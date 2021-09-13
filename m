Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A100409E7D
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 22:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348252AbhIMUvl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 16:51:41 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:58889 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347850AbhIMUvP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Sep 2021 16:51:15 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id DEC27580E89;
        Mon, 13 Sep 2021 16:49:58 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Mon, 13 Sep 2021 16:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=m0LGWP1WSCvGQ2DYDtucYeRXsxGz
        LZXMe3rABFJpklM=; b=o9cvAVkJ9HSHlIF93zlZ1Wsoo35lnxHbsuY/jtrziE6n
        0lRy3aCJ/c8WHH9gy4yLjZ1df3YHDjTu8cjxqPQQAmKK7MTgXJrA5G3TJaJIW9TO
        1FlVrjjvs3NsYzuUUvmWiM9HkA8wLzvqTNAAhy8aUbOCtm7hKY6xPc6Q+NKSbs2U
        zyWORD9F8N28eJfIVPzgV+srLPoREBPLCVzR8PH/18NL+go9RiUhVRcyOi0fMHcH
        r8nmihe2Wio56U3rKPakZWd2KZM5e/DEPzCmIXlaFEzrfeR4aBZuKJGc4ynCj3/E
        JCCBMGBHubAmwsgw6JBoz+DIB7hqvuq96nNq8CHVow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=m0LGWP
        1WSCvGQ2DYDtucYeRXsxGzLZXMe3rABFJpklM=; b=XvMvLFtZFUuSJQpJ+CpmRN
        MtRt2jQOzee2X4gWZf660Ub+lqSJopNqAeNk40S8nnRL3oWSWa6nHCfZVg7TsuQF
        a+UZ/DW3oLe8Jy1k4eyOy9cZd7aFvcIemVOsGd+Bhpf3aUw8JGUR/oKsNUXVuu2g
        mshQm0JAUaPFEXRbKGJfhiJzm52/3KJyYtBJjI1GNQRn3JUo5lvjcewP6WLtN8lj
        MsN8ByUpdhGlQlvHhjD+wsP9dfTcBAmZlDNktY0pelBS5S5MQ8ZjRO5A/qfQJfo5
        Ree/hgzLeG3bi40H6rPuktz1WGMQ/9NUo5CHiU8VeHLd572q51CC38QbQ7z3LVVw
        ==
X-ME-Sender: <xms:drk_YRLejLWCqpQGtvpjalrQP4ofXuygVE9K11u0IaJpUIdVEhtj8A>
    <xme:drk_YdLVDHkRAybSaIV9VXQeBZQBP9GFZU4dzfFIiLa108WiYXtKDFN2FECBFtCHy
    tco1PwBmpO3ooLOAX8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegjedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepvedvgeevuddvvedvgfelfeegiedvgeehieeutdelvedvieevveeljeef
    vedtleehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdr
    uggvvh
X-ME-Proxy: <xmx:drk_YZsOikPLUyiDqSOOeW4ggfBMJfNopI_OunPiuorIY8VrxKtQ-w>
    <xmx:drk_YSbmrvDly6HUE9Daf9yy2w_ft66TARBoXCsVQuLZzsVPNF2K8w>
    <xmx:drk_YYbmifjRNLl6yRo-7oFCJMjskPYZVQ_NPOxt14p20_wbLWGERg>
    <xmx:drk_YSDSMJvFYBXH2NjHeyMaQtR6hgkSeJXbemiQWqYcLuvT7PxAQA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ED87B51C0060; Mon, 13 Sep 2021 16:49:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1229-g7ca81dfce5-fm-20210908.005-g7ca81dfc
Mime-Version: 1.0
Message-Id: <6eb53661-e11e-4634-9fa5-5e7e62d57a15@www.fastmail.com>
In-Reply-To: <20210913182550.264165-5-maz@kernel.org>
References: <20210913182550.264165-1-maz@kernel.org>
 <20210913182550.264165-5-maz@kernel.org>
Date:   Mon, 13 Sep 2021 22:48:47 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Marc Zyngier" <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     "Bjorn Helgaas" <bhelgaas@google.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Stan Skowronek" <stan@corellium.com>,
        "Mark Kettenis" <kettenis@openbsd.org>,
        "Hector Martin" <marcan@marcan.st>,
        "Robin Murphy" <Robin.Murphy@arm.com>, kernel-team@android.com
