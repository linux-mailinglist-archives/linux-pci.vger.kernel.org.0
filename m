Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C693576A9E
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 01:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiGOXVj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 19:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiGOXVd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 19:21:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4561C93C39;
        Fri, 15 Jul 2022 16:21:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94801B82F03;
        Fri, 15 Jul 2022 23:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8CFC34115;
        Fri, 15 Jul 2022 23:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657927282;
        bh=J5W0p4ucASc4vcM38f4aAA0aBmwfM4SM9vH8Xt0UEZ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MIhvZ7dyMNTqXpgIUIKXdHkUN20tBif8oS4/LgKCwjiH8brwnLVDd+vcILhnOI3vM
         EuUnP/YFXNcXIb8iowT53tmDt5Z7brcoFxZx1I2PHndD6GVq4FRzcN6B4lSA7r1c0x
         LRs7BiRfZhswP2QzAM7v+kcXHwG3uhGSpRpoBh7tP/lYN27XpA3Wwu2I/6VdrNh4dZ
         c/4dgeNHnAl0kxerrkkp2/h8qJHXUBrBwce+k++MHN4yN45rRnoN1Wi3jYa+fu9gL2
         VBMCW6QAwre/G32926VhoMuoFDygW8Ylbrb/BNvFkQflBfDAfIryBBvmSHUQ97ivxH
         tDpERWrjFJ+zQ==
Date:   Fri, 15 Jul 2022 18:21:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-phy@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 1/2] phy: samsung: phy-exynos-pcie: sanitize
 init/power_on callbacks
Message-ID: <20220715232120.GA1216057@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628220409.26545-1-m.szyprowski@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 29, 2022 at 12:04:08AM +0200, Marek Szyprowski wrote:
> The exynos-pcie driver called phy_power_on() and then phy_init() for some
> historical reasons. However the generic PHY framework assumes that the
> proper sequence is to call phy_init() first, then phy_power_on(). The
> operations done by both functions should be considered as one action and
> as such they are called by the exynos-pcie driver (without doing anything
> between them). The initialization is just a sequence of register writes,
> which cannot be altered, without breaking the hardware operation.
> 
> To match the generic PHY framework requirement, simply move all register
> writes to the phy_init()/phy_exit() and drop power_on()/power_off()
> callbacks. This way the driver will also work with the old (incorrect)
> PHY initialization call sequence.
> 
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Both applied to pci/ctrl/exynos for v5.20, thanks!

> ---
>  drivers/phy/samsung/phy-exynos-pcie.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/phy/samsung/phy-exynos-pcie.c b/drivers/phy/samsung/phy-exynos-pcie.c
> index 578cfe07d07a..53c9230c2907 100644
> --- a/drivers/phy/samsung/phy-exynos-pcie.c
> +++ b/drivers/phy/samsung/phy-exynos-pcie.c
> @@ -51,6 +51,13 @@ static int exynos5433_pcie_phy_init(struct phy *phy)
>  {
>  	struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
>  
> +	regmap_update_bits(ep->pmureg, EXYNOS5433_PMU_PCIE_PHY_OFFSET,
> +			   BIT(0), 1);
> +	regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_GLOBAL_RESET,
> +			   PCIE_APP_REQ_EXIT_L1_MODE, 0);
> +	regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_L1SUB_CM_CON,
> +			   PCIE_REFCLK_GATING_EN, 0);
> +
>  	regmap_update_bits(ep->fsysreg,	PCIE_EXYNOS5433_PHY_COMMON_RESET,
>  			   PCIE_PHY_RESET, 1);
>  	regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_MAC_RESET,
> @@ -109,20 +116,7 @@ static int exynos5433_pcie_phy_init(struct phy *phy)
>  	return 0;
>  }
>  
> -static int exynos5433_pcie_phy_power_on(struct phy *phy)
> -{
> -	struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
> -
> -	regmap_update_bits(ep->pmureg, EXYNOS5433_PMU_PCIE_PHY_OFFSET,
> -			   BIT(0), 1);
> -	regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_GLOBAL_RESET,
> -			   PCIE_APP_REQ_EXIT_L1_MODE, 0);
> -	regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_L1SUB_CM_CON,
> -			   PCIE_REFCLK_GATING_EN, 0);
> -	return 0;
> -}
> -
> -static int exynos5433_pcie_phy_power_off(struct phy *phy)
> +static int exynos5433_pcie_phy_exit(struct phy *phy)
>  {
>  	struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
>  
> @@ -135,8 +129,7 @@ static int exynos5433_pcie_phy_power_off(struct phy *phy)
>  
>  static const struct phy_ops exynos5433_phy_ops = {
>  	.init		= exynos5433_pcie_phy_init,
> -	.power_on	= exynos5433_pcie_phy_power_on,
> -	.power_off	= exynos5433_pcie_phy_power_off,
> +	.exit		= exynos5433_pcie_phy_exit,
>  	.owner		= THIS_MODULE,
>  };
>  
> -- 
> 2.17.1
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy
