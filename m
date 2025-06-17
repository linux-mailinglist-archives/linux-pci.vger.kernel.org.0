Return-Path: <linux-pci+bounces-29950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56917ADD78A
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 18:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7DE4A1795
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 16:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E982F2C4E;
	Tue, 17 Jun 2025 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoLn8npu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3876028505C;
	Tue, 17 Jun 2025 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178019; cv=none; b=e2Jss2UGM20lA8Ms5Yv9Gya8rZIsoiO/aDcQsLrl1kTpgXRMr8m3KtDHbvnioMqgK5BNyGujTUQIRmGLTwT0N1pzClqWnGQpn44VprC2NGeFMbTIhfKDzjWq4jqR8m3EjLIMMDy0/4oKQi4aoq1+J6Sz05r8HqDP5dw07NOjr5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178019; c=relaxed/simple;
	bh=HXwonGiNJd0DIMeQERhLo8Kf3Zxxi0PS7BE3fkI89jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Esp9b/wczN8RkoEGW0sKWyRNz5HYXCJhLR5uowXwhAqreDPVEkxIq7BVsO5MN5RfpT2DPjeVz/zPtadm2VRenEG7asRoPQ0MDhnG2SXYFPxdUcEhQ/VrgIAV9xsb1INVuazVv8rKqQTvsPRh8SeaZgsWgxTQwQA2iOMv+uQHDnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoLn8npu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC85CC4CEE3;
	Tue, 17 Jun 2025 16:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750178019;
	bh=HXwonGiNJd0DIMeQERhLo8Kf3Zxxi0PS7BE3fkI89jQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QoLn8npu5krVknk1qU+Lk01+Vi5QKLMaXUoTeYPXKR1NgNk6pSHE1m6gbfIfyTE4H
	 OZChYeBkH5v/pLKhlCyhTXlWKFkX00zqcInHpsEjVCfzL7GxLVrssnuSizpvVMLOsb
	 vfK6c/CJg02JUpuSBet84tI40mZvzmlWXdWCzs2YnAhJP2EMakd6tO91y19nLn/cXJ
	 LwquK324EBWU1MMpN1fIhzqr56zRBdnF8ROVQOcWg/XCZRICOn5Wg6n+Oay8wHnE7s
	 t3CiRpuAHbujWFd8CbsGP7KU41zKi/9WmPCcsx4TKvLSR6Mwb+WVjUIKhb80nPr1a8
	 gUrjjXAZySrxA==
Date: Tue, 17 Jun 2025 22:03:26 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
	neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, quic_qianyu@quicinc.com, 
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 4/4] arm64: dts: qcom: qcs615-ride: Enable PCIe
 interface
Message-ID: <6vfwiii4sawm722odw6hxomtsrd5m64pmjlqm5sr5m3nblih3m@jkn3txak5nix>
References: <20250527072036.3599076-1-quic_ziyuzhan@quicinc.com>
 <20250527072036.3599076-5-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250527072036.3599076-5-quic_ziyuzhan@quicinc.com>

On Tue, May 27, 2025 at 03:20:36PM +0800, Ziyue Zhang wrote:
> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 
> Add platform configurations in devicetree for PCIe, board related
> gpios, PMIC regulators, etc.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts | 42 ++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> index 2b5aa3c66867..c59647e5f2d6 100644
> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> @@ -217,6 +217,23 @@ &gcc {
>  		 <&sleep_clk>;
>  };
>  
> +&pcie {
> +	perst-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 100 GPIO_ACTIVE_HIGH>;
> +
> +	pinctrl-0 = <&pcie_default_state>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pcie_phy {
> +	vdda-phy-supply = <&vreg_l5a>;
> +	vdda-pll-supply = <&vreg_l12a>;
> +
> +	status = "okay";
> +};
> +
>  &pm8150_gpios {
>  	usb2_en: usb2-en-state {
>  		pins = "gpio10";
> @@ -244,6 +261,31 @@ &rpmhcc {
>  	clocks = <&xo_board_clk>;
>  };
>  
> +&tlmm {
> +	pcie_default_state: pcie-default-state {
> +		clkreq-pins {
> +			pins = "gpio90";
> +			function = "pcie_clk_req";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-pins {
> +			pins = "gpio101";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;

Are you sure that the default state of the pin should be 'pull down'? Pull down
of a PERST# is deassert, which should only happen once the power and refclk are
stable.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

