Return-Path: <linux-pci+bounces-37808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E58BCD86E
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 16:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5BE3B067C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 14:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0EE2F5A0E;
	Fri, 10 Oct 2025 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOA+t+no"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178C62F5339;
	Fri, 10 Oct 2025 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760106596; cv=none; b=SqGi97h89aTn1m43zoLQfF1Ezo9skY1Sswg0henwe5+q6UqVUqNFJFMyMfzy8tvIW8xDpc4nUwi6wEEXSRMmrA1aDYTztVGCPE7oOLCAHEDHEJ8Q2MlE03COm9eoE4oRUdFcmBDqnNHXjFAFGiSxEfJUlICHsC4GTgCvlEcSc8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760106596; c=relaxed/simple;
	bh=yl9lTNG9cI7kGqEr96VCPMwNc3S+w7x6EZzUyQ7so/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2U4DsRFnfXLGtcPOUbT2Mq1J0+MdGxbhU+C9KQTkkvR4cC7lY0oi8bRBPla9W8Cn38kc6f35pZCTyPSh7SD1IMcI0uyJt1fwess9BwMEpmLD3YRiLo5KWK/QHiesjbo7lRYMT1hE8X908fMr9V+BW3fzxxnD+YceASMHuSLdb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOA+t+no; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69632C4CEF1;
	Fri, 10 Oct 2025 14:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760106595;
	bh=yl9lTNG9cI7kGqEr96VCPMwNc3S+w7x6EZzUyQ7so/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rOA+t+not28skCwTqf3HLSbpAi/LM0gSw604PbQ8Yh2RuM3lcelUMVzW7yb7AZsSn
	 /+NybYpnrGempOSv1xB7TBnSrUo4PeYxEJaPgszGz+l5EOKrJAIOmpwgdpljp74uWZ
	 D3jx4lYdHKkJRME+L4p0b5cMHd82yoH+SHHMqxTH0Ngj5tXaTXktkzrUw0ywVnh4yC
	 thOl+I5b6vlF6RPrBgx5f0XvuTNc9Lx/3fRhbAEh2jBOFmkPPfHKNvQ6rnJQlrRhSl
	 gVkvkLK7YcXQKUK23j8pwUGyAjzEJilCozzihElzVpSR75cX4t61ioMwb7ntH0mI94
	 NocKQTDE6RPBA==
Date: Fri, 10 Oct 2025 09:29:53 -0500
From: Rob Herring <robh@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add
 documentation for the PCIe IP on Renesas RZ/G3S
Message-ID: <20251010142953.GA242024-robh@kernel.org>
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
 <20251007133657.390523-2-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007133657.390523-2-claudiu.beznea.uj@bp.renesas.com>

On Tue, Oct 07, 2025 at 04:36:52PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The PCIe IP available on the Renesas RZ/G3S complies with the PCI Express
> Base Specification 4.0. It is designed for root complex applications and
> features a single-lane (x1) implementation. Add documentation for it.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v5:
> - dropped Tb tag
> - style updates to the dma-ranges and ranges properties from
>   examples section
> - re-enabled the node from examples section
> 
> Changes in v4:
> - dropped "s33" string from compatible name
> - added port node documentation; due to this dropped Rob's Rb tag
> - reorderded properties
> - dropped spaces b/w "INT" and "A", "B", "C", "D" in comments
> 
> Changes in v3:
> - collected tags
> - updated the flags of ranges property from example
> 
> Changes in v2:
> - update the interrupt names by dropping "int" and "rc" string; due
>   to this the patch description was adjusted
> - added "interrupt-controller" and made it mandatory
> - s/clkl1pm/pm/g
> - dropped the legacy-interrupt-controller node; with this the gic
>   interrupt controller node was dropped as well as it is not needed
>   anymore
> - updated interrupt-map in example and added interrupt-controller
> - added clock-names as required property as the pm clock is not
>   handled though PM domains; this will allow the driver to have
>   the option to request the pm clock by its name when implementation
>   will be adjusted to used the pm clock
> - adjusted the size of dma-ranges to reflect the usage on
>   SMARC module board
> - moved "renesas,sysc" at the end of the node in example to align
>   with dts coding style
> 
>  .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 239 ++++++++++++++++++
>  1 file changed, 239 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
> new file mode 100644
> index 000000000000..d21d16b4e28d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
> @@ -0,0 +1,239 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/renesas,r9a08g045-pcie.yaml#
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
> +    const: renesas,r9a08g045-pcie # RZ/G3S
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
> +      - description: serr
> +      - description: ser_cor
> +      - description: serr_nonfatal
> +      - description: serr_fatal
> +      - description: axi_err
> +      - description: inta
> +      - description: intb
> +      - description: intc
> +      - description: intd
> +      - description: msi
> +      - description: link_bandwidth
> +      - description: pm_pme
> +      - description: dma
> +      - description: pcie_evt
> +      - description: msg
> +      - description: all
> +
> +  interrupt-controller: true
> +
> +  clocks:
> +    items:
> +      - description: System clock
> +      - description: PM control clock
> +
> +  clock-names:
> +    items:
> +      - description: aclk
> +      - description: pm
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

Please say something about what controls are in this.

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +patternProperties:
> +  "^pcie@0,[0-0]$":
> +    type: object
> +    allOf:
> +      - $ref: /schemas/pci/pci-device.yaml#

A PCI-PCI bridge is a PCI device, so drop.

> +      - $ref: /schemas/pci/pci-pci-bridge.yaml#
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      vendor-id:
> +        const: 0x1912
> +
> +      device-id:
> +        const: 0x0033
> +
> +      clocks:
> +        items:
> +          - description: Reference clock
> +
> +      clock-names:
> +        items:
> +          - const: ref
> +
> +    required:
> +      - device_type
> +      - vendor-id
> +      - device-id
> +      - clocks
> +      - clock-names
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - interrupts
> +  - interrupt-names
> +  - interrupt-map
> +  - interrupt-map-mask
> +  - interrupt-controller
> +  - power-domains
> +  - "#address-cells"
> +  - "#size-cells"
> +  - "#interrupt-cells"
> +  - renesas,sysc
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
> +        pcie@11e40000 {
> +            compatible = "renesas,r9a08g045-pcie";
> +            reg = <0 0x11e40000 0 0x10000>;
> +            ranges = <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>;
> +            /* Map all possible DRAM ranges (4 GB). */
> +            dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 1 0x00000000>;
> +            bus-range = <0x0 0xff>;
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
> +            interrupt-map = <0 0 0 1 &pcie 0 0 0 0>, /* INTA */
> +                            <0 0 0 2 &pcie 0 0 0 1>, /* INTB */
> +                            <0 0 0 3 &pcie 0 0 0 2>, /* INTC */
> +                            <0 0 0 4 &pcie 0 0 0 3>; /* INTD */
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
> +            power-domains = <&cpg>;
> +            device_type = "pci";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            max-link-speed = <2>;
> +            renesas,sysc = <&sysc>;
> +
> +            pcie_port0: pcie@0,0 {

Drop unused labels.

> +                reg = <0x0 0x0 0x0 0x0 0x0>;
> +                ranges;
> +                clocks = <&versa3 5>;
> +                clock-names = "ref";
> +                device_type = "pci";
> +                vendor-id = <0x1912>;
> +                device-id = <0x0033>;
> +                #address-cells = <3>;
> +                #size-cells = <2>;
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.43.0
> 

