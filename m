Return-Path: <linux-pci+bounces-1981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC75829531
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 09:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8897BB2646F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 08:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E693EA9F;
	Wed, 10 Jan 2024 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bk+lwM5C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182163EA8C;
	Wed, 10 Jan 2024 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704875360; x=1736411360;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HGUnFfKqfo0vhTDrCpcMiyiWljW4q+J7UTiA46fVaj8=;
  b=bk+lwM5CakAakfI5eIGGPnvmMx45rvREM714uc6uhY9Kebfeb7+nN7ay
   Fl44V69/FzUfkfo80dsFSBX9zWrXov+xr+itSQ9FInNN4++su7rllWdKc
   wPJBR8gKIkvaWEbeN+dmUfkq7WK+5p3Ar7CKUspFp+CT2VLedN3IxEerR
   L1bIMQGfnZS3AMWOT00hYI5fo/CNtHpnJs9Ss6Tk6xGO8wsr32w6cWs1W
   /dHof6EJAjkJD45gkdNRDwpRZGkDQZ54ocVlwl4IRXgduHdqB3qepfsuy
   U8jPHieHjFIpMuiaHsp5jvz3vBbX5f+08Vc1M+eBk6uPziSCCx1gMBm00
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5220485"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5220485"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 00:29:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="901066966"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="901066966"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.11.157]) ([10.93.11.157])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 00:29:15 -0800
Message-ID: <290c30a5-c828-47e1-be42-a5a11a944a5c@linux.intel.com>
Date: Wed, 10 Jan 2024 16:29:13 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v10 2/5] iommu/vt-d: break out ATS Invalidation if
 target device is gone
To: Baolu Lu <baolu.lu@linux.intel.com>, kevin.tian@intel.com,
 bhelgaas@google.com, dwmw2@infradead.org, will@kernel.org,
 robin.murphy@arm.com, lukas@wunner.de
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231228170206.720675-1-haifeng.zhao@linux.intel.com>
 <20231228170206.720675-3-haifeng.zhao@linux.intel.com>
 <d0446efb-936c-4abc-839b-8e6c3f28ee07@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <d0446efb-936c-4abc-839b-8e6c3f28ee07@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/10/2024 1:17 PM, Baolu Lu wrote:
