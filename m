Return-Path: <linux-pci+bounces-7457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5CA8C5666
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 14:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B2C1F2240C
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 12:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792827EEE1;
	Tue, 14 May 2024 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SqHcSbng"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6605A79B;
	Tue, 14 May 2024 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715691334; cv=none; b=ZVGgFFP70v07VQmhzkFIeXcfxzGyJy/AaubjpnnV0Gv734i3gQj5ogi0xAOUyt8LsOY0zkaKYbV0/j0kSx5+E7nphvBsTWzqHQT90X2dMnx7I5VjrjdJLJfQ8alBRf82EIIBU4mq4TlF5fM0uuHi1KR0NEAhGxfPl2GyHIYNZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715691334; c=relaxed/simple;
	bh=ogLSvab9s/uaYk8nU1V6GvKZYCgdD8Qs2Pc34NIY5X0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REk401ZHEAYvgdh8g52Z1C6NddsmO9qCrrMJ2qGJfTKPMX4lQfBgBVorSikqnMco0AEEwRu8kN/ZZSXPf9NRKEBgwlYNZ6uewoNuys+L9m4J7LtUQDNvOfKQMmj6d/7pbv5fS3Wkp52lMuoTO2K72q0oP7r3bQovx944Na8TGA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SqHcSbng; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 103CD20007;
	Tue, 14 May 2024 12:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715691323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1U1lSHyn+UBGYjOWsepzisKyKSuUqvB3hMNBkgKOiVw=;
	b=SqHcSbngLJlpXZ3Qfg4KbR4KsZwO0iwvwjzI88o8+Tf2e/Q0DD67RsrnIP/SgrGMEJZ3hQ
	Op8bxR6zbPwZWcXBE35qbKg9Z3diV2VFHHT+H3fyKu2MHKiNGs2FNi+dsvqmB9Id1OI8L0
	Zcrk4xCQCpNsWLtad7RjLVLwn70oLnGzp+xvl+4UIL1PutKDvt9wCLEPbs0sRSkiIcTmXk
	x8OVkso3DFNW+I0RFrCfQa9Y5hfPaxWMG0z9OJYQmMRGmNsXb167RC3WrZi0FrHHdbi+5H
	hL27DJm0xrFQ4QSjQosQYjpgMA0WqCpPxwAYZRB1OAK1XvcexRfN+zuhnoMJTA==
Date: Tue, 14 May 2024 14:55:18 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: <Steen.Hegelund@microchip.com>
Cc: <tglx@linutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <lee@kernel.org>, <arnd@arndb.de>,
 <Horatiu.Vultur@microchip.com>, <UNGLinuxDriver@microchip.com>,
 <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <saravanak@google.com>, <bhelgaas@google.com>, <p.zabel@pengutronix.de>,
 <Lars.Povlsen@microchip.com>, <Daniel.Machon@microchip.com>,
 <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <Allan.Nielsen@microchip.com>, <luca.ceresoli@bootlin.com>,
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 16/17] mfd: Add support for LAN966x PCI device
Message-ID: <20240514145518.3e989b83@bootlin.com>
In-Reply-To: <D1447AHUWV6C.13V6FOWZ80GH@microchip.com>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
	<20240430083730.134918-17-herve.codina@bootlin.com>
	<D1447AHUWV6C.13V6FOWZ80GH@microchip.com>
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

Hi Steen,

On Wed, 8 May 2024 08:20:04 +0000
<Steen.Hegelund@microchip.com> wrote:

...
> > +
> > +static irqreturn_t pci_dev_irq_handler(int irq, void *data)
> > +{
> > +       struct pci_dev_intr_ctrl *intr_ctrl = data;
> > +       int ret;
> > +
> > +       ret = generic_handle_domain_irq(intr_ctrl->irq_domain, 0);
> > +       return ret ? IRQ_NONE : IRQ_HANDLED;
> > +}
> > +
> > +static struct pci_dev_intr_ctrl *pci_dev_create_intr_ctrl(struct pci_dev *pdev)
> > +{
> > +       struct pci_dev_intr_ctrl *intr_ctrl;
> > +       struct fwnode_handle *fwnode;
> > +       int ret;
> > +
> > +       if (!pdev->irq)
> > +               return ERR_PTR(-EOPNOTSUPP);
> > +
> > +       fwnode = dev_fwnode(&pdev->dev);
> > +       if (!fwnode)
> > +               return ERR_PTR(-ENODEV);
> > +
> > +       intr_ctrl = kmalloc(sizeof(*intr_ctrl), GFP_KERNEL);
> > +       if (!intr_ctrl)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       intr_ctrl->pci_dev = pdev;
> > +
> > +       intr_ctrl->irq_domain = irq_domain_create_linear(fwnode, 1, &pci_dev_irq_domain_ops,
> > +                                                        intr_ctrl);
> > +       if (!intr_ctrl->irq_domain) {
> > +               pci_err(pdev, "Failed to create irqdomain\n");
> > +               ret = -ENOMEM;
> > +               goto err_free_intr_ctrl;
> > +       }
> > +
> > +       ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
> > +       if (ret < 0) {
> > +               pci_err(pdev, "Unable alloc irq vector (%d)\n", ret);
> > +               goto err_remove_domain;
> > +       }
> > +       intr_ctrl->irq = pci_irq_vector(pdev, 0);
> > +       ret = request_irq(intr_ctrl->irq, pci_dev_irq_handler, IRQF_SHARED,
> > +                         dev_name(&pdev->dev), intr_ctrl);
> > +       if (ret) {
> > +               pci_err(pdev, "Unable to request irq %d (%d)\n", intr_ctrl->irq, ret);
> > +               goto err_free_irq_vector;
> > +       }
> > +
> > +       return intr_ctrl;
> > +
> > +err_free_irq_vector:
> > +       pci_free_irq_vectors(pdev);
> > +err_remove_domain:
> > +       irq_domain_remove(intr_ctrl->irq_domain);
> > +err_free_intr_ctrl:
> > +       kfree(intr_ctrl);
> > +       return ERR_PTR(ret);
> > +}
> > +
> > +static void pci_dev_remove_intr_ctrl(struct pci_dev_intr_ctrl *intr_ctrl)
> > +{
> > +       free_irq(intr_ctrl->irq, intr_ctrl);
> > +       pci_free_irq_vectors(intr_ctrl->pci_dev);
> > +       irq_dispose_mapping(irq_find_mapping(intr_ctrl->irq_domain, 0));
> > +       irq_domain_remove(intr_ctrl->irq_domain);
> > +       kfree(intr_ctrl);
> > +}
> > +  
> 
> It looks like the two functions below (and their helper functions) are so
> generic that they could be part of the pci driver core support.
> Any plans for that?

Indeed, I tried to write them in a generic way.
Right now, at least for the next iteration of this series, I don't plan to
move them as part of the PCI code.
This piece of code did not get any feedback and I would prefer to keep them
here for the moment.

Of course, they could be move out of the LAN966x PCI driver later.

> 
> > +static void devm_pci_dev_remove_intr_ctrl(void *data)
> > +{
> > +       struct pci_dev_intr_ctrl *intr_ctrl = data;
> > +
> > +       pci_dev_remove_intr_ctrl(intr_ctrl);
> > +}
> > +
> > +static int devm_pci_dev_create_intr_ctrl(struct pci_dev *pdev)
> > +{
> > +       struct pci_dev_intr_ctrl *intr_ctrl;
> > +
> > +       intr_ctrl = pci_dev_create_intr_ctrl(pdev);
> > +
> > +       if (IS_ERR(intr_ctrl))
> > +               return PTR_ERR(intr_ctrl);
> > +
> > +       return devm_add_action_or_reset(&pdev->dev, devm_pci_dev_remove_intr_ctrl, intr_ctrl);
> > +}
> > +  
> 

Best regards,
Hervé

