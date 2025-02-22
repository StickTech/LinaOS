// SPDX-License-Identifier: GPL-2.0
/*
 * Architecture-specific ACPI-based support for suspend-to-idle.
 *
 * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 * Author: Srinivas Pandruvada <srinivas.pandruvada@linaos.intel.com>
 * Author: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
 *
 * On platforms supporting the Low Power S0 Idle interface there is an ACPI
 * device object with the PNP0D80 compatible device ID (System Power Management
 * Controller) and a specific _DSM method under it.  That method, if present,
 * can be used to indicate to the platform that the OS is transitioning into a
 * low-power state in which certain types of activity are not desirable or that
 * it is leaving such a state, which allows the platform to adjust its operation
 * mode accordingly.
 */

#include <linaos/acpi.h>
#include <linaos/device.h>
#include <linaos/suspend.h>

#include "../sleep.h"

#ifdef CONFIG_SUSPEND

static bool sleep_no_lps0 __read_mostly;
module_param(sleep_no_lps0, bool, 0644);
MODULE_PARM_DESC(sleep_no_lps0, "Do not use the special LPS0 device interface");

static const struct acpi_device_id lps0_device_ids[] = {
	{"PNP0D80", },
	{"", },
};

#define ACPI_LPS0_DSM_UUID	"c4eb40a0-6cd2-11e2-bcfd-0800200c9a66"

#define ACPI_LPS0_GET_DEVICE_CONSTRAINTS	1
#define ACPI_LPS0_SCREEN_OFF	3
#define ACPI_LPS0_SCREEN_ON	4
#define ACPI_LPS0_ENTRY		5
#define ACPI_LPS0_EXIT		6

/* AMD */
#define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
#define ACPI_LPS0_SCREEN_OFF_AMD    4
#define ACPI_LPS0_SCREEN_ON_AMD     5

static acpi_handle lps0_device_handle;
static guid_t lps0_dsm_guid;
static char lps0_dsm_func_mask;

/* Device constraint entry structure */
struct lpi_device_info {
	char *name;
	int enabled;
	union acpi_object *package;
};

/* Constraint package structure */
struct lpi_device_constraint {
	int uid;
	int min_dstate;
	int function_states;
};

struct lpi_constraints {
	acpi_handle handle;
	int min_dstate;
};

/* AMD */
/* Device constraint entry structure */
struct lpi_device_info_amd {
	int revision;
	int count;
	union acpi_object *package;
};

/* Constraint package structure */
struct lpi_device_constraint_amd {
	char *name;
	int enabled;
	int function_states;
	int min_dstate;
};

static struct lpi_constraints *lpi_constraints_table;
static int lpi_constraints_table_size;
static int rev_id;

static void lpi_device_get_constraints_amd(void)
{
	union acpi_object *out_obj;
	int i, j, k;

	out_obj = acpi_evaluate_dsm_typed(lps0_device_handle, &lps0_dsm_guid,
					  1, ACPI_LPS0_GET_DEVICE_CONSTRAINTS,
					  NULL, ACPI_TYPE_PACKAGE);

	if (!out_obj)
		return;

	acpi_handle_debug(lps0_device_handle, "_DSM function 1 eval %s\n",
			  out_obj ? "successful" : "failed");

	for (i = 0; i < out_obj->package.count; i++) {
		union acpi_object *package = &out_obj->package.elements[i];

		if (package->type == ACPI_TYPE_PACKAGE) {
			lpi_constraints_table = kcalloc(package->package.count,
							sizeof(*lpi_constraints_table),
							GFP_KERNEL);

			if (!lpi_constraints_table)
				goto free_acpi_buffer;

			acpi_handle_debug(lps0_device_handle,
					  "LPI: constraints list begin:\n");

			for (j = 0; j < package->package.count; ++j) {
				union acpi_object *info_obj = &package->package.elements[j];
				struct lpi_device_constraint_amd dev_info = {};
				struct lpi_constraints *list;
				acpi_status status;

				for (k = 0; k < info_obj->package.count; ++k) {
					union acpi_object *obj = &info_obj->package.elements[k];

					list = &lpi_constraints_table[lpi_constraints_table_size];
					list->min_dstate = -1;

					switch (k) {
					case 0:
						dev_info.enabled = obj->integer.value;
						break;
					case 1:
						dev_info.name = obj->string.pointer;
						break;
					case 2:
						dev_info.function_states = obj->integer.value;
						break;
					case 3:
						dev_info.min_dstate = obj->integer.value;
						break;
					}

					if (!dev_info.enabled || !dev_info.name ||
					    !dev_info.min_dstate)
						continue;

					status = acpi_get_handle(NULL, dev_info.name,
								 &list->handle);
					if (ACPI_FAILURE(status))
						continue;

					acpi_handle_debug(lps0_device_handle,
							  "Name:%s\n", dev_info.name);

					list->min_dstate = dev_info.min_dstate;

					if (list->min_dstate < 0) {
						acpi_handle_debug(lps0_device_handle,
								  "Incomplete constraint defined\n");
						continue;
					}
				}
				lpi_constraints_table_size++;
			}
		}
	}

	acpi_handle_debug(lps0_device_handle, "LPI: constraints list end\n");

free_acpi_buffer:
	ACPI_FREE(out_obj);
}

