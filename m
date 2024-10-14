Return-Path: <linux-pci+bounces-14486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3731699D4B1
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 18:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B6F288D11
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 16:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CE72595;
	Mon, 14 Oct 2024 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rrQud1Bm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wPq0vw4z"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3126B231C92;
	Mon, 14 Oct 2024 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923496; cv=none; b=CSaCtZpkp3Wb161pg9GZUjyQPOuFk/EjJT8pOwkpzDcIVJvH5TQLiMyOme+EGxCH0T7CyDaVYCNVH8y9cHqTe9L6FvU6mHGJXsP7ws8qXgdI5+GdQ1KyFFD+qX+E5ORDLam3vMddaLVc8zaJdYs5ywjHTXfxTpy+7solSblMxV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923496; c=relaxed/simple;
	bh=hRoA3ccR5Y8oRXRdOMvMWRGqLfR7Pm1OrtYuVHblhug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JR/GpQ1NPWc+kgepWLK+mZ16V4ldnUq1jGk5setQXY6jmnI9bsz7jW7BgcDqJEqT1ky9k3lQ19HjdETZdzN2Cn8FAUUtumDLZVzrDwvVwz4KulkE+4nsxJICTBXPixDAfsrLlh4+waO/HhSZe/H3N1hsTBz2Jrt81oy8rwxwcwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rrQud1Bm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wPq0vw4z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728923492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ow/UxrNjYbB9p7imk5iwLyMoJAD0hoXV5EJONRnoywA=;
	b=rrQud1Bmrb6k1OJO8EmZWxF/QUHGHoo6snHSxtVUgsEFeCxNzJ4q1QMFXvIBHiCXLrKOnp
	5n2zfs4cjvMRW84uP2ReREOXB4GsDYWko8jIDJkr9l+9zdO8YwS26aL6ZSWCDjRud13enR
	KsHcpVLiarsShJnRVFn4EhH3D+c78VhqrZZnmHAwIZ55bCGCLkxhmQ/ki2Ny5NpX5G+FiT
	4el9dkx2BNEHvetIh2DFvh54IORDpOroEmPDh5UZ/bgbVFpY3DjPUqwrOzaJX72HycQoPj
	jBUluAEhaic3IhLOaOiqXwD4Lzr/iEcOr5BdHwPnyX7HYGY6YL619CT/VYHswQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728923492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ow/UxrNjYbB9p7imk5iwLyMoJAD0hoXV5EJONRnoywA=;
	b=wPq0vw4zgDf7pPyiwHAm5p05qXTlNkIJPC5VQTxfHidMe8ODXZEdfMPPimcsSbxLQli+/+
	ZLuoGkIRW8RucaDg==
To: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 kw@linux.com, Philipp Zabel <p.zabel@pengutronix.de>, Andrea della Porta
 <andrea.porta@suse.com>, Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Stanimir Varbanov <svarbanov@suse.de>
Subject: Re: [PATCH v3 03/11] irqchip: mip: Add Broadcom bcm2712 MSI-X
 interrupt controller
In-Reply-To: <20241014130710.413-4-svarbanov@suse.de>
References: <20241014130710.413-1-svarbanov@suse.de>
 <20241014130710.413-4-svarbanov@suse.de>
Date: Mon, 14 Oct 2024 18:31:32 +0200
Message-ID: <87o73mfxy3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


> Subject: irqchip: mip:

is not a valid prefix

Just make it: irqchip: Add Broadcom  .....

> +static int mip_middle_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				   unsigned int nr_irqs, void *arg)
> +{
> +	struct mip_priv *mip = domain->host_data;
> +	struct irq_fwspec fwspec = {0};
> +	struct irq_data *irqd;
> +	unsigned int hwirq, irq, i;

	unsigned int hwirq, irq, i;
	struct irq_data *irqd;

> +
> +#define MIP_MSI_FLAGS_REQUIRED	(MSI_FLAG_USE_DEF_DOM_OPS |	\
> +				 MSI_FLAG_USE_DEF_CHIP_OPS |	\
> +				 MSI_FLAG_PCI_MSI_MASK_PARENT |	\
> +				 MSI_FLAG_PCI_MSIX)

Why are you requiring MSI_FLAG_PCI_MSIX here? That's a supported flag,
not a required one.

> +#define MIP_MSI_FLAGS_SUPPORTED	(MSI_GENERIC_FLAGS_MASK |	\
> +				 MSI_FLAG_PCI_MSIX |		\

So this does not support multi MSI, but your allocation function looks
like it supports it (nr_irqs is not range checked).

> +				 IRQ_DOMAIN_FLAG_MSI_PARENT)

This is not a MSI flag and has no place here.

> +static const struct msi_parent_ops mip_msi_parent_ops = {
> +	.supported_flags	= MIP_MSI_FLAGS_SUPPORTED,
> +	.required_flags		= MIP_MSI_FLAGS_REQUIRED,
> +	.bus_select_token       = DOMAIN_BUS_PCI_MSI,
> +	.bus_select_mask	= MATCH_PCI_MSI,
> +	.prefix			= "MIP-MSI-",
> +	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
> +};
> +
> +static int mip_init_domains(struct mip_priv *mip, struct device_node *np)
> +{
> +	struct irq_domain *middle;
> +
> +	middle = irq_domain_add_hierarchy(mip->parent, 0, mip->num_msis, np,
> +					  &mip_middle_domain_ops, mip);
> +	if (!middle)
> +		return -ENOMEM;
> +
> +	irq_domain_update_bus_token(middle, DOMAIN_BUS_PCI_MSI);

That's the wrong token. DOMAIN_BUS_PCI_MSI is what the v2 global PCI/MSI
domain uses. But that's not what this is about. This is the parent
domain for PCI/MSI. DOMAIN_BUS_GENERIC_MSI or DOMAIN_BUS_NEXUS is what
you want here.

> +	middle->dev = mip->dev;
> +	middle->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
> +	middle->msi_parent_ops = &mip_msi_parent_ops;
> +

Other than this, this looks good now.

Thanks,

        tglx

