Return-Path: <linux-pci+bounces-8291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2DA8FC559
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 10:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D012815DA
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 08:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A27714F113;
	Wed,  5 Jun 2024 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBTiThhi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AF91922FC;
	Wed,  5 Jun 2024 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574813; cv=none; b=CBU1NovPzzJAmScWoLOOTG526mdliVGShraxjYPVDaDdKjfZy15BgND6v/zkN3ud1dBACNEQ/kCZuutAeelDpD06hXHxpeebhtCaC2AMEIH2Xh0KqWU9K/KOlMVuEks4XQoytjGNA1VA3D6clbtxo8v7AyH+oU1GxZDXotA848M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574813; c=relaxed/simple;
	bh=wYE6T1lsbts1oFahGg1sqw1GHF2V+AJpwXfB/pxwhww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dj63fbpZGGJ/Yfcn9JrMcrSXSHxIEAeghwcIAWun3RPEDF112yJGaW7t3dcsQ90hgZg2FaPXSa6vDUZ0NWLYBu5w5Kd4GUlX6GN15D7vMi6GD4Li9UECpxV9yQtSxv+liw+BVGsKyHO++smby26BrJV4P/f3cgv2U1DKftwkKgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBTiThhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DD5C3277B;
	Wed,  5 Jun 2024 08:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717574812;
	bh=wYE6T1lsbts1oFahGg1sqw1GHF2V+AJpwXfB/pxwhww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eBTiThhi4+nxpHQ0SWvxIV1sRELb02ftmzxAWxi5GQtjWEhdf0TmZZTo/2Mqg+Say
	 WWFU5R2pGdDMevTd2hzzAbjylu7JPM2uBHC6A83FwmkFKkJ/nSwqR6vG2u5jCnHjwj
	 UmZ7IwFGaBxVfjTGqFTyyH2nR9SonAjK3K1t4YYwpdx7p2g5CEG1hhW2AhuQMOo35l
	 WU6KB+oU19ZdTw41X/PK74Ou9x3AT+2QUScGdit/8buJbOVfly2mxDFqDrk7C+KS+S
	 Cc12SgXu6TckRzX06d0Oh5M9uYyBgpTv1eM2GXcIukltvsN+TBaOpxssS0JqRh6aei
	 Fp5hLoiFAGhzQ==
Date: Wed, 5 Jun 2024 13:36:40 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 09/13] PCI: dw-rockchip: Refactor the driver to
 prepare for EP mode
Message-ID: <20240605080640.GJ5085@thinkpad>
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
 <20240529-rockchip-pcie-ep-v1-v4-9-3dc00fe21a78@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240529-rockchip-pcie-ep-v1-v4-9-3dc00fe21a78@kernel.org>

On Wed, May 29, 2024 at 10:29:03AM +0200, Niklas Cassel wrote:
> This refactors the driver to prepare for EP mode.
> Add of-match data to the existing compatible, and explicitly define it as
> DW_PCIE_RC_TYPE. This way, we will be able to add EP mode in a follow-up
> commit in a much less intrusive way, which makes the follup-up commit much
> easier to review.
> 
> No functional change intended.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Few nitpicks below. With those addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 84 +++++++++++++++++++--------
>  1 file changed, 60 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 1380e3a5284b..e133511692af 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -49,15 +49,20 @@
>  #define PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)
>  
>  struct rockchip_pcie {
> -	struct dw_pcie			pci;
> -	void __iomem			*apb_base;
> -	struct phy			*phy;
> -	struct clk_bulk_data		*clks;
> -	unsigned int			clk_cnt;
> -	struct reset_control		*rst;
> -	struct gpio_desc		*rst_gpio;
> -	struct regulator                *vpcie3v3;
> -	struct irq_domain		*irq_domain;
> +	struct dw_pcie				pci;
> +	void __iomem				*apb_base;
> +	struct phy				*phy;
> +	struct clk_bulk_data			*clks;
> +	unsigned int				clk_cnt;
> +	struct reset_control			*rst;
> +	struct gpio_desc			*rst_gpio;
> +	struct regulator			*vpcie3v3;
> +	struct irq_domain			*irq_domain;
> +	const struct rockchip_pcie_of_data	*data;

I prefer to avoid aligning the struct members just for this reason. Once you add
a member with a bigger name, then you need to align others also. Please just use
space.

> +};
> +
> +struct rockchip_pcie_of_data {
> +	enum dw_pcie_device_mode mode;
>  };
>  
>  static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip, u32 reg)
> @@ -195,7 +200,6 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>  	struct device *dev = rockchip->pci.dev;
> -	u32 val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
>  	int irq, ret;
>  
>  	irq = of_irq_get_byname(dev->of_node, "legacy");
> @@ -209,12 +213,6 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>  	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
>  					 rockchip);
>  
> -	/* LTSSM enable control mode */
> -	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
> -
> -	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE,
> -				 PCIE_CLIENT_GENERAL_CONTROL);
> -
>  	return 0;
>  }
>  
> @@ -294,13 +292,35 @@ static const struct dw_pcie_ops dw_pcie_ops = {
>  	.start_link = rockchip_pcie_start_link,
>  };
>  
> +static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
> +{
> +	struct dw_pcie_rp *pp;
> +	u32 val;
> +
> +	/* LTSSM enable control mode */
> +	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
> +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
> +
> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE,
> +				 PCIE_CLIENT_GENERAL_CONTROL);
> +
> +	pp = &rockchip->pci.pp;
> +	pp->ops = &rockchip_pcie_host_ops;
> +
> +	return dw_pcie_host_init(pp);
> +}
> +
>  static int rockchip_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct rockchip_pcie *rockchip;
> -	struct dw_pcie_rp *pp;
> +	const struct rockchip_pcie_of_data *data;
>  	int ret;
>  
> +	data = of_device_get_match_data(dev);
> +	if (!data)
> +		return -EINVAL;

-ENODATA?

> +
>  	rockchip = devm_kzalloc(dev, sizeof(*rockchip), GFP_KERNEL);
>  	if (!rockchip)
>  		return -ENOMEM;
> @@ -309,9 +329,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  
>  	rockchip->pci.dev = dev;
>  	rockchip->pci.ops = &dw_pcie_ops;
> -
> -	pp = &rockchip->pci.pp;
> -	pp->ops = &rockchip_pcie_host_ops;
> +	rockchip->data = data;
>  
>  	ret = rockchip_pcie_resource_get(pdev, rockchip);
>  	if (ret)
> @@ -347,10 +365,21 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto deinit_phy;
>  
> -	ret = dw_pcie_host_init(pp);
> -	if (!ret)
> -		return 0;

Thanks a lot for getting rid of this ugly piece of code!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

