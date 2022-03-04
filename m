Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59234CDFCD
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 22:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiCDVen (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Mar 2022 16:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiCDVen (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Mar 2022 16:34:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1991556C03
        for <linux-pci@vger.kernel.org>; Fri,  4 Mar 2022 13:33:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A683561E6E
        for <linux-pci@vger.kernel.org>; Fri,  4 Mar 2022 21:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CC3C340E9;
        Fri,  4 Mar 2022 21:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646429634;
        bh=sJLda56sT9G8QugWFfysgUqyxui1yJRrcBVlc+VBBBk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Rb1DdnT7tj5H7IaKB8Vc14LisUEWewlKfECLqCpdJoCeysG97egWG2Y/0fNenNj4D
         Ibx4k9AZtUjfJEFpwSwK2A8xh1SeL6Rz7r/vnspH02Vi0McyHgBbgouRpxcc+LDpmn
         40gkq0xD7x00CuMT6rb0S9298alC+Vym5yB6Wfmv3cmLd1zl9mG72e6gJHn9qDESf3
         bWn1sHPF85DZTLBp/X/0HH7F1pzZIWJD3jtkCzv4/4LnffoV/t8m57kX2TLstj45MR
         O/XB78+nnFIiq/ybMXyYNH8nwc0AORKw/9fI559egw3Gn7XPY3fkHI5snqhLg83IpZ
         Jz10E+Dy9Vojw==
Date:   Fri, 4 Mar 2022 15:33:52 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v2 4/5] PCI: imx6: add PCIe embedded DMA support
Message-ID: <20220304213352.GA1046827@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303184635.2603-4-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 03, 2022 at 12:46:34PM -0600, Frank Li wrote:
> Add support for the DMA controller in the DesignWare PCIe core
> 
> The DMA can transfer data to any remote address location
> regardless PCI address space size.
> 
> Prepare struct dw_edma_chip() and call dw_edma_probe()
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> This patch depended on some ep enable patch for imx.

This makes it really hard to apply because we don't know *which* patch
this depends on.  Patches that depend on each other should be posted
in the same series, or at the very least, include lore URL to what
they depend on.

> Change from v1 to v2
> - rework commit message
> - align dw_edma_chip change
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 51 +++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index efa8b81711090..7dc55986c947d 100644
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
> @@ -2031,6 +2034,51 @@ static const struct dw_pcie_ep_ops pcie_ep_ops = {
>  	.get_features = imx_pcie_ep_get_features,
>  };
>  
> +static int imx_dma_irq_vector(struct device *dev, unsigned int nr)
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
> +static int imx_add_pcie_dma(struct imx6_pcie *imx6_pcie)

Rename these functions to use "imx6" prefix, as the other functions in
the file do.  Mentioned this last time, too.  Also applies to
imx_add_pcie_ep() below; I guess that must be in the other
prerequisite patch?

> +{
> +	unsigned int pcie_dma_offset;
> +	struct dw_pcie *pci = imx6_pcie->pci;
> +	struct device *dev = pci->dev;
> +	struct dw_edma_chip *dma = &imx6_pcie->dma_chip;
> +	int i = 0;

No need to make a variable for this.  Just use 0 below, which will be
easier to read.

> +	int sz = PAGE_SIZE;
> +
> +	pcie_dma_offset = 0x970;

This would be better as a #define.  No point in making a local
variable on the stack.

> +	dma->dev = dev;
> +
> +	dma->reg_base = pci->dbi_base + pcie_dma_offset;
> +
> +	dma->ops = &dma_ops;
> +	dma->nr_irqs = 1;
> +
> +	dma->flags = DW_EDMA_CHIP_NO_MSI | DW_EDMA_CHIP_REG32BIT | DW_EDMA_CHIP_LOCAL_EP;
> +
> +	dma->ll_wr_cnt = dma->ll_rd_cnt=1;
> +	dma->ll_region_wr[0].sz = sz;
> +	dma->ll_region_wr[0].vaddr = dmam_alloc_coherent(dev, sz,
> +							 &dma->ll_region_wr[i].paddr,
> +							 GFP_KERNEL);
> +
> +	dma->ll_region_rd[0].sz = sz;
> +	dma->ll_region_rd[0].vaddr = dmam_alloc_coherent(dev, sz,
> +							 &dma->ll_region_rd[i].paddr,
> +							 GFP_KERNEL);

Wrap all the above to fit in 80 columns.

I would consider something like this to reduce some of the repetition:

  struct dw_edma_region *region;

  dma->ll_wr_cnt = 1;
  region = &dma->ll_region_wr[0];
  region->sz = sz;
  region->vaddr = dmam_alloc_coherent(dev, sz, &region->paddr, GFP_KERNEL);

  dma->ll_rd_cnt = 1;
  region = &dma->ll_region_rd[0];
  region->sz = sz;
  region->vaddr = dmam_alloc_coherent(dev, sz, &region->paddr, GFP_KERNEL);

> +
> +	return dw_edma_probe(dma);
> +}
> +
>  static int imx_add_pcie_ep(struct imx6_pcie *imx6_pcie,
>  					struct platform_device *pdev)
>  {
> @@ -2694,6 +2742,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		goto err_ret;
>  	}
>  
> +	if (imx_add_pcie_dma(imx6_pcie))
> +		dev_info(dev, "pci edma probe failure\n");
> +
>  	return 0;
>  
>  err_ret:
> -- 
> 2.24.0.rc1
> 
