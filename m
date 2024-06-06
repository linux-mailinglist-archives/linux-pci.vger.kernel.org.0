Return-Path: <linux-pci+bounces-8406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6701D8FF147
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 17:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A28F1C20959
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 15:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9EB196DB0;
	Thu,  6 Jun 2024 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AqZcSkcx"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A01196DA8;
	Thu,  6 Jun 2024 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689214; cv=none; b=klS30aWJ72fGwdnzq88hDbXCLw83vR+mghU8ML4kFaBNkI20L/QOtaiNRLRu0ldVW52x/GVUCRy6xUMnvhU65yKfImdv7GMxvVmUhC1O/PkRaNgh1Jy6Z+brt6oWcrJ4vZa1IMpwY5N2m0SpJfQaKU3xBo6gFxJNAMCRVl3ZP3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689214; c=relaxed/simple;
	bh=EGRyH1GZKdAcDzaDXqk/xJjj5T/dqFdVpB9jjtRbMZs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qi3oY32TsC3i9jp+Ydc6u3GjAIIDTmLoDqolxIjqDYmDFckLuUtPf/PVATB8gSwHx0EA13DnGzKA2Ivj9i1RdXF4WxUyY1F42gsrUIbY3jSFXmywDtZnBuN7F402Cxrw1FHgTd9S3at+5g70kkW5dsYZDDF/bt79wdaRy7ntxEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AqZcSkcx; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C3BF40003;
	Thu,  6 Jun 2024 15:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717689204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ykb7pydzqzUmgumy7ROcbGm4j4AUrqIXRnSnq1EpQXA=;
	b=AqZcSkcxZ8Crl/9qpk/v7M8vuYCKh4/tDXfbnTEW9/weDi2Xamxb97hsVEQUCn2qoaGYCW
	R/6f+xbF8O72YibKV0D3kAbVnEnhVVIACWsyyZb95NSIHnPY9ED0/TmkY+1oDQYX6VSBS8
	HtkCEgTN4NzUwDbt/VBMZHh9fo7nKrgEJAJR/n+GWYSbkgObVi01Ei2/Id/o0Vmmm+ljmv
	T1cG4m4ehXh0OMB6bYFxwGfjs/O4JCiz22GNPWd0XkwkWKAoc7X3BRosrn0gbbuv6/vEvY
	ktMfyL92H/ximPOAeAH73BmY1JMlxGFzUby6si2qtodEczCaZOsANdTSrohUaw==
Date: Thu, 6 Jun 2024 17:53:17 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Simon Horman <horms@kernel.org>, Sai Krishna Gajula
 <saikrishnag@marvell.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lee Jones
 <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Saravana Kannan <saravanak@google.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Lars
 Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Allan
 Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 11/19] irqchip: Add support for LAN966x OIC
Message-ID: <20240606175317.62d476b0@bootlin.com>
In-Reply-To: <87frtr4goe.ffs@tglx>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
 <20240527161450.326615-12-herve.codina@bootlin.com>
 <87frtr4goe.ffs@tglx>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Thomas,

On Wed, 05 Jun 2024 16:17:53 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, May 27 2024 at 18:14, Herve Codina wrote:
> > +struct lan966x_oic_data {
> > +	struct irq_domain *domain;
> > +	void __iomem *regs;
> > +	int irq;
> > +};  
> 
> Please read Documentation/process/maintainers-tip.rst

I suppose you pointed out the un-tabular struct member names here.
I will fix that in the next iteration.

> 
> > +static int lan966x_oic_irq_set_type(struct irq_data *data,
> > +				    unsigned int flow_type)  
> 
> Please use the 100 character limit

Sure, will be fixed.

