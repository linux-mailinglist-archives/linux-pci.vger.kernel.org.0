Return-Path: <linux-pci+bounces-31630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55798AFB983
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 19:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42BFC189078E
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 17:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8666422A4D5;
	Mon,  7 Jul 2025 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrCYAXbr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790082E7F34;
	Mon,  7 Jul 2025 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907872; cv=none; b=ohvsCLnfD2owBvyR3oYy8QH7Sw6hD/a2hk8NqBGIuWd2npix9RhOG4aAjDtkvzXx8C7WnDX/1ca0npeUoOI2J5TgmqIAjhTXFO9by/+/mt45x4Ohbk43ms8oLiYx+SWbbt2ht14EfY2wm/WU2Auc4Ftt/qJpD+uEabSOQw+kLSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907872; c=relaxed/simple;
	bh=GYasa85fPolMC5UzEKuJVy95/AUHLQ33xNjfnyH420Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBaa5QZVbUrV2yg4khJV8kDSwnFcQHDhjYn2s9u8WkXFHxxtfBKZNolt/RAp8NcP1O7RXCFtkId31vJIziwzSO+wJqarEwpdReBAkd7Qm4E+XtXCSlg07cdCPpnf3Qe3DBtXvn2XWV/JZi/d5O6O+jnuzNaSxxsJymBo80o1Iuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrCYAXbr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751907871; x=1783443871;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GYasa85fPolMC5UzEKuJVy95/AUHLQ33xNjfnyH420Y=;
  b=HrCYAXbrwSxcGCPlB30c6UZ/rUm6CPqFmjIz1aoE/pZNIMwyVBmx5Oq1
   oaK3+9jm0bgQaKMoB5uoUxsOcWb/Xhl6YtI95rLsQQcudIHzlrKhe4KIB
   9cK1a3Z0Al+tHu6+tLaRCMEAyxtqepCMKvk8EKWV8gxqSAD79gJmtJQQH
   IHtnjIJQWZMzDsOBc5yJ2lGzcHomsbs1Xkjl5SSKdc1SD/w1jmsEER5In
   N9132JzHng/VCDmYdKJfZvl/hfMilIzweIYITW/uJjxM4XzE/GJkW8Ij2
   /ZVeXDKf9ZVF6QFKxLVJ+g0RaJenfMUw9HDEQpFIAL9yswre/4/p3i7/D
   A==;
X-CSE-ConnectionGUID: HQRarHaJQsenXROFHQ4ZRQ==
X-CSE-MsgGUID: EqKrrB6/QMqeHpYF2Hm5aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57805393"
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="57805393"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 10:04:30 -0700
X-CSE-ConnectionGUID: Fvi+HKuGSgOXnCOOEPDJzA==
X-CSE-MsgGUID: dNQKkJ3nRxSzE1gFhniEGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="186287216"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 10:04:30 -0700
Received: from [10.124.220.149] (unknown [10.124.220.149])
	by linux.intel.com (Postfix) with ESMTP id 332B320B571C;
	Mon,  7 Jul 2025 10:04:29 -0700 (PDT)
