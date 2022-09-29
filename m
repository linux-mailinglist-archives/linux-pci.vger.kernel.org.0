Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AAC5EF109
	for <lists+linux-pci@lfdr.de>; Thu, 29 Sep 2022 10:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiI2I5k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Sep 2022 04:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiI2I5W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2022 04:57:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3688EEF085;
        Thu, 29 Sep 2022 01:57:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22D2CB823C8;
        Thu, 29 Sep 2022 08:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BC2C433D6;
        Thu, 29 Sep 2022 08:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664441826;
        bh=AB9OBY5Q/XflWMZEjGozmUCmyCSOHdzr9/Xwke2HRv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dffSs2Rj/KWFa80GhJnSSBe+iznLMBr3NPAxLCx0A1gjoxQlImpAsZnx1j5w9b40F
         Eph18owQWi1Bxcge1T8ZNkpQphOqefizXcurvioFIbQH6Odqc9ggdpRUs57XcdtDb5
         aM6aNtHoASOVZPgz5/ZmXjtXTlH8VV/oUN+fyjtcNz8yGMfJG2m0lnPRyhzAwvfrd6
         Ez7/R1bUz+jaTTtueRhwBJRWoCa3MaAfedfpgyPdIEyShPScOTTBk4XPtnp3lUVjET
         dhgg388O4vhnFwSAIs8BeLkBgeQoMnUj4H0M8BxXkapEeRSEaSVcgGQg8cdIN125wW
         FL4gowVrJL4PA==
Date:   Thu, 29 Sep 2022 10:57:00 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     a.fatoum@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, vkoul@kernel.org,
        marcel.ziswiler@toradex.com, kishon@ti.com,
        linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v3] phy: freescale: imx8m-pcie: Fix the wrong order of
 phy_init() and phy_power_on()
Message-ID: <YzVd3GAtpd0ipMAu@lpieralisi>
References: <1662344583-18874-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662344583-18874-1-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 05, 2022 at 10:23:03AM +0800, Richard Zhu wrote:
> Refer to phy_core driver, phy_init() must be called before phy_power_on().
> Fix the wrong order of phy_init() and phy_power_on() here.
> 
> Fixes: 1aa97b002258 ("phy: freescale: pcie: Initialize the imx8 pcie standalone phy driver")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Acked-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c      | 6 +++---
>  drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)

Who is picking this up ? I believe this is supposed to
go via the PHY tree, so:

Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 6e5debdbc55b..b5f0de455a7b 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -935,7 +935,7 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
>  	}
>  
>  	if (imx6_pcie->phy) {
> -		ret = phy_power_on(imx6_pcie->phy);
> +		ret = phy_init(imx6_pcie->phy);
>  		if (ret) {
>  			dev_err(dev, "pcie PHY power up failed\n");
>  			goto err_clk_disable;
> @@ -949,7 +949,7 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
>  	}
>  
>  	if (imx6_pcie->phy) {
> -		ret = phy_init(imx6_pcie->phy);
> +		ret = phy_power_on(imx6_pcie->phy);
>  		if (ret) {
>  			dev_err(dev, "waiting for PHY ready timeout!\n");
>  			goto err_phy_off;
> @@ -961,7 +961,7 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
>  
>  err_phy_off:
>  	if (imx6_pcie->phy)
> -		phy_power_off(imx6_pcie->phy);
> +		phy_exit(imx6_pcie->phy);
>  err_clk_disable:
>  	imx6_pcie_clk_disable(imx6_pcie);
>  err_reg_disable:
> diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> index ad7d2edfc414..c93286483b42 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> @@ -59,7 +59,7 @@ struct imx8_pcie_phy {
>  	bool			clkreq_unused;
>  };
>  
> -static int imx8_pcie_phy_init(struct phy *phy)
> +static int imx8_pcie_phy_power_on(struct phy *phy)
>  {
>  	int ret;
>  	u32 val, pad_mode;
> @@ -137,14 +137,14 @@ static int imx8_pcie_phy_init(struct phy *phy)
>  	return ret;
>  }
>  
> -static int imx8_pcie_phy_power_on(struct phy *phy)
> +static int imx8_pcie_phy_init(struct phy *phy)
>  {
>  	struct imx8_pcie_phy *imx8_phy = phy_get_drvdata(phy);
>  
>  	return clk_prepare_enable(imx8_phy->clk);
>  }
>  
> -static int imx8_pcie_phy_power_off(struct phy *phy)
> +static int imx8_pcie_phy_exit(struct phy *phy)
>  {
>  	struct imx8_pcie_phy *imx8_phy = phy_get_drvdata(phy);
>  
> @@ -155,8 +155,8 @@ static int imx8_pcie_phy_power_off(struct phy *phy)
>  
>  static const struct phy_ops imx8_pcie_phy_ops = {
>  	.init		= imx8_pcie_phy_init,
> +	.exit		= imx8_pcie_phy_exit,
>  	.power_on	= imx8_pcie_phy_power_on,
> -	.power_off	= imx8_pcie_phy_power_off,
>  	.owner		= THIS_MODULE,
>  };
>  
> -- 
> 2.25.1
> 
