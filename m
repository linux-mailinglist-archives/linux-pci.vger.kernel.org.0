Return-Path: <linux-pci+bounces-35332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B49B408BD
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 17:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBC43A98DB
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DE92DE6F3;
	Tue,  2 Sep 2025 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApjN4+wd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E089279DDD;
	Tue,  2 Sep 2025 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756826313; cv=none; b=QftH8Gom7USmmTPsTXV375Mj8NO34q6BJxSpvTRdfgPihymnwYeFoRjpfnZRZjKLourp7G2IMOZgLlRIaF6FTbawetznCcBB5pfn6VbHFtLJfnBEJhl3zIuguNQAI+MFJNHdJjnBwUU+m28ADctswn674XuQnN4jTGsIQRdwNqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756826313; c=relaxed/simple;
	bh=vMshstqno7vuVDuvUK1zYuB6lswlHvvEGV9RJecyEus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lS9th+Wh1sL6Py9yyZDVONjjZwHRPiLyOWEtnPPB/NVXfi9ZUsCN/gJPuDCI0TQcghFnTnDGAZyQun81k4ii+mzIjhQxtbE1UvR/bkf5vVQD7BYSoe6zmZYNatUJp6lJvouk1jynjZXTBbY9U5sztaxFBYtYC6lC6F7dBfr4DXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApjN4+wd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66778C4CEED;
	Tue,  2 Sep 2025 15:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756826313;
	bh=vMshstqno7vuVDuvUK1zYuB6lswlHvvEGV9RJecyEus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ApjN4+wdgsoXdBsc7MpBBbC2cSgReIZ1ngEEzAmCPNBjOUv1q8mJJiJyg28pIJd7s
	 MQkdM9gMjmx3+NAzWP6DQyZzUiNIre750NEFFAGQHD3Uix3M0zAgNoSOFEXpc+OGJ0
	 6NdGqIO1/OlHve7LktMmSWsSIybuj6jS6swKmgSVd+SL9+QYeoA1bZpC9HbrMylSRx
	 bCaDBiYw0jZDAVAiNb1JULsapE6yLzH4bBkgHYImQU6g1ywGb1wimMv5TqK4nT1tUS
	 gAtKxl6NaKfDprSLf7VombO8Q7/sjhMc6e7atnCrJqk8Xe4txelD/cmsGWcznbkuta
	 sQjgzPFaTjL7g==
Date: Tue, 2 Sep 2025 16:18:28 +0100
From: Lee Jones <lee@kernel.org>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Michael Walle <mwalle@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 3/3] mfd: vortex: implement new driver for Vortex
 southbridges
Message-ID: <20250902151828.GU2163762@google.com>
References: <20250822135816.739582-1-marcos@orca.pet>
 <20250822135816.739582-4-marcos@orca.pet>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822135816.739582-4-marcos@orca.pet>

On Fri, 22 Aug 2025, Marcos Del Sol Vives wrote:

> This new driver loads resources related to southbridges available in DM&P
> Vortex devices, currently only the GPIO pins.
> 
> Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>
> ---
>  MAINTAINERS             |   1 +
>  drivers/mfd/Kconfig     |   9 +++
>  drivers/mfd/Makefile    |   1 +
>  drivers/mfd/vortex-sb.c | 135 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci_ids.h |   3 +
>  5 files changed, 149 insertions(+)
>  create mode 100644 drivers/mfd/vortex-sb.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index afa88f446630..63e410e23e95 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26957,6 +26957,7 @@ VORTEX HARDWARE SUPPORT
>  R:	Marcos Del Sol Vives <marcos@orca.pet>
>  S:	Maintained
>  F:	drivers/gpio/gpio-vortex.c
> +F:	drivers/mfd/vortex-sb.c
>  
>  VRF
>  M:	David Ahern <dsahern@kernel.org>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 425c5fba6cb1..fe54bb22687d 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2008,6 +2008,15 @@ config MFD_VX855
>  	  VIA VX855/VX875 south bridge. You will need to enable the vx855_spi
>  	  and/or vx855_gpio drivers for this to do anything useful.
>  
> +config MFD_VORTEX_SB
> +	tristate "Vortex southbridge"
> +	select MFD_CORE
> +	depends on PCI
> +	help
> +	  Say yes here if you want to have support for the southbridge
> +	  present on Vortex SoCs. You will need to enable the vortex-gpio
> +	  driver for this to do anything useful.
> +
>  config MFD_ARIZONA
>  	select REGMAP
>  	select REGMAP_IRQ
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index f7bdedd5a66d..2504ba311f1a 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -202,6 +202,7 @@ obj-$(CONFIG_MFD_JANZ_CMODIO)	+= janz-cmodio.o
>  obj-$(CONFIG_MFD_TPS6586X)	+= tps6586x.o
>  obj-$(CONFIG_MFD_VX855)		+= vx855.o
>  obj-$(CONFIG_MFD_WL1273_CORE)	+= wl1273-core.o
> +obj-$(CONFIG_MFD_VORTEX_SB)	+= vortex-sb.o
>  
>  si476x-core-y := si476x-cmd.o si476x-prop.o si476x-i2c.o
>  obj-$(CONFIG_MFD_SI476X_CORE)	+= si476x-core.o
> diff --git a/drivers/mfd/vortex-sb.c b/drivers/mfd/vortex-sb.c
> new file mode 100644
> index 000000000000..141fa19773e2
> --- /dev/null
> +++ b/drivers/mfd/vortex-sb.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  MFD southbridge driver for Vortex SoCs

Drop references to MFD.

Call it "Core southbridge ..."

