Return-Path: <linux-pci+bounces-7803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554B78CDC4B
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 23:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C30C287974
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 21:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447CD84DF2;
	Thu, 23 May 2024 21:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="031Z2ztT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uPxNlIt2"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4AE83CD6;
	Thu, 23 May 2024 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716500836; cv=none; b=C146J2JKsaVo2wELNAsjjcQjm+f8+9mgkmYPB/G1G4KIVA6O+ZCrEReoFywR2T5LAMroSJSt0cpr1k7fY7YN1vfKWaYEAkyW0FJlokFalD2eHYoWweemDEgsmcEVIYucNBdqa14PNmkdDoh1H82NGsnKbyXzsH/5uyf5nIKch7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716500836; c=relaxed/simple;
	bh=AIHTysb/p3mDj8tuOHpdkYeIE9mgzI5yyx/JhVGsGoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uaP20Zuf8jJgxbm+FT85pO+aDts9C9PyV7F6NEAq+N734vUJyn+mNBlnTC7Nv3KbsBYNcNOkOYdGsA6sXF7WMi9U5W1rPgAqJ28nO/oPPHc4DLftihhU98EhS5ATgymZljfkjfewBjIA4TxDzhayCSaEyAcuLfjX0qNwfX4iBdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=031Z2ztT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uPxNlIt2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716500826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HfSWMIeSro48ZWRAqUv8vmWmiMIU3qQetnBBw4e5rJU=;
	b=031Z2ztTxyuFXWApXykB4FQ6WaX9zYH0aXVpcqWQB5qgDssiFxcYkRuP1BHwBoJ0as9q/P
	EXzT6AwP1f0MokxzuLUtGHnd/YRw6WlyeA3HqslxGXNKpX5tBLVchRJXUxPP3ciz07FdXC
	P/IsavOejg3ADUlytLFev1n1x38CxXmCTeOmlrGUgy+dVEu2JXXP76YK3Y74Q43LLU+rpx
	4e818JFQXHcoX9MRoZIv+/tG6baHUjQO/AN6kVInuwH6xJm8KrDuozEyKCeBwJtzdUm4LO
	/OP+ayf6aZztWmSr9kpUB6ABm2jqlch7+LGwc3L8WMXS9E/1Qi0N2qxEpt8xdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716500826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HfSWMIeSro48ZWRAqUv8vmWmiMIU3qQetnBBw4e5rJU=;
	b=uPxNlIt2bLb0MzrZ7XtUuIjHV0iT2joAzZuN1nk4jaICo6I8QMAAOXKwoGUFFYbIa7H/D7
	NeqcFf+VNhZB4jBA==
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
Subject: Re: [PATCH v5 13/17] irqchip/riscv-intc: Add ACPI support for AIA
In-Reply-To: <20240501121742.1215792-14-sunilvl@ventanamicro.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-14-sunilvl@ventanamicro.com>
Date: Thu, 23 May 2024 23:47:06 +0200
Message-ID: <874jaofbfp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 01 2024 at 17:47, Sunil V L wrote:
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
> index 9e71c4428814..af7a2f78f0ee 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -249,14 +249,105 @@ IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
>  IRQCHIP_DECLARE(andes, "andestech,cpu-intc", riscv_intc_init);
>  
>  #ifdef CONFIG_ACPI
> +struct rintc_data {
> +	u32 ext_intc_id;
> +	unsigned long hart_id;
> +	u64 imsic_addr;
> +	u32 imsic_size;

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers

> +};
> +
> +static u32 nr_rintc;
> +static struct rintc_data *rintc_acpi_data[NR_CPUS];
> +
> +int acpi_get_intc_index_hartid(u32 index, unsigned long *hartid)

Why int? All of these functions have strictly boolean return values:
success = true, fail = false, no?

Either bool or get rid of the pointer and let the function return
either the real hart id or an invalid one.

> +{
> +	if (index >= nr_rintc)
> +		return -1;
> +
> +	*hartid = rintc_acpi_data[index]->hart_id;
> +	return 0;

I.e.

	return index >= nr_rintc ? rintc_acpi_data[index]->hart_id : INVALID_HART_ID;

> +int acpi_get_ext_intc_parent_hartid(u8 id, u32 idx, unsigned long *hartid)
> +{
> +	int i, j = 0;
> +
> +	for (i = 0; i < nr_rintc; i++) {
> +		if (APLIC_PLIC_ID(rintc_acpi_data[i]->ext_intc_id) == id) {
> +			if (idx == j) {
> +				*hartid = rintc_acpi_data[i]->hart_id;
> +				return 0;
> +			}
> +			j++;
> +		}
> +	}
> +
> +	return -1;
> +}
> +
> +void acpi_get_plic_nr_contexts(u8 id, int *nr_contexts)
> +{
> +	int i, j = 0;
> +
> +	for (i = 0; i < nr_rintc; i++) {
> +		if (APLIC_PLIC_ID(rintc_acpi_data[i]->ext_intc_id) == id)
> +			j++;
> +	}
> +
> +	*nr_contexts = j;
> +}
> +
> +int acpi_get_plic_context(u8 id, u32 idx, int *context_id)
> +{
> +	int i, j = 0;
> +
> +	for (i = 0; i < nr_rintc; i++) {
> +		if (APLIC_PLIC_ID(rintc_acpi_data[i]->ext_intc_id) == id) {
> +			if (idx == j) {
> +				*context_id = IDC_CONTEXT_ID(rintc_acpi_data[i]->ext_intc_id);
> +				return 0;
> +			}
> +
> +			j++;
> +		}
> +	}

So that's the third incarnation of the same loop with the truly self
explaining variable and argument names.

    j is actually the index of the context which is associated to a
    given PLIC ID.

    idx is the context index to search for

Right? So why can't these things be named in a way which makes the
intent of the code clear?

Also why are all the arguments u8/u32? There is no hardware
involved. Simple 'unsigned int' is just fine and the u8/u32 is not bying
you anything here.

Aside of that these ugly macros can be completely avoided and the code
can be written without a copy & pasta orgy.

struct rintc_data {
	union {
		u32		ext_intc_id;
                struct {
                	u32	context_id	: 16,
                        			:  8,
                        	aplic_plic_id	:  8;
                }
        };
	unsigned long		hart_id;
	u64			imsic_addr;
	u32			imsic_size;
};

#define for_each_matching_plic(_plic, _plic_id)				\
	for (_plic = 0; _plic < nr_rintc; _plict++)			\
        	if (rintc_acpi_data[_plic]->aplic_plic_id != _plic_id)	\
                	continue;					\
                else

unsigned int acpi_get_plic_nr_contexts(unsigned int plic_id)
{
	unsigned int nctx = 0;

	for_each_matching_plic(plic, plic_id)
		nctx++;

	return nctx;
}

static struct rintc_data *get_plic_context(unsigned int plic_id, unsigned int ctxt_idx)
{
	unsigned int ctxt = 0;

	for_each_matching_plic(plic, plic_id) {
        	if (ctxt == ctxt_idx)
                	return rintc_acpi_data + plic;
        }
        return NULL;
}

unsigned long acpi_get_ext_intc_parent_hartid(unsigned int plic_id, unsigned int ctxt_idx)
{
        struct rintc_data *data = get_plic_context(plic_id, ctxt_idx);

        return data ? data->hart_id : INVALID_HART_ID;
}

unsigned int acpi_get_plic_context(unsigned int plic_id, unsigned int ctxt_idx)
{
        struct rintc_data *data = get_plic_context(plic_id, ctxt_idx);

        return data ? data->context_id : INVALID_CONTEXT;
}

Or something like that. Hmm?

> +int acpi_get_imsic_mmio_info(u32 index, struct resource *res)
> +{
> +	if (index >= nr_rintc)
> +		return -1;
> +
> +	res->start = rintc_acpi_data[index]->imsic_addr;
> +	res->end = res->start + rintc_acpi_data[index]->imsic_size - 1;
> +	res->flags = IORESOURCE_MEM;
> +	return 0;
> +}
> +
> +static struct fwnode_handle *ext_entc_get_gsi_domain_id(u32 gsi)
> +{
> +	return riscv_acpi_get_gsi_domain_id(gsi);
> +}

This wrapper is required because using riscv_acpi_get_gsi_domain_id()
directly is too obvious, right?

>  static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
>  				       const unsigned long end)
>  {
> -	struct fwnode_handle *fn;
>  	struct acpi_madt_rintc *rintc;
> +	struct fwnode_handle *fn;
> +	int rc;
>  
>  	rintc = (struct acpi_madt_rintc *)header;
> +	rintc_acpi_data[nr_rintc] = kzalloc(sizeof(*rintc_acpi_data[0]), GFP_KERNEL);
> +	if (!rintc_acpi_data[nr_rintc])
> +		return -ENOMEM;
> +
> +	rintc_acpi_data[nr_rintc]->ext_intc_id = rintc->ext_intc_id;
> +	rintc_acpi_data[nr_rintc]->hart_id = rintc->hart_id;
> +	rintc_acpi_data[nr_rintc]->imsic_addr = rintc->imsic_addr;
> +	rintc_acpi_data[nr_rintc]->imsic_size = rintc->imsic_size;
> +	nr_rintc++;
>  
>  	/*
>  	 * The ACPI MADT will have one INTC for each CPU (or HART)
> @@ -273,7 +364,14 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
>  		return -ENOMEM;
>  	}
>  
> -	return riscv_intc_init_common(fn, &riscv_intc_chip);
> +	rc = riscv_intc_init_common(fn, &riscv_intc_chip);
> +	if (rc) {
> +		irq_domain_free_fwnode(fn);
> +		return rc;
> +	}

This looks like a completely unrelated bug fix. Please don't mix functional
changes and fixes.

Thanks,

        tglx

