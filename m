Return-Path: <linux-pci+bounces-33505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18066B1D0CA
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 04:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC00188A547
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 02:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09471E4AB;
	Thu,  7 Aug 2025 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMlOq1yt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D7D286A9;
	Thu,  7 Aug 2025 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754532031; cv=none; b=fNVi1E3UyzXSmM2y1r2O9y+HOuqau2k6BcsDdW2OgY9P6U0j48XDdDSqIw7CEgOq5oKae1CdZ+5C1qeHYXGZmfqIm+/PbwfFUjuXDRnwum3lB9PZCAS4eHtDj3lNEusf++UTCR4/8npyBS5vxwPn6Zn61UtJ3mNhGg6Woqu7eKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754532031; c=relaxed/simple;
	bh=nEu9rgA6GeCYi3YzHKi+ug6Nu0lKdz8H8aV7Jp+ZH1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7cFSsgCs+s8G9PlHUaoIn0arprTG2qwKj40cuxyy2mwitWDOeOMt4+XOPiEeQK7SNQKlu51Es1iTRauDH87P0JJXRwtslNmiWQ1a5szdyPglM/Lykdfi2/cBPOKWMCa2idbb5Ga4HpXQurZbjVSf+9n71uyEgGSzstq6jZzVgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMlOq1yt; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-61571192c3aso622846a12.2;
        Wed, 06 Aug 2025 19:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754532028; x=1755136828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ABRrAgyeGksuFUpWeQANtztghSDdAocaJuPB0k003W8=;
        b=WMlOq1yt9Cavb4lWrYv2ZP+mD//RAUDOuXVude9hco89E8dI8yaW7FBlbFBvaQu5Tv
         MafTv4LUrvFivP7z/WSvyz9IlU23EetcDYAnc7eo43ukdGFb7l8bQeYcBFn0mxbEqLmz
         PM3vCc7rKDqubaQJgw2PIUeA/NzsZMtjlOcz5mKgpklFHUdYTJLowYFCr2Qj9CxRsyZ2
         TBjq2NsXVsdl39ik1LbGeML6DNqpjMxg+3oYVRLOXOHIaCoEV1+aCFcc1HXhprjCxt40
         Na8Pdpt1O1pHtnjietDxPZLcfuSO6M4wzu8MfBvgldCGlIn1j5xxjUggXzaumviAFypW
         W25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754532028; x=1755136828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABRrAgyeGksuFUpWeQANtztghSDdAocaJuPB0k003W8=;
        b=oXjJEJIsX0s1CoaVlvIZvU0bXyvWLoH/btWChl14Cm7CDYTdDo+eRI1QcqfJLc12PN
         SKP6qWyXip6rlpeFTYaJ3aQuTITimgxCmzOGGvZ6s7JBkXIyWPS+wFNK/A/7Javxtckp
         UvqaRVrsDaGuymzqAApAqoX7FMP1lsbTAGvB9CgH3Ie9DLhNM4Sihw2pLc3yQWM382/i
         LMIYbN5CS3WB81+mGy8YGqxqmd/Ou8Cm+S/6WvNoGf9I+TvO4XDZ2LIGrT56m6Pqh1+d
         Os5AeNgHj5sMLj+5CckNCqT83XG7FJtLj1S9TqTlQJlje+tQQSTnCOybJ0Nc/a94hRRL
         Zj7A==
X-Forwarded-Encrypted: i=1; AJvYcCUKVSldN8cTlgDK1c8w8ldpw9E8spNchZ1GdREp7qRWnQE0xUpULOnooN5aOvBhD9IArSuKVAV3MO9k@vger.kernel.org, AJvYcCVfNlRQEsWalXY+hvqhPLgeXZJGaDi6fzocSlQlIHUDqPB7NpzpP8ZVd5RIYLZqliYkvM6X2rPJyXjbpAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSt+F+FA2Dw56r3t5qprnfmGYyCpipe8905/mG2kuoW6jv0EC9
	1Tr8exB8vrTngVaQQawviLMfT5pU5s+Llpu4kjsP0sESOuZqlLwemXeE
