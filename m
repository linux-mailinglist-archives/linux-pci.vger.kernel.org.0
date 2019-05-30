Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7C030015
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 18:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfE3QTD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 May 2019 12:19:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:20310 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfE3QTD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 May 2019 12:19:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 09:18:53 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 May 2019 09:18:51 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hWNlS-000J3D-VI; Fri, 31 May 2019 00:18:50 +0800
Date:   Fri, 31 May 2019 00:17:54 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     kbuild-all@01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [pci:pci/docs 2/12] htmldocs: include/linux/pci.h:831: warning:
 Function parameter or member 'node' not described in 'pci_driver'
Message-ID: <201905310045.I2hsmQif%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/docs
head:   5b76337ac1d54eb1c82414f17e29883290ce87de
commit: fe6cdee86aeb83ee6ed2dc98928fb9fefc138612 [2/12] Documentation: PCI: convert pci.txt to reST
reproduce: make htmldocs

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   include/linux/pci.h:158: warning: cannot understand function prototype: 'typedef unsigned int __bitwise pci_channel_state_t; '
>> include/linux/pci.h:831: warning: Function parameter or member 'node' not described in 'pci_driver'
>> include/linux/pci.h:831: warning: Function parameter or member 'name' not described in 'pci_driver'
>> include/linux/pci.h:831: warning: Function parameter or member 'sriov_configure' not described in 'pci_driver'
>> include/linux/pci.h:831: warning: Function parameter or member 'groups' not described in 'pci_driver'
>> include/linux/pci.h:831: warning: Function parameter or member 'driver' not described in 'pci_driver'
>> include/linux/pci.h:831: warning: Function parameter or member 'dynids' not described in 'pci_driver'
   include/linux/pci.h:2251: warning: Excess function parameter 'lrdt' description in 'pci_vpd_info_field_size'
   include/linux/generic-radix-tree.h:1: warning: no structured comments found
   lib/sort.c:59: warning: Excess function parameter 'size' description in 'swap_words_32'
   lib/sort.c:83: warning: Excess function parameter 'size' description in 'swap_words_64'
   lib/sort.c:110: warning: Excess function parameter 'size' description in 'swap_bytes'
   block/genhd.c:540: warning: Function parameter or member 'devt' not described in 'blk_invalidate_devt'
   kernel/rcu/tree_plugin.h:1: warning: no structured comments found
   include/net/cfg80211.h:1074: warning: Function parameter or member 'txpwr' not described in 'station_parameters'
   include/net/mac80211.h:4037: warning: Function parameter or member 'sta_set_txpwr' not described in 'ieee80211_ops'
   include/net/mac80211.h:2004: warning: Function parameter or member 'txpwr' not described in 'ieee80211_sta'
   kernel/rcu/tree_plugin.h:1: warning: no structured comments found
   include/linux/firmware/intel/stratix10-svc-client.h:1: warning: no structured comments found
   Error: Cannot open file drivers/counter/generic-counter.c
   Error: Cannot open file drivers/counter/generic-counter.c
   WARNING: kernel-doc 'scripts/kernel-doc -rst -enable-lineno -export drivers/counter/generic-counter.c' failed with return code 2
   include/linux/gpio/driver.h:374: warning: Function parameter or member 'init_valid_mask' not described in 'gpio_chip'
   include/linux/i2c.h:343: warning: Function parameter or member 'init_irq' not described in 'i2c_client'
   include/linux/iio/hw-consumer.h:1: warning: no structured comments found
   drivers/base/node.c:78: warning: Function parameter or member 'hmem_attrs' not described in 'node_access_nodes'
   drivers/base/node.c:690: warning: Function parameter or member 'mem_nid' not described in 'register_memory_node_under_compute_node'
   drivers/base/node.c:690: warning: Function parameter or member 'cpu_nid' not described in 'register_memory_node_under_compute_node'
   drivers/base/node.c:690: warning: Excess function parameter 'mem_node' description in 'register_memory_node_under_compute_node'
   drivers/base/node.c:690: warning: Excess function parameter 'cpu_node' description in 'register_memory_node_under_compute_node'
   include/linux/input/sparse-keymap.h:46: warning: Function parameter or member 'sw' not described in 'key_entry'
   include/linux/regulator/machine.h:199: warning: Function parameter or member 'max_uV_step' not described in 'regulation_constraints'
   include/linux/regulator/driver.h:228: warning: Function parameter or member 'resume' not described in 'regulator_ops'
   drivers/slimbus/stream.c:1: warning: no structured comments found
   include/linux/spi/spi.h:188: warning: Function parameter or member 'driver_override' not described in 'spi_device'
   drivers/target/target_core_device.c:1: warning: no structured comments found
   drivers/usb/typec/bus.c:1: warning: no structured comments found
   drivers/usb/typec/class.c:1: warning: no structured comments found
   include/linux/w1.h:281: warning: Function parameter or member 'of_match_table' not described in 'w1_family'
   fs/direct-io.c:257: warning: Excess function parameter 'offset' description in 'dio_complete'
   fs/file_table.c:1: warning: no structured comments found
   fs/libfs.c:479: warning: Excess function parameter 'available' description in 'simple_write_end'
   fs/posix_acl.c:646: warning: Function parameter or member 'inode' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:646: warning: Function parameter or member 'mode_p' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:646: warning: Function parameter or member 'acl' not described in 'posix_acl_update_mode'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:294: warning: Excess function parameter 'mm' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:294: warning: Excess function parameter 'start' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:294: warning: Excess function parameter 'end' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:343: warning: Excess function parameter 'mm' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:343: warning: Excess function parameter 'start' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:343: warning: Excess function parameter 'end' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:183: warning: Function parameter or member 'blockable' not described in 'amdgpu_mn_read_lock'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:295: warning: Function parameter or member 'range' not described in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:295: warning: Excess function parameter 'mm' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:295: warning: Excess function parameter 'start' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:295: warning: Excess function parameter 'end' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:344: warning: Function parameter or member 'range' not described in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:344: warning: Excess function parameter 'mm' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:344: warning: Excess function parameter 'start' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:344: warning: Excess function parameter 'end' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:347: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:348: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:494: warning: Function parameter or member 'start' not described in 'amdgpu_vm_pt_first_dfs'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'adev' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'vm' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'start' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'cursor' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'entry' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:823: warning: Function parameter or member 'level' not described in 'amdgpu_vm_bo_param'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'params' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'bo' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'level' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'pe' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'addr' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'count' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'incr' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'flags' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2812: warning: Function parameter or member 'pasid' not described in 'amdgpu_vm_make_compute'
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:375: warning: Excess function parameter 'entry' description in 'amdgpu_irq_dispatch'
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:376: warning: Function parameter or member 'ih' not described in 'amdgpu_irq_dispatch'
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:376: warning: Excess function parameter 'entry' description in 'amdgpu_irq_dispatch'
   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c:1: warning: no structured comments found
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:128: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source @atomic_obj
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:210: warning: Function parameter or member 'atomic_obj' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:210: warning: Function parameter or member 'backlight_link' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:210: warning: Function parameter or member 'backlight_caps' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:210: warning: Function parameter or member 'freesync_module' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:210: warning: Function parameter or member 'fw_dmcu' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:210: warning: Function parameter or member 'dmcu_fw_version' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1: warning: no structured comments found
   include/drm/drm_drv.h:722: warning: Function parameter or member 'gem_prime_pin' not described in 'drm_driver'
   include/drm/drm_drv.h:722: warning: Function parameter or member 'gem_prime_unpin' not described in 'drm_driver'
   include/drm/drm_drv.h:722: warning: Function parameter or member 'gem_prime_res_obj' not described in 'drm_driver'
   include/drm/drm_drv.h:722: warning: Function parameter or member 'gem_prime_get_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:722: warning: Function parameter or member 'gem_prime_import_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:722: warning: Function parameter or member 'gem_prime_vmap' not described in 'drm_driver'
   include/drm/drm_drv.h:722: warning: Function parameter or member 'gem_prime_vunmap' not described in 'drm_driver'
   include/drm/drm_drv.h:722: warning: Function parameter or member 'gem_prime_mmap' not described in 'drm_driver'
   include/drm/drm_modeset_helper_vtables.h:1004: warning: Function parameter or member 'prepare_writeback_job' not described in 'drm_connector_helper_funcs'
   include/drm/drm_modeset_helper_vtables.h:1004: warning: Function parameter or member 'cleanup_writeback_job' not described in 'drm_connector_helper_funcs'
   include/drm/drm_atomic_state_helper.h:1: warning: no structured comments found
   drivers/gpu/drm/scheduler/sched_main.c:419: warning: Function parameter or member 'full_recovery' not described in 'drm_sched_start'
   drivers/gpu/drm/i915/i915_vma.h:50: warning: cannot understand function prototype: 'struct i915_vma '
   drivers/gpu/drm/i915/i915_vma.h:1: warning: no structured comments found
   drivers/gpu/drm/i915/intel_guc_fwif.h:536: warning: cannot understand function prototype: 'struct guc_log_buffer_state '
   drivers/gpu/drm/i915/i915_trace.h:1: warning: no structured comments found
   drivers/gpu/drm/i915/i915_reg.h:156: warning: bad line:

vim +831 include/linux/pci.h

fe6cdee8 Changbin Du        2019-05-14  778  
fe6cdee8 Changbin Du        2019-05-14  779  /**
fe6cdee8 Changbin Du        2019-05-14  780   * struct pci_driver - PCI driver structure
fe6cdee8 Changbin Du        2019-05-14  781   * @id_table:	Pointer to table of device IDs the driver is
fe6cdee8 Changbin Du        2019-05-14  782   *		interested in.  Most drivers should export this
fe6cdee8 Changbin Du        2019-05-14  783   *		table using MODULE_DEVICE_TABLE(pci,...).
fe6cdee8 Changbin Du        2019-05-14  784   * @probe:	This probing function gets called (during execution
fe6cdee8 Changbin Du        2019-05-14  785   *		of pci_register_driver() for already existing
fe6cdee8 Changbin Du        2019-05-14  786   *		devices or later if a new device gets inserted) for
fe6cdee8 Changbin Du        2019-05-14  787   *		all PCI devices which match the ID table and are not
fe6cdee8 Changbin Du        2019-05-14  788   *		"owned" by the other drivers yet. This function gets
fe6cdee8 Changbin Du        2019-05-14  789   *		passed a "struct pci_dev *" for each device whose
fe6cdee8 Changbin Du        2019-05-14  790   *		entry in the ID table matches the device. The probe
fe6cdee8 Changbin Du        2019-05-14  791   *		function returns zero when the driver chooses to
fe6cdee8 Changbin Du        2019-05-14  792   *		take "ownership" of the device or an error code
fe6cdee8 Changbin Du        2019-05-14  793   *		(negative number) otherwise.
fe6cdee8 Changbin Du        2019-05-14  794   *		The probe function always gets called from process
fe6cdee8 Changbin Du        2019-05-14  795   *		context, so it can sleep.
fe6cdee8 Changbin Du        2019-05-14  796   * @remove:	The remove() function gets called whenever a device
fe6cdee8 Changbin Du        2019-05-14  797   *		being handled by this driver is removed (either during
fe6cdee8 Changbin Du        2019-05-14  798   *		deregistration of the driver or when it's manually
fe6cdee8 Changbin Du        2019-05-14  799   *		pulled out of a hot-pluggable slot).
fe6cdee8 Changbin Du        2019-05-14  800   *		The remove function always gets called from process
fe6cdee8 Changbin Du        2019-05-14  801   *		context, so it can sleep.
fe6cdee8 Changbin Du        2019-05-14  802   * @suspend:	Put device into low power state.
fe6cdee8 Changbin Du        2019-05-14  803   * @suspend_late: Put device into low power state.
fe6cdee8 Changbin Du        2019-05-14  804   * @resume_early: Wake device from low power state.
fe6cdee8 Changbin Du        2019-05-14  805   * @resume:	Wake device from low power state.
fe6cdee8 Changbin Du        2019-05-14  806   *		(Please see Documentation/power/pci.txt for descriptions
fe6cdee8 Changbin Du        2019-05-14  807   *		of PCI Power Management and the related functions.)
fe6cdee8 Changbin Du        2019-05-14  808   * @shutdown:	Hook into reboot_notifier_list (kernel/sys.c).
fe6cdee8 Changbin Du        2019-05-14  809   *		Intended to stop any idling DMA operations.
fe6cdee8 Changbin Du        2019-05-14  810   *		Useful for enabling wake-on-lan (NIC) or changing
fe6cdee8 Changbin Du        2019-05-14  811   *		the power state of a device before reboot.
fe6cdee8 Changbin Du        2019-05-14  812   *		e.g. drivers/net/e100.c.
fe6cdee8 Changbin Du        2019-05-14  813   * @err_handler: See Documentation/PCI/pci-error-recovery.rst
fe6cdee8 Changbin Du        2019-05-14  814   */
^1da177e Linus Torvalds     2005-04-16  815  struct pci_driver {
^1da177e Linus Torvalds     2005-04-16  816  	struct list_head	node;
42b21932 Stephen Hemminger  2010-09-02  817  	const char		*name;
0aa0f5d1 Bjorn Helgaas      2017-12-02  818  	const struct pci_device_id *id_table;	/* Must be non-NULL for probe to be called */
^1da177e Linus Torvalds     2005-04-16  819  	int  (*probe)(struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
^1da177e Linus Torvalds     2005-04-16  820  	void (*remove)(struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
^1da177e Linus Torvalds     2005-04-16  821  	int  (*suspend)(struct pci_dev *dev, pm_message_t state);	/* Device suspended */
cbd69dbb Linus Torvalds     2006-06-24  822  	int  (*suspend_late)(struct pci_dev *dev, pm_message_t state);
cbd69dbb Linus Torvalds     2006-06-24  823  	int  (*resume_early)(struct pci_dev *dev);
^1da177e Linus Torvalds     2005-04-16  824  	int  (*resume)(struct pci_dev *dev);	/* Device woken up */
c8958177 Greg Kroah-Hartman 2005-04-08  825  	void (*shutdown)(struct pci_dev *dev);
0aa0f5d1 Bjorn Helgaas      2017-12-02  826  	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
49453028 Stephen Hemminger  2012-09-07  827  	const struct pci_error_handlers *err_handler;
92d50fc1 Greg Kroah-Hartman 2017-07-19  828  	const struct attribute_group **groups;
^1da177e Linus Torvalds     2005-04-16  829  	struct device_driver	driver;
^1da177e Linus Torvalds     2005-04-16  830  	struct pci_dynids	dynids;
^1da177e Linus Torvalds     2005-04-16 @831  };
^1da177e Linus Torvalds     2005-04-16  832  

:::::: The code at line 831 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--TB36FDmn/VVEgNH/
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
lmgAAA==

--TB36FDmn/VVEgNH/--
