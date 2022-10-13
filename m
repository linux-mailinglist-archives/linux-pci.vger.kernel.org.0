Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530B75FDC01
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 16:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJMOGh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 10:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiJMOGf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 10:06:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCF7107CE6
        for <linux-pci@vger.kernel.org>; Thu, 13 Oct 2022 07:06:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99959B81E60
        for <linux-pci@vger.kernel.org>; Thu, 13 Oct 2022 14:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011C1C433D6;
        Thu, 13 Oct 2022 14:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665669892;
        bh=9PYpYkdxdeYP9ZMQ9IALmGecY9rvjMIMkVX1EfnhvD4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SXNLO0pQxNTtMW1KrUNwd8f5ABQ+KbrRqqFLsFy0Be9NvgwmsuxvpL3ply5bztQP9
         3Sm7JuLOIhHvsvZ0VFSB1Nza3Z6qcJeVQJN0K0N3X93R9+VhngIUSEFI9JuhRFpTSw
         uLeHXBEr66ZKIeLgLfopFO1DXNepLBPl1OI8ra9Z+7msXlEteE+38+9E5yGad7KfX9
         4yxfIOSTiHhWAewsOb32xRuZ3Xqh9npe4nvgh2XFTzt68Ezmg1tUmzgjfhGGyN8ity
         gWwKKRox2S6CTAIhHexUcHBLsrHBY1L0aUa02UH6JWVmNEBHWEg6TAisRnWhEXToxj
         dAhRNtdCk9hEA==
Date:   Thu, 13 Oct 2022 09:04:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] PCI: imx6: Fix link initialisation when the phy is ref
 clk provider
Message-ID: <20221013140450.GA3244741@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012132634.267970-1-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Would you mind rewording the subject so it says something more
specific about what the patch does?  E.g.,

  PCI: imx6: Initialize PHY before deasserting core reset

It may be that this ordering is only *required* when the PHY is the
ref clk provider, but the patch doesn't test for that; it *always*
initializes the PHY first.

On Wed, Oct 12, 2022 at 03:26:34PM +0200, Sascha Hauer wrote:
> When the phy is the reference clock provider then it must be initialised
> and powered on before the reset on the client is deasserted, otherwise
> the link will never come up. The order was changed in cf236e0c0d59.
> Restore the correct order to make the driver work again on boards where
> the phy provides the reference clock.

s/phy/PHY/ several places above

> Fixes: cf236e0c0d59 ("PCI: imx6: Do not hide PHY driver callbacks and refine the error handling")
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index b5f0de455a7bd..211eb55d6d34b 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -942,12 +942,6 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
>  		}
>  	}
>  
> -	ret = imx6_pcie_deassert_core_reset(imx6_pcie);
> -	if (ret < 0) {
> -		dev_err(dev, "pcie deassert core reset failed: %d\n", ret);
> -		goto err_phy_off;
> -	}
> -
>  	if (imx6_pcie->phy) {
>  		ret = phy_power_on(imx6_pcie->phy);
>  		if (ret) {
> @@ -955,6 +949,13 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
>  			goto err_phy_off;
>  		}
>  	}
> +
> +	ret = imx6_pcie_deassert_core_reset(imx6_pcie);
> +	if (ret < 0) {
> +		dev_err(dev, "pcie deassert core reset failed: %d\n", ret);
> +		goto err_phy_off;
> +	}
> +
>  	imx6_setup_phy_mpll(imx6_pcie);
>  
>  	return 0;
> -- 
> 2.30.2
> 
