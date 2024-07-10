Return-Path: <linux-pci+bounces-10077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A50C392D33C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 15:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1040CB26B6A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 13:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464031E502;
	Wed, 10 Jul 2024 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ha1FyJEj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7F9194C85
	for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2024 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618967; cv=none; b=d7IIOLf+9cImS53nkbEONGBYi5/hauyV+HGtVcRh9NNcept8vuUENB58GRW3Gd7Zgpjoy2mXAHtkfhhXVkyvhdt10OS0HwK6jnzlooAQQKqvsXRF7r9dTkeS9aA77GpqhRUwDe+Pub/PH1Xs2f4sIlquglEf+Sv1PAWIn2O4YY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618967; c=relaxed/simple;
	bh=1UTWdzOxOelSHpVSNprV23qUyNKV7uNp5Ou37TT94+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIeaBBrrvI4oP6V8sUVGIJSZZN6cBck43HjzwJQM56m4nVn/qFNiDOkDtxhYzl0dbPkv651jwGeeCaM2sVRJUxVcM9sDOXeXhRQRflGB3ARA3xlLrozX6gwBeLt9bVceAyIxIrvPUSZ6tLtKXiHUgeUK7fg08SEp5lhypKu3WB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ha1FyJEj; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5c691c6788eso950588eaf.2
        for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2024 06:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1720618964; x=1721223764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYo7hiyQeiuXBsG523lCpU3OjDoScc8p3LqrHOuQZw8=;
        b=ha1FyJEjoqX27cMRURisxJOE0AQtS5Br8zauxvuXfh5Lgon7Bnp0PauwQIc4QJUi4B
         7XHDTHN3fKkr7H1EfmNKRj/TBhn/YLSQLKoFkm3D4+ZbiRRFMC+FnMJ+DFaSLSNTJze9
         oCCAO+1jvkhKqraPmKzjK/gYr8nuEexebKDg1U1HR+ZCjhleQ589m1GzrLNxlGWHmNwD
         +gdsWqwAelOlICXuUkjqAQNmG8MAxfst8YiEH5wyb0SvERTx9rzG5RiJKT2PMra9ieJK
         L4cUTo31L1EpP8001Q4xX8CNowvON8ajgIHzOr4E9OAgcTjQziWeRHkofD+oPurJZw3p
         6tDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720618964; x=1721223764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYo7hiyQeiuXBsG523lCpU3OjDoScc8p3LqrHOuQZw8=;
        b=plipHNAjZQbBAv8/+jFMWJjGjmSD6kX8Vn/7ZgTjaloUP57wdKsufWr4W2balwxhX7
         a4uTeTNWrhtVJjOaZRIUK+nzPSfzB6NfpsoiXS+T1S0puyLG6+Zb2epfZG01mcs4gghh
         Undx6Fu+NBHwQo1qtxUmw9qkAY7mcq5IygIuX0klXId1UWgzzqoUPFeGZ2o33nYli8lI
         FoeYplD6dX7EPds/9l9kzvPR7iHdFykKxcOq42GbNdg9dc7ai7cUiE7ub0PZfD7S9kny
         2NGhpwEdQsGrxi2MfvSLxe2heJGRNFyj4sKn+CKuc/TKGEwPLKc7QNZomhjEIzE4LLsL
         duvw==
X-Forwarded-Encrypted: i=1; AJvYcCUrok0qyzHOX56emRRDpu7WP30DaIkrqQwLYI9NYdTQyOA8jl727ke9FwPZivNPCp8+BZgFne/WmTmfr7xC7EFd01CWeJSnGxbT
X-Gm-Message-State: AOJu0Yyk9r4KsygJrqaA4KrwXoS+P7CdZpWgDvPISZFsmhnXcO13uZsT
	hT3DlQOhXc8zUVJbZL9WleEjDPAFTvlTwKN3xZC4LMsTt6r6QW5xVQxOjKOcfNUTZL/FfN0OzHU
	aJdQ=
X-Google-Smtp-Source: AGHT+IEKatB3eqFgez+wXc1iMLGNbwHvkjmaIQf9kU0G+YZPSgDIUnJE7UlX38DLcJq5LYXxTX1LPA==
X-Received: by 2002:a4a:6c4:0:b0:5c4:68b8:e27f with SMTP id 006d021491bc7-5c68e19136bmr5609120eaf.6.1720618964379;
        Wed, 10 Jul 2024 06:42:44 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c68cd9a709sm674614eaf.22.2024.07.10.06.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 06:42:43 -0700 (PDT)
Date: Wed, 10 Jul 2024 19:12:29 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH v6 11/17] ACPI: RISC-V: Initialize GSI mapping structures
Message-ID: <Zo6PxdFM2GzTV1yc@sunil-laptop>
References: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
 <20240601150411.1929783-12-sunilvl@ventanamicro.com>
 <Zo5mMiWbEtKEeZ2r@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo5mMiWbEtKEeZ2r@lpieralisi>

On Wed, Jul 10, 2024 at 12:45:06PM +0200, Lorenzo Pieralisi wrote:
> On Sat, Jun 01, 2024 at 08:34:05PM +0530, Sunil V L wrote:
> > RISC-V has PLIC and APLIC in MADT as well as namespace devices.
> > Initialize the list of those structures using MADT and namespace devices
> > to create mapping between the ACPI handle and the GSI ranges. This will
> > be used later to add dependencies.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/irq.h |  22 ++++++
> >  drivers/acpi/riscv/init.c    |   2 +
> >  drivers/acpi/riscv/init.h    |   4 +
> >  drivers/acpi/riscv/irq.c     | 142 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 170 insertions(+)
> >  create mode 100644 drivers/acpi/riscv/init.h
> > 
> > diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
> > index 8e10a94430a2..44a0b128c602 100644
> > --- a/arch/riscv/include/asm/irq.h
> > +++ b/arch/riscv/include/asm/irq.h
> > @@ -16,4 +16,26 @@ void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void));
> >  
> >  struct fwnode_handle *riscv_get_intc_hwnode(void);
> >  
> > +#ifdef CONFIG_ACPI
> > +
> > +enum riscv_irqchip_type {
> > +	ACPI_RISCV_IRQCHIP_INTC		= 0x00,
> > +	ACPI_RISCV_IRQCHIP_IMSIC	= 0x01,
> > +	ACPI_RISCV_IRQCHIP_PLIC		= 0x02,
> > +	ACPI_RISCV_IRQCHIP_APLIC	= 0x03,
> > +};
> > +
> > +int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
> > +			    u32 *id, u32 *nr_irqs, u32 *nr_idcs);
> > +struct fwnode_handle *riscv_acpi_get_gsi_domain_id(u32 gsi);
> > +
> > +#else
> > +static inline int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
> > +					  u32 *id, u32 *nr_irqs, u32 *nr_idcs)
> > +{
> > +	return 0;
> > +}
> > +
> > +#endif /* CONFIG_ACPI */
> > +
> >  #endif /* _ASM_RISCV_IRQ_H */
> > diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
> > index 5f7571143245..22db97f7a772 100644
> > --- a/drivers/acpi/riscv/init.c
> > +++ b/drivers/acpi/riscv/init.c
> > @@ -6,7 +6,9 @@
> >   */
> >  
> >  #include <linux/acpi.h>
> > +#include "init.h"
> >  
> >  void __init acpi_riscv_init(void)
> >  {
> > +	riscv_acpi_init_gsi_mapping();
> >  }
> > diff --git a/drivers/acpi/riscv/init.h b/drivers/acpi/riscv/init.h
> > new file mode 100644
> > index 000000000000..0b9a07e4031f
> > --- /dev/null
> > +++ b/drivers/acpi/riscv/init.h
> > @@ -0,0 +1,4 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#include <linux/init.h>
> > +
> > +void __init riscv_acpi_init_gsi_mapping(void);
> > diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
> > index f56e103a501f..0473428e8d1e 100644
> > --- a/drivers/acpi/riscv/irq.c
> > +++ b/drivers/acpi/riscv/irq.c
> > @@ -7,6 +7,21 @@
> >  
> >  #include <linux/acpi.h>
> >  #include <linux/sort.h>
> > +#include <linux/irq.h>
> > +
> > +#include "init.h"
> > +
> > +struct riscv_ext_intc_list {
> > +	acpi_handle handle;
> > +	u32 gsi_base;
> > +	u32 nr_irqs;
> > +	u32 nr_idcs;
> > +	u32 id;
> > +	u32 type;
> > +	struct list_head list;
> > +};
> > +
> > +LIST_HEAD(ext_intc_list);
> >  
> >  static int irqchip_cmp_func(const void *in0, const void *in1)
> >  {
> > @@ -30,3 +45,130 @@ void arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr)
> >  		return;
> >  	sort(ape, nr, sizeof(*ape), irqchip_cmp_func, NULL);
> >  }
> > +
> > +static void riscv_acpi_update_gsi_handle(u32 gsi_base, acpi_handle handle)
> > +{
> > +	struct riscv_ext_intc_list *ext_intc_element;
> > +	struct list_head *i, *tmp;
> > +
> > +	list_for_each_safe(i, tmp, &ext_intc_list) {
> > +		ext_intc_element = list_entry(i, struct riscv_ext_intc_list, list);
> > +		if (gsi_base == ext_intc_element->gsi_base) {
> > +			ext_intc_element->handle = handle;
> > +			return;
> > +		}
> > +	}
> > +
> > +	acpi_handle_err(handle, "failed to find the GSI mapping entry\n");
> > +}
> > +
> > +int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
> > +			    u32 *id, u32 *nr_irqs, u32 *nr_idcs)
> > +{
> > +	struct riscv_ext_intc_list *ext_intc_element;
> > +	struct list_head *i, *tmp;
> > +
> > +	list_for_each_safe(i, tmp, &ext_intc_list) {
> > +		ext_intc_element = list_entry(i, struct riscv_ext_intc_list, list);
> > +		if (ext_intc_element->handle == ACPI_HANDLE_FWNODE(fwnode)) {
> > +			*gsi_base = ext_intc_element->gsi_base;
> > +			*id = ext_intc_element->id;
> > +			*nr_irqs = ext_intc_element->nr_irqs;
> > +			if (nr_idcs)
> > +				*nr_idcs = ext_intc_element->nr_idcs;
> > +
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	return -ENODEV;
> > +}
> > +
> > +struct fwnode_handle *riscv_acpi_get_gsi_domain_id(u32 gsi)
> > +{
> > +	struct riscv_ext_intc_list *ext_intc_element;
> > +	struct acpi_device *adev;
> > +	struct list_head *i, *tmp;
> > +
> > +	list_for_each_safe(i, tmp, &ext_intc_list) {
> > +		ext_intc_element = list_entry(i, struct riscv_ext_intc_list, list);
> > +		if (gsi >= ext_intc_element->gsi_base &&
> > +		    gsi < (ext_intc_element->gsi_base + ext_intc_element->nr_irqs)) {
> > +			adev = acpi_fetch_acpi_dev(ext_intc_element->handle);
> > +			if (!adev)
> > +				return NULL;
> > +
> > +			return acpi_fwnode_handle(adev);
> > +		}
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static int __init riscv_acpi_register_ext_intc(u32 gsi_base, u32 nr_irqs, u32 nr_idcs,
> > +					       u32 id, u32 type)
> > +{
> > +	struct riscv_ext_intc_list *ext_intc_element;
> > +
> > +	ext_intc_element = kzalloc(sizeof(*ext_intc_element), GFP_KERNEL);
> > +	if (!ext_intc_element)
> > +		return -ENOMEM;
> > +
> > +	ext_intc_element->gsi_base = gsi_base;
> > +	ext_intc_element->nr_irqs = nr_irqs;
> > +	ext_intc_element->nr_idcs = nr_idcs;
> > +	ext_intc_element->id = id;
> > +	list_add_tail(&ext_intc_element->list, &ext_intc_list);
> > +	return 0;
> > +}
> > +
> > +static acpi_status __init riscv_acpi_create_gsi_map(acpi_handle handle, u32 level,
> > +						    void *context, void **return_value)
> > +{
> > +	acpi_status status;
> > +	u64 gbase;
> > +
> > +	if (!acpi_has_method(handle, "_GSB")) {
> > +		acpi_handle_err(handle, "_GSB method not found\n");
> > +		return AE_OK;
> > +	}
> > +
> > +	status = acpi_evaluate_integer(handle, "_GSB", NULL, &gbase);
> > +	if (ACPI_FAILURE(status)) {
> > +		acpi_handle_err(handle, "failed to evaluate _GSB method\n");
> > +		return AE_OK;
> > +	}
> > +
> > +	riscv_acpi_update_gsi_handle((u32)gbase, handle);
> > +	return AE_OK;
> > +}
> > +
> > +static int __init riscv_acpi_aplic_parse_madt(union acpi_subtable_headers *header,
> > +					      const unsigned long end)
> > +{
> > +	struct acpi_madt_aplic *aplic = (struct acpi_madt_aplic *)header;
> > +
> > +	return riscv_acpi_register_ext_intc(aplic->gsi_base, aplic->num_sources, aplic->num_idcs,
> > +					    aplic->id, ACPI_RISCV_IRQCHIP_APLIC);
> > +}
> > +
> > +static int __init riscv_acpi_plic_parse_madt(union acpi_subtable_headers *header,
> > +					     const unsigned long end)
> > +{
> > +	struct acpi_madt_plic *plic = (struct acpi_madt_plic *)header;
> > +
> > +	return riscv_acpi_register_ext_intc(plic->gsi_base, plic->num_irqs, 0,
> > +					    plic->id, ACPI_RISCV_IRQCHIP_PLIC);
> > +}
> > +
> > +void __init riscv_acpi_init_gsi_mapping(void)
> > +{
> > +	/* There can be either PLIC or APLIC */
> > +	if (acpi_table_parse_madt(ACPI_MADT_TYPE_PLIC, riscv_acpi_plic_parse_madt, 0) > 0) {
> > +		acpi_get_devices("RSCV0001", riscv_acpi_create_gsi_map, NULL, NULL);
> > +		return;
> > +	}
> > +
> > +	if (acpi_table_parse_madt(ACPI_MADT_TYPE_APLIC, riscv_acpi_aplic_parse_madt, 0) > 0)
> > +		acpi_get_devices("RSCV0002", riscv_acpi_create_gsi_map, NULL, NULL);
> > +}
> 
> I don't know if it is needed in RISC-V - it is a question - but how would you
> resolve a GSI mapping before the ACPI intepreter is initialized ?
> 
> This model relies on the _GSB method to be called on the interrupt controller
> device to discover the GSI range it actually covers, I was wondering how this
> works for "devices" (eg components described in static table, eg timers)
> that require a GSI mapping before you are able to retrieve the required
> information from the namespace devices.
> 
Hi Lorenzo,

This model is based on the idea of _DEP method to describe dependencies
between devices and interrupt controller. So, you are right it needs
interpreter to be up. RISC-V doesn't have devices like timers defined in
a static table. Every other platform device which needs GSIs should be
defined in the namespace.

Thanks,
Sunil


