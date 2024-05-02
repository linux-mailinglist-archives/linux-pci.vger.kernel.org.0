Return-Path: <linux-pci+bounces-7009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0C08B9B8C
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 15:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C8D281800
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 13:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5047B84A4F;
	Thu,  2 May 2024 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NPkP0GCu"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4216556B8B;
	Thu,  2 May 2024 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714656257; cv=none; b=iq+5DlvLWwCMi9Rt0rIDDixf0CTApVQeYjiKpiGH6cEymkXFtqh/nGE3xoqDcOEDtgLzyUVb19/solNrsRiSmozNUvyTMoIyXBSfvV4nHfMQiccNfKPt5Z746ZU8pd6/6e1/QJ3t9KeoOff99NJ+e2LoCmqvUnxRQ9PWHBKw1ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714656257; c=relaxed/simple;
	bh=+xxCO+Xf/1cD5/co4TyZWT75lYmYABg2lLKlawfo68E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XX1AynHGAKSeiN2CJXwLtEUlR8FQbZUnobqFuvBQCMgU5c8OVmCWnKAbWop9EB99n7gt6rSvHJrvxJ1ERJNym807wtKpNB76pLFPk3aNDPiGy8Z6lxEnLRe/pBlhpgT41nV9xQymoTrr0P6hrfH6YU6V6uXNbascQN3xvY+Gymw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NPkP0GCu; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 75EF9FF808;
	Thu,  2 May 2024 13:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714656252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpTPdiBa1OIGqNkEL6fPrCzTcfq7rb6C3wl4aQp+dcE=;
	b=NPkP0GCumBTB70ynwkVX+XDO1XNVFTfvKLUT+5OWkYYJaNp8AJ76z1vAsGpmJg0N4r3Tk+
	FQIxTPvPtsQ8tOlwx+qCvG5y1/4xi9k1myhBDuV5idzjf/12FH8pjfab79m6uA31VSRdWn
	WPf3VGoVsxqvZNHqQ+FWJs+AVyZYGPBRey4ipNJMXXZpuSZXQbC833xBbFigo2Ajok9sjM
	xxMNlmIAGc4X7SLAa8VmBs/B+Z4UQ2z6DJvwMiZt8BXY0BKRpgjTubPlHXbGzr57cy96d6
	RnDbMHO/5by3VKF5YESRk+lRHpsYhPqTRVzNc+9M+9TohLszr/A2mK0q4K63LQ==
Date: Thu, 2 May 2024 15:24:09 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Lee Jones <lee@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Saravana
 Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, Lars Povlsen <lars.povlsen@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Allan
 Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 12/17] irqchip: Add support for LAN966x OIC
Message-ID: <20240502152409.70a85339@bootlin.com>
In-Reply-To: <20240430202451.GF2575892@kernel.org>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
	<20240430083730.134918-13-herve.codina@bootlin.com>
	<20240430202451.GF2575892@kernel.org>
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

Hi Simon,

On Tue, 30 Apr 2024 21:24:51 +0100
Simon Horman <horms@kernel.org> wrote:

> On Tue, Apr 30, 2024 at 10:37:21AM +0200, Herve Codina wrote:
> > The Microchip LAN966x outband interrupt controller (OIC) maps the
> > internal interrupt sources of the LAN966x device to an external
> > interrupt.
> > When the LAN966x device is used as a PCI device, the external interrupt
> > is routed to the PCI interrupt.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>  
> 
> Hi Herve,
> 
> > +static int lan966x_oic_probe(struct platform_device *pdev)
> > +{
> > +	struct device_node *node = pdev->dev.of_node;
> > +	struct lan966x_oic_data *lan966x_oic;
> > +	struct device *dev = &pdev->dev;
> > +	struct irq_chip_generic *gc;
> > +	int ret;
> > +	int i;
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
> > +						      &irq_generic_chip_ops, NULL);  
> 
> nit: Please consider limiting lines to 80 columns wide in Networking code.

This will be done in the next iteration.

> 
> > +	if (!lan966x_oic->domain) {
> > +		dev_err(dev, "failed to create an IRQ domain\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	lan966x_oic->irq = platform_get_irq(pdev, 0);
> > +	if (lan966x_oic->irq < 0) {
> > +		dev_err_probe(dev, lan966x_oic->irq, "failed to get the IRQ\n");
> > +		goto err_domain_free;  
> 
> Hi,
> 
> This will result in the function returning ret.
> However, ret is uninitialised here.
> 
> Flagged by W=1 builds with clang-18, and Smatch.

Indeed, this fill be fixed in the next iteration.

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

