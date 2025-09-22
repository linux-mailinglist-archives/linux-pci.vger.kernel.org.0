Return-Path: <linux-pci+bounces-36680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A416BB91A76
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 16:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E96D42360F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 14:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CBF1EB9F2;
	Mon, 22 Sep 2025 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeVhvABq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A0B1EA7F4;
	Mon, 22 Sep 2025 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551058; cv=none; b=I5qNvdgLWaiYcSgwfaJjC5AOziFsTGHqUEQiiHWvYWvVsxW4/Bm1rZ1ZRBHr308bEH+BY14b/tIfn7BoQw8lDhh64NiKz4Jt7nV7qKc0KZSaQRWM354QOAkXkUb1aB0tJ2vPexL0EU3TrHYVgGPFpnjbgiqsSIHJsZh5LabDbeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551058; c=relaxed/simple;
	bh=jQtHtAtu5OySNQUZ2//oR7DQqnnmk0wu7kAEitj9Px4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAheknSSXNZGRBXOBTXGSLKUmX789yzBUpqys0MKhmdKHxnL+wFuFbQETOsX6EqiYvdqBWutF5PfBVkQfWiPsqtAfO4j76g4vDeg7e6Zxz0PXiFYOwrUsJT+shrFwN4KcXDQ0SrB9srJhgHbal6mU4a18l5yERWtuGNMVuzj9vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeVhvABq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA95AC4CEF0;
	Mon, 22 Sep 2025 14:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758551058;
	bh=jQtHtAtu5OySNQUZ2//oR7DQqnnmk0wu7kAEitj9Px4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qeVhvABqQVsydEHWe0g9vnzDCMEGqlQ2NnEnCDVfov8k6Ks5laRrOzTwbKEbeoRZs
	 rN1oEjLLQm7xzO00NFEl0XWAPWgzpg/fTEj62BXkCbmeBFgFGpLPeUdGJLKHoTi7Gg
	 lUxO0KQQmq+qrp26TrMqLaa+b86FbRj7/irJby1tRuUrpVU56R+mBwa8jkqKlxIRbO
	 zU7FmM746tfeQoMjo7y81fphZYOaEnTSsQMYSFrfbDNLGoxNj6cDdF90ieZFglLOE+
	 IwNKWuRSeZB+rF+Fqr09bVl0IbwblaH/oSoEXMAC2kz/Ror6cDGpMk571vomAEuY3p
	 RIXZi/caGhXtg==
Date: Mon, 22 Sep 2025 09:24:14 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: PCI: mediatek: Convert to YAML schema
Message-ID: <20250922142414.GA4042309-robh@kernel.org>
References: <20250920114103.16964-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920114103.16964-1-ansuelsmth@gmail.com>

On Sat, Sep 20, 2025 at 01:41:01PM +0200, Christian Marangi wrote:
> Convert the PCI mediatek Documentation to YAML schema to enable
> validation of the supported GEN1/2 Mediatek PCIe controller.
> 
> While converting, lots of cleanup were done from the .txt with better
> specifying what is supported by the various PCIe controller variant and
> drop of redundant info that are part of the standard PCIe Host Bridge
> schema.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/pci/mediatek-pcie.txt | 289 ---------
>  .../bindings/pci/mediatek-pcie.yaml           | 564 ++++++++++++++++++
>  2 files changed, 564 insertions(+), 289 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> 

> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> new file mode 100644
> index 000000000000..f6c391c4add2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> @@ -0,0 +1,564 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/mediatek-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe controller on MediaTek SoCs
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: mediatek,mt2701-pcie
> +      - const: mediatek,mt2712-pcie
> +      - const: mediatek,mt7622-pcie
> +      - const: mediatek,mt7623-pcie
> +      - const: mediatek,mt7629-pcie

These can all be an enum.

> +      - items:
> +          - const: airoha,en7523-pcie
> +          - const: mediatek,mt7622-pcie
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 4
> +
> +  reg-names:
> +    minItems: 1
> +    maxItems: 4
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 6
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 6
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    const: pcie_irq
> +
> +  resets:
> +    minItems: 1
> +    maxItems: 3
> +
> +  reset-names:
> +    minItems: 1
> +    maxItems: 3
> +
> +  phys:
> +    minItems: 1
> +    maxItems: 3
> +
> +  phy-names:
> +    minItems: 1
> +    maxItems: 3
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +  interrupt-controller:
> +    description: Interrupt controller node for handling legacy PCI interrupts.
> +    type: object
> +    properties:
> +      '#address-cells':
> +        const: 0
> +      '#interrupt-cells':
> +        const: 1
> +      interrupt-controller: true
> +
> +    required:
> +      - '#address-cells'
> +      - '#interrupt-cells'
> +      - interrupt-controller
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - ranges
> +  - clocks
> +  - clock-names
> +  - '#interrupt-cells'
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - mediatek,mt2701-pcie
> +            - mediatek,mt7623-pcie

I think these 2 should be a separate schema doc. The resources are a bit 
different compared to the rest. Then reg-names, clock-names, etc. can 
move to the top-level schema.

