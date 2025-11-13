Return-Path: <linux-pci+bounces-41051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C45C55B40
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 05:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389793B4B30
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 04:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D3B304BDC;
	Thu, 13 Nov 2025 04:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glxU1Wrf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D128287246;
	Thu, 13 Nov 2025 04:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763009486; cv=none; b=PqRWM08swseUxv4BUfjPfjaJ60YV7z+MVtmX78sDksazxQMBlHlhmp50U25qVPyLrwEQz+Hlw0GCdfJgMwLZES6VS2pV214eE8HEjUeczjtNbrMkLd1d1FyOwGRIB6sTG5xoBoz8EOfu5JMYU0AT5aF/piA+iBiTqMI1QjhbqHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763009486; c=relaxed/simple;
	bh=u1EUAM6v70Id6ffUyitEzHKUzjJqyDleo4+wyX4xB1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmQXeN9IqqISaO+qkLNl3GRArViK4wxiDNu4Ztp8Mz73LJ47BqZwBJ5FdluknVv3z/YnEDm81u/lSmRy8WM4CVhWaTuudRhziJGMumRarMxxkeEAZwPg808HY2LDr5ZDLzFAJ+9kDY8W5P/B0ncMCIdun4gyk8iXqWXNKI1Pzo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glxU1Wrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE866C4CEF5;
	Thu, 13 Nov 2025 04:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763009486;
	bh=u1EUAM6v70Id6ffUyitEzHKUzjJqyDleo4+wyX4xB1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=glxU1WrfDP8k7P6d3p7QCqNLd/d0t4Ua5Ee2ES1XSQCxN18wR1pQ9PmT6R34ZsMIw
	 98yDh/372bYdTHroq4t9dCea9YG1KlGigje2VMM79I5aPcbW87MGqfy2zdB5EuVoNC
	 Y5NbC56Z1LU/eJzkxVYbsr2HRFDUMxcSCBK1xP5OYd0Z+JVPoIBHVOpv8COG/H/5GX
	 yVVm6/g2ol54DCjzv/CvJz07pBN/iE4jwdOef808YZUHqn2vmW3M3/gjka3QWCM29G
	 7mRdDZjQGYH/cpoRKXYI91HFubJxa7/JJf5pQnEUOw/iw2iaVTifsX2swIWmJGOQ24
	 fgRgHp7z08NZQ==
Date: Thu, 13 Nov 2025 10:21:06 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org, 
	kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, 
	krishna.chundru@oss.qualcomm.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: Add PCIe3 and PCIe5 support for
 HAMOA-IOT-SOM platform
Message-ID: <nkcxf3gnpvjilvw36f65e3olynta2jebki2rkc4tmka7poux6j@g6xksv3aobpp>
References: <20251112090316.936187-1-ziyue.zhang@oss.qualcomm.com>
 <20251112090316.936187-2-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251112090316.936187-2-ziyue.zhang@oss.qualcomm.com>

On Wed, Nov 12, 2025 at 05:03:15PM +0800, Ziyue Zhang wrote:
> HAMOA IoT SOM requires PCIe3 and PCIe5 connectivity for SATA controller
> and SDX65.
> Add the required sideband signals (PERST#, WAKE#, CLKREQ#), pinctrl states
> and power supply properties in the device tree, which PCIe3 and PCIe5
> require.
> 
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 79 +++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
> index 4de7c0abb25a..abb8ea323d78 100644
> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
> @@ -390,6 +390,22 @@ &gpu_zap_shader {
>  	firmware-name = "qcom/x1e80100/gen70500_zap.mbn";
>  };
>  
> +&pcie3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie3_default>;
> +	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;

Can you move these GPIOs and PHY (in SoC dtsi) properties to Root Port node?

Specifying Root Port properties in controller node is deprecated.

- Mani

> +
> +	status = "okay";
> +};
> +
> +&pcie3_phy {
> +	vdda-phy-supply = <&vreg_l3c_0p8>;
> +	vdda-pll-supply = <&vreg_l3e_1p2>;
> +
> +	status = "okay";
> +};
> +
>  &pcie4 {
>  	perst-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
>  	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
> @@ -407,6 +423,23 @@ &pcie4_phy {
>  	status = "okay";
>  };
>  
> +&pcie5 {
> +	perst-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
> +
> +	pinctrl-0 = <&pcie5_default>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pcie5_phy {
> +	vdda-phy-supply = <&vreg_l3i_0p8>;
> +	vdda-pll-supply = <&vreg_l3e_1p2>;
> +
> +	status = "okay";
> +};
> +
>  &pcie6a {
>  	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
>  	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
> @@ -454,6 +487,29 @@ &tlmm {
>  	gpio-reserved-ranges = <34 2>, /* TPM LP & INT */
>  			       <44 4>; /* SPI (TPM) */
>  
> +	pcie3_default: pcie3-default-state {
> +		clkreq-n-pins {
> +			pins = "gpio144";
> +			function = "pcie3_clk";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-n-pins {
> +			pins = "gpio143";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		wake-n-pins {
> +			pins = "gpio145";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +
>  	pcie4_default: pcie4-default-state {
>  		clkreq-n-pins {
>  			pins = "gpio147";
> @@ -477,6 +533,29 @@ wake-n-pins {
>  		};
>  	};
>  
> +	pcie5_default: pcie5-default-state {
> +		clkreq-n-pins {
> +			pins = "gpio150";
> +			function = "pcie5_clk";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-n-pins {
> +			pins = "gpio149";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		wake-n-pins {
> +			pins = "gpio151";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +
>  	pcie6a_default: pcie6a-default-state {
>  		clkreq-n-pins {
>  			pins = "gpio153";
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

