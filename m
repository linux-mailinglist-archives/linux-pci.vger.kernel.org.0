Return-Path: <linux-pci+bounces-41006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E63E2C53729
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 17:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806D3420879
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 16:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CBA33AD97;
	Wed, 12 Nov 2025 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Umd7piN3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FE02550AF;
	Wed, 12 Nov 2025 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964982; cv=none; b=dHZsgFciV1oq73Wb+7di0ewfHM4Kk9m74/BnnvWCSY5m95m8xHHtSKtoaTjw4LORfZ0e/tzQtqkPg3wgTtzpeS19FvQ447hMV2ATIeE3gRBUHD5i0QuVLQoDedRnXf7uwseHXp+3Zp3HrBxynEYRpP7C5c9Rm++LQ3lHbfUHjGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964982; c=relaxed/simple;
	bh=DP5D2zjQPq84AdGMdpDugauF+Uw5VjnEZ/jSz0bVjQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPA3xYsQ/qhnulSL7SrKJnZINOAfLWzqnFUusD2My+H3PfMj061FdAoKHuopk9MvyCES7OIhOwTdCTuWsjJBGiHDasnEkSFyvi3vhVxgBnX1MRFySJNgjbW8qeBieI2hhtG86sbQv/xYR+IQek3UdlGh8jY/fsLlL+w41k7LJys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Umd7piN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F77C4CEF1;
	Wed, 12 Nov 2025 16:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762964981;
	bh=DP5D2zjQPq84AdGMdpDugauF+Uw5VjnEZ/jSz0bVjQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Umd7piN3+04i8gvUPVvGaPzCgGl9OYviITEvXRjtjkY1zWB08XfPwM596K5Xx+yTT
	 6jlBuI7jmtuhSTV7HXyJghjYGq5GvSUuhsHoVQf8x7f6Efsa18iC+7AbtoXVU0DQ6u
	 7BUti4EwiDji9mD8ATudxo8+lYjVmK1qJZxU6Ok6WQAjwL78NTMNsJg58rwKM9fp0X
	 2n1VDrUQ4c6yPc2d25GV8oAYeb+103t3lBtA8GMELK9WhJ+C8+NnE2+2IHyfEW8YMy
	 3I20JVe9pmiZnDbpF0qEFXF0ZvGvKvTeFJmY/VBdros8N5KrXxzSxt0pI09T3CsiQG
	 aywUJlcTIjY8A==
Date: Wed, 12 Nov 2025 10:33:58 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org, 
	kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, 
	krishna.chundru@oss.qualcomm.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add PCIe3 and PCIe5 regulators
 for HAMAO-IOT-EVK board
Message-ID: <6iuuosajwue35goout6ohpdbmdoahc6f3gxicliiin6wq3ggjh@m7nkqnsxq63h>
References: <20251112090316.936187-1-ziyue.zhang@oss.qualcomm.com>
 <20251112090316.936187-3-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112090316.936187-3-ziyue.zhang@oss.qualcomm.com>

On Wed, Nov 12, 2025 at 05:03:16PM +0800, Ziyue Zhang wrote:
> HAMAO IoT EVK uses PCIe5 to connect an SDX65 module for WWAN functionality
> and PCIe3 to connect a SATA controller. These interfaces require multiple
> voltage rails: PCIe5 needs 3.3V supplied by vreg_wwan, while PCIe3 requires
> 12V, 3.3V, and 3.3V AUX rails, controlled via PMIC GPIOs.
> 

I love it! Thank you for the clear description.

Regards,
Bjorn

> Add the required fixed regulators with related pin configuration, and
> connect them to the PCIe3 and PCIe5 ports to ensure proper power for the
> SDX65 module and SATA controller.
> 
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 83 ++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> index 36dd6599402b..ac17f7cb8b3d 100644
> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> @@ -199,6 +199,48 @@ vreg_nvme: regulator-nvme {
>  		regulator-boot-on;
>  	};
>  
> +	vreg_pcie_12v: regulator-pcie-12v {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_PCIE_12V";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +
> +		gpio = <&pm8550ve_8_gpios 8 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&pcie_x8_12v>;
> +		pinctrl-names = "default";
> +	};
> +
> +	vreg_pcie_3v3: regulator-pcie-3v3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_PCIE_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&pmc8380_3_gpios 6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&pm_sde7_main_3p3_en>;
> +		pinctrl-names = "default";
> +	};
> +
> +	vreg_pcie_3v3_aux: regulator-pcie-3v3-aux {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_PCIE_3P3_AUX";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&pmc8380_3_gpios 8 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&pm_sde7_aux_3p3_en>;
> +		pinctrl-names = "default";
> +	};
> +
>  	/* Left unused as the retimer is not used on this board. */
>  	vreg_rtmr0_1p15: regulator-rtmr0-1p15 {
>  		compatible = "regulator-fixed";
> @@ -844,6 +886,16 @@ &mdss_dp3_phy {
>  	status = "okay";
>  };
>  
> +&pcie3_port {
> +	vpcie12v-supply = <&vreg_pcie_12v>;
> +	vpcie3v3-supply = <&vreg_pcie_3v3>;
> +	vpcie3v3aux-supply = <&vreg_pcie_3v3_aux>;
> +};
> +
> +&pcie5 {
> +	vddpe-3v3-supply = <&vreg_wwan>;
> +};
> +
>  &pcie6a {
>  	vddpe-3v3-supply = <&vreg_nvme>;
>  };
> @@ -868,6 +920,17 @@ usb0_3p3_reg_en: usb0-3p3-reg-en-state {
>  	};
>  };
>  
> +&pm8550ve_8_gpios {
> +	pcie_x8_12v: pcie-12v-default-state {
> +		pins = "gpio8";
> +		function = "normal";
> +		output-enable;
> +		output-high;
> +		bias-pull-down;
> +		power-source = <0>;
> +	};
> +};
> +
>  &pm8550ve_9_gpios {
>  	usb0_1p8_reg_en: usb0-1p8-reg-en-state {
>  		pins = "gpio8";
> @@ -879,6 +942,26 @@ usb0_1p8_reg_en: usb0-1p8-reg-en-state {
>  	};
>  };
>  
> +&pmc8380_3_gpios {
> +	pm_sde7_aux_3p3_en: pcie-aux-3p3-default-state {
> +		pins = "gpio8";
> +		function = "normal";
> +		output-enable;
> +		output-high;
> +		bias-pull-down;
> +		power-source = <0>;
> +	};
> +
> +	pm_sde7_main_3p3_en: pcie-main-3p3-default-state {
> +		pins = "gpio6";
> +		function = "normal";
> +		output-enable;
> +		output-high;
> +		bias-pull-down;
> +		power-source = <0>;
> +	};
> +};
> +
>  &pmc8380_5_gpios {
>  	usb0_pwr_1p15_reg_en: usb0-pwr-1p15-reg-en-state {
>  		pins = "gpio8";
> -- 
> 2.34.1
> 