> + *
> + *  Author: Marcos Del Sol Vives <marcos@orca.pet>
> + *
> + *  Based on the RDC321x MFD driver by Florian Fainelli and Bernhard Loos

Drop this.

> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/pci.h>
> +#include <linux/mfd/core.h>

Alphabetical.

> +
> +struct vortex_southbridge {
> +	const struct mfd_cell *cells;
> +	int n_cells;
> +};

Why is this needed?

> +/* Layout for Vortex86DX/MX */
> +static const struct resource vortex_dx_gpio_resources[] = {
> +	{
> +		.name	= "dat1",
> +		.start	= 0x78,

Define _all_ magic numbers.


> +		.end	= 0x7C,
> +		.flags	= IORESOURCE_IO,
> +	}, {
> +		.name	= "dir1",
> +		.start	= 0x98,
> +		.end	= 0x9C,
> +		.flags	= IORESOURCE_IO,
> +	}

Use DEFINE_RES_*() macros.

> +};
> +
> +static const struct mfd_cell vortex_dx_sb_cells[] = {
> +	{
> +		.name		= "vortex-gpio",
> +		.resources	= vortex_dx_gpio_resources,
> +		.num_resources	= ARRAY_SIZE(vortex_dx_gpio_resources),
> +	},
> +};

It's not an MFD until you have more than one device.

> +static const struct vortex_southbridge vortex_dx_sb = {
> +	.cells = vortex_dx_sb_cells,
> +	.n_cells = ARRAY_SIZE(vortex_dx_sb_cells),
> +};
> +
> +/* Layout for Vortex86DX2/DX3 */
> +static const struct resource vortex_dx2_gpio_resources[] = {
> +	{
> +		.name	= "dat1",
> +		.start	= 0x78,
> +		.end	= 0x7C,
> +		.flags	= IORESOURCE_IO,
> +	}, {
> +		.name	= "dat2",
> +		.start	= 0x100,
> +		.end	= 0x105,
> +		.flags	= IORESOURCE_IO,
> +	}, {
> +		.name	= "dir1",
> +		.start	= 0x98,
> +		.end	= 0x9D,
> +		.flags	= IORESOURCE_IO,
> +	}, {
> +		.name	= "dir2",
> +		.start	= 0x93,
> +		.end	= 0x97,
> +		.flags	= IORESOURCE_IO,
> +	}
> +};

As above.

> +static const struct mfd_cell vortex_dx2_sb_cells[] = {
> +	{
> +		.name		= "vortex-gpio",
> +		.resources	= vortex_dx2_gpio_resources,
> +		.num_resources	= ARRAY_SIZE(vortex_dx2_gpio_resources),
> +	},
> +};
> +
> +static const struct vortex_southbridge vortex_dx2_sb = {
> +	.cells = vortex_dx2_sb_cells,
> +	.n_cells = ARRAY_SIZE(vortex_dx2_sb_cells),
> +};
> +
> +static int vortex_sb_probe(struct pci_dev *pdev,
> +			   const struct pci_device_id *ent)

Why line-feed here and not 2 lines down?

> +{
> +	struct vortex_southbridge *priv = (struct vortex_southbridge *) ent->driver_data;

s/priv/ddata/

> +	int err;
> +
> +	/*
> +	 * In the Vortex86DX3, the southbridge appears twice (on both 00:07.0
> +	 * and 00:07.1). Register only once for .0.
> +	 *
> +	 * Other Vortex boards (eg Vortex86MX+) have the southbridge exposed
> +	 * only once, also at 00:07.0.
> +	 */
> +	if (PCI_FUNC(pdev->devfn) != 0)
> +		return -ENODEV;
> +
> +	err = pci_enable_device(pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "failed to enable device\n");
> +		return err;
> +	}
> +
> +	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
> +				    priv->cells, priv->n_cells,
> +				    NULL, 0, NULL);
> +}
> +
> +static const struct pci_device_id vortex_sb_table[] = {
> +	/* Vortex86DX */
> +	{ PCI_DEVICE_DATA(RDC, R6031, &vortex_dx_sb) },

We're not passing one initialisation API's data (MFD) through another (PCI).

Pass a device ID (if you don't already have one) and match on that instead.

> +	/* Vortex86DX2/DX3 */
> +	{ PCI_DEVICE_DATA(RDC, R6035, &vortex_dx2_sb) },
> +	/* Vortex86MX */
> +	{ PCI_DEVICE_DATA(RDC, R6036, &vortex_dx_sb) },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(pci, vortex_sb_table);
> +
> +static struct pci_driver vortex_sb_driver = {
> +	.name		= "vortex-sb",
> +	.id_table	= vortex_sb_table,
> +	.probe		= vortex_sb_probe,
> +};
> +

Remove this line.

> +module_pci_driver(vortex_sb_driver);
> +
> +MODULE_AUTHOR("Marcos Del Sol Vives <marcos@orca.pet>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Vortex MFD southbridge driver");
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 92ffc4373f6d..2c7afebd94ea 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2412,6 +2412,9 @@
>  #define PCI_VENDOR_ID_RDC		0x17f3
>  #define PCI_DEVICE_ID_RDC_R6020		0x6020
>  #define PCI_DEVICE_ID_RDC_R6030		0x6030
> +#define PCI_DEVICE_ID_RDC_R6031		0x6031
> +#define PCI_DEVICE_ID_RDC_R6035		0x6035
> +#define PCI_DEVICE_ID_RDC_R6036		0x6036
>  #define PCI_DEVICE_ID_RDC_R6040		0x6040
>  #define PCI_DEVICE_ID_RDC_R6060		0x6060
>  #define PCI_DEVICE_ID_RDC_R6061		0x6061
> -- 
> 2.34.1
> 

-- 
Lee Jones [李琼斯]

