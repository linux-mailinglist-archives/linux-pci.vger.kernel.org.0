Return-Path: <linux-pci+bounces-12272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC87C96091F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 13:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E031F244AB
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 11:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9366B1A071B;
	Tue, 27 Aug 2024 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAl5WkB7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED471A0718;
	Tue, 27 Aug 2024 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758882; cv=none; b=dP1VxNAT53DIc/bUOM6fcPiB9SqR/Bg29/ru3CNQAZKG2ZA3/jUN0IRGSb/zFIzx/D0qblvuXHjR0woatevj8iz7QVpujeQouIXWHCiJI9cZ4wnOD97wrKrUJ1WaSCPMf3OLllA+eoZFAoaHNVmMKW4bUYm7oR+5bXQCwbL9b3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758882; c=relaxed/simple;
	bh=VYCX0E48ph+cth/n7E5awP96npB0EP6UJB3lBeYDBE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZT+MEnOKtlD+prQsAqx4zn+outei16S4J6DiKH8gyHMzaGrDUyR6Rx/r5OPXZe26470n/dZd/TquXxCCzgSO4q2Q+I8pRueRfRDSofe6Af8lSZS3MRoUmoGL4h2yJTVZr8w22/D/IKtRlamcI7LcY3UE/jxXjT8Zyq6pVz5bCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAl5WkB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B301C51E64;
	Tue, 27 Aug 2024 11:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724758882;
	bh=VYCX0E48ph+cth/n7E5awP96npB0EP6UJB3lBeYDBE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZAl5WkB76UMZu/3JybqCIQUYRU6jgBeGbMAgKTlHR+QVcISzMmminsDdV+HdwggY3
	 ThIqfL82T80Yi/3+e3CrriedQwzjnsdgKZrhFM2CWGSEkpwV7Z1+KXZcwFiXwXMXtA
	 Vf5M/hsjXs2YAahwD0bAt2KwsMhz+EJxEx9ExVe8ULA/89F6O2osPb/iNlQ0EU8vCc
	 diFiGXzsGJOy02993ujsAfjRpE6E5Mdc2eVCqeY7p0WQRNkBDt0sgLHuPwmBCnMe/8
	 BlKmZQh4r1ThNGMwkxVDHByuR5W5NuBaQ+oYyoAdgXEcvrGg0wP7yWR+tJ5hZTvHLS
	 6sgB6WxQCJcDQ==
Date: Tue, 27 Aug 2024 13:41:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org, 
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org, 
	quic_msarkar@quicinc.com, quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org, 
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 7/8] arm64: dts: qcom: x1e80100-qcp: Add power supply and
 sideband signal for pcie3
Message-ID: <haj2zmdk7raz4zcwaizzeyxoetrb5rcxwwkhjesuejphixgogb@gueq5pq7srcx>
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
 <20240827063631.3932971-8-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827063631.3932971-8-quic_qianyu@quicinc.com>

On Mon, Aug 26, 2024 at 11:36:30PM -0700, Qiang Yu wrote:
> Add perst, wake and clkreq gpio config. Add required power supply.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 116 ++++++++++++++++++++++
>  1 file changed, 116 insertions(+)
> 

Really, driver cannot depend on this patch. That's a no go.

> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
> index 1c3a6a7b3ed6..0deb0c4bfea9 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
> @@ -254,6 +254,48 @@ vreg_nvme: regulator-nvme {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&nvme_reg_en>;
>  	};
> +
> +	vreg_pcie_12v: regulator-pcie_12v {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_PCIE_12V";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +
> +		gpio = <&pm8550ve_8_gpios 8 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pcie_x8_12v>;
> +	};
> +
> +	vreg_pcie_3v3_aux: regulator-pcie_3v3_aux {

Please follow DTS coding style.

> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_PCIE_3P3_AUX";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&pmc8380_3_gpios 8 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pm_sde7_aux_3p3_en>;
> +	};
> +
> +	vreg_pcie_3v3: regulator-pcie_3v3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_PCIE_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&pmc8380_3_gpios 6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pm_sde7_main_3p3_en>;
> +	};
>  };
>  
>  &apps_rsc {
> @@ -667,6 +709,57 @@ &mdss_dp3_phy {
>  	status = "okay";
>  };
>  
> +&pm8550ve_8_gpios {
> +	pcie_x8_12v: pcie_x8_12v_on {

Never tested.

Best regards,
Krzysztof


