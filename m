Return-Path: <linux-pci+bounces-6978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AA28B918A
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 00:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF1F285446
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 22:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C113165FBF;
	Wed,  1 May 2024 22:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YP1XcFam"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536761649A8;
	Wed,  1 May 2024 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714601263; cv=none; b=n3tNIQREqL7+L+ab1moNWvpddBztK6x4eofRP4uJ0qDdWr5A++6hVavptd0ruDiBRCbEFu0GGHpyFL9zyZMKPBNmHp5KBJRK3qrk/3Aho48kHhh9GwhZiv82q9Msm+tfOk1IkN+vt8Wp/imclq9LKXIlQJ3A/gWMh4Ti/tWXdlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714601263; c=relaxed/simple;
	bh=SlBQ+fw5MzFKBS2OWIQSolGLFOpblAAXYbWwBv6gOjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVVEwDzZo4G958FGUqMr/Uw3ei7MQUJaIT3ZiSc3j8f3YXRn0iUeNzIoMfaVVCCnXAxN8QzwMBZGlJC/ly2QINhYdimMJfzNlpwQKe1iqTzEzWDIkKqY3sD9kPiHgFN81CUKde874IIW90xrCe3PEAVkiOD4s5cAM9ykLkmWK10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YP1XcFam; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714601261; x=1746137261;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SlBQ+fw5MzFKBS2OWIQSolGLFOpblAAXYbWwBv6gOjA=;
  b=YP1XcFamnMQRkvrgaAhJSvec6QA52UWqQovH3G7FHDpmF7mgH+UE4bax
   VJmLN76Cm6pelfcz5jQhAWxm4qsHMOnjblwwatGiJhUP40MMJ2nJ0fWTb
   /kHGukrdiyLoZNJGXRLcu7Kc7nD9SkbIS+S//E9jSga/vBiKvrmppcvZm
   8vlkFu1U4tUu+8npDOMCFL2Bf+eFQt6WjyldS/VOB7FNXglQpb0M79N2s
   RpsS2oYRq6QSqzuuYulDT24f45ydOkydfS9MJFF1Bf3yxD9JxPRYvGPZP
   BRW9Ku9X+u0nTNblgHDrNcFYeG9VHhn51Vq53KT8RsdbLC9h2Im5spWKM
   w==;
X-CSE-ConnectionGUID: d2dm6SERTgqBSEfUjtBShg==
X-CSE-MsgGUID: r6hsyex0RaOXe7A17CcuXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="14158558"
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="14158558"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 15:07:40 -0700
X-CSE-ConnectionGUID: COJ9DY6TS5muhgObgsrxPw==
X-CSE-MsgGUID: WwXc4/QASHCU83SdC7lXrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="27025929"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.221.178]) ([10.124.221.178])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 15:07:40 -0700
Message-ID: <1b54ca20-5dce-4257-bc3f-38e3106b6746@linux.intel.com>
Date: Wed, 1 May 2024 15:07:39 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI/EDR: Align EDR implementation with PCI firmware
 r3.3 spec
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Thatchanamurthy Satish <Satish.Thatchanamurt@dell.com>,
 Tushar Dave <tdave@nvidia.com>
