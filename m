Return-Path: <linux-pci+bounces-27528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6D4AB1EB2
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 23:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7070C17B967
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 21:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBDD25F79A;
	Fri,  9 May 2025 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1We5LSV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345D625394A;
	Fri,  9 May 2025 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746824883; cv=none; b=eop5iszi3W/uth8hHBRR0prgxvv3Eqx39hDwbVWwMIl+BgCKmK2MDp//TsMJBRPGY+VjIZmF3PG0i50KPmnHUsjhQVSLyHL2Zm+jJ0+Lq2N8wWYbyLPzS9GBj+Oi9Ym/P8crFStZ2Av81SGDuPH7w+yoJSIpIPusIWXcLK45dYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746824883; c=relaxed/simple;
	bh=CAxTMPR8YPvt69jMr9a/HnbcXSU4cctemxa+AVtAFbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSpl+t2yU4TWXZA+cWcC7Svz8QeN4PjVdHQRdy/XxIoul5/lRglCzX8mdCnHM8kdmD2/aiETOXzYPcrIrwxZcMiEyt21g1HgxeLDY7C2xcltNHQ0wp8w1Q3QENg0F71+J2juSUTMlli04SNdXzR9/xkzPw3Tf2H3OCBSwaSY1lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1We5LSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72E5C4CEE4;
	Fri,  9 May 2025 21:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746824882;
	bh=CAxTMPR8YPvt69jMr9a/HnbcXSU4cctemxa+AVtAFbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1We5LSVZ15+LhFsS3loTqYybJgPreqHIReEJy176pHa414yKvrmoykEIuRo4INxJ
	 9tmo0mlpg82B/zeb1OcfORrFivYHERRq75Yv6Vdp/9dgYqcoYwSuJlecEw/gLS4BAu
	 oSCsEwzKgHF9HBs2Wy5dS2QnW5SLLZ/GJVCTDyqvKxK/F1/6FRX8KiMgHoTWG3qC6a
	 6N4Y4bwzkA6EOkV5ULEsiXW5ej77xwcstcqJeCw4VJGmbphc8g9GFR9AnDCy0WqWdM
	 ZJ2Pgnklq9pxgw2YzALlThXNoxta6p5G+xD9OaEgPPtXQVnhs2Q/5Due7BvPpALYOv
	 FlUOoI4RB3oGA==
Date: Fri, 9 May 2025 16:08:00 -0500
From: Rob Herring <robh@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
	mturquette@baylibre.com, sboyd@kernel.org, saravanak@google.com,
	p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 4/8] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add
 documentation for the PCIe IP on Renesas RZ/G3S
Message-ID: <20250509210800.GB4080349-robh@kernel.org>
References: <20250430103236.3511989-1-claudiu.beznea.uj@bp.renesas.com>
 <20250430103236.3511989-5-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430103236.3511989-5-claudiu.beznea.uj@bp.renesas.com>

On Wed, Apr 30, 2025 at 01:32:32PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The PCIe IP available on the Renesas RZ/G3S complies with the PCI Express
> Base Specification 4.0. It is designed for root complex applications and
> features a single-lane (x1) implementation. Add documentation for it.
> The interrupts, interrupt-names, resets, reset-names, clocks, clock-names
> description were obtained from the hardware manual.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  .../pci/renesas,r9a08g045s33-pcie.yaml        | 242 ++++++++++++++++++
>  1 file changed, 242 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml
> new file mode 100644
> index 000000000000..354f9c3be139
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml
> @@ -0,0 +1,242 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/renesas,r9a08g045s33-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G3S PCIe host controller
> +
> +maintainers:
> +  - Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> +
> +description:
> +  Renesas RZ/G3S PCIe host controller complies with PCIe Base Specification
> +  4.0 and supports up to 5 GT/s (Gen2).
> +
> +properties:
> +  compatible:
> +    const: renesas,r9a08g045s33-pcie # RZ/G3S
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: System error interrupt
> +      - description: System error on correctable error interrupt
> +      - description: System error on non-fatal error interrupt
> +      - description: System error on fatal error interrupt
> +      - description: AXI error interrupt
> +      - description: INTA interrupt
> +      - description: INTB interrupt
> +      - description: INTC interrupt
> +      - description: INTD interrupt
> +      - description: MSI interrupt
> +      - description: Link bandwidth interrupt
> +      - description: PME interrupt
> +      - description: DMA interrupt
> +      - description: PCIe event interrupt
> +      - description: Message interrupt
> +      - description: All interrupts
> +
> +  interrupt-names:
> +    items:
> +      - description: int_serr
> +      - description: int_ser_cor
> +      - description: int_serr_nonfatal
> +      - description: int_serr_fatal
> +      - description: axi_err_int
> +      - description: inta_rc
> +      - description: intb_rc
> +      - description: intc_rc
> +      - description: intd_rc
> +      - description: intmsi_rc

