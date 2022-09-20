Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9695BDCEA
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 08:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiITGLt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 02:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiITGLt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 02:11:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C42D3AE46;
        Mon, 19 Sep 2022 23:11:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C54F5B8249F;
        Tue, 20 Sep 2022 06:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB181C433C1;
        Tue, 20 Sep 2022 06:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663654305;
        bh=NuFw7uED7Nut4KOkUsKsKxYCFbmw1Pj9smtOuX/NV5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sJ/P2SXqcLyeBHY3+xxuhckYc5Q5wc31re0TfJgTYhh/XxK6AYmDtnQmvy8jjgrrq
         KE2B0Z9zUk1lwISuJnYeVhkhfvShg5Zy+sLLC9/fNmoMG9HuxbkMLGyuM7IL0IJ+vT
         HqAa4AYUFX/T5UATTw50dGM6Xkkh+3oXIAv38wgCY6c5QPYajL0vl7XgTudNLNUhAF
         7qrMr2OgZz5EupI66zkwli4u4OarQTHNaz7x5rmJyI/tYjKfzO3RYhvkR70D4BWjbz
         bwWXRYD9tfYzK7vy/S3E3fKQqPv4qDdXmCai7+e+Xaq55+fN0OLrvKVShXlsi/gNEw
         Moi5LGimzIuqQ==
Date:   Tue, 20 Sep 2022 11:41:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, mani@kernel.org,
        Sergey.Semin@baikalelectronics.ru, ffclaire1224@gmail.com,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1 8/9] phy: tegra: p2u: Set ENABLE_L2_EXIT_RATE_CHANGE
 in calibration
Message-ID: <YylZnfan61xlXFWb@matsya>
References: <20220919143627.13803-1-vidyas@nvidia.com>
 <20220919143627.13803-9-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919143627.13803-9-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19-09-22, 20:06, Vidya Sagar wrote:
> Set ENABLE_L2_EXIT_RATE_CHANGE to request UPHY PLL rate change to Gen1
> during initialization. This helps in the below surprise down cases,
>   - Surprise down happens at Gen3/Gen4 link speed
>   - Surprise down happens and external REFCLK is cut off which causes
> UPHY PLL rate to deviate to an invalid rate
> 
> ENABLE_L2_EXIT_RATE_CHANGE needs to be set to bring the UPHY PLL rate
> back to Gen1 during controller initialization for the link up.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/phy/tegra/phy-tegra194-p2u.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/phy/tegra/phy-tegra194-p2u.c b/drivers/phy/tegra/phy-tegra194-p2u.c
> index 1415ca71de38..fb710e89acac 100644
> --- a/drivers/phy/tegra/phy-tegra194-p2u.c
> +++ b/drivers/phy/tegra/phy-tegra194-p2u.c
> @@ -15,6 +15,7 @@
>  #include <linux/phy/phy.h>
>  
>  #define P2U_CONTROL_CMN			0x74
> +#define P2U_CONTROL_CMN_ENABLE_L2_EXIT_RATE_CHANGE		BIT(13)
>  #define P2U_CONTROL_CMN_SKP_SIZE_PROTECTION_EN			BIT(20)
>  
>  #define P2U_PERIODIC_EQ_CTRL_GEN3	0xc0
> @@ -85,8 +86,21 @@ static int tegra_p2u_power_on(struct phy *x)
>  	return 0;
>  }
>  
> +int tegra_p2u_calibrate(struct phy *x)

why not static?

> +{
> +	struct tegra_p2u *phy = phy_get_drvdata(x);
> +	u32 val;
> +
> +	val = p2u_readl(phy, P2U_CONTROL_CMN);
> +	val |= P2U_CONTROL_CMN_ENABLE_L2_EXIT_RATE_CHANGE;
> +	p2u_writel(phy, val, P2U_CONTROL_CMN);
> +
> +	return 0;
> +}
> +
>  static const struct phy_ops ops = {
>  	.power_on = tegra_p2u_power_on,
> +	.calibrate = tegra_p2u_calibrate,
>  	.owner = THIS_MODULE,
>  };
>  
> -- 
> 2.17.1

-- 
~Vinod
