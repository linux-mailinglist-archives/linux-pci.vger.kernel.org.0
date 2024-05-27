Return-Path: <linux-pci+bounces-7835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622128CF88D
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 06:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 179B0281103
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 04:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADAFD50F;
	Mon, 27 May 2024 04:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dWKQEvs+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9575279F6
	for <linux-pci@vger.kernel.org>; Mon, 27 May 2024 04:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716785543; cv=none; b=qs/O3+gjiiRsaY3K2Wn1mUV1kfljjLIBEVVi51vxGZHzKP4VQqvjtRvP1Baoz1eSKw9P4vm94j/rOX3sHFu7WhC9+9EAG63EY0KxpUyhZzgB/yc+btAXcG0z9R9JEy1GYcq6aRh8qbs2wHi27rLc36rvtSl0dfPep9LRwH0ahoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716785543; c=relaxed/simple;
	bh=AMS5ARv3IfVq3Q8iY1GykVsvHQU5Z7iIP9RDyXjiVic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/OkZZUscFkPaleQhMdmXJx6HAODoONx+ip2lB54ARc27gchEFyMmKd7pPMHXGwsR7h9qCzRuakgxW/px25GRIWwVjepTTg9RauCQ79n0OSpwrUOdI7jg4fzhykYc1szJRiPx+g/9z4xKo4J4SVBVEpVVTLXj/KtAxMMJTYc+QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dWKQEvs+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f6911d16b4so5459727b3a.3
        for <linux-pci@vger.kernel.org>; Sun, 26 May 2024 21:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1716785541; x=1717390341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7OwVnHZBL6wTRkCGzMu3WG8eEJumBpr030yY2OMz5XY=;
        b=dWKQEvs+MUTWbvLggpmH8Z1VlzQToXz6qDtzRkfM9GD7TN8aA5BcNyYw8jb0JW2+hp
         HZkmCiilUQjK98mkgOmC22CZS//ttmdsGnlmxzHzextBSN7o261fjlen6QgQ+dJ4191F
         KeKpwDSwcNQ1bG4gKwYP0tvvia0mcEwima8BMKeuPIeGNM9pG1TImkbVcMvfRc3HZTB/
         vh+ZYZIhfayqaeXoOiu314yDzDbex13irUdVMsrG3X5DL5Fbc0CbpgrIMrN+ewMB10uO
         4R/WV2IBms1XnS3iP+o5+vhBnanpl/y387LJ/yGE0ZbapvvNFyDayr+RB5I1RIcULxwh
         xr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716785541; x=1717390341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OwVnHZBL6wTRkCGzMu3WG8eEJumBpr030yY2OMz5XY=;
        b=cfE2WmxEwVet108L61UEIhkVwy/oU53S36KoxlSvO66ABRp5niZLR3JE5hKuvxW4+R
         capQI09Y4oABZJiF/rbS13Pjdji+TcwUdgfs6qam6VlT+zggUYHn3Nrs9DIneCtU4DxK
         66qZyXTjpHSZMsZf9VfAPYpRygIqeDLFc8UP3n5zHKnw/6sJZR+6oTjZPlt7USp+6f4B
         HmuAqzxo6i66qqukpQL2coAi6gXHfzi6rpoq5PttsC2YpLTttY5Mpu03YXO3HUt5Y18q
         ccbAf2M4Ex71eEni/QH7jV3zt8QGPQv0JV0HUdp/N4WNx2balabqKiOyPESCB/NMyzpj
         rh2g==
X-Forwarded-Encrypted: i=1; AJvYcCXXdnn3ImOlNlm0iGdqx2jgrcit0Y8KqHPVvmkkGJUtDFmTtTrHKu97cvoLr3OYHWX+YuTZ3Tz7DA1YutRxQz++FjX/FXtqxg1Q
X-Gm-Message-State: AOJu0YyQijiYEboo7mGN0/YaxgaO/tRQa2UZ0xbzXOZZJ+JBlOqdPhPi
	Y2z8ANtJ/oCvnpiTl0ZMmI0I2iV/QTW8uombZ0x3SEISgcmYMI4FGdFAVUS88JQ=
X-Google-Smtp-Source: AGHT+IH1+6Rmi8dE36D+B+xJAB7lUPPIYa2o+TDUzseyC6rijf8D9sllaHoXY4NG8W+kwmTTtncYfQ==
X-Received: by 2002:a05:6a21:191:b0:1a9:d6e2:66e9 with SMTP id adf61e73a8af0-1b212d4aee2mr9906286637.28.1716785540658;
        Sun, 26 May 2024 21:52:20 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f483584be5sm19427935ad.258.2024.05.26.21.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 21:52:20 -0700 (PDT)