X-Gm-Gg: ASbGncuU4ZGqz9F4TQkL69dkhijbQBJ/waggox/sbGZ8ynty2lpFj2h+u4EJ8HEENQB
	6c8UAByw9aSp0UVUwCWOKW4DuPMoKqsMd7KjqkzFt+ISjvC3NDv06Xiv6A6gQAk+7pKfWGs1q6Q
	aaR0QYPIZeRAQHf6kdYjpo/WgN8oblApQE3V8J1HUQo4bt3XMIRVMh4PNwdUNmHD7FcOEAqT15/
	WrWbLrGnGTjvV9HpMqHEys5i/XVL9+9joOr14PHyFNx9hQlmbJ0sPQADi0wdxpESuAU7qB5lfXW
	wkChjoh6GAjf2keF+aRuLDFfy21y0NB9pDi5udKAq1v0W1MdIFTF5c3hk6opceO2DmFsbbCmhrX
	0GZ3aCW9VMQ2HZeD1lL7oevcMjGTyZaF0xTK48jAlZYzVYbobFguVH5sNxrkYvpOz2pnw+uLASh
	f49Cj1Xzn/ha37PnxrbWegrpJCSF4=
X-Google-Smtp-Source: AGHT+IEnSbQ9l5AyMsBRP/idqZTwghLbST+oqy4zLw7snINhb9wyCkI1OH6xs/LXOrnsd8nZVwfUhw==
X-Received: by 2002:a17:907:6d19:b0:af2:9a9d:2857 with SMTP id a640c23a62f3a-af992a344b7mr441804666b.3.1754532027835;
        Wed, 06 Aug 2025 19:00:27 -0700 (PDT)
