Return-Path: <linux-pci+bounces-35054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A35B3AB01
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 21:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C021C84901
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 19:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19427270EBC;
	Thu, 28 Aug 2025 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6xyCKSo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54A02356B9;
	Thu, 28 Aug 2025 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756409768; cv=none; b=N8yR0gB+H8x5TeSkIDd8F+hqrLc0bbyKCQWojeYNnPZ3zyrabP3sqnLmlgKxc/3uGlsa3w+OUnm03VFr74tIahWBHbUb+7g/oY8JnBPV62cCCtBjId3tR0w0uiNOSs9Hqy5nO42WkdQRjp6eXgTBsoi9VtgE/Bp4cJ8nLiKJktY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756409768; c=relaxed/simple;
	bh=OsoMClZ8zewBYWl+159+qqnGdVkEoyGDB7GLoGNd/TE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=m2r7QvNTiEteUoURP3CqRLCHajsE3fU1WkI/YXXqNyI9ttDdXVmBBUIG9atBDxuRdX8pyzqbq1ExsknV4T6jlpFooV58okk1iXEoU67GmAaBDS+sQNZa+VTBHWq/l0jgn4qZvT0aP5skJ+vsYFQYp7JeEPF51qymbHKGGxs9SGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6xyCKSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BAFC4CEEB;
	Thu, 28 Aug 2025 19:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756409767;
	bh=OsoMClZ8zewBYWl+159+qqnGdVkEoyGDB7GLoGNd/TE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=k6xyCKSoZHCUN/xb2z1hgFOpvBNITDPTdgB/yNo+zgp+wzg0/iCiJo313C+gRx6h0
	 HcQRVMWJv+p7GyZcF4lkNyo1IhHCryoTndR8pxNezLRB6xdp0BxXIBdug9ximJv9op
	 veZe0kDGL2U/PXwytNoTGTTgrk9IjbRW8dbi7d3jO6uJdxcQkgVi4dYV41k1Lc6/Qb
	 MMyCWu4LHphr6dE/ylm5ADQgfCm4S3q7xdbPVif24gg9urwiyLJn2YzVbPotpgf5OG
	 tvI+G1KlGDdQgp+C3poxlb9FCsK1f54ZjN+/oTWLayzytev8Vg6rdzUWSQGEDoz69W
	 hQ7LVKCq3Sllw==
Date: Thu, 28 Aug 2025 14:36:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
	catalin.marinas@arm.com, will@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de, lizhi.hou@amd.com,
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v3 4/9] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add
 documentation for the PCIe IP on Renesas RZ/G3S
Message-ID: <20250828193605.GA957994@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe7afeb5-e009-4f68-a3a8-58ff967d3780@tuxon.dev>

On Thu, Aug 28, 2025 at 10:11:55PM +0300, claudiu beznea wrote:
> On 8/8/25 14:25, Claudiu Beznea wrote:
> > On 08.07.2025 19:34, Bjorn Helgaas wrote:
> > > On Fri, Jul 04, 2025 at 07:14:04PM +0300, Claudiu wrote:
> > > > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > > 
> > > > The PCIe IP available on the Renesas RZ/G3S complies with the PCI Express
> > > > Base Specification 4.0. It is designed for root complex applications and
> > > > features a single-lane (x1) implementation. Add documentation for it.
> ...

> Renesas HW team replied to me that there are no clock, reset, or interrupt
> signals dedicated specifically to the Root Port. All these signals are
> shared across the PCIe system.
> 
> Taking this and your suggestions into account, I have prepared the following
> device tree:
> 
> pcie: pcie@11e40000 {
> 	compatible = "renesas,r9a08g045-pcie";
> 	reg = <0 0x11e40000 0 0x10000>;
> 	ranges = <0x02000000 0 0x30000000 0 0x30000000 0 0x8000000>;
> 	/* Map all possible DRAM ranges (4 GB). */
> 	dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0x1 0x0>;
> 	bus-range = <0x0 0xff>;
> 	interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
> 		     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
> 		     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
> 		     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
> 		     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
> 		     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
> 		     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
> 		     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
> 		     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
> 		     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
> 		     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
> 		     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
> 		     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
> 		     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
> 		     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
> 		     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>;
> 	interrupt-names = "serr", "serr_cor", "serr_nonfatal",
> 			  "serr_fatal", "axi_err", "inta",
> 			  "intb", "intc", "intd", "msi",
> 			  "link_bandwidth", "pm_pme", "dma",
> 			  "pcie_evt", "msg", "all";
> 	#interrupt-cells = <1>;
> 	interrupt-controller;
> 	interrupt-map-mask = <0 0 0 7>;
> 	interrupt-map = <0 0 0 1 &pcie 0 0 0 0>, /* INTA */
> 			<0 0 0 2 &pcie 0 0 0 1>, /* INTB */
> 			<0 0 0 3 &pcie 0 0 0 2>, /* INTC */
> 			<0 0 0 4 &pcie 0 0 0 3>; /* INTD */
> 	clocks = <&cpg CPG_MOD R9A08G045_PCI_ACLK>,
> 		 <&cpg CPG_MOD R9A08G045_PCI_CLKL1PM>;
> 	clock-names = "aclk", "pm";
> 	resets = <&cpg R9A08G045_PCI_ARESETN>,
> 		 <&cpg R9A08G045_PCI_RST_B>,
> 		 <&cpg R9A08G045_PCI_RST_GP_B>,
> 		 <&cpg R9A08G045_PCI_RST_PS_B>,
> 		 <&cpg R9A08G045_PCI_RST_RSM_B>,
> 		 <&cpg R9A08G045_PCI_RST_CFG_B>,
> 		 <&cpg R9A08G045_PCI_RST_LOAD_B>;
> 	reset-names = "aresetn", "rst_b", "rst_gp_b", "rst_ps_b",
> 		      "rst_rsm_b", "rst_cfg_b", "rst_load_b";
> 	power-domains = <&cpg>;
> 	device_type = "pci";
> 	#address-cells = <3>;
> 	#size-cells = <2>;
> 	renesas,sysc = <&sysc>;
> 	status = "disabled";
> 
> 	pcie_port0: pcie@0,0 {
> 		reg = <0x0 0x0 0x0 0x0 0x0>;
> 		ranges;
> 		clocks = <&versa3 5>;
> 		clock-names = "ref";
> 		device_type = "pci";
> 		vendor-id = <0x1912>;
> 		device-id = <0x0033>;
> 		bus-range = <0x1 0xff>;

I don't think you need this bus-range.  The bus range for the
hierarchy below a Root Port is discoverable and configurable via
config space.

> 		#address-cells = <3>;
> 		#size-cells = <2>;
> 	};
> };