Date: Mon, 27 May 2024 10:22:08 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>
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
Subject: Re: [PATCH v5 14/17] irqchip/riscv-imsic: Add ACPI support
Message-ID: <ZlQReOytuJcMsXUW@sunil-laptop>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-15-sunilvl@ventanamicro.com>
 <871q5sfatm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q5sfatm.ffs@tglx>

On Fri, May 24, 2024 at 12:00:21AM +0200, Thomas Gleixner wrote:
> On Wed, May 01 2024 at 17:47, Sunil V L wrote:
> 
> > RISC-V IMSIC interrupt controller provides IPI and MSI support.
> > Currently, DT based drivers setup the IPI feature early during boot but
> > defer setting up the MSI functionality. However, in ACPI systems, ACPI,
> > both IPI and MSI features need to be initialized early itself.
> 
> Why?
> 
Sorry, commit message got truncated by mistake. Basically, in ACPI PCI
scan happens very early and there is no concept of msi-parent/dependency
on MSI controller like in DT. It just assumes MSI is setup already. Due
to this, we need to setup MSI controller early as well.

> > +
> > +#ifdef CONFIG_ACPI
> > +
> > +static struct fwnode_handle *imsic_acpi_fwnode;
> > +
> > +struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev)
> 
> Why is this function global? It's only used in the very same file and
> under the same CONFIG_ACPI #ifdef, no?
> 
For platform devices using MSIs, we need a way to determine the MSI
domain. This function is exported so that platform device like
APLIC/IOMMU can find the MSI irqdomain.

For PCI, pci_msi_register_fwnode_provider() is registered by the MSI
driver for this purpose.

Let me know if this can be made better.

> > +{
> > +	return imsic_acpi_fwnode;
> > +}
> > +
> > +static int __init imsic_early_acpi_init(union acpi_subtable_headers *header,
> > +					const unsigned long end)
> > +{
> > +	struct acpi_madt_imsic *imsic = (struct acpi_madt_imsic *)header;
> > +	int rc;
> > +
> > +	imsic_acpi_fwnode = irq_domain_alloc_named_fwnode("imsic");
> > +	if (!imsic_acpi_fwnode) {
> > +		pr_err("unable to allocate IMSIC FW node\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/* Setup IMSIC state */
> > +	rc = imsic_setup_state(imsic_acpi_fwnode, (void *)imsic);
> 
> Pointless (void *) cast.
> 
Okay.

> > +	if (rc) {
> > +		pr_err("%pfwP: failed to setup state (error %d)\n", imsic_acpi_fwnode, rc);
> > +		return rc;
> > +	}
> > +
> > +	/* Do early setup of IMSIC state and IPIs */
> > +	rc = imsic_early_probe(imsic_acpi_fwnode);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = imsic_platform_acpi_probe(imsic_acpi_fwnode);
> > +
> > +#ifdef CONFIG_PCI
> > +	if (!rc)
> > +		pci_msi_register_fwnode_provider(&imsic_acpi_get_fwnode);
> > +#endif
> > +
> > +	return rc;
> 
> Any error return in this function leaks the firmware node and probably
> some more stuff.
>
Yeah, fwnode needs free up and need to update the code a bit. Thanks!
 
> > +}
> > +
> > +IRQCHIP_ACPI_DECLARE(riscv_imsic, ACPI_MADT_TYPE_IMSIC, NULL,
> > +		     1, imsic_early_acpi_init);
> > +#endif
> 
> ...
> 
> > -	/* Find number of interrupt identities */
> > -	rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-ids",
> > -				  &global->nr_ids);
> > -	if (rc) {
> > -		pr_err("%pfwP: number of interrupt identities not found\n", fwnode);
> > -		return rc;
> > +		/* Find number of guest interrupt identities */
> > +		rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-guest-ids",
> > +					  &global->nr_guest_ids);
> > +		if (rc)
> > +			global->nr_guest_ids = global->nr_ids;
> > +	} else {
> > +		global->guest_index_bits = imsic->guest_index_bits;
> > +		global->hart_index_bits = imsic->hart_index_bits;
> > +		global->group_index_bits = imsic->group_index_bits;
> > +		global->group_index_shift = imsic->group_index_shift;
> > +		global->nr_ids = imsic->num_ids;
> > +		global->nr_guest_ids = imsic->num_guest_ids;
> >  	}
> 
> Seriously?
> 
> Why can't you just split out the existing DT code into a separate
> function in an initial patch which avoulds all of this unreviewable
> churn of making the DT stuff indented ?
> 
Sure, makes sense. let me create separate patch first as you suggested.

> > +#ifdef CONFIG_ACPI
> > +int imsic_platform_acpi_probe(struct fwnode_handle *fwnode);
> > +struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev);
> > +#else
> > +static inline struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev)
> > +{
> > +	return NULL;
> > +}
> > +#endif
> 
> Oh well.
> 
I guess this is related to your prior comment about the need to make
this public function. Let me know if I am missing something.

Thanks!
Sunil