Received: from [26.26.26.1] (95.112.207.35.bc.googleusercontent.com. [35.207.112.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0766f9sm1235552766b.24.2025.08.06.19.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 19:00:27 -0700 (PDT)
Message-ID: <43b6812c-4f00-48c2-a917-a3e25911c11c@gmail.com>
Date: Thu, 7 Aug 2025 10:00:21 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/DPC: Extend DPC recovery timeout
To: Hongbo Yao <andy.xu@hj-micro.com>,
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 bhelgaas@google.com, lukas@wunner.de
Cc: mahesh@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, jemma.zhang@hj-micro.com, peter.du@hj-micro.com
References: <20250707103014.1279262-1-andy.xu@hj-micro.com>
 <24dfe8e2-e4b3-40e9-b9ac-026e057abd30@linux.intel.com>
 <b9b64b4f-dcec-4ab1-b796-54d66ec91fc5@hj-micro.com>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <b9b64b4f-dcec-4ab1-b796-54d66ec91fc5@hj-micro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/11/2025 11:20 AM, Hongbo Yao wrote:
> 
> 
> 在 2025/7/8 1:04, Sathyanarayanan Kuppuswamy 写道:
>>
>> On 7/7/25 3:30 AM, Andy Xu wrote:
>>> From: Hongbo Yao <andy.xu@hj-micro.com>
>>>
>>> Extend the DPC recovery timeout from 4 seconds to 7 seconds to
>>> support Mellanox ConnectX series network adapters.
>>>
>>> My environment:
>>>     - Platform: arm64 N2 based server
>>>     - Endpoint1: Mellanox Technologies MT27800 Family [ConnectX-5]
>>>     - Endpoint2: Mellanox Technologies MT2910 Family [ConnectX-7]
>>>
>>> With the original 4s timeout, hotplug would still be triggered:
>>>
>>> [ 81.012463] pcieport 0004:00:00.0: DPC: containment event,
>>> status:0x1f01 source:0x0000
>>> [ 81.014536] pcieport 0004:00:00.0: DPC: unmasked uncorrectable error
>>> detected
>>> [ 81.029598] pcieport 0004:00:00.0: PCIe Bus Error:
>>> severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver ID)
>>> [ 81.040830] pcieport 0004:00:00.0: device [0823:0110] error status/
>>> mask=00008000/04d40000
>>> [ 81.049870] pcieport 0004:00:00.0: [ 0] ERCR (First)
>>> [ 81.053520] pcieport 0004:00:00.0: AER: TLP Header: 60008010 010000ff
>>> 00001000 9c4c0000
>>> [ 81.065793] mlx5_core 0004:01:00.0: mlx5_pci_err_detected Device
>>> state = 1 health sensors: 1 pci_status: 1. Enter, pci channel state = 2
>>> [ 81.076183] mlx5_core 0004:01:00.0: mlx5_error_sw_reset:231:(pid
>>> 1618): start
>>> [ 81.083307] mlx5_core 0004:01:00.0: mlx5_error_sw_reset:252:(pid
>>> 1618): PCI channel offline, stop waiting for NIC IFC
>>> [ 81.077428] mlx5_core 0004:01:00.0: E-Switch: Disable: mode(LEGACY),
>>> nvfs(0), neovfs(0), active vports(0)
>>> [ 81.486693] mlx5_core 0004:01:00.0: mlx5_wait_for_pages:786:(pid
>>> 1618): Skipping wait for vf pages stage
>>> [ 81.496965] mlx5_core 0004:01:00.0: mlx5_wait_for_pages:786:(pid
>>> 1618): Skipping wait for vf pages stage
>>> [ 82.395040] mlx5_core 0004:01:00.1: print_health:819:(pid 0): Fatal
>>> error detected
>>> [ 82.395493] mlx5_core 0004:01:00.1: print_health_info:423:(pid 0):
>>> PCI slot 1 is unavailable
>>> [ 83.431094] mlx5_core 0004:01:00.0: mlx5_pci_err_detected Device
>>> state = 2 pci_status: 0. Exit, result = 3, need reset
>>> [ 83.442100] mlx5_core 0004:01:00.1: mlx5_pci_err_detected Device
>>> state = 2 health sensors: 1 pci_status: 1. Enter, pci channel state = 2
>>> [ 83.441801] mlx5_core 0004:01:00.0: mlx5_crdump_collect:50:(pid
>>> 2239): crdump: failed to lock gw status -13
>>> [ 83.454050] mlx5_core 0004:01:00.1: mlx5_error_sw_reset:231:(pid
>>> 1618): start
>>> [ 83.454050] mlx5_core 0004:01:00.1: mlx5_error_sw_reset:252:(pid
>>> 1618): PCI channel offline, stop waiting for NIC IFC
>>> [ 83.849429] mlx5_core 0004:01:00.1: E-Switch: Disable: mode(LEGACY),
>>> nvfs(0), neovfs(0), active vports(0)
>>> [ 83.858892] mlx5_core 0004:01:00.1: mlx5_wait_for_pages:786:(pid
>>> 1618): Skipping wait for vf pages stage
>>> [ 83.869464] mlx5_core 0004:01:00.1: mlx5_wait_for_pages:786:(pid
>>> 1618): Skipping wait for vf pages stage
>>> [ 85.201433] pcieport 0004:00:00.0: pciehp: Slot(41): Link Down
>>> [ 85.815016] mlx5_core 0004:01:00.1: mlx5_health_try_recover:335:(pid
>>> 2239): handling bad device here
>>> [ 85.824164] mlx5_core 0004:01:00.1: mlx5_error_sw_reset:231:(pid
>>> 2239): start
>>> [ 85.831283] mlx5_core 0004:01:00.1: mlx5_error_sw_reset:252:(pid
>>> 2239): PCI channel offline, stop waiting for NIC IFC
>>> [ 85.841899] mlx5_core 0004:01:00.1: mlx5_unload_one_dev_locked:1612:
>>> (pid 2239): mlx5_unload_one_dev_locked: interface is down, NOP
>>> [ 85.853799] mlx5_core 0004:01:00.1: mlx5_health_wait_pci_up:325:(pid
>>> 2239): PCI channel offline, stop waiting for PCI
>>> [ 85.863494] mlx5_core 0004:01:00.1: mlx5_health_try_recover:338:(pid
>>> 2239): health recovery flow aborted, PCI reads still not working
>>> [ 85.873231] mlx5_core 0004:01:00.1: mlx5_pci_err_detected Device
>>> state = 2 pci_status: 0. Exit, result = 3, need reset
>>> [ 85.879899] mlx5_core 0004:01:00.1: E-Switch: Unload vfs:
>>> mode(LEGACY), nvfs(0), neovfs(0), active vports(0)
>>> [ 85.921428] mlx5_core 0004:01:00.1: E-Switch: Disable: mode(LEGACY),
>>> nvfs(0), neovfs(0), active vports(0)
>>> [ 85.930491] mlx5_core 0004:01:00.1: mlx5_wait_for_pages:786:(pid
>>> 1617): Skipping wait for vf pages stage
>>> [ 85.940849] mlx5_core 0004:01:00.1: mlx5_wait_for_pages:786:(pid
>>> 1617): Skipping wait for vf pages stage
>>> [ 85.949971] mlx5_core 0004:01:00.1: mlx5_uninit_one:1528:(pid 1617):
>>> mlx5_uninit_one: interface is down, NOP
>>> [ 85.959944] mlx5_core 0004:01:00.1: E-Switch: cleanup
>>> [ 86.035541] mlx5_core 0004:01:00.0: E-Switch: Unload vfs:
>>> mode(LEGACY), nvfs(0), neovfs(0), active vports(0)
>>> [ 86.077568] mlx5_core 0004:01:00.0: E-Switch: Disable: mode(LEGACY),
>>> nvfs(0), neovfs(0), active vports(0)
>>> [ 86.071727] mlx5_core 0004:01:00.0: mlx5_wait_for_pages:786:(pid
>>> 1617): Skipping wait for vf pages stage
>>> [ 86.096577] mlx5_core 0004:01:00.0: mlx5_wait_for_pages:786:(pid
>>> 1617): Skipping wait for vf pages stage
>>> [ 86.106909] mlx5_core 0004:01:00.0: mlx5_uninit_one:1528:(pid 1617):
>>> mlx5_uninit_one: interface is down, NOP
>>> [ 86.115940] pcieport 0004:00:00.0: AER: subordinate device reset failed
>>> [ 86.122557] pcieport 0004:00:00.0: AER: device recovery failed
>>> [ 86.128571] mlx5_core 0004:01:00.0: E-Switch: cleanup
>>>
>>> I added some prints and found that:
>>>    - ConnectX-5 requires >5s for full recovery
>>>    - ConnectX-7 requires >6s for full recovery
>>>
>>> Setting timeout to 7s covers both devices with safety margin.
>>
>>
>> Instead of updating the recovery time, can you check why your device
>> recovery takes
>> such a long time and how to fix it from the device end?
>>
> Hi, Sathyanarayanan.
> 
> Thanks for the valuable feedback and suggestions.
> 
> I fully agree that ideally the root cause should be addressed on the
> device side to reduce the DPC recovery latency, and that waiting longer
> in the kernel is not a perfect solution.
> 
> However, the current 4 seconds timeout in pci_dpc_recovered() is indeed
> an empirical value rather than a hard requirement from the PCIe
> specification. In real-world scenarios, like with Mellanox ConnectX-5/7
> adapters, we've observed that full DPC recovery can take more than 5-6
> seconds, which leads to premature hotplug processing and device removal.
> 
> To improve robustness and maintain flexibility, I’m considering
> introducing a module parameter to allow tuning the DPC recovery timeout
> dynamically. Would you like me to prepare and submit such a patch for
> review?
> 
What if another device just needs 7.1 seconds to recover ? revise the
timeout again ?  no spec says 4 seconds is mandated. have a kernel 
parameter to override it's default value is one choice to workaround.

Ask FW guys to fix ? what justification we have ?

Thanks,
Ethan
> 
> Best regards,
> Hongbo Yao
> 
> 
>>
>>> Signed-off-by: Hongbo Yao <andy.xu@hj-micro.com>
>>> ---
>>>    drivers/pci/pcie/dpc.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>>> index fc18349614d7..35a37fd86dcd 100644
>>> --- a/drivers/pci/pcie/dpc.c
>>> +++ b/drivers/pci/pcie/dpc.c
>>> @@ -118,10 +118,10 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
>>>        /*
>>>         * Need a timeout in case DPC never completes due to failure of
>>>         * dpc_wait_rp_inactive().  The spec doesn't mandate a time limit,
>>> -     * but reports indicate that DPC completes within 4 seconds.
>>> +     * but reports indicate that DPC completes within 7 seconds.
>>>         */
>>>        wait_event_timeout(dpc_completed_waitqueue, dpc_completed(pdev),
>>> -               msecs_to_jiffies(4000));
>>> +               msecs_to_jiffies(7000));
>>>          return test_and_clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
>>>    }
>>
> 
> 