> +    then:
> +      properties:
> +        reg:
> +          minItems: 4
> +
> +        reg-names:
> +          items:
> +            - const: subsys
> +            - const: port0
> +            - const: port1
> +            - const: port2
> +
> +        clocks:
> +          minItems: 4
> +          maxItems: 4
> +
> +        clock-names:
> +          items:
> +            - const: free_ck
> +            - const: sys_ck0
> +            - const: sys_ck1
> +            - const: sys_ck2
> +
> +        interrupts: false
> +
> +        interrupt-names: false
> +
> +        interrupt-controller: false
> +
> +        resets:
> +          minItems: 3
> +
> +        reset-names:
> +          items:
> +            - const: pcie-rst0
> +            - const: pcie-rst1
> +            - const: pcie-rst2
> +
> +        phys:
> +          minItems: 3
> +
> +        phy-names:
> +          items:
> +            - const: pcie-phy0
> +            - const: pcie-phy1
> +            - const: pcie-phy2
> +
> +      required:
> +        - resets
> +        - reset-names
> +        - phys
> +        - phy-names
> +        - power-domains
> +
> +  - if:
> +      properties:
> +        compatible:
> +          const: mediatek,mt2712-pcie
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 1
> +
> +        reg-names:
> +          items:
> +            - enum: [ port0, port1 ]
> +
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +
> +        clock-names:
> +          items:
> +            - enum: [ sys_ck0, sys_ck1 ]
> +            - enum: [ ahb_ck0, ahb_ck1 ]
> +
> +        reset: false
> +
> +        reset-names: false
> +
> +        phys:
> +          maxItems: 1
> +
> +        phy-names:
> +          items:
> +            - enum: [ pcie-phy0, pcie-phy1 ]
> +
> +      required:
> +        - interrupts
> +        - interrupt-names
> +        - interrupt-controller
> +        - phys
> +        - phy-names
> +        - power-domains
> +
> +  - if:
> +      properties:
> +        compatible:
> +          const: mediatek,mt7622-pcie
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 1
> +
> +        reg-names:
> +          items:
> +            - enum: [ port0, port1 ]
> +
> +        clocks:
> +          minItems: 6
> +          maxItems: 6
> +
> +        clock-names:
> +          items:
> +            - enum: [ sys_ck0, sys_ck1 ]
> +            - enum: [ ahb_ck0, ahb_ck1 ]
> +            - enum: [ aux_ck0, aux_ck1 ]
> +            - enum: [ axi_ck0, axi_ck1 ]
> +            - enum: [ obff_ck0, obff_ck1 ]
> +            - enum: [ pipe_ck0, pipe_ck1 ]
> +
> +        reset: false
> +
> +        reset-names: false
> +
> +        phys: false
> +
> +        phy-names: false
> +
> +      required:
> +        - interrupts
> +        - interrupt-names
> +        - interrupt-controller
> +        - power-domains
> +
> +  - if:
> +      properties:
> +        compatible:
> +          const: mediatek,mt7629-pcie
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 1
> +
> +        reg-names:
> +          items:
> +            - enum: [ port0, port1 ]
> +
> +        clocks:
> +          minItems: 6
> +          maxItems: 6
> +
> +        clock-names:
> +          items:
> +            - enum: [ sys_ck0, sys_ck1 ]
> +            - enum: [ ahb_ck0, ahb_ck1 ]
> +            - enum: [ aux_ck0, aux_ck1 ]
> +            - enum: [ axi_ck0, axi_ck1 ]
> +            - enum: [ obff_ck0, obff_ck1 ]
> +            - enum: [ pipe_ck0, pipe_ck1 ]
> +
> +        reset: false
> +
> +        reset-names: false
> +
> +        phys:
> +          maxItems: 1
> +
> +        phy-names:
> +          items:
> +            - enum: [ pcie-phy0, pcie-phy1 ]
> +
> +      required:
> +        - interrupts
> +        - interrupt-names
> +        - interrupt-controller
> +        - power-domains
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: airoha,en7523-pcie
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 1
> +
> +        reg-names:
> +          items:
> +            - enum: [ port0, port1 ]
> +
> +        clocks:
> +          maxItems: 1
> +
> +        clock-names:
> +          items:
> +            - enum: [ sys_ck0, sys_ck1 ]
> +
> +        reset: false
> +
> +        reset-names: false
> +
> +        phys: false
> +
> +        phy-names: false
> +
> +        power-domain: false
> +
> +      required:
> +        - interrupts
> +        - interrupt-names
> +        - interrupt-controller
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  # MT7623
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/mt2701-clk.h>
> +    #include <dt-bindings/reset/mt2701-resets.h>
> +    #include <dt-bindings/phy/phy.h>
> +    #include <dt-bindings/power/mt2701-power.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        hifsys: syscon@1a000000 {
> +            compatible = "mediatek,mt7623-hifsys",
> +                        "mediatek,mt2701-hifsys",
> +                        "syscon";
> +            reg = <0 0x1a000000 0 0x1000>;
> +            #clock-cells = <1>;
> +            #reset-cells = <1>;
> +        };
> +
> +        pcie@1a140000 {
> +            compatible = "mediatek,mt7623-pcie";
> +            device_type = "pci";
> +            reg = <0 0x1a140000 0 0x1000>, /* PCIe shared registers */
> +                  <0 0x1a142000 0 0x1000>, /* Port0 registers */
> +                  <0 0x1a143000 0 0x1000>, /* Port1 registers */
> +                  <0 0x1a144000 0 0x1000>; /* Port2 registers */
> +            reg-names = "subsys", "port0", "port1", "port2";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0xf800 0 0 0>;
> +            interrupt-map = <0x0000 0 0 0 &sysirq GIC_SPI 193 IRQ_TYPE_LEVEL_LOW>,
> +                            <0x0800 0 0 0 &sysirq GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>,
> +                            <0x1000 0 0 0 &sysirq GIC_SPI 195 IRQ_TYPE_LEVEL_LOW>;
> +            clocks = <&topckgen CLK_TOP_ETHIF_SEL>,
> +                    <&hifsys CLK_HIFSYS_PCIE0>,
> +                    <&hifsys CLK_HIFSYS_PCIE1>,
> +                    <&hifsys CLK_HIFSYS_PCIE2>;
> +            clock-names = "free_ck", "sys_ck0", "sys_ck1", "sys_ck2";
> +            resets = <&hifsys MT2701_HIFSYS_PCIE0_RST>,
> +                     <&hifsys MT2701_HIFSYS_PCIE1_RST>,
> +                     <&hifsys MT2701_HIFSYS_PCIE2_RST>;
> +            reset-names = "pcie-rst0", "pcie-rst1", "pcie-rst2";
> +            phys = <&pcie0_phy PHY_TYPE_PCIE>, <&pcie1_phy PHY_TYPE_PCIE>,
> +                   <&pcie2_phy PHY_TYPE_PCIE>;
> +            phy-names = "pcie-phy0", "pcie-phy1", "pcie-phy2";
> +            power-domains = <&scpsys MT2701_POWER_DOMAIN_HIF>;
> +            bus-range = <0x00 0xff>;
> +            ranges = <0x81000000 0 0x1a160000 0 0x1a160000 0 0x00010000	/* I/O space */
> +                      0x83000000 0 0x60000000 0 0x60000000 0 0x10000000>;	/* memory space */
> +
> +            pcie@0,0 {

If these nodes are required, then the schema should say that.

> +                reg = <0x0000 0 0 0 0>;
> +                #address-cells = <3>;
> +                #size-cells = <2>;
> +                #interrupt-cells = <1>;
> +                interrupt-map-mask = <0 0 0 0>;
> +                interrupt-map = <0 0 0 0 &sysirq GIC_SPI 193 IRQ_TYPE_LEVEL_LOW>;
> +                ranges;
> +            };
> +
> +            pcie@1,0 {
> +                reg = <0x0800 0 0 0 0>;
> +                #address-cells = <3>;
> +                #size-cells = <2>;
> +                #interrupt-cells = <1>;
> +                interrupt-map-mask = <0 0 0 0>;
> +                interrupt-map = <0 0 0 0 &sysirq GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
> +                ranges;
> +            };
> +
> +            pcie@2,0 {
> +                reg = <0x1000 0 0 0 0>;
> +                #address-cells = <3>;
> +                #size-cells = <2>;
> +                #interrupt-cells = <1>;
> +                interrupt-map-mask = <0 0 0 0>;
> +                interrupt-map = <0 0 0 0 &sysirq GIC_SPI 195 IRQ_TYPE_LEVEL_LOW>;
> +                ranges;
> +            };
> +        };
> +    };
> +
> +  # MT2712
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/phy/phy.h>
> +
> +    soc_1 {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie@112ff000 {
> +            compatible = "mediatek,mt2712-pcie";
> +            device_type = "pci";
> +            reg = <0 0x112ff000 0 0x1000>;
> +            reg-names = "port1";
> +            linux,pci-domain = <1>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "pcie_irq";
> +            clocks = <&topckgen>, /* CLK_TOP_PE2_MAC_P1_SEL */
> +                     <&pericfg>; /* CLK_PERI_PCIE1 */
> +            clock-names = "sys_ck1", "ahb_ck1";
> +            phys = <&u3port1 PHY_TYPE_PCIE>;
> +            phy-names = "pcie-phy1";
> +            bus-range = <0x00 0xff>;
> +            ranges = <0x82000000 0 0x11400000  0x0 0x11400000  0 0x300000>;
> +            status = "disabled";

Examples should be enabled...

> +
> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0 0 0 7>;
> +            interrupt-map = <0 0 0 1 &pcie_intc1 0>,
> +                            <0 0 0 2 &pcie_intc1 1>,
> +                            <0 0 0 3 &pcie_intc1 2>,
> +                            <0 0 0 4 &pcie_intc1 3>;
> +            pcie_intc1: interrupt-controller {
> +                interrupt-controller;
> +                #address-cells = <0>;
> +                #interrupt-cells = <1>;
> +            };
> +        };
> +
> +        pcie@11700000 {
> +            compatible = "mediatek,mt2712-pcie";
> +            device_type = "pci";
> +            reg = <0 0x11700000 0 0x1000>;
> +            reg-names = "port0";
> +            linux,pci-domain = <0>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "pcie_irq";
> +            clocks = <&topckgen>, /* CLK_TOP_PE2_MAC_P0_SEL */
> +                     <&pericfg>; /* CLK_PERI_PCIE0 */
> +            clock-names = "sys_ck0", "ahb_ck0";
> +            phys = <&u3port0 PHY_TYPE_PCIE>;
> +            phy-names = "pcie-phy0";
> +            bus-range = <0x00 0xff>;
> +            ranges = <0x82000000 0 0x20000000 0x0 0x20000000 0 0x10000000>;
> +            status = "disabled";
> +
> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0 0 0 7>;
> +            interrupt-map = <0 0 0 1 &pcie_intc0 0>,
> +                            <0 0 0 2 &pcie_intc0 1>,
> +                            <0 0 0 3 &pcie_intc0 2>,
> +                            <0 0 0 4 &pcie_intc0 3>;
> +            pcie_intc0: interrupt-controller {
> +                interrupt-controller;
> +                #address-cells = <0>;
> +                #interrupt-cells = <1>;
> +            };
> +        };
> +    };
> +
> +  # MT7622
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/power/mt7622-power.h>
> +
> +    soc_2 {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie@1a143000 {
> +            compatible = "mediatek,mt7622-pcie";
> +            device_type = "pci";
> +            reg = <0 0x1a143000 0 0x1000>;
> +            reg-names = "port0";
> +            linux,pci-domain = <0>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_LOW>;
> +            interrupt-names = "pcie_irq";
> +            clocks = <&pciesys>, /* CLK_PCIE_P0_MAC_EN */
> +                     <&pciesys>, /* CLK_PCIE_P0_AHB_EN */
> +                     <&pciesys>, /* CLK_PCIE_P0_AUX_EN */
> +                     <&pciesys>, /* CLK_PCIE_P0_AXI_EN */
> +                     <&pciesys>, /* CLK_PCIE_P0_OBFF_EN */
> +                     <&pciesys>; /* CLK_PCIE_P0_PIPE_EN */
> +            clock-names = "sys_ck0", "ahb_ck0", "aux_ck0",
> +                          "axi_ck0", "obff_ck0", "pipe_ck0";
> +
> +            power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
> +            bus-range = <0x00 0xff>;
> +            ranges = <0x82000000 0 0x20000000  0x0 0x20000000  0 0x8000000>;
> +            status = "disabled";
> +
> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0 0 0 7>;
> +            interrupt-map = <0 0 0 1 &pcie_intc0_1 0>,
> +                            <0 0 0 2 &pcie_intc0_1 1>,
> +                            <0 0 0 3 &pcie_intc0_1 2>,
> +                            <0 0 0 4 &pcie_intc0_1 3>;
> +            pcie_intc0_1: interrupt-controller {
> +                interrupt-controller;
> +                #address-cells = <0>;
> +                #interrupt-cells = <1>;
> +            };
> +        };
> +
> +        pcie@1a145000 {
> +            compatible = "mediatek,mt7622-pcie";
> +            device_type = "pci";
> +            reg = <0 0x1a145000 0 0x1000>;
> +            reg-names = "port1";
> +            linux,pci-domain = <1>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
> +            interrupt-names = "pcie_irq";
> +            clocks = <&pciesys>, /* CLK_PCIE_P1_MAC_EN */
> +                     /* designer has connect RC1 with p0_ahb clock */
> +                     <&pciesys>, /* CLK_PCIE_P0_AHB_EN */
> +                     <&pciesys>, /* CLK_PCIE_P1_AUX_EN */
> +                     <&pciesys>, /* CLK_PCIE_P1_AXI_EN */
> +                     <&pciesys>, /* CLK_PCIE_P1_OBFF_EN */
> +                     <&pciesys>; /* CLK_PCIE_P1_PIPE_EN */
> +            clock-names = "sys_ck1", "ahb_ck1", "aux_ck1",
> +                          "axi_ck1", "obff_ck1", "pipe_ck1";
> +
> +            power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
> +            bus-range = <0x00 0xff>;
> +            ranges = <0x82000000 0 0x28000000  0x0 0x28000000  0 0x8000000>;
> +            status = "disabled";
> +
> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0 0 0 7>;
> +            interrupt-map = <0 0 0 1 &pcie_intc1_1 0>,
> +                            <0 0 0 2 &pcie_intc1_1 1>,
> +                            <0 0 0 3 &pcie_intc1_1 2>,
> +                            <0 0 0 4 &pcie_intc1_1 3>;
> +            pcie_intc1_1: interrupt-controller {
> +                interrupt-controller;
> +                #address-cells = <0>;
> +                #interrupt-cells = <1>;
> +            };
> +        };
> +    };
> -- 
> 2.51.0
> 

