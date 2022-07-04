Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64308565C4C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jul 2022 18:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiGDQmr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jul 2022 12:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbiGDQkq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2022 12:40:46 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D1110FF5
        for <linux-pci@vger.kernel.org>; Mon,  4 Jul 2022 09:40:03 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id k9so9386447pfg.5
        for <linux-pci@vger.kernel.org>; Mon, 04 Jul 2022 09:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LswkjGcJVBc2WWsGCRFLi7bAYfC3sQI866ihCaPTF3k=;
        b=YlwwD+7L/42rnPC8RAls9nFYeOHdTJDCGM/t/9PY9Mh3kWCL9M8oO4RmxyTIZ1ZCwa
         1g1YUjv5/CrS5GRn7ckayKUHYI8tm3b18Rqz+BL4cO/LG0qv5xyYyvB59E5yW06aGMSR
         tlsg0Dph3+1m3dH/J+c0OT9AIVmAo6yeXyI8p+LnwgD/E4O57amLhe+ZJevnjKWVzllm
         V3kNiiowiAP8HGcVUABpCCqDCKOH7wrMSP5HooKDEcrI2AfIi9mD/yQn40D9MJ34KOu9
         24hyWv734GE5+X9chL6ddbuYkJVMbY3S1NwbICZP7LizVSzVVplBHzGTTROc3k24AZwu
         OYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LswkjGcJVBc2WWsGCRFLi7bAYfC3sQI866ihCaPTF3k=;
        b=IadpyJIgg2YCTHtxmFbs6vd25NRBujxgHa9eXIrtTHz2bIyA9vR+eQ/bm+BYXGrzIU
         A2rQM3RPMmH4etwG2tIjipjQ++PksMNTlrQup1qdbWv2Iv0CXEOpYLg6erPOiIz0wmzg
         hoAuKFGi8KcKfpXV0pAAlvi5L0yHbXq6pzakldaLRn16Fj8ku9QDbvqmH1MB3aYuGFh4
         4drzGVVJ7BIgZq0oG6jR9vhZeRIbgS3q4zYrCT1LDRKQQ5KUOMPn6IM7nDLvGNglXh3J
         8YXmBoZI6FZqWJSexiJxihDeuUDexEKwjU9hGwJkJgrJpqXlqTbgJcew6uZIl5qBW09v
         TlPA==
X-Gm-Message-State: AJIora+5UgEqFPRffruOWuQ78TBJDup8PMBCbNLTMBjiLIFMR3Rb0Lgq
        BZrFqHw+Y51/NrMZpOCwU3iO
X-Google-Smtp-Source: AGRyM1vz2wq+WaLFOHRD33Vkn4RdSaTYP7NnoHPM/cktcwt39oA83YkwWFFNFRblyTG1bcaXi2HI9w==
X-Received: by 2002:a63:d315:0:b0:411:bbff:efbc with SMTP id b21-20020a63d315000000b00411bbffefbcmr18833548pgg.342.1656952803118;
        Mon, 04 Jul 2022 09:40:03 -0700 (PDT)
Received: from thinkpad ([220.158.158.244])
        by smtp.gmail.com with ESMTPSA id n24-20020a056a000d5800b00517c84fd24asm22064209pfv.172.2022.07.04.09.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 09:40:02 -0700 (PDT)
Date:   Mon, 4 Jul 2022 22:09:54 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v16 2/6] PCI: dwc: Convert msi_irq to the array
Message-ID: <20220704163954.GF6560@thinkpad>
References: <20220704152746.807550-1-dmitry.baryshkov@linaro.org>
 <20220704152746.807550-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220704152746.807550-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 04, 2022 at 06:27:42PM +0300, Dmitry Baryshkov wrote:
> Qualcomm version of DWC PCIe controller supports more than 32 MSI
> interrupts, but they are routed to separate interrupts in groups of 32
> vectors. To support such configuration, change the msi_irq field into an
> array. Let the DWC core handle all interrupts that were set in this
> array.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
>  drivers/pci/controller/dwc/pci-exynos.c       |  2 +-
>  .../pci/controller/dwc/pcie-designware-host.c | 32 ++++++++++++-------
>  drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
>  drivers/pci/controller/dwc/pcie-keembay.c     |  2 +-
>  drivers/pci/controller/dwc/pcie-spear13xx.c   |  2 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c    |  2 +-
>  7 files changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index dfcdeb432dc8..0919c96dcdbd 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -483,7 +483,7 @@ static int dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>  		return pp->irq;
>  
>  	/* MSI IRQ is muxed */
> -	pp->msi_irq = -ENODEV;
> +	pp->msi_irq[0] = -ENODEV;
>  
>  	ret = dra7xx_pcie_init_irq_domain(pp);
>  	if (ret < 0)
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index 467c8d1cd7e4..4f2010bd9cd7 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -292,7 +292,7 @@ static int exynos_add_pcie_port(struct exynos_pcie *ep,
>  	}
>  
>  	pp->ops = &exynos_pcie_host_ops;
> -	pp->msi_irq = -ENODEV;
> +	pp->msi_irq[0] = -ENODEV;
>  
>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 4418879fbf43..4c5b3f70ab17 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -257,8 +257,12 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
>  
>  static void dw_pcie_free_msi(struct pcie_port *pp)
>  {
> -	if (pp->msi_irq > 0)
> -		irq_set_chained_handler_and_data(pp->msi_irq, NULL, NULL);
> +	u32 ctrl;
> +
> +	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
> +		if (pp->msi_irq[ctrl] > 0)
> +			irq_set_chained_handler_and_data(pp->msi_irq[ctrl], NULL, NULL);
> +	}
>  
>  	irq_domain_remove(pp->msi_domain);
>  	irq_domain_remove(pp->irq_domain);
> @@ -369,13 +373,15 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  			for (ctrl = 0; ctrl < num_ctrls; ctrl++)
>  				pp->irq_mask[ctrl] = ~0;
>  
> -			if (!pp->msi_irq) {
> -				pp->msi_irq = platform_get_irq_byname_optional(pdev, "msi");
> -				if (pp->msi_irq < 0) {
> -					pp->msi_irq = platform_get_irq(pdev, 0);
> -					if (pp->msi_irq < 0)
> -						return pp->msi_irq;
> +			if (!pp->msi_irq[0]) {
> +				int irq = platform_get_irq_byname_optional(pdev, "msi");
> +
> +				if (irq < 0) {
> +					irq = platform_get_irq(pdev, 0);
> +					if (irq < 0)
> +						return irq;
>  				}
> +				pp->msi_irq[0] = irq;
>  			}
>  
>  			pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
> @@ -384,10 +390,12 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  			if (ret)
>  				return ret;
>  
> -			if (pp->msi_irq > 0)
> -				irq_set_chained_handler_and_data(pp->msi_irq,
> -							    dw_chained_msi_isr,
> -							    pp);
> +			for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> +				if (pp->msi_irq[ctrl] > 0)
> +					irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
> +									 dw_chained_msi_isr,
> +									 pp);
> +			}
>  
>  			ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
>  			if (ret)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index b5f528536358..acbb2598cc16 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -187,7 +187,7 @@ struct pcie_port {
>  	u32			io_size;
>  	int			irq;
>  	const struct dw_pcie_host_ops *ops;
> -	int			msi_irq;
> +	int			msi_irq[MAX_MSI_CTRLS];
>  	struct irq_domain	*irq_domain;
>  	struct irq_domain	*msi_domain;
>  	dma_addr_t		msi_data;
> diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
> index 1ac29a6eef22..297e6e926c00 100644
> --- a/drivers/pci/controller/dwc/pcie-keembay.c
> +++ b/drivers/pci/controller/dwc/pcie-keembay.c
> @@ -338,7 +338,7 @@ static int keembay_pcie_add_pcie_port(struct keembay_pcie *pcie,
>  	int ret;
>  
>  	pp->ops = &keembay_pcie_host_ops;
> -	pp->msi_irq = -ENODEV;
> +	pp->msi_irq[0] = -ENODEV;
>  
>  	ret = keembay_pcie_setup_msi_irq(pcie);
>  	if (ret)
> diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
> index 1569e82b5568..cc7776833810 100644
> --- a/drivers/pci/controller/dwc/pcie-spear13xx.c
> +++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
> @@ -172,7 +172,7 @@ static int spear13xx_add_pcie_port(struct spear13xx_pcie *spear13xx_pcie,
>  	}
>  
>  	pp->ops = &spear13xx_pcie_host_ops;
> -	pp->msi_irq = -ENODEV;
> +	pp->msi_irq[0] = -ENODEV;
>  
>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index d992371a36e6..35427b7b0b5e 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2263,7 +2263,7 @@ static void tegra194_pcie_shutdown(struct platform_device *pdev)
>  
>  	disable_irq(pcie->pci.pp.irq);
>  	if (IS_ENABLED(CONFIG_PCI_MSI))
> -		disable_irq(pcie->pci.pp.msi_irq);
> +		disable_irq(pcie->pci.pp.msi_irq[0]);
>  
>  	tegra194_pcie_pme_turnoff(pcie);
>  	tegra_pcie_unconfig_controller(pcie);
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
