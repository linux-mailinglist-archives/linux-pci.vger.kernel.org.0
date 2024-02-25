Return-Path: <linux-pci+bounces-3981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77924862C94
	for <lists+linux-pci@lfdr.de>; Sun, 25 Feb 2024 20:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035E11F21450
	for <lists+linux-pci@lfdr.de>; Sun, 25 Feb 2024 19:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C3318645;
	Sun, 25 Feb 2024 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkxpH8do"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29F717997;
	Sun, 25 Feb 2024 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708889629; cv=none; b=bmEvl3FO1mlvIJ1Ikbq8lLOl9STk7dgqtZOdLP197nT8xsJCt3DopsvTemfaVpwpM0bNDdTmz91mhDRwwLmYWdIydtxqI4BeiV1ZhDEFfqu/GezXsqNzKns32Mr0gkaJAOof3OUMMhxtGlguVOcLuq5gKYOuwIlD0rg7krVBVGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708889629; c=relaxed/simple;
	bh=ii9IDhIV83iifwH6mIMhAiwVq+0wGwlwsd70iKz9Gfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MDHTZ2aMuttMP8dWZTdAB54IfrDK+6sZJuqvCaKXVl3RW357CfyPeAs3d13C17t89bSrynnijgvgNMhD6pAkha1/iHL2BAMtON+FB2nCQ04+UgClL9aEdGkPHUv9y6quWaToqyCei0hw/NMU5iWaxxyB91LQFuJ1LIutG4B8gxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JkxpH8do; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708889627; x=1740425627;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ii9IDhIV83iifwH6mIMhAiwVq+0wGwlwsd70iKz9Gfo=;
  b=JkxpH8doJJpzxxmtZkGIOmd9dhbesXPaTGdekrxR49gstm1orYfIZQZo
   IG7V5hOQMzWNYZgBaDdoNUvIcrdL3EB5Qur2vIRTPfS8/8x0ERT1jNRY3
   Ab8mhVfjC7uB3FARvCFOpqyEpZ6Tdo/VAWx7NyrLK9wSmRgkrHKxw6Ion
   6w87/LGKeguNnNcoRHPOPaT5FOYZjB9UVnZ5INVExDtckqCzRQ3Cs9LS1
   Pwdz/pjShI802diNcxcHNORUATyNc7uIhrm3WIV6FC1hgwcw5TFGOTVbT
   OZgItQhq6TCoeo3b4E6X2kQSjwq26TlDmFKACGSa+IqaG1wGHL3Rois+q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3082799"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3082799"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 11:33:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6585485"
Received: from gcsargen-mobl1.amr.corp.intel.com (HELO [10.255.228.214]) ([10.255.228.214])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 11:33:45 -0800
Message-ID: <935f15e5-1d2b-4aaf-880d-00d9ba16eaaa@linux.intel.com>
Date: Sun, 25 Feb 2024 11:33:44 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/DPC: Request DPC only if also requesting AER
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org,
 Matthew W Carlis <mattc@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Lukas Wunner <lukas@wunner.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>
References: <20240221232523.GA1533169@bhelgaas>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240221232523.GA1533169@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/21/24 3:25 PM, Bjorn Helgaas wrote:
> On Tue, Feb 20, 2024 at 06:45:32PM -0800, Kuppuswamy Sathyanarayanan wrote:
>> On 2/20/24 3:55 PM, Bjorn Helgaas wrote:
>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> When booting with "pci=noaer", we don't request control of AER, but we
>>> previously *did* request control of DPC, as in the dmesg log attached at
>>> the bugzilla below:
>>>
>>>   Command line: ... pci=noaer
>>>   acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
>>>   acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR DPC]
>>>
>>> That's illegal per PCI Firmware Spec, r3.3, sec 4.5.1, table 4-5, which
>>> says:
>>>
>>>   If the operating system sets this bit [OSC_PCI_EXPRESS_DPC_CONTROL], it
>>>   must also set bit 7 of the Support field (indicating support for Error
>>>   Disconnect Recover notifications) and bits 3 and 4 of the Control field
>>>   (requesting control of PCI Express Advanced Error Reporting and the PCI
>>>   Express Capability Structure).
>>>
>>> Request DPC control only if we have also requested AER control.
>> Can you also add similar check in calculate_support call?
>>
>>         if (pci_aer_available() && IS_ENABLED(CONFIG_PCIE_EDR))
>>                 support |= OSC_PCI_EDR_SUPPORT;
> That doesn't seem right to me.  The implementation note in sec 4.6.12
> suggests that EDR Notifications may be used even when the firmware
> maintains control of AER and DPC.  Maybe that note is wrong or

It is correct. EDR notification is used when firmware retains control
of AER and DPC, but wants OS to handle the recovery action. But,
since EDR (like DPC) also touches the AER registers and depends
on OS supporting AER capability. For example, EDR driver internally
calls pci_aer_raw_clear_status(). So we need at-least ensure that AER
driver code is enabled when exposing support for EDR.

> misleading, but as written, I interpret that as meaning that it may be
> useful for the platform to know that the OS supports EDR even if it
> AER control isn't requested or granted.
>
>>> Fixes: ac1c8e35a326 ("PCI/DPC: Add Error Disconnect Recover (EDR) support")
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218491#c12
>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: <stable@vger.kernel.org>	# v5.7+
>>> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>> Cc: Matthew W Carlis <mattc@purestorage.com>
>>> Cc: Keith Busch <kbusch@kernel.org>
>>> Cc: Lukas Wunner <lukas@wunner.de>
>>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>>> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
>>> ---
>>>  drivers/acpi/pci_root.c | 20 +++++++++++---------
>>>  1 file changed, 11 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>>> index 58b89b8d950e..1c16965427b3 100644
>>> --- a/drivers/acpi/pci_root.c
>>> +++ b/drivers/acpi/pci_root.c
>>> @@ -518,17 +518,19 @@ static u32 calculate_control(void)
>>>  	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
>>>  		control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
>>>  
>>> -	if (pci_aer_available())
>>> +	if (pci_aer_available()) {
>>>  		control |= OSC_PCI_EXPRESS_AER_CONTROL;
>>>  
>>> -	/*
>>> -	 * Per the Downstream Port Containment Related Enhancements ECN to
>>> -	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
>>> -	 * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
>>> -	 * and EDR.
>>> -	 */
>>> -	if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
>>> -		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
>>> +		/*
>>> +		 * Per PCI Firmware Spec, r3.3, sec 4.5.1, table 4-5, the
>>> +		 * OS can request DPC control only if it has advertised
>>> +		 * OSC_PCI_EDR_SUPPORT and requested both
>>> +		 * OSC_PCI_EXPRESS_CAPABILITY_CONTROL and
>> I think you mean OSC_PCI_EXPRESS_DPC_CONTROL.
> No, I just tried to rephrase the text for _OSC Control, bit 7 (quoted
> in the commit log), so I think requesting control of bits 3 and 4 (AER
> and PCIe Capability) is right.
>
>>> +		 * OSC_PCI_EXPRESS_AER_CONTROL.
>>> +		 */
>>> +		if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
>>> +			control |= OSC_PCI_EXPRESS_DPC_CONTROL;
>> Since you are cleaning up this part, why not add a patch to remove
>> CONFIG_PCIE_EDR?
> Good idea, I'll do that, too.
>
> Bjorn
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


