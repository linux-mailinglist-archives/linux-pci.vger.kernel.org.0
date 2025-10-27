Return-Path: <linux-pci+bounces-39448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D91AC0F23A
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 17:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E6A19C0A72
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 15:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3583D3126BD;
	Mon, 27 Oct 2025 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LS0umjTD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A4F3126B2;
	Mon, 27 Oct 2025 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580462; cv=none; b=tg4shDDQ2H1uWZCjW8WLoYfp2pbp0XUseusYr5CCjiOFiHIcDBn4ZdC6K9mDZIBZHVE27vf5eJfnxtQFtdYDUkPaQ7JwcCwVXOOaOmMHphdPdZzOHPokCgnDTkYnuoOAaY1dAC3dfyd7UYatCwFWzgj25OvT2KZ/TimnjziriSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580462; c=relaxed/simple;
	bh=aNG/Xv8gCUMk2mL6QGjKgipDfk2wjjPqo6zhLwcFPAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4idgPV0pULXQR+GE2PoY+ViE93S4+uvOk8CqNlc6yTldcMAAGDw721OKIc6LakdzSLK0gHwFSkxcyjt4lhcFxXjRHC1eBQEnJixbct20RhRvRSdy7C1eK3oWWrsymW5+sjJuVXraJDgJMznTl42Dff3z1GfHxzIvlPQMTw8hYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LS0umjTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E2FC4CEF1;
	Mon, 27 Oct 2025 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761580461;
	bh=aNG/Xv8gCUMk2mL6QGjKgipDfk2wjjPqo6zhLwcFPAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LS0umjTDiZiKI/a+r3HCL+b/I6dSagSLfTI7yGyW/mNTuOcGSyHWGUM9oZOXh0TPv
	 rVj8iAfbSTMVP0ilGO1iitAK9t2Od2I7ylviMS6HDrkKVAI6ilJW9p7eyFWhmbGp4B
	 0/6X7OXTFS/bK4OnsguilhCtWR07792HBzxwc/owQX1mHE8uACC++8zMXnfDUN8HKb
	 EqBkiqoC1doCx6N2PIIHQmtYLa73BZEyx8SQj7aVfZVr4h33OeDZA4uSKKqFmbq5em
	 xE+FDWdlPymZ1pCFPe1z/969Tl0lw5uWkWDMnw6C/O1+7cowOfHR1YkByk2TOxQjRn
	 Mycfu7+Hd9zPQ==
Date: Mon, 27 Oct 2025 10:57:13 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>, konradybcio@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com, 
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org, 
	neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, 
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v1 3/4] arm64: dts: qcom: Add PCIe 3 support for
 HAMOA-IOT-SOM platform
Message-ID: <cncyo6y47anbyi434inelfl5czvgscjezejtzii4kihffkj2hj@e5jvvk4o5l7x>
References: <20250922075509.3288419-1-ziyue.zhang@oss.qualcomm.com>
 <20250922075509.3288419-4-ziyue.zhang@oss.qualcomm.com>
 <cd84f10e-c264-43fb-9e3d-20338d85de19@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd84f10e-c264-43fb-9e3d-20338d85de19@oss.qualcomm.com>

On Tue, Oct 14, 2025 at 11:13:42AM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 9/22/2025 1:25 PM, Ziyue Zhang wrote:
> > Update the HAMOA-IOT-SOM device tree to enable PCIe 3 support. Add perst
> > wake and clkreq sideband signals and required regulators in PCIe3
> > controller and PHY device tree node.

The commit message should answer the questions I pose below. This
message explains what you change, but it doesn't explain why.

Start your commit message by describing the hardware, then follow that
with the description of your change.

> > 
> > Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com
> > ---
> >   arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 70 +++++++++++++++++++++
> >   1 file changed, 70 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
> > index 0c8ae34c1f37..7486204a4a46 100644
> > --- a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
> > @@ -390,6 +390,53 @@ &gpu_zap_shader {
> >   	firmware-name = "qcom/x1e80100/gen70500_zap.mbn";
> >   };
> > +&pm8550ve_8_gpios {
> > +	pcie_x8_12v: pcie-12v-default-state {
> > +		pins = "gpio8";
> > +		function = "normal";
> > +		output-enable;
> > +		output-high;
> > +		bias-pull-down;
> > +		power-source = <0>;
> > +	};
> > +};
> > +
> > +&pmc8380_3_gpios {
> > +	pm_sde7_aux_3p3_en: pcie-aux-3p3-default-state {
> > +		pins = "gpio8";
> > +		function = "normal";
> > +		output-enable;
> > +		output-high;
> > +		bias-pull-down;
> > +		power-source = <0>;
> > +	};
> > +
> > +	pm_sde7_main_3p3_en: pcie-main-3p3-default-state {
> > +		pins = "gpio6";
> > +		function = "normal";
> > +		output-enable;
> > +		output-high;
> > +		bias-pull-down;
> > +		power-source = <0>;
> > +	};
> > +};
> Either squash patch 3/4 with 4/4 or move these pin configuration to
> patch 4/4.
> 

Patch 3 defines properties for the SOM and patch 4 defines properties
for the EVK board, so the split sounds reasonable.

But looking at the details, why would the SOM define these states? Isn't
it the carrier board that contains the related regulators? If I use this
SOM in my design, does my board have to have a 12V supply to my x8 PCIe
that's being controlled by gpio8?


In other words, I think you're right.

Regards,
Bjorn

> - Krishna Chaitanya.
> > +
> > +&pcie3 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pcie3_default>;
> > +	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
> > +	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
> > +
> > +	status = "okay";
> > +};
> > +
> > +&pcie3_phy {
> > +	vdda-phy-supply = <&vreg_l3c_0p8>;
> > +	vdda-pll-supply = <&vreg_l3e_1p2>;
> > +
> > +	status = "okay";
> > +};
> > +
> >   &pcie4 {
> >   	perst-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
> >   	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
> > @@ -471,6 +518,29 @@ &tlmm {
> >   	gpio-reserved-ranges = <34 2>, /* TPM LP & INT */
> >   			       <44 4>; /* SPI (TPM) */
> > +	pcie3_default: pcie3-default-state {
> > +		clkreq-n-pins {
> > +			pins = "gpio144";
> > +			function = "pcie3_clk";
> > +			drive-strength = <2>;
> > +			bias-pull-up;
> > +		};
> > +
> > +		perst-n-pins {
> > +			pins = "gpio143";
> > +			function = "gpio";
> > +			drive-strength = <2>;
> > +			bias-pull-down;
> > +		};
> > +
> > +		wake-n-pins {
> > +			pins = "gpio145";
> > +			function = "gpio";
> > +			drive-strength = <2>;
> > +			bias-pull-up;
> > +		};
> > +	};
> > +
> >   	pcie4_default: pcie4-default-state {
> >   		clkreq-n-pins {
> >   			pins = "gpio147";

