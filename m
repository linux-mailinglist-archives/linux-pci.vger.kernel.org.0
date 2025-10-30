Return-Path: <linux-pci+bounces-39832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1D7C21256
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 17:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504593BF9A5
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 16:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6533655FA;
	Thu, 30 Oct 2025 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NakRxAgf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A9C279329;
	Thu, 30 Oct 2025 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841324; cv=none; b=jz6YNwWu68IwLfqOtOl66/Wt9kNHGFdEf45QaySFpx/KizpouswDGy0419yPT8s8PZvXDaDfAO4zNt/ql8JpLsP2WDUfJKuRWdiVEE1MThTzBhmxlEqYGIOAGlQ/mq5V155WMI7P+DLLSM4khIYEBnNP9yaR6ylRQ7JFoOkRe0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841324; c=relaxed/simple;
	bh=F+ThUuZwTPoqOt/a8AaNAZXa9DD3eH4/OEJNQKNPueM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPtFH8IxtUFUQEUmMWwGicKpjOXjHQToM0qe13NjsE28LKCn3YYU+Txg169sgYYeYOl+VFzRoCFnk9Cy/EjWHPAqXnhM14nKkCl/xzVjNge2PMvDi9DUFYmM19dxrfTxmAGR2OVT+KMVVgmcUtWHurjVZO1yCpS+f6QGRWkzjEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NakRxAgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47798C4CEF1;
	Thu, 30 Oct 2025 16:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761841323;
	bh=F+ThUuZwTPoqOt/a8AaNAZXa9DD3eH4/OEJNQKNPueM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NakRxAgf5j+AWB35aj0q8wYpPF+yCxnIwpGI2id4YibssjyXZWke4BL9F6dtizBqQ
	 qIniLzOK/Wd7ucdaHgZyZLTD77gLzl0O8eSGDEW2dbkhlNseTkDJ6iNZYqv8iTiYJ1
	 8OSb/667+qkK60On9KiL+um9H7xAasMWdKBvisHlSFKtFCEd5wyez4vKvYodGqolHa
	 ovMHAzka3vDfe3jXQldAjcnqFgr5ygOKGcX0Z2LUxDWTDKhP0YMpw4g56cKwU4xLi4
	 9ZCwlj9jwO9tYT9LKEDdKVyAWWWpQvYYBXSdimAyOjYmndLfb29ADBaty3bcCDVJ3r
	 gzsjIXXopBw8g==
Date: Thu, 30 Oct 2025 11:25:11 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org, 
	kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, 
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: Add PCIe 3 regulators for
 HAMOA-IOT-EVK board
Message-ID: <5rpmcr23gsoiefmgxaci3fcc5yf3iwo4pbgywz6wuzljcnuxxe@pjn3g7dizim4>
References: <20251030084804.1682744-1-ziyue.zhang@oss.qualcomm.com>
 <20251030084804.1682744-5-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251030084804.1682744-5-ziyue.zhang@oss.qualcomm.com>

On Thu, Oct 30, 2025 at 04:48:04PM +0800, Ziyue Zhang wrote:
> HAMOA-IOT-EVK board includes a PCIe3 controller and x8 slot that require
> proper power rail and control signal configuration. This update adds
> `vddpe-3v3-supply` and `regulator-pcie-12v` to provide 3.3V to the PHY
> and 12V to the slot for external devices.
> 
> It also introduces PM GPIOs to manage power enable and reset signals,
> ensuring stable power sequencing and reliable PCIe3 operation.

I'm afraid I don't understand this paragraph. In the first paragraph you
establish that you have PCIe3, there is a x8 slot, and there's 3.3V and
12V supplies.

But where in the patch do you establish "reset signals" and "ensure
stable power sequencing"?

> 
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 79 ++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> index 24c2dcef0ba8..0984a6eed226 100644
> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> @@ -414,6 +414,48 @@ vreg_wwan: regulator-wwan {
>  		regulator-boot-on;
>  	};
>  
> +	vreg_pcie_12v: regulator-pcie-12v {

https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-nodes

2. Nodes without unit addresses shall be ordered alpha-numerically by
   the node name. For a few node types, they can be ordered by the main
   property, e.g. pin configuration states ordered by value of “pins”
   property.

Regards,
Bjorn

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
> +};
> +
>  	sound {
>  		compatible = "qcom,x1e80100-sndcard";
>  		model = "X1E80100-EVK";
> @@ -844,6 +886,12 @@ &mdss_dp3_phy {
>  	status = "okay";
>  };
>  
> +&pcie3_port {
> +	vpcie12v-supply = <&vreg_pcie_12v>;
> +	vpcie3v3-supply = <&vreg_pcie_3v3>;
> +	vpcie3v3aux-supply = <&vreg_pcie_3v3_aux>;
> +};
> +
>  &pcie5 {
>  	vddpe-3v3-supply = <&vreg_wwan>;
>  };
> @@ -872,6 +920,17 @@ usb0_3p3_reg_en: usb0-3p3-reg-en-state {
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
> @@ -883,6 +942,26 @@ usb0_1p8_reg_en: usb0-1p8-reg-en-state {
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

