Return-Path: <linux-pci+bounces-11425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EEE94A522
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 12:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C121F217D2
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 10:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438581D363A;
	Wed,  7 Aug 2024 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TUPmhRdW"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C19F1C6899;
	Wed,  7 Aug 2024 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723025416; cv=none; b=kRCch11xVMBJn936x0toT5sfSLAcItxTLE3jub6sfY9yJYnS/eQQxOaNvME8biqssA2BBRixi3vCnouZd7U8DWYRmCjThrJRGqkwC5n4PmDHO8uL05EZlPW5uZTADSXMPCsVNaiA6c2EYRG1epfwgkowq9WCt9Pp5W9OC/VmvHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723025416; c=relaxed/simple;
	bh=3geILOQKguehSc6CHYFbtZK9lmxQOnTTa3CMyswIst4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QfLrY3GQ4Uka9aykRWFuoP73fzYsez9Q5avIKEBtP1QBZo5OlExY1Q65OdY7a74vxgUDnlWm2McnJRzfvCugZbxO9A2hnYop8cLSsgo3J++2utPRHKIonoKfQz5jOYGfoukGh5zNGjAvjAUzd86dG5kLSbzw87urV2sabGQAvew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TUPmhRdW; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C0821BF203;
	Wed,  7 Aug 2024 10:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723025403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5BGqJI/ev/belov1hsrruBFGrYZxU1Unm6iwJDXADo=;
	b=TUPmhRdWjO9JNhnOiRGL61xQIzPr5WsceG2EwvtaTxyj8uRQI95g+daK4eu9DM/BqXSzkK
	8YNzgK3ImrLELTqobMwZ/7xfMMBl6IFDXVPea6GvQP1qbhCHCdSQz47hWiYHt8v01wasRY
	rpWo2J0qeMP0Vm7L4lv4eMnRdSe5tz26dB7dL6Hs8hGtkQ2Dpdigm7AhZIAriO7AUQOX5A
	jCYfHm2gS+/o+Od7CegM/vgVVOCdlKaneFthnJMxnu4l90ya2cMtx8lJPk9zFz/psPQVvc
	9jH5QhFLfBwlPgLTYF8Ufg8xQzJOxvngmPLExruVRGcVqdLvMB1Pfv7l2G6ThQ==
Date: Wed, 7 Aug 2024 12:09:56 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman
 <horms@kernel.org>, Lee Jones <lee@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Lars Povlsen <lars.povlsen@microchip.com>, Steen
 Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, Rob Herring
 <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 1/8] misc: Add support for LAN966x PCI device
Message-ID: <20240807120956.30c8264e@bootlin.com>
In-Reply-To: <CAHp75VdtFET87R9DZbz27vEeyv4K5bn7mxDCnBVdpFVJ=j6qtg@mail.gmail.com>
References: <20240805101725.93947-1-herve.codina@bootlin.com>
	<20240805101725.93947-2-herve.codina@bootlin.com>
	<CAHp75VdtFET87R9DZbz27vEeyv4K5bn7mxDCnBVdpFVJ=j6qtg@mail.gmail.com>
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

Hi Andy,

On Mon, 5 Aug 2024 22:13:38 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Aug 5, 2024 at 12:19 PM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > Add a PCI driver that handles the LAN966x PCI device using a device-tree
> > overlay. This overlay is applied to the PCI device DT node and allows to
> > describe components that are present in the device.
> >
> > The memory from the device-tree is remapped to the BAR memory thanks to
> > "ranges" properties computed at runtime by the PCI core during the PCI
> > enumeration.
> >
> > The PCI device itself acts as an interrupt controller and is used as the
> > parent of the internal LAN966x interrupt controller to route the
> > interrupts to the assigned PCI INTx interrupt.  
> 
> ...
> 
> + device.h

Will be added.

> 
> > +#include <linux/irq.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>  
> 
> > +#include <linux/pci.h>  
> 
> > +#include <linux/pci_ids.h>  
> 
> AFAIU pci_ids..h is guaranteed to be included by pci.h, but having it
> here explicitly doesn't make it worse, so up to you.

I will keep pci_ids.h

