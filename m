Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EC24CAF78
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 21:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240183AbiCBUQJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 15:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiCBUQI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 15:16:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAFCCD5EB
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 12:15:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 583F1616C8
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 20:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86599C004E1;
        Wed,  2 Mar 2022 20:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646252123;
        bh=3j1kH3qtJP1nGuImmN3YxURNYPXbfeCWonsaPABo+Ok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lA3rv4Ij+CtyxbT06sLFJd0DdxRduuZWC5VErRcgnx/aDl6DFXDf/9rhWSOP2/T1s
         BaUi3a7KAnQdCI0lwDgdJUPgawVyClLdvFBgS1VBByBE85LiRE4MhQJna+iGNTtpZo
         8CN6jisMQOw0kVFpbrPfbFkuIx04sgBDnzkhyWr/GhefcQZBeAmo7urt3fHXolLl3x
         CH9K9vr190xeuJhqySngw7C52F3yDDnRPfv/iUQYu9xIU/eUfB/P31VLhTxsjrR0PR
         h3/60UQhVssp5fzPkp4cEVR1UKv2s8J0r0SmBSH6TSkxVA2TUgcopntoOn2w9YqKQJ
         zAuX+jmE96mew==
Date:   Wed, 2 Mar 2022 14:15:20 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, shawnguo@kernel.org,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH 4/5] PCI: imx6: add PCIe embedded DMA support
Message-ID: <20220302201520.GA746237@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302032646.3793-4-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jingoo for DesignWare generic question]

In subject:

  PCI: imx6: Add embedded DMA support

to match existing style.  "PCIe" seems superfluous here since we
already mentioned it earlier in the subject.

On Tue, Mar 01, 2022 at 09:26:45PM -0600, Frank Li wrote:
> Designware PCIe control have embedded DMA controller.
> This enable the DMA controller support.

Maybe:

  Add support for the DMA controller in the DesignWare PCIe core.

If this DMA controller is in the DesignWare core, is everything in
this patch specific to imx6?  Or could some of it be shared with other
dwc-based drivers?

> The DMA can transfer data to any remote address location
> regardless PCI address space size.

What is this sentence telling us?  Is it merely that the DMA "inbound
address space" may be larger than the MMIO "outbound address space"?
I think there's no necessary connection between them, and there's no
need to call it out as though it's something special.

> Prepare struct dw_edma_chip and call dw_edma_probe

"dw_edma_probe()" so it's obvious this is a function.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 61 +++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index efa8b81711090..a588b848a1650 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -38,6 +38,7 @@
>  #include "../../pci.h"
>  
>  #include "pcie-designware.h"
> +#include "linux/dma/edma.h"
>  
>  #define IMX8MQ_PCIE_LINK_CAP_REG_OFFSET		0x7c
>  #define IMX8MQ_PCIE_LINK_CAP_L1EL_64US		GENMASK(18, 17)
> @@ -164,6 +165,8 @@ struct imx6_pcie {
>  	const struct imx6_pcie_drvdata *drvdata;
>  	struct regulator	*epdev_on;
>  	struct phy		*phy;
> +
> +	struct dw_edma_chip	dma_chip;
>  };
>  
>  /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
> @@ -2031,6 +2034,61 @@ static const struct dw_pcie_ep_ops pcie_ep_ops = {
>  	.get_features = imx_pcie_ep_get_features,
>  };
>  
> +static int imx_dma_irq_vector(struct device *dev, unsigned int nr)

Function names should match existing style in this driver, i.e., they
should start with "imx6", not "imx".

> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +
> +	return platform_get_irq_byname(pdev, "dma");
> +}
> +
> +static struct dw_edma_core_ops dma_ops = {
> +	.irq_vector = imx_dma_irq_vector,
> +};
> +
> +static int imx_add_pcie_dma(struct imx6_pcie *imx6_pcie,
> +			    struct platform_device *pdev,

You don't use "pdev" in this function, so no need to pass it in.

> +			    struct resource *dbi_base)

IIUC this is already in pci->dbi_base, so why not use that instead of
passing it in?  Passing both a struct and the contents of a member of
the struct is an opportunity for a mistake.

> +{
> +	unsigned int pcie_dma_offset;
> +	struct dw_pcie *pci = imx6_pcie->pci;
> +	struct device *dev = pci->dev;
> +	struct dw_edma_chip *dma = &imx6_pcie->dma_chip;
> +	int i = 0;
> +	u64 pbase;
> +	void *vbase;
> +	int sz = PAGE_SIZE;
> +
> +	pcie_dma_offset = 0x970;
> +
> +	pbase = dbi_base->start + pcie_dma_offset;
> +	vbase = pci->dbi_base + pcie_dma_offset;
> +
> +	dma->dev = dev;
> +
> +	dma->rg_region.paddr = pbase;
> +	dma->rg_region.vaddr = vbase;
> +	dma->rg_region.sz = 0x424;
> +
> +	dma->wr_ch_cnt = dma->rd_ch_cnt = 1;
> +
> +	dma->ops = &dma_ops;
> +	dma->nr_irqs = 1;
> +
> +	dma->flags = DW_EDMA_CHIP_NO_MSI | DW_EDMA_CHIP_REG32BIT | DW_EDMA_CHIP_LOCAL_EP;
> +
> +	dma->ll_region_wr[0].sz = sz;
> +	dma->ll_region_wr[0].vaddr = dmam_alloc_coherent(dev, sz,
> +							 &dma->ll_region_wr[i].paddr,
> +							 GFP_KERNEL);
> +
> +	dma->ll_region_rd[0].sz = sz;
> +	dma->ll_region_rd[0].vaddr = dmam_alloc_coherent(dev, sz,
> +							 &dma->ll_region_rd[i].paddr,
> +							 GFP_KERNEL);
> +
> +	return dw_edma_probe(dma);
> +}
> +
>  static int imx_add_pcie_ep(struct imx6_pcie *imx6_pcie,
>  					struct platform_device *pdev)
>  {
> @@ -2694,6 +2752,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		goto err_ret;
>  	}
>  
> +	if (imx_add_pcie_dma(imx6_pcie, pdev, dbi_base))
> +		dev_info(dev, "pci edma probe failure\n");
> +
>  	return 0;
>  
>  err_ret:
> -- 
> 2.24.0.rc1
> 
