Return-Path: <linux-pci+bounces-9031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FAF910D61
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 18:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F08AB26912
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 16:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEEB1B1509;
	Thu, 20 Jun 2024 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="baZ76z4H"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6E1B14FE;
	Thu, 20 Jun 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901791; cv=none; b=bNUgFh+UIUrm2PVkF7mdhXONmf570UsyV1ytGaI7kizUX1Ztx2ckq88bM9f62aXqM/i1YMXq5JC4s5X539zdWj7UNdx+94jG94Yl/Uw7gcNft7BJx0Kmx5RwpQVNyXPKRhixt9M6ojDIwoj6x1ASqh3CgN4w50Z87UGGGvdySbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901791; c=relaxed/simple;
	bh=qNoR8qj0GlgV+wz3XDBMUwMPVm5Y2wWXfA/fLvk7oSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rjm13H+Xne25OLgTIlJJAQ0kS5Rp73beMNuh7zUbO7IBF2CzurjWmoqfUs/rsd3B0tI5O99T0lxV6LborcX9cwLviD61Q4YAOJXktIvSHSSEx719ygZhwaNRWAKgYgU1dYytSJth+Dw/lydfA1xF05fxr3VJBHcRKVjkkD3eU/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=baZ76z4H; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0664F240004;
	Thu, 20 Jun 2024 16:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718901786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1r5R+hOmxGf9CtGbULnMlJbI64xhjSlMlPpHNZ7oU0=;
	b=baZ76z4HxPN7Cb0wMGu5shQwCA1EPGa8J5KCt4JJfI/6E6eKEYZyYWUAjTvdK1ZSc/fIwZ
	Cvo5PN/HQ4TBhPLOZ50DayGeGzBlmWc0ZvRytoXUUbnGZHp773BtXhfpknjwvZujbov1Nu
	V8I+wNx3cPrr5h8Oq5S0cxRK7JcaaJUs63iaN15MY1vbym5zbXsonVXWBOq+Qn30t37Cbg
	Jf5+uhxpe5L2NTaQmCPYyfjni6lblCT6HPQSff5z4XkPi6rfjGL124Wa2cL/HEi7X9xxs4
	suL31dAyDVFKpNT4B9B6JafAONKkFjBaqhFg6Ti2+kbBDdLTTaqWYcMzizNDZQ==
Date: Thu, 20 Jun 2024 18:43:01 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Sai Krishna Gajula
 <saikrishnag@marvell.com>, Thomas Gleixner <tglx@linutronix.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
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
Subject: Re: [PATCH v2 18/19] mfd: Add support for LAN966x PCI device
Message-ID: <20240620184301.2e768c02@bootlin.com>
In-Reply-To: <20240620175646.24455efb@bootlin.com>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
	<20240527161450.326615-19-herve.codina@bootlin.com>
	<ZmDJi__Ilp7zd-yJ@surfacebook.localdomain>
	<20240620175646.24455efb@bootlin.com>
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

My bad, I wrongly answered first in private.
-> Resend my answers with people in Cc

Andy, I will also resend your reply.

Sorry for this mistake.

Herve

