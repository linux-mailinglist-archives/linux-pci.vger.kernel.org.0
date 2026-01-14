Return-Path: <linux-pci+bounces-44740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B424D1F11A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 14:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 997B03010980
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 13:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A52138BF96;
	Wed, 14 Jan 2026 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6TvRHPq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2E737B40B
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768397396; cv=none; b=fAdvyQXmdzBbEp+ZVXBbIWAYveYzjVM2gt2R7Ssj/wiJiPlr0EYvasfJwSTacfMrDI+frAMg0rEON3XccyKkUFYGndGD+ZBST7K7v0AYdsErujH7wbnsqp6whLYLd+SFsskUCQeDIQ4ruV7c17+GWySNrhOTH4AXt1hQzwdW9XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768397396; c=relaxed/simple;
	bh=194PmoqrLmqXrWfN2Bl3lw4B4bZEIfsiGBpd7H0rceU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKxuvD7F/RqQUU9mxAdajcT0RQJEo/CM9kXSxRfiZLhOFWR/nVN1CeOFdXxYJugBI7c6mSuxy0ZPj9z3kC6iz39mCKAxvGGUmr6PFl/PqGS40Ox4lb31/7wiAi2MpP5RYwvYVcXjE88MhSV+wk0BR/5cQXMx7UBvXcGjBkGGvE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6TvRHPq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EB9C4CEF7;
	Wed, 14 Jan 2026 13:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768397395;
	bh=194PmoqrLmqXrWfN2Bl3lw4B4bZEIfsiGBpd7H0rceU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t6TvRHPqe1DXhY8NuwX/BYV4BSwuch7Szg2R3i8GKMiPfH9BP4BiSx1R043J+IdwD
	 oWVn7sc1RbFJvYVt0lKgIq/vN7ODplE2pGMDPlWl8buY3vhBSG2KYETg+wA0p4AZ52
	 aA4mhUkQz8yjmWZ7/yOC8BB9btAsvklD+FCSX57ObXagHOmo6TVdoMUrEg/TxkrJ1L
	 gO1RZfRo2uKN4gnvC2oaMfl5JMqYyzWc//2aWzb/Rlh9i6yJZN72Zv9+MSgov0SXny
	 7bUXAma4A/RdtRhPmGYWhQxapn3vMKBSm8Pm5OLrZkKLe2IhH4POoXqgsNhHM0CCry
	 tdAb/v5igV1gQ==
Date: Wed, 14 Jan 2026 18:59:52 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 3/5] phy: rockchip-snps-pcie3: Increase sram init timeout
Message-ID: <aWeaUG45FWtdgscG@vaman>
References: <1766560210-100883-1-git-send-email-shawn.lin@rock-chips.com>
 <1766560210-100883-4-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1766560210-100883-4-git-send-email-shawn.lin@rock-chips.com>

On 24-12-25, 15:10, Shawn Lin wrote:
> Per massive test, 500us is not enough for all chips, increase it
> to 20000us for worse case recommended.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/phy/rockchip/phy-rockchip-snps-pcie3.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> index 9933cda..f5a5d0af 100644
> --- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> +++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> @@ -19,6 +19,9 @@
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
>  
> +/* Common definition */
> +#define RK_SRAM_INIT_TIMEOUT_US			20000
> +
>  /* Register for RK3568 */
>  #define GRF_PCIE30PHY_CON1			0x4
>  #define GRF_PCIE30PHY_CON6			0x18
> @@ -28,6 +31,7 @@
>  #define GRF_PCIE30PHY_WR_EN			(0xf << 16)
>  #define SRAM_INIT_DONE(reg)			(reg & BIT(14))
>  
> +

why this empty line here?

>  #define RK3568_BIFURCATION_LANE_0_1		BIT(0)
>  
>  /* Register for RK3588 */
> @@ -134,7 +138,7 @@ static int rockchip_p3phy_rk3568_calibrate(struct rockchip_p3phy_priv *priv)
>  	ret = regmap_read_poll_timeout(priv->phy_grf,
>  				       GRF_PCIE30PHY_STATUS0,
>  				       reg, SRAM_INIT_DONE(reg),
> -				       0, 500);
> +				       0, RK_SRAM_INIT_TIMEOUT_US);
>  	if (ret)
>  		dev_err(&priv->phy->dev, "lock failed 0x%x, check input refclk and power supply\n",
>  			reg);
> @@ -203,11 +207,11 @@ static int rockchip_p3phy_rk3588_calibrate(struct rockchip_p3phy_priv *priv)
>  	ret = regmap_read_poll_timeout(priv->phy_grf,
>  				       RK3588_PCIE3PHY_GRF_PHY0_STATUS1,
>  				       reg, RK3588_SRAM_INIT_DONE(reg),
> -				       0, 500);
> +				       0, RK_SRAM_INIT_TIMEOUT_US);
>  	ret |= regmap_read_poll_timeout(priv->phy_grf,
>  					RK3588_PCIE3PHY_GRF_PHY1_STATUS1,
>  					reg, RK3588_SRAM_INIT_DONE(reg),
> -					0, 500);
> +					0, RK_SRAM_INIT_TIMEOUT_US);
>  	if (ret)
>  		dev_err(&priv->phy->dev, "lock failed 0x%x, check input refclk and power supply\n",
>  			reg);
> -- 
> 2.7.4

-- 
~Vinod

