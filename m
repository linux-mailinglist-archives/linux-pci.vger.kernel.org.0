Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12B8610FE7
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 13:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJ1LmS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 07:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiJ1LmQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 07:42:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79791D1E2E;
        Fri, 28 Oct 2022 04:42:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C2C5627EB;
        Fri, 28 Oct 2022 11:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF58DC433C1;
        Fri, 28 Oct 2022 11:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666957334;
        bh=j5oyUBGYEDvyaMjSOM8jXa9mUm9PaDf/2SpF9C28fug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TTE5UUdfIiUDky5NmRxijg+BuPNiIOp9asdTm3Rz6Mup/Loeeliyw4zUzXSH0/ZOb
         z2JjC28Z5aBJtgkofForKoMLzv8H0lAz+q0+DvUiL9OKt/8kzImY6jMFs+FI1S7uZS
         mGjMANlZ8Eak2MePpmqKLpKfcpVtvbjPcXmKnI45sVl4QmFpVsBnM0O7+92OFToqWb
         xhfpvi5j+px/xS/WdWu2DHEPWlwVbJa3llaxgsQgVawHLGGwUI9ebLvsTmkoqMkAH5
         jNidf/+7fR33jdoaAGygyTBgG6HxWeghuyFsQH2no8IhpKvJcOneG1bNPuKbZCd5FN
         x4vti3KeUkwQg==
Date:   Fri, 28 Oct 2022 17:12:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, mani@kernel.org,
        Sergey.Semin@baikalelectronics.ru, ffclaire1224@gmail.com,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 08/21] phy: tegra: p2u: Set ENABLE_L2_EXIT_RATE_CHANGE
 in calibration
Message-ID: <Y1vAEh3NRiB5mrM7@matsya>
References: <20221013183854.21087-1-vidyas@nvidia.com>
 <20221013183854.21087-9-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013183854.21087-9-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14-10-22, 00:08, Vidya Sagar wrote:
> Set ENABLE_L2_EXIT_RATE_CHANGE register bit to request UPHY PLL rate change
> to Gen1 during initialization. This helps in the below surprise link down
> cases,
>   - Surprise link down happens at Gen3/Gen4 link speed.
>   - Surprise link down happens and external REFCLK is cut off, which causes
> UPHY PLL rate to deviate to an invalid rate.

This looks okay to me and I can go ahead and apply, PCI patches can come
thru PCI tree and whenever ready use .calibrate() ?

> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V3:
> * Removed "Reported-by: kernel test robot <lkp@intel.com>" based on Bjorn's review comment
> * Reworded the commit message
> 
> V2:
> * Addressed review comment from test bot and Vinod
> 
>  drivers/phy/tegra/phy-tegra194-p2u.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/phy/tegra/phy-tegra194-p2u.c b/drivers/phy/tegra/phy-tegra194-p2u.c
> index 1415ca71de38..633e6b747275 100644
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
> +static int tegra_p2u_calibrate(struct phy *x)
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
