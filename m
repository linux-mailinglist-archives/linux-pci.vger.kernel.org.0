Return-Path: <linux-pci+bounces-42008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11304C8369E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 06:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCEC3AC76A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 05:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704D1285CB6;
	Tue, 25 Nov 2025 05:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nao6fk/I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7CB2857CC;
	Tue, 25 Nov 2025 05:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764049996; cv=none; b=MeuLvELiMlwgvrGIE+gQTNRoFzkysmEnHUoFcNXLgwkR2ojgKgr4CmUxXEqVGbs5yCVF5IpfPHA7UvnQcl/CSP44zcp/5lD1xn9yL8GXwOkiDXJ51v+yLr40O5xFehHVXbQiUaeiXD5EVIO9IRUJhbKDE3pCnMUOnB23EVmwjCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764049996; c=relaxed/simple;
	bh=uZXyr9e6RyW7UyopcNGjuBsEuZrdr8kyg20VKmROles=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXnPbIq0VF7XExFYft4TDN0x9cXD+EVXFh3o0NW1kRe34WTXDiTQjiGFhkF6STApenAW1YnApqO+04CmjkTmFQy+UJzvnW4mhWThTGYaFu4ibDPS7iD9G/XY/EmjsP5vecEgrNdlXGpdPRE3/uk6rx7ECHjXc+LNhZ90cpCld1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nao6fk/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AB9C4CEF1;
	Tue, 25 Nov 2025 05:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764049995;
	bh=uZXyr9e6RyW7UyopcNGjuBsEuZrdr8kyg20VKmROles=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nao6fk/Is5uNu/ld04vpTyPRfYQVR2Bz5VZyWNdUWk8YMr8PoHl7EV5YmhB+a0Gzw
	 zBfzlIKAbzjSFrGOuYNM+A75u8Ffe0oPcMK0Yrmae1v9xx7qAP/BxLiyovIBl2eENr
	 6yoVqlbdgTN8U3QPAMeXAwoKKIBcwCOd92UxqHcgPNHD/G+MLX5SyC62T0oAAeUVtd
	 47/lJTtxp0HCqd/Cd7WrLt+Xb5uw2oUGguY5jsPfnn6XqFk/HCDLWcrsEuzDmZvaAj
	 BYp59ztolxmbUDkGWlWyK6PyZsA1rojeKPOb6DkoUdXqrnlmbRVsypYj/T/55SCtuc
	 WjmvJdimZ53Rg==
Date: Tue, 25 Nov 2025 11:23:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v8 3/6] arm64: dts: renesas: r9a08g045: Add PCIe node
Message-ID: <2gumxdloes2zpzbyfmva2vhibxzevk2bqspj5ufl4pldrnyzkh@bhcvz5g6kka5>
References: <20251119143523.977085-1-claudiu.beznea.uj@bp.renesas.com>
 <20251119143523.977085-4-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251119143523.977085-4-claudiu.beznea.uj@bp.renesas.com>

On Wed, Nov 19, 2025 at 04:35:20PM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The RZ/G3S SoC has a variant (R9A08G045S33) which supports PCIe. Add the
> PCIe node.
> 
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> 
> Changes in v8:
> - none
> 
> Changes in v7:
> - none
> 
> Changes in v6:
> - dropped max-link-speed
> 
> Changes in v5:
> - updated the last part of ranges and dma-ranges
> - collected tags
> 
> Changes in v4:
> - moved the node to r9a08g045.dtsi
> - dropped the "s33" from the compatible string
> - added port node
> - re-ordered properties to have them grouped together
> 
> Changes in v3:
> - collected tags
> - changed the ranges flags
> 
> Changes in v2:
> - updated the dma-ranges to reflect the SoC capability; added a
>   comment about it.
> - updated clock-names, interrupt names
> - dropped legacy-interrupt-controller node
> - added interrupt-controller property
> - moved renesas,sysc at the end of the node to comply with
>   DT coding style
> 
>  arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 65 ++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> index 16e6ac614417..8fd3659b70fe 100644
> --- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> @@ -717,6 +717,71 @@ eth1: ethernet@11c40000 {
>  			status = "disabled";
>  		};
>  
> +		pcie: pcie@11e40000 {
> +			compatible = "renesas,r9a08g045-pcie";
> +			reg = <0 0x11e40000 0 0x10000>;
> +			ranges = <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>;
> +			/* Map all possible DRAM ranges (4 GB). */
> +			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 1 0x00000000>;
> +			bus-range = <0x0 0xff>;
> +			interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "serr", "serr_cor", "serr_nonfatal",
> +					  "serr_fatal", "axi_err", "inta",
> +					  "intb", "intc", "intd", "msi",
> +					  "link_bandwidth", "pm_pme", "dma",
> +					  "pcie_evt", "msg", "all";
> +			#interrupt-cells = <1>;
> +			interrupt-controller;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0 0 0 1 &pcie 0 0 0 0>, /* INTA */
> +					<0 0 0 2 &pcie 0 0 0 1>, /* INTB */
> +					<0 0 0 3 &pcie 0 0 0 2>, /* INTC */
> +					<0 0 0 4 &pcie 0 0 0 3>; /* INTD */
> +			clocks = <&cpg CPG_MOD R9A08G045_PCI_ACLK>,
> +				 <&cpg CPG_MOD R9A08G045_PCI_CLKL1PM>;
> +			clock-names = "aclk", "pm";
> +			resets = <&cpg R9A08G045_PCI_ARESETN>,
> +				 <&cpg R9A08G045_PCI_RST_B>,
> +				 <&cpg R9A08G045_PCI_RST_GP_B>,
> +				 <&cpg R9A08G045_PCI_RST_PS_B>,
> +				 <&cpg R9A08G045_PCI_RST_RSM_B>,
> +				 <&cpg R9A08G045_PCI_RST_CFG_B>,
> +				 <&cpg R9A08G045_PCI_RST_LOAD_B>;
> +			reset-names = "aresetn", "rst_b", "rst_gp_b", "rst_ps_b",
> +				      "rst_rsm_b", "rst_cfg_b", "rst_load_b";
> +			power-domains = <&cpg>;
> +			device_type = "pci";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			renesas,sysc = <&sysc>;
> +			status = "disabled";
> +
> +			pcie_port0: pcie@0,0 {
> +				reg = <0x0 0x0 0x0 0x0 0x0>;
> +				ranges;
> +				device_type = "pci";
> +				vendor-id = <0x1912>;
> +				device-id = <0x0033>;
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +			};
> +		};
> +
>  		gic: interrupt-controller@12400000 {
>  			compatible = "arm,gic-v3";
>  			#interrupt-cells = <3>;
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

