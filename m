Return-Path: <linux-pci+bounces-6904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0248B8159
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 22:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762121F2558D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 20:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECEE19DF47;
	Tue, 30 Apr 2024 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4o0H8CN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A81C18412A;
	Tue, 30 Apr 2024 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714508700; cv=none; b=QHzXOd42SisuQAPTpOA42NHt3y58SX9VE1Kh/RK53mrUb+PusvLx5D4HT/IbmTVtnC3DwHBrcNBcpKZzB9nrmeVR1pPfQLlU6YjGIbxOCroA+0lph8q6oZdpqIWICnq30T4Y/HjPcMBTAPUp/k2oaXjDkM1qYa5qZ70M1l1xhPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714508700; c=relaxed/simple;
	bh=YK0ojQVxvVKavdRF62uiNBOU2ZXdClhDIYj2p8To/K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKPWfbYg77zikY6zZVYcqtF4KyAhxxsJhFZJq3Gn/ko2KkznEtIQXaJU9Pra3h8L09txvplQYc0P7BkGZpubQ5xHWlXKY9IuQy7e1a24A0Dd5zInsdzvnicJZB8V33AjOeEx4InFmol+//yq5ZDFK6YdGdWZSNRTVzcM1gq6Mt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4o0H8CN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF84C2BBFC;
	Tue, 30 Apr 2024 20:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714508699;
	bh=YK0ojQVxvVKavdRF62uiNBOU2ZXdClhDIYj2p8To/K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m4o0H8CNPOm4vbL22XkO3NBODXBP2RQxKga431SeRHapVBS6EZf3LpvX51Oxhn5Mr
	 +5YJ8XrTkgqKDigdBnOIjPsCi0snH2cr8XBTCyHrOjVs4YeIMFw7sjXmu+z0HEV3tK
	 haV3pwJtRzTnr9+FoRS2Fhniuppwk8ygYVCIwSEUMja07zPXlTbCB84N0RpfSGyuHn
	 xw4KULT2KjHcjVMTcYiheycAb8TU4fPOAlFMEBjXyfrjJyyK4V2s6Co9jXbrjHvV+p
	 5p8VyLLO8dRyeCSR7nnsq7pAvG2mmwDiG/i/NkRcxZJXvBEIP9iMkeb2546N7O0vh4
	 pa5PE8ivPLC+Q==
Date: Tue, 30 Apr 2024 21:24:51 +0100
From: Simon Horman <horms@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 12/17] irqchip: Add support for LAN966x OIC
Message-ID: <20240430202451.GF2575892@kernel.org>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
 <20240430083730.134918-13-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430083730.134918-13-herve.codina@bootlin.com>

On Tue, Apr 30, 2024 at 10:37:21AM +0200, Herve Codina wrote:
> The Microchip LAN966x outband interrupt controller (OIC) maps the
> internal interrupt sources of the LAN966x device to an external
> interrupt.
> When the LAN966x device is used as a PCI device, the external interrupt
> is routed to the PCI interrupt.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Hi Herve,

> +static int lan966x_oic_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct lan966x_oic_data *lan966x_oic;
> +	struct device *dev = &pdev->dev;
> +	struct irq_chip_generic *gc;
> +	int ret;
> +	int i;
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
> +						      &irq_generic_chip_ops, NULL);

nit: Please consider limiting lines to 80 columns wide in Networking code.

> +	if (!lan966x_oic->domain) {
> +		dev_err(dev, "failed to create an IRQ domain\n");
> +		return -EINVAL;
> +	}
> +
> +	lan966x_oic->irq = platform_get_irq(pdev, 0);
> +	if (lan966x_oic->irq < 0) {
> +		dev_err_probe(dev, lan966x_oic->irq, "failed to get the IRQ\n");
> +		goto err_domain_free;

Hi,

This will result in the function returning ret.
However, ret is uninitialised here.

Flagged by W=1 builds with clang-18, and Smatch.

> +	}
> +
> +	ret = irq_alloc_domain_generic_chips(lan966x_oic->domain, 32, 1, "lan966x-oic",
> +					     handle_level_irq, 0, 0, 0);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to alloc irq domain gc\n");
> +		goto err_domain_free;
> +	}
> +
> +	/* Init chips */
> +	BUILD_BUG_ON(DIV_ROUND_UP(LAN966X_OIC_NR_IRQ, 32) != ARRAY_SIZE(lan966x_oic_chip_regs));
> +	for (i = 0; i < ARRAY_SIZE(lan966x_oic_chip_regs); i++) {
> +		gc = irq_get_domain_generic_chip(lan966x_oic->domain, i * 32);
> +		lan966x_oic_chip_init(lan966x_oic, gc, &lan966x_oic_chip_regs[i]);
> +	}
> +
> +	irq_set_chained_handler_and_data(lan966x_oic->irq, lan966x_oic_irq_handler,
> +					 lan966x_oic->domain);
> +
> +	irq_domain_publish(lan966x_oic->domain);
> +	platform_set_drvdata(pdev, lan966x_oic);
> +	return 0;
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
> +
> +	irq_domain_unpublish(lan966x_oic->domain);
> +
> +	for (i = 0; i < ARRAY_SIZE(lan966x_oic_chip_regs); i++) {
> +		gc = irq_get_domain_generic_chip(lan966x_oic->domain, i * 32);
> +		irq_remove_generic_chip(gc, ~0, 0, 0);
> +	}
> +
> +	kfree(lan966x_oic->domain->gc);
> +	irq_domain_free(lan966x_oic->domain);
> +}

...

