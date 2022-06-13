Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD03A54A1C6
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 23:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbiFMVut (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 17:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFMVur (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 17:50:47 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70A7186DD;
        Mon, 13 Jun 2022 14:50:45 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id 19so7523642iou.12;
        Mon, 13 Jun 2022 14:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3DnfSStrST9vh3VYXUX3uiUNREnNF9oj/5Rmy/GAuEE=;
        b=33oNdJmdVHVkzP8MpvMYPBAdvtSmvZ9hGy27EanZqMDWPcHtXwE4PBIB/kBS+vOT+P
         uuG/N54jlP0MWSernVriNW7QDH5IRnFM3WxKhCY6tv123AxoDTt0CCuRzsnp3XZRKIbG
         bE0LgBVJfBSMBJYufTIX7ZF0CH/SXONN35zPt4r7ir1IDjmKCJsGfgSGWEdGbjlq1jMk
         QYhFKnRoYXI7WFBHAxD0IVwLNRR7pHuMt51RpLddefQoEho6K+zhbsYhoIuX5FLR+wXT
         1e2XAVZc19LkOy8VAfPYNt2ocoi0hDOACAfY+FDG+eLSAsmRs+mG5jeZE0wAQcewuT0/
         Oy2w==
X-Gm-Message-State: AOAM531FlSUtAZCzzRlYCtQfklkZQzuE9UWIRYzcv1LFLYhDiNRSyPGs
        vEpJZUHG2Qvjr20xRJdRvg==
X-Google-Smtp-Source: ABdhPJwB/sVqU734p0nPbp/xMh3hN0vCsZwVh0yTqSZ5SK9pTkq4GyxlV0fjbaxfVDfLM1Ry5FMwvA==
X-Received: by 2002:a05:6638:5b0:b0:331:61eb:618a with SMTP id b16-20020a05663805b000b0033161eb618amr1104117jar.164.1655157044858;
        Mon, 13 Jun 2022 14:50:44 -0700 (PDT)
Received: from robh.at.kernel.org ([69.39.28.171])
        by smtp.gmail.com with ESMTPSA id f17-20020a02cad1000000b00331ce22e1e4sm4042193jap.2.2022.06.13.14.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 14:50:44 -0700 (PDT)
Received: (nullmailer pid 155359 invoked by uid 1000);
        Mon, 13 Jun 2022 21:50:43 -0000
Date:   Mon, 13 Jun 2022 15:50:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        krzk+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 4/7] PCI: renesas: Add R-Car Gen4 PCIe Endpoint support
Message-ID: <20220613215043.GB87830-robh@kernel.org>
References: <20220613115712.2831386-1-yoshihiro.shimoda.uh@renesas.com>
 <20220613115712.2831386-5-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613115712.2831386-5-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 13, 2022 at 08:57:09PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car Gen4 PCIe Endpoint support. This controller is based on
> Synopsys Designware PCIe.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/Kconfig            |   9 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  .../pci/controller/dwc/pcie-rcar-gen4-ep.c    | 253 ++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |   1 +
>  4 files changed, 264 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 3ddccc9c38c5..503ead1a4358 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -393,4 +393,13 @@ config PCIE_RCAR_GEN4
>  	  Say Y here if you want PCIe host controller support on R-Car Gen4 SoCs.
>  	  This uses the DesignWare core.
>  
> +config PCIE_RCAR_GEN4_EP
> +	bool "Renesas R-Car Gen4 PCIe Endpoint controller"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on PCI_ENDPOINT
> +	select PCIE_DW_EP
> +	help
> +	  Say Y here if you want PCIe endpoint controller support on R-Car Gen4
> +	  SoCs. This uses the DesignWare core.
> +
>  endmenu
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index b3f285e685f9..3d40346efd27 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>  obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
>  obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
>  obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o pcie-rcar-gen4-host.o
> +obj-$(CONFIG_PCIE_RCAR_GEN4_EP) += pcie-rcar-gen4.o pcie-rcar-gen4-ep.o
>  
>  # The following drivers are for devices that use the generic ACPI
>  # pci_root.c driver but don't support standard ECAM config access.
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c b/drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
> new file mode 100644
> index 000000000000..622e32c7a410
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
> @@ -0,0 +1,253 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe Endpoint driver for Renesas R-Car Gen4 Series SoCs
> + * Copyright (C) 2022 Renesas Electronics Corporation
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +
> +#include "pcie-rcar-gen4.h"
> +#include "pcie-designware.h"
> +
> +/* Configuration */
> +#define PCICONF3		0x000c
> +#define  MULTI_FUNC		BIT(23)
> +
> +struct rcar_gen4_pcie_ep {
> +	struct rcar_gen4_pcie	*pcie;
> +	struct dw_pcie		*pci;

Would be better if these are embedded structs rather than pointers. Then 
it is 1 alloc. Also, 'pci' and 'pcie' aren't very clear. rcar_pcie and 
pcie perhaps. Or rcar and dw.

> +	u32			num_lanes;

What's wrong with dw_pcie.num_lanes?

> +};
> +
> +static void rcar_gen4_pcie_ep_init(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar;
> +
> +	for (bar = BAR_0; bar <= BAR_5; bar++)
> +		dw_pcie_ep_reset_bar(pci, bar);

Seems like the core code should be doing this.

> +}
> +
> +static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> +				       enum pci_epc_irq_type type,
> +				       u16 interrupt_num)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +
> +	switch (type) {
> +	case PCI_EPC_IRQ_LEGACY:
> +		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> +	case PCI_EPC_IRQ_MSI:
> +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> +	case PCI_EPC_IRQ_MSIX:
> +		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
> +	default:
> +		dev_err(pci->dev, "UNKNOWN IRQ type\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pci_epc_features rcar_gen4_pcie_epc_features = {
> +	.linkup_notifier = false,
> +	.msi_capable = true,
> +	.msix_capable = false,

If this is false, why do you call dw_pcie_ep_raise_msix_irq?

> +	.align = SZ_1M,
> +};
> +
> +static const struct pci_epc_features*
> +rcar_gen4_pcie_ep_get_features(struct dw_pcie_ep *ep)
> +{
> +	return &rcar_gen4_pcie_epc_features;
> +}
> +
> +static const struct dw_pcie_ep_ops pcie_ep_ops = {
> +	.ep_init = rcar_gen4_pcie_ep_init,
> +	.raise_irq = rcar_gen4_pcie_ep_raise_irq,
> +	.get_features = rcar_gen4_pcie_ep_get_features,
> +};
> +
> +static int rcar_gen4_add_pcie_ep(struct rcar_gen4_pcie_ep *pcie_ep,
> +			       struct platform_device *pdev)
> +{
> +	struct rcar_gen4_pcie *pcie = pcie_ep->pcie;
> +	struct dw_pcie *pci = pcie->pci;
> +	struct dw_pcie_ep *ep;
> +	struct resource *res;
> +	int ret;
> +
> +	ep = &pci->ep;
> +	ep->ops = &pcie_ep_ops;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
> +	if (!res)
> +		return -EINVAL;

Common code handles this.

> +
> +	ep->addr_size = resource_size(res);
> +
> +	ret = dw_pcie_ep_init(ep);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to initialize endpoint\n");
> +		return ret;
> +	}
> +
> +	pci->ops->start_link(pci);
> +
> +	return 0;
> +}
> +
> +static void rcar_gen4_remove_pcie_ep(struct rcar_gen4_pcie_ep *pcie_ep)
> +{
> +	dw_pcie_ep_exit(&pcie_ep->pcie->pci->ep);
> +}
> +
> +static void rcar_gen4_pcie_init_ep(struct rcar_gen4_pcie_ep *pcie_ep)
> +{
> +	struct rcar_gen4_pcie *pcie = pcie_ep->pcie;
> +	struct dw_pcie *pci = pcie->pci;
> +	int val;
> +
> +	/* Device type selection - Endpoint */
> +	val = rcar_gen4_pcie_readl(pcie, PCIEMSR0);
> +	val |= DEVICE_TYPE_EP;
> +	if (pcie_ep->num_lanes < 4)
> +		val |= BIFUR_MOD_SET_ON;
> +	rcar_gen4_pcie_writel(pcie, PCIEMSR0, val);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	/* Single function */
> +	val = dw_pcie_readl_dbi(pci, PCICONF3);
> +	val &= ~MULTI_FUNC;
> +	dw_pcie_writel_dbi(pci, PCICONF3, val);

Common DWC reg/bit? If so, belongs in common header.

> +
> +	/* Disable unused BARs */
> +	dw_pcie_writel_dbi(pci, SHADOW_REG(BAR2MASKF), 0x0);
> +	dw_pcie_writel_dbi(pci, SHADOW_REG(BAR3MASKF), 0x0);

Seems like something the common code should do.

> +
> +	/* Set Max Link Width */
> +	rcar_gen4_pcie_set_max_link_width(pci, pcie_ep->num_lanes);
> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +}
> +
> +static int rcar_gen4_pcie_ep_get_resources(struct rcar_gen4_pcie_ep *pcie_ep,
> +					   struct platform_device *pdev)
> +{
> +	struct rcar_gen4_pcie *pcie = pcie_ep->pcie;
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +	struct device_node *np = dev->of_node;
> +	struct resource *res;
> +	int err;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +	pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
> +	if (IS_ERR(pci->dbi_base))
> +		return PTR_ERR(pci->dbi_base);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
> +	pci->atu_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pci->atu_base))
> +		return PTR_ERR(pci->atu_base);

