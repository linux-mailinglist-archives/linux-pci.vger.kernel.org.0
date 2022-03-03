Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB60A4CBAD8
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 10:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiCCJ5X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 04:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiCCJ5W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 04:57:22 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4861795C4
        for <linux-pci@vger.kernel.org>; Thu,  3 Mar 2022 01:56:37 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id q11so4048049pln.11
        for <linux-pci@vger.kernel.org>; Thu, 03 Mar 2022 01:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8+uTGAxBMqaR2e+Zjz32fiIik0yDOurUH3U6HILNBiA=;
        b=hHhuyI8L6RiT1o3HUkMD6udSd0Yp+G2hoCl5li2KBGUIfsIzIO+RR82xQ0JK/RKTRa
         ilpWbIe0W8U7RPMRuSvilJQHb161ZHsrhGtTMViFi1j6lAeS27a8q5vkkK7iSD0G4KCI
         heKxU10KBT4aF9LPYUN2JravAG/W260JD3ToFrpo2hfdcqaUO30cReP9QbsuyCzT0WeE
         gAcGD+VUuMmqwUsjep8WksLM61gQ52bDIj27I0DO5+kHBqMmk9PmnRV3JqOleGa05CkU
         eVZFPyMkocgimTZHfHOlqLDCOZU6644enBxXBMKHfFzMhl3mjDP8k1Hw7i0/3RzC2k0v
         wijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8+uTGAxBMqaR2e+Zjz32fiIik0yDOurUH3U6HILNBiA=;
        b=HoFkmoWVuMk6Ziia61J9FlT/enf1qg7qWTnIbSfOB/RhmKm/e2c93xXw/0GfxKQeBA
         Ez3Dxet7W0x+QtLmob9f7qkgXAFwgPFKL0La8L/HG9wo/gckRATSR/0tUSeCahjCmfH/
         iprDLHCIb70N2AETMTU+z+rlJX8Jmyubcmw1FgpKDemL8NKhs4QWeCRgWXKEk0TubIz1
         LUZDRmZORBqZX8ssqH4DsaZfFP1n9iHYByUmI+pN1tF2q6H0juJlnJWQADnHmCTw9+FR
         Bc9CHFN9Zw1hTFpQVHnvHUM41J60Nh/YusBzYVYtWESKFfoSded6WRBmzEJdhwED6aIy
         m+Eg==
X-Gm-Message-State: AOAM530v7vF1af+XJVn5e8pSOIFsR4TTZ7NOPqtWBRFfUAnbdIHlG83B
        XPENY/9oKlM+oEf56ARMRcV5
X-Google-Smtp-Source: ABdhPJw8XPsOH/9J/I6RfPwgv7CXYE/5sDDROoEFhPMK+K+i2xo3kh/E5byKnycITwFjZGT/AzZW0g==
X-Received: by 2002:a17:902:d705:b0:14e:e5a2:1b34 with SMTP id w5-20020a170902d70500b0014ee5a21b34mr34621377ply.88.1646301396659;
        Thu, 03 Mar 2022 01:56:36 -0800 (PST)
Received: from workstation ([117.207.24.195])
        by smtp.gmail.com with ESMTPSA id mi9-20020a17090b4b4900b001bc8dd413fesm1706504pjb.19.2022.03.03.01.56.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Mar 2022 01:56:36 -0800 (PST)
Date:   Thu, 3 Mar 2022 15:26:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, shawnguo@kernel.org
Subject: Re: [PATCH 2/5] dmaengine: dw-edma-pcie: don't touch internal struct
 dw_edma
Message-ID: <20220303095631.GI12451@workstation>
References: <20220302032646.3793-1-Frank.Li@nxp.com>
 <20220302032646.3793-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302032646.3793-2-Frank.Li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 01, 2022 at 09:26:43PM -0600, Frank Li wrote:
> dw_edma_probe() defined at include/linux/dma/edma.h
> 
> 	@dw: struct dw_edma that is filed by dw_edma_probe()
> 
> dw_edma_pcie_probe() shouldn't access dw_edma, only filed
> struct dw_edma_chip before call dw_edma_probe()
> 
> change all dw(struct dw_edma*)  to chip(struct dw_edma_chip*)
> 

