/*
 * linaos/fs/nls/nls_cp874.c
 *
 * Charset cp874 translation tables.
 * Generated automatically from the Unicode and charset
 * tables from the Unicode Organization (www.unicode.org).
 * The Unicode to charset table has only exact mappings.
 */

#include <linaos/module.h>
#include <linaos/kernel.h>
#include <linaos/string.h>
#include <linaos/nls.h>
#include <linaos/errno.h>

static const wchar_t charset2uni[256] = {
	/* 0x00*/
	0x0000, 0x0001, 0x0002, 0x0003,
	0x0004, 0x0005, 0x0006, 0x0007,
	0x0008, 0x0009, 0x000a, 0x000b,
	0x000c, 0x000d, 0x000e, 0x000f,
	/* 0x10*/
	0x0010, 0x0011, 0x0012, 0x0013,
	0x0014, 0x0015, 0x0016, 0x0017,
	0x0018, 0x0019, 0x001a, 0x001b,
	0x001c, 0x001d, 0x001e, 0x001f,
	/* 0x20*/
	0x0020, 0x0021, 0x0022, 0x0023,
	0x0024, 0x0025, 0x0026, 0x0027,
	0x0028, 0x0029, 0x002a, 0x002b,
	0x002c, 0x002d, 0x002e, 0x002f,
	/* 0x30*/
	0x0030, 0x0031, 0x0032, 0x0033,
	0x0034, 0x0035, 0x0036, 0x0037,
	0x0038, 0x0039, 0x003a, 0x003b,
	0x003c, 0x003d, 0x003e, 0x003f,
	/* 0x40*/
	0x0040, 0x0041, 0x0042, 0x0043,
	0x0044, 0x0045, 0x0046, 0x0047,
	0x0048, 0x0049, 0x004a, 0x004b,
	0x004c, 0x004d, 0x004e, 0x004f,
	/* 0x50*/
	0x0050, 0x0051, 0x0052, 0x0053,
	0x0054, 0x0055, 0x0056, 0x0057,
	0x0058, 0x0059, 0x005a, 0x005b,
	0x005c, 0x005d, 0x005e, 0x005f,
	/* 0x60*/
	0x0060, 0x0061, 0x0062, 0x0063,
	0x0064, 0x0065, 0x0066, 0x0067,
	0x0068, 0x0069, 0x006a, 0x006b,
	0x006c, 0x006d, 0x006e, 0x006f,
	/* 0x70*/
	0x0070, 0x0071, 0x0072, 0x0073,
	0x0074, 0x0075, 0x0076, 0x0077,
	0x0078, 0x0079, 0x007a, 0x007b,
	0x007c, 0x007d, 0x007e, 0x007f,
	/* 0x80*/
	0x0000, 0x0000, 0x0000, 0x0000,
	0x0000, 0x2026, 0x0000, 0x0000,
	0x0000, 0x0000, 0x0000, 0x0000,
	0x0000, 0x0000, 0x0000, 0x0000,
	/* 0x90*/
	0x0000, 0x2018, 0x2019, 0x201c,
	0x201d, 0x2022, 0x2013, 0x2014,
	0x0000, 0x0000, 0x0000, 0x0000,
	0x0000, 0x0000, 0x0000, 0x0000,
	/* 0xa0*/
	0x00a0, 0x0e01, 0x0e02, 0x0e03,
	0x0e04, 0x0e05, 0x0e06, 0x0e07,
	0x0e08, 0x0e09, 0x0e0a, 0x0e0b,
	0x0e0c, 0x0e0d, 0x0e0e, 0x0e0f,
	/* 0xb0*/
	0x0e10, 0x0e11, 0x0e12, 0x0e13,
	0x0e14, 0x0e15, 0x0e16, 0x0e17,
	0x0e18, 0x0e19, 0x0e1a, 0x0e1b,
	0x0e1c, 0x0e1d, 0x0e1e, 0x0e1f,
	/* 0xc0*/
	0x0e20, 0x0e21, 0x0e22, 0x0e23,
	0x0e24, 0x0e25, 0x0e26, 0x0e27,
	0x0e28, 0x0e29, 0x0e2a, 0x0e2b,
	0x0e2c, 0x0e2d, 0x0e2e, 0x0e2f,
	/* 0xd0*/
	0x0e30, 0x0e31, 0x0e32, 0x0e33,
	0x0e34, 0x0e35, 0x0e36, 0x0e37,
	0x0e38, 0x0e39, 0x0e3a, 0x0000,
	0x0000, 0x0000, 0x0000, 0x0e3f,
	/* 0xe0*/
	0x0e40, 0x0e41, 0x0e42, 0x0e43,
	0x0e44, 0x0e45, 0x0e46, 0x0e47,
	0x0e48, 0x0e49, 0x0e4a, 0x0e4b,
	0x0e4c, 0x0e4d, 0x0e4e, 0x0e4f,
	/* 0xf0*/
	0x0e50, 0x0e51, 0x0e52, 0x0e53,
	0x0e54, 0x0e55, 0x0e56, 0x0e57,
	0x0e58, 0x0e59, 0x0e5a, 0x0e5b,
	0x0000, 0x0000, 0x0000, 0x0000,
};

