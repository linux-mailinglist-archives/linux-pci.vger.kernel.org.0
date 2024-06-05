Return-Path: <linux-pci+bounces-8308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C878FC633
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 10:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB0F2852BF
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 08:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7FC19412F;
	Wed,  5 Jun 2024 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4ytbu9l"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323B61922F1;
	Wed,  5 Jun 2024 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575649; cv=none; b=Vb3c60ZXFGSoCTP0KX2g9wew3zBfGZOflyUoXgebzXgFZmCNB7pweI9bM74Yo929QwjX6vWHrHooaU4O4cN4I1sgKbplD1KjBACAXrplpgkbzOCmLGQDfcOZHKMvrty3MSKmujuKAKy0qDfletFJWVoG6Y0MlNWnlH++2ydrtEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575649; c=relaxed/simple;
	bh=tdJCoQUnDHwWGC9phlxd9DGQ1Y6QsRTagKbQFdMO/5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8K8NX67bRp24GuOBr2l4vDsGRW39O9YkUF3QZgcBPFdPIrRo2kOHTAYQALsWsCPUX2CjtwVUhOWUWtLGzyIeooCnqTdvPOGt35+SZOiCnQKbA5kiBNaNuzqoZQo1VWz9KV2kWInPgnizWMP3qad8xnUEz+5w9f04NPGAuk94hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4ytbu9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15807C3277B;
	Wed,  5 Jun 2024 08:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717575648;
	bh=tdJCoQUnDHwWGC9phlxd9DGQ1Y6QsRTagKbQFdMO/5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u4ytbu9l2gNIegcE1N/32b0M1xKHez4npGVzM4y+hRX5+Mwz7cQSeZHQHPe5Tw593
	 Yzb6BdHbKnhLbr9Hp0FqjCaOKczazZ0kqqrRg6dlURY7o0I4WZGj8XVgStdsqGhIzp
	 lgwzwItc+DRMOL180/qhlEXUf1CuJO0NsUaIZBodeW0MUEKH/3HYSqfo5Oy4auDgPr
	 zILutOM0Cs2w4n4iF202e0+uIRCT3jLAHnLtMA9Uz2xXHitqlCtrPLNPvmmnzAjPOA
	 BLCsYRahO7AwVd9jBrSf1nbG3MrIIFRrgAafa13ab2Fh2cGfEA4FmmeNUsV/n6DuTS
	 6evxlCsNGPYKw==
Date: Wed, 5 Jun 2024 13:50:34 +0530
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
Subject: Re: [PATCH v4 12/13] arm64: dts: rockchip: Add PCIe endpoint mode
 support
Message-ID: <20240605082034.GL5085@thinkpad>
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
 <20240529-rockchip-pcie-ep-v1-v4-12-3dc00fe21a78@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240529-rockchip-pcie-ep-v1-v4-12-3dc00fe21a78@kernel.org>

On Wed, May 29, 2024 at 10:29:06AM +0200, Niklas Cassel wrote:
> Add a device tree node representing PCIe endpoint mode.
> 
> The controller can either be configured to run in Root Complex or Endpoint
> node.
> 
> If a user wants to run the controller in endpoint mode, the user has to
> disable the pcie3x4 node and enable the pcie3x4_ep node.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

One nitpick below.

> ---
>  arch/arm64/boot/dts/rockchip/rk3588.dtsi | 35 ++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> index 5984016b5f96..6b5bf1055143 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> @@ -186,6 +186,41 @@ pcie3x4_intc: legacy-interrupt-controller {
>  		};
>  	};
>  
> +	pcie3x4_ep: pcie-ep@fe150000 {
> +		compatible = "rockchip,rk3588-pcie-ep";
> +		clocks = <&cru ACLK_PCIE_4L_MSTR>, <&cru ACLK_PCIE_4L_SLV>,
> +			 <&cru ACLK_PCIE_4L_DBI>, <&cru PCLK_PCIE_4L>,
> +			 <&cru CLK_PCIE_AUX0>, <&cru CLK_PCIE4L_PIPE>;
> +		clock-names = "aclk_mst", "aclk_slv",
> +			      "aclk_dbi", "pclk",
> +			      "aux", "pipe";
> +		interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH 0>;
> +		interrupt-names = "sys", "pmc", "msg", "legacy", "err",
> +				  "dma0", "dma1", "dma2", "dma3";
> +		max-link-speed = <3>;
> +		num-lanes = <4>;
> +		phys = <&pcie30phy>;
> +		phy-names = "pcie-phy";
> +		power-domains = <&power RK3588_PD_PCIE>;
> +		reg = <0xa 0x40000000 0x0 0x00100000>,
> +		      <0xa 0x40100000 0x0 0x00100000>,
> +		      <0x0 0xfe150000 0x0 0x00010000>,
> +		      <0x9 0x00000000 0x0 0x40000000>,
> +		      <0xa 0x40300000 0x0 0x00100000>;
> +		reg-names = "dbi", "dbi2", "apb", "addr_space", "atu";

As suggested in the bindings patch, please move these reg properties below
compatible.

- Mani

> +		resets = <&cru SRST_PCIE0_POWER_UP>, <&cru SRST_P_PCIE0>;
> +		reset-names = "pwr", "pipe";
> +		status = "disabled";
> +	};
> +
>  	pcie3x2: pcie@fe160000 {
>  		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
>  		#address-cells = <3>;
> 
> -- 
> 2.45.1
> 

-- 
மணிவண்ணன் சதாசிவம்

