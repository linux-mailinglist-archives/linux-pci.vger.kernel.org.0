Return-Path: <linux-pci+bounces-3853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C2D85F3D3
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 10:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F24C1F24B85
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 09:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA68336B1B;
	Thu, 22 Feb 2024 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mz/+7ioc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B03F381D0;
	Thu, 22 Feb 2024 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592606; cv=none; b=U6NZdCBo75D0zdTT4SDrGv8u52bd2rZKnu06Vh55Zz24+yR65ZaL+xdNE6OJNDSw0TDf5XFtQucHmyuxaVZ7FZ2MRPDVuYcHVTTNI1BIe0BOghfMdvH8P2pdmKQMwTtbLWdrXqc7YzCiUdGr7fz9hVOehsGvErhXg/ezDPBdrMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592606; c=relaxed/simple;
	bh=a7XdviOurXqd+UxiwOvQTQYdFqRYCE9FWEvr4+FRLAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gsm/1v+Pt8HmZyX++2pJCJmnoNiU1xaRMWDV8BYiVT3FBCkiVyoF1YnyBbxm9wgE3yTTMfpaXwIhNAIjsLmw0b7b6SrEOtmSm8IFpTuDsFIjxWQof+c9cpu9KarnP23LZu9oQqABC+nDd+93kR/A0qyrTDFjtWJKGClZiKrhw94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mz/+7ioc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708592605; x=1740128605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a7XdviOurXqd+UxiwOvQTQYdFqRYCE9FWEvr4+FRLAA=;
  b=mz/+7iocUshVzC7gVnrX7J33X/4PHSNNTVUf6KSngaNoy82LGfqg+KVv
   dsmUr8hsKT0jbonEffJJCGX7LKY9exhWd5CYBtc4N4SnTWlS096OZLjhv
   RulBioy3YwOBSQzCsAvtPnQZ/6JMYQJHPlf7YdsW5sbND7tOGvEq5aK28
   +IjfnmZjMPPyMCsHBZ/fIj6g1brT9+6C2fsWwp7KwVqAk8AI2jWEGxct0
   V1GFU4lMHgIta3uw6Ax+7QRkdMtZMjYJo5/vvoogFKuNNYsYnmE1hxign
   y4wNjR7ki4MPZhF3MCH9aVv1ixcTla01iFfiDj1o61gUq/I2+woOWS6ys
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="25264474"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="25264474"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 01:03:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="10122658"
Received: from unknown (HELO ply01-vm-store.amr.corp.intel.com) ([10.238.153.201])
  by orviesa003.jf.intel.com with ESMTP; 22 Feb 2024 01:03:19 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	robin.murphy@arm.com,
	jgg@ziepe.ca
Cc: kevin.tian@intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	lukas@wunner.de,
	yi.l.liu@intel.com,
	dan.carpenter@linaro.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Ethan Zhao <haifeng.zhao@linux.intel.com>,
	Haorong Ye <yehaorong@bytedance.com>
Subject: [PATCH v13 2/3] iommu/vt-d: don't issue ATS Invalidation request when device is disconnected
Date: Thu, 22 Feb 2024 04:02:50 -0500
Message-Id: <20240222090251.2849702-3-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240222090251.2849702-1-haifeng.zhao@linux.intel.com>
References: <20240222090251.2849702-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For those endpoint devices connect to system via hotplug capable ports,
users could request a hot reset to the device by flapping device's link
through setting the slot's link control register, as pciehp_ist() DLLSC
interrupt sequence response, pciehp will unload the device driver and
then power it off. thus cause an IOMMU device-TLB invalidation (Intel
VT-d spec, or ATS Invalidation in PCIe spec r6.1) request for non-existence
target device to be sent and deadly loop to retry that request after ITE
fault triggered in interrupt context.

That would cause following continuous hard lockup warning and system hang

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

Such issue could be triggered by all kinds of regular surprise removal
hotplug operation. like:

1. pull EP(endpoint device) out directly.
2. turn off EP's power.
3. bring the link down.
etc.

this patch aims to work for regular safe removal and surprise removal
unplug. these hot unplug handling process could be optimized for fix the
ATS Invalidation hang issue by calling pci_dev_is_disconnected() in
function devtlb_invalidation_with_pasid() to check target device state to
avoid sending meaningless ATS Invalidation request to iommu when device is
gone. (see IMPLEMENTATION NOTE in PCIe spec r6.1 section 10.3.1)

For safe removal, device wouldn't be removed until the whole software
handling process is done, it wouldn't trigger the hard lock up issue
caused by too long ATS Invalidation timeout wait. In safe removal path,
device state isn't set to pci_channel_io_perm_failure in
pciehp_unconfigure_device() by checking 'presence' parameter, calling
pci_dev_is_disconnected() in devtlb_invalidation_with_pasid() will return
false there, wouldn't break the function.

For surprise removal, device state is set to pci_channel_io_perm_failure in
pciehp_unconfigure_device(), means device is already gone (disconnected)
call pci_dev_is_disconnected() in devtlb_invalidation_with_pasid() will
return true to break the function not to send ATS Invalidation request to
the disconnected device blindly, thus avoid to trigger further ITE fault,
and ITE fault will block all invalidation request to be handled.
furthermore retry the timeout request could trigger hard lockup.

safe removal (present) & surprise removal (not present)

pciehp_ist()
   pciehp_handle_presence_or_link_change()
     pciehp_disable_slot()
       remove_board()
         pciehp_unconfigure_device(presence) {
           if (!presence)
                pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
           }

this patch works for regular safe removal and surprise removal of ATS
capable endpoint on PCIe switch downstream ports.

Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table interface")
Tested-by: Haorong Ye <yehaorong@bytedance.com>
Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 108158e2b907..746c7abe2237 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -214,6 +214,9 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	if (!info || !info->ats_enabled)
 		return;
 
+	if (pci_dev_is_disconnected(to_pci_dev(dev)))
+		return;
+
 	sid = info->bus << 8 | info->devfn;
 	qdep = info->ats_qdep;
 	pfsid = info->pfsid;
-- 
2.31.1


