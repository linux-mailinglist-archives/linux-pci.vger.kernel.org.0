Return-Path: <linux-pci+bounces-33770-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4C5B21249
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 18:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32852684BAA
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47431A9FB6;
	Mon, 11 Aug 2025 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u05n6lhy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F30724888F;
	Mon, 11 Aug 2025 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930170; cv=none; b=LW67S0hUv9UsmpOiyNgOyeykSllxFtnIf6hdihYOc2ZDkvmLfO2Au9e+fP/pC1zBOz1rHboG+pX2LxXYbRIuwJe4W1xkgDwi95fcavRw8KjtPbHxTtUojwGshuGNMhS6MEUhAG79vyq12FJa3K9OzOCp4qJOSIJPD0TKpcKOds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930170; c=relaxed/simple;
	bh=7ZMfgVnzeejYKUo7Uchi+tz+fGM5yKJz1iXdAWYyqAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQElzc295YIDucT77g3T55GmQhqHqgtCD8Q0ohdzs9uYKjRo/NAUTSWKHTl4eQyztyYaVPhgUwJqXiiLqZU+g+579kOyuX7lmjZf3+q5fuAmVW72wOryLTNNTR8I+bb1I/4blbxDMaQBY9UCGdeH5uIAG2Bm4c+8nsHBC5N2V64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u05n6lhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE2BC4CEF5;
	Mon, 11 Aug 2025 16:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754930170;
	bh=7ZMfgVnzeejYKUo7Uchi+tz+fGM5yKJz1iXdAWYyqAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u05n6lhyjlEP+hguvk/wDXY1/mESDQYjMzAixM2H/ONpNaYZrEmjhxG5vWZmOymkg
	 TPgAM7u9gnAUUhTDcY/Qb0Af3Bs0aMyVWXS0DObRSDIt+W7zcmBjuD0WWPCmz/+WFC
	 ECUCXH1nToHtSVcIEAoekVK5mXMSLP2Y0lKDTSo5jqsfMSayYMeI4hehrTN+YWlWRc
	 y2RBZOYmqYsO0KPSoTuwsKpiNtoBr30uWgBnlzoUDlUbEDaw3win6NQQ4DI2nF7Qpd
	 n58F1dC1lVGUBLCt1PE78fdu1ogp89VHKqgeG/ZGKHj1vfwcAKMv3YihHlHmczcdZ8
	 4ROVRAUoPlM/Q==
Date: Mon, 11 Aug 2025 11:36:07 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Bjorn Helgaas <bhelgaas@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, 
	sherry.sun@nxp.com, linux-pm@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v4 1/3] arm64: dts: qcom: sc7280: Add wake GPIO
Message-ID: <u4zedngig2jsraq27h2gc5ksp5swgypl2k3sy44znrhndtljpp@r4jb3wibkf3q>
References: <20250801-wake_irq_support-v4-0-6b6639013a1a@oss.qualcomm.com>
 <20250801-wake_irq_support-v4-1-6b6639013a1a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801-wake_irq_support-v4-1-6b6639013a1a@oss.qualcomm.com>

On Fri, Aug 01, 2025 at 04:29:42PM +0530, Krishna Chaitanya Chundru wrote:
> Add WAKE# gpio which is needed to bring PCIe device state
> from D3cold to D0.
> 

What tree did you base this on? None of these boards has pcieport1
defined in the upstream kernel.

Regards,
Bjorn

> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts   | 1 +
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 1 +
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 10c152ac03c874df5f1dc386d9079d3db1c55362..a4d85772f86955ad061433b138581fa9d81110a4 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -810,6 +810,7 @@ &mdss_edp_phy {
>  
>  &pcieport1 {
>  	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 3 GPIO_ACTIVE_HIGH>;
>  };
>  
>  &pcie1 {
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> index 60b3cf50ea1d61dd5e8b573b5f1c6faa1c291eee..5e73060771329cade097bf1a71056a456a7937d7 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> @@ -477,6 +477,7 @@ &pcie1 {
>  
>  &pcieport1 {
>  	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 3 GPIO_ACTIVE_HIGH>;
>  };
>  
>  &pm8350c_pwm {
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 0b0212b670797a364d7f0e7a458fc73245fff8db..240513774612fb2bfcdb951e5a5a77c49f49eb82 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -418,6 +418,7 @@ &lpass_va_macro {
>  
>  &pcieport1 {
>  	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 3 GPIO_ACTIVE_HIGH>;
>  };
>  
>  &pcie1 {
> 
> -- 
> 2.34.1
> 