> On 12/29/23 1:02 AM, Ethan Zhao wrote:
>> For those endpoint devices connect to system via hotplug capable ports,
>> users could request a warm reset to the device by flapping device's link
>> through setting the slot's link control register, as pciehp_ist() DLLSC
>> interrupt sequence response, pciehp will unload the device driver and
>> then power it off. thus cause an IOMMU device-TLB invalidation (Intel
>> VT-d spec, or ATS Invalidation in PCIe spec r6.1) request for device to
>> be sent and a long time completion/timeout waiting in interrupt context.
>>
>> That would cause following continuous hard lockup warning and system 
>> hang
>>
>> [ 4211.433662] pcieport 0000:17:01.0: pciehp: Slot(108): Link Down
>> [ 4211.433664] pcieport 0000:17:01.0: pciehp: Slot(108): Card not 
>> present
>> [ 4223.822591] NMI watchdog: Watchdog detected hard LOCKUP on cpu 144
>> [ 4223.822622] CPU: 144 PID: 1422 Comm: irq/57-pciehp Kdump: loaded 
>> Tainted: G S
>>           OE    kernel version xxxx
>> [ 4223.822623] Hardware name: vendorname xxxx 666-106,
>> BIOS 01.01.02.03.01 05/15/2023
>> [ 4223.822623] RIP: 0010:qi_submit_sync+0x2c0/0x490
>> [ 4223.822624] Code: 48 be 00 00 00 00 00 08 00 00 49 85 74 24 20 0f 
>> 95 c1 48 8b
>>   57 10 83 c1 04 83 3c 1a 03 0f 84 a2 01 00 00 49 8b 04 24 8b 70 34 
>> <40> f6 c6 1
>> 0 74 17 49 8b 04 24 8b 80 80 00 00 00 89 c2 d3 fa 41 39
>> [ 4223.822624] RSP: 0018:ffffc4f074f0bbb8 EFLAGS: 00000093
>> [ 4223.822625] RAX: ffffc4f040059000 RBX: 0000000000000014 RCX: 
>> 0000000000000005
>> [ 4223.822625] RDX: ffff9f3841315800 RSI: 0000000000000000 RDI: 
>> ffff9f38401a8340
>> [ 4223.822625] RBP: ffff9f38401a8340 R08: ffffc4f074f0bc00 R09: 
>> 0000000000000000
>> [ 4223.822626] R10: 0000000000000010 R11: 0000000000000018 R12: 
>> ffff9f384005e200
>> [ 4223.822626] R13: 0000000000000004 R14: 0000000000000046 R15: 
>> 0000000000000004
>> [ 4223.822626] FS:  0000000000000000(0000) GS:ffffa237ae400000(0000)
>> knlGS:0000000000000000
>> [ 4223.822627] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 4223.822627] CR2: 00007ffe86515d80 CR3: 000002fd3000a001 CR4: 
>> 0000000000770ee0
>> [ 4223.822627] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
>> 0000000000000000
>> [ 4223.822628] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 
>> 0000000000000400
>> [ 4223.822628] PKRU: 55555554
>> [ 4223.822628] Call Trace:
>> [ 4223.822628]  qi_flush_dev_iotlb+0xb1/0xd0
>> [ 4223.822628]  __dmar_remove_one_dev_info+0x224/0x250
>> [ 4223.822629]  dmar_remove_one_dev_info+0x3e/0x50
>> [ 4223.822629]  intel_iommu_release_device+0x1f/0x30
>> [ 4223.822629]  iommu_release_device+0x33/0x60
>> [ 4223.822629]  iommu_bus_notifier+0x7f/0x90
>> [ 4223.822630]  blocking_notifier_call_chain+0x60/0x90
>> [ 4223.822630]  device_del+0x2e5/0x420
>> [ 4223.822630]  pci_remove_bus_device+0x70/0x110
>> [ 4223.822630]  pciehp_unconfigure_device+0x7c/0x130
>> [ 4223.822631]  pciehp_disable_slot+0x6b/0x100
>> [ 4223.822631]  pciehp_handle_presence_or_link_change+0xd8/0x320
>> [ 4223.822631]  pciehp_ist+0x176/0x180
>> [ 4223.822631]  ? irq_finalize_oneshot.part.50+0x110/0x110
>> [ 4223.822632]  irq_thread_fn+0x19/0x50
>> [ 4223.822632]  irq_thread+0x104/0x190
>> [ 4223.822632]  ? irq_forced_thread_fn+0x90/0x90
>> [ 4223.822632]  ? irq_thread_check_affinity+0xe0/0xe0
>> [ 4223.822633]  kthread+0x114/0x130
>> [ 4223.822633]  ? __kthread_cancel_work+0x40/0x40
>> [ 4223.822633]  ret_from_fork+0x1f/0x30
>> [ 4223.822633] Kernel panic - not syncing: Hard LOCKUP
>> [ 4223.822634] CPU: 144 PID: 1422 Comm: irq/57-pciehp Kdump: loaded 
>> Tainted: G S
>>           OE     kernel version xxxx
>> [ 4223.822634] Hardware name: vendorname xxxx 666-106,
>> BIOS 01.01.02.03.01 05/15/2023
>> [ 4223.822634] Call Trace:
>> [ 4223.822634]  <NMI>
>> [ 4223.822635]  dump_stack+0x6d/0x88
>> [ 4223.822635]  panic+0x101/0x2d0
>> [ 4223.822635]  ? ret_from_fork+0x11/0x30
>> [ 4223.822635]  nmi_panic.cold.14+0xc/0xc
>> [ 4223.822636]  watchdog_overflow_callback.cold.8+0x6d/0x81
>> [ 4223.822636]  __perf_event_overflow+0x4f/0xf0
>> [ 4223.822636]  handle_pmi_common+0x1ef/0x290
>> [ 4223.822636]  ? __set_pte_vaddr+0x28/0x40
>> [ 4223.822637]  ? flush_tlb_one_kernel+0xa/0x20
>> [ 4223.822637]  ? __native_set_fixmap+0x24/0x30
>> [ 4223.822637]  ? ghes_copy_tofrom_phys+0x70/0x100
>> [ 4223.822637]  ? __ghes_peek_estatus.isra.16+0x49/0xa0
>> [ 4223.822637]  intel_pmu_handle_irq+0xba/0x2b0
>> [ 4223.822638]  perf_event_nmi_handler+0x24/0x40
>> [ 4223.822638]  nmi_handle+0x4d/0xf0
>> [ 4223.822638]  default_do_nmi+0x49/0x100
>> [ 4223.822638]  exc_nmi+0x134/0x180
>> [ 4223.822639]  end_repeat_nmi+0x16/0x67
>> [ 4223.822639] RIP: 0010:qi_submit_sync+0x2c0/0x490
>> [ 4223.822639] Code: 48 be 00 00 00 00 00 08 00 00 49 85 74 24 20 0f 
>> 95 c1 48 8b
>>   57 10 83 c1 04 83 3c 1a 03 0f 84 a2 01 00 00 49 8b 04 24 8b 70 34 
>> <40> f6 c6 10
>>   74 17 49 8b 04 24 8b 80 80 00 00 00 89 c2 d3 fa 41 39
>> [ 4223.822640] RSP: 0018:ffffc4f074f0bbb8 EFLAGS: 00000093
>> [ 4223.822640] RAX: ffffc4f040059000 RBX: 0000000000000014 RCX: 
>> 0000000000000005
>> [ 4223.822640] RDX: ffff9f3841315800 RSI: 0000000000000000 RDI: 
>> ffff9f38401a8340
>> [ 4223.822641] RBP: ffff9f38401a8340 R08: ffffc4f074f0bc00 R09: 
>> 0000000000000000
>> [ 4223.822641] R10: 0000000000000010 R11: 0000000000000018 R12: 
>> ffff9f384005e200
>> [ 4223.822641] R13: 0000000000000004 R14: 0000000000000046 R15: 
>> 0000000000000004
>> [ 4223.822641]  ? qi_submit_sync+0x2c0/0x490
>> [ 4223.822642]  ? qi_submit_sync+0x2c0/0x490
>> [ 4223.822642]  </NMI>
>> [ 4223.822642]  qi_flush_dev_iotlb+0xb1/0xd0
>> [ 4223.822642]  __dmar_remove_one_dev_info+0x224/0x250
>> [ 4223.822643]  dmar_remove_one_dev_info+0x3e/0x50
>> [ 4223.822643]  intel_iommu_release_device+0x1f/0x30
>> [ 4223.822643]  iommu_release_device+0x33/0x60
>> [ 4223.822643]  iommu_bus_notifier+0x7f/0x90
>> [ 4223.822644]  blocking_notifier_call_chain+0x60/0x90
>> [ 4223.822644]  device_del+0x2e5/0x420
>> [ 4223.822644]  pci_remove_bus_device+0x70/0x110
>> [ 4223.822644]  pciehp_unconfigure_device+0x7c/0x130
>> [ 4223.822644]  pciehp_disable_slot+0x6b/0x100
>> [ 4223.822645]  pciehp_handle_presence_or_link_change+0xd8/0x320
>> [ 4223.822645]  pciehp_ist+0x176/0x180
>> [ 4223.822645]  ? irq_finalize_oneshot.part.50+0x110/0x110
>> [ 4223.822645]  irq_thread_fn+0x19/0x50
>> [ 4223.822646]  irq_thread+0x104/0x190
>> [ 4223.822646]  ? irq_forced_thread_fn+0x90/0x90
>> [ 4223.822646]  ? irq_thread_check_affinity+0xe0/0xe0
>> [ 4223.822646]  kthread+0x114/0x130
>> [ 4223.822647]  ? __kthread_cancel_work+0x40/0x40
>> [ 4223.822647]  ret_from_fork+0x1f/0x30
>> [ 4223.822647] Kernel Offset: 0x6400000 from 0xffffffff81000000 
>> (relocation
>> range: 0xffffffff80000000-0xffffffffbfffffff)
>>
>> Furthermore even an in-process safe removal unplugged device could be
>> surprise removed anytime, thus need to check the ATS Invalidation target
>> device state to see if it is gone, and don't wait for the completion/
>> timeout blindly, thus avoid the up to 1min+50% (see Implementation Note
>> in PCIe spec r6.1 sec 10.3.1) waiting and cause hard lockup or system
>> hang.
>>
>> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> ---
>>   drivers/iommu/intel/dmar.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index 3d661f2b7946..0a8d628a42ee 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -1423,6 +1423,14 @@ int qi_submit_sync(struct intel_iommu *iommu, 
>> struct qi_desc *desc,
>>       writel(qi->free_head << shift, iommu->reg + DMAR_IQT_REG);
>>         while (qi->desc_status[wait_index] != QI_DONE) {
>> +        /*
>> +         * if the device-TLB invalidation target device is gone, don't
>> +         * wait anymore, it might take up to 1min+50%, causes system
>> +         * hang. (see Implementation Note in PCIe spec r6.1 sec 10.3.1)
>> +         */
>> +        if ((type == QI_DIOTLB_TYPE || type == QI_DEIOTLB_TYPE) && 
>> pdev)
>> +            if (!pci_device_is_present(pdev))
>> +                    break;
>>           /*
>>            * We will leave the interrupts disabled, to prevent interrupt
>>            * context to queue another cmd while a cmd is already 
>> submitted
>
> How about handing this in qi_check_fault() when it detects an ITE error?

fold into qi_check_fault() looks reasonable, no response from endpoint

device is a kind of fault. my concern there is no real ITE there (it didn't

wait for enough time), but it predicts there would be a timeout, that

is weird if we describe the fact, -ENOTCONN would be more precise

(device is not conneted)  well -ETIMEDOUT could simplify the caller error

handling, the side effect is we have to add pdev parameter to 
qi_check_fault()

too. then no need to check invalidition type of QI_IOTLB_TYPE &

QI_EIOTLB_TYPE in qi_check_fault() ? , seems we could save another

patch then, I am still not be convinced :), on the wall, not incline

to which side.

pros

- qi_submit_sync() could be simpler in error handling.

- qi_check_fault() does the right thing it should do.

- save another patch to break the loop.

cons

- more parameters to qi_check_fault()

- lost one opportunity to break loop while retry, but will bail out in 
next try.



Thanks,

Ethan

>
> qi_check_fault() should returns -ETIMEDOUT instead of -EAGAIN, if
>
> - qi_submit_sync() is called for a device TLB invalidation request
>   (indicated by pdev is valid);
> - device is not present.
>
> Best regards,
> baolu