> 
> > +static struct lan966x_oic_chip_regs lan966x_oic_chip_regs[3] = {
> > +	{
> > +		.reg_off_ena_set = LAN966X_OIC_INTR_ENA_SET,
> > +		.reg_off_ena_clr = LAN966X_OIC_INTR_ENA_CLR,
> > +		.reg_off_sticky = LAN966X_OIC_INTR_STICKY,
> > +		.reg_off_ident = LAN966X_OIC_DST_INTR_IDENT(0),
> > +		.reg_off_map = LAN966X_OIC_DST_INTR_MAP(0),  
> 
> Please make this tabular. See doc.

Will be fixed.

> 
> > +static void lan966x_oic_chip_init(struct lan966x_oic_data *lan966x_oic,
> > +				  struct irq_chip_generic *gc,
> > +				  struct lan966x_oic_chip_regs *chip_regs)
> > +{
> > +	gc->reg_base = lan966x_oic->regs;
> > +	gc->chip_types[0].regs.enable = chip_regs->reg_off_ena_set;
> > +	gc->chip_types[0].regs.disable = chip_regs->reg_off_ena_clr;
> > +	gc->chip_types[0].regs.ack = chip_regs->reg_off_sticky;
> > +	gc->chip_types[0].chip.irq_startup = lan966x_oic_irq_startup;
> > +	gc->chip_types[0].chip.irq_shutdown = lan966x_oic_irq_shutdown;
> > +	gc->chip_types[0].chip.irq_set_type = lan966x_oic_irq_set_type;
> > +	gc->chip_types[0].chip.irq_mask = irq_gc_mask_disable_reg;
> > +	gc->chip_types[0].chip.irq_unmask = irq_gc_unmask_enable_reg;
> > +	gc->chip_types[0].chip.irq_ack = irq_gc_ack_set_bit;
> > +	gc->private = chip_regs;
> > +
> > +	/* Disable all interrupts handled by this chip */
> > +	irq_reg_writel(gc, ~0, chip_regs->reg_off_ena_clr);
> > +}
> > +
> > +static void lan966x_oic_chip_exit(struct irq_chip_generic *gc)
> > +{
> > +	/* Disable and ack all interrupts handled by this chip */
> > +	irq_reg_writel(gc, ~0, gc->chip_types[0].regs.disable);  
> 
> ~0U

Will be changed.

>   
> > +	irq_reg_writel(gc, ~0, gc->chip_types[0].regs.ack);
> > +}
> > +
> > +static int lan966x_oic_probe(struct platform_device *pdev)
> > +{
> > +	struct device_node *node = pdev->dev.of_node;
> > +	struct lan966x_oic_data *lan966x_oic;
> > +	struct device *dev = &pdev->dev;
> > +	struct irq_chip_generic *gc;
> > +	int ret;
> > +	int i;  
> 
> int ret, i;

Will be changed.

> 
> > +
> > +	lan966x_oic = devm_kmalloc(dev, sizeof(*lan966x_oic), GFP_KERNEL);
> > +	if (!lan966x_oic)
> > +		return -ENOMEM;
> > +
> > +	lan966x_oic->regs = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(lan966x_oic->regs))
> > +		return dev_err_probe(dev, PTR_ERR(lan966x_oic->regs),
> > +				     "failed to map resource\n");
> > +
> > +	lan966x_oic->domain = irq_domain_alloc_linear(of_node_to_fwnode(node),
> > +						      LAN966X_OIC_NR_IRQ,
> > +						      &irq_generic_chip_ops,
> > +						      NULL);
> > +	if (!lan966x_oic->domain) {
> > +		dev_err(dev, "failed to create an IRQ domain\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	lan966x_oic->irq = platform_get_irq(pdev, 0);
> > +	if (lan966x_oic->irq < 0) {
> > +		ret = dev_err_probe(dev, lan966x_oic->irq,
> > +				    "failed to get the IRQ\n");
> > +		goto err_domain_free;
> > +	}
> > +
> > +	ret = irq_alloc_domain_generic_chips(lan966x_oic->domain, 32, 1,
> > +					     "lan966x-oic", handle_level_irq, 0,
> > +					     0, 0);
> > +	if (ret) {
> > +		dev_err_probe(dev, ret, "failed to alloc irq domain gc\n");
> > +		goto err_domain_free;
> > +	}
> > +
> > +	/* Init chips */
> > +	BUILD_BUG_ON(DIV_ROUND_UP(LAN966X_OIC_NR_IRQ, 32) !=
> > +		     ARRAY_SIZE(lan966x_oic_chip_regs));
> > +	for (i = 0; i < ARRAY_SIZE(lan966x_oic_chip_regs); i++) {
> > +		gc = irq_get_domain_generic_chip(lan966x_oic->domain, i * 32);
> > +		lan966x_oic_chip_init(lan966x_oic, gc,
> > +				      &lan966x_oic_chip_regs[i]);
> > +	}
> > +
> > +	irq_set_chained_handler_and_data(lan966x_oic->irq,
> > +					 lan966x_oic_irq_handler,
> > +					 lan966x_oic->domain);
> > +
> > +	irq_domain_publish(lan966x_oic->domain);
> > +	platform_set_drvdata(pdev, lan966x_oic);
> > +	return 0;  
> 
> This is exactly what can be avoided.
> 
> > +
> > +err_domain_free:
> > +	irq_domain_free(lan966x_oic->domain);
> > +	return ret;
> > +}
> > +
> > +static void lan966x_oic_remove(struct platform_device *pdev)
> > +{
> > +	struct lan966x_oic_data *lan966x_oic = platform_get_drvdata(pdev);
> > +	struct irq_chip_generic *gc;
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(lan966x_oic_chip_regs); i++) {
> > +		gc = irq_get_domain_generic_chip(lan966x_oic->domain, i * 32);
> > +		lan966x_oic_chip_exit(gc);
> > +	}
> > +
> > +	irq_set_chained_handler_and_data(lan966x_oic->irq, NULL, NULL);
> > +
> > +	for (i = 0; i < LAN966X_OIC_NR_IRQ; i++)
> > +		irq_dispose_mapping(irq_find_mapping(lan966x_oic->domain, i));  
> 
> This is just wrong. You cannot remove the chip when there are still interrupts
> mapped.
> 
> I just did a quick conversion to the template approach. Unsurprisingly
> it removes 30 lines of boiler plate code:
> 
> +static void lan966x_oic_chip_init(struct irq_chip_generic *gc)
> +{
> +	struct lan966x_oic_data *lan966x_oic = gc->domain->host_data;
> +	struct lan966x_oic_chip_regs *chip_regs;
> +
> +	gc->reg_base = lan966x_oic->regs;
> +
> +	chip_regs = lan966x_oic_chip_regs + gc->irq_base / 32;
> +	gc->chip_types[0].regs.enable = chip_regs->reg_off_ena_set;
> +	gc->chip_types[0].regs.disable = chip_regs->reg_off_ena_clr;
> +	gc->chip_types[0].regs.ack = chip_regs->reg_off_sticky;
> +
> +	gc->chip_types[0].chip.irq_startup = lan966x_oic_irq_startup;
> +	gc->chip_types[0].chip.irq_shutdown = lan966x_oic_irq_shutdown;
> +	gc->chip_types[0].chip.irq_set_type = lan966x_oic_irq_set_type;
> +	gc->chip_types[0].chip.irq_mask = irq_gc_mask_disable_reg;
> +	gc->chip_types[0].chip.irq_unmask = irq_gc_unmask_enable_reg;
> +	gc->chip_types[0].chip.irq_ack = irq_gc_ack_set_bit;
> +	gc->private = chip_regs;
> +
> +	/* Disable all interrupts handled by this chip */
> +	irq_reg_writel(gc, ~0, chip_regs->reg_off_ena_clr);
> +}
> +
> +static void lan966x_oic_chip_exit(struct irq_chip_generic *gc)
> +{
> +	/* Disable and ack all interrupts handled by this chip */
> +	irq_reg_writel(gc, ~0, gc->chip_types[0].regs.disable);
> +	irq_reg_writel(gc, ~0, gc->chip_types[0].regs.ack);
> +}
> +
> +static void lan966x_oic_domain_init(struct irq_domain *d)
> +{
> +	struct lan966x_oic_data *lan966x_oic = d->host_data;
> +
> +	irq_set_chained_handler_and_data(lan966x_oic->irq, lan966x_oic_irq_handler, d);
> +}
> +
> +static int lan966x_oic_probe(struct platform_device *pdev)
> +{
> +	struct irq_domain_chip_generic_info gc_info = {
> +		.irqs_per_chip		= 32,
> +		.num_chips		= 1,
> +		.name			= "lan966x-oic"
> +		.handler		= handle_level_irq,
> +		.init			= lan966x_oic_chip_init,
> +		.destroy		= lan966x_oic_chip_exit,
> +	};
> +
> +	struct irq_domain_info info = {
> +		.fwnode			= of_node_to_fwnode(pdev->dev.of_node),
> +		.size			= LAN966X_OIC_NR_IRQ,
> +		.hwirq_max		= LAN966X_OIC_NR_IRQ,
> +		.ops			= &irq_generic_chip_ops,
> +		.gc_info		= &gc_info,
> +		.init			= lan966x_oic_domain_init,
> +	};
> +	struct lan966x_oic_data *lan966x_oic;
> +	struct device *dev = &pdev->dev;
> +
> +	lan966x_oic = devm_kmalloc(dev, sizeof(*lan966x_oic), GFP_KERNEL);
> +	if (!lan966x_oic)
> +		return -ENOMEM;
> +
> +	lan966x_oic->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(lan966x_oic->regs))
> +		return dev_err_probe(dev, PTR_ERR(lan966x_oic->regs), "failed to map resource\n");
> +
> +	lan966x_oic->irq = platform_get_irq(pdev, 0);
> +	if (lan966x_oic->irq < 0)
> +		return dev_err_probe(dev, lan966x_oic->irq, "failed to get the IRQ\n");
> +
> +	lan966x_oic->domain = irq_domain_instantiate(&info);
> +	if (!lan966x_oic->domain)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, lan966x_oic);
> +	return 0;
> +}
> +
> +static void lan966x_oic_remove(struct platform_device *pdev)
> +{
> +	struct lan966x_oic_data *lan966x_oic = platform_get_drvdata(pdev);
> +
> +	irq_set_chained_handler_and_data(lan966x_oic->irq, NULL, NULL);
> +	irq_domain_remove(lan966x_oic->domain);
> +}
> 
> See?

Perfectly.
I will rework patches in this way.
Again, thanks for pointing out this solution.

Best regards,
Hervé

> 
> Thanks,
> 
>         tglx



-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