static const unsigned char page00[256] = {
	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, /* 0x00-0x07 */
	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, /* 0x08-0x0f */
	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, /* 0x10-0x17 */
	0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, /* 0x18-0x1f */
	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, /* 0x20-0x27 */
	0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, /* 0x28-0x2f */
	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, /* 0x30-0x37 */
	0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, /* 0x38-0x3f */
	0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, /* 0x40-0x47 */
	0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, /* 0x48-0x4f */
	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, /* 0x50-0x57 */
	0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, /* 0x58-0x5f */
	0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, /* 0x60-0x67 */
	0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, /* 0x68-0x6f */
	0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, /* 0x70-0x77 */
	0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f, /* 0x78-0x7f */

	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x80-0x87 */
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x88-0x8f */
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x90-0x97 */
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x98-0x9f */
	0xa0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0xa0-0xa7 */
};

static const unsigned char page0e[256] = {
	0x00, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, /* 0x00-0x07 */
	0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf, /* 0x08-0x0f */
	0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7, /* 0x10-0x17 */
	0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf, /* 0x18-0x1f */
	0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7, /* 0x20-0x27 */
	0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf, /* 0x28-0x2f */
	0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7, /* 0x30-0x37 */
	0xd8, 0xd9, 0xda, 0x00, 0x00, 0x00, 0x00, 0xdf, /* 0x38-0x3f */
	0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7, /* 0x40-0x47 */
	0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef, /* 0x48-0x4f */
	0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, /* 0x50-0x57 */
	0xf8, 0xf9, 0xfa, 0xfb, 0x00, 0x00, 0x00, 0x00, /* 0x58-0x5f */
};

static const unsigned char page20[256] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x00-0x07 */
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x08-0x0f */
	0x00, 0x00, 0x00, 0x96, 0x97, 0x00, 0x00, 0x00, /* 0x10-0x17 */
	0x91, 0x92, 0x00, 0x00, 0x93, 0x94, 0x00, 0x00, /* 0x18-0x1f */
	0x00, 0x00, 0x95, 0x00, 0x00, 0x00, 0x85, 0x00, /* 0x20-0x27 */
};

static const unsigned char *const page_uni2charset[256] = {
	page00, NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   
	NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   page0e, NULL,   
	NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   
	NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   
	page20, NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   
};

