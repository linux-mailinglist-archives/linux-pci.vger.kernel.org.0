Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1306A4D2E9F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Mar 2022 13:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiCIMC7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Mar 2022 07:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiCIMC6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2022 07:02:58 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC45156C71
        for <linux-pci@vger.kernel.org>; Wed,  9 Mar 2022 04:02:00 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id mg21-20020a17090b371500b001bef9e4657cso5088783pjb.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Mar 2022 04:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K6zryj3TkJV3Z7TGK5B5OEkA95sLoP7KQOJ8Zj5mn34=;
        b=GzbAQMShA6ryCcXCDwWvnRy+qrq+iH0tC5m9EPJhK2ZnTEkHTlVX6MM+EgrmHwIp4w
         LD+/755dlgkQnxyhrH86bhPLE5LJWSnVREteeJ/+e4ik0bqpbbe1Xwc4+6PeTbLELszy
         /J207Opae6i0leHK9oVBHYxRXOGQYPsfxbEqV0JM/xUagnjEBc2QxUvpOeYinN+NBUQj
         ZuVbeok5EFmorIwdjAO15GUsK95qBOSbEmL4Cdw+YsrH652w/V6CHQSI3j3q/MUTnC9L
         4oO0luYMH0ltcw7KTUta2u8OdswxJZ0oQSROZ0rMg/eSsipUkvexrKOm6aoCH9eZTjPE
         RaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K6zryj3TkJV3Z7TGK5B5OEkA95sLoP7KQOJ8Zj5mn34=;
        b=A2poZ3CmijaHRVszm8FH2m0lNxWfYFIIuuPO3EEOnxDzPx9yzou4ce96iGURn6EqTo
         Of/W5HFTIpIDYnMfdrfh1N6Dx/PkxNWGh2XLoC8iNMwBPZVNRwiYnAuHI72QUi01qZQ1
         azCxZCAPOjjg6JZFilfXPJZb7ej4WCaFJpo8Dndn/pVHW1hF7KX6qbu0NJTyn3PrcwQ1
         JmeJcbj7kHAOMGkYVeANvTd6dcHDEQReO1RlTtcwGISrBLz0ZedAYfBP8p1yKiviqqTI
         MvwWoPwQtAzWF2Jf4HccnVogAE/eYWI9gF4UHbvdHDS8ovhGj8stJzDQhpowVVEFGVf9
         5e9Q==
X-Gm-Message-State: AOAM530bDKr9etHpR1oe/fMeWzWBTBKgaLuG2P1HUZ6AC0Vs5wdwrXo9
        ptCzdMs/p6P8+xmuQ9qS0b4g
X-Google-Smtp-Source: ABdhPJwX2T6fz75njRMo85cCchm/G7rH3N972IxnfLZFg1qDYIS2x1uzSvX8TLCWWacNg/vIiHZdkw==
X-Received: by 2002:a17:902:d4c2:b0:151:d590:a13d with SMTP id o2-20020a170902d4c200b00151d590a13dmr20244154plg.85.1646827319718;
        Wed, 09 Mar 2022 04:01:59 -0800 (PST)
Received: from thinkpad ([117.193.208.22])
        by smtp.gmail.com with ESMTPSA id u15-20020a056a00124f00b004f12b8c81ccsm2834343pfi.75.2022.03.09.04.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 04:01:59 -0800 (PST)
Date:   Wed, 9 Mar 2022 17:31:49 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, shawnguo@kernel.org
Subject: Re: [PATCH v2 4/5] PCI: imx6: add PCIe embedded DMA support
Message-ID: <20220309120149.GB134091@thinkpad>
References: <20220303184635.2603-1-Frank.Li@nxp.com>
 <20220303184635.2603-4-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303184635.2603-4-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
> 
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
> +{
> +	unsigned int pcie_dma_offset;
> +	struct dw_pcie *pci = imx6_pcie->pci;
> +	struct device *dev = pci->dev;
> +	struct dw_edma_chip *dma = &imx6_pcie->dma_chip;
> +	int i = 0;

Unused?

> +	int sz = PAGE_SIZE;
> +
> +	pcie_dma_offset = 0x970;

Can you get this offset from the devicetree node of ep?

> +
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

Is this a hard limitation of the eDMA implementation or because of difficulties
in requesting the correct channel from client driver?

If it's the latter, you could use my patch:

https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/commit/?h=tracking-qcomlt-sdx55-drivers&id=c77ad9d929372b1ff495709714b24486d266a810

> +	dma->ll_region_wr[0].sz = sz;
> +	dma->ll_region_wr[0].vaddr = dmam_alloc_coherent(dev, sz,
> +							 &dma->ll_region_wr[i].paddr,
> +							 GFP_KERNEL);

Allocation could fail. Please add error checking here and below.

Thanks,
Mani

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