On Thu, 20 Jun 2024 17:56:46 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> Hi Andy,
> 
> On Wed, 5 Jun 2024 23:24:43 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > Mon, May 27, 2024 at 06:14:45PM +0200, Herve Codina kirjoitti:
> > > Add a PCI driver that handles the LAN966x PCI device using a device-tree
> > > overlay. This overlay is applied to the PCI device DT node and allows to
> > > describe components that are present in the device.
> > > 
> > > The memory from the device-tree is remapped to the BAR memory thanks to
> > > "ranges" properties computed at runtime by the PCI core during the PCI
> > > enumeration.
> > > The PCI device itself acts as an interrupt controller and is used as the
> > > parent of the internal LAN966x interrupt controller to route the
> > > interrupts to the assigned PCI INTx interrupt.  
> > 
> > ...
> > 
> > > +#include <linux/irq.h>
> > > +#include <linux/irqdomain.h>  
> > 
> > > +#include <linux/kernel.h>  
> > 
> > Why do you need this?
> > 
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_platform.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/slab.h>  
> > 
> > General comment to the headers (in all your patches), try to follow IWYU
> > principle, i.e. include what you use explicitly and don't use "proxy" headers
> > such as kernel.h which basically shouldn't be used at all in the drivers.
> 
> Sure, I will remove unneeded header inclusion.
> 
> > 
> > ...
> > 
> > > +static irqreturn_t pci_dev_irq_handler(int irq, void *data)
> > > +{
> > > +	struct pci_dev_intr_ctrl *intr_ctrl = data;
> > > +	int ret;
> > > +
> > > +	ret = generic_handle_domain_irq(intr_ctrl->irq_domain, 0);
> > > +	return ret ? IRQ_NONE : IRQ_HANDLED;  
> > 
> > There is a macro for that IRQ_RETVAL() IIRC.
> 
> Didn't known about that. Thanks for pointing out!
> I will use it :)
> 
> > 
> > > +}  
> > 
> > ...
> > 
> > > +static int devm_pci_dev_create_intr_ctrl(struct pci_dev *pdev)
> > > +{
> > > +	struct pci_dev_intr_ctrl *intr_ctrl;
> > > +
> > > +	intr_ctrl = pci_dev_create_intr_ctrl(pdev);  
> > 
> > > +  
> > 
> > Redundant blank line.
> 
> Will be removed.
> 
> > 
> > > +	if (IS_ERR(intr_ctrl))
> > > +		return PTR_ERR(intr_ctrl);
> > > +
> > > +	return devm_add_action_or_reset(&pdev->dev, devm_pci_dev_remove_intr_ctrl, intr_ctrl);
> > > +}  
> > 
> > ...
> > 
> > > +static int lan966x_pci_load_overlay(struct lan966x_pci *data)
> > > +{
> > > +	u32 dtbo_size = __dtbo_lan966x_pci_end - __dtbo_lan966x_pci_begin;
> > > +	void *dtbo_start = __dtbo_lan966x_pci_begin;
> > > +	int ret;
> > > +
> > > +	ret = of_overlay_fdt_apply(dtbo_start, dtbo_size, &data->ovcs_id, data->dev->of_node);  
> > 
> > dev_of_node() ?
> 
> Yes indeed.
> 
> > 
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return 0;
> > > +}  
> > 
> > ...
> > 
> > > +static int lan966x_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	struct lan966x_pci *data;
> > > +	int ret;  
> > 
> > > +	if (!dev->of_node) {
> > > +		dev_err(dev, "Missing of_node for device\n");
> > > +		return -EINVAL;
> > > +	}  
> > 
> > Why do you need this? The code you have in _create_intr_ctrl() will take care
> > already for this case.
> 
> The code in _create_intr_ctrl checks for fwnode and not an of_node.
> 
> The check here is to ensure that an of_node is available as it will be use
> for DT overlay loading.
> 
> I will keep the check here and use dev_of_node() instead of dev->of_node.
> 
> > 
> > > +	/* Need to be done before devm_pci_dev_create_intr_ctrl.
> > > +	 * It allocates an IRQ and so pdev->irq is updated  
> > 
> > Missing period at the end.
> 
> Will be added.
> 
> > 
> > > +	 */
> > > +	ret = pcim_enable_device(pdev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = devm_pci_dev_create_intr_ctrl(pdev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > > +	if (!data)
> > > +		return -ENOMEM;
> > > +
> > > +	dev_set_drvdata(dev, data);
> > > +	data->dev = dev;
> > > +	data->pci_dev = pdev;
> > > +
> > > +	ret = lan966x_pci_load_overlay(data);
> > > +	if (ret)
> > > +		return ret;  
> > 
> > > +	pci_set_master(pdev);  
> > 
> > You don't use MSI, what is this for?
> 
> DMA related.
> Allows the PCI device to be master on the bus and so initiate transactions.
> 
> Did I misunderstood ?
> 
> > 
> > > +	ret = of_platform_default_populate(dev->of_node, NULL, dev);  
> > 
> > dev_of_node()
> 
> Yes, sure.
> 
> > 
> > > +	if (ret)
> > > +		goto err_unload_overlay;
> > > +
> > > +	return 0;
> > > +
> > > +err_unload_overlay:
> > > +	lan966x_pci_unload_overlay(data);
> > > +	return ret;
> > > +}  
> > 
> > ...
> > 
> > > +static void lan966x_pci_remove(struct pci_dev *pdev)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	struct lan966x_pci *data = dev_get_drvdata(dev);  
> > 
> > platform_get_drvdata()
> 
> platform_get_drvdata() is related to platform_device.
> There is no platform_device here but a pci_dev.
> 
> I will use pci_get_drvdata() here and update probe() to
> use pci_set_drvdata() for consistency.
> 
> > 
> > > +	of_platform_depopulate(dev);
> > > +
> > > +	lan966x_pci_unload_overlay(data);  
> > 
> > > +	pci_clear_master(pdev);  
> > 
> > No need to call this excplicitly when pcim_enable_device() was called.
> 
> You're right. I will remove this call.
> 
> > 
> > > +}  
> > 
> > ...
> > 
> > > +static struct pci_device_id lan966x_pci_ids[] = {
> > > +	{ PCI_DEVICE(0x1055, 0x9660) },  
> > 
> > Don't you have VENDOR_ID defined somewhere?
> 
> No and 0x1055 is taken by PCI_VENDOR_ID_EFAR in pci-ids.h
> but SMSC acquired EFAR late 1990's and MCHP acquired SMSC in 2012
> https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/microchip/lan743x_main.h#L851
> 
> I will patch pci-ids.h to create:
>   #define PCI_VENDOR_ID_SMSC PCI_VENDOR_ID_EFAR
>   #define PCI_VENDOR_ID_MCHP PCI_VENDOR_ID_SMSC
> As part of this patch, I will update lan743x_main.h to remove its own #define
> 
> And use PCI_VENDOR_ID_MCHP in this series.
> 
> > 
> > > +	{ 0, }  
> > 
> > Unneeded ' 0, ' part
> 
> Will be removed.
> 
> > 
> > > +};  
> > 
> 
> Thanks a lot for your review.
> 
> Best regards,
> Hervé


