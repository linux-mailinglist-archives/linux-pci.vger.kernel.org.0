Return-Path: <linux-pci+bounces-8368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D6F8FD774
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 22:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A3F285C4E
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 20:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7796C15ECD1;
	Wed,  5 Jun 2024 20:24:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B7115ECC4
	for <linux-pci@vger.kernel.org>; Wed,  5 Jun 2024 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619089; cv=none; b=JWmr2m3Y4J8/t+H2zcFhQ+93H1tywwjx3lxExdHeNuC+e4iLK/dFoAq1Al0OfMpu8yNksl3GTmblzpsUsM+rBEWm9Z8cgVJX5w6Li28oc0/XlN0Wj3Tdl1aWBoOMpSt4RhpvWFsCPXzhik7cse/mZ/ru3TBYELCZMr13yq1v/FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619089; c=relaxed/simple;
	bh=dJT0IXIjAoLuqegKrl7wJhhJCx7h7wib/TJUPpQllBA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQZn8TtNQAaXNzh0huY2QXM1gl1C2lwcHSGB4AeXrqcHfX4IEg9LadHColNf8pj6btZyuMweydmWITLUWMSGBiackaCvczjG8B1OW+a/GYVejVjIigYAE+F6+QNCTDOCIpTg001OwgbG36QQq0x8QnNV4kx6bE0zbjUECPQpw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id a4ad9dfa-2379-11ef-8e41-005056bdf889;
	Wed, 05 Jun 2024 23:24:45 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 5 Jun 2024 23:24:43 +0300
To: Herve Codina <herve.codina@bootlin.com>
Cc: Simon Horman <horms@kernel.org>,
	Sai Krishna Gajula <saikrishnag@marvell.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v2 18/19] mfd: Add support for LAN966x PCI device
Message-ID: <ZmDJi__Ilp7zd-yJ@surfacebook.localdomain>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
 <20240527161450.326615-19-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527161450.326615-19-herve.codina@bootlin.com>

Mon, May 27, 2024 at 06:14:45PM +0200, Herve Codina kirjoitti:
> Add a PCI driver that handles the LAN966x PCI device using a device-tree
> overlay. This overlay is applied to the PCI device DT node and allows to
> describe components that are present in the device.
> 
> The memory from the device-tree is remapped to the BAR memory thanks to
> "ranges" properties computed at runtime by the PCI core during the PCI
> enumeration.
> The PCI device itself acts as an interrupt controller and is used as the
> parent of the internal LAN966x interrupt controller to route the
> interrupts to the assigned PCI INTx interrupt.

...

> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>

> +#include <linux/kernel.h>

Why do you need this?

> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>

General comment to the headers (in all your patches), try to follow IWYU
principle, i.e. include what you use explicitly and don't use "proxy" headers
such as kernel.h which basically shouldn't be used at all in the drivers.

...

> +static irqreturn_t pci_dev_irq_handler(int irq, void *data)
> +{
> +	struct pci_dev_intr_ctrl *intr_ctrl = data;
> +	int ret;
> +
> +	ret = generic_handle_domain_irq(intr_ctrl->irq_domain, 0);
> +	return ret ? IRQ_NONE : IRQ_HANDLED;

There is a macro for that IRQ_RETVAL() IIRC.

> +}

...

> +static int devm_pci_dev_create_intr_ctrl(struct pci_dev *pdev)
> +{
> +	struct pci_dev_intr_ctrl *intr_ctrl;
> +
> +	intr_ctrl = pci_dev_create_intr_ctrl(pdev);

> +

Redundant blank line.

> +	if (IS_ERR(intr_ctrl))
> +		return PTR_ERR(intr_ctrl);
> +
> +	return devm_add_action_or_reset(&pdev->dev, devm_pci_dev_remove_intr_ctrl, intr_ctrl);
> +}

...

> +static int lan966x_pci_load_overlay(struct lan966x_pci *data)
> +{
> +	u32 dtbo_size = __dtbo_lan966x_pci_end - __dtbo_lan966x_pci_begin;
> +	void *dtbo_start = __dtbo_lan966x_pci_begin;
> +	int ret;
> +
> +	ret = of_overlay_fdt_apply(dtbo_start, dtbo_size, &data->ovcs_id, data->dev->of_node);

dev_of_node() ?

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

...

> +static int lan966x_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct lan966x_pci *data;
> +	int ret;

> +	if (!dev->of_node) {
> +		dev_err(dev, "Missing of_node for device\n");
> +		return -EINVAL;
> +	}

Why do you need this? The code you have in _create_intr_ctrl() will take care
already for this case.

> +	/* Need to be done before devm_pci_dev_create_intr_ctrl.
> +	 * It allocates an IRQ and so pdev->irq is updated

Missing period at the end.

> +	 */
> +	ret = pcim_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_pci_dev_create_intr_ctrl(pdev);
> +	if (ret)
> +		return ret;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, data);
> +	data->dev = dev;
> +	data->pci_dev = pdev;
> +
> +	ret = lan966x_pci_load_overlay(data);
> +	if (ret)
> +		return ret;

> +	pci_set_master(pdev);

You don't use MSI, what is this for?

> +	ret = of_platform_default_populate(dev->of_node, NULL, dev);

dev_of_node()

> +	if (ret)
> +		goto err_unload_overlay;
> +
> +	return 0;
> +
> +err_unload_overlay:
> +	lan966x_pci_unload_overlay(data);
> +	return ret;
> +}

...

> +static void lan966x_pci_remove(struct pci_dev *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct lan966x_pci *data = dev_get_drvdata(dev);

platform_get_drvdata()

> +	of_platform_depopulate(dev);
> +
> +	lan966x_pci_unload_overlay(data);

> +	pci_clear_master(pdev);

No need to call this excplicitly when pcim_enable_device() was called.

> +}

...

> +static struct pci_device_id lan966x_pci_ids[] = {
> +	{ PCI_DEVICE(0x1055, 0x9660) },

Don't you have VENDOR_ID defined somewhere?

> +	{ 0, }

Unneeded ' 0, ' part

> +};

-- 
With Best Regards,
Andy Shevchenko



