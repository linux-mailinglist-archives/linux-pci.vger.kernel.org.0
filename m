Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6579D56631F
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 08:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiGEGZd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 02:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGEGZc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 02:25:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E0AA1AB;
        Mon,  4 Jul 2022 23:25:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5AFF5CE1A17;
        Tue,  5 Jul 2022 06:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E58FC341C7;
        Tue,  5 Jul 2022 06:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657002327;
        bh=gT9vnVWwfoaHB/KlAQfPukD6zbCjQfi0xC2TgLz8Ixg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QQiyORgpEmTuZ7hRd4rpivPxBCRE9sZIIC3psJ10k8AnU9FSkYEBIWeO6oHhY+2bT
         gOWu9onqD66WfCeviF8oHCZ4jqy2FvULccPniYlVH80npXuF+UKUaum0uGZlqKjRWu
         75jMaHvqwZFIP0EhiwBoBVV6lF+8Vs6WCE+ZVxQKZp6rHFOkbdsKvA3DQpCp9Zv9iV
         fDEDKGK6y+u12lk2sLoWMg61Kx7XNzlNm177NRMQVvo2VoxDUoWeqEopmswjhyzomu
         LJDeH7sOhMyyk1OreB6khpri975grUltDUHjZ3AfmQ5Zz1G3sN4uFrXHoebb9NyyBr
         ZCFrhwe33Aslg==
Date:   Tue, 5 Jul 2022 11:55:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-phy@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/2] phy: samsung: phy-exynos-pcie: sanitize
 init/power_on callbacks
Message-ID: <YsPZU83Jl/kcqR8h@matsya>
References: <CGME20220628220437eucas1p2c478751458323f93a71050c4a949f12e@eucas1p2.samsung.com>
 <20220628220409.26545-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628220409.26545-1-m.szyprowski@samsung.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29-06-22, 00:04, Marek Szyprowski wrote:
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

Is the plan to merge thru pcie tree?

> 
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
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

why not retain exynos5433_pcie_phy_power_on() and call it from here and
drop in ops. It would be clear to reader that these are for turning on
the phy...

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

-- 
~Vinod
