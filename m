Return-Path: <linux-pci+bounces-4023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 025FD867AA0
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 16:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C491F22727
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 15:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9625412BF01;
	Mon, 26 Feb 2024 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rt1Spkys"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844431BDDC;
	Mon, 26 Feb 2024 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962369; cv=none; b=JYqr8yW+unY3TWueUJwKR4fNg+qeCfVBcTwiFif8g+Qz+EcgA2zBfcv2WTYtUTkvo6BDpu64Aw6EC8GV5yAWr57jmPDfVVxq77fHH17pR3lIXVsZAJtSujKA6Mr+Bg+ZOFIp78rt6BuxW5flVtIm2tgC4882SBVia4y+XCREHs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962369; c=relaxed/simple;
	bh=UsqyRMSqElQb29ybk/PYbZx8lzm8g++czw/Vi6K81ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RdeMxjMH9oaLsSVZ4lmDjiCBSjJIWpz9eRz4UNXL3C0++K7Gaq1a4JwILz07aXSYGE6o3HMWs3wxqG7dRFMcbrWopOcGx/2j39RgE0xW8Yn9gcYhSX00J5C3Gsxo8Dfb3CqBTkBpJqlrKlQTVrNXk/qpOM57SPIJmXNsSry2WAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rt1Spkys; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708962368; x=1740498368;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UsqyRMSqElQb29ybk/PYbZx8lzm8g++czw/Vi6K81ck=;
  b=Rt1SpkysvqHPaquNJcmn9Bzgh4WHgKNV571QfjhngHfmlWwuqzZlYAfN
   peB0WtoeFTc48XE3Z9lZ2Rz2Zt9xfXHpqslaXsrSrGTr5gXML8K4zdlwK
   M25x2qmfjNYoL9jUpLc+q3I7fOEyOMmLaCcbF2n3o+D5yBTyVrPicf1Yr
   0au3IVAwKIfRqo8DOUH8qJTvR0zAqD4ZZE/MS3NSL+hYYssfQt57TDAI2
   1KhnMTIJTIUufJMjdX/MHFdVspEMryHCizuj783q2u9BUMlLtkhk1EW1/
   8yLwjV6MoVsCr1TCVC+gHsMv+nwJBvtxs3lnZcXOtubxPKGAcLbs/9ASN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="6200753"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6200753"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 07:46:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6695740"
Received: from tvereenx-mobl.amr.corp.intel.com (HELO [10.251.5.170]) ([10.251.5.170])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 07:46:06 -0800
Message-ID: <dfc9692b-1a9a-4d53-9e3e-33b2e88d0d37@linux.intel.com>
Date: Mon, 26 Feb 2024 07:46:05 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] PCI/DPC: Request DPC only if also requesting AER
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthew W Carlis <mattc@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Lukas Wunner <lukas@wunner.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org
References: <20240226151805.GA200026@bhelgaas>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240226151805.GA200026@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/26/24 7:18 AM, Bjorn Helgaas wrote:
> On Sun, Feb 25, 2024 at 11:46:07AM -0800, Kuppuswamy Sathyanarayanan wrote:
>> On 2/22/24 2:15 PM, Bjorn Helgaas wrote:
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
>> IIUC, this dependency is discussed in sec 4.5.2.4. "Dependencies
>> Between _OSC Control Bits".
>>
>> Because handling of Downstream Port Containment has a dependency on
>> Advanced Error Reporting, the operating system is required to
>> request control over Advanced Error Reporting (bit 3 of the Control
>> field) while requesting control over Downstream Port Containment
>> Configuration (bit 7 of the Control field). If the operating system
>> attempts to claim control of Downstream Port Containment
>> Configuration without also claiming control over Advanced Error
>> Reporting, firmware is required to refuse control of the feature
>> being illegally claimed and mask the corresponding bit.  Firmware is
>> required to maintain ownership of Advanced Error Reporting if it
>> retains ownership of Downstream Port Containment Configuration.  If
>> the operating system sets bit 7 of the Control field, it must set
>> bit 7 of the Support field, indicating support for the Error
>> Disconnect Recover event.
> So I guess you're suggesting that there are two defects here?
>
>   1) Linux requested DPC control without requesting AER control.
>
>   2) Platform granted DPC control when it shouldn't have.
>
> I do agree with that, but obviously we can only fix 1) in Linux.

Sorry, maybe my comment was not clear. I was just suggesting
to change the  spec reference from r3.3, sec 4.5.1, table 4-5
to  r3.3, sec 4.5.2.4 "Dependencies Between _OSC Control Bits". I agree that we cannot do much if firmware misbehaves here.

>>> Request DPC control only if we have also requested AER control.
>>>
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
>> Code wise it looks fine to me.
>>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>  drivers/acpi/pci_root.c | 20 +++++++++++---------
>>>  1 file changed, 11 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>>> index 58b89b8d950e..efc292b6214e 100644
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
>>> +		 * OSC_PCI_EXPRESS_AER_CONTROL.
>>> +		 */
>>> +		if (IS_ENABLED(CONFIG_PCIE_DPC))
>>> +			control |= OSC_PCI_EXPRESS_DPC_CONTROL;
>>> +	}
>>>  
>>>  	return control;
>>>  }
>> -- 
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer
>>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


