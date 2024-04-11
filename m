Return-Path: <linux-pci+bounces-6152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C19208A1F4D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 21:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3594D1F2A0B5
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 19:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BE4205E35;
	Thu, 11 Apr 2024 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pzhs1o84"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF4FF9DF;
	Thu, 11 Apr 2024 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862969; cv=none; b=j8sD/We9w3RC7h/+utfz2uBtQLeC7LnTwTSSX3fkbaf2PDqVoCUnSWDCM87EqA08LbzKwcb/mgmAplhhN6AxGh+BWXjOvXffBUpy+HQaaKK15CkJs1AAmEaNh04pFa+3f5GXu3wG31AnlRKJF0BB8aJXjUMLHa53rgJsegLl/Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862969; c=relaxed/simple;
	bh=xwu1Lyvb4geu/kIf3urHXorMd7iumeFJO7hXvoKCOII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rP/UIa17ogKQemx4qN9ZcI64vnQrgV3BIVyP2MNaD/X23vrSL3sly8dBKT+trx3kYXP/KSAIXDNiTZXBlSbzB/1N2dMHK/pTIT/dWRxNapX+3cL0Hg7Au9rw/c8reRGo/Y+x7rfUeBJu2ZyCgN7y5yF8B1nfb4GJwbEA5Y6/arQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pzhs1o84; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712862969; x=1744398969;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xwu1Lyvb4geu/kIf3urHXorMd7iumeFJO7hXvoKCOII=;
  b=Pzhs1o84hREufZytn015hu311k0L/BCZS+btoexWJUVymj6appD4cdVu
   FfrWjtWOV6DuTjnf0H92nBPm89pwWyM7YW8u9N93R3waTdeB0KI7QR71v
   /cHX35VGRdyz1yfBlFW4v3Ve21U6pPuFEIZ0gthLzEtYB6GPWumaKUxmr
   YRvLIM4c8buhwFCTUXxeRS/KqP7xWVT2y06YcOhGDT7AxPyGVoy3A+aNt
   EpFVdJvsBHVa38ADvaCvoNHoU+mZc3RIM1eNq7hnMDdF4MSMrdH9pe85/
   0NWCYp5qKimUQV8h/mZ8wIMopBkBXZDV0pyvy7rijiggcJCuXK3Ddq9Bz
   A==;
X-CSE-ConnectionGUID: CgNx3H3vR26hjkXNFzfj+A==
X-CSE-MsgGUID: xBrT2lBjQCaxH7Ep3IveNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="12084220"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="12084220"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 12:16:08 -0700
X-CSE-ConnectionGUID: jmaJMGkISoqLiJ2p2IZYhw==
X-CSE-MsgGUID: Kd5Vby8OQKCXTdujpsXnLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="21036760"
Received: from kaspence-mobl.amr.corp.intel.com (HELO [10.209.90.14]) ([10.209.90.14])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 12:16:07 -0700
Message-ID: <d1f40ee3-ffac-4277-a5b5-6f3d678dff6b@linux.intel.com>
Date: Thu, 11 Apr 2024 12:16:06 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 10/11] PCI/DPC: Add Error Disconnect Recover (EDR)
 support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, ashok.raj@intel.com,
 Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20240411180757.GA2190937@bhelgaas>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240411180757.GA2190937@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/11/24 11:07 AM, Bjorn Helgaas wrote:
> On Mon, Mar 23, 2020 at 05:26:07PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Error Disconnect Recover (EDR) is a feature that allows ACPI firmware to
>> notify OSPM that a device has been disconnected due to an error condition
>> (ACPI v6.3, sec 5.6.6).  OSPM advertises its support for EDR on PCI devices
>> via _OSC (see [1], sec 4.5.1, table 4-4).  The OSPM EDR notify handler
>> should invalidate software state associated with disconnected devices and
>> may attempt to recover them.  OSPM communicates the status of recovery to
>> the firmware via _OST (sec 6.3.5.2).
>>
>> For PCIe, firmware may use Downstream Port Containment (DPC) to support
>> EDR.  Per [1], sec 4.5.1, table 4-6, even if firmware has retained control
>> of DPC, OSPM may read/write DPC control and status registers during the EDR
>> notification processing window, i.e., from the time it receives an EDR
>> notification until it clears the DPC Trigger Status.
>>
>> Note that per [1], sec 4.5.1 and 4.5.2.4,
>>
>>   1. If the OS supports EDR, it should advertise that to firmware by
>>      setting OSC_PCI_EDR_SUPPORT in _OSC Support.
>>
>>   2. If the OS sets OSC_PCI_EXPRESS_DPC_CONTROL in _OSC Control to request
>>      control of the DPC capability, it must also set OSC_PCI_EDR_SUPPORT in
>>      _OSC Support.
>>
>> Add an EDR notify handler to attempt recovery.
>>
>> [1] Downstream Port Containment Related Enhancements ECN, Jan 28, 2019,
>>     affecting PCI Firmware Specification, Rev. 3.2
>>     https://members.pcisig.com/wg/PCI-SIG/document/12888
>> +static int acpi_enable_dpc(struct pci_dev *pdev)
>> +{
>> +	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
>> +	union acpi_object *obj, argv4, req;
>> +	int status;
>> +
>> +	/*
>> +	 * Some firmware implementations will return default values for
>> +	 * unsupported _DSM calls. So checking acpi_evaluate_dsm() return
>> +	 * value for NULL condition is not a complete method for finding
>> +	 * whether given _DSM function is supported or not. So use
>> +	 * explicit func 0 call to find whether given _DSM function is
>> +	 * supported or not.
>> +	 */
>> +        status = acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
>> +				1ULL << EDR_PORT_DPC_ENABLE_DSM);
>> +        if (!status)
>> +                return 0;
>> +
>> +	status = 0;
>> +	req.type = ACPI_TYPE_INTEGER;
>> +	req.integer.value = 1;
>> +
>> +	argv4.type = ACPI_TYPE_PACKAGE;
>> +	argv4.package.count = 1;
>> +	argv4.package.elements = &req;
>> +
>> +	/*
>> +	 * Per Downstream Port Containment Related Enhancements ECN to PCI
>> +	 * Firmware Specification r3.2, sec 4.6.12, EDR_PORT_DPC_ENABLE_DSM is
>> +	 * optional.  Return success if it's not implemented.
>> +	 */
>> +	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
>> +				EDR_PORT_DPC_ENABLE_DSM, &argv4);
> This has been upstream for a while, just a follow-up question: this
> _DSM function was defined by the ECN with Rev 5.  The ECN was
> incorporated into the PCI Firmware spec r3.3 with slightly different
> behavior as Rev 6.
>
> The main differences are:
>
>   ECN
>     - Rev 5
>     - Arg3 is an Integer
>     - Return is 0 (DPC disabled) or 1 (DPC enabled)
>
>   r3.3 spec
>     - Rev 6
>     - Arg3 is a Package of one Integer
>     - Return is 0 (DPC disabled, Hot-Plug Surprise may be set), 1 (DPC
>       enabled, Hot-Plug Surprise may be cleared), or 2 (failure)
>
> So the question is whether this actually implements Rev 5 or Rev 6?
> It looks like this builds a *package* for Arg3 (which would correspond
> to Rev 6), but we're evaluating Rev 5, which specified an Integer.
>
> The meaning of the Arg3 values is basically the same, so I don't see
> an issue there, but it looks like if a platform implemented Rev 5
> according to the ECN to take a bare Integer, this might not work
> correctly.

I think it implements rev 6. The version number needs to be updated.

If you would like, I can submit a patch to fix it.

>
>> +	if (!obj)
>> +		return 0;
>> +
>> +	if (obj->type != ACPI_TYPE_INTEGER) {
>> +		pci_err(pdev, FW_BUG "Enable DPC _DSM returned non integer\n");
>> +		status = -EIO;
>> +	}
>> +
>> +	if (obj->integer.value != 1) {
>> +		pci_err(pdev, "Enable DPC _DSM failed to enable DPC\n");
>> +		status = -EIO;
>> +	}
>> +
>> +	ACPI_FREE(obj);
>> +
>> +	return status;
>> +}

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


