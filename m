Return-Path: <linux-pci+bounces-8336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD098FD0A4
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 16:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30791F241E4
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 14:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB231A291;
	Wed,  5 Jun 2024 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FdQtT2yD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h0pcncrc"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3CB1863C;
	Wed,  5 Jun 2024 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717597078; cv=none; b=UDyFZs5vxzUgN1a7veDWm4wLnmyPITJKKGIjYPcVIokNO5B1+DSbIup16Yd40rriqc399OLaMBX3XDrd92q+IpAGPwuZ86X0o/WLCMQm4ZecAEuxu7zJBRwU1VC46sZRN9D1wpfdEkAa7n3LkCXNT9tFWmOJqMKwEpa/UkHzdDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717597078; c=relaxed/simple;
	bh=s3hsBHfHGSb76vwMZy3nEFVmXNXGEjEkilscDvM66vU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XG8WwwhSx/2RJYy0nDWfJoqnKK/R0b3Y4jgisBYRM6JPGvQAelBtzJeGcBfb8l33DmF+8SaLpLr6woAYCyPLMUMPNUbsHfMpkdVFmaa025u+3tstKPaiVj9mRx3IDYMnGuxU24EgsOK3TWNVkLr7nqKtym2X3of9lB67HtLIomE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FdQtT2yD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h0pcncrc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717597074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n04KYCuxF/d4GeXP4Wu2hdUNiAxVocZIZGoARupszWA=;
	b=FdQtT2yDVgjr7iJyRlkteEqbXa73u24p0cdcvjcM7lv4L6l/Pccu5G4WV5pAmh0E4SbJjR
	mhW1SKXlkwarDSWWUKyTAnJm2yKOZk5vmUeCb0s/ifaDtklQ0O6I34O4ofjoie8Oim5luf
	0b8qFJwaTUBYv1zqgPSxCeo+kzF6jgeT5g24mXFklxbbY6r7LYbXA+1osLNVqDBFhI7UKi
	Oe4dS+MR2QWUOXHs6QZJK3/FZvmc+agjLRfisu9VdynmcBtSEFXLp1n4O1GNG4RwvFZRIc
	AYcKCdV7t5xwEgMuTy7lXDBiFmxZNlxX9TfhfkGmfF5c8pJJL34xwPgnfYYjYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717597074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n04KYCuxF/d4GeXP4Wu2hdUNiAxVocZIZGoARupszWA=;
	b=h0pcncrcJMKv0Oz6gYvi5gHNG5E4DWuOjpeI4WUt5kg06KSE57hQUeJ5yoXrQ/t9Vh27IB
	2Oo4K14xZE/sPKAQ==
To: Herve Codina <herve.codina@bootlin.com>, Simon Horman
 <horms@kernel.org>, Sai Krishna Gajula <saikrishnag@marvell.com>, Herve
 Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Lee Jones <lee@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Saravana Kannan <saravanak@google.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Lars
 Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 11/19] irqchip: Add support for LAN966x OIC
In-Reply-To: <20240527161450.326615-12-herve.codina@bootlin.com>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
 <20240527161450.326615-12-herve.codina@bootlin.com>
Date: Wed, 05 Jun 2024 16:17:53 +0200
Message-ID: <87frtr4goe.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 27 2024 at 18:14, Herve Codina wrote:
> +struct lan966x_oic_data {
> +	struct irq_domain *domain;
> +	void __iomem *regs;
> +	int irq;
> +};

Please read Documentation/process/maintainers-tip.rst

> +static int lan966x_oic_irq_set_type(struct irq_data *data,
> +				    unsigned int flow_type)

Please use the 100 character limit

