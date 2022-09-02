Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F675AB721
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 19:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbiIBRE7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 13:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236291AbiIBRE5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 13:04:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD2115A11;
        Fri,  2 Sep 2022 10:04:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D571621AE;
        Fri,  2 Sep 2022 17:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE77C433C1;
        Fri,  2 Sep 2022 17:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662138291;
        bh=lAxIv2QfUf2l3nKsqdu22JAcrnIgJ48N3jh5vnIFQzc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PRpPlEAS+vV10WkjFd2TH3iPGH/W+xDWHqXVC9AXUx6z6Y1sDQ3leqzZAC3t60T7l
         uqeZ/8qorvgJhSS1r8iQqv1WAersSU+3+BYJLz3uP0Ni+YHlTM6qI3dcoxiZLbIOSM
         iftOWO8qkp2Sg2Hrs6v3wS6MqdwqRlEJAUQ/NBQZQsXGIAKEstjDuhOAvM+PJjQuB+
         9cL8+MU9v8qi1FSVt3biWE7zzO2Yxv+qLsBb85UAD9wFcAvzvAn92+Fxjs44/unia9
         L1yjEHFmn1+j/5k6ovZp0Wd2hjaV+FowWP154owJUEYyK6M6Yj3T/G3MoVIH/CmW+l
         Y9MvqPRcxOZ7A==
Date:   Fri, 2 Sep 2022 12:04:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     a.fatoum@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, vkoul@kernel.org,
        marcel.ziswiler@toradex.com, kishon@ti.com,
        linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v2] phy: freescale: imx8m-pcie: Fix the wrong order of
 phy_init() and phy_power_on()
Message-ID: <20220902170449.GA354728@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1661928956-12727-1-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 31, 2022 at 02:55:56PM +0800, Richard Zhu wrote:
> Refer to phy_core driver, phy_init() must be called before phy_power_on().
> Fix the wrong order of phy_init() and phy_power_on() here.

> Squash the changes into one patch to avoid the possible bi-section hole.

Avoiding bisection holes goes without saying, so I don't think we need
to even mention it ;)

> Fixes: 1aa97b002258 ("phy: freescale: pcie: Initialize the imx8 pcie standalone phy driver")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

I propose merging this via PCI, since I suspect pci-imx6.c is more
active than phy-fsl-imx8m-pcie.c.

Vinod, if you agree, I'm sure Lorenzo will look for your ack.

> ---
>  drivers/pci/controller/dwc/pci-imx6.c      | 6 +++---
>  drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
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
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy
