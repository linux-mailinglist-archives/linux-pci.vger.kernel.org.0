Return-Path: <linux-pci+bounces-9327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED80B91892D
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 19:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2AB8282D96
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 17:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D5C18FC95;
	Wed, 26 Jun 2024 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S49eW3O4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B12913AA4C;
	Wed, 26 Jun 2024 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719421881; cv=none; b=oQqXPHT3Lyv9coJY6XhWiOO4h2XX23Dv/15uphjDSSwOPsN1NmybtpW+MrZ1VQzH3zgl7SZ6cCY06plvgQMdDcYVtnviOSXCrPuGHmb6cHRt4p5vfZWzQC2DHRaxoHy09W5qhdWh6lGamuZL26XXa09mW2p4uOWcYk+EioFZxYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719421881; c=relaxed/simple;
	bh=VETDa7WGPPP0WRkkjP/Fo+N4DNsrXTJSc+J9H4gVkbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsWigSDN19URFVnlrGhdSnO3oSuAgl3nr79Er56y8aQmrNQcNyfkpDncuMdRD6qT7JNcSmnzywNA/3FqdTMTpUuudTcpuIOsK7rLa3RKsUPWusgaXw33S37sJLQY32f4rhLvrNEGtyZVaZBIvHTRDl3c2aCvA9YgJqoXoVCWOhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S49eW3O4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32E3C4AF09;
	Wed, 26 Jun 2024 17:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719421881;
	bh=VETDa7WGPPP0WRkkjP/Fo+N4DNsrXTJSc+J9H4gVkbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S49eW3O4mxG51Uk8cltbhcBzHUi6HSxpdpSaP6HqrPV2X3QIzpe0n24OsFa++bM4S
	 aVL05SNzpOS/QQu8B91fv8OP0DxMrbeNesRJ+SrVkerf6QPmtYlHKFWKktZUqcmA0M
	 HdY7HJjMTLDNG4vAPR6QHTrDlQXlTY5KeOB7r6w+hpereXaC5rhrNDEPn23USTqdOJ
	 /bNxoy+8ajurCwE02jNqIQAomfueuXXEQtFtEJqK1+R0OaM6/9sQtzan7BCUSay9jU
	 gITnnalinQbTLg1r7Cvboj3ANkf8nY2XjOxI9DGocS0KC8iJ+Bqw70PZIqRg5dzQK8
	 uei85S1kaz2Qg==
Date: Wed, 26 Jun 2024 12:11:11 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Jingoo Han <jingoohan1@gmail.com>, quic_vbadigan@quicinc.com, quic_skananth@quicinc.com, 
	quic_nitegupt@quicinc.com, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/7] arm64: dts: qcom: qcs6490-rb3gen2: Add qps615
 node
Message-ID: <7ntqpz2saju2wwgndnc5sykibrfiystqh4e7fabfwkkcyko5tp@vhorsxlyvgf6>
References: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
 <20240626-qps615-v1-2-2ade7bd91e02@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626-qps615-v1-2-2ade7bd91e02@quicinc.com>

On Wed, Jun 26, 2024 at 06:07:50PM GMT, Krishna chaitanya chundru wrote:
> QPS615 switch power is controlled by GPIO's. Once the GPIO's are
> enabled, switch power will be on.
> 
> Make all GPIO's as fixed regulators and inter link them so that
> enabling the regulator will enable power to the switch by enabling
> GPIO's.
> 
> Enable i2c0 which is required to configure the switch.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 55 ++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index a085ff5b5fb2..5b453896a6c9 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -511,6 +511,61 @@ vreg_bob_3p296: bob {
>  			regulator-max-microvolt = <3960000>;
>  		};
>  	};
> +
> +	qps615_0p9_vreg: qps615-0p9-vreg {

Keep nodes sorted by address, node name, then label.

Perhaps name the nodes "regulator-<name>" to group static regulators
together.

> +		compatible = "regulator-fixed";
> +		regulator-name = "qps615_0p9_vreg";

Is this the name used for the output of the regulator in the schematics?

> +		gpio = <&pm8350c_gpios 2 0>;

Replace that 0 with GPIO_ACTIVE_HIGH.

> +		regulator-min-microvolt = <1000000>;
> +		regulator-max-microvolt = <1000000>;
> +		enable-active-high;
> +		regulator-enable-ramp-delay = <4300>;
> +	};
> +
> +	qps615_1p8_vreg: qps615-1p8-vreg {
> +		compatible = "regulator-fixed";
> +		regulator-name = "qps615_1p8_vreg";
> +		gpio = <&pm8350c_gpios 3 0>;
> +		vin-supply = <&qps615_0p9_vreg>;

This makes me curious, &qps615_0p9_vreg provides 1V, which we feed into
another regulator (which typically would be an LDO) to provide 1.8V...

> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		enable-active-high;
> +		regulator-enable-ramp-delay = <10000>;
> +	};
> +
> +	qps615_rsex_vreg: qps615-rsex-vreg {
> +		compatible = "regulator-fixed";
> +		regulator-name = "qps615_rsex_vreg";
> +		gpio = <&pm8350c_gpios 1 0>;
> +		vin-supply = <&qps615_1p8_vreg>;

...which is then fed to another LDO(?) which provides 1.8V.

Please double check the schematics and make sure this represents what's
on the board. Feel free to ping me offline and I can help review the
schematics.

> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		enable-active-high;
> +		regulator-enable-ramp-delay = <10000>;
> +	};
> +};
> +
> +&i2c0 {
> +	clock-frequency = <100000>;
> +	status = "okay";
> +};
> +
> +&pcie1 {
> +	pcie@0 {
> +		device_type = "pci";
> +		reg = <0x0 0x0 0x0 0x0 0x0>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +
> +		bus-range = <0x01 0xff>;
> +
> +		qps615@0 {
> +			compatible = "pci1179,0623";
> +			reg = <0x1000 0x0 0x0 0x0 0x0>;
> +			vdda-supply = <&qps615_rsex_vreg>;

I presume you didn't "make qcom/qcs6490-rb3gen2.dtb CHECK_DTBS=1" this,
as "vdda-supply" is not listed as a valid supply in the binding (also
the driver is looking for vdd-supply...)

Regards,
Bjorn

> +			switch-i2c-cntrl = <&i2c0>;
> +		};
> +	};
>  };
>  
>  &gcc {
> 
> -- 
> 2.42.0
> 