> 
> > +#include <linux/slab.h>  
> 
> ...
> 
> > +static irqreturn_t pci_dev_irq_handler(int irq, void *data)
> > +{
> > +       struct pci_dev_intr_ctrl *intr_ctrl = data;
> > +       int ret;
> > +
> > +       ret = generic_handle_domain_irq(intr_ctrl->irq_domain, 0);
> > +       return IRQ_RETVAL(!ret);  
> 
> Hmm... I dunno if it was me who suggested IRQ_RETVAL() here, but it
> usually makes sense for the cases where ret is not inverted.
> 
> Perhaps
> 
>   if (ret)
>     return NONE;
>   return HANDLED;
> 
> is slightly better in this case?

Right. I will use a more compact version:
  return ret ? IRQ_NONE : IRQ_HANDLED;

> 
> > +}  
> 
> ...
> 
> > +static struct pci_dev_intr_ctrl *pci_dev_create_intr_ctrl(struct pci_dev *pdev)
> > +{
> > +       struct pci_dev_intr_ctrl *intr_ctrl;
> > +       struct fwnode_handle *fwnode;
> > +       int ret;  
> 
> > +       if (!pdev->irq)
> > +               return ERR_PTR(-EOPNOTSUPP);  
> 
> Before even trying to get it via APIs? (see below as well)
> Also, when is it possible to have 0 here?

pdev->irq can be 0 if the PCI device did not request any IRQ
(i.e. PCI_INTERRUPT_PIN in PCI config header is 0).

I use that to check whether or not INTx is supported.

Even if this code is present in the LAN966x PCI driver, it can be use as a
starting point for other drivers and may be moved to a common part in the
future.

Do you think I should remove it ?

If keeping it is fine, I will add a comment.

> 
> > +       fwnode = dev_fwnode(&pdev->dev);
> > +       if (!fwnode)
> > +               return ERR_PTR(-ENODEV);
> > +
> > +       intr_ctrl = kmalloc(sizeof(*intr_ctrl), GFP_KERNEL);  
> 
> Hmm... Why not use __free()?

Well, just because I am not used to using __free() and I didn't think
about it.

I will use it in the next operation.

> 
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
> 
> > +       ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_INTX);
> > +       if (ret < 0) {
> > +               pci_err(pdev, "Unable alloc irq vector (%d)\n", ret);
> > +               goto err_remove_domain;
> > +       }  
> 
> I am wondering if you even need this in case you want solely INTx.

I have the feeling that it is needed.
pci_alloc_irq_vectors() will call pci_intx() which in turn enables INT
clearing PCI_COMMAND_INTX_DISABLE flag in the PCI_COMMAND config word.

> 
> > +       intr_ctrl->irq = pci_irq_vector(pdev, 0);  
> 
> Don't remember documentation by heart for this, but the implementation
> suggests that it can be called without the above for retrieving INTx.

So, with the above said, I will keep both pci_alloc_irq_vectors() and
pci_irq_vector() calls.

> 
> > +       ret = request_irq(intr_ctrl->irq, pci_dev_irq_handler, IRQF_SHARED,
> > +                         dev_name(&pdev->dev), intr_ctrl);  
> 
> pci_name() ? (IIRC the macro name)

Indeed, will be changed.

> 
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
> 
> ...
> 
> > +static void devm_pci_dev_remove_intr_ctrl(void *data)
> > +{  
> 
> > +       struct pci_dev_intr_ctrl *intr_ctrl = data;  
> 
> It can be eliminated
> 
> static void devm_pci_...(void *intr_ctrl)

I will update.

> 
> > +       pci_dev_remove_intr_ctrl(intr_ctrl);
> > +}  
> 
> ...
> 
> > +static int lan966x_pci_load_overlay(struct lan966x_pci *data)
> > +{
> > +       u32 dtbo_size = __dtbo_lan966x_pci_end - __dtbo_lan966x_pci_begin;
> > +       void *dtbo_start = __dtbo_lan966x_pci_begin;
> > +       int ret;
> > +
> > +       ret = of_overlay_fdt_apply(dtbo_start, dtbo_size, &data->ovcs_id, dev_of_node(data->dev));
> > +       if (ret)
> > +               return ret;
> > +
> > +       return 0;  
> 
> return of_overlay_fdt_apply() ?

Yes indeed.

> 
> > +}  
> 
> ...
> 
> > +static int lan966x_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct lan966x_pci *data;
> > +       int ret;
> > +
> > +       /*
> > +        * On ACPI system, fwnode can point to the ACPI node.
> > +        * This driver needs an of_node to be used as the device-tree overlay
> > +        * target. This of_node should be set by the PCI core if it succeeds in
> > +        * creating it (CONFIG_PCI_DYNAMIC_OF_NODES feature).
> > +        * Check here for the validity of this of_node.
> > +        */
> > +       if (!dev_of_node(dev)) {  
> 
> > +               dev_err(dev, "Missing of_node for device\n");
> > +               return -EINVAL;  
> 
> return dev_err_probe() ?

Yes, I will update.

> 
> > +       }
> > +
> > +       /* Need to be done before devm_pci_dev_create_intr_ctrl.
> > +        * It allocates an IRQ and so pdev->irq is updated.
> > +        */
> > +       ret = pcim_enable_device(pdev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = devm_pci_dev_create_intr_ctrl(pdev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > +       if (!data)
> > +               return -ENOMEM;
> > +
> > +       pci_set_drvdata(pdev, data);
> > +       data->dev = dev;
> > +
> > +       ret = lan966x_pci_load_overlay(data);
> > +       if (ret)
> > +               return ret;
> > +
> > +       pci_set_master(pdev);
> > +
> > +       ret = of_platform_default_populate(dev_of_node(dev), NULL, dev);
> > +       if (ret)
> > +               goto err_unload_overlay;
> > +
> > +       return 0;
> > +
> > +err_unload_overlay:
> > +       lan966x_pci_unload_overlay(data);
> > +       return ret;
> > +}  
> 
> ...
> 
> > +#include <dt-bindings/clock/microchip,lan966x.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/mfd/atmel-flexcom.h>
> > +#include <dt-bindings/phy/phy-lan966x-serdes.h>  
> 
> > +#include <dt-bindings/gpio/gpio.h>  
> 
> Alphabetical order?

Yes indeed.

Thanks for the review.

Best regards,
Hervé

