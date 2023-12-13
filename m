Return-Path: <linux-pci+bounces-834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7A28108D0
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 04:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDAF28235A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 03:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB099471;
	Wed, 13 Dec 2023 03:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZyyRtws"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24D8B7;
	Tue, 12 Dec 2023 19:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702439254; x=1733975254;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=je5nKRidUNnG58JMaYYxuhlKzpazqskKw4rSM3Yy+H0=;
  b=SZyyRtwsXeTKHV0Li3Mb+u1u9IbFqwek1C54N7wwsVmHYV3lCReyQ6SV
   vNKp1Fb/9a29mHti0T/RZWy1Cw4+AkDrcwZgtkgEydz80VAk8HCUhlx67
   LSFmYwh5YfaVWX3ZDF5+l9++KRDeCMfS8KpAariUctFHLc8ywqcyYi2jk
   JNzxRX28o5lsNvMHIMVl/yaIyBOFRvRVCKn0uzH2DLWSobyRyl6VGUdui
   DjmnFEup/kMyeX6JiI3zjxkhR4O+eZ4A/6WwOj4a3nA3DQPl3zpwOjuU/
   dNqFEeVv/UJG1Ap5vn6X0llW9r6BJQ1ddwYh7X4yIWrsRBtaWvj22aNnG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="459227270"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="459227270"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 19:47:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="897175455"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="897175455"
Received: from ply01-vm-store.bj.intel.com ([10.238.153.201])
  by orsmga004.jf.intel.com with ESMTP; 12 Dec 2023 19:47:30 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: bhelgaas@google.com,
	baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: linux-pci@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	haifeng.zhao@linux.intel.com
Subject: [PATCH RFC 0/2] fix vt-d hard lockup when hotplug ATS capable device
Date: Tue, 12 Dec 2023 22:46:35 -0500
Message-Id: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 This patch is used to fix vt-d hard lockup reported when ATS capable 
 endpoint device connects to system via PCIe switch populates in root port
 as following topology.

     +-[0000:15]-+-00.0  Intel Corporation Ice Lake Memory Map/VT-d
     |           +-00.1  Intel Corporation Ice Lake Mesh 2 PCIe
     |           +-00.2  Intel Corporation Ice Lake RAS
     |           +-00.4  Intel Corporation Device 0b23
     |           \-01.0-[16-1b]----00.0-[17-1b]--+-00.0-[18]----00.0 
                                           NVIDIA Corporation Device 2324
     |                                           +-01.0-[19]----00.0
                          Mellanox Technologies MT2910 Family [ConnectX-7]

 User brought endpoint device 19:00.0's link down by flap it's hotplug 
 capable slot 17:01.0 link control register, as sequence DLLSC response, 
 pciehp_ist() will unload device driver and power it off, durning device
 driver is unloading an iommu devTlb flush request isssed to that link 
 down device, thus a long time completion/timeout waiting in interrupt
 context causes continuous lock lockup warnning and system hang.

[ 4211.433662] pcieport 0000:17:01.0: pciehp: Slot(108): Link Down
[ 4211.433664] pcieport 0000:17:01.0: pciehp: Slot(108): Card not present
[ 4223.822591] NMI watchdog: Watchdog detected hard LOCKUP on cpu 144
[ 4223.822622] CPU: 144 PID: 1422 Comm: irq/57-pciehp Kdump: loaded Tainted: G S
         OE    kernel version xxxx
[ 4223.822623] Hardware name: vendorname xxxx 666-106,
BIOS 01.01.02.03.01 05/15/2023
[ 4223.822623] RIP: 0010:qi_submit_sync+0x2c0/0x490
[ 4223.822624] Code: 48 be 00 00 00 00 00 08 00 00 49 85 74 24 20 0f 95 c1 48 8b
 57 10 83 c1 04 83 3c 1a 03 0f 84 a2 01 00 00 49 8b 04 24 8b 70 34 <40> f6 c6 1