> +static struct lan966x_oic_chip_regs lan966x_oic_chip_regs[3] = {
> +	{
> +		.reg_off_ena_set = LAN966X_OIC_INTR_ENA_SET,
> +		.reg_off_ena_clr = LAN966X_OIC_INTR_ENA_CLR,
> +		.reg_off_sticky = LAN966X_OIC_INTR_STICKY,
> +		.reg_off_ident = LAN966X_OIC_DST_INTR_IDENT(0),
> +		.reg_off_map = LAN966X_OIC_DST_INTR_MAP(0),

Please make this tabular. See doc.

> +static void lan966x_oic_chip_init(struct lan966x_oic_data *lan966x_oic,
> +				  struct irq_chip_generic *gc,
> +				  struct lan966x_oic_chip_regs *chip_regs)
> +{
> +	gc->reg_base = lan966x_oic->regs;
> +	gc->chip_types[0].regs.enable = chip_regs->reg_off_ena_set;
> +	gc->chip_types[0].regs.disable = chip_regs->reg_off_ena_clr;
> +	gc->chip_types[0].regs.ack = chip_regs->reg_off_sticky;
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

~0U
  
> +	irq_reg_writel(gc, ~0, gc->chip_types[0].regs.ack);
> +}
> +
> +static int lan966x_oic_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct lan966x_oic_data *lan966x_oic;
> +	struct device *dev = &pdev->dev;
> +	struct irq_chip_generic *gc;
> +	int ret;
> +	int i;

int ret, i;

> +
> +	lan966x_oic = devm_kmalloc(dev, sizeof(*lan966x_oic), GFP_KERNEL);
> +	if (!lan966x_oic)
> +		return -ENOMEM;
> +
> +	lan966x_oic->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(lan966x_oic->regs))
> +		return dev_err_probe(dev, PTR_ERR(lan966x_oic->regs),
> +				     "failed to map resource\n");
> +
> +	lan966x_oic->domain = irq_domain_alloc_linear(of_node_to_fwnode(node),
> +						      LAN966X_OIC_NR_IRQ,
> +						      &irq_generic_chip_ops,
> +						      NULL);
> +	if (!lan966x_oic->domain) {
> +		dev_err(dev, "failed to create an IRQ domain\n");
> +		return -EINVAL;
> +	}
> +
> +	lan966x_oic->irq = platform_get_irq(pdev, 0);
> +	if (lan966x_oic->irq < 0) {
> +		ret = dev_err_probe(dev, lan966x_oic->irq,
> +				    "failed to get the IRQ\n");
> +		goto err_domain_free;
> +	}
> +
> +	ret = irq_alloc_domain_generic_chips(lan966x_oic->domain, 32, 1,
> +					     "lan966x-oic", handle_level_irq, 0,
> +					     0, 0);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to alloc irq domain gc\n");
> +		goto err_domain_free;
> +	}
> +
> +	/* Init chips */
> +	BUILD_BUG_ON(DIV_ROUND_UP(LAN966X_OIC_NR_IRQ, 32) !=
> +		     ARRAY_SIZE(lan966x_oic_chip_regs));
> +	for (i = 0; i < ARRAY_SIZE(lan966x_oic_chip_regs); i++) {
> +		gc = irq_get_domain_generic_chip(lan966x_oic->domain, i * 32);
> +		lan966x_oic_chip_init(lan966x_oic, gc,
> +				      &lan966x_oic_chip_regs[i]);
> +	}
> +
> +	irq_set_chained_handler_and_data(lan966x_oic->irq,
> +					 lan966x_oic_irq_handler,
> +					 lan966x_oic->domain);
> +
> +	irq_domain_publish(lan966x_oic->domain);
> +	platform_set_drvdata(pdev, lan966x_oic);
> +	return 0;

This is exactly what can be avoided.

> +
> +err_domain_free:
> +	irq_domain_free(lan966x_oic->domain);
> +	return ret;
> +}
> +
> +static void lan966x_oic_remove(struct platform_device *pdev)
> +{
> +	struct lan966x_oic_data *lan966x_oic = platform_get_drvdata(pdev);
> +	struct irq_chip_generic *gc;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(lan966x_oic_chip_regs); i++) {
> +		gc = irq_get_domain_generic_chip(lan966x_oic->domain, i * 32);
> +		lan966x_oic_chip_exit(gc);
> +	}
> +
> +	irq_set_chained_handler_and_data(lan966x_oic->irq, NULL, NULL);
> +
> +	for (i = 0; i < LAN966X_OIC_NR_IRQ; i++)
> +		irq_dispose_mapping(irq_find_mapping(lan966x_oic->domain, i));

This is just wrong. You cannot remove the chip when there are still interrupts
mapped.

