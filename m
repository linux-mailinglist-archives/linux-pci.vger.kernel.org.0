Return-Path: <linux-pci+bounces-1153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A49C0818156
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 07:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3601F227E1
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 06:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE36D7468;
	Tue, 19 Dec 2023 06:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YzjMoHRt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ABA746A;
	Tue, 19 Dec 2023 06:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702966186; x=1734502186;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bqK6fT+ccdw0m9eVwDiXkII7gB/apsBy0ECFW8DrwPc=;
  b=YzjMoHRtlnecfOH1fvdhyhzc0308gh7E/4beE3c1f/gy+KbPWQji4hHU
   Ura70RzYg1Ke+k5ACFtVuujPIFfcNZ1DUNIN9N2AQHmXOPXVCeWE+v/Z2
   5LdmZ5d71j1kHeyRT2gLiZ9dzcxUhIWo/4l6c//KtPDsRJ+he78w4MYvN
   v0KukEbTDMJ26Ijy4QiAc5HBAF3B3KPo2EK1hrWhpjqqym9ucnmL37Oi3
   BKhSV0A/aDcEWvTE9YfwO5ubXSbDDzjtlHN+vgfiDP9HWW8KlnT5x2UhY
   wdWt5ROnmeLdmVBfff8d2Qt+h+lPvg4LaCgnAnZUbdORi5+mF2iTy4U9s
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2464214"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="2464214"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 22:09:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="846223740"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="846223740"
Received: from xshi3x-mobl.ccr.corp.intel.com (HELO [10.255.31.117]) ([10.255.31.117])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 22:09:43 -0800
Message-ID: <ac0fd341-7def-485e-9f32-530cf8a83273@linux.intel.com>
Date: Tue, 19 Dec 2023 14:09:40 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-pci@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, bhelgaas@google.com,
 dwmw2@infradead.org, will@kernel.org, robin.murphy@arm.com, lukas@wunner.de
References: <20231217114902.3836260-1-haifeng.zhao@linux.intel.com>
 <20231217114902.3836260-3-haifeng.zhao@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231217114902.3836260-3-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/12/17 19:49, Ethan Zhao wrote:
> For those endpoint devices connect to system via hotplug capable ports,
> users could request a warm reset to the device by flapping device's link
> through setting the slot's link control register, as pciehpt_ist() DLLSC
> interrupt sequence response, pciehp will unload the device driver and
> then power it off. thus cause an IOMMU devTLB flush request for device to
> be sent and a long time completion/timeout waiting in interrupt context.
> 
> That would cause following continuous hard lockup warning and system hang
> 
> [ 4211.433662] pcieport 0000:17:01.0: pciehp: Slot(108): Link Down
> [ 4211.433664] pcieport 0000:17:01.0: pciehp: Slot(108): Card not present
> [ 4223.822591] NMI watchdog: Watchdog detected hard LOCKUP on cpu 144
> [ 4223.822622] CPU: 144 PID: 1422 Comm: irq/57-pciehp Kdump: loaded Tainted: G S
>           OE    kernel version xxxx
> [ 4223.822623] Hardware name: vendorname xxxx 666-106,
> BIOS 01.01.02.03.01 05/15/2023
> [ 4223.822623] RIP: 0010:qi_submit_sync+0x2c0/0x490
> [ 4223.822624] Code: 48 be 00 00 00 00 00 08 00 00 49 85 74 24 20 0f 95 c1 48 8b
>   57 10 83 c1 04 83 3c 1a 03 0f 84 a2 01 00 00 49 8b 04 24 8b 70 34 <40> f6 c6 1
> 0 74 17 49 8b 04 24 8b 80 80 00 00 00 89 c2 d3 fa 41 39
> [ 4223.822624] RSP: 0018:ffffc4f074f0bbb8 EFLAGS: 00000093
> [ 4223.822625] RAX: ffffc4f040059000 RBX: 0000000000000014 RCX: 0000000000000005
> [ 4223.822625] RDX: ffff9f3841315800 RSI: 0000000000000000 RDI: ffff9f38401a8340
> [ 4223.822625] RBP: ffff9f38401a8340 R08: ffffc4f074f0bc00 R09: 0000000000000000
> [ 4223.822626] R10: 0000000000000010 R11: 0000000000000018 R12: ffff9f384005e200
> [ 4223.822626] R13: 0000000000000004 R14: 0000000000000046 R15: 0000000000000004
> [ 4223.822626] FS:  0000000000000000(0000) GS:ffffa237ae400000(0000)
> knlGS:0000000000000000
> [ 4223.822627] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4223.822627] CR2: 00007ffe86515d80 CR3: 000002fd3000a001 CR4: 0000000000770ee0
> [ 4223.822627] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 4223.822628] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [ 4223.822628] PKRU: 55555554
> [ 4223.822628] Call Trace:
> [ 4223.822628]  qi_flush_dev_iotlb+0xb1/0xd0
> [ 4223.822628]  __dmar_remove_one_dev_info+0x224/0x250
> [ 4223.822629]  dmar_remove_one_dev_info+0x3e/0x50
> [ 4223.822629]  intel_iommu_release_device+0x1f/0x30
> [ 4223.822629]  iommu_release_device+0x33/0x60
> [ 4223.822629]  iommu_bus_notifier+0x7f/0x90
> [ 4223.822630]  blocking_notifier_call_chain+0x60/0x90
> [ 4223.822630]  device_del+0x2e5/0x420
> [ 4223.822630]  pci_remove_bus_device+0x70/0x110
> [ 4223.822630]  pciehp_unconfigure_device+0x7c/0x130
> [ 4223.822631]  pciehp_disable_slot+0x6b/0x100
> [ 4223.822631]  pciehp_handle_presence_or_link_change+0xd8/0x320
> [ 4223.822631]  pciehp_ist+0x176/0x180
> [ 4223.822631]  ? irq_finalize_oneshot.part.50+0x110/0x110
> [ 4223.822632]  irq_thread_fn+0x19/0x50
> [ 4223.822632]  irq_thread+0x104/0x190
> [ 4223.822632]  ? irq_forced_thread_fn+0x90/0x90
> [ 4223.822632]  ? irq_thread_check_affinity+0xe0/0xe0
> [ 4223.822633]  kthread+0x114/0x130
> [ 4223.822633]  ? __kthread_cancel_work+0x40/0x40
> [ 4223.822633]  ret_from_fork+0x1f/0x30
> [ 4223.822633] Kernel panic - not syncing: Hard LOCKUP
> [ 4223.822634] CPU: 144 PID: 1422 Comm: irq/57-pciehp Kdump: loaded Tainted: G S
>           OE     kernel version xxxx
> [ 4223.822634] Hardware name: vendorname xxxx 666-106,
> BIOS 01.01.02.03.01 05/15/2023
> [ 4223.822634] Call Trace:
> [ 4223.822634]  <NMI>
> [ 4223.822635]  dump_stack+0x6d/0x88
> [ 4223.822635]  panic+0x101/0x2d0
> [ 4223.822635]  ? ret_from_fork+0x11/0x30
> [ 4223.822635]  nmi_panic.cold.14+0xc/0xc
> [ 4223.822636]  watchdog_overflow_callback.cold.8+0x6d/0x81
> [ 4223.822636]  __perf_event_overflow+0x4f/0xf0
> [ 4223.822636]  handle_pmi_common+0x1ef/0x290
> [ 4223.822636]  ? __set_pte_vaddr+0x28/0x40
> [ 4223.822637]  ? flush_tlb_one_kernel+0xa/0x20
> [ 4223.822637]  ? __native_set_fixmap+0x24/0x30
> [ 4223.822637]  ? ghes_copy_tofrom_phys+0x70/0x100
> [ 4223.822637]  ? __ghes_peek_estatus.isra.16+0x49/0xa0
> [ 4223.822637]  intel_pmu_handle_irq+0xba/0x2b0
> [ 4223.822638]  perf_event_nmi_handler+0x24/0x40
> [ 4223.822638]  nmi_handle+0x4d/0xf0
> [ 4223.822638]  default_do_nmi+0x49/0x100
> [ 4223.822638]  exc_nmi+0x134/0x180
> [ 4223.822639]  end_repeat_nmi+0x16/0x67
> [ 4223.822639] RIP: 0010:qi_submit_sync+0x2c0/0x490
> [ 4223.822639] Code: 48 be 00 00 00 00 00 08 00 00 49 85 74 24 20 0f 95 c1 48 8b
>   57 10 83 c1 04 83 3c 1a 03 0f 84 a2 01 00 00 49 8b 04 24 8b 70 34 <40> f6 c6 10
>   74 17 49 8b 04 24 8b 80 80 00 00 00 89 c2 d3 fa 41 39
> [ 4223.822640] RSP: 0018:ffffc4f074f0bbb8 EFLAGS: 00000093
> [ 4223.822640] RAX: ffffc4f040059000 RBX: 0000000000000014 RCX: 0000000000000005
> [ 4223.822640] RDX: ffff9f3841315800 RSI: 0000000000000000 RDI: ffff9f38401a8340
> [ 4223.822641] RBP: ffff9f38401a8340 R08: ffffc4f074f0bc00 R09: 0000000000000000
> [ 4223.822641] R10: 0000000000000010 R11: 0000000000000018 R12: ffff9f384005e200
> [ 4223.822641] R13: 0000000000000004 R14: 0000000000000046 R15: 0000000000000004
> [ 4223.822641]  ? qi_submit_sync+0x2c0/0x490
> [ 4223.822642]  ? qi_submit_sync+0x2c0/0x490
> [ 4223.822642]  </NMI>
> [ 4223.822642]  qi_flush_dev_iotlb+0xb1/0xd0
> [ 4223.822642]  __dmar_remove_one_dev_info+0x224/0x250
> [ 4223.822643]  dmar_remove_one_dev_info+0x3e/0x50
> [ 4223.822643]  intel_iommu_release_device+0x1f/0x30
> [ 4223.822643]  iommu_release_device+0x33/0x60
> [ 4223.822643]  iommu_bus_notifier+0x7f/0x90
> [ 4223.822644]  blocking_notifier_call_chain+0x60/0x90
> [ 4223.822644]  device_del+0x2e5/0x420
> [ 4223.822644]  pci_remove_bus_device+0x70/0x110
> [ 4223.822644]  pciehp_unconfigure_device+0x7c/0x130
> [ 4223.822644]  pciehp_disable_slot+0x6b/0x100
> [ 4223.822645]  pciehp_handle_presence_or_link_change+0xd8/0x320
> [ 4223.822645]  pciehp_ist+0x176/0x180
> [ 4223.822645]  ? irq_finalize_oneshot.part.50+0x110/0x110
> [ 4223.822645]  irq_thread_fn+0x19/0x50
> [ 4223.822646]  irq_thread+0x104/0x190
> [ 4223.822646]  ? irq_forced_thread_fn+0x90/0x90
> [ 4223.822646]  ? irq_thread_check_affinity+0xe0/0xe0
> [ 4223.822646]  kthread+0x114/0x130
> [ 4223.822647]  ? __kthread_cancel_work+0x40/0x40
> [ 4223.822647]  ret_from_fork+0x1f/0x30
> [ 4223.822647] Kernel Offset: 0x6400000 from 0xffffffff81000000 (relocation
> range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> Fix it by checking the device's error_state in
> devtlb_invalidation_with_pasid() to avoid sending meaningless devTLB flush
> request to link down device that is set to pci_channel_io_perm_failure and
> then powered off in
> 
> pciehp_ist()
>     pciehp_handle_presence_or_link_change()
>       pciehp_disable_slot()
>         remove_board()
>           pciehp_unconfigure_device()
> 
> For SAFE_REMOVAL unplug, link is alive when iommu releases device and
> issues devTLB invalidate request, wouldn't trigger such issue.
> 
> This patch works for all kinds of SURPPRISE_REMOVAL unplug operation.
> 
> Tested-by: Haorong Ye <yehaorong@bytedance.com>
> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> ---
>   drivers/iommu/intel/pasid.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 74e8e4c17e81..182eb5df244d 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -476,6 +476,23 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
>   {
>   	struct device_domain_info *info;
>   	u16 sid, qdep, pfsid;
> +	struct pci_dev *pdev;
> +
> +	pdev = to_pci_dev(dev);
> +	if (!pdev)
> +		return;
> +
> +	/*
> +	 * If endpoint device's link was brough down by user's pci configuration
> +	 * access to it's hotplug capable slot link control register, as sequence
> +	 * response for DLLSC, pciehp_ist() will set the device error_state to
> +	 * pci_channel_io_perm_failure. Checking device's state here to avoid
> +	 * issuing meaningless devTLB flush request to it, that might cause lockup
> +	 * warning or deadlock because too long time waiting in interrupt context.
> +	 */
> +
> +	if (pci_dev_is_disconnected(pdev))
> +		return;
>   
>   	info = dev_iommu_priv_get(dev);
>   	if (!info || !info->ats_enabled)

It's likely better to check the device status after verifying
ats_enabled. How about below change?

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 74e8e4c17e81..fa19c6cdfd8b 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -481,6 +481,9 @@ devtlb_invalidation_with_pasid(struct intel_iommu 
*iommu,
         if (!info || !info->ats_enabled)
                 return;

+       if (pci_dev_is_disconnected(to_pci_dev(dev)))
+               return
+
         sid = info->bus << 8 | info->devfn;
         qdep = info->ats_qdep;
         pfsid = info->pfsid;

Best regards,
baolu

