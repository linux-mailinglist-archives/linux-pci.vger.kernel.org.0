Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAC155D637
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245450AbiF1GjC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 02:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiF1GjB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 02:39:01 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D960E6337
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 23:39:00 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id a15so11103824pfv.13
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 23:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yrYr6jJXfjch3Pb9mH5mAmFf6UnZOa1Y6mUEsgtjN1I=;
        b=zOtjBQIFbHNzZaCzDVoNYoe9Wfv6jCeGGHzKwXyeZh+RJtCNNQvVavwh1fLxhtSUHf
         IBeHSIfBBkFcNl1UHe4IpLl6kEo18mFK2UaoAbAafCDqlvFh7l8evGavQoH9QOiq/y3g
         Sc2r5NN54zh1QG5UPbOCxoZi2ml0t64kYQNZvfS0a67JnEgEFKHAYLuvfSHIi+9iDUK8
         y9y6mtBBDDAZAmenr29ZmJxxh+u6GzCsa03PVCoc8bzi5BH4+biPz6Y+X1Xrs2bkiJCB
         N9Yz1+mEdZYUJ690aNp5aLMEGiwYp4pMp+pXFY+gi/YDX8iiH6JM+O/j9CGykNyu7Wkh
         3qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yrYr6jJXfjch3Pb9mH5mAmFf6UnZOa1Y6mUEsgtjN1I=;
        b=k/Wj3mqE7Ok4yXP8ANbFkzuz+Ma5Y0mGFSFY+eq+Pk8G8X6g3MIthi7WpZt7/ES+oX
         UFxGyh4Xd10wr2pG63gvJnIJZLfv7u0RNFWjQYx+9E1BHI0CExL4UbDp3mpiFu0fRkS1
         kq8q8qXgbolwmyFvBJKFRIYVyHuo6wYx9nRPPLdOEciJ89++oCgooIeDXZIDatWTH+Yg
         DO0CL1TtkrN9nQtKHNjVT/nFefsYdhArfkvwLUjirZVsSYHXwgr8d9yW2yhULP78ENhK
         FR022pHQqhxf09WtNwYVG6yitCfVtTnjXd5ovZQjERIG2PmSpRWhvXLzobtgDOukiE5n
         F9Xw==
X-Gm-Message-State: AJIora+yCakVTBLT48YUPYP+UdLgB1eCLLbvMe6DsE7snBGNVLRBj+Ad
        9R6smuN2PUWtpTzK+kKpef0J
X-Google-Smtp-Source: AGRyM1txLt89GVm1bDOnHO4ERkirif3tx7UqtWVuWl3162z6fqwHXW3GQwgPjtxt2HJoNHaOj5Csqw==
X-Received: by 2002:a63:1a10:0:b0:40d:fb07:ec26 with SMTP id a16-20020a631a10000000b0040dfb07ec26mr8226055pga.273.1656398340190;
        Mon, 27 Jun 2022 23:39:00 -0700 (PDT)
Received: from thinkpad ([27.111.75.159])
        by smtp.gmail.com with ESMTPSA id d9-20020a655889000000b0040c97f0057dsm8261911pgu.17.2022.06.27.23.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 23:38:59 -0700 (PDT)
Date:   Tue, 28 Jun 2022 12:08:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 11/18] PCI: dwc: Organize local variables usage
Message-ID: <20220628063855.GD23601@thinkpad>
References: <20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru>
 <20220624143428.8334-12-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624143428.8334-12-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:34:21PM +0300, Serge Semin wrote:
> There are several places in the common DW PCIe code with incoherent local
> variables usage: a variable is defined and initialized with a structure
> field, but the structure pointer is de-referenced to access that field
> anyway; the local variable is defined and initialized but either used just
> once or not used afterwards in the main part of the subsequent method.
> It's mainly concerns the pcie_port.dev field. Let's fix that in the
> relevant places.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Changelog v4:
> - This is a new patch created on the v4 lap of the series.
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++------
>  drivers/pci/controller/dwc/pcie-designware.c      |  8 +++-----
>  2 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 9a4922b714e5..54257874c154 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -296,7 +296,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	struct resource *cfg_res;
>  	int ret;
>  
> -	raw_spin_lock_init(&pci->pp.lock);
> +	raw_spin_lock_init(&pp->lock);
>  
>  	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
>  	if (cfg_res) {
> @@ -388,15 +388,15 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  							    dw_chained_msi_isr,
>  							    pp);
>  
> -			ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
> +			ret = dma_set_mask(dev, DMA_BIT_MASK(32));
>  			if (ret)
> -				dev_warn(pci->dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> +				dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
>  
> -			pp->msi_data = dma_map_single_attrs(pci->dev, &pp->msi_msg,
> +			pp->msi_data = dma_map_single_attrs(dev, &pp->msi_msg,
>  						      sizeof(pp->msi_msg),
>  						      DMA_FROM_DEVICE,
>  						      DMA_ATTR_SKIP_CPU_SYNC);
> -			ret = dma_mapping_error(pci->dev, pp->msi_data);
> +			ret = dma_mapping_error(dev, pp->msi_data);
>  			if (ret) {
>  				dev_err(pci->dev, "Failed to map MSI data\n");
>  				pp->msi_data = 0;
> @@ -633,7 +633,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  		}
>  
>  		if (pci->num_ob_windows <= atu_idx)
> -			dev_warn(pci->dev, "Resources exceed number of ATU entries (%d)\n",
> +			dev_warn(dev, "Resources exceed number of ATU entries (%d)\n",
>  				 pci->num_ob_windows);
>  	}
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index f9613835212b..ce01187947c9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -677,8 +677,7 @@ static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
>  
>  void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  {
> -	struct device *dev = pci->dev;
> -	struct platform_device *pdev = to_platform_device(dev);
> +	struct platform_device *pdev = to_platform_device(pci->dev);
>  
>  	pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
>  	if (pci->iatu_unroll_enabled) {
> @@ -687,7 +686,7 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  				platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
>  			if (res) {
>  				pci->atu_size = resource_size(res);
> -				pci->atu_base = devm_ioremap_resource(dev, res);
> +				pci->atu_base = devm_ioremap_resource(pci->dev, res);
>  			}
>  			if (!pci->atu_base || IS_ERR(pci->atu_base))
>  				pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
> @@ -711,9 +710,8 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  
>  void dw_pcie_setup(struct dw_pcie *pci)
>  {
> +	struct device_node *np = pci->dev->of_node;
>  	u32 val;
> -	struct device *dev = pci->dev;
> -	struct device_node *np = dev->of_node;
>  
>  	if (pci->link_gen > 0)
>  		dw_pcie_link_set_max_speed(pci, pci->link_gen);
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
