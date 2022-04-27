Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E854511996
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 16:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbiD0OQu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 10:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237426AbiD0OQu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 10:16:50 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4332F53A7C
        for <linux-pci@vger.kernel.org>; Wed, 27 Apr 2022 07:13:35 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y14so1680930pfe.10
        for <linux-pci@vger.kernel.org>; Wed, 27 Apr 2022 07:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4SSg9xvttj6ofRIso6mDTNWRqylug+TxQegoRN2Hy+E=;
        b=Ynrnt4ag/fTrk+ZaeCVK91gLosITF9Y2Spphnsg7OwPVSutemFem4wUfO8W20f+lhq
         BegLMnSak3Ylp4XQUdTIGVwVdXfAIuiw8klflijsMOqIBnyuHQ+6ZVyFQBMe9v0qy4JX
         x3NafhSsue3PmXZz9Cx/JJy8j4tAf8anKqJ2blfUZ01hgEO46nb6E5AEXOG0KPBIIbnd
         a3aOJoKs63JHNEHYSnu9Eo0uNcWOhk6w6ykqMGQkLStQV0GOZj6mwSJ6R+GR0rrCLUHX
         ona7CdaBgXXIlGEVqcMcglwN2u4iybJUz0yAPmF7KkbMGn8PBFthelPqu8D88K1qqzVz
         mLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4SSg9xvttj6ofRIso6mDTNWRqylug+TxQegoRN2Hy+E=;
        b=zC0nDP6Cc5S3ABMiSKCRx6K5Wi0mNWck/vWw/YPEvkRg/Rb/xQgoujaov/mkNAPnTC
         QFMlfar8MCJMWRaKLDkSAfb6QWWqrQv77mg2Fb0c72wF1QuVtxSwKxms1wWmoQyf8i1o
         Y/9TZL2Ft5ARw2LMZqSRxLfdWAK8U3fI1kTLf4/0AlMS1f9q1wqahbAHQ+QvgTkj+ikj
         Ft4k+mQJExLfXLaf1PkGzXucskhr/gItAtSA0v0LMep77Kq4NJJ4jZlLIycbsRgC3yRZ
         +58VV2PQAyyR41mONQ/ay0mcOPmTN6pQhn/ZGjQlFp1aIvBS1rfQeo13foMsH7r5yjM6
         szzg==
X-Gm-Message-State: AOAM533IApIkm3YnuCJs+Kq6Acb6+2xnDRzkQLTc+kp8Sjbs5wFnISCS
        FyHyHiAP3NiIiSGT1R0FZv5J
X-Google-Smtp-Source: ABdhPJyeZaLnVABPLhwheo7Q4u0alHqWLeJL95RhQwsTcziUeecNyjDChzeEPdc5CEVZHjhp3r+f7g==
X-Received: by 2002:a63:5464:0:b0:3c1:4930:fbd5 with SMTP id e36-20020a635464000000b003c14930fbd5mr2572020pgm.94.1651068814601;
        Wed, 27 Apr 2022 07:13:34 -0700 (PDT)
Received: from thinkpad ([27.111.75.179])
        by smtp.gmail.com with ESMTPSA id bo3-20020a17090b090300b001cd4989fecesm7273661pjb.26.2022.04.27.07.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 07:13:34 -0700 (PDT)
Date:   Wed, 27 Apr 2022 19:43:29 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/5] PCI: dwc: Convert msi_irq to the array
Message-ID: <20220427141329.GA4161@thinkpad>
References: <20220427121653.3158569-1-dmitry.baryshkov@linaro.org>
 <20220427121653.3158569-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427121653.3158569-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 27, 2022 at 03:16:49PM +0300, Dmitry Baryshkov wrote:
> Qualcomm version of DWC PCIe controller supports more than 32 MSI
> interrupts, but they are routed to separate interrupts in groups of 32
> vectors. To support such configuration, change the msi_irq field into an
> array. Let the DWC core handle all interrupts that were set in this
> array.
> 

Instead of defining it as an array, can we allocate it dynamically in the
controller drivers instead? This has two benefits:

1. There is no need of using a dedicated flag.
2. Controller drivers that don't support MSIs can pass NULL and in the core we
can use platform_get_irq_byname_optional() to get supported number of MSIs from
devicetree.

Thanks,
Mani

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
>  drivers/pci/controller/dwc/pci-exynos.c       |  2 +-
>  .../pci/controller/dwc/pcie-designware-host.c | 30 +++++++++++--------
>  drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
>  drivers/pci/controller/dwc/pcie-keembay.c     |  2 +-
>  drivers/pci/controller/dwc/pcie-spear13xx.c   |  2 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c    |  2 +-
>  7 files changed, 24 insertions(+), 18 deletions(-)
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
> index 2fa86f32d964..5d90009a0f73 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -257,8 +257,11 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
>  
>  static void dw_pcie_free_msi(struct pcie_port *pp)
>  {
> -	if (pp->msi_irq)
> -		irq_set_chained_handler_and_data(pp->msi_irq, NULL, NULL);
> +	u32 ctrl;
> +
> +	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
> +		if (pp->msi_irq[ctrl])
> +			irq_set_chained_handler_and_data(pp->msi_irq[ctrl], NULL, NULL);
>  
>  	irq_domain_remove(pp->msi_domain);
>  	irq_domain_remove(pp->irq_domain);
> @@ -368,13 +371,15 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
> @@ -383,10 +388,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  			if (ret)
>  				return ret;
>  
> -			if (pp->msi_irq > 0)
> -				irq_set_chained_handler_and_data(pp->msi_irq,
> -							    dw_chained_msi_isr,
> -							    pp);
> +			for (ctrl = 0; ctrl < num_ctrls; ctrl++)
> +				if (pp->msi_irq[ctrl] > 0)
> +					irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
> +									 dw_chained_msi_isr,
> +									 pp);
>  
>  			ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
>  			if (ret)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 7d6e9b7576be..9c1a38b0a6b3 100644
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
>  	u16			msi_msg;
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
> index b1b5f836a806..e75712db85b0 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2271,7 +2271,7 @@ static void tegra194_pcie_shutdown(struct platform_device *pdev)
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
