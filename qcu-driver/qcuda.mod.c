#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

MODULE_INFO(vermagic, VERMAGIC_STRING);

__visible struct module __this_module
__attribute__((section(".gnu.linkonce.this_module"))) = {
	.name = KBUILD_MODNAME,
	.init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
	.exit = cleanup_module,
#endif
	.arch = MODULE_ARCH_INIT,
};

static const struct modversion_info ____versions[]
__used
__attribute__((section("__versions"))) = {
	{ 0x485a10ed, __VMLINUX_SYMBOL_STR(module_layout) },
	{ 0xb889815d, __VMLINUX_SYMBOL_STR(kmalloc_caches) },
	{ 0xd2b09ce5, __VMLINUX_SYMBOL_STR(__kmalloc) },
	{ 0x1fdc7df2, __VMLINUX_SYMBOL_STR(_mcount) },
	{ 0x17a142df, __VMLINUX_SYMBOL_STR(__copy_from_user) },
	{ 0x98082893, __VMLINUX_SYMBOL_STR(__copy_to_user) },
	{ 0xd4e8143e, __VMLINUX_SYMBOL_STR(virtqueue_kick) },
	{ 0x9c850759, __VMLINUX_SYMBOL_STR(virtqueue_get_buf) },
	{ 0x902f7301, __VMLINUX_SYMBOL_STR(misc_register) },
	{ 0xdcb764ad, __VMLINUX_SYMBOL_STR(memset) },
	{ 0x6f9040f8, __VMLINUX_SYMBOL_STR(virtqueue_add_sgs) },
	{ 0x27e1a049, __VMLINUX_SYMBOL_STR(printk) },
	{ 0x7c1372e8, __VMLINUX_SYMBOL_STR(panic) },
	{ 0xf8e398fc, __VMLINUX_SYMBOL_STR(memstart_addr) },
	{ 0xe3a53f4c, __VMLINUX_SYMBOL_STR(sort) },
	{ 0xa52ba1b9, __VMLINUX_SYMBOL_STR(module_put) },
	{ 0x280b5449, __VMLINUX_SYMBOL_STR(unregister_virtio_driver) },
	{ 0x93fca811, __VMLINUX_SYMBOL_STR(__get_free_pages) },
	{ 0x3d014c0b, __VMLINUX_SYMBOL_STR(kmem_cache_alloc_trace) },
	{ 0x5cd885d5, __VMLINUX_SYMBOL_STR(_raw_spin_lock) },
	{ 0x4302d0eb, __VMLINUX_SYMBOL_STR(free_pages) },
	{ 0xb6244511, __VMLINUX_SYMBOL_STR(sg_init_one) },
	{ 0x37a0cba, __VMLINUX_SYMBOL_STR(kfree) },
	{ 0x4ed8db13, __VMLINUX_SYMBOL_STR(remap_pfn_range) },
	{ 0x91bf97ef, __VMLINUX_SYMBOL_STR(virtqueue_is_broken) },
	{ 0xd85198bd, __VMLINUX_SYMBOL_STR(misc_deregister) },
	{ 0x7955e733, __VMLINUX_SYMBOL_STR(try_module_get) },
	{ 0x616e14d7, __VMLINUX_SYMBOL_STR(register_virtio_driver) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";

MODULE_ALIAS("virtio:d00000045v*");

MODULE_INFO(srcversion, "D37B0491010B70362E3F08E");
