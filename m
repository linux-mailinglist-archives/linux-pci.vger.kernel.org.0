Return-Path: <linux-pci+bounces-31695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6B9AFD172
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 18:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D195416BE
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 16:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2ED2E5418;
	Tue,  8 Jul 2025 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azMXPSKl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300022E2F0D;
	Tue,  8 Jul 2025 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992449; cv=none; b=WITI7ja0GhLZTXr70sVXX2x++zJkbDKHYTczpkubvuO/nEVPCsr6T0dNcfM7/Y76cvGbaA3LdR/5Rt+kqq/CB5u7lPIRYvJkrK4CXpr0uhbIrXVMXAI3NltQZmJd9/O8QKYlUuJt/MRgP85Nr6yUnNM3/B1nV1AbE3N9P5ftknQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992449; c=relaxed/simple;
	bh=SgfdUXzh2Nml5Z3bb/5kyq3mdQdgb9FfXFfA9SvpmDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VAEI9xrEo3Ly5VZrCVn5cK43yRvVjbVFGd48J4Zg17zpR7my3wBn+Bc6ngeR/h6TIvU/wRPpfCXu86gysQioSLjkzbPCqwuwDw0K3DN0CARJA2JEPZ3Xupj/joe/bi3nq9Re/Y28if/OSOBaeNGjDjfLutJg6ZAS8BWM1f6btDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azMXPSKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D4FC4CEF6;
	Tue,  8 Jul 2025 16:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751992449;
	bh=SgfdUXzh2Nml5Z3bb/5kyq3mdQdgb9FfXFfA9SvpmDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=azMXPSKl/cKhJH/ynvyluDOzxcpZwYDm4K+ao5thzQed3wrQRNk0B1kWpuK5JNyfM
	 AtMyy7PP7q2t5/9TFMMeck2emNZwxvwqiJhAVafZNIe/h8+dnZCoWL0NxxvWckE2mt
	 Jth6t+YijRDPahsaE9FnJ8odSlCtQNXxs97jPn1+8p/GIBxNIzskwbMTLO02bG/wvn
	 EytWUL6LWW1YiGiEsf5g2w7F+EIA7ud5u40x8r64WU9EG2ptzsw3IbLSKLL/XQUmNk
	 NkORhxTHhw8QrigiyoXt6UPm6n1eBH5aWKtPpctk+Hj+4VfpvJ2f3EYIhe1WxdduJp
	 A0UfauJ4tl4Nw==
Date: Tue, 8 Jul 2025 11:34:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
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
Message-ID: <20250708163407.GA2149616@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704161410.3931884-5-claudiu.beznea.uj@bp.renesas.com>

On Fri, Jul 04, 2025 at 07:14:04PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The PCIe IP available on the Renesas RZ/G3S complies with the PCI Express
> Base Specification 4.0. It is designed for root complex applications and
> features a single-lane (x1) implementation. Add documentation for it.

> +++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml

The "r9a08g045s33" in the filename seems oddly specific.  Does it
leave room for descendants of the current chip that will inevitably be
added in the future?  Most bindings are named with a fairly generic
family name, e.g., "fsl,layerscape", "hisilicon,kirin", "intel,
keembay", "samsung,exynos", etc.

> +examples:
> +  - |
> +    #include <dt-bindings/clock/r9a08g045-cpg.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie@11e40000 {
> +            compatible = "renesas,r9a08g045s33-pcie";
> +            reg = <0 0x11e40000 0 0x10000>;
> +            ranges = <0x02000000 0 0x30000000 0 0x30000000 0 0x8000000>;
> +            dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0 0x38000000>;
> +            bus-range = <0x0 0xff>;
> +            clocks = <&cpg CPG_MOD R9A08G045_PCI_ACLK>,
> +                     <&cpg CPG_MOD R9A08G045_PCI_CLKL1PM>;
> +            clock-names = "aclk", "pm";
> +            resets = <&cpg R9A08G045_PCI_ARESETN>,
> +                     <&cpg R9A08G045_PCI_RST_B>,
> +                     <&cpg R9A08G045_PCI_RST_GP_B>,
> +                     <&cpg R9A08G045_PCI_RST_PS_B>,
> +                     <&cpg R9A08G045_PCI_RST_RSM_B>,
> +                     <&cpg R9A08G045_PCI_RST_CFG_B>,
> +                     <&cpg R9A08G045_PCI_RST_LOAD_B>;
> +            reset-names = "aresetn", "rst_b", "rst_gp_b", "rst_ps_b",
> +                          "rst_rsm_b", "rst_cfg_b", "rst_load_b";
> +            interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "serr", "serr_cor", "serr_nonfatal",
> +                              "serr_fatal", "axi_err", "inta",
> +                              "intb", "intc", "intd", "msi",
> +                              "link_bandwidth", "pm_pme", "dma",
> +                              "pcie_evt", "msg", "all";
> +            #interrupt-cells = <1>;
> +            interrupt-controller;
> +            interrupt-map-mask = <0 0 0 7>;
> +            interrupt-map = <0 0 0 1 &pcie 0 0 0 0>, /* INT A */
> +                            <0 0 0 2 &pcie 0 0 0 1>, /* INT B */
> +                            <0 0 0 3 &pcie 0 0 0 2>, /* INT C */
> +                            <0 0 0 4 &pcie 0 0 0 3>; /* INT D */

The spec styles these closed up: "INTA", "INTB", etc.

> +            device_type = "pci";
> +            num-lanes = <1>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            power-domains = <&cpg>;
> +            vendor-id = <0x1912>;
> +            device-id = <0x0033>;

Some of this is specific to a Root Port, not to the Root Complex as a
whole.  E.g., device-type = "pci", num-lanes, vendor-id, device-id,
are Root Port properties.  Some of the resets, clocks, and interrupts
might be as well.

I really want to separate those out because even though this
particular version of this PCIe controller only supports a single Root
Port, there are other controllers (and possibly future iterations of
this controller) that support multiple Root Ports, and it makes
maintenance easier if the DT bindings and the driver structures are
similar.

This email includes pointers to sample DT bindings and driver code
that is structured to allow multiple Root Ports:

  https://lore.kernel.org/linux-pci/20250625221653.GA1590146@bhelgaas/

Bjorn