static void lpi_device_get_constraints(void)
{
	union acpi_object *out_obj;
	int i;

	out_obj = acpi_evaluate_dsm_typed(lps0_device_handle, &lps0_dsm_guid,
					  1, ACPI_LPS0_GET_DEVICE_CONSTRAINTS,
					  NULL, ACPI_TYPE_PACKAGE);

	acpi_handle_debug(lps0_device_handle, "_DSM function 1 eval %s\n",
			  out_obj ? "successful" : "failed");

	if (!out_obj)
		return;

	lpi_constraints_table = kcalloc(out_obj->package.count,
					sizeof(*lpi_constraints_table),
					GFP_KERNEL);
	if (!lpi_constraints_table)
		goto free_acpi_buffer;

	acpi_handle_debug(lps0_device_handle, "LPI: constraints list begin:\n");

	for (i = 0; i < out_obj->package.count; i++) {
		struct lpi_constraints *constraint;
		acpi_status status;
		union acpi_object *package = &out_obj->package.elements[i];
		struct lpi_device_info info = { };
		int package_count = 0, j;

		if (!package)
			continue;

		for (j = 0; j < package->package.count; ++j) {
			union acpi_object *element =
					&(package->package.elements[j]);

			switch (element->type) {
			case ACPI_TYPE_INTEGER:
				info.enabled = element->integer.value;
				break;
			case ACPI_TYPE_STRING:
				info.name = element->string.pointer;
				break;
			case ACPI_TYPE_PACKAGE:
				package_count = element->package.count;
				info.package = element->package.elements;
				break;
			}
		}

		if (!info.enabled || !info.package || !info.name)
			continue;

		constraint = &lpi_constraints_table[lpi_constraints_table_size];

		status = acpi_get_handle(NULL, info.name, &constraint->handle);
		if (ACPI_FAILURE(status))
			continue;

		acpi_handle_debug(lps0_device_handle,
				  "index:%d Name:%s\n", i, info.name);

		constraint->min_dstate = -1;

		for (j = 0; j < package_count; ++j) {
			union acpi_object *info_obj = &info.package[j];
			union acpi_object *cnstr_pkg;
			union acpi_object *obj;
			struct lpi_device_constraint dev_info;

			switch (info_obj->type) {
			case ACPI_TYPE_INTEGER:
				/* version */
				break;
			case ACPI_TYPE_PACKAGE:
				if (info_obj->package.count < 2)
					break;

				cnstr_pkg = info_obj->package.elements;
				obj = &cnstr_pkg[0];
				dev_info.uid = obj->integer.value;
				obj = &cnstr_pkg[1];
				dev_info.min_dstate = obj->integer.value;

				acpi_handle_debug(lps0_device_handle,
					"uid:%d min_dstate:%s\n",
					dev_info.uid,
					acpi_power_state_string(dev_info.min_dstate));

				constraint->min_dstate = dev_info.min_dstate;
				break;
			}
		}

		if (constraint->min_dstate < 0) {
			acpi_handle_debug(lps0_device_handle,
					  "Incomplete constraint defined\n");
			continue;
		}

		lpi_constraints_table_size++;
	}

	acpi_handle_debug(lps0_device_handle, "LPI: constraints list end\n");

free_acpi_buffer:
	ACPI_FREE(out_obj);
}

