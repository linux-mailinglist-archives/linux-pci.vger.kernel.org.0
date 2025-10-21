Return-Path: <linux-pci+bounces-38841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0744BF45CA
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 04:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B613B6591
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 02:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DE621D011;
	Tue, 21 Oct 2025 02:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geQbXYjQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE31199D8;
	Tue, 21 Oct 2025 02:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761012979; cv=none; b=Cs3/Nin7bgCJ5x92+osZsUgsb0QN+bspqdjbIHozRqZ8c9djgNAA4L44nWY9IkRQYJsjRMr2zZqk0FRwFy/bhXdo6uSKHSRCKhXnd5rDrCEE2DxELHi8m9C3kAv+H4/6oK1Z6fBznZBqfRRTWSPlcw7XIxdYamAqFRdfJsl2sNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761012979; c=relaxed/simple;
	bh=BTFNDm4Itzck0+WolcanaKwCwbJd24TnvyBW8Vf27dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEofr1V6iRb90NLeGv2SS6s+nvyL4hlBwTy630r6fU/+e9NSOVlcTWS0B7RMqA83a7Hkkv81I+wQyRfsEkWrSEVFaGsZ6wje6qjqUhbs/W53Ogv7DhAD4vZQPjs5avQaFgHhdVdzQr9FaED5My8r1aKZ02AgQxU8UtSgvLx3i1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geQbXYjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D85C4CEFB;
	Tue, 21 Oct 2025 02:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761012978;
	bh=BTFNDm4Itzck0+WolcanaKwCwbJd24TnvyBW8Vf27dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=geQbXYjQto0Rqi0/fy+oytHI6WbFjPBZnrFKa2mouO8NWrMvqZBtccDD3oUCcQIIA
	 cBGvPSto7/WvPWgksvmb4vp6EcwzCNruDHk4yjDj7JbdcF0gcXPERweztp5zTfUVTf
	 +YcA7q+N0/Ae9mKDcyiEPSITyTvVBS7wrU0Pgf7FcWhvB0hV07ac89nDHQBVQhz/mO
	 MNobTRjU+Wfpx2h1tI2rQaSgj6pGe4MzS1GEvK1nROuIr2+6q1VDgAlXx8xeMG5HJK
	 UmOfZDV++hnY1T/ZOk4aVyZxffQNmg11ueFEslVpfazm7cJzogI/yntafqCnedNxED
	 /ehqHkAv3TLyQ==
Date: Tue, 21 Oct 2025 07:46:06 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v5 3/6] arm64: dts: renesas: r9a08g045: Add PCIe node
Message-ID: <p4k4gkolfudxhvnrj4kkwpnyphdulga3fjovxqjqhmkhnts37o@y3jxdljb5oeo>
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
 <20251007133657.390523-4-claudiu.beznea.uj@bp.renesas.com>
 <k75ewk6mnv4w333oqefpgpa46fbg57grz7q6tlpc5evzehnzh5@elgnofa5ud5p>
 <a40a4a52-3dc0-4e17-8c55-548068976b8f@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a40a4a52-3dc0-4e17-8c55-548068976b8f@tuxon.dev>

