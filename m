Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576AE60DA96
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 07:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbiJZFbH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 01:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiJZFbG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 01:31:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BF87E814;
        Tue, 25 Oct 2022 22:31:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A34ACB81CF1;
        Wed, 26 Oct 2022 05:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649DEC433D7;
        Wed, 26 Oct 2022 05:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666762260;
        bh=RdsVKGr0DKlgl6WpaDh170LCu3U34tEkshFDVWtm758=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rgNTr7masNG4Olgab5jNl69ohTUd82wAW378pvkSSfOHf16i5MTG6xu4qyCQRYREb
         Xm6CPVo3XY4jqvQJtUTf96I9td8dzIWvwot0iKm4GjRYUvq2lpswW5LFqtMADG5LMH
         UM+AEkxmhnIFio230Z4XTsp/dfEQ23EdIA/TZvYT3ZNVZH3WK/wcVJ+VPhRuqhclBs
         wYLI/eluFiGFCZOeK0MW3heFQ1stHGrJko/7TFM1jKM8REAydjMDNiBJpDABcvAm9a
         fxv4fCEmAM9IM3ituuMexB1pWO8rrLLMow53SYM+Vob93p6+y/XnOOpeTTOf/0DW0u
         nlXLjXzu8tibw==
Date:   Wed, 26 Oct 2022 11:00:46 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, Sergey.Semin@baikalelectronics.ru,
        dmitry.baryshkov@linaro.org, linmq006@gmail.com,
        ffclaire1224@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V5 2/3] PCI: qcom-ep: Refactor EP initialization
 completion
Message-ID: <20221026053046.GB5179@thinkpad>
References: <20221013175712.7539-1-vidyas@nvidia.com>
 <20221013175712.7539-3-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221013175712.7539-3-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 13, 2022 at 11:27:11PM +0530, Vidya Sagar wrote:
> Move the post initialization code to .ep_init_late() call back and call
> only dw_pcie_ep_init_notify() which internally takes care of calling
> dw_pcie_ep_init_complete().
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V5:
> * None
> 
> V4:
> * New patch in this series
> 
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 27 ++++++++++++++---------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index e33eb3871309..c418b20042aa 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -361,22 +361,12 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
>  	      PARF_INT_ALL_LINK_UP;
>  	writel_relaxed(val, pcie_ep->parf + PARF_INT_ALL_MASK);
>  
> -	ret = dw_pcie_ep_init_complete(&pcie_ep->pci.ep);
> +	ret = dw_pcie_ep_init_notify(&pcie_ep->pci.ep);
>  	if (ret) {
>  		dev_err(dev, "Failed to complete initialization: %d\n", ret);
>  		goto err_disable_resources;
>  	}
>  
> -	/*
> -	 * The physical address of the MMIO region which is exposed as the BAR
> -	 * should be written to MHI BASE registers.
> -	 */
> -	writel_relaxed(pcie_ep->mmio_res->start,
> -		       pcie_ep->parf + PARF_MHI_BASE_ADDR_LOWER);
> -	writel_relaxed(0, pcie_ep->parf + PARF_MHI_BASE_ADDR_UPPER);

Writes to the MHI base addresses are required before starting LTSSM and not
necessarily before core_init notifier. So you could just leave this code here
and get rid of .ep_init_late() callback.

And you should also rebase the series on top of v6.1-rcX as I've added few more
code in this function.

Thanks,
Mani

> -
> -	dw_pcie_ep_init_notify(&pcie_ep->pci.ep);
> -
>  	/* Enable LTSSM */
>  	val = readl_relaxed(pcie_ep->parf + PARF_LTSSM);
>  	val |= BIT(8);
> @@ -643,8 +633,23 @@ static void qcom_pcie_ep_init(struct dw_pcie_ep *ep)
>  		dw_pcie_ep_reset_bar(pci, bar);
>  }
>  
> +static void qcom_pcie_ep_init_late(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> +
> +	/*
> +	 * The physical address of the MMIO region which is exposed as the BAR
> +	 * should be written to MHI BASE registers.
> +	 */
> +	writel_relaxed(pcie_ep->mmio_res->start,
> +		       pcie_ep->parf + PARF_MHI_BASE_ADDR_LOWER);
> +	writel_relaxed(0, pcie_ep->parf + PARF_MHI_BASE_ADDR_UPPER);
> +}
> +
>  static const struct dw_pcie_ep_ops pci_ep_ops = {
>  	.ep_init = qcom_pcie_ep_init,
> +	.ep_init_late = qcom_pcie_ep_init_late,
>  	.raise_irq = qcom_pcie_ep_raise_irq,
>  	.get_features = qcom_pcie_epc_get_features,
>  };
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