0 74 17 49 8b 04 24 8b 80 80 00 00 00 89 c2 d3 fa 41 39
[ 4223.822624] RSP: 0018:ffffc4f074f0bbb8 EFLAGS: 00000093
[ 4223.822625] RAX: ffffc4f040059000 RBX: 0000000000000014 RCX: 0000000000000005
[ 4223.822625] RDX: ffff9f3841315800 RSI: 0000000000000000 RDI: ffff9f38401a8340
[ 4223.822625] RBP: ffff9f38401a8340 R08: ffffc4f074f0bc00 R09: 0000000000000000
[ 4223.822626] R10: 0000000000000010 R11: 0000000000000018 R12: ffff9f384005e200
[ 4223.822626] R13: 0000000000000004 R14: 0000000000000046 R15: 0000000000000004
[ 4223.822626] FS:  0000000000000000(0000) GS:ffffa237ae400000(0000)
knlGS:0000000000000000
[ 4223.822627] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4223.822627] CR2: 00007ffe86515d80 CR3: 000002fd3000a001 CR4: 0000000000770ee0
[ 4223.822627] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 4223.822628] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[ 4223.822628] PKRU: 55555554
[ 4223.822628] Call Trace:
[ 4223.822628]  qi_flush_dev_iotlb+0xb1/0xd0
[ 4223.822628]  __dmar_remove_one_dev_info+0x224/0x250
[ 4223.822629]  dmar_remove_one_dev_info+0x3e/0x50
[ 4223.822629]  intel_iommu_release_device+0x1f/0x30
[ 4223.822629]  iommu_release_device+0x33/0x60
[ 4223.822629]  iommu_bus_notifier+0x7f/0x90
[ 4223.822630]  blocking_notifier_call_chain+0x60/0x90
[ 4223.822630]  device_del+0x2e5/0x420
[ 4223.822630]  pci_remove_bus_device+0x70/0x110
[ 4223.822630]  pciehp_unconfigure_device+0x7c/0x130
[ 4223.822631]  pciehp_disable_slot+0x6b/0x100
[ 4223.822631]  pciehp_handle_presence_or_link_change+0xd8/0x320
[ 4223.822631]  pciehp_ist+0x176/0x180
[ 4223.822631]  ? irq_finalize_oneshot.part.50+0x110/0x110
[ 4223.822632]  irq_thread_fn+0x19/0x50
[ 4223.822632]  irq_thread+0x104/0x190
[ 4223.822632]  ? irq_forced_thread_fn+0x90/0x90
[ 4223.822632]  ? irq_thread_check_affinity+0xe0/0xe0
[ 4223.822633]  kthread+0x114/0x130
[ 4223.822633]  ? __kthread_cancel_work+0x40/0x40
[ 4223.822633]  ret_from_fork+0x1f/0x30
[ 4223.822633] Kernel panic - not syncing: Hard LOCKUP
[ 4223.822634] CPU: 144 PID: 1422 Comm: irq/57-pciehp Kdump: loaded Tainted: G S
         OE     kernel version xxxx
[ 4223.822634] Hardware name: vendorname xxxx 666-106,
BIOS 01.01.02.03.01 05/15/2023
[ 4223.822634] Call Trace:
[ 4223.822634]  <NMI>
[ 4223.822635]  dump_stack+0x6d/0x88
[ 4223.822635]  panic+0x101/0x2d0
[ 4223.822635]  ? ret_from_fork+0x11/0x30
[ 4223.822635]  nmi_panic.cold.14+0xc/0xc
[ 4223.822636]  watchdog_overflow_callback.cold.8+0x6d/0x81
[ 4223.822636]  __perf_event_overflow+0x4f/0xf0
[ 4223.822636]  handle_pmi_common+0x1ef/0x290
[ 4223.822636]  ? __set_pte_vaddr+0x28/0x40
[ 4223.822637]  ? flush_tlb_one_kernel+0xa/0x20
[ 4223.822637]  ? __native_set_fixmap+0x24/0x30
[ 4223.822637]  ? ghes_copy_tofrom_phys+0x70/0x100
[ 4223.822637]  ? __ghes_peek_estatus.isra.16+0x49/0xa0
[ 4223.822637]  intel_pmu_handle_irq+0xba/0x2b0
[ 4223.822638]  perf_event_nmi_handler+0x24/0x40
[ 4223.822638]  nmi_handle+0x4d/0xf0
[ 4223.822638]  default_do_nmi+0x49/0x100
[ 4223.822638]  exc_nmi+0x134/0x180
[ 4223.822639]  end_repeat_nmi+0x16/0x67
[ 4223.822639] RIP: 0010:qi_submit_sync+0x2c0/0x490
[ 4223.822639] Code: 48 be 00 00 00 00 00 08 00 00 49 85 74 24 20 0f 95 c1 48 8b
 57 10 83 c1 04 83 3c 1a 03 0f 84 a2 01 00 00 49 8b 04 24 8b 70 34 <40> f6 c6 10
 74 17 49 8b 04 24 8b 80 80 00 00 00 89 c2 d3 fa 41 39
