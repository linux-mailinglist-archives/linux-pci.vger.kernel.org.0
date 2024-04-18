Return-Path: <linux-pci+bounces-6388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEB38A916F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 05:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696A01F21558
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 03:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D408B4F20E;
	Thu, 18 Apr 2024 03:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSNDyq0v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026FA63D5;
	Thu, 18 Apr 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713409832; cv=none; b=RjcxDiDXtWUhADY4k+v1AyUj4qAYUEo8baPbnRmxobyI3Q0XPIJUqwBbF6GMFYGhHlzRU+bNJzDFbFizPL/wGH2ZDwfWPD++DY7LlLkV3iyUMwtBpRA/MDN2psyXTD7ABVw+GSMMXVy7pVByKINhHjzgrVmFSdsw+tSbbF80Fxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713409832; c=relaxed/simple;
	bh=8LEJM9vkGFK/UoZS9qEvsMoHGiAAvfvk08Ql1e4Kkuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lz1Lec1fa9vK9wQlDF1DWWbRwxZOaforvVmOo3KuXrlj9OpyIVx6+1l+zIAmme7ihAm3tYZKL7YoVGyuv+e4C/q0sF95DFMDQX3pNButEwhzxC2xYW4C0osMhBkLGjJ9ZtficCy8epDqURJpV3flWz0PXnvgLaqZ6QgZRMnRDiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSNDyq0v; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713409831; x=1744945831;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8LEJM9vkGFK/UoZS9qEvsMoHGiAAvfvk08Ql1e4Kkuo=;
  b=SSNDyq0vhm8KtyiZ/IMxLsQVfJjfgkigBCerEQBvYgse7o6DtIV2oLjm
   gwSlr/9Mig/dk4AkyAqUHfkyc1EiTd7u2oz6OMz+M3rszmh+VrZ6kuUSr
   /L40pmMH0fjRp3mluCJigWCQNItF8bdk3/pdITN2YP1nAdYIf3/+w3erh
   AJ8/LARtsFHqMqrAm2mj6isMMZ4MPdroj431s13Fn1di0N3DkjO06mfaA
   kglYF5G8KLUUc5g+hI8AYtWP8czkAg8oxexJAg1M7CxB2hh7UXfcrmvR7
   vkvZgHVe766aKBmMJTCLZz35O/KvaUa50UCGBPgExUEbhUxVQDQsWRSVC
   A==;
X-CSE-ConnectionGUID: geMvzFiYQhuQ0rvPQCpdlA==
X-CSE-MsgGUID: 6T9ikv9TRJS6BBjXGZ5KeQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20080580"
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="20080580"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 20:10:30 -0700
X-CSE-ConnectionGUID: 1JISkpTwRQa9i+mRmysrmg==
X-CSE-MsgGUID: 7JxQED1ZQZSmm/xdv2Nh5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="27414951"
Received: from kglossop-mobl.amr.corp.intel.com (HELO [10.209.94.180]) ([10.209.94.180])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 20:10:29 -0700
Message-ID: <11f55f7e-92f9-4689-9dd8-75fb45f8afe5@linux.intel.com>
Date: Wed, 17 Apr 2024 20:10:28 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/pci: Skip early E820 check for ECAM region
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Mateusz Kaduk <mateusz.kaduk@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Tj <linux@iam.tj>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 stable@vger.kernel.org
References: <20240417204012.215030-1-helgaas@kernel.org>
 <20240417204012.215030-2-helgaas@kernel.org>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240417204012.215030-2-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/17/24 1:40 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Arul, Mateusz, Imcarneiro91, and Aman reported a regression caused by
