Return-Path: <linux-pci+bounces-30385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDE2AE3FDB
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 14:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD513E04F5
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 12:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0EA248191;
	Mon, 23 Jun 2025 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfP7CoTy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C79524169B;
	Mon, 23 Jun 2025 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680933; cv=none; b=t18bVNCPCgBuMWjMKmbnUlB+M6oaKea9JwsGZZHMOJGLXv2vleZxq6nVaC5XAuupAyAk7RnvBKhFYnkYC5LHbwFDtG/sueFrYJu6ASfJuYugfozO7USJ1FgXtVbmIpoDbFNSQexEvvoSlRbtqGGJseZl3YJqUr63NlE6AjvHI5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680933; c=relaxed/simple;
	bh=pr2/No/guItEEsZxzpUA7Zdi/FU0THWZwck2JGVadcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXVdA9BV19RiaA+cG8dRwBzdW/iVVc6QkRWSws0Tejd6kCc7xfrMF5z0VGUupuCdRv60LvvpVnUBOeq4/HdGIkIZsvItsALUGUy4pCaFBNe9uYCncf/RNZvFHDdy92YJy807FyQoZPOyxHa6U8qLbLcC1k9Kl2S7HNpXXOurNOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfP7CoTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB84C4CEEA;
	Mon, 23 Jun 2025 12:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750680933;
	bh=pr2/No/guItEEsZxzpUA7Zdi/FU0THWZwck2JGVadcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FfP7CoTyA8fu1qCwlWVPh5R8i5EG5GKmtcq50mO0Txd7ASAKCgT7eI5eLmmW4JRCD
	 bT2rk641NFiTtFeOu4W2WwvmiuTe5RvfdJPMiGkB0iGPunuNBVKnKXiSzYFzuwEUmy
	 Y3ATCjQJcuWGHBBP3JgbuaGB1TAqvg/Z2rDwEUkXRclqscxwUgb0gq9qUk8++07THf
	 z4g7+5C0syh+uUqEuOnWnD+NiPOG72Zjl1xrMfOwPPNLdfWmCJTUK7RrnNhylGJWQQ
	 o/hpBLdgYSVSDm1wyfKRXs4mNNU/8yi+GWV6tvk0v8xC71ViUdvIZntzgzEHjJCe8U
	 4KN6vgL3PYNSA==
Date: Mon, 23 Jun 2025 06:15:31 -0600
From: Manivannan Sadhasivam <mani@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, p.zabel@pengutronix.de, 
	johan+linaro@kernel.org, cassel@kernel.org, shradha.t@samsung.com, 
	thippeswamy.havalige@amd.com, quic_schintav@quicinc.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 7/9] arm64: dts: st: Add PCIe Root Complex mode on
 stm32mp251
Message-ID: <vhzu4e233bulwq3jwozctvxzg2ib5j7n6axfneltznnqi453np@npbx44uvccdd>
References: <20250610090714.3321129-1-christian.bruel@foss.st.com>
 <20250610090714.3321129-8-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610090714.3321129-8-christian.bruel@foss.st.com>

On Tue, Jun 10, 2025 at 11:07:12AM +0200, Christian Bruel wrote:
> Add pcie_rc node to support STM32 MP25 PCIe driver based on the
> DesignWare PCIe core configured as Root Complex mode
> 
> Supports Gen1/Gen2, single lane, MSI interrupts using the ARM GICv2m
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  arch/arm64/boot/dts/st/stm32mp251.dtsi | 44 ++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> index 8d87865850a7..781d0e43ab59 100644
> --- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
> +++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> @@ -122,6 +122,15 @@ intc: interrupt-controller@4ac00000 {
>  		      <0x0 0x4ac20000 0x0 0x20000>,
>  		      <0x0 0x4ac40000 0x0 0x20000>,
>  		      <0x0 0x4ac60000 0x0 0x20000>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		v2m0: v2m@48090000 {
> +			compatible = "arm,gic-v2m-frame";
> +			reg = <0x0 0x48090000 0x0 0x1000>;
> +			msi-controller;
> +		};
>  	};
>  
>  	psci {
> @@ -1130,6 +1139,41 @@ stmmac_axi_config_1: stmmac-axi-config {
>  					snps,wr_osr_lmt = <0x7>;
>  				};
>  			};
> +
> +			pcie_rc: pcie@48400000 {
> +				compatible = "st,stm32mp25-pcie-rc";
> +				device_type = "pci";
> +				reg = <0x48400000 0x400000>,
> +				      <0x10000000 0x10000>;
> +				reg-names = "dbi", "config";
> +				#interrupt-cells = <1>;
> +				interrupt-map-mask = <0 0 0 7>;
> +				interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
> +						<0 0 0 2 &intc 0 0 GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
> +						<0 0 0 3 &intc 0 0 GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
> +						<0 0 0 4 &intc 0 0 GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				ranges = <0x01000000 0x0 0x00000000 0x10010000 0x0 0x10000>,
> +					 <0x02000000 0x0 0x10020000 0x10020000 0x0 0x7fe0000>,
> +					 <0x42000000 0x0 0x18000000 0x18000000 0x0 0x8000000>;
> +				dma-ranges = <0x42000000 0x0 0x80000000 0x80000000 0x0 0x80000000>;
> +				clocks = <&rcc CK_BUS_PCIE>;
> +				resets = <&rcc PCIE_R>;
> +				msi-parent = <&v2m0>;
> +				access-controllers = <&rifsc 68>;
> +				power-domains = <&CLUSTER_PD>;
> +				status = "disabled";
> +
> +				pcie@0,0 {
> +					device_type = "pci";
> +					reg = <0x0 0x0 0x0 0x0 0x0>;
> +					phys = <&combophy PHY_TYPE_PCIE>;
> +					#address-cells = <3>;
> +					#size-cells = <2>;
> +					ranges;
> +				};
> +			};
>  		};
>  
>  		bsec: efuse@44000000 {
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