The common code handles these resources.

> +
> +	/* Renesas-specific registers */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "appl");
> +	pcie->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pcie->base))
> +		return PTR_ERR(pcie->base);
> +
> +	err = of_property_read_u32(np, "num-lanes", &pcie_ep->num_lanes);

Common code does this too. Lots of duplication! Please check. If it's 
something every DW controller has or might have, then the code for it 
belongs in the common code.

> +	if (err < 0) {
> +		dev_err(dev, "num-lanes not found %d\n", err);
> +		return err;
> +	}
> +
> +	return rcar_gen4_pcie_devm_clk_and_reset_get(pcie, dev);
> +}
> +
> +static int rcar_gen4_pcie_ep_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rcar_gen4_pcie_ep *pcie_ep;
> +	struct rcar_gen4_pcie *pcie;
> +	int err;
> +
> +	pcie_ep = devm_kzalloc(dev, sizeof(*pcie_ep), GFP_KERNEL);
> +	if (!pcie_ep)
> +		return -ENOMEM;
> +
> +	pcie = rcar_gen4_pcie_devm_alloc(dev);
> +	if (!pcie)
> +		return -ENOMEM;
> +	pcie_ep->pcie = pcie;
> +
> +	err = rcar_gen4_pcie_pm_runtime_enable(dev);
> +	if (err < 0) {
> +		dev_err(dev, "pm_runtime_get_sync failed\n");
> +		return err;
> +	}
> +
> +	err = rcar_gen4_pcie_ep_get_resources(pcie_ep, pdev);
> +	if (err < 0) {
> +		dev_err(dev, "failed to request resource: %d\n", err);
> +		goto err_pm_put;
> +	}
> +
> +	pcie->priv = pcie_ep;
> +	platform_set_drvdata(pdev, pcie);
> +
> +	err = rcar_gen4_pcie_prepare(pcie);
> +	if (err < 0)
> +		goto err_pm_put;
> +	rcar_gen4_pcie_init_ep(pcie_ep);
> +
> +	err = rcar_gen4_add_pcie_ep(pcie_ep, pdev);
> +	if (err < 0)
> +		goto err_ep_disable;
> +
> +	return 0;
> +
> +err_ep_disable:
> +	rcar_gen4_pcie_unprepare(pcie);
> +
> +err_pm_put:
> +	rcar_gen4_pcie_pm_runtime_disable(dev);
> +
> +	return err;
> +}
> +
> +static int rcar_gen4_pcie_ep_remove(struct platform_device *pdev)
> +{
> +	struct rcar_gen4_pcie *pcie = platform_get_drvdata(pdev);
> +	struct rcar_gen4_pcie_ep *pcie_ep = pcie->priv;
> +
> +	rcar_gen4_remove_pcie_ep(pcie_ep);
> +	rcar_gen4_pcie_unprepare(pcie_ep->pcie);
> +	rcar_gen4_pcie_pm_runtime_disable(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id rcar_gen4_pcie_of_match[] = {
> +	{ .compatible = "renesas,rcar-gen4-pcie-ep", },
> +	{},
> +};
> +
> +static struct platform_driver rcar_gen4_pcie_ep_driver = {
> +	.driver = {
> +		.name = "pcie-rcar-gen4-ep",
> +		.of_match_table = rcar_gen4_pcie_of_match,
> +	},
> +	.probe = rcar_gen4_pcie_ep_probe,
> +	.remove = rcar_gen4_pcie_ep_remove,
> +};
> +builtin_platform_driver(rcar_gen4_pcie_ep_driver);

Not a module or...

> +
> +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe endpoint controller driver");
> +MODULE_LICENSE("GPL v2");

A module? Should be a module if possible.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.h b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
> index bd01d0ffcac9..b6e285d8ebc0 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.h
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
> @@ -43,6 +43,7 @@ struct rcar_gen4_pcie {
>  	void __iomem		*base;
>  	struct clk		*bus_clk;
>  	struct reset_control	*rst;
> +	void			*priv;
>  };
>  
>  extern u32 rcar_gen4_pcie_readl(struct rcar_gen4_pcie *pcie, u32 reg);
> -- 
> 2.25.1
> 
