Return-Path: <linux-pci+bounces-6406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116D48A94B6
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 10:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC4D282B22
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 08:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1060E7D09A;
	Thu, 18 Apr 2024 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/v26Mvw"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6840C54775
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 08:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428069; cv=none; b=aa56c/+DrWqfHkmxwA6j4HZTHn3Xx82nXhbivYce9Jom7MdNIqZUxm0Wbftnv0HRpj14Gj8HtLyegSx3k6vh8HOHOq820lvcy6WSEREuwMQGH6uY+jb9QZkI1S80hoGlBpmizebv1uq7E1vHRtbC7BS7WYG7c7LGRYFkgLevcqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428069; c=relaxed/simple;
	bh=OmyJ4CCIcPHCYBOIHKM/SO5ZvFHjMk+iPD2ShEtPKW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=khy9dAsccpxALUy8id0Op8MRtAEE+LEkOngsU1x1pnFPjDHxbiTYTInOY/Cfi3AVXZFyUMmfutz4+n26qobp6Dz2bXs3l2PL0x9cd/ZFI6iufULCQTCGicylRRcH2cPih6bH+q0hNcyLVeAFOssp+hwn3R1jgnXo8eLdaUHkPt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/v26Mvw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713428066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m9Ui1mDTOM4AD6M9Ta2r6+9nSqGNzGJnd1ALyUw6BX8=;
	b=H/v26MvwDvTl1OJlziTaKHoWuGhWb+GN7v9sDjxAuO19fKJQPUGJhYj0OBVJZwynTEZxAx
	MeZ51e2VYveGDZ59QD29YrWnxEnmlHBoAtt+RqH/Xg3W4SwK0FVT1LKIIfKD4ePuVcT/Ck
	Dm5PSQPINYWvXsSxaCBxLcxJhwAzEho=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-QO00Ag__OBa690ipiOBMXQ-1; Thu, 18 Apr 2024 04:14:24 -0400
X-MC-Unique: QO00Ag__OBa690ipiOBMXQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a450265c7b6so28432166b.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 01:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713428063; x=1714032863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9Ui1mDTOM4AD6M9Ta2r6+9nSqGNzGJnd1ALyUw6BX8=;
        b=sOmcBOtQBOgNmVzhHQkK6uH2SDdd+1CLg6sV5hgg/Sdnioo4bqHTrrnYEemlgSIAMT
         CE5aCvVGsXJRs4l+p8bO2k28ob/cZjL6MNukRMM43mp6+808XNFCLEJZmHRKKGoZbIQV
         hReVqsPKYBO1U6EgHI47dNmBWFpbUhexeWsXbfg0fzp2GHY0sKPP3c69ZuYHL78sZBqu
         qx7g/IAEs0r+0tCom162hm05GK0ZVIH/0EcgFmVdcCZhMTOxh0KPzyEijWF1xbmH5r1+
         aeD1me//vdy5+J4sNMElsuRN9mwlThqiVHSf4qr+e0KERX1QWt+Y6x3+G9hwPFFrFljW
         FTBA==
X-Forwarded-Encrypted: i=1; AJvYcCVN6pLVjeMPx+vnAFFoSlKdPPNszO3qU2QXxIxZgoFg95kO+M6DmN89YEAjRXIwE2VWqNzuItBf1zZHViTf+ewHWhhkecU39LYp
X-Gm-Message-State: AOJu0YxVjq9aMsB2rbf+tWOj4Rc/bZqkjWvsweIVZirjZq7tLMhCDDvA
	TTdb8LYz3KlCddTJIcopmD71OMlWtqvgtrnaRqkXylKFLpoW6hGvhqhb98MY+bG3ZK9+yq62Iq/
	L1SW3OmnpVcYUcAiJpgnkVJGjyncD75+GpamCC8s8GHvgvraXc11kzvt9ng==
X-Received: by 2002:a17:906:3108:b0:a52:408f:8575 with SMTP id 8-20020a170906310800b00a52408f8575mr1134290ejx.12.1713428063181;
        Thu, 18 Apr 2024 01:14:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgqLUhBNwIayrRWKNw8a6roBMGoqLy7R5iBXwNsfyU8W95SRZ4G+cQy68OohlTtrn3M4pMKw==
X-Received: by 2002:a17:906:3108:b0:a52:408f:8575 with SMTP id 8-20020a170906310800b00a52408f8575mr1134273ejx.12.1713428062763;
        Thu, 18 Apr 2024 01:14:22 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906329100b00a4ea067f6f8sm551939ejw.161.2024.04.18.01.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 01:14:22 -0700 (PDT)
Message-ID: <c1897030-77a4-416d-86c4-6d4d560e5fd8@redhat.com>
Date: Thu, 18 Apr 2024 10:14:21 +0200
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
 x86@kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org
References: <20240417204012.215030-1-helgaas@kernel.org>
 <20240417204012.215030-2-helgaas@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240417204012.215030-2-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

On 4/17/24 10:40 PM, Bjorn Helgaas wrote:
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

I know a fix for this has been long in the making so I don't want to throw
a spanner into the works, but I wonder why is the is_efi_mmio() check inside
the if (!early && !acpi_disabled) {} block (before this patch) ?

is_efi_mmio() only relies on EFI memdescriptors and those are setup pretty
early. Assuming that the EFI memdescriptors are indeed setup before
pci_mmcfg_reserved(..., ..., early=true) gets called we could simply move
the is_efi_mmio(&cfg->res) outside (below) the if (!early && !acpi_disabled)
{} so that it always runs before the is_mmconf_reserved(e820__mapped_all, ...)
check.

Looking at the dmesg above the is_efi_mmio() check does succeed, so this
should fix the issue without needing a BIOS year check ?

Regards,

Hans





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


