Return-Path: <linux-pci+bounces-44614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E42D19879
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 15:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A7D53072F8D
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 14:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA911288522;
	Tue, 13 Jan 2026 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQNfju/Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CD029AB02
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314898; cv=none; b=cr1wCQp6MhUgnEWZJMrXqZKKeXS0Rcfl6GKJy5wTwxOV3ZfiSKo62JrCr7WWgCimbh2wrbmScAeZs1sCzmi8kgr/XPMwIKvC3eLymeaqXEiVmLj0X04K79vLqcRmhMV80Hg/HZ7cSQct4X9rDme+IAQtpAPZfnOxDRylEg3bnMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314898; c=relaxed/simple;
	bh=AzZQytbKoAJJfaB4z4AtSC0UhVkaJpMEr1pqnGeXh9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZcAj7lmp8spK7uD+HYiD0yaKE2hgfUFwF2flcn3xQg85WJyopd9b11YX2MDtj9U6wVgNp2/xApWEn3dUaQ59v24svYYyjh36lKzqf1uT30LqYQpcctyRHUzIm64kWdVtEJX+bvBc30m22x9a5dsm7K+HezUszG5eRIIDBDzz6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQNfju/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F47C116C6;
	Tue, 13 Jan 2026 14:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768314898;
	bh=AzZQytbKoAJJfaB4z4AtSC0UhVkaJpMEr1pqnGeXh9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MQNfju/Q9a6Hn8BI1P+idlfvG6yB1q8BDwruQgbECFoMUIsvVS2gOeytY885uwG7X
	 +tjwGvxA0cfaMtbIPAX7V9Xb6sAdeu7wQDvIN0X49EJ8/j1BfRhR9E8MvJQIIJkCqW
	 Au5RHD49jMU0HAZ12NZNsHajN5XUmuzOZHyKrf6NvlVMxoPESPULpCNKVrbU2tZOas
	 VVzxa4SVZuIuc+/IBd4IdXgKTylQ/4es8ZhJ66VsoHqG5VyrPY9aHVC+LODho/Oe2P
	 yH5qxPs3GaSPIy1zUwYdQfQy/+nQ6rAUwdsq4wUe0VXoWfAPmHjsl+JUwDuV+oVrq3
	 tD4eBiT4ngUig==
Date: Tue, 13 Jan 2026 20:04:50 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>, 
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-phy@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 1/5] PCI: dw-rockchip: Add phy_calibrate() to check PHY
 lock status
Message-ID: <og25pa5rxaktqjs7x2h3gkq4yvh77tq6xksc5usddvy3dpqxsp@honmrhi4fv5i>
References: <1766560210-100883-1-git-send-email-shawn.lin@rock-chips.com>
 <1766560210-100883-2-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1766560210-100883-2-git-send-email-shawn.lin@rock-chips.com>

On Wed, Dec 24, 2025 at 03:10:06PM +0800, Shawn Lin wrote:
> Current we keep controller in reset state when initializing PHY which
> is the right thing to do. But this case, the PHY is also reset because
> it refers to a signal from controller. Now we check PHY lock status
> inside .phy_init() callback which may be bogus for certain type of PHY,
> because of the fact above. Add phy_calibrate() to better check PHY lock
> status if provided.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

I guess this patch can get merged separately without the PHY patches and not
cause any functional issue. But I'd like the PHY patches to get reviewed so that
we know that the API usage is correct.

- Mani

> ---
> 
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index f8605fe..75d6306 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -705,6 +705,12 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto deinit_phy;
>  
> +	ret = phy_calibrate(rockchip->phy);
> +	if (ret) {
> +		dev_err(dev, "phy lock failed\n");
> +		goto assert_controller;
> +	}
> +
>  	ret = rockchip_pcie_clk_init(rockchip);
>  	if (ret)
>  		goto deinit_phy;
> @@ -727,7 +733,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	}
>  
>  	return 0;
> -
> +assert_controller:
> +	reset_control_assert(rockchip->rst);
>  deinit_clk:
>  	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
>  deinit_phy:
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்