static const unsigned char charset2lower[256] = {
	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, /* 0x00-0x07 */
	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, /* 0x08-0x0f */
	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, /* 0x10-0x17 */
	0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, /* 0x18-0x1f */
	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, /* 0x20-0x27 */
	0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, /* 0x28-0x2f */
	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, /* 0x30-0x37 */
	0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, /* 0x38-0x3f */
	0x40, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, /* 0x40-0x47 */
	0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, /* 0x48-0x4f */
	0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, /* 0x50-0x57 */
	0x78, 0x79, 0x7a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, /* 0x58-0x5f */
	0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, /* 0x60-0x67 */
	0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, /* 0x68-0x6f */
	0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, /* 0x70-0x77 */
	0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f, /* 0x78-0x7f */

	0x00, 0x00, 0x00, 0x00, 0x00, 0x85, 0x00, 0x00, /* 0x80-0x87 */
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x88-0x8f */
	0x00, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, /* 0x90-0x97 */
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x98-0x9f */
	0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, /* 0xa0-0xa7 */
	0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf, /* 0xa8-0xaf */
	0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7, /* 0xb0-0xb7 */
	0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf, /* 0xb8-0xbf */
	0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7, /* 0xc0-0xc7 */
	0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf, /* 0xc8-0xcf */
	0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7, /* 0xd0-0xd7 */
	0xd8, 0xd9, 0xda, 0x00, 0x00, 0x00, 0x00, 0xdf, /* 0xd8-0xdf */
	0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7, /* 0xe0-0xe7 */
	0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef, /* 0xe8-0xef */
	0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, /* 0xf0-0xf7 */
	0xf8, 0xf9, 0xfa, 0xfb, 0x00, 0x00, 0x00, 0x00, /* 0xf8-0xff */
};

static const unsigned char charset2upper[256] = {
	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, /* 0x00-0x07 */
	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, /* 0x08-0x0f */
	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, /* 0x10-0x17 */
	0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, /* 0x18-0x1f */
	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, /* 0x20-0x27 */
	0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, /* 0x28-0x2f */
	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, /* 0x30-0x37 */
	0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, /* 0x38-0x3f */
	0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, /* 0x40-0x47 */
	0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, /* 0x48-0x4f */
	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, /* 0x50-0x57 */
	0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, /* 0x58-0x5f */
	0x60, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, /* 0x60-0x67 */
	0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, /* 0x68-0x6f */
	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, /* 0x70-0x77 */
	0x58, 0x59, 0x5a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f, /* 0x78-0x7f */

	0x00, 0x00, 0x00, 0x00, 0x00, 0x85, 0x00, 0x00, /* 0x80-0x87 */
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x88-0x8f */
	0x00, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, /* 0x90-0x97 */
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x98-0x9f */
	0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, /* 0xa0-0xa7 */
	0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf, /* 0xa8-0xaf */
	0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7, /* 0xb0-0xb7 */
	0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf, /* 0xb8-0xbf */
	0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7, /* 0xc0-0xc7 */
	0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf, /* 0xc8-0xcf */
	0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7, /* 0xd0-0xd7 */
	0xd8, 0xd9, 0xda, 0x00, 0x00, 0x00, 0x00, 0xdf, /* 0xd8-0xdf */
	0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7, /* 0xe0-0xe7 */
	0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef, /* 0xe8-0xef */
	0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, /* 0xf0-0xf7 */
	0xf8, 0xf9, 0xfa, 0xfb, 0x00, 0x00, 0x00, 0x00, /* 0xf8-0xff */
};

static int uni2char(wchar_t uni, unsigned char *out, int boundlen)
{
	const unsigned char *uni2charset;
	unsigned char cl = uni & 0x00ff;
	unsigned char ch = (uni & 0xff00) >> 8;

	if (boundlen <= 0)
		return -ENAMETOOLONG;

	uni2charset = page_uni2charset[ch];
	if (uni2charset && uni2charset[cl])
		out[0] = uni2charset[cl];
	else
		return -EINVAL;
	return 1;
}

static int char2uni(const unsigned char *rawstring, int boundlen, wchar_t *uni)
{
	*uni = charset2uni[*rawstring];
	if (*uni == 0x0000)
		return -EINVAL;
	return 1;
}

static struct nls_table table = {
	.charset	= "cp874",
	.alias		= "tis-620",
	.uni2char	= uni2char,
	.char2uni	= char2uni,
	.charset2lower	= charset2lower,
	.charset2upper	= charset2upper,
};

static int __init init_nls_cp874(void)
{
	return register_nls(&table);
}

static void __exit exit_nls_cp874(void)
{
	unregister_nls(&table);
}

module_init(init_nls_cp874)
module_exit(exit_nls_cp874)

MODULE_LICENSE("Dual BSD/GPL");
MODULE_ALIAS_NLS(tis-620);
