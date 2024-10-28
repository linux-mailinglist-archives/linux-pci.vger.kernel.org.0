Return-Path: <linux-pci+bounces-15493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2A19B3B08
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 21:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C44E1F22155
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 20:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF041DF251;
	Mon, 28 Oct 2024 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wCWqvspG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rRTjLwKv"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E667A3A1DB;
	Mon, 28 Oct 2024 20:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730146010; cv=none; b=jVYFci2gw5tLojdDFjyTf3P0INiK0I5tyZe5rq3drk/t3OKJ9WymeHCwt5F413RG4Mxk+ghsvC3/Rkkn+1AoNj4iNPKlzEjqtxlAfK6H5oNEKfXdWoW1jpZ148RNtiEfTdcrDArWXmoCeF1pvW3vz+CkVXiTo4ixGCpEwM6Wd8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730146010; c=relaxed/simple;
	bh=hI/JQPkLA+5n9iK5TZxs1ugSGqsg3kjsm0HaXAbtwtc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RgFHKamc1t7Rb9h2d2YrEhUPVitRtwW20Ys2igoA+pWSw4PCgDe1/A5jgJGaREvz7h0eEOADkoeDm0KrnfiBJaYZtzSLtKXoufzebId5YDGgnAByvL2K4/WXveVPpgi15lLAN4EyrOxhxxOGpDx9OAh57BA0tX0s1+2JvfgJ1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wCWqvspG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rRTjLwKv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730146005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N+Os3sIDkyLTxp+Q1Etclyz80BkquFk+b0V9pAR3X4c=;
	b=wCWqvspGE9QIMaJUGyQdB933wfrC6rd/+gheavMM5coROFeRKoleVj5oP8V/3rjek0e1F1
	HqjkRUJkYCyk8JQOCfLJN6t/+bQ1yF7IkG7eyMLXzI2JMQRQeB+uGwlSvieHnlfGD/WhkZ
	+WfMQprkjMzvZBSyVq2Ak2jisHyYBgCwFKtFoP5R2YxGI+a3uq8vD1VDdPZ4xn1es7/oaP
	5CwHLFc/pOUpeLJjt6Ht4FlIz21tAv4w3HKIMR1DJq0FPTam0QPG9aIC10vlkFqyGfPHGK
	aZJp5xX04/3cCkjmX6yDDviCees69d9G1X4TurGT6gkAcuFHjueyqKtNnZ5wvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730146005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N+Os3sIDkyLTxp+Q1Etclyz80BkquFk+b0V9pAR3X4c=;
	b=rRTjLwKvdpfoRhvKvGp33/j4XmzKcTNajXe2Xl17clcpcPsppXfrXC1itt+abaBYDLLBkA
	yoKPdoF+o+ucmoDA==
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
Subject: Re: [PATCH v4 03/10] irqchip: Add Broadcom bcm2712 MSI-X interrupt
 controller
In-Reply-To: <20241025124515.14066-4-svarbanov@suse.de>
References: <20241025124515.14066-1-svarbanov@suse.de>
 <20241025124515.14066-4-svarbanov@suse.de>
Date: Mon, 28 Oct 2024 21:06:45 +0100
Message-ID: <87ttcw0z6y.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 25 2024 at 15:45, Stanimir Varbanov wrote:

> Add an interrupt controller driver for MSI-X Interrupt Peripheral (MIP)
> hardware block found in bcm2712. The interrupt controller is used to
> handle MSI-X interrupts from peripherials behind PCIe endpoints like
> RP1 south bridge found in RPi5.
>
> There are two MIPs on bcm2712, the first has 64 consecutive SPIs
> assigned to 64 output vectors, and the second has 17 SPIs, but only
> 8 of them are consecutive starting at the 8th output vector.

This starts to converge nicely. Just a few remaining nitpicks.