Isn't every interrupt for the root complex?

> +      - description: int_link_bandwidth
> +      - description: int_pm_pme
> +      - description: dma_int
> +      - description: pcie_evt_int
> +      - description: msg_int
> +      - description: int_all

'int_' or '_int' is redundant (and inconsistent). Drop.

> +
> +  clocks:
> +    items:
> +      - description: System clock
> +      - description: PM control clock
> +
> +  clock-names:
> +    items:
> +      - description: aclk
> +      - description: clkl1pm

'l1pm' or 'pm'

> +
> +  resets:
> +    items:
> +      - description: AXI2PCIe Bridge reset
> +      - description: Data link layer/transaction layer reset
> +      - description: Transaction layer (ACLK domain) reset
> +      - description: Transaction layer (PCLK domain) reset
> +      - description: Physical layer reset
> +      - description: Configuration register reset
> +      - description: Configuration register reset
> +
> +  reset-names:
> +    items:
> +      - description: aresetn
> +      - description: rst_b
> +      - description: rst_gp_b
> +      - description: rst_ps_b
> +      - description: rst_rsm_b
> +      - description: rst_cfg_b
> +      - description: rst_load_b
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  dma-ranges:
> +    description:
> +      A single range for the inbound memory region.
> +    maxItems: 1
> +
> +  renesas,sysc:
> +    description: System controller phandle
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  vendor-id:
> +    const: 0x1912
> +
> +  device-id:
> +    const: 0x0033
> +
> +  legacy-interrupt-controller:
> +    description: Interrupt controller node for handling legacy PCI interrupts
> +    type: object
> +
> +    properties:
> +      "#address-cells":
> +        const: 0
> +
> +      "#interrupt-cells":
> +        const: 1
> +
> +      interrupt-controller: true
> +
> +      interrupts:
> +        items:
> +          - description: INTA interrupt
> +          - description: INTB interrupt
> +          - description: INTC interrupt
> +          - description: INTD interrupt
> +
> +    required:
> +      - "#address-cells"
> +      - "#interrupt-cells"
> +      - interrupt-controller
> +      - interrupts
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +  - reset-names
> +  - interrupts
> +  - interrupt-names
> +  - interrupt-map
> +  - interrupt-map-mask
> +  - power-domains
> +  - "#address-cells"
> +  - "#size-cells"
> +  - "#interrupt-cells"
> +  - renesas,sysc
> +  - vendor-id
> +  - device-id
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r9a08g045-cpg.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        gic: interrupt-controller {
> +            interrupt-controller;
> +            #interrupt-cells = <3>;
> +        };

Drop. Don't need to show provider nodes for the example.

> +
> +        pcie@11e40000 {
> +            compatible = "renesas,r9a08g045s33-pcie";
> +            reg = <0 0x11e40000 0 0x10000>;
> +            ranges = <0x03000000 0 0x30000000 0 0x30000000 0 0x8000000>;
> +            dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0 0x8000000>;
> +            bus-range = <0x0 0xff>;
> +            clocks = <&cpg CPG_MOD R9A08G045_PCI_ACLK>,
> +                     <&cpg CPG_MOD R9A08G045_PCI_CLKL1PM>;
> +            clock-names = "aclk", "clkl1pm";
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

It is very odd that you have the INTx interrupts here and below.

As I mentioned in the driver, you don't need the legacy node any more. 
Just add 'interrupt-controller' to this node and point interrupt-map to 
this node.

> +                         <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "int_serr", "int_serr_cor", "int_serr_nonfatal",
> +                              "int_serr_fatal", "axi_err_int", "inta_rc",
> +                              "intb_rc", "intc_rc", "intd_rc",
> +                              "intmsi_rc", "int_link_bandwidth", "int_pm_pme",
> +                              "dma_int", "pcie_evt_int", "msg_int",
> +                              "int_all";
> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0 0 0 7>;
> +            interrupt-map = <0 0 0 1 &pcie_intx 0>, /* INT A */
> +                            <0 0 0 2 &pcie_intx 1>, /* INT B */
> +                            <0 0 0 3 &pcie_intx 2>, /* INT C */
> +                            <0 0 0 4 &pcie_intx 3>; /* INT D */
> +            device_type = "pci";
> +            num-lanes = <1>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            power-domains = <&cpg>;
> +            renesas,sysc = <&sysc>;
> +            vendor-id = <0x1912>;
> +            device-id = <0x0033>;
> +
> +            pcie_intx: legacy-interrupt-controller {
> +                interrupt-controller;
> +                #interrupt-cells = <1>;
> +                #address-cells = <0>;
> +                interrupt-parent = <&gic>;
> +                interrupts = <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
> +                             <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
> +                             <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
> +                             <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>;
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.43.0
> 

