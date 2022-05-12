Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AED52552F
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 20:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357811AbiELSyt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 14:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245570AbiELSys (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 14:54:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0832725D7;
        Thu, 12 May 2022 11:54:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05FB761A78;
        Thu, 12 May 2022 18:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E4BC34100;
        Thu, 12 May 2022 18:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652381686;
        bh=PSHeA+PB/B8QynKP9h0yo/H4Z29a34iXwki0d0pqb5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QBCA5bfxVYqi9as6PeG0tsU0kO+mqz1c1uJlcWG8WachpCjsiN9Wv7+FD0MEAVlDP
         /7VTiGVXiGOofiYRWZmvHGoPt/od2S6Pb5R9n0MbM6RRGZvZhaYH67XABVAgjUgSoq
         XJonbcBKGw3LJF7erbROYHebgbVrccAo98CFh8/7idbWA9R1j7CI/qIERjPlXZ12GQ
         N6dQSD7JFFH6Yl44GVsK93TNWehhIoyxOXHBwKx3aAuZAAVOC/PFHLIPsL6hp5mIWj
         DP/m3BV+SmlUCoK86rxOXPOh2G3Tc0yYuiEy90yiwzOvk4MwYLFxhwl9aqGkJyzIXA
         GLGAOKTweK5qA==
Date:   Thu, 12 May 2022 13:54:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
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
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 05/10] PCI: dwc: split MSI IRQ parsing/allocation to a
 separate function
Message-ID: <20220512185443.GA860607@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512104545.2204523-6-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Only if you have other occasion to repost, in subject:

  PCI: dwc: Split

On Thu, May 12, 2022 at 01:45:40PM +0300, Dmitry Baryshkov wrote:
> Split handling of MSI host IRQs to a separate dw_pcie_msi_host_init()
> function. The code is complex enough to warrant a separte function.

s/separte/separate/

It looks like this is simply a split, with no expected functional
impact.  The above is sufficient; the sentence below is not really
necessary.

> Adding another bit to support multiple host MSI IRQs would make it
> overcomplicated.

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 97 +++++++++++--------
>  1 file changed, 55 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 5f6590929319..6b0c7b75391f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -288,6 +288,59 @@ static void dw_pcie_msi_init(struct pcie_port *pp)
>  	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
>  }
>  
> +static int dw_pcie_msi_host_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct platform_device *pdev = to_platform_device(pci->dev);
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
> +	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
> +		if (pp->msi_irq[ctrl] > 0)
> +			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
> +							 dw_chained_msi_isr,
> +							 pp);
> +
> +	ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		dev_warn(pci->dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> +
> +	pp->msi_data = dma_map_single_attrs(pci->dev, &pp->msi_msg,
> +				      sizeof(pp->msi_msg),
> +				      DMA_FROM_DEVICE,
> +				      DMA_ATTR_SKIP_CPU_SYNC);
> +	ret = dma_mapping_error(pci->dev, pp->msi_data);
> +	if (ret) {
> +		dev_err(pci->dev, "Failed to map MSI data: %d\n", ret);
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
> @@ -365,49 +418,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
> -			for (ctrl = 0; ctrl < num_ctrls; ctrl++)
> -				if (pp->msi_irq[ctrl] > 0)
> -					irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
> -									 dw_chained_msi_isr,
> -									 pp);
> -
> -			ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
> -			if (ret)
> -				dev_warn(pci->dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> -
> -			pp->msi_data = dma_map_single_attrs(pci->dev, &pp->msi_msg,
> -						      sizeof(pp->msi_msg),
> -						      DMA_FROM_DEVICE,
> -						      DMA_ATTR_SKIP_CPU_SYNC);
> -			ret = dma_mapping_error(pci->dev, pp->msi_data);
> -			if (ret) {
> -				dev_err(pci->dev, "Failed to map MSI data: %d\n", ret);
> -				pp->msi_data = 0;
> -				goto err_free_msi;
> -			}
>  		}
>  	}
>  
> -- 
> 2.35.1
> 