"struct dw_edma" is an internal structure of the eDMA core. This should not be
used by the eDMA controllers like "dw-edma-pcie" for passing the controller
specific information to the core.

Instead, use the fields local to the "struct dw_edma_chip" for passing the
controller specific info to the core.

Thanks,
Mani

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 83 +++++++++++++-----------------
>  1 file changed, 36 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 44f6e09bdb531..2262b1c196978 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -148,7 +148,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	struct dw_edma_pcie_data vsec_data;
>  	struct device *dev = &pdev->dev;
>  	struct dw_edma_chip *chip;
> -	struct dw_edma *dw;
>  	int err, nr_irqs;
>  	int i, mask;
>  
> @@ -214,10 +213,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	if (!chip)
>  		return -ENOMEM;
>  
> -	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
> -	if (!dw)
> -		return -ENOMEM;
> -
>  	/* IRQs allocation */
>  	nr_irqs = pci_alloc_irq_vectors(pdev, 1, vsec_data.irqs,
>  					PCI_IRQ_MSI | PCI_IRQ_MSIX);
> @@ -228,29 +223,27 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	}
>  
>  	/* Data structure initialization */
> -	chip->dw = dw;
>  	chip->dev = dev;
>  	chip->id = pdev->devfn;
> -	chip->irq = pdev->irq;
>  
> -	dw->mf = vsec_data.mf;
> -	dw->nr_irqs = nr_irqs;
> -	dw->ops = &dw_edma_pcie_core_ops;
> -	dw->wr_ch_cnt = vsec_data.wr_ch_cnt;
> -	dw->rd_ch_cnt = vsec_data.rd_ch_cnt;
> +	chip->mf = vsec_data.mf;
> +	chip->nr_irqs = nr_irqs;
> +	chip->ops = &dw_edma_pcie_core_ops;
> +	chip->wr_ch_cnt = vsec_data.wr_ch_cnt;
> +	chip->rd_ch_cnt = vsec_data.rd_ch_cnt;
>  
> -	dw->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
> -	if (!dw->rg_region.vaddr)
> +	chip->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
> +	if (!chip->rg_region.vaddr)
>  		return -ENOMEM;
>  
> -	dw->rg_region.vaddr += vsec_data.rg.off;
> -	dw->rg_region.paddr = pdev->resource[vsec_data.rg.bar].start;
> -	dw->rg_region.paddr += vsec_data.rg.off;
> -	dw->rg_region.sz = vsec_data.rg.sz;
> +	chip->rg_region.vaddr += vsec_data.rg.off;
> +	chip->rg_region.paddr = pdev->resource[vsec_data.rg.bar].start;
> +	chip->rg_region.paddr += vsec_data.rg.off;
> +	chip->rg_region.sz = vsec_data.rg.sz;
>  
> -	for (i = 0; i < dw->wr_ch_cnt; i++) {
> -		struct dw_edma_region *ll_region = &dw->ll_region_wr[i];
> -		struct dw_edma_region *dt_region = &dw->dt_region_wr[i];
> +	for (i = 0; i < chip->wr_ch_cnt; i++) {
> +		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
> +		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
>  		struct dw_edma_block *ll_block = &vsec_data.ll_wr[i];
>  		struct dw_edma_block *dt_block = &vsec_data.dt_wr[i];
>  
> @@ -273,9 +266,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		dt_region->sz = dt_block->sz;
>  	}
>  
> -	for (i = 0; i < dw->rd_ch_cnt; i++) {
> -		struct dw_edma_region *ll_region = &dw->ll_region_rd[i];
> -		struct dw_edma_region *dt_region = &dw->dt_region_rd[i];
> +	for (i = 0; i < chip->rd_ch_cnt; i++) {
> +		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
> +		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
>  		struct dw_edma_block *ll_block = &vsec_data.ll_rd[i];
>  		struct dw_edma_block *dt_block = &vsec_data.dt_rd[i];
>  
> @@ -299,45 +292,45 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	}
>  
>  	/* Debug info */
> -	if (dw->mf == EDMA_MF_EDMA_LEGACY)
> -		pci_dbg(pdev, "Version:\teDMA Port Logic (0x%x)\n", dw->mf);
> -	else if (dw->mf == EDMA_MF_EDMA_UNROLL)
> -		pci_dbg(pdev, "Version:\teDMA Unroll (0x%x)\n", dw->mf);
> -	else if (dw->mf == EDMA_MF_HDMA_COMPAT)
> -		pci_dbg(pdev, "Version:\tHDMA Compatible (0x%x)\n", dw->mf);
> +	if (chip->mf == EDMA_MF_EDMA_LEGACY)
> +		pci_dbg(pdev, "Version:\teDMA Port Logic (0x%x)\n", chip->mf);
> +	else if (chip->mf == EDMA_MF_EDMA_UNROLL)
> +		pci_dbg(pdev, "Version:\teDMA Unroll (0x%x)\n", chip->mf);
> +	else if (chip->mf == EDMA_MF_HDMA_COMPAT)
> +		pci_dbg(pdev, "Version:\tHDMA Compatible (0x%x)\n", chip->mf);
>  	else
> -		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", dw->mf);
> +		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", chip->mf);
>  
>  	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
>  		vsec_data.rg.bar, vsec_data.rg.off, vsec_data.rg.sz,
> -		dw->rg_region.vaddr, &dw->rg_region.paddr);
> +		chip->rg_region.vaddr, &chip->rg_region.paddr);
>  
>  
> -	for (i = 0; i < dw->wr_ch_cnt; i++) {
> +	for (i = 0; i < chip->wr_ch_cnt; i++) {
>  		pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
>  			i, vsec_data.ll_wr[i].bar,
> -			vsec_data.ll_wr[i].off, dw->ll_region_wr[i].sz,
> -			dw->ll_region_wr[i].vaddr, &dw->ll_region_wr[i].paddr);
> +			vsec_data.ll_wr[i].off, chip->ll_region_wr[i].sz,
> +			chip->ll_region_wr[i].vaddr, &chip->ll_region_wr[i].paddr);
>  
>  		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
>  			i, vsec_data.dt_wr[i].bar,
> -			vsec_data.dt_wr[i].off, dw->dt_region_wr[i].sz,
> -			dw->dt_region_wr[i].vaddr, &dw->dt_region_wr[i].paddr);
> +			vsec_data.dt_wr[i].off, chip->dt_region_wr[i].sz,
> +			chip->dt_region_wr[i].vaddr, &chip->dt_region_wr[i].paddr);
>  	}
>  
> -	for (i = 0; i < dw->rd_ch_cnt; i++) {
> +	for (i = 0; i < chip->rd_ch_cnt; i++) {
>  		pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
>  			i, vsec_data.ll_rd[i].bar,
> -			vsec_data.ll_rd[i].off, dw->ll_region_rd[i].sz,
> -			dw->ll_region_rd[i].vaddr, &dw->ll_region_rd[i].paddr);
> +			vsec_data.ll_rd[i].off, chip->ll_region_rd[i].sz,
> +			chip->ll_region_rd[i].vaddr, &chip->ll_region_rd[i].paddr);
>  
>  		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
>  			i, vsec_data.dt_rd[i].bar,
> -			vsec_data.dt_rd[i].off, dw->dt_region_rd[i].sz,
> -			dw->dt_region_rd[i].vaddr, &dw->dt_region_rd[i].paddr);
> +			vsec_data.dt_rd[i].off, chip->dt_region_rd[i].sz,
> +			chip->dt_region_rd[i].vaddr, &chip->dt_region_rd[i].paddr);
>  	}
>  
> -	pci_dbg(pdev, "Nr. IRQs:\t%u\n", dw->nr_irqs);
> +	pci_dbg(pdev, "Nr. IRQs:\t%u\n", chip->nr_irqs);
>  
>  	/* Validating if PCI interrupts were enabled */
>  	if (!pci_dev_msi_enabled(pdev)) {
> @@ -345,10 +338,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		return -EPERM;
>  	}
>  
> -	dw->irq = devm_kcalloc(dev, nr_irqs, sizeof(*dw->irq), GFP_KERNEL);
> -	if (!dw->irq)
> -		return -ENOMEM;
> -
>  	/* Starting eDMA driver */
>  	err = dw_edma_probe(chip);
>  	if (err) {
> -- 
> 2.24.0.rc1
> 
