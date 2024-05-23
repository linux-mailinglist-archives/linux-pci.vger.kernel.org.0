Return-Path: <linux-pci+bounces-7805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369FE8CDC89
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2024 00:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545B21C239EA
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 22:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CBF127E3A;
	Thu, 23 May 2024 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AbYeiDrh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hG7nVsQd"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F38784A4E;
	Thu, 23 May 2024 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716501624; cv=none; b=lVmlH+tqNbbfpPy1HlCiVipnecqM+jEklsr0X5X1LeicfAXQL2eHi39U4pn7lgieJhFR1iO3/EqGRTQRal4uxxvb3xmCmcPKvKppVdct1oAqhtAkvRafEr1c9GGl02ygBOcsBz67nWrHagSpKwSgzErXQwuJqCGPHv6EJx1qy2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716501624; c=relaxed/simple;
	bh=U3zNsDx6nW/dLYh1FM2TrjCHAPkf8MnEIVyZTcNJdnY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mTW3CpJRGXwR8ZuUrnMF/o3lTJj+R1Q46Um8bM5x0QTBZBrfCMCDlUvQIxYAzdHl88fHLyTndBgkYHhA5l3rZW12ycXBR40XfoGmVNKIIvUwhYLAtmteeTYjhcGmPw+IPSIt9FcUka3mf+Uh848EetcGfmOxdko3pzIAwGMLjsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AbYeiDrh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hG7nVsQd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716501621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=18bFCkDiE5Sbgi4NXueQ8erF60YbZu7PrN26lvvIIBA=;
	b=AbYeiDrhr7a8f7DpLWT7jPVQsX5p8BYnloO9JHGWZo1jwWM2TNA1GkS+RXgQQZ4kwveXJA
	uO2F3wxgENt5+tKqVIgI6LKhXREauGP4TyVSnMEjWlqAQaaQOAFEqtPs/deTAO0TFZJ7Ty
	XF8dZT5GJXGueFBS1ZHnF05S7WpTqg0DfkUciatQMe2lVzrH9N7yj6h8ufGhwlj3MNvTIQ
	EyaFwwIde5NjZXu/+dN8DnAO4TXG/44owA2GfGZdyYXZKje8Uxr03QDeKC3OlmZc4fjhmF
	yOl2dALXgw8lwL0coqnq1DwlyJLRFqb5paIzqkr2HPPs4pBa2EKFPyuWxO8WYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716501621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=18bFCkDiE5Sbgi4NXueQ8erF60YbZu7PrN26lvvIIBA=;
	b=hG7nVsQdEZxaAwZk4oZt4Q8Vn66oqj4h5KlI8OqVC3M2q2XO0TFXx9+UzcEfwt+sQD2dkW
	Gavtq8THOFkIrzAw==
To: Sunil V L <sunilvl@ventanamicro.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou
 <aou@eecs.berkeley.edu>, "Rafael J . Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Anup Patel
 <anup@brainfault.org>, Samuel Holland <samuel.holland@sifive.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Robert Moore <robert.moore@intel.com>, Conor
 Dooley <conor.dooley@microchip.com>, Andrew Jones
 <ajones@ventanamicro.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Marc Zyngier <maz@kernel.org>, Atish
 Kumar Patra <atishp@rivosinc.com>, Andrei Warkentin
 <andrei.warkentin@intel.com>, Haibo1 Xu <haibo1.xu@intel.com>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>
Subject: Re: [PATCH v5 14/17] irqchip/riscv-imsic: Add ACPI support
In-Reply-To: <20240501121742.1215792-15-sunilvl@ventanamicro.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-15-sunilvl@ventanamicro.com>
Date: Fri, 24 May 2024 00:00:21 +0200
Message-ID: <871q5sfatm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 01 2024 at 17:47, Sunil V L wrote:

> RISC-V IMSIC interrupt controller provides IPI and MSI support.
> Currently, DT based drivers setup the IPI feature early during boot but
> defer setting up the MSI functionality. However, in ACPI systems, ACPI,
> both IPI and MSI features need to be initialized early itself.

Why?

> +
> +#ifdef CONFIG_ACPI
> +
> +static struct fwnode_handle *imsic_acpi_fwnode;
> +
> +struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev)

Why is this function global? It's only used in the very same file and
under the same CONFIG_ACPI #ifdef, no?

> +{
> +	return imsic_acpi_fwnode;
> +}
> +
> +static int __init imsic_early_acpi_init(union acpi_subtable_headers *header,
> +					const unsigned long end)
> +{
> +	struct acpi_madt_imsic *imsic = (struct acpi_madt_imsic *)header;
> +	int rc;
> +
> +	imsic_acpi_fwnode = irq_domain_alloc_named_fwnode("imsic");
> +	if (!imsic_acpi_fwnode) {
> +		pr_err("unable to allocate IMSIC FW node\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Setup IMSIC state */
> +	rc = imsic_setup_state(imsic_acpi_fwnode, (void *)imsic);

Pointless (void *) cast.

> +	if (rc) {
> +		pr_err("%pfwP: failed to setup state (error %d)\n", imsic_acpi_fwnode, rc);
> +		return rc;
> +	}
> +
> +	/* Do early setup of IMSIC state and IPIs */
> +	rc = imsic_early_probe(imsic_acpi_fwnode);
> +	if (rc)
> +		return rc;
> +
> +	rc = imsic_platform_acpi_probe(imsic_acpi_fwnode);
> +
> +#ifdef CONFIG_PCI
> +	if (!rc)
> +		pci_msi_register_fwnode_provider(&imsic_acpi_get_fwnode);
> +#endif
> +
> +	return rc;

Any error return in this function leaks the firmware node and probably
some more stuff.

> +}
> +
> +IRQCHIP_ACPI_DECLARE(riscv_imsic, ACPI_MADT_TYPE_IMSIC, NULL,
> +		     1, imsic_early_acpi_init);
> +#endif

...

> -	/* Find number of interrupt identities */
> -	rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-ids",
> -				  &global->nr_ids);
> -	if (rc) {
> -		pr_err("%pfwP: number of interrupt identities not found\n", fwnode);
> -		return rc;
> +		/* Find number of guest interrupt identities */
> +		rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-guest-ids",
> +					  &global->nr_guest_ids);
> +		if (rc)
> +			global->nr_guest_ids = global->nr_ids;
> +	} else {
> +		global->guest_index_bits = imsic->guest_index_bits;
> +		global->hart_index_bits = imsic->hart_index_bits;
> +		global->group_index_bits = imsic->group_index_bits;
> +		global->group_index_shift = imsic->group_index_shift;
> +		global->nr_ids = imsic->num_ids;
> +		global->nr_guest_ids = imsic->num_guest_ids;
>  	}

Seriously?

Why can't you just split out the existing DT code into a separate
function in an initial patch which avoulds all of this unreviewable
churn of making the DT stuff indented ?

> +#ifdef CONFIG_ACPI
> +int imsic_platform_acpi_probe(struct fwnode_handle *fwnode);
> +struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev);
> +#else
> +static inline struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev)
> +{
> +	return NULL;
> +}
> +#endif

Oh well.

>  #endif

Thanks,

        tglx