> 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map").  On the
> Lenovo Legion 9i laptop, that commit removes the area containing ECAM from
> E820, which means the early E820 validation started failing, which meant we
> didn't enable ECAM in the "early MCFG" path
>
> The lack of ECAM caused many ACPI methods to fail, resulting in the
> embedded controller, PS/2, audio, trackpad, and battery devices not being
> detected.  The _OSC method also failed, so Linux could not take control of
> the PCIe hotplug, PME, and AER features:
>
>   # pci_mmcfg_early_init()
>
>   PCI: ECAM [mem 0xc0000000-0xce0fffff] (base 0xc0000000) for domain 0000 [bus 00-e0]
>   PCI: not using ECAM ([mem 0xc0000000-0xce0fffff] not reserved)
>
>   ACPI Error: AE_ERROR, Returned by Handler for [PCI_Config] (20230628/evregion-300)
>   ACPI: Interpreter enabled
>   ACPI: Ignoring error and continuing table load
>   ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.RP01._SB.PC00], AE_NOT_FOUND (20230628/dswload2-162)
>   ACPI Error: AE_NOT_FOUND, During name lookup/catalog (20230628/psobject-220)
>   ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0010)
>   ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.RP01._SB.PC00], AE_NOT_FOUND (20230628/dswload2-162)
>   ACPI Error: AE_NOT_FOUND, During name lookup/catalog (20230628/psobject-220)
>   ...
>   ACPI Error: Aborting method \_SB.PC00._OSC due to previous error (AE_NOT_FOUND) (20230628/psparse-529)
>   acpi PNP0A08:00: _OSC: platform retains control of PCIe features (AE_NOT_FOUND)
>
>   # pci_mmcfg_late_init()
>
>   PCI: ECAM [mem 0xc0000000-0xce0fffff] (base 0xc0000000) for domain 0000 [bus 00-e0]
>   PCI: [Firmware Info]: ECAM [mem 0xc0000000-0xce0fffff] not reserved in ACPI motherboard resources
>   PCI: ECAM [mem 0xc0000000-0xce0fffff] is EfiMemoryMappedIO; assuming valid
>   PCI: ECAM [mem 0xc0000000-0xce0fffff] reserved to work around lack of ACPI motherboard _CRS
>
> Per PCI Firmware r3.3, sec 4.1.2, ECAM space must be reserved by a PNP0C02
> resource, but it need not be mentioned in E820, so we shouldn't look at
> E820 to validate the ECAM space described by MCFG.
>
> 946f2ee5c731 ("[PATCH] i386/x86-64: Check that MCFG points to an e820
> reserved area") added a sanity check of E820 to work around buggy MCFG
> tables, but that over-aggressive validation causes failures like this one.
>
> Keep the E820 validation check only for older BIOSes (pre-2016) so the
> buggy 2006-era machines don't break.  Skip the early E820 check for 2016
> and newer BIOSes.
>
> Fixes: 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map")
> Reported-by: Mateusz Kaduk <mateusz.kaduk@gmail.com>
> Reported-by: Arul <...>
> Reported-by: Imcarneiro91 <...>
> Reported-by: Aman <...>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218444
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Tested-by: Mateusz Kaduk <mateusz.kaduk@gmail.com>
> Cc: stable@vger.kernel.org
> ---

LGTM

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  arch/x86/pci/mmconfig-shared.c | 35 +++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index 0cc9520666ef..53c7afa606c3 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -518,7 +518,34 @@ static bool __ref pci_mmcfg_reserved(struct device *dev,
>  {
>  	struct resource *conflict;
>  
> -	if (!early && !acpi_disabled) {
> +	if (early) {
> +
> +		/*
> +		 * Don't try to do this check unless configuration type 1
> +		 * is available.  How about type 2?

I don't understand why above question is included in the comment. Do
you think it is better to drop that part of the comment?

> +		 */
> +
> +		/*
> +		 * 946f2ee5c731 ("Check that MCFG points to an e820
> +		 * reserved area") added this E820 check in 2006 to work
> +		 * around BIOS defects.
> +		 *
> +		 * Per PCI Firmware r3.3, sec 4.1.2, ECAM space must be
> +		 * reserved by a PNP0C02 resource, but it need not be
> +		 * mentioned in E820.  Before the ACPI interpreter is
> +		 * available, we can't check for PNP0C02 resources, so
> +		 * there's no reliable way to verify the region in this
> +		 * early check.  Keep it only for the old machines that
> +		 * motivated 946f2ee5c731.
> +		 */
> +		if (dmi_get_bios_year() < 2016 && raw_pci_ops)
> +			return is_mmconf_reserved(e820__mapped_all, cfg, dev,
> +						  "E820 entry");
> +
> +		return true;
> +	}
> +
> +	if (!acpi_disabled) {
>  		if (is_mmconf_reserved(is_acpi_reserved, cfg, dev,
>  				       "ACPI motherboard resource"))
>  			return true;
> @@ -554,12 +581,6 @@ static bool __ref pci_mmcfg_reserved(struct device *dev,
>  	if (pci_mmcfg_running_state)
>  		return true;
>  
> -	/* Don't try to do this check unless configuration
> -	   type 1 is available. how about type 2 ?*/
> -	if (raw_pci_ops)
> -		return is_mmconf_reserved(e820__mapped_all, cfg, dev,
> -					  "E820 entry");
> -
>  	return false;
>  }
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