On Mon, Oct 20, 2025 at 09:15:47AM +0300, Claudiu Beznea wrote:
> Hi, Mani,
> 
> On 10/19/25 09:57, Manivannan Sadhasivam wrote:
> > On Tue, Oct 07, 2025 at 04:36:54PM +0300, Claudiu wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> The RZ/G3S SoC has a variant (R9A08G045S33) which supports PCIe. Add the
> >> PCIe node.
> >>
> >> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >> ---
> >>
> >> Changes in v5:
> >> - updated the last part of ranges and dma-ranges
> >> - collected tags
> >>
> >> Changes in v4:
> >> - moved the node to r9a08g045.dtsi
> >> - dropped the "s33" from the compatible string
> >> - added port node
> >> - re-ordered properties to have them grouped together
> >>
> >> Changes in v3:
> >> - collected tags
> >> - changed the ranges flags
> >>
> >> Changes in v2:
> >> - updated the dma-ranges to reflect the SoC capability; added a
> >>   comment about it.
> >> - updated clock-names, interrupt names
> >> - dropped legacy-interrupt-controller node
> >> - added interrupt-controller property
> >> - moved renesas,sysc at the end of the node to comply with
> >>   DT coding style
> >>
> >>  arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 66 ++++++++++++++++++++++
> >>  1 file changed, 66 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> >> index 16e6ac614417..00b43377877e 100644
> >> --- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> >> +++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> >> @@ -717,6 +717,72 @@ eth1: ethernet@11c40000 {
> >>  			status = "disabled";
> >>  		};
> >>  
> >> +		pcie: pcie@11e40000 {
> >> +			compatible = "renesas,r9a08g045-pcie";
> >> +			reg = <0 0x11e40000 0 0x10000>;
> >> +			ranges = <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>;
> >> +			/* Map all possible DRAM ranges (4 GB). */
> >> +			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 1 0x00000000>;
> >> +			bus-range = <0x0 0xff>;
> >> +			interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
> >> +				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
> >> +				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
> >> +				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
> >> +				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
> >> +				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
> >> +				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
> >> +				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
> >> +				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
> >> +				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
> >> +				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
> >> +				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
> >> +				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
> >> +				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
> >> +				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
> >> +				     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>;
> >> +			interrupt-names = "serr", "serr_cor", "serr_nonfatal",
> >> +					  "serr_fatal", "axi_err", "inta",
> >> +					  "intb", "intc", "intd", "msi",
> >> +					  "link_bandwidth", "pm_pme", "dma",
> >> +					  "pcie_evt", "msg", "all";
> >> +			#interrupt-cells = <1>;
> >> +			interrupt-controller;
> >> +			interrupt-map-mask = <0 0 0 7>;
> >> +			interrupt-map = <0 0 0 1 &pcie 0 0 0 0>, /* INTA */
> >> +					<0 0 0 2 &pcie 0 0 0 1>, /* INTB */
> >> +					<0 0 0 3 &pcie 0 0 0 2>, /* INTC */
> >> +					<0 0 0 4 &pcie 0 0 0 3>; /* INTD */
> > 
> > Why can't you describe the SPI interrupt for INTx in 'interrupt-map' itself?
> 
> Because the INTx need to be controlled at PCIe controller level, too.
> Driver implements struct irq_chip::{irq_ack, irq_mask, irq_unmask} for
> these interrupts. Describing them like:
> 
> interrupt-map = <0 0 0 1 &gic GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
>                 <0 0 0 2 &gic GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
>                 <0 0 0 3 &gic GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
>                 <0 0 0 4 &gic GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>;
> 
> wouldn't allow for this, AFAICT.
> 

Ah, so these interrupts are masked at the PCI controller level... Fine then.

> > 
> >> +			clocks = <&cpg CPG_MOD R9A08G045_PCI_ACLK>,
> >> +				 <&cpg CPG_MOD R9A08G045_PCI_CLKL1PM>;
> >> +			clock-names = "aclk", "pm";
> >> +			resets = <&cpg R9A08G045_PCI_ARESETN>,
> >> +				 <&cpg R9A08G045_PCI_RST_B>,
> >> +				 <&cpg R9A08G045_PCI_RST_GP_B>,
> >> +				 <&cpg R9A08G045_PCI_RST_PS_B>,
> >> +				 <&cpg R9A08G045_PCI_RST_RSM_B>,
> >> +				 <&cpg R9A08G045_PCI_RST_CFG_B>,
> >> +				 <&cpg R9A08G045_PCI_RST_LOAD_B>;
> >> +			reset-names = "aresetn", "rst_b", "rst_gp_b", "rst_ps_b",
> >> +				      "rst_rsm_b", "rst_cfg_b", "rst_load_b";
> >> +			power-domains = <&cpg>;
> >> +			device_type = "pci";
> >> +			#address-cells = <3>;
> >> +			#size-cells = <2>;
> >> +			max-link-speed = <2>;
> > 
> > 'max-link-speed' is used to limit the link speed. Why do you need to limit the
> > link speed all the time for this controller?
> 
> I though it is to describe the max link speed supported by controller. This
> controller max link speed is 5GT/s. Should I drop this property?
> 

Yes. The driver should be able to query the Link Capabilities register and get
the max supported link speed of the hardware. This property should only be used
when the firmware decides to override the hardware supported max link speed.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

