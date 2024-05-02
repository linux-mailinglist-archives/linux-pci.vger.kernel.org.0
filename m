Return-Path: <linux-pci+bounces-7025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 700238BA291
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 23:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3A41C22506
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 21:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E2857CB7;
	Thu,  2 May 2024 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvnPyn+E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F1757CB5;
	Thu,  2 May 2024 21:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714686183; cv=none; b=BuJZpFxRZziZsBnou0F/0rGgCYCR047XbSqKj9haho3Xla3BQDgUtSMIC2kJG3RuRG2T+e71GsuUtt+JrbtLg380dKft0/xDuj+vRWLji4Ew8gcYUxpkACoLUR+/4yMQG35v6IawFj9ioLo+k+Jyf6cAbXcv41ODZMFqwMq9rvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714686183; c=relaxed/simple;
	bh=hU0rwDyItfrpYEKW9APHQwJSc/rZVbSW7HMod3rGJt0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EwSA+vn1oIUK6eqnMnmh9zl22lkpkCqAnoiLu416eNwJBt2guohD/EBt9iZkW7vaWcb6wIc1GlV9AtqIdYJrsGeXFqZNXGLOaRzlhBS21FtwkzRqi3qyTzeG56zdujiqpNE+AX4QN18dlXAmlZtIjkl/cZdoDbHBrdSHwoHnZTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvnPyn+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC32C113CC;
	Thu,  2 May 2024 21:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714686182;
	bh=hU0rwDyItfrpYEKW9APHQwJSc/rZVbSW7HMod3rGJt0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CvnPyn+EX/NmZZdNbjM4BI2Dj6j9krHnP/4y7s7t38FK34ToT1ExioKiJAF5wty7S
	 eDuI5KsHBDz92OjB4uTIaMNTqbwSj9mpmRdCe85pONeDODTjMmgEUceQwPAv0ehEo7
	 6LKNDDQMuUGPf3S7B3Roq797esg1ODWseJa1fmJ7qP/a2ihXbXZXn+essmLA3TN/Pd
	 hjCngZ5RBqgECPah0fCRfDxa1q4mgDuldJi/yiSx1rQ28wIvoVxGj0peHYKt7d8R5x
	 jryC1p6YtUorrnsDSumPBRRbmm1wPwF9AOIC8j+8HNDoFy/nSNoSZj9KW1lduN/2l2
	 9woaFVdcsLPBg==
Date: Thu, 2 May 2024 16:43:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Mateusz Kaduk <mateusz.kaduk@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, Tj <linux@iam.tj>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/pci: Skip early E820 check for ECAM region
Message-ID: <20240502214300.GA1547650@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417204012.215030-2-helgaas@kernel.org>

On Wed, Apr 17, 2024 at 03:40:12PM -0500, Bjorn Helgaas wrote:
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

I applied this to pci/enumeration for v6.10, thanks everybody for
your testing and review.

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
> -- 
> 2.34.1
> 

