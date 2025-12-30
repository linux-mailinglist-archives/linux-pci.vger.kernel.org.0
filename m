Return-Path: <linux-pci+bounces-43823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C12CE8A48
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 04:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBC3830109B5
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 03:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C044286418;
	Tue, 30 Dec 2025 03:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3/K7jpk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C52641FC;
	Tue, 30 Dec 2025 03:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767065303; cv=none; b=p6GP/36OZdOQy7znwoo2O3/ONUYtiTCQZULE67PTb0wHMZygZPhfupz4ki5UsC17Oy5Dn+uopIIOzPGHZIEMeIZagJDDXYXYK7OjYjooPugbhuRajCjYvHIKNUERFB74WXr9oXCBN1ffqmAISS6ZTP0A7gS/tsL5NEN7k8DbH0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767065303; c=relaxed/simple;
	bh=Dccpw7NPvtBDj/FiKmoCP1aZ1Hu8cpN1GGFZQAOlyAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUsLbBNTcvtli16R8c/gE7EqWueBANdYzREczdjblYp1K0tZr8RoM/sHPuGro0JSd1B1AjfESCBnHRBkHm7CcnMmOnQOguiv05VhQ/Vu956hzTFfI9oFXKgdRVdbK55M3l18UoRTHk+qoyaC6mw2QBUyz0T1T1XIbdqVF99dRoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3/K7jpk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87405C16AAE;
	Tue, 30 Dec 2025 03:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767065302;
	bh=Dccpw7NPvtBDj/FiKmoCP1aZ1Hu8cpN1GGFZQAOlyAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3/K7jpk/8nZPjwYl44wpek4Pb6k5lsqGww8UKUxKm0vtED6l/Qe6gmgMFRl22BR0
	 Rb0Hbp6YVKnByxVtcyD5CLRDuUzvtx+SITxnWHn1oUemGtsV8vsguciQI55RRm85AL
	 Lg3BiEh5kRHpVeKfjHWDCDx0GutRyXKaFIEFVZ5znJvGR5BfBZDBunoaTKq6aZKH+H
	 33DQo2cxFKA+uvpnZl5y27MTkzfP77a2YQN+oCeFtrTngRqMdQ0y50E8i0adNTfeeb
	 8/YqrJNGlXXHdYo52LQo+xVR9nkHxFRUO0HMwmoVprvOdMmmOC/9a5jNIeB4dABhoV
	 eDpJOeW7fuGDg==
Date: Tue, 30 Dec 2025 11:28:16 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	bhelgaas@google.com, frank.li@nxp.com, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 4/4] arm64: dt: imx95: Add the missed ref clock for
 PCIe[0,1]
Message-ID: <aVNG0BjbEVHhgNCa@dragon>
References: <20251211064821.2707001-1-hongxing.zhu@nxp.com>
 <20251211064821.2707001-5-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211064821.2707001-5-hongxing.zhu@nxp.com>

On Thu, Dec 11, 2025 at 02:48:21PM +0800, Richard Zhu wrote:
> i.MX95 PCIes have two reference clock inputs, one of them is from
> internal PLL. It's wired inside chip and present as "ref" clock. It's
> not an optional clock.
> 
> Add the missed ref clock for PCIe[0,1].
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

It doesn't seem to apply to my tree.

Shawn

> ---
>  .../boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
> index 5b6b2bb80b288..1258fcb54681e 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
> @@ -237,8 +237,9 @@ &pcie0 {
>  	clocks = <&scmi_clk IMX95_CLK_HSIO>,
>  		 <&pcieclk 1>,
>  		 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> -		 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> -	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
> +		 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
> +		 <&hsio_blk_ctl 0>;
> +	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
>  	reset-gpio = <&expander2 9 GPIO_ACTIVE_LOW>;
>  	status = "okay";
>  };
> @@ -250,8 +251,9 @@ &pcie1 {
>  	clocks = <&scmi_clk IMX95_CLK_HSIO>,
>  		 <&pcieclk 0>,
>  		 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> -		 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> -	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
> +		 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
> +		 <&hsio_blk_ctl 0>;
> +	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
>  	reset-gpio = <&expander2 10 GPIO_ACTIVE_LOW>;
>  	status = "okay";
>  };
> -- 
> 2.37.1
> 

