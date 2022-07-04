Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77A6565C52
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jul 2022 18:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbiGDQna (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jul 2022 12:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiGDQl3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2022 12:41:29 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CA75F60
        for <linux-pci@vger.kernel.org>; Mon,  4 Jul 2022 09:41:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso2578236pjh.1
        for <linux-pci@vger.kernel.org>; Mon, 04 Jul 2022 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+YkKDGGYRCRKmuH8zH7bPuQVwdi1tT1POxCvznjFXbQ=;
        b=K9GRO1eZzURJfs5Kyu8liO984oQdLyPCQTvVOyX0A0gEpfiZZ7Noa0ZHFWXy9mYMEe
         nMy+lIMCaUrZo1xb3e1FiyfFPV8HJymZlsKJJvI+RtbRQaobmnR4xU5QxK1zT0ag8L6S
         jrdPrzOZicLB3IfNkyvmk5G4zAmq57l9/FWllujWFrDum7psymf+/WXUVc1Ftb/1C1qc
         0otdvX3H4HV0RnyLMGCJThc9H0nuVPR7EV9epPKNmV3VNgEHqPws64lhtzXRzjAN+XUX
         xHf6hUu5zVLVUZU5mVcrDSSh6mFKNTldBTljGWEVkdz7zQ0UCkyNT15svK3QoWYK+KPl
         6Q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+YkKDGGYRCRKmuH8zH7bPuQVwdi1tT1POxCvznjFXbQ=;
        b=8MtRh5x0ByxLUeTDBNU9WA/P8YlB5p2iYlA97HtiHv5g5iv32MQUUfmLpxRa+9ohgz
         zEodp/1je1fGJMApIv+KLCpkfLV+Rb1b2AV1lP1bdfeg69i8gsWrYcU/fekBS+RXbAfy
         kh8GcyK11CL1VM4B1v2SFF+YMzlE8DbcZYa/Hdrf9u/fCoRKypfMiAywYTh6mvjfUg9F
         bMseRPI5SLF6uHhGX1Cc3UeMeDOYJj++98sQLWfhSxxY+FtTEDltjk3A6MSg9gAUjWwL
         ksNvvO/eOhu+EJZRHpt/SL8GqNU6+JNsTYygNuK+ey8HP8zoYTAqpkEXO8eq7tDgrOwe
         /qOw==
X-Gm-Message-State: AJIora/7lGhA199fC8YwMJNvNB+GQ8LaJOFz8ZKgjM72ZWAkTcjtHie6
        8zL2HyE+EBZCFOAq4pOAw3d+
X-Google-Smtp-Source: AGRyM1snQ4ZZ4E7Ljls2rwPB1bbFAr2FMNQ5a94dHrKl3DdS/fanWGoZXGqVqp/jv7Heor+Gr6emhA==
X-Received: by 2002:a17:903:18f:b0:16a:5c43:9a85 with SMTP id z15-20020a170903018f00b0016a5c439a85mr37126100plg.122.1656952887207;
        Mon, 04 Jul 2022 09:41:27 -0700 (PDT)
Received: from thinkpad ([220.158.158.244])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e80900b0016a163d1cd5sm21686142plg.253.2022.07.04.09.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 09:41:25 -0700 (PDT)
Date:   Mon, 4 Jul 2022 22:11:18 +0530
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
Subject: Re: [PATCH v16 3/6] PCI: dwc: split MSI IRQ parsing/allocation to a
 separate function
Message-ID: <20220704164118.GG6560@thinkpad>
References: <20220704152746.807550-1-dmitry.baryshkov@linaro.org>
 <20220704152746.807550-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220704152746.807550-4-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 04, 2022 at 06:27:43PM +0300, Dmitry Baryshkov wrote:
> Split handling of MSI host IRQs to a separate dw_pcie_msi_host_init()
> function. The code is complex enough to warrant a separate function.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 101 ++++++++++--------
>  1 file changed, 57 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 4c5b3f70ab17..3ba531da99d4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -290,6 +290,61 @@ static void dw_pcie_msi_init(struct pcie_port *pp)
>  	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
>  }
>  
> +static int dw_pcie_msi_host_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct device *dev = pci->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int ret;
> +	u32 ctrl, num_ctrls;
> +
> +	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> +	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
> +		pp->irq_mask[ctrl] = ~0;
> +
> +	if (!pp->msi_irq[0]) {
> +		int irq = platform_get_irq_byname_optional(pdev, "msi");
> +
> +		if (irq < 0) {
> +			irq = platform_get_irq(pdev, 0);
> +			if (irq < 0)
> +				return irq;
> +		}
> +		pp->msi_irq[0] = irq;
> +	}
> +
> +	pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
> +
> +	ret = dw_pcie_allocate_domains(pp);
> +	if (ret)
> +		return ret;
> +
> +	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> +		if (pp->msi_irq[ctrl] > 0)
> +			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
> +							 dw_chained_msi_isr,
> +							 pp);
> +	}
> +
> +	ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		dev_warn(pci->dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> +
> +	pp->msi_page = alloc_page(GFP_DMA32);
> +	pp->msi_data = dma_map_page(pci->dev, pp->msi_page, 0,
> +						    PAGE_SIZE, DMA_FROM_DEVICE);
> +	ret = dma_mapping_error(pci->dev, pp->msi_data);
> +	if (ret) {
> +		dev_err(pci->dev, "Failed to map MSI data\n");
> +		pp->msi_page = NULL;
> +		pp->msi_data = 0;
> +		dw_pcie_free_msi(pp);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  int dw_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -367,51 +422,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  			if (ret < 0)
>  				return ret;
>  		} else if (pp->has_msi_ctrl) {
> -			u32 ctrl, num_ctrls;
> -
> -			num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> -			for (ctrl = 0; ctrl < num_ctrls; ctrl++)
> -				pp->irq_mask[ctrl] = ~0;
> -
> -			if (!pp->msi_irq[0]) {
> -				int irq = platform_get_irq_byname_optional(pdev, "msi");
> -
> -				if (irq < 0) {
> -					irq = platform_get_irq(pdev, 0);
> -					if (irq < 0)
> -						return irq;
> -				}
> -				pp->msi_irq[0] = irq;
> -			}
> -
> -			pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
> -
> -			ret = dw_pcie_allocate_domains(pp);
> -			if (ret)
> +			ret = dw_pcie_msi_host_init(pp);
> +			if (ret < 0)
>  				return ret;
> -
> -			for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> -				if (pp->msi_irq[ctrl] > 0)
> -					irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
> -									 dw_chained_msi_isr,
> -									 pp);
> -			}
> -
> -			ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
> -			if (ret)
> -				dev_warn(pci->dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> -
> -			pp->msi_page = alloc_page(GFP_DMA32);
> -			pp->msi_data = dma_map_page(pci->dev, pp->msi_page, 0,
> -						    PAGE_SIZE, DMA_FROM_DEVICE);
> -			ret = dma_mapping_error(pci->dev, pp->msi_data);
> -			if (ret) {
> -				dev_err(pci->dev, "Failed to map MSI data\n");
> -				__free_page(pp->msi_page);
> -				pp->msi_page = NULL;
> -				pp->msi_data = 0;
> -				goto err_free_msi;
> -			}
>  		}
>  	}
>  
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
