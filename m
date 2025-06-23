Return-Path: <linux-pci+bounces-30384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A0EAE3FB9
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 14:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4998C17C907
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 12:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C19F24887A;
	Mon, 23 Jun 2025 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDPRAB8x"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2212B24169B;
	Mon, 23 Jun 2025 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680914; cv=none; b=bsose3209NdYtMXuFHFIQAt262Rzarji9STyu0Sj/HnmC/sLWHBsk6qIk1JqEljM2USL8kbxT5L/AzxbEJzPK3GUrXSn5kLPhrZ4uJDlSvjZevMQac6TiKvKfglohL0OgC1smcBqu8u1gwDCNBrEHVM4/j2lfknGufTkkp2KvH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680914; c=relaxed/simple;
	bh=e99veYZUy79gCMXBdhcBd8vV/Ca+YIYh9vr/jO7tfPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rb3BiZNpuQZ3DQ4nGWN0VEdDVB3hJrWm/wJerMsIDg1Bl53xADKPYvWQk2UX9FOODeVIbu1kU1DJAL8kyRhX4RYN0OTul+uS8BeEa9X6peHFiNq489JzqVxN0cVC2aYHpHdPxJGQXzwrTSN2FapHpVMe7eoihRfo9H4VKg9hQ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDPRAB8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14247C4CEEA;
	Mon, 23 Jun 2025 12:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750680914;
	bh=e99veYZUy79gCMXBdhcBd8vV/Ca+YIYh9vr/jO7tfPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oDPRAB8x+L31MY/qA3EPZ/FsPe6E2LBHxsMfdHLpdaY9n1XFZRtyJBHYiW9RbRkcw
	 kt3nTgv4WTwMg1LQZ/wVpsbsRM1V4C1ibRrLhIlyVypVleKAhgYbakE6NzYT8cVJ9h
	 NB9TkI45eC+fxRHLIME/Sca94oRKSxuADXO0z8yIITHsWcjikKJuk/SOq1texRQtU8
	 QnNLBieQM7tKdYlhuNSkdJ0zDF4/5emPgaGe4u144tzUTGoPQAqpnsekIuauSEMaTa
	 hrWALF12f9AiP6XJKNMGeGzb2Bj8r7fr6QicvBJmFsA7wWRS6SUCGVORSsjyODlhve
	 B+h6cu+xb/sLA==
Date: Mon, 23 Jun 2025 06:15:12 -0600
From: Manivannan Sadhasivam <mani@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, p.zabel@pengutronix.de, 
	johan+linaro@kernel.org, cassel@kernel.org, shradha.t@samsung.com, 
	thippeswamy.havalige@amd.com, quic_schintav@quicinc.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 8/9] arm64: dts: st: Add PCIe Endpoint mode on
 stm32mp251
Message-ID: <de275zjaafymohqbcao5tvk2bul5f3fvqgsla4yjfvvueg75yz@dpqh2vs3t6kg>
References: <20250610090714.3321129-1-christian.bruel@foss.st.com>
 <20250610090714.3321129-9-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610090714.3321129-9-christian.bruel@foss.st.com>

On Tue, Jun 10, 2025 at 11:07:13AM +0200, Christian Bruel wrote:
> Add pcie_ep node to support STM32 MP25 PCIe driver based on the
> DesignWare PCIe core configured as Endpoint mode
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  arch/arm64/boot/dts/st/stm32mp251.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> index 781d0e43ab59..23dcc889c3e8 100644
> --- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
> +++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> @@ -1140,6 +1140,21 @@ stmmac_axi_config_1: stmmac-axi-config {
>  				};
>  			};
>  
> +			pcie_ep: pcie-ep@48400000 {
> +				compatible = "st,stm32mp25-pcie-ep";
> +				reg = <0x48400000 0x100000>,
> +				      <0x48500000 0x100000>,
> +				      <0x48700000 0x80000>,
> +				      <0x10000000 0x10000000>;
> +				reg-names = "dbi", "dbi2", "atu", "addr_space";
> +				clocks = <&rcc CK_BUS_PCIE>;
> +				resets = <&rcc PCIE_R>;
> +				phys = <&combophy PHY_TYPE_PCIE>;
> +				access-controllers = <&rifsc 68>;
> +				power-domains = <&CLUSTER_PD>;
> +				status = "disabled";
> +			};
> +
>  			pcie_rc: pcie@48400000 {
>  				compatible = "st,stm32mp25-pcie-rc";
>  				device_type = "pci";
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