Message-ID: <24dfe8e2-e4b3-40e9-b9ac-026e057abd30@linux.intel.com>
Date: Mon, 7 Jul 2025 10:04:28 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/DPC: Extend DPC recovery timeout
To: Andy Xu <andy.xu@hj-micro.com>, bhelgaas@google.com, lukas@wunner.de
Cc: mahesh@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, jemma.zhang@hj-micro.com, peter.du@hj-micro.com
References: <20250707103014.1279262-1-andy.xu@hj-micro.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250707103014.1279262-1-andy.xu@hj-micro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/7/25 3:30 AM, Andy Xu wrote:
> From: Hongbo Yao <andy.xu@hj-micro.com>
>
> Extend the DPC recovery timeout from 4 seconds to 7 seconds to
> support Mellanox ConnectX series network adapters.
>
> My environment:
>    - Platform: arm64 N2 based server
>    - Endpoint1: Mellanox Technologies MT27800 Family [ConnectX-5]
>    - Endpoint2: Mellanox Technologies MT2910 Family [ConnectX-7]
>
> With the original 4s timeout, hotplug would still be triggered:
>
> [ 81.012463] pcieport 0004:00:00.0: DPC: containment event, status:0x1f01 source:0x0000
> [ 81.014536] pcieport 0004:00:00.0: DPC: unmasked uncorrectable error detected
> [ 81.029598] pcieport 0004:00:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver ID)
> [ 81.040830] pcieport 0004:00:00.0: device [0823:0110] error status/mask=00008000/04d40000
> [ 81.049870] pcieport 0004:00:00.0: [ 0] ERCR (First)
> [ 81.053520] pcieport 0004:00:00.0: AER: TLP Header: 60008010 010000ff 00001000 9c4c0000
> [ 81.065793] mlx5_core 0004:01:00.0: mlx5_pci_err_detected Device state = 1 health sensors: 1 pci_status: 1. Enter, pci channel state = 2
> [ 81.076183] mlx5_core 0004:01:00.0: mlx5_error_sw_reset:231:(pid 1618): start
> [ 81.083307] mlx5_core 0004:01:00.0: mlx5_error_sw_reset:252:(pid 1618): PCI channel offline, stop waiting for NIC IFC
> [ 81.077428] mlx5_core 0004:01:00.0: E-Switch: Disable: mode(LEGACY), nvfs(0), neovfs(0), active vports(0)
> [ 81.486693] mlx5_core 0004:01:00.0: mlx5_wait_for_pages:786:(pid 1618): Skipping wait for vf pages stage
> [ 81.496965] mlx5_core 0004:01:00.0: mlx5_wait_for_pages:786:(pid 1618): Skipping wait for vf pages stage
> [ 82.395040] mlx5_core 0004:01:00.1: print_health:819:(pid 0): Fatal error detected
> [ 82.395493] mlx5_core 0004:01:00.1: print_health_info:423:(pid 0): PCI slot 1 is unavailable
> [ 83.431094] mlx5_core 0004:01:00.0: mlx5_pci_err_detected Device state = 2 pci_status: 0. Exit, result = 3, need reset
> [ 83.442100] mlx5_core 0004:01:00.1: mlx5_pci_err_detected Device state = 2 health sensors: 1 pci_status: 1. Enter, pci channel state = 2
> [ 83.441801] mlx5_core 0004:01:00.0: mlx5_crdump_collect:50:(pid 2239): crdump: failed to lock gw status -13
> [ 83.454050] mlx5_core 0004:01:00.1: mlx5_error_sw_reset:231:(pid 1618): start
> [ 83.454050] mlx5_core 0004:01:00.1: mlx5_error_sw_reset:252:(pid 1618): PCI channel offline, stop waiting for NIC IFC
> [ 83.849429] mlx5_core 0004:01:00.1: E-Switch: Disable: mode(LEGACY), nvfs(0), neovfs(0), active vports(0)
> [ 83.858892] mlx5_core 0004:01:00.1: mlx5_wait_for_pages:786:(pid 1618): Skipping wait for vf pages stage
> [ 83.869464] mlx5_core 0004:01:00.1: mlx5_wait_for_pages:786:(pid 1618): Skipping wait for vf pages stage
> [ 85.201433] pcieport 0004:00:00.0: pciehp: Slot(41): Link Down
> [ 85.815016] mlx5_core 0004:01:00.1: mlx5_health_try_recover:335:(pid 2239): handling bad device here
> [ 85.824164] mlx5_core 0004:01:00.1: mlx5_error_sw_reset:231:(pid 2239): start
> [ 85.831283] mlx5_core 0004:01:00.1: mlx5_error_sw_reset:252:(pid 2239): PCI channel offline, stop waiting for NIC IFC
> [ 85.841899] mlx5_core 0004:01:00.1: mlx5_unload_one_dev_locked:1612:(pid 2239): mlx5_unload_one_dev_locked: interface is down, NOP
> [ 85.853799] mlx5_core 0004:01:00.1: mlx5_health_wait_pci_up:325:(pid 2239): PCI channel offline, stop waiting for PCI
> [ 85.863494] mlx5_core 0004:01:00.1: mlx5_health_try_recover:338:(pid 2239): health recovery flow aborted, PCI reads still not working
> [ 85.873231] mlx5_core 0004:01:00.1: mlx5_pci_err_detected Device state = 2 pci_status: 0. Exit, result = 3, need reset
> [ 85.879899] mlx5_core 0004:01:00.1: E-Switch: Unload vfs: mode(LEGACY), nvfs(0), neovfs(0), active vports(0)
> [ 85.921428] mlx5_core 0004:01:00.1: E-Switch: Disable: mode(LEGACY), nvfs(0), neovfs(0), active vports(0)
> [ 85.930491] mlx5_core 0004:01:00.1: mlx5_wait_for_pages:786:(pid 1617): Skipping wait for vf pages stage
> [ 85.940849] mlx5_core 0004:01:00.1: mlx5_wait_for_pages:786:(pid 1617): Skipping wait for vf pages stage
> [ 85.949971] mlx5_core 0004:01:00.1: mlx5_uninit_one:1528:(pid 1617): mlx5_uninit_one: interface is down, NOP
> [ 85.959944] mlx5_core 0004:01:00.1: E-Switch: cleanup
> [ 86.035541] mlx5_core 0004:01:00.0: E-Switch: Unload vfs: mode(LEGACY), nvfs(0), neovfs(0), active vports(0)
> [ 86.077568] mlx5_core 0004:01:00.0: E-Switch: Disable: mode(LEGACY), nvfs(0), neovfs(0), active vports(0)
> [ 86.071727] mlx5_core 0004:01:00.0: mlx5_wait_for_pages:786:(pid 1617): Skipping wait for vf pages stage
> [ 86.096577] mlx5_core 0004:01:00.0: mlx5_wait_for_pages:786:(pid 1617): Skipping wait for vf pages stage
> [ 86.106909] mlx5_core 0004:01:00.0: mlx5_uninit_one:1528:(pid 1617): mlx5_uninit_one: interface is down, NOP
> [ 86.115940] pcieport 0004:00:00.0: AER: subordinate device reset failed
> [ 86.122557] pcieport 0004:00:00.0: AER: device recovery failed
> [ 86.128571] mlx5_core 0004:01:00.0: E-Switch: cleanup
>
> I added some prints and found that:
>   - ConnectX-5 requires >5s for full recovery
>   - ConnectX-7 requires >6s for full recovery
>
> Setting timeout to 7s covers both devices with safety margin.


Instead of updating the recovery time, can you check why your device recovery takes
such a long time and how to fix it from the device end?


> Signed-off-by: Hongbo Yao <andy.xu@hj-micro.com>
> ---
>   drivers/pci/pcie/dpc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index fc18349614d7..35a37fd86dcd 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -118,10 +118,10 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
>   	/*
>   	 * Need a timeout in case DPC never completes due to failure of
>   	 * dpc_wait_rp_inactive().  The spec doesn't mandate a time limit,
> -	 * but reports indicate that DPC completes within 4 seconds.
> +	 * but reports indicate that DPC completes within 7 seconds.
>   	 */
>   	wait_event_timeout(dpc_completed_waitqueue, dpc_completed(pdev),
> -			   msecs_to_jiffies(4000));
> +			   msecs_to_jiffies(7000));
>   
>   	return test_and_clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
>   }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


