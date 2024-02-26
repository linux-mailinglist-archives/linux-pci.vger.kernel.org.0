Return-Path: <linux-pci+bounces-4034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AF5867C8D
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 17:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5149B29613B
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 16:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9304E12D77C;
	Mon, 26 Feb 2024 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/S6xSlO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7008D12C55E;
	Mon, 26 Feb 2024 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966218; cv=none; b=fyFpISKE+BPrWK8KYzd3PEaTl5mIE5DWL7X87UAqbImAE/2pYRHct7aCTEgpEmqkQ2cmOsf6WQl1H4Gw5VgnZh2d78QpA5/UZpWfdlGGx7mCiXaVwtnKKSXYn4hk1G/ura5Wr8da3o79f5WT0WewilRFROHk+iQ2SVUkjZnJZEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966218; c=relaxed/simple;
	bh=7YvuyP2/3dQMz06f8V/sENTfum4SLtdXfnyglIOEK08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZnznCa5pTcbgVf0pH1XlsVbysNbWMY456uw/OSmdZE743VF4gxj0EPvvlBab2kNuPg1vdv0gGskyocJpDdlokMxz8ZYH7O4gLkV5hgGN+GwbRefFubdJ5JNOqIQMxAhpt/HLmPCmU02TpmNVCJYi6nfZ+WnncTBK287DzZba1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/S6xSlO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708966217; x=1740502217;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7YvuyP2/3dQMz06f8V/sENTfum4SLtdXfnyglIOEK08=;
  b=a/S6xSlORqGh5ZOWdQSRqjOdu6G4e0Z9QLyVLEaykGySUpqCUNNVY6O+
   ohFE048AaFFZ22IZWSiTsIO5u0c8WDvycbevbNcM52darXWxW46mnOZKu
   kOm7etZ4Gwh8V9vSHJX4IyqllQy7AhyVBpnypw4jSt4mr4PmONo/kvclt
   RDDqcvwsroFX2rgwHIoTKmEJvXVENlZGoVC6lWvpdh0kNzYTssdAT9UGC
   Qqij5I2jY5ydniaCofVVwtIax6JoNcmEjSM75xlD8IQEp3XfEJbwWVlSh
   YtPjALktfVt/xiVvPYY99p600dHbGUkhIrhg2H28FdpcQg6PXxkLHuXiL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7044878"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="7044878"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:50:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="6871348"
Received: from tvereenx-mobl.amr.corp.intel.com (HELO [10.251.5.170]) ([10.251.5.170])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:50:12 -0800
Message-ID: <d238cb35-bdf6-4f10-a729-41ef8916605f@linux.intel.com>
Date: Mon, 26 Feb 2024 08:50:11 -0800
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
References: <20240226163305.GA202015@bhelgaas>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240226163305.GA202015@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/26/24 8:33 AM, Bjorn Helgaas wrote:
> On Mon, Feb 26, 2024 at 07:46:05AM -0800, Kuppuswamy Sathyanarayanan wrote:
>> On 2/26/24 7:18 AM, Bjorn Helgaas wrote:
>>> On Sun, Feb 25, 2024 at 11:46:07AM -0800, Kuppuswamy Sathyanarayanan wrote:
>>>> On 2/22/24 2:15 PM, Bjorn Helgaas wrote:
>>>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>>>
>>>>> When booting with "pci=noaer", we don't request control of AER, but we
>>>>> previously *did* request control of DPC, as in the dmesg log attached at
>>>>> the bugzilla below:
>>>>>
>>>>>   Command line: ... pci=noaer
>>>>>   acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
>>>>>   acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR DPC]
>>>>>
>>>>> That's illegal per PCI Firmware Spec, r3.3, sec 4.5.1, table 4-5, which
>>>>> says:
>>>>>
>>>>>   If the operating system sets this bit [OSC_PCI_EXPRESS_DPC_CONTROL], it
>>>>>   must also set bit 7 of the Support field (indicating support for Error
>>>>>   Disconnect Recover notifications) and bits 3 and 4 of the Control field
>>>>>   (requesting control of PCI Express Advanced Error Reporting and the PCI
>>>>>   Express Capability Structure).
>>>> IIUC, this dependency is discussed in sec 4.5.2.4. "Dependencies
>>>> Between _OSC Control Bits".
>>>>
>>>> Because handling of Downstream Port Containment has a dependency on
>>>> Advanced Error Reporting, the operating system is required to
>>>> request control over Advanced Error Reporting (bit 3 of the Control
>>>> field) while requesting control over Downstream Port Containment
>>>> Configuration (bit 7 of the Control field). If the operating system
>>>> attempts to claim control of Downstream Port Containment
>>>> Configuration without also claiming control over Advanced Error
>>>> Reporting, firmware is required to refuse control of the feature
>>>> being illegally claimed and mask the corresponding bit.  Firmware is
>>>> required to maintain ownership of Advanced Error Reporting if it
>>>> retains ownership of Downstream Port Containment Configuration.  If
>>>> the operating system sets bit 7 of the Control field, it must set
>>>> bit 7 of the Support field, indicating support for the Error
>>>> Disconnect Recover event.
>>> So I guess you're suggesting that there are two defects here?
>>>
>>>   1) Linux requested DPC control without requesting AER control.
>>>
>>>   2) Platform granted DPC control when it shouldn't have.
>>>
>>> I do agree with that, but obviously we can only fix 1) in Linux.
>> Sorry, maybe my comment was not clear. I was just suggesting to
>> change the spec reference from r3.3, sec 4.5.1, table 4-5 to r3.3,
>> sec 4.5.2.4 "Dependencies Between _OSC Control Bits".
> The requirement that the OS request AER control whenever it requests
> DPC control is mentioned in both sec 4.5.1 and sec 4.5.2.4.  IMO sec
> 4.5.2.4 should not exist because the per-bit table in sec 4.5.1 is a
> better place for implementation guidance.  4.5.2.4 is easy to miss,
> mostly redundant, and hard to integrate with the 4.5.1 table.
>
> What advantage do you see for citing 4.5.2.4 instead of 4.5.1?  The
> only real difference I see is that it also points out a firmware
> problem.  I don't think the extra text is worth it since it doesn't
> motivate the Linux change.


My thinking is, since the fix is related to the dependency between
_OSC control bits (AER & DPC), and there is a special section in the
spec which discuss it, I thought it is better to  quote it.

But I get your point. I think either if fine.

>
> Bjorn

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


