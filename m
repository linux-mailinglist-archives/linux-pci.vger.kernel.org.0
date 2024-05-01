Return-Path: <linux-pci+bounces-6969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06038B8E9E
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 18:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A311C211EF
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 16:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B703C14A8B;
	Wed,  1 May 2024 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwrFK+fQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBC513FF6;
	Wed,  1 May 2024 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582577; cv=none; b=fI7lkGFhIajUZZMNurhtQdEiXoRY3PrTHzLBgQdpaebMWNxSTfYr3LQ/4y4yhKXc5Ch0zKoXN66AlQdF/mHsnEI2MOBn40jCG43CqNZ+79b+bBxxNZr/fmiN0XZolGp3yfpPheR7aabIzer8f21lrEGBMjfiq3V0d0iyG9jHddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582577; c=relaxed/simple;
	bh=SfIUnFvTodi3ZAdSokEGwrQBZQMoBGP2gvIdsXxo1z8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=D5xabfYICiRdM0GdfDmOH0nzsEQWjB2W/U/nTi3G7sYIsUsXPb7MPhT9LdnfBdP2ulwOJfH410ACBzlZjmM8rSPHaGyMDZGCdHDWQnL54LzB/aUTkf8Keuodi+HuaZHOsCGy2Xa0sVXEJxV2rb7LMzDwEMA1vtZlb9/xkpsksmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwrFK+fQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC497C072AA;
	Wed,  1 May 2024 16:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714582577;
	bh=SfIUnFvTodi3ZAdSokEGwrQBZQMoBGP2gvIdsXxo1z8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nwrFK+fQYl6W4IHr6gnMS8swEZfLcfdSm4TEcZt5aWvI5cpqh7w4by/NlSlrVYjZL
	 nSyMc1JZUgqnVPi3l4AskQDTBIg9ssQDqVRKrNblj13co5FmyvpEeH/66UR7xpkZOB
	 00NeWDZlTLiVmA0UQWYWoqUKgZkqpFbxOsnnVkdBIiEpBc979vFlZAfENsKIP5C4FP
	 ZgIXwvnYDTXwcasDNez+ynbUOZgMUa5OPy4YdrNoLJ+KdsG164DtG/7BQjY2pA2zWK
	 GEd3kS4ypFHM9mTJOQSG/RGht9W4bkGnY7CGz8RqZ+/Ebp1vm8DPjQkVyYEp898vFN
	 W1ZUMK9aRV32A==
Date: Wed, 1 May 2024 11:56:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH v5 08/17] ACPI: pci_link: Clear the dependencies after
 probe
Message-ID: <20240501165615.GA758227@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501121742.1215792-9-sunilvl@ventanamicro.com>

On Wed, May 01, 2024 at 05:47:33PM +0530, Sunil V L wrote:
> RISC-V platforms need to use dependencies between PCI host bridge, Link
> devices and the interrupt controllers to ensure probe order. The
> dependency is like below.
> 
> Interrupt controller <-- Link Device <-- PCI Host bridge.
> 
> If there is no dependency added between Link device and PCI Host Bridge,
> then the PCI end points can get probed prior to link device, unable to
> get mapping for INTx.
> 
> So, add the link device's HID to dependency honor list and also clear it
> after its probe.
> 
> Since this is required only for architectures like RISC-V, enable this
> code under a new config option and set this only in RISC-V.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/Kconfig      | 1 +
>  drivers/acpi/Kconfig    | 3 +++
>  drivers/acpi/pci_link.c | 3 +++
>  drivers/acpi/scan.c     | 1 +
>  4 files changed, 8 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index f961449ca077..f7a36d79ff1a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -14,6 +14,7 @@ config RISCV
>  	def_bool y
>  	select ACPI_GENERIC_GSI if ACPI
>  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> +	select ARCH_ACPI_DEFERRED_GSI if ACPI
>  	select ARCH_DMA_DEFAULT_COHERENT
>  	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
>  	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index e3a7c2aedd5f..ebec1707f662 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -587,6 +587,9 @@ config ACPI_PRMT
>  	  substantially increase computational overhead related to the
>  	  initialization of some server systems.
>  
> +config ARCH_ACPI_DEFERRED_GSI
> +	bool
> +
>  endif	# ACPI
>  
>  config X86_PM_TIMER
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index aa1038b8aec4..48cdcedafad6 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -748,6 +748,9 @@ static int acpi_pci_link_add(struct acpi_device *device,
>  	if (result)
>  		kfree(link);
>  
> +	if (IS_ENABLED(CONFIG_ARCH_ACPI_DEFERRED_GSI))
> +		acpi_dev_clear_dependencies(device);

This is really a question for Rafael, but it doesn't seem right that
this completely depends on a config option.

Is there a reason this wouldn't work for all architectures, i.e., what
would happen if you just called acpi_dev_clear_dependencies()
unconditionally?

> +
>  	return result < 0 ? result : 1;
>  }
>  
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 3eeb4ce39fcc..67677a6ff8e3 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -834,6 +834,7 @@ static const char * const acpi_honor_dep_ids[] = {
>  	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
>  	"RSCV0001", /* RISC-V PLIC */
>  	"RSCV0002", /* RISC-V APLIC */
> +	"PNP0C0F",  /* PCI Link Device */
>  	NULL
>  };
>  
> -- 
> 2.40.1
> 
> 

