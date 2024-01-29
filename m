Return-Path: <linux-pci+bounces-2731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F858409CF
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 16:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0541F223E6
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 15:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC01153BC3;
	Mon, 29 Jan 2024 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPSs7Jld"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA641153505;
	Mon, 29 Jan 2024 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541889; cv=none; b=COg09ZZ5FMjQVFH+KmiodaNNeG8McKnRoG2mN6HA2eXZRVbYck0PneROIp/ZTBRllvxEUhjyy3ArjOVj1atPiBMffTnZ07wqL268nPuLKu0D+Ez6Za5ixSSzZV63cq0YToGfY+nfVSWUqP3xN/H2q7s0uuoJ7dcgZ0jfwfvO1qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541889; c=relaxed/simple;
	bh=0XZk90jx/4Vjd3WKyXbE8BDxmOT93W1I9wEfFfSYGhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xp+2SAeFCLO4ttCaIOpFfEPvQIu4n+ACEvpE00AkbnysynzdLDnbKUQmYq0Z6xQe4efR02Z7AvXLGuqunlHbZMnql7eAippKtr9r+xquITt+oWjf2JsD4eHoBm0fVlloQL8I/IYyRTNCngdGzgguWxM2wJVQ/ifsnbI0Ek7D/uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPSs7Jld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11AAC433F1;
	Mon, 29 Jan 2024 15:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706541888;
	bh=0XZk90jx/4Vjd3WKyXbE8BDxmOT93W1I9wEfFfSYGhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPSs7Jldr7TL3e6bV27W4LxgaFSZLWa1Hp2c4+QotUeWGNBrazbjZfhBo8UF4I4tx
	 olai5mlMTz/P5/vKW6sfSFS2Dh0Wlqg1IkAMGX7e/5Lw/osaHbgpf6+biMpmWunESJ
	 xC785K7K1nST1lFoVPmJCtZjEUoPmZeBV1ce/fsB4te9+43a8JWfEh5Mm7jOvzAQjl
	 vXLLC5R1tVbguiNX9yiy04wVZO3rvcoY/Bq8O1TgzL6BOyXWHOTBcbgt/pduRE+Wsq
	 lLWo5L7PUF5mYPkXXHzRnh2aBk6WIm4cNrv0Hf7uSdOFz4y2o23QSHbuzSUYPf8U3B
	 qINfUEtX/rarQ==
Date: Mon, 29 Jan 2024 20:54:32 +0530
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
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/6] arm64: dts: qcom: sm8450: Add interconnect path
 to PCIe node
Message-ID: <20240129152432.GE22617@thinkpad>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-2-77bbf7d0cc37@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240112-opp_support-v6-2-77bbf7d0cc37@quicinc.com>

On Fri, Jan 12, 2024 at 07:52:01PM +0530, Krishna chaitanya chundru wrote:
> Add pcie-mem & cpu-pcie interconnect path to the PCIe nodes.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 01e4dfc4babd..6b1d2e0d9d14 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -1781,6 +1781,10 @@ pcie0: pcie@1c00000 {
>  					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>  					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
>  
> +			interconnects = <&pcie_noc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_0 0>;
> +			interconnect-names = "pcie-mem", "cpu-pcie";
> +
>  			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
>  				 <&gcc GCC_PCIE_0_PIPE_CLK_SRC>,
>  				 <&pcie0_phy>,
> @@ -1890,6 +1894,10 @@ pcie1: pcie@1c08000 {
>  					<0 0 0 3 &intc 0 0 0 438 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>  					<0 0 0 4 &intc 0 0 0 439 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
>  
> +			interconnects = <&pcie_noc MASTER_PCIE_1 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_1 0>;
> +			interconnect-names = "pcie-mem", "cpu-pcie";
> +
>  			clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
>  				 <&gcc GCC_PCIE_1_PIPE_CLK_SRC>,
>  				 <&pcie1_phy>,
> 
> -- 
> 2.42.0
> 

-- 
மணிவண்ணன் சதாசிவம்