static void lpi_check_constraints(void)
{
	int i;

	for (i = 0; i < lpi_constraints_table_size; ++i) {
		acpi_handle handle = lpi_constraints_table[i].handle;
		struct acpi_device *adev;

		if (!handle || acpi_bus_get_device(handle, &adev))
			continue;

		acpi_handle_debug(handle,
			"LPI: required min power state:%s current power state:%s\n",
			acpi_power_state_string(lpi_constraints_table[i].min_dstate),
			acpi_power_state_string(adev->power.state));

		if (!adev->flags.power_manageable) {
			acpi_handle_info(handle, "LPI: Device not power manageable\n");
			lpi_constraints_table[i].handle = NULL;
			continue;
		}

		if (adev->power.state < lpi_constraints_table[i].min_dstate)
			acpi_handle_info(handle,
				"LPI: Constraint not met; min power state:%s current power state:%s\n",
				acpi_power_state_string(lpi_constraints_table[i].min_dstate),
				acpi_power_state_string(adev->power.state));
	}
}

static void acpi_sleep_run_lps0_dsm(unsigned int func)
{
	union acpi_object *out_obj;

	if (!(lps0_dsm_func_mask & (1 << func)))
		return;

	out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, rev_id, func, NULL);
	ACPI_FREE(out_obj);

	acpi_handle_debug(lps0_device_handle, "_DSM function %u evaluation %s\n",
			  func, out_obj ? "successful" : "failed");
}

static bool acpi_s2idle_vendor_amd(void)
{
	return boot_cpu_data.x86_vendor == X86_VENDOR_AMD;
}

static int lps0_device_attach(struct acpi_device *adev,
			      const struct acpi_device_id *not_used)
{
	union acpi_object *out_obj;

	if (lps0_device_handle)
		return 0;

	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
		return 0;

	if (acpi_s2idle_vendor_amd()) {
		guid_parse(ACPI_LPS0_DSM_UUID_AMD, &lps0_dsm_guid);
		out_obj = acpi_evaluate_dsm(adev->handle, &lps0_dsm_guid, 0, 0, NULL);
		rev_id = 0;
	} else {
		guid_parse(ACPI_LPS0_DSM_UUID, &lps0_dsm_guid);
		out_obj = acpi_evaluate_dsm(adev->handle, &lps0_dsm_guid, 1, 0, NULL);
		rev_id = 1;
	}

	/* Check if the _DSM is present and as expected. */
	if (!out_obj || out_obj->type != ACPI_TYPE_BUFFER) {
		acpi_handle_debug(adev->handle,
				  "_DSM function 0 evaluation failed\n");
		return 0;
	}

	lps0_dsm_func_mask = *(char *)out_obj->buffer.pointer;

	ACPI_FREE(out_obj);

	acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
			  lps0_dsm_func_mask);

	lps0_device_handle = adev->handle;

	if (acpi_s2idle_vendor_amd())
		lpi_device_get_constraints_amd();
	else
		lpi_device_get_constraints();

	/*
	 * Use suspend-to-idle by default if the default suspend mode was not
	 * set from the command line.
	 */
	if (mem_sleep_default > PM_SUSPEND_MEM && !acpi_sleep_default_s3)
		mem_sleep_current = PM_SUSPEND_TO_IDLE;

	/*
	 * Some LPS0 systems, like ASUS Zenbook UX430UNR/i7-8550U, require the
	 * EC GPE to be enabled while suspended for certain wakeup devices to
	 * work, so mark it as wakeup-capable.
	 */
	acpi_ec_mark_gpe_for_wake();

	return 0;
}

static struct acpi_scan_handler lps0_handler = {
	.ids = lps0_device_ids,
	.attach = lps0_device_attach,
};

int acpi_s2idle_prepare_late(void)
{
	if (!lps0_device_handle || sleep_no_lps0)
		return 0;

	if (pm_debug_messages_on)
		lpi_check_constraints();

	if (acpi_s2idle_vendor_amd()) {
		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD);
	} else {
		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
	}

	return 0;
}

void acpi_s2idle_restore_early(void)
{
	if (!lps0_device_handle || sleep_no_lps0)
		return;

	if (acpi_s2idle_vendor_amd()) {
		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD);
	} else {
		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
	}
}

static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
	.begin = acpi_s2idle_begin,
	.prepare = acpi_s2idle_prepare,
	.prepare_late = acpi_s2idle_prepare_late,
	.wake = acpi_s2idle_wake,
	.restore_early = acpi_s2idle_restore_early,
	.restore = acpi_s2idle_restore,
	.end = acpi_s2idle_end,
};

void acpi_s2idle_setup(void)
{
	acpi_scan_add_handler(&lps0_handler);
	s2idle_set_ops(&acpi_s2idle_ops_lps0);
}

#endif /* CONFIG_SUSPEND */
