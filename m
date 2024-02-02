Return-Path: <linux-pci+bounces-3034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A1984754B
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 17:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EDC7B2D239
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 16:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBC2149015;
	Fri,  2 Feb 2024 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAM6fhUA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E9713E228;
	Fri,  2 Feb 2024 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892453; cv=none; b=kHON6Ct+maUcSIwM/dKQN0ZZHER8GrLLEpJry69C+s5Y0HUnpzfkosvGvgs58GhjNaI9hHMMPHAL63+DJIv4xzDRTP/yu8qkUDkZsa4Smf7biP3Pld1KIozbK9wtXadA4oNpzn5BT0EARH9cqLZqJ6GylmQ8s22k52yd+42Kp1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892453; c=relaxed/simple;
	bh=aPP8zdITaRAZSTngrnQUULuGDL50v7spoqetUBvyE1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EF6dqxf2SCVj4aedwO9y+r4iD+p0EE7wXez7lEne+1PwyYMfFg7wRKP577HrD4k8YiYKBjCwOswPui7+mDr2aTa3tnC2j+luvywvaSclxdwEa7jxADSZlC9p0gF2CJg/oa3PsmpGOID+4heIJ2LZSkqz/IJ0/1fb3TU8Txph1Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAM6fhUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA379C433F1;
	Fri,  2 Feb 2024 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706892453;
	bh=aPP8zdITaRAZSTngrnQUULuGDL50v7spoqetUBvyE1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MAM6fhUAoxso/2VI8dzxVfOIaKPWWXeoBw3V1+MWLiIMaxJ77fMBxgxSEVhPksnyQ
	 GZqAdczhIWpkRMNOTqnjPmsJnUWTdNHnI6HKn7C+stsTb7KDTsTfbbaz6W903+1Tsn
	 BHU7gWEIRqomnI1YQZXRPJ1xy0GyAYZ+AO9HwGT60xUsxjYp1gxnMbgrFtGtt7Radd
	 +GfD6kiv6UywsOBvqho/+jDNSkISh621Zk6HQWOZUxjFtIEAavmI3xRRsOp04LQdy3
	 /n0KXeg7bdyxP0fQUNp3TdfviLTdYvf/qeLR4zPYdivQP5xp4ZAU7W0B+kJVDpGKsA
	 4lZCG5q93GrbA==
Date: Fri, 2 Feb 2024 10:47:29 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pci@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC 2/9] arm64: dts: qcom: qrb5165-rb5: model the PMU of the
 QCA6391
Message-ID: <zyiimnkpifo3mb54e2oyqmw6xcjtzkwodxuq5y7vac3slizfkm@mtiijlxeahuk>
References: <20240201155532.49707-1-brgl@bgdev.pl>
 <20240201155532.49707-3-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201155532.49707-3-brgl@bgdev.pl>

On Thu, Feb 01, 2024 at 04:55:25PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a node for the PMU module of the QCA6391 present on the RB5 board.
> Assign its LDO power outputs to the existing Bluetooth module. Add a
> node for the PCIe port to sm8250.dtsi and define the WLAN node on it in
> the board's .dts and also make it consume the power outputs of the PMU.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 128 +++++++++++++++++++++--
>  arch/arm64/boot/dts/qcom/sm8250.dtsi     |  10 ++
>  2 files changed, 127 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> index cd0db4f31d4a..fab5bebafbad 100644
> --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> @@ -108,6 +108,87 @@ lt9611_3v3: lt9611-3v3 {
>  		regulator-always-on;
>  	};
>  
> +	qca6390_pmu: pmu@0 {

The node doesn't have an address, so why does it have a unit address?
Also, the node isn't referenced, so please skip the label.

> +		compatible = "qcom,qca6390-pmu";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_en_state>, <&wlan_en_state>;
> +
> +		vddaon-supply = <&vreg_s6a_0p95>;
> +		vddpmu-supply = <&vreg_s2f_0p95>;
> +		vddrfa1-supply = <&vreg_s2f_0p95>;
> +		vddrfa2-supply = <&vreg_s8c_1p3>;
> +		vddrfa3-supply = <&vreg_s5a_1p9>;
> +		vddpcie1-supply = <&vreg_s8c_1p3>;
> +		vddpcie2-supply = <&vreg_s5a_1p9>;
> +		vddio-supply = <&vreg_s4a_1p8>;

So, after studying the datasheet for this. The names of the pins seems
to come from the existing binding(s). As you're introducing a new
binding (and driver) for qcom,qca6390-pmu, please use the pad names from
qca6390.

> +
> +		wlan-enable-gpios = <&tlmm 20 GPIO_ACTIVE_HIGH>;
> +		bt-enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
> +
> +		regulators {
> +			vreg_pmu_rfa_cmn: ldo0 {
> +				regulator-name = "vreg_pmu_rfa_cmn";
> +				regulator-min-microvolt = <760000>;
> +				regulator-max-microvolt = <840000>;

The min/max operating range of the regulator is something we provide in
the implementation, in DeviceTree you should specify the expected
operating voltage. Based on the TYP value this should be
regulator-min-microvolt = regulator-max-microvolt = 0.8V.

> +			};
> +
> +			vreg_pmu_aon_0p59: ldo1 {
> +				regulator-name = "vreg_pmu_aon_0p59";
> +				regulator-min-microvolt = <540000>;
> +				regulator-max-microvolt = <840000>;
> +			};
[..]
> @@ -1303,6 +1402,14 @@ sdc2_card_det_n: sd-card-det-n-state {
>  		function = "gpio";
>  		bias-pull-up;
>  	};
> +
> +	wlan_en_state: wlan-default-state {
> +		pins = "gpio20";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		output-low;

Please omit output-low here.

> +		bias-pull-up;

Why do you drive it low and pull it high? bias-disable sounds more
appropriate.

Regards,
Bjorn

> +	};
>  };
>  
>  &uart6 {
> @@ -1311,17 +1418,16 @@ &uart6 {
>  	bluetooth {
>  		compatible = "qcom,qca6390-bt";
>  
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&bt_en_state>;
> -
> -		enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
> -
> -		vddio-supply = <&vreg_s4a_1p8>;
> -		vddpmu-supply = <&vreg_s2f_0p95>;
> -		vddaon-supply = <&vreg_s6a_0p95>;
> -		vddrfa0p9-supply = <&vreg_s2f_0p95>;
> -		vddrfa1p3-supply = <&vreg_s8c_1p3>;
> -		vddrfa1p9-supply = <&vreg_s5a_1p9>;
> +		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
> +		vddaon-supply = <&vreg_pmu_aon_0p59>;
> +		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
> +		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
> +		vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
> +		vddrfa0-supply = <&vreg_pmu_rfa_0p8>;
> +		vddrfa1-supply = <&vreg_pmu_rfa_1p2>;
> +		vddrfa2-supply = <&vreg_pmu_rfa_1p7>;
> +		vddpcie0-supply = <&vreg_pmu_pcie_0p9>;
> +		vddpcie1-supply = <&vreg_pmu_pcie_1p8>;
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 4d849e98bf9b..7cd21d4e7278 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -2203,6 +2203,16 @@ pcie0: pcie@1c00000 {
>  			dma-coherent;
>  
>  			status = "disabled";
> +
> +			pcieport0: pcie@0 {
> +				device_type = "pci";
> +				reg = <0x0 0x0 0x0 0x0 0x0>;
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				ranges;
> +
> +				bus-range = <0x01 0xff>;
> +			};
>  		};
>  
>  		pcie0_phy: phy@1c06000 {
> -- 
> 2.40.1
> 

