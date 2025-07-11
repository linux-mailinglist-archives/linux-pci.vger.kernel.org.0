Return-Path: <linux-pci+bounces-31907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 758B3B013E4
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 08:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375A35A48AD
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 06:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281751D9346;
	Fri, 11 Jul 2025 06:49:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49194.qiye.163.com (mail-m49194.qiye.163.com [45.254.49.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CF41DFDB8;
	Fri, 11 Jul 2025 06:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752216580; cv=none; b=cdZ5KQaD/K+XZZbaeKAYZFnfV1YZJspyGe9jrTiNHHhgmEHIGFsHAyrV2ItCy0SWo8bUkX91GX3JVRZJX9y0A31AYb1Yh1iobzf0fZwX14Y0kMf6Cls/RmcSbTHL0IH0zOr24hFrX6K2QgmMgf4rfeYA/pd/30mE0vhGSlZj06M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752216580; c=relaxed/simple;
	bh=QZrMrJlhlfBGdfCa857qFOkagVrEV/xyyBgoKtuNvRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rxy3cUP0S1/Nm9sxwy9eVB21cChUfF8Y4P5OPS+wrXS0NzIPnLZ++t0jCPkjsH0N5rgbPIH9KUwEfARH+fUh2TXfpAIssts3zXQGCAzSna2qarNgKHptXov5uraHMa6Myji/G/X60HoYg9iuwNP8oKHWAQ2J5Kv1q1FvnqtRW78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com; spf=pass smtp.mailfrom=hj-micro.com; arc=none smtp.client-ip=45.254.49.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hj-micro.com
Received: from [172.21.129.96] (unknown [122.224.241.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1ba5d1178;
	Fri, 11 Jul 2025 11:20:15 +0800 (GMT+08:00)
Message-ID: <b9b64b4f-dcec-4ab1-b796-54d66ec91fc5@hj-micro.com>
Date: Fri, 11 Jul 2025 11:20:15 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/DPC: Extend DPC recovery timeout
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 bhelgaas@google.com, lukas@wunner.de
Cc: mahesh@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, jemma.zhang@hj-micro.com, peter.du@hj-micro.com
References: <20250707103014.1279262-1-andy.xu@hj-micro.com>
 <24dfe8e2-e4b3-40e9-b9ac-026e057abd30@linux.intel.com>
From: Hongbo Yao <andy.xu@hj-micro.com>
In-Reply-To: <24dfe8e2-e4b3-40e9-b9ac-026e057abd30@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSk9OVksZS0JKTE5CTR0eHVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSUlVSUlPVUlPSlVIT1lXWRYaDxIVHRRZQVlPS0hVSktJSEJIQ1VKS0
	tVSkJLS1kG
X-HM-Tid: 0a97f77f77bf03afkunmc5f2982d1629a34
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngw6EAw6KDErCRlPD0wDCxMu
	NEsKFAFVSlVKTE5JSUtPS0pNQk9DVTMWGhIXVRoVHwJVAw47ExFWFhIYCRRVGBQWRVlXWRILWUFZ
	SklJVUlJT1VJT0pVSE9ZV1kIAVlBQ09JTzcG



在 2025/7/8 1:04, Sathyanarayanan Kuppuswamy 写道:
> 
> On 7/7/25 3:30 AM, Andy Xu wrote:
>> From: Hongbo Yao <andy.xu@hj-micro.com>
>>
>> Extend the DPC recovery timeout from 4 seconds to 7 seconds to
>> support Mellanox ConnectX series network adapters.
>>
>> My environment:
>>    - Platform: arm64 N2 based server
>>    - Endpoint1: Mellanox Technologies MT27800 Family [ConnectX-5]
>>    - Endpoint2: Mellanox Technologies MT2910 Family [ConnectX-7]
>>
>> With the original 4s timeout, hotplug would still be triggered:
>>
>> [ 81.012463] pcieport 0004:00:00.0: DPC: containment event,
>> status:0x1f01 source:0x0000
>> [ 81.014536] pcieport 0004:00:00.0: DPC: unmasked uncorrectable error
>> detected
>> [ 81.029598] pcieport 0004:00:00.0: PCIe Bus Error:
>> severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver ID)
>> [ 81.040830] pcieport 0004:00:00.0: device [0823:0110] error status/
>> mask=00008000/04d40000
>> [ 81.049870] pcieport 0004:00:00.0: [ 0] ERCR (First)
>> [ 81.053520] pcieport 0004:00:00.0: AER: TLP Header: 60008010 010000ff
>> 00001000 9c4c0000
>> [ 81.065793] mlx5_core 0004:01:00.0: mlx5_pci_err_detected Device
>> state = 1 health sensors: 1 pci_status: 1. Enter, pci channel state = 2
>> [ 81.076183] mlx5_core 0004:01:00.0: mlx5_error_sw_reset:231:(pid
>> 1618): start
>> [ 81.083307] mlx5_core 0004:01:00.0: mlx5_error_sw_reset:252:(pid
>> 1618): PCI channel offline, stop waiting for NIC IFC
>> [ 81.077428] mlx5_core 0004:01:00.0: E-Switch: Disable: mode(LEGACY),
>> nvfs(0), neovfs(0), active vports(0)
>> [ 81.486693] mlx5_core 0004:01:00.0: mlx5_wait_for_pages:786:(pid
>> 1618): Skipping wait for vf pages stage
>> [ 81.496965] mlx5_core 0004:01:00.0: mlx5_wait_for_pages:786:(pid
>> 1618): Skipping wait for vf pages stage
>> [ 82.395040] mlx5_core 0004:01:00.1: print_health:819:(pid 0): Fatal
>> error detected
>> [ 82.395493] mlx5_core 0004:01:00.1: print_health_info:423:(pid 0):
>> PCI slot 1 is unavailable
>> [ 83.431094] mlx5_core 0004:01:00.0: mlx5_pci_err_detected Device
>> state = 2 pci_status: 0. Exit, result = 3, need reset
>> [ 83.442100] mlx5_core 0004:01:00.1: mlx5_pci_err_detected Device
>> state = 2 health sensors: 1 pci_status: 1. Enter, pci channel state = 2
>> [ 83.441801] mlx5_core 0004:01:00.0: mlx5_crdump_collect:50:(pid
>> 2239): crdump: failed to lock gw status -13
>> [ 83.454050] mlx5_core 0004:01:00.1: mlx5_error_sw_reset:231:(pid
>> 1618): start
>> [ 83.454050] mlx5_core 0004:01:00.1: mlx5_error_sw_reset:252:(pid
>> 1618): PCI channel offline, stop waiting for NIC IFC
>> [ 83.849429] mlx5_core 0004:01:00.1: E-Switch: Disable: mode(LEGACY),
>> nvfs(0), neovfs(0), active vports(0)
>> [ 83.858892] mlx5_core 0004:01:00.1: mlx5_wait_for_pages:786:(pid
>> 1618): Skipping wait for vf pages stage
>> [ 83.869464] mlx5_core 0004:01:00.1: mlx5_wait_for_pages:786:(pid
>> 1618): Skipping wait for vf pages stage
>> [ 85.201433] pcieport 0004:00:00.0: pciehp: Slot(41): Link Down
>> [ 85.815016] mlx5_core 0004:01:00.1: mlx5_health_try_recover:335:(pid
>> 2239): handling bad device here
>> [ 85.824164] mlx5_core 0004:01:00.1: mlx5_error_sw_reset:231:(pid
>> 2239): start
>> [ 85.831283] mlx5_core 0004:01:00.1: mlx5_error_sw_reset:252:(pid
>> 2239): PCI channel offline, stop waiting for NIC IFC
>> [ 85.841899] mlx5_core 0004:01:00.1: mlx5_unload_one_dev_locked:1612:
>> (pid 2239): mlx5_unload_one_dev_locked: interface is down, NOP
>> [ 85.853799] mlx5_core 0004:01:00.1: mlx5_health_wait_pci_up:325:(pid
>> 2239): PCI channel offline, stop waiting for PCI
>> [ 85.863494] mlx5_core 0004:01:00.1: mlx5_health_try_recover:338:(pid
>> 2239): health recovery flow aborted, PCI reads still not working
>> [ 85.873231] mlx5_core 0004:01:00.1: mlx5_pci_err_detected Device
>> state = 2 pci_status: 0. Exit, result = 3, need reset
>> [ 85.879899] mlx5_core 0004:01:00.1: E-Switch: Unload vfs:
>> mode(LEGACY), nvfs(0), neovfs(0), active vports(0)
>> [ 85.921428] mlx5_core 0004:01:00.1: E-Switch: Disable: mode(LEGACY),
>> nvfs(0), neovfs(0), active vports(0)
>> [ 85.930491] mlx5_core 0004:01:00.1: mlx5_wait_for_pages:786:(pid
>> 1617): Skipping wait for vf pages stage
>> [ 85.940849] mlx5_core 0004:01:00.1: mlx5_wait_for_pages:786:(pid
>> 1617): Skipping wait for vf pages stage
>> [ 85.949971] mlx5_core 0004:01:00.1: mlx5_uninit_one:1528:(pid 1617):
>> mlx5_uninit_one: interface is down, NOP
>> [ 85.959944] mlx5_core 0004:01:00.1: E-Switch: cleanup
>> [ 86.035541] mlx5_core 0004:01:00.0: E-Switch: Unload vfs:
>> mode(LEGACY), nvfs(0), neovfs(0), active vports(0)
>> [ 86.077568] mlx5_core 0004:01:00.0: E-Switch: Disable: mode(LEGACY),
>> nvfs(0), neovfs(0), active vports(0)
>> [ 86.071727] mlx5_core 0004:01:00.0: mlx5_wait_for_pages:786:(pid
>> 1617): Skipping wait for vf pages stage
>> [ 86.096577] mlx5_core 0004:01:00.0: mlx5_wait_for_pages:786:(pid
>> 1617): Skipping wait for vf pages stage
>> [ 86.106909] mlx5_core 0004:01:00.0: mlx5_uninit_one:1528:(pid 1617):
>> mlx5_uninit_one: interface is down, NOP
>> [ 86.115940] pcieport 0004:00:00.0: AER: subordinate device reset failed
>> [ 86.122557] pcieport 0004:00:00.0: AER: device recovery failed
>> [ 86.128571] mlx5_core 0004:01:00.0: E-Switch: cleanup
>>
>> I added some prints and found that:
>>   - ConnectX-5 requires >5s for full recovery
>>   - ConnectX-7 requires >6s for full recovery
>>
>> Setting timeout to 7s covers both devices with safety margin.
> 
> 
> Instead of updating the recovery time, can you check why your device
> recovery takes
> such a long time and how to fix it from the device end?
> 
Hi, Sathyanarayanan.

Thanks for the valuable feedback and suggestions.

I fully agree that ideally the root cause should be addressed on the
device side to reduce the DPC recovery latency, and that waiting longer
in the kernel is not a perfect solution.

However, the current 4 seconds timeout in pci_dpc_recovered() is indeed
an empirical value rather than a hard requirement from the PCIe
specification. In real-world scenarios, like with Mellanox ConnectX-5/7
adapters, we've observed that full DPC recovery can take more than 5-6
seconds, which leads to premature hotplug processing and device removal.

To improve robustness and maintain flexibility, I’m considering
introducing a module parameter to allow tuning the DPC recovery timeout
dynamically. Would you like me to prepare and submit such a patch for
review?


Best regards,
Hongbo Yao


> 
>> Signed-off-by: Hongbo Yao <andy.xu@hj-micro.com>
>> ---
>>   drivers/pci/pcie/dpc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>> index fc18349614d7..35a37fd86dcd 100644
>> --- a/drivers/pci/pcie/dpc.c
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -118,10 +118,10 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
>>       /*
>>        * Need a timeout in case DPC never completes due to failure of
>>        * dpc_wait_rp_inactive().  The spec doesn't mandate a time limit,
>> -     * but reports indicate that DPC completes within 4 seconds.
>> +     * but reports indicate that DPC completes within 7 seconds.
>>        */
>>       wait_event_timeout(dpc_completed_waitqueue, dpc_completed(pdev),
>> -               msecs_to_jiffies(4000));
>> +               msecs_to_jiffies(7000));
>>         return test_and_clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
>>   }
> 


