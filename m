Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85274E67F5
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 18:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352334AbiCXRnN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 13:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239035AbiCXRnM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 13:43:12 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2F0B2444
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 10:41:40 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p8so4519711pfh.8
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 10:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dZ1u1Ug2jTMoLajJKgKdgwxi2OU0FG22PDfBsq85ol0=;
        b=KBI1Vr3z/V2JK/heCNXmXFF9DZ5RjZirNQPJMWZZniiaB3f3eAkC4yCk0VcPUJnqUo
         8xk5LIfABdUKpnTCEiNVE58SETv6i3BGqec9w8bWXgVZv6u2HFhBO5HzaUDDQ752rjt+
         ls1yUT+FciwCWEF9Fb7SfABjXt53ChjaxosXJtdejWbKId/jXhM4mldx1UTKb3ij5w5E
         874AToUWjPRBKAP3dJQ6/kiW54PuPYbEpHgNu2G541JtQYnfDUIA5xVlA9kRfTb/gek9
         hTBP2TxTe1Q0oRuG8AURDA2v6JqvGqkH5wLYoG0WLv8LqJiFD24jyXhFoTQ/pIXqqL5C
         EYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dZ1u1Ug2jTMoLajJKgKdgwxi2OU0FG22PDfBsq85ol0=;
        b=nGpq6ywpcjq+fylhWjsmIFyBMG7m1KHJ8SSdAfDXc3Zjy5QM/2oHXlpw5gUI4V710r
         y8Pahv9QW4PBn7p++HdGxoH8Vgb+No4lOs6sQicLPLN2mTuBsunsg6zJrk8lSiQmxQ9H
         QS3Uh4zZEyUSpXDo71EKRXNNEH48+df1RUOPE9DnL0yFbMVbpDeDFtKuOe5wHKRLctaL
         jiBlSIg8Tiuu8qdoP3YQfnnLSw4XP+Nn9X0WL+ziVC+XYWUZQtlWwvQ7IiMmwbTz72Bz
         LPtHY4j3UqN6TZiPi20yMR5XTBvTZsEr1Hf0DyHbpE9+IgJjcr7r/bVXdIUIwRW+wdSP
         gHzQ==
X-Gm-Message-State: AOAM530wnKzQFpL6ebTy62kuGr9a08PKFSvGPKNQzUjuhz7xor3peSkd
        lowMVjrPzhmAd/14BdxB572+
X-Google-Smtp-Source: ABdhPJzGHUWdPrP3WcR1fluY7c1jSSIbJNvoNafacszk1Kt+//P+z7493Hs0TPdrepU3A8+TWyx5Ng==
X-Received: by 2002:a65:61ad:0:b0:378:8f01:7674 with SMTP id i13-20020a6561ad000000b003788f017674mr4694544pgv.314.1648143699920;
        Thu, 24 Mar 2022 10:41:39 -0700 (PDT)
Received: from thinkpad ([27.111.75.218])
        by smtp.gmail.com with ESMTPSA id 73-20020a62194c000000b004fab3b767ccsm4436980pfz.216.2022.03.24.10.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 10:41:39 -0700 (PDT)
Date:   Thu, 24 Mar 2022 23:11:32 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/25] dmaengine: dw-edma: Add PCIe bus address getter to
 the remote EP glue-driver
Message-ID: <20220324174132.GS2854@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-11-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324014836.19149-11-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 24, 2022 at 04:48:21AM +0300, Serge Semin wrote:
> In general the Synopsys PCIe EndPoint IP prototype kit can be attached to
> a PCIe bus with any PCIe Host controller including to the one with
> distinctive from CPU address space. Due to that we need to make sure that
> the source and destination addresses of the DMA-slave devices are properly
> converted to the PCIe bus address space, otherwise the DMA transaction
> will not only work as expected, but may cause the memory corruption with
> subsequent system crash. Let's do that by introducing a new
> dw_edma_pcie_address() method defined in the dw-edma-pcie.c, which will
> perform the denoted translation by using the pcibios_resource_to_bus()
> method.
> 
> Fixes: 41aaff2a2ac0 ("dmaengine: Add Synopsys eDMA IP PCIe glue-logic")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> 
> Note this patch depends on the patch "dmaengine: dw-edma: Add CPU to PCIe
> bus address translation" from this series.
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 04c95cba1244..f530bacfd716 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -95,8 +95,23 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
>  	return pci_irq_vector(to_pci_dev(dev), nr);
>  }
>  
> +static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pci_bus_region region;
> +	struct resource res = {
> +		.flags = IORESOURCE_MEM,
> +		.start = cpu_addr,
> +		.end = cpu_addr,
> +	};
> +
> +	pcibios_resource_to_bus(pdev->bus, &region, &res);
> +	return region.start;
> +}
> +
>  static const struct dw_edma_core_ops dw_edma_pcie_core_ops = {
>  	.irq_vector = dw_edma_pcie_irq_vector,
> +	.pci_address = dw_edma_pcie_address,
>  };
>  
>  static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> -- 
> 2.35.1
> 