Subject: Re: [PATCH v3 04/10] PCI: apple: Add initial hardware bring-up
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On Mon, Sep 13, 2021, at 20:25, Marc Zyngier wrote:
> From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> 
> Add a minimal driver to bring up the PCIe bus on Apple system-on-chips,
> particularly the Apple M1. This driver exposes the internal bus used for
> the USB type-A ports, Ethernet, Wi-Fi, and Bluetooth. Bringing up the
> radios requires additional drivers beyond what's necessary for PCIe
> itself.
> 
> At this stage, nothing is functionnal.
> 
> Co-developed-by: Stan Skowronek <stan@corellium.com>
> Signed-off-by: Stan Skowronek <stan@corellium.com>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20210816031621.240268-3-alyssa@rosenzweig.io
> ---
>  MAINTAINERS                         |   7 +
>  drivers/pci/controller/Kconfig      |  12 ++
>  drivers/pci/controller/Makefile     |   1 +
>  drivers/pci/controller/pcie-apple.c | 243 ++++++++++++++++++++++++++++
>  4 files changed, 263 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-apple.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 813a847e2d64..9905cc48fed9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1280,6 +1280,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
>  F:	drivers/iommu/apple-dart.c
>  
> +APPLE PCIE CONTROLLER DRIVER
> +M:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
> +M:	Marc Zyngier <maz@kernel.org>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	drivers/pci/controller/pcie-apple.c
> +
>  APPLE SMC DRIVER
>  M:	Henrik Rydberg <rydberg@bitmath.org>
>  L:	linux-hwmon@vger.kernel.org
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 326f7d13024f..814833a8120d 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -312,6 +312,18 @@ config PCIE_HISI_ERR
>  	  Say Y here if you want error handling support
>  	  for the PCIe controller's errors on HiSilicon HIP SoCs
>  
> +config PCIE_APPLE
> +	tristate "Apple PCIe controller"
> +	depends on ARCH_APPLE || COMPILE_TEST
> +	depends on OF
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	help
> +	  Say Y here if you want to enable PCIe controller support on Apple
> +	  system-on-chips, like the Apple M1. This is required for the USB
> +	  type-A ports, Ethernet, Wi-Fi, and Bluetooth.
> +
> +	  If unsure, say Y if you have an Apple Silicon system.
> +
>  source "drivers/pci/controller/dwc/Kconfig"
>  source "drivers/pci/controller/mobiveil/Kconfig"
>  source "drivers/pci/controller/cadence/Kconfig"
> diff --git a/drivers/pci/controller/Makefile 
> b/drivers/pci/controller/Makefile
> index aaf30b3dcc14..f9d40bad932c 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_VMD) += vmd.o
>  obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
>  obj-$(CONFIG_PCI_LOONGSON) += pci-loongson.o
>  obj-$(CONFIG_PCIE_HISI_ERR) += pcie-hisi-error.o
> +obj-$(CONFIG_PCIE_APPLE) += pcie-apple.o
>  # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
>  obj-y				+= dwc/
>  obj-y				+= mobiveil/
> diff --git a/drivers/pci/controller/pcie-apple.c 
> b/drivers/pci/controller/pcie-apple.c
> new file mode 100644
> index 000000000000..f3c414950a10
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -0,0 +1,243 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host bridge driver for Apple system-on-chips.
> + *
> + * The HW is ECAM compliant, so once the controller is initialized,
> + * the driver mostly deals MSI mapping and handling of per-port
> + * interrupts (INTx, management and error signals).
> + *
> + * Initialization requires enabling power and clocks, along with a
> + * number of register pokes.
> + *
> + * Copyright (C) 2021 Alyssa Rosenzweig <alyssa@rosenzweig.io>
> + * Copyright (C) 2021 Google LLC
> + * Copyright (C) 2021 Corellium LLC
> + * Copyright (C) 2021 Mark Kettenis <kettenis@openbsd.org>
> + *
> + * Author: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> + * Author: Marc Zyngier <maz@kernel.org>
> + */
> +
> [...]
> +
> +static inline void rmwl(u32 clr, u32 set, void __iomem *addr)
> +{
> +	writel_relaxed((readl_relaxed(addr) & ~clr) | set, addr);
> +}

This helper is a bit strange, especially since it's always only used
with either clr != 0 or set != 0 but never (clr = 0 and set = 0) afaict.
Maybe create two instead for setting and clearing bits?

> +
> +static int apple_pcie_setup_port(struct apple_pcie *pcie,
> +				 struct device_node *np)
> +{
> +	struct platform_device *platform = to_platform_device(pcie->dev);
> +	struct apple_pcie_port *port;
> +	struct gpio_desc *reset;
> +	u32 stat, idx;
> +	int ret;
> +
> +	reset = gpiod_get_from_of_node(np, "reset-gpios", 0,
> +				       GPIOD_OUT_LOW, "#PERST");
> +	if (IS_ERR(reset))
> +		return PTR_ERR(reset);
> +
> +	port = devm_kzalloc(pcie->dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	ret = of_property_read_u32_index(np, "reg", 0, &idx);
> +	if (ret)
> +		return ret;
> +
> +	/* Use the first reg entry to work out the port index */
> +	port->idx = idx >> 11;
> +	port->pcie = pcie;
> +	port->np = np;
> +
> +	port->base = devm_platform_ioremap_resource(platform, port->idx + 2);
> +	if (IS_ERR(port->base))
> +		return -ENODEV;
> +
> +	rmwl(0, PORT_APPCLK_EN, port + PORT_APPCLK);
> +
> +	rmwl(0, PORT_PERST_OFF, port->base + PORT_PERST);
> +	gpiod_set_value(reset, 1);
> +
> +	ret = readl_relaxed_poll_timeout(port->base + PORT_STATUS, stat,
> +					 stat & PORT_STATUS_READY, 100, 250000);
> +	if (ret < 0) {
> +		dev_err(pcie->dev, "port %pOF ready wait timeout\n", np);
> +		return ret;
> +	}
> +
> +	/* Flush writes and enable the link */
> +	dma_wmb();

This is a DMA barrier but there's no DMA you need to order this against
here. I think you can just drop it.

> +
> +	writel_relaxed(PORT_LTSSMCTL_START, port->base + PORT_LTSSMCTL);
> +
> +	return 0;
> +}
> +



Sven

