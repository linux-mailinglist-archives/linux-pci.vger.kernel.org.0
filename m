Return-Path: <linux-pci+bounces-2733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21658840AC7
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 17:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B291F27E9D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 16:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22FB155311;
	Mon, 29 Jan 2024 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dz2X9qOR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721091552E9;
	Mon, 29 Jan 2024 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544278; cv=none; b=KwvJPnl7nFhm8BZCb16t/ALQzlXGS3jDjOhlGx7irm1xQvsUztV6UWfQxHJEtpi8xNvORP1waxdskAZ5Q6HeOUT0xjMNZbrsXsuYm0pHdNI5fJX4aJOPVPVV+aCuuE9CFFGPyxV9bzQDDm5X0colneJewzxZlfDdTee8otBMu/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544278; c=relaxed/simple;
	bh=rrF5M/nyZQ+K0nhCjlO7cD1vmBoa6qCOpTEz1qNzJys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcYD0C3MpHrd3Cwt3oF0ousIIfNlZjNyK0j2dBKXqQGvhtoPSBdsMtd8xgVKx/DltCn3aKxGkWUohwN3gCqQx4vk6Ii4hzRkgXjScG1nd/KZWw96h6BZpk9h2uNtvHag7zkbF8dnHvtvLX017FnH2hvj5N5vLzO/U6RzYE44qWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dz2X9qOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA296C433F1;
	Mon, 29 Jan 2024 16:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706544277;
	bh=rrF5M/nyZQ+K0nhCjlO7cD1vmBoa6qCOpTEz1qNzJys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dz2X9qOR470blV81A32kJLPi10DjH2zNYtxAw1INh5zFauLVb3x81ElJxCa534MGG
	 hQ7kpQ3f6y5pMcKtkqfBmmakiyVNG+LSVPUViiXe5Q8c3lQLtyyB3AO88cdEx993KY
	 RwRdjgbSCnSblBi7jhmBBIMf9qA6Pbb/lhp/bXzK3S+dC2UYHlonv4lJkntkDFF2Ex
	 wWEb+L6q05GY5GS0AoTS6Ru0uBG3eWD7aDKn/3xdR/uNxM7n4KGlwj5YTDGQ5qVviL
	 3r9HDXCST3Xsh+619JPqxeAAftOYacFeBp7YJu0CNRgAh9EERquLe87ZLjWtGfjdyj
	 dYEOZfDCsbQWA==
Date: Mon, 29 Jan 2024 21:34:20 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/6] arm64: dts: qcom: sm8450: Add opp table support
 to PCIe
Message-ID: <20240129160420.GA27739@thinkpad>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-5-77bbf7d0cc37@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240112-opp_support-v6-5-77bbf7d0cc37@quicinc.com>

On Fri, Jan 12, 2024 at 07:52:04PM +0530, Krishna chaitanya chundru wrote:
> PCIe needs to choose the appropriate performance state of RPMH power
> domain and interconnect bandwidth based up on the PCIe gen speed.
> 
> Add the OPP table support to specify RPMH performance states and
> interconnect peak bandwidth.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 74 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 6b1d2e0d9d14..eab85ecaeff0 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -1827,7 +1827,32 @@ pcie0: pcie@1c00000 {
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&pcie0_default_state>;
>  
> +			operating-points-v2 = <&pcie0_opp_table>;
> +
>  			status = "disabled";
> +
> +			pcie0_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-2500000 {
> +					opp-hz = /bits/ 64 <2500000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <250000 250000>;

This is a question for Viresh: We already have macros in the driver to derive
the bandwidth based on link speed. So if OPP core exposes a callback to allow
the consumers to set the bw on its own, we can get rid of this entry.

Similar to config_clks()/config_regulators(). Is that feasible?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

