Return-Path: <linux-pci+bounces-17104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B5D9D3503
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 09:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F241F21FC3
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 08:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA31D15D5B8;
	Wed, 20 Nov 2024 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBFXlqxC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D64B15B551;
	Wed, 20 Nov 2024 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089967; cv=none; b=QymdmHB4MUoGXGz0Jw4ibTKYJ67LLZjCHEFUs85owztXyYVR+TdrLXxh+Tsnj313OTxqS30X9mJ3wOYwVzHWDum2uze0i9mCK+GbIvYj8egBb98+PKmEmqW9evkVUf+7Kd8BzDuXzWNhnjVmh08LWVCaczeDYkA+IrdCjsHOkhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089967; c=relaxed/simple;
	bh=4XpgWRwxRQX8N4sCs+G1yqWwX0N+g8TGTG4+ywFNqTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJA12jfFhKGNfH/02054WCZq4fbNkjf4Xw2eucHksQ0/p24bZP4SktyRIumezIkc5eiQZf+x/hiqOMY7UnTvxUvaoSzy8nu5N2xFzPBbkT8p0mz0uqdjsxkWZ2OYlPgrW7k9oIe0CMV9AoSE7KVCCYnPxVv206DBgxNcZEsLJj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBFXlqxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4273AC4CECD;
	Wed, 20 Nov 2024 08:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732089967;
	bh=4XpgWRwxRQX8N4sCs+G1yqWwX0N+g8TGTG4+ywFNqTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QBFXlqxC4rM78DDgViewI8/dKlQaxXqNEHoFtPKzouuOYFG7SkBH7iBRBo5wYmTsJ
	 /UbMoKqzxONL293iN90t76vu5Q8XJTwtaMZKf4bTZ55d9DtZxyJcW4eCQJy925ZVc0
	 gBgYF37HE3JAEZe2cPTtpFOYEnyJYm0AjFqnQQ+PZbRAoYryhlgXFrsY7lHqa45lqN
	 7ga4XGm8PgZJVaQSn/ufDk9z/+G+h4Bp0roZU2mkaELv6MsTyk+QdUxnXVFgLUx4xL
	 UZGqMMdGJMWzuK4mYcH5CpibI/anrEB5Zkmied7DiK+Key5iki/TV8GV2jiwJySj6i
	 RHHcBF7AIAL6w==
Date: Wed, 20 Nov 2024 09:06:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: andersson@kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] arm64: dts: qcom: qcs6490-rb3gen2: Add node for
 qps615
Message-ID: <ngjwfsymvo2sucvzyoanhezjisjqgfgnlixrzjgxjzlfchni7y@lvgrfslpnqmo>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-2-29a1e98aa2b0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241112-qps615_pwr-v3-2-29a1e98aa2b0@quicinc.com>

On Tue, Nov 12, 2024 at 08:31:34PM +0530, Krishna chaitanya chundru wrote:
> Add QPS615 PCIe switch node which has 3 downstream ports and in one
> downstream port two embedded ethernet devices are present.
> 
> Power to the QPS615 is supplied through two LDO regulators, controlled
> by two GPIOs, these are added as fixed regulators. And the QPS615 is
> configured through i2c.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 115 +++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
>  2 files changed, 116 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 0d45662b8028..0e890841b600 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -202,6 +202,30 @@ vph_pwr: vph-pwr-regulator {
>  		regulator-min-microvolt = <3700000>;
>  		regulator-max-microvolt = <3700000>;
>  	};
> +
> +	vdd_ntn_0p9: regulator-vdd-ntn-0p9 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDD_NTN_0P9";
> +		gpio = <&pm8350c_gpios 2 GPIO_ACTIVE_HIGH>;
> +		regulator-min-microvolt = <899400>;
> +		regulator-max-microvolt = <899400>;
> +		enable-active-high;
> +		pinctrl-0 = <&ntn_0p9_en>;
> +		pinctrl-names = "default";
> +		regulator-enable-ramp-delay = <4300>;
> +	};
> +
> +	vdd_ntn_1p8: regulator-vdd-ntn-1p8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDD_NTN_1P8";
> +		gpio = <&pm8350c_gpios 3 GPIO_ACTIVE_HIGH>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		enable-active-high;
> +		pinctrl-0 = <&ntn_1p8_en>;
> +		pinctrl-names = "default";
> +		regulator-enable-ramp-delay = <10000>;
> +	};
>  };
>  
>  &apps_rsc {
> @@ -684,6 +708,75 @@ &mdss_edp_phy {
>  	status = "okay";
>  };
>  
> +&pcie1_port {
> +	pcie@0,0 {
> +		compatible = "pci1179,0623";

The switch is part of SoC or board? This is confusing, I thought QPS615
is the SoC.

> +		reg = <0x10000 0x0 0x0 0x0 0x0>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;

Best regards,
Krzysztof