[ 4223.822640] RSP: 0018:ffffc4f074f0bbb8 EFLAGS: 00000093
[ 4223.822640] RAX: ffffc4f040059000 RBX: 0000000000000014 RCX: 0000000000000005
[ 4223.822640] RDX: ffff9f3841315800 RSI: 0000000000000000 RDI: ffff9f38401a8340
[ 4223.822641] RBP: ffff9f38401a8340 R08: ffffc4f074f0bc00 R09: 0000000000000000
[ 4223.822641] R10: 0000000000000010 R11: 0000000000000018 R12: ffff9f384005e200
[ 4223.822641] R13: 0000000000000004 R14: 0000000000000046 R15: 0000000000000004
[ 4223.822641]  ? qi_submit_sync+0x2c0/0x490
[ 4223.822642]  ? qi_submit_sync+0x2c0/0x490
[ 4223.822642]  </NMI>
[ 4223.822642]  qi_flush_dev_iotlb+0xb1/0xd0
[ 4223.822642]  __dmar_remove_one_dev_info+0x224/0x250
[ 4223.822643]  dmar_remove_one_dev_info+0x3e/0x50
[ 4223.822643]  intel_iommu_release_device+0x1f/0x30
[ 4223.822643]  iommu_release_device+0x33/0x60
[ 4223.822643]  iommu_bus_notifier+0x7f/0x90
[ 4223.822644]  blocking_notifier_call_chain+0x60/0x90
[ 4223.822644]  device_del+0x2e5/0x420
[ 4223.822644]  pci_remove_bus_device+0x70/0x110
[ 4223.822644]  pciehp_unconfigure_device+0x7c/0x130
[ 4223.822644]  pciehp_disable_slot+0x6b/0x100
[ 4223.822645]  pciehp_handle_presence_or_link_change+0xd8/0x320
[ 4223.822645]  pciehp_ist+0x176/0x180
[ 4223.822645]  ? irq_finalize_oneshot.part.50+0x110/0x110
[ 4223.822645]  irq_thread_fn+0x19/0x50
[ 4223.822646]  irq_thread+0x104/0x190
[ 4223.822646]  ? irq_forced_thread_fn+0x90/0x90
[ 4223.822646]  ? irq_thread_check_affinity+0xe0/0xe0
[ 4223.822646]  kthread+0x114/0x130
[ 4223.822647]  ? __kthread_cancel_work+0x40/0x40
[ 4223.822647]  ret_from_fork+0x1f/0x30
[ 4223.822647] Kernel Offset: 0x6400000 from 0xffffffff81000000 (relocation
range: 0xffffffff80000000-0xffffffffbfffffff)

Fix it by checking the device's error_state in
devtlb_invalidation_with_pasid() to avoid sending meaningless devTLB flush
request to link down device that is set to pci_channel_io_perm_failure and
then powered off in

pciehp_ist()
   pciehp_handle_presence_or_link_change()
     pciehp_disable_slot()
       remove_board()
         pciehp_unconfigure_device()
 

This patchset was tested by yehaorong@bytedance.com on stable-6.7rc4.
And is sent for more comment.

Ethan Zhao (2):
  PCI: make pci_dev_is_disconnected() helper public for other drivers
  iommu/vt-d: don's issue devTLB flush request when device is
    disconnected

 drivers/iommu/intel/pasid.c | 21 ++++++++++++++++++++-
 drivers/pci/pci.h           |  5 -----
 include/linux/pci.h         |  5 +++++
 3 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.31.1


