Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDDD4855E5
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 16:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241504AbiAEPd3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 10:33:29 -0500
Received: from foss.arm.com ([217.140.110.172]:45498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230238AbiAEPd3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Jan 2022 10:33:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DADA811D4;
        Wed,  5 Jan 2022 07:33:28 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 009773F774;
        Wed,  5 Jan 2022 07:33:27 -0800 (PST)
Date:   Wed, 5 Jan 2022 15:33:16 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, robh@kernel.org, bhelgaas@google.com,
        minghuan.Lian@nxp.com, leoyang.li@nxp.com
Subject: Re: [PATCHv6] PCI: layerscape: Change to use the DWC common link-up
 check function
Message-ID: <20220105153316.GA7762@lpieralisi>
References: <20211224094000.8513-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224094000.8513-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 24, 2021 at 05:40:00PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The current Layerscape PCIe driver directly uses the physical layer
> LTSSM code to check the link-up state, which treats the > L0 states
> as link-up. This is not correct, since there is not explicit map
> between link-up state and LTSSM. So this patch changes to use the
> DWC common link-up check function.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> V6:
>  - This patch is splited from the V5 version of Layerscape PCIe Power
>    Management support series.
>  - Removed the driver data structure.
> 
>  drivers/pci/controller/dwc/pci-layerscape.c | 152 ++------------------
>  1 file changed, 11 insertions(+), 141 deletions(-)

Applied to pci/dwc, thanks.

Lorenzo

> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 5b9c625df7b8..6a4f0619bb1c 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -3,6 +3,7 @@
>   * PCIe host controller driver for Freescale Layerscape SoCs
>   *
>   * Copyright (C) 2014 Freescale Semiconductor.
> + * Copyright 2021 NXP
>   *
>   * Author: Minghuan Lian <Minghuan.Lian@freescale.com>
>   */
> @@ -22,12 +23,6 @@
>  
>  #include "pcie-designware.h"
>  
> -/* PEX1/2 Misc Ports Status Register */
> -#define SCFG_PEXMSCPORTSR(pex_idx)	(0x94 + (pex_idx) * 4)
> -#define LTSSM_STATE_SHIFT	20
> -#define LTSSM_STATE_MASK	0x3f
> -#define LTSSM_PCIE_L0		0x11 /* L0 state */
> -
>  /* PEX Internal Configuration Registers */
>  #define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
>  #define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
> @@ -35,20 +30,8 @@
>  
>  #define PCIE_IATU_NUM		6
>  
> -struct ls_pcie_drvdata {
> -	u32 lut_offset;
> -	u32 ltssm_shift;
> -	u32 lut_dbg;
> -	const struct dw_pcie_host_ops *ops;
> -	const struct dw_pcie_ops *dw_pcie_ops;
> -};
> -
>  struct ls_pcie {
>  	struct dw_pcie *pci;
> -	void __iomem *lut;
> -	struct regmap *scfg;
> -	const struct ls_pcie_drvdata *drvdata;
> -	int index;
>  };
>  
>  #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
> @@ -83,38 +66,6 @@ static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
>  	iowrite32(val, pci->dbi_base + PCIE_STRFMR1);
>  }
>  
> -static int ls1021_pcie_link_up(struct dw_pcie *pci)
> -{
> -	u32 state;
> -	struct ls_pcie *pcie = to_ls_pcie(pci);
> -
> -	if (!pcie->scfg)
> -		return 0;
> -
> -	regmap_read(pcie->scfg, SCFG_PEXMSCPORTSR(pcie->index), &state);
> -	state = (state >> LTSSM_STATE_SHIFT) & LTSSM_STATE_MASK;
> -
> -	if (state < LTSSM_PCIE_L0)
> -		return 0;
> -
> -	return 1;
> -}
> -
> -static int ls_pcie_link_up(struct dw_pcie *pci)
> -{
> -	struct ls_pcie *pcie = to_ls_pcie(pci);
> -	u32 state;
> -
> -	state = (ioread32(pcie->lut + pcie->drvdata->lut_dbg) >>
> -		 pcie->drvdata->ltssm_shift) &
> -		 LTSSM_STATE_MASK;
> -
> -	if (state < LTSSM_PCIE_L0)
> -		return 0;
> -
> -	return 1;
> -}
> -
>  /* Forward error response of outbound non-posted requests */
>  static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
>  {
> @@ -139,96 +90,20 @@ static int ls_pcie_host_init(struct pcie_port *pp)
>  	return 0;
>  }
>  
> -static int ls1021_pcie_host_init(struct pcie_port *pp)
> -{
> -	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -	struct ls_pcie *pcie = to_ls_pcie(pci);
> -	struct device *dev = pci->dev;
> -	u32 index[2];
> -	int ret;
> -
> -	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node,
> -						     "fsl,pcie-scfg");
> -	if (IS_ERR(pcie->scfg)) {
> -		ret = PTR_ERR(pcie->scfg);
> -		dev_err(dev, "No syscfg phandle specified\n");
> -		pcie->scfg = NULL;
> -		return ret;
> -	}
> -
> -	if (of_property_read_u32_array(dev->of_node,
> -				       "fsl,pcie-scfg", index, 2)) {
> -		pcie->scfg = NULL;
> -		return -EINVAL;
> -	}
> -	pcie->index = index[1];
> -
> -	return ls_pcie_host_init(pp);
> -}
> -
> -static const struct dw_pcie_host_ops ls1021_pcie_host_ops = {
> -	.host_init = ls1021_pcie_host_init,
> -};
> -
>  static const struct dw_pcie_host_ops ls_pcie_host_ops = {
>  	.host_init = ls_pcie_host_init,
>  };
>  
> -static const struct dw_pcie_ops dw_ls1021_pcie_ops = {
> -	.link_up = ls1021_pcie_link_up,
> -};
> -
> -static const struct dw_pcie_ops dw_ls_pcie_ops = {
> -	.link_up = ls_pcie_link_up,
> -};
> -
> -static const struct ls_pcie_drvdata ls1021_drvdata = {
> -	.ops = &ls1021_pcie_host_ops,
> -	.dw_pcie_ops = &dw_ls1021_pcie_ops,
> -};
> -
> -static const struct ls_pcie_drvdata ls1043_drvdata = {
> -	.lut_offset = 0x10000,
> -	.ltssm_shift = 24,
> -	.lut_dbg = 0x7fc,
> -	.ops = &ls_pcie_host_ops,
> -	.dw_pcie_ops = &dw_ls_pcie_ops,
> -};
> -
> -static const struct ls_pcie_drvdata ls1046_drvdata = {
> -	.lut_offset = 0x80000,
> -	.ltssm_shift = 24,
> -	.lut_dbg = 0x407fc,
> -	.ops = &ls_pcie_host_ops,
> -	.dw_pcie_ops = &dw_ls_pcie_ops,
> -};
> -
> -static const struct ls_pcie_drvdata ls2080_drvdata = {
> -	.lut_offset = 0x80000,
> -	.ltssm_shift = 0,
> -	.lut_dbg = 0x7fc,
> -	.ops = &ls_pcie_host_ops,
> -	.dw_pcie_ops = &dw_ls_pcie_ops,
> -};
> -
> -static const struct ls_pcie_drvdata ls2088_drvdata = {
> -	.lut_offset = 0x80000,
> -	.ltssm_shift = 0,
> -	.lut_dbg = 0x407fc,
> -	.ops = &ls_pcie_host_ops,
> -	.dw_pcie_ops = &dw_ls_pcie_ops,
> -};
> -
>  static const struct of_device_id ls_pcie_of_match[] = {
> -	{ .compatible = "fsl,ls1012a-pcie", .data = &ls1046_drvdata },
> -	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata },
> -	{ .compatible = "fsl,ls1028a-pcie", .data = &ls2088_drvdata },
> -	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043_drvdata },
> -	{ .compatible = "fsl,ls1046a-pcie", .data = &ls1046_drvdata },
> -	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata },
> -	{ .compatible = "fsl,ls2085a-pcie", .data = &ls2080_drvdata },
> -	{ .compatible = "fsl,ls2088a-pcie", .data = &ls2088_drvdata },
> -	{ .compatible = "fsl,ls1088a-pcie", .data = &ls2088_drvdata },
> +	{ .compatible = "fsl,ls1012a-pcie", },
> +	{ .compatible = "fsl,ls1021a-pcie", },
> +	{ .compatible = "fsl,ls1028a-pcie", },
> +	{ .compatible = "fsl,ls1043a-pcie", },
> +	{ .compatible = "fsl,ls1046a-pcie", },
> +	{ .compatible = "fsl,ls2080a-pcie", },
> +	{ .compatible = "fsl,ls2085a-pcie", },
> +	{ .compatible = "fsl,ls2088a-pcie", },
> +	{ .compatible = "fsl,ls1088a-pcie", },
>  	{ },
>  };
>  
> @@ -247,11 +122,8 @@ static int ls_pcie_probe(struct platform_device *pdev)
>  	if (!pci)
>  		return -ENOMEM;
>  
> -	pcie->drvdata = of_device_get_match_data(dev);
> -
>  	pci->dev = dev;
> -	pci->ops = pcie->drvdata->dw_pcie_ops;
> -	pci->pp.ops = pcie->drvdata->ops;
> +	pci->pp.ops = &ls_pcie_host_ops;
>  
>  	pcie->pci = pci;
>  
> @@ -260,8 +132,6 @@ static int ls_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(pci->dbi_base))
>  		return PTR_ERR(pci->dbi_base);
>  
> -	pcie->lut = pci->dbi_base + pcie->drvdata->lut_offset;
> -
>  	if (!ls_pcie_is_bridge(pcie))
>  		return -ENODEV;
>  
> -- 
> 2.17.1
> 