> +static int mip_alloc_hwirq(struct mip_priv *mip, unsigned int nr_irqs,
> +			   unsigned int *hwirq)
> +{
> +	int bit;
> +
> +	spin_lock(&mip->lock);
> +	bit = bitmap_find_free_region(mip->bitmap, mip->num_msis,
> +				      ilog2(nr_irqs));
> +	spin_unlock(&mip->lock);

This should be

        scoped_guard(spinlock, &mip->lock)
		bit = bitmap_find_free_region(mip->bitmap, mip->num_msis, ilog2(nr_irqs));

> +	if (bit < 0)
> +		return bit;
> +
> +	if (hwirq)
> +		*hwirq = bit;

But what's the point of this conditional? The only call site hands in a
valid pointer, no?

> +	return 0;

And therefore the whole thing can be simplified to:

static int mip_alloc_hwirq(struct mip_priv *mip, unsigned int nr_irqs)
{
        guard(spinlock)(&mip_lock);
        return bitmap_find_free_region(mip->bitmap, mip->num_msis, ilog2(nr_irqs));
}

and the callsite becomes:

        irq = mip_alloc_hwirq(mip, nr_irqs);
        if (irq < 0)
        	return irq;
Hmm?

> +}
> +
> +static void mip_free_hwirq(struct mip_priv *mip, unsigned int hwirq,
> +			   unsigned int nr_irqs)
> +{
> +	spin_lock(&mip->lock);

	guard(spinlock)(&mip->lock);

> +	bitmap_release_region(mip->bitmap, hwirq, ilog2(nr_irqs));
> +	spin_unlock(&mip->lock);
> +}

> +	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &fwspec);
> +	if (ret) {
> +		mip_free_hwirq(mip, irq, nr_irqs);
> +		return ret;

                goto err_free_hwirq; ?

> +	}
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		irqd = irq_domain_get_irq_data(domain->parent, virq + i);
> +		irqd->chip->irq_set_type(irqd, IRQ_TYPE_EDGE_RISING);
> +
> +		ret = irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> +						    &mip_middle_irq_chip, mip);
> +		if (ret)
> +			goto err_free;
> +
> +		irqd = irq_get_irq_data(virq + i);
> +		irqd_set_single_target(irqd);
> +		irqd_set_affinity_on_activate(irqd);
> +	}
> +
> +	return 0;
> +
> +err_free:
> +	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
> +	mip_free_hwirq(mip, irq, nr_irqs);
> +	return ret;
> +}
> +
> +static int __init mip_of_msi_init(struct device_node *node,
> +				  struct device_node *parent)

No line break required here.

> +{
> +	struct platform_device *pdev;
> +	struct mip_priv *mip;
> +	int ret;
> +
> +	pdev = of_find_device_by_node(node);
> +	of_node_put(node);
> +	if (!pdev)
> +		return -EPROBE_DEFER;
> +
> +	mip = kzalloc(sizeof(*mip), GFP_KERNEL);
> +	if (!mip)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&mip->lock);
> +	mip->dev = &pdev->dev;
> +
> +	ret = mip_parse_dt(mip, node);
> +	if (ret)
> +		goto err_priv;
> +
> +	mip->base = of_iomap(node, 0);
> +	if (!mip->base) {
> +		ret = -ENXIO;
> +		goto err_priv;
> +	}
> +
> +	mip->bitmap = bitmap_zalloc(mip->num_msis, GFP_KERNEL);
> +	if (!mip->bitmap) {
> +		ret = -ENOMEM;
> +		goto err_base;
> +	}
> +
> +	/*
> +	 * All MSI-X masked in for the host, masked out for the
> +	 * VPU, and edge-triggered.
> +	 */
> +	writel(0, mip->base + MIP_INT_MASKL_HOST);
> +	writel(0, mip->base + MIP_INT_MASKH_HOST);
> +	writel(~0, mip->base + MIP_INT_MASKL_VPU);
> +	writel(~0, mip->base + MIP_INT_MASKH_VPU);
> +	writel(~0, mip->base + MIP_INT_CFGL_HOST);
> +	writel(~0, mip->base + MIP_INT_CFGH_HOST);

What undoes that in case mpi_init_domains() fails? Or is it harmless? I
really have no idea what masked in and masked out means here.

> +	dev_dbg(&pdev->dev,
> +		"MIP: MSI-X count: %u, base: %u, offset: %u, msg_addr: %llx\n",

Please move the string up. You have 100 characters width available.

> +		mip->num_msis, mip->msi_base, mip->msi_offset, mip->msg_addr);

Thanks,

        tglx