References: <20240501215009.GA1497134@bhelgaas>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240501215009.GA1497134@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/1/24 2:50 PM, Bjorn Helgaas wrote:
> On Wed, May 01, 2024 at 02:25:43AM +0000, Kuppuswamy Sathyanarayanan wrote:
>> During the Error Disconnect Recover (EDR) spec transition from r3.2 ECN
>> to PCI firmware spec r3.3, improvements were made to definitions of
>> EDR_PORT_DPC_ENABLE_DSM (0x0C) and EDR_PORT_LOCATE_DSM(0x0D) _DSMs.
>>
>> Specifically,
>>
>> * EDR_PORT_DPC_ENABLE_DSM _DSM version changed from 5 to 6, and
>>   arg4 is now a package type instead of an integer in version 5.
>> * EDR_PORT_LOCATE_DSM _DSM uses BIT(31) to return the status of the
>>   operation.
>>
>> Ensure _DSM implementation aligns with PCI firmware r3.3 spec
>> recommendation. More details about the EDR_PORT_DPC_ENABLE_DSM and
>> EDR_PORT_LOCATE_DSM _DSMs can be found in PCI firmware specification,
>> r3.3, sec 4.6.12 and sec 4.6.13.
>>
>> While at it, fix a typo in EDR_PORT_LOCATE_DSM comments.
>>
>> Fixes: ac1c8e35a326 ("PCI/DPC: Add Error Disconnect Recover (EDR) support")
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>  drivers/pci/pcie/edr.c | 23 +++++++++++++++++------
>>  1 file changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
>> index 5f4914d313a1..fea098e22e3e 100644
>> --- a/drivers/pci/pcie/edr.c
>> +++ b/drivers/pci/pcie/edr.c
>> @@ -35,7 +35,7 @@ static int acpi_enable_dpc(struct pci_dev *pdev)
>>  	 * Behavior when calling unsupported _DSM functions is undefined,
>>  	 * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
>>  	 */
>> -	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
>> +	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 6,
>>  			    1ULL << EDR_PORT_DPC_ENABLE_DSM))
> How confident are we that this won't break any existing platforms?

Since we are already using arg4 as package, it wont work with
platforms that implement version 5.  So I think we won't be
breaking any existing users of version 5.


> Any idea how many platforms implement EDR_PORT_DPC_ENABLE_DSM and what
> Revision IDs they support?

I am not very sure about it. I think it is being used in some Dell
and Nvidia platforms.

@Satish from Dell, tested this fix in some Dell server platforms
that implements this support and found it working.

@Tushar Dave, since you previously submitted some error report
related to EDR, I assume you have some platforms that uses these
_DSMs. Can you please take a look at this patch and let us know
whether it works for you?

>
>>  		return 0;
>>  
>> @@ -47,11 +47,11 @@ static int acpi_enable_dpc(struct pci_dev *pdev)
>>  	argv4.package.elements = &req;
>>  
>>  	/*
>> -	 * Per Downstream Port Containment Related Enhancements ECN to PCI
>> -	 * Firmware Specification r3.2, sec 4.6.12, EDR_PORT_DPC_ENABLE_DSM is
>> -	 * optional.  Return success if it's not implemented.
>> +	 * Per PCI Firmware Specification r3.3, sec 4.6.12,
>> +	 * EDR_PORT_DPC_ENABLE_DSM is optional. Return success if it's not
>> +	 * implemented.
>>  	 */
>> -	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
>> +	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 6,
>>  				EDR_PORT_DPC_ENABLE_DSM, &argv4);
>>  	if (!obj)
>>  		return 0;
>> @@ -86,7 +86,7 @@ static struct pci_dev *acpi_dpc_port_get(struct pci_dev *pdev)
>>  
>>  	/*
>>  	 * Behavior when calling unsupported _DSM functions is undefined,
>> -	 * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
>> +	 * so check whether EDR_PORT_LOCATE_DSM is supported.
>>  	 */
>>  	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
>>  			    1ULL << EDR_PORT_LOCATE_DSM))
>> @@ -103,6 +103,17 @@ static struct pci_dev *acpi_dpc_port_get(struct pci_dev *pdev)
>>  		return NULL;
>>  	}
>>  
>> +	/*
>> +	 * Per PCI Firmware Specification r3.3, sec 4.6.13, bit 31 represents
>> +	 * the success/failure of the operation. If bit 31 is set, the operation
>> +	 * is failed.
>> +	 */
>> +	if (obj->integer.value & BIT(31)) {
>> +		ACPI_FREE(obj);
>> +		pci_err(pdev, "Locate Port _DSM failed\n");
>> +		return NULL;
>> +	}
> This changes two _DSMs, and I think it should be two patches.

Ok. I can split it into two patches.

> Same question here: we now depend on functionality we didn't depend on
> before.  How confident are we in this?

In some platforms I have tested so far, it seems to work. But I am
not sure whether there are other platforms that does not implement
this support.

IMO, since this change aligns with the spec, it is best to fix it.

>
>>  	/*
>>  	 * Firmware returns DPC port BDF details in following format:
>>  	 *	15:8 = bus
>> -- 
>> 2.25.1
>>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


