Return-Path: <linux-pci+bounces-186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED94E7FA775
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 18:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970A7281711
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 17:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDBD34CDE;
	Mon, 27 Nov 2023 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JmLF1v+e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A8B30C7;
	Mon, 27 Nov 2023 09:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701104703; x=1732640703;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q0Cs8/Z2gWXTtybRmRR8o0521aCJxHfPoBNVT4y79Tk=;
  b=JmLF1v+eyK3sPnlZoX7bUa6eSIgALzI9incLDzP8xeTG+RoJEnpdPa1+
   Hl/JPJ75eSDGCXPY0pxw4ArKftDZrhVplPcU/7C6pcWKXSU9sEN118+fw
   I7DiRNZvS0qrZjui8t38o2RgHRocVTpq/rqRTnbbirBKa0I9MJJyJZ7Ui
   Hxbi0n7ZkZxYrJUM8MV343rvht37ASx1MkRD3k+A9grSBksuySio3rkhn
   tg4xUfNGcbN6IzQCMP24nArp+8TMfxtrxK06TbU8QWagrKltj/IzYTukl
   rlNcZJ4O367ahRUjLpYr7De0C8V4bYTNRI/LKKhjTjzPCg+a/4LXIu3lT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="392495108"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="392495108"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 09:05:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="771998345"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="771998345"
Received: from thomasob-mobl3.amr.corp.intel.com (HELO [10.255.231.114]) ([10.255.231.114])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 09:05:02 -0800
Message-ID: <beb0b52d-7136-43b2-a4d0-ce7114c772e4@linux.intel.com>
Date: Mon, 27 Nov 2023 09:05:02 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Race b/w pciehp and FirmwareFirst DPC->EDR flow - Reg
Content-Language: en-US
To: Vidya Sagar <vidyas@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>
Cc: Vikram Sethi <vsethi@nvidia.com>, Krishna Thota <kthota@nvidia.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 sagar.tv@gmail.com
References: <BN8PR12MB290002441CA3C24D1FA742D2B8AEA@BN8PR12MB2900.namprd12.prod.outlook.com>
 <529acc15-1932-4785-9edf-c5327db64ab1@nvidia.com>
 <a73a2156-124b-47f7-b545-6751f6e87d54@nvidia.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <a73a2156-124b-47f7-b545-6751f6e87d54@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/27/2023 6:43 AM, Vidya Sagar wrote:
> Hi Bjorn and others,
> Could you please share your thoughts on this?
> 
> Thanks,
> Vidya Sagar
> 
> On 11/10/2023 10:31 PM, Vidya Sagar wrote:
>> There was a typo. Corrected it.
>>
>> s/If DPC->EDR flow checks DPC also/If DPC->EDR flow checks 'PD Change' also
>>
>> On 11/10/2023 6:30 PM, Vidya Sagar wrote:
>>> Hi folks,
>>> Here are the platform details.
>>> - System with a Firmware First approach for both AER and DPC
>>> - CPERs are sent to the OS for the AER events
>>> - DPC is notified to the OS through EDR mechanism
>>> - System doesn't have support for in-band PD and supports only OOB PD where writing to a private register would set the PD state
>>> - System has this design where PD state gets cleared whenever there is a link down (without even writing to the private register)
>>>

Is clearing the PD state when link goes down normal? Is this a bug in the hardware?

>>> In this system, if the root port has to experience a DPC because of any right reasons (say SW trigger of DPC for time being), I'm observing the following flow which is causing a race.
>>> 1. Since DPC brings the link down, there is a DLLSC and an MSI is sent to the OS hence PCIe HP ISR is invoked.
>>> 2. ISR then takes stock of the Slot_Status register to see what all events caused the MSI generation.
>>> 3. It sees both DLLSC and PDC bits getting set.
>>> 4. PDC is set because of the aforementioned hardware design where for every link down, PD state gets cleared and since this is considered as a change in the PD state, PDC also gets set.
>>> 5. PCIe HP ISR flow transitions to the PCIe HP IST (interrupt thread/bottom half) and waits for the DPC_EDR to complete (because DLLSC is one of the events)
>>> 6. Parallel to the PCIe HP ISR/IST, DPC interrupt is raised to the firmware and that would then send an EDR event to the OS. Firmware also sets the PD state to '1' before that, as the endpoint device is still available.
>>> 7. Firmware programming of the private register to set the PD state raises second interrupt and PCIe HP ISR takes stock of the events and this time it is only the PDC and not DLLSC. ISR sends a wake to the IST, but since there is an IST in progress already, nothing much happens at this point.
>>> 8. Once the DPC is completed and link comes back up again, DPC framework asks the endpoint drivers to handle it by calling the 'pci_error_handlers' callabacks registered by the endpoint device drivers.
>>> 9. The PCIe HP IST (of the very first MSI) resumes after receiving the completion from the DPC framework saying that DPC recovery is successful.
>>> 10. Since PDC (Presence Detect Change) bit is also set for the first interrupt, IST attempts to remove the devices (as part of pciehp_handle_presence_or_link_change())
>>>
>>> At this point, there is a race between the device driver that is trying to work with the device (through pci_error_handlers callback) and the IST that is trying to remove the device.

IIUC, this step is after DPC recovery, which means the device is up and error_handlers are not used anymore, right? Why do you say there is a race between IST and error handler?

>>> To be fair to pciehp_handle_presence_or_link_change(), after removing the devices, it checks for the link-up/PD being '1' and scans the devices again if the device is still available. But unfortunately, IST is deadlocked (with the device driver) while removing the devices itself and won't go to the next step.
>>>
>>> The rationale given in the form of a comment in pciehp_handle_presence_or_link_change() for removing the devices first (without checking PD/link-up) and adding them back after checking link-up/PD is that, since there is a change in PD, the new link-up need not be with the same old device rather it could be with a different device. So, it justifies in removing the existing devices and then scanning for new ones. But this is causing deadlock with the already initiated DPC recovery process.
>>>
>>> I see two ways to avoid the deadlock in this scenario.
>>> 1. When PCIe HP IST is looking at both DLLSC and PDC, why should DPC->EDR flow look at only DLLSC and not DPC? If DPC->EDR flow checks 'PD Change' also (along with DLL) and declares that the DPC recovery can't happen (as there could be a change of device) hence returning DPC recovery failure, then, the device driver's pci_error_handlers callbacks won't be called and there won't be any deadlock.
>>> 2. Check for the possibility of a common lock so that PCIe HP IST and device driver's pci_error_handlers callbacks don't race.
>>>
>>> Let me know your comments on this.
>>>
>>> Thanks,
>>> Vidya Sagar

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

