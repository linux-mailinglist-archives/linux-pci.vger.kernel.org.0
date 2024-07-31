Return-Path: <linux-pci+bounces-11071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F819436B7
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 21:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52206281C9F
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 19:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1114414AD3F;
	Wed, 31 Jul 2024 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzwcgcEJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB1614831F;
	Wed, 31 Jul 2024 19:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722455370; cv=none; b=SNaGv/Wn2TrUhhVqWtfw1Mv1GnfDT5cVjs7EK5gi7tsBn2K1cMtubYpVgYTL/vmA/5HJVc+LeQH8FD1mv8VmQOfYX0m6ozAYbIXsXpRlDhP9iMA6WeQYIrzOqI0GAE8tEyYrLbQlXMqjNT9wGknm3p3O3DfqGK17hFAQw7Hmrfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722455370; c=relaxed/simple;
	bh=PUpvq4IvGstISJBnqSrlDq4K2g9I2Ugc4NXAsXQFQ+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G4txADYvLFxqVv5LbsZjGY3IoMT6tb7uC6fxol3ckjKREWccI6gXGyIeMvsdjmV3dEPXjx2k220hylMdwHbHcmRsl4Awr8a7L6NyrH9Lhlv5QwOJTFaXfoYZQXHZzNQ9WvLANXFHxcZxDjoPJLU502VJd+EwtZizpA6fnVL37ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzwcgcEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118DEC4AF09;
	Wed, 31 Jul 2024 19:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722455369;
	bh=PUpvq4IvGstISJBnqSrlDq4K2g9I2Ugc4NXAsXQFQ+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FzwcgcEJ2HxUeoOcvMsJeNsPl6w9Kj08seE75vXEQtKYVaw9J5f5kGITSMChJ5ngg
	 nyOup++1xb53SaOvf2JQ6WZNlC0k9CcImr85jS76aolvFVD1FC92psCq2PvJTtVh43
	 JSm+TZmXzo9IqPIorv/zUDNb7zcBKywFNjDBjzOenBlkIy7+dBWQj4PvcAIYmwZWJd
	 mnRfyHxi402vgsIw2XNgcy189EIbANEqBOYCgpV2Nbwbgkc9WXc2wGBBi/g4AHzyUm
	 adI7kyJrsRNPmnjJPx8nunXdyVHshIdNVxYRsg7P4rs98iTyg7W80qr3kqBAvFNRer
	 5IIcm7AENs1qQ==
Date: Wed, 31 Jul 2024 14:49:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>
Subject: Re: [PATCH v7 08/17] ACPI: pci_link: Clear the dependencies after
 probe
Message-ID: <20240731194927.GA78106@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729142241.733357-9-sunilvl@ventanamicro.com>

On Mon, Jul 29, 2024 at 07:52:30PM +0530, Sunil V L wrote:
> RISC-V platforms need to use dependencies between PCI host bridge, Link
> devices and the interrupt controllers to ensure probe order. The
> dependency is like below.
> 
> Interrupt controller <-- Link Device <-- PCI Host bridge.
> 
> If there is no dependency added between Link device and PCI Host Bridge,
> then the PCI end points can get probed prior to link device, unable to
> get mapping for INTx.

This sentence is missing a word or something.  Maybe it's supposed to
say something like this:

  If there is no dependency between Link device and PCI Host Bridge,
  then PCI devices may be probed prior to Link devices.  If a PCI
  device is probed before its Link device, we won't be able to find
  its INTx mapping.

> So, add the link device's HID to dependency honor list and also clear it
> after its probe.

It looks like *this* patch only clears it after probe.  And the commit
log doesn't say why we need to clear the dependency.

> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/acpi/pci_link.c | 2 ++
>  drivers/acpi/scan.c     | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index aa1038b8aec4..b727db968f33 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -748,6 +748,8 @@ static int acpi_pci_link_add(struct acpi_device *device,
>  	if (result)
>  		kfree(link);
>  
> +	acpi_dev_clear_dependencies(device);
> +
>  	return result < 0 ? result : 1;
>  }
>  
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 28a221f956d7..753539a1f26b 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -863,6 +863,7 @@ static const char * const acpi_honor_dep_ids[] = {
>  	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
>  	"RSCV0001", /* RISC-V PLIC */
>  	"RSCV0002", /* RISC-V APLIC */
> +	"PNP0C0F",  /* PCI Link Device */
>  	NULL
>  };
>  
> -- 
> 2.43.0
> 