I just did a quick conversion to the template approach. Unsurprisingly
it removes 30 lines of boiler plate code:

+static void lan966x_oic_chip_init(struct irq_chip_generic *gc)
+{
+	struct lan966x_oic_data *lan966x_oic = gc->domain->host_data;
+	struct lan966x_oic_chip_regs *chip_regs;
+
+	gc->reg_base = lan966x_oic->regs;
+
+	chip_regs = lan966x_oic_chip_regs + gc->irq_base / 32;
+	gc->chip_types[0].regs.enable = chip_regs->reg_off_ena_set;
+	gc->chip_types[0].regs.disable = chip_regs->reg_off_ena_clr;
+	gc->chip_types[0].regs.ack = chip_regs->reg_off_sticky;
+
+	gc->chip_types[0].chip.irq_startup = lan966x_oic_irq_startup;
+	gc->chip_types[0].chip.irq_shutdown = lan966x_oic_irq_shutdown;
+	gc->chip_types[0].chip.irq_set_type = lan966x_oic_irq_set_type;
+	gc->chip_types[0].chip.irq_mask = irq_gc_mask_disable_reg;
+	gc->chip_types[0].chip.irq_unmask = irq_gc_unmask_enable_reg;
+	gc->chip_types[0].chip.irq_ack = irq_gc_ack_set_bit;
+	gc->private = chip_regs;
+
+	/* Disable all interrupts handled by this chip */
+	irq_reg_writel(gc, ~0, chip_regs->reg_off_ena_clr);
+}
+
+static void lan966x_oic_chip_exit(struct irq_chip_generic *gc)
+{
+	/* Disable and ack all interrupts handled by this chip */
+	irq_reg_writel(gc, ~0, gc->chip_types[0].regs.disable);
+	irq_reg_writel(gc, ~0, gc->chip_types[0].regs.ack);
+}
+
+static void lan966x_oic_domain_init(struct irq_domain *d)
+{
+	struct lan966x_oic_data *lan966x_oic = d->host_data;
+
+	irq_set_chained_handler_and_data(lan966x_oic->irq, lan966x_oic_irq_handler, d);
+}
+
+static int lan966x_oic_probe(struct platform_device *pdev)
+{
+	struct irq_domain_chip_generic_info gc_info = {
+		.irqs_per_chip		= 32,
+		.num_chips		= 1,
+		.name			= "lan966x-oic"
+		.handler		= handle_level_irq,
+		.init			= lan966x_oic_chip_init,
+		.destroy		= lan966x_oic_chip_exit,
+	};
+
+	struct irq_domain_info info = {
+		.fwnode			= of_node_to_fwnode(pdev->dev.of_node),
+		.size			= LAN966X_OIC_NR_IRQ,
+		.hwirq_max		= LAN966X_OIC_NR_IRQ,
+		.ops			= &irq_generic_chip_ops,
+		.gc_info		= &gc_info,
+		.init			= lan966x_oic_domain_init,
+	};
+	struct lan966x_oic_data *lan966x_oic;
+	struct device *dev = &pdev->dev;
+
+	lan966x_oic = devm_kmalloc(dev, sizeof(*lan966x_oic), GFP_KERNEL);
+	if (!lan966x_oic)
+		return -ENOMEM;
+
+	lan966x_oic->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(lan966x_oic->regs))
+		return dev_err_probe(dev, PTR_ERR(lan966x_oic->regs), "failed to map resource\n");
+
+	lan966x_oic->irq = platform_get_irq(pdev, 0);
+	if (lan966x_oic->irq < 0)
+		return dev_err_probe(dev, lan966x_oic->irq, "failed to get the IRQ\n");
+
+	lan966x_oic->domain = irq_domain_instantiate(&info);
+	if (!lan966x_oic->domain)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, lan966x_oic);
+	return 0;
+}
+
+static void lan966x_oic_remove(struct platform_device *pdev)
+{
+	struct lan966x_oic_data *lan966x_oic = platform_get_drvdata(pdev);
+
+	irq_set_chained_handler_and_data(lan966x_oic->irq, NULL, NULL);
+	irq_domain_remove(lan966x_oic->domain);
+}

See?

Thanks,

        tglx

