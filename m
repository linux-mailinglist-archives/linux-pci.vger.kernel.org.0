Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E80BCC97
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2019 18:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfIXQjN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Sep 2019 12:39:13 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43122 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbfIXQjN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Sep 2019 12:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=llkvlXH2HyzT21BvZS+MKPSLJBD5XYlNUa4xtWE/sQQ=; b=b3U7Jst2wOzDvJpl23r2N6Nwi
        AjQgS3yV6p6Fca6pWTLCSEwNDgB5uKGvazALJ7y1jq3srLcG0AE9Pib52YrpDk5bg1uRhvpF3Ta7G
        mKnSjU79iiB5E9WHKMNIgzK5Ll2Gfjuk9KQZyYgyTsvV7rEVryJEssRBriKYS7HzwycrL8zfmf8WQ
        GF1i1d0QwQBQuwI6fvrTtU87qU0Qft2dKx++QipFuK23kpRxJrF3pmgvH1YYD82+brX9MAisxIj2E
        Navfx+UbSGVnRX79Gp80HoMH+IZE22RUViczE//IB9tY/cOxbyjLnbh8Ob6ZSk2vrOvfaA0AHpRxd
        jG8a/xkSQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47712)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iCnq2-0002wF-2p; Tue, 24 Sep 2019 17:38:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iCnpy-0001PI-IA; Tue, 24 Sep 2019 17:38:50 +0100
Date:   Tue, 24 Sep 2019 17:38:50 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     Zhiqiang.Hou@nxp.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, Minghuan.Lian@nxp.com,
        andrew.murray@arm.com, mingkai.hu@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] PCI: mobiveil: Add PCIe Gen4 EP driver for NXP
 Layerscape SoCs
Message-ID: <20190924163850.GY25745@shell.armlinux.org.uk>
References: <20190916021742.22844-1-xiaowei.bao@nxp.com>
 <20190916021742.22844-4-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916021742.22844-4-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 16, 2019 at 10:17:39AM +0800, Xiaowei Bao wrote:
> This PCIe controller is based on the Mobiveil GPEX IP, it work in EP
> mode if select this config opteration.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
>  MAINTAINERS                                        |   2 +
>  drivers/pci/controller/mobiveil/Kconfig            |  17 ++-
>  drivers/pci/controller/mobiveil/Makefile           |   1 +
>  .../controller/mobiveil/pcie-layerscape-gen4-ep.c  | 156 +++++++++++++++++++++
>  4 files changed, 173 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b997056..0858b54 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12363,11 +12363,13 @@ F:	drivers/pci/controller/dwc/*layerscape*
>  
>  PCI DRIVER FOR NXP LAYERSCAPE GEN4 CONTROLLER
>  M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> +M:	Xiaowei Bao <xiaowei.bao@nxp.com>
>  L:	linux-pci@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
>  F:	drivers/pci/controller/mobibeil/pcie-layerscape-gen4.c
> +F:	drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c
>  
>  PCI DRIVER FOR GENERIC OF HOSTS
>  M:	Will Deacon <will@kernel.org>
> diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller/mobiveil/Kconfig
> index 2054950..0696b6e 100644
> --- a/drivers/pci/controller/mobiveil/Kconfig
> +++ b/drivers/pci/controller/mobiveil/Kconfig
> @@ -27,13 +27,24 @@ config PCIE_MOBIVEIL_PLAT
>  	  for address translation and it is a PCIe Gen4 IP.
>  
>  config PCIE_LAYERSCAPE_GEN4
> -	bool "Freescale Layerscape PCIe Gen4 controller"
> +	bool "Freescale Layerscpe PCIe Gen4 controller in RC mode"
>  	depends on PCI
>  	depends on OF && (ARM64 || ARCH_LAYERSCAPE)
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_MOBIVEIL_HOST
>  	help
>  	  Say Y here if you want PCIe Gen4 controller support on
> -	  Layerscape SoCs. The PCIe controller can work in RC or
> -	  EP mode according to RCW[HOST_AGT_PEX] setting.
> +	  Layerscape SoCs. And the PCIe controller work in RC mode
> +	  by setting the RCW[HOST_AGT_PEX] to 0.
> +
> +config PCIE_LAYERSCAPE_GEN4_EP
> +	bool "Freescale Layerscpe PCIe Gen4 controller in EP mode"
> +	depends on PCI
> +	depends on OF && (ARM64 || ARCH_LAYERSCAPE)
> +	depends on PCI_ENDPOINT
> +	select PCIE_MOBIVEIL_EP
> +	help
> +	  Say Y here if you want PCIe Gen4 controller support on
> +	  Layerscape SoCs. And the PCIe controller work in EP mode
> +	  by setting the RCW[HOST_AGT_PEX] to 1.
>  endmenu
> diff --git a/drivers/pci/controller/mobiveil/Makefile b/drivers/pci/controller/mobiveil/Makefile
> index 686d41f..6f54856 100644
> --- a/drivers/pci/controller/mobiveil/Makefile
> +++ b/drivers/pci/controller/mobiveil/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_PCIE_MOBIVEIL_HOST) += pcie-mobiveil-host.o
>  obj-$(CONFIG_PCIE_MOBIVEIL_EP) += pcie-mobiveil-ep.o
>  obj-$(CONFIG_PCIE_MOBIVEIL_PLAT) += pcie-mobiveil-plat.o
>  obj-$(CONFIG_PCIE_LAYERSCAPE_GEN4) += pcie-layerscape-gen4.o
> +obj-$(CONFIG_PCIE_LAYERSCAPE_GEN4_EP) += pcie-layerscape-gen4-ep.o
> diff --git a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c
> new file mode 100644
> index 0000000..7bfec51
> --- /dev/null
> +++ b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe controller EP driver for Freescale Layerscape SoCs
> + *
> + * Copyright (C) 2019 NXP Semiconductor.
> + *
> + * Author: Xiaowei Bao <xiaowei.bao@nxp.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +
> +#include "pcie-mobiveil.h"
> +
> +#define PCIE_LX2_BAR_NUM	4
> +
> +#define to_ls_pcie_g4_ep(x)	dev_get_drvdata((x)->dev)
> +
> +struct ls_pcie_g4_ep {
> +	struct mobiveil_pcie		*mv_pci;
> +};
> +
> +static const struct of_device_id ls_pcie_g4_ep_of_match[] = {
> +	{ .compatible = "fsl,lx2160a-pcie-ep",},
> +	{ },
> +};
> +
> +static const struct pci_epc_features ls_pcie_g4_epc_features = {
> +	.linkup_notifier = false,
> +	.msi_capable = true,
> +	.msix_capable = true,
> +	.reserved_bar = (1 << BAR_4) | (1 << BAR_5),

			BIT(BAR_4) | BIT(BAR_5) ?

> +};
> +
> +static const struct pci_epc_features*
> +ls_pcie_g4_ep_get_features(struct mobiveil_pcie_ep *ep)
> +{
> +	return &ls_pcie_g4_epc_features;
> +}
> +
> +static void ls_pcie_g4_ep_init(struct mobiveil_pcie_ep *ep)
> +{
> +	struct mobiveil_pcie *mv_pci = to_mobiveil_pcie_from_ep(ep);
> +	int win_idx;
> +	u8 bar;
> +
> +	ep->bar_num = PCIE_LX2_BAR_NUM;
> +
> +	for (bar = BAR_0; bar < ep->epc->max_functions * ep->bar_num; bar++)
> +		mobiveil_pcie_ep_reset_bar(mv_pci, bar);
> +
> +	for (win_idx = 0; win_idx < ep->apio_wins; win_idx++)
> +		mobiveil_pcie_disable_ob_win(mv_pci, win_idx);
> +}
> +
> +static int ls_pcie_g4_ep_raise_irq(struct mobiveil_pcie_ep *ep, u8 func_no,
> +				   enum pci_epc_irq_type type,
> +				   u16 interrupt_num)
> +{
> +	struct mobiveil_pcie *mv_pci = to_mobiveil_pcie_from_ep(ep);
> +
> +	switch (type) {
> +	case PCI_EPC_IRQ_LEGACY:
> +		return mobiveil_pcie_ep_raise_legacy_irq(ep, func_no);
> +	case PCI_EPC_IRQ_MSI:
> +		return mobiveil_pcie_ep_raise_msi_irq(ep, func_no,
> +						      interrupt_num);
> +	case PCI_EPC_IRQ_MSIX:
> +		return mobiveil_pcie_ep_raise_msix_irq(ep, func_no,
> +						       interrupt_num);
> +	default:
> +		dev_err(&mv_pci->pdev->dev, "UNKNOWN IRQ type\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct mobiveil_pcie_ep_ops pcie_ep_ops = {
> +	.ep_init = ls_pcie_g4_ep_init,
> +	.raise_irq = ls_pcie_g4_ep_raise_irq,
> +	.get_features = ls_pcie_g4_ep_get_features,
> +};
> +
> +static int __init ls_pcie_gen4_add_pcie_ep(struct ls_pcie_g4_ep *ls_ep,
> +					   struct platform_device *pdev)
> +{
> +	struct mobiveil_pcie *mv_pci = ls_ep->mv_pci;
> +	struct device *dev = &pdev->dev;
> +	struct mobiveil_pcie_ep *ep;
> +	struct resource *res;
> +	int ret;
> +
> +	ep = &mv_pci->ep;
> +	ep->ops = &pcie_ep_ops;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
> +	if (!res)
> +		return -EINVAL;
> +
> +	ep->phys_base = res->start;
> +	ep->addr_size = resource_size(res);
> +
> +	ret = mobiveil_pcie_ep_init(ep);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize layerscape endpoint\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init ls_pcie_g4_ep_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mobiveil_pcie *mv_pci;
> +	struct ls_pcie_g4_ep *ls_ep;
> +	struct resource *res;
> +	int ret;
> +
> +	ls_ep = devm_kzalloc(dev, sizeof(*ls_ep), GFP_KERNEL);
> +	if (!ls_ep)
> +		return -ENOMEM;
> +
> +	mv_pci = devm_kzalloc(dev, sizeof(*mv_pci), GFP_KERNEL);
> +	if (!mv_pci)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
> +	mv_pci->csr_axi_slave_base = devm_pci_remap_cfg_resource(dev, res);
> +	if (IS_ERR(mv_pci->csr_axi_slave_base))
> +		return PTR_ERR(mv_pci->csr_axi_slave_base);
> +
> +	mv_pci->pdev = pdev;
> +	ls_ep->mv_pci = mv_pci;
> +
> +	platform_set_drvdata(pdev, ls_ep);
> +
> +	ret = ls_pcie_gen4_add_pcie_ep(ls_ep, pdev);
> +
> +	return ret;
> +}
> +
> +static struct platform_driver ls_pcie_g4_ep_driver = {
> +	.driver = {
> +		.name = "layerscape-pcie-gen4-ep",
> +		.of_match_table = ls_pcie_g4_ep_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +builtin_platform_driver_probe(ls_pcie_g4_ep_driver, ls_pcie_g4_ep_probe);
> -- 
> 2.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
