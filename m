Return-Path: <linux-pci+bounces-2973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459CD846700
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 05:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6044F1C23ADE
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 04:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B25E56B;
	Fri,  2 Feb 2024 04:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvkWrecU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4711BEAF2;
	Fri,  2 Feb 2024 04:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706848475; cv=none; b=jDivbTPgzA/TjRldERgvIVjf0qeU/2oY84IEKyMBPmHKHlGz0/rFnYG/PQ8ktxVd1K9EM+aUEM0L43Vq8dHOm11hhe6TyXcRyTw7MRADe37zc4ThJardCjP6oMrg4m4FfejWjabUOIeKNlS39546X1gfwQ8Ewb7Olp9HbNwV9Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706848475; c=relaxed/simple;
	bh=satbLNeZz+QWwEIu5LrwtxRMwFvB1z9KyJTB07xtAgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTCMZNF4g/GW1mL/ViQaPu3bwKsJYUPPIPJSdVxALRAQbwLal8fWcMMi0FcloT8k8mhDr7QNljzJqK7S8fXQRVY/l8iqsJJ5qAYkIxqcu5vvURcwawEaQoTSGK7f9KKRJ7WGdd0j1uHniRzrE8rIuLc+p3fILr5b9soZYE/cJ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvkWrecU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAECDC433F1;
	Fri,  2 Feb 2024 04:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706848474;
	bh=satbLNeZz+QWwEIu5LrwtxRMwFvB1z9KyJTB07xtAgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvkWrecULFI83GjFioZwqm5vQ1TbPIlFqnepDB4YbeJudyH6HH4//FFf42DN2DhqN
	 E16V9EUtLRMVBl8NOkxZ81MzljTO1myTN++gHrA1u/ncJQrrsTYai2Z0yN6loVzx8R
	 YzaOEtjrFjoeKvD3Rod1kVYDB42d8hn/qXdHKcxiLjZMIxYFvBl9PrvvUTdKgKX3yS
	 F/R/Vm0ED29YaHpwNvHFN6YmiDuZZkzg4e5SmbaTR/6JhSB25QiEmCuzGLbJXjl+1b
	 3mZeuzrQYKvxGZJ+kxcMOGSdaDud/tKKepoSxycP+b+IEMVxgwfjZThKoOxSCOdE3V
	 OLmt+gdb4LgNQ==
Date: Thu, 1 Feb 2024 22:34:30 -0600
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
Message-ID: <5lirm5mnf7yqbripue5nyqu6ej54sx4rtmgmyqjrqanabsriyp@2pjiv5xbmxpk>
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
> +
> +		wlan-enable-gpios = <&tlmm 20 GPIO_ACTIVE_HIGH>;
> +		bt-enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
> +
> +		regulators {
> +			vreg_pmu_rfa_cmn: ldo0 {
> +				regulator-name = "vreg_pmu_rfa_cmn";
> +				regulator-min-microvolt = <760000>;
> +				regulator-max-microvolt = <840000>;

I'm still not convinced that the PMU has a set of LDOs, and looking at
your implementation you neither register these with the regulator
framework, nor provide any means of controlling the state or voltage of
these "regulators".

[..]
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

As I asked before, why does bluetooth suddenly care about PCIe supplies?

Regards,
Bjorn

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

