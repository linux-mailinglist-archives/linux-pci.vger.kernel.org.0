Return-Path: <linux-pci+bounces-37142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AE7BA5337
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 23:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD0338229A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 21:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBA028851E;
	Fri, 26 Sep 2025 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKr/yStd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E244E284672;
	Fri, 26 Sep 2025 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758921985; cv=none; b=cBks1nuWQTk1V99tY/L87PVh5QDNpINatErnxEOykfXXnVBD46xEYS9yqmyXc7pDvnAKR9kByt212VdQzQTJMlMJBpi7swgsbHJ4FI4HXjdvr2gBztvhtS19ZoIWjMsk3LpDgdWUsG19bOriwqPJwS2/R9CSynvTaSsvZsxKJFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758921985; c=relaxed/simple;
	bh=rc40FMK/iH3e7zWd+KjxdrxDzdXmnXRX3uILrqZMdes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSjV9iiO7/6QMvyWYKpGnprOveditIFRqo4ynRQkW/VaLU0pQNiTOfhnlyzVQci2fd1m3zGXCSfOiAUox+RgMAhFc/rU0LNd2oLKjd1NrXavDBCplzN+0yj5GjntFzmiWkIzcScow1FDt8HS+ttwdooQyiMumC7KYf1tqBxv6Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKr/yStd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB906C4CEF4;
	Fri, 26 Sep 2025 21:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758921984;
	bh=rc40FMK/iH3e7zWd+KjxdrxDzdXmnXRX3uILrqZMdes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rKr/yStdG0HH9zTUKLSsq5vxa7EbZc/VXyqHeAa+whlTELJrCYjoLK+3/Z/a8BvFZ
	 VnVOQP/uM9UBqAL8pODw276Kk88v31zYcpTPjVGo0gX1006BDFV9yPojl2f8vwfb0c
	 26adgO1qivhwGh5QXCIz1r6CBySy5nMSpPC2ZZsUDJ7s1Xo6xK45IS5fc4Iv2YZAR0
	 xnbsxf9L/eQGxfmUzDsZ3opgpb/usSGqnu458wekWhkLwvt6l7d7jjtsfZDEXfndh7
	 GfEaqwNRZhCTYE6AU6wt5IaRYjWiL42uhc19avLSYNyjIC6uC66nH/I3aKKFlmN8mP
	 F1a+qNF3dVEYA==
Date: Fri, 26 Sep 2025 16:26:12 -0500
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
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com
Subject: Re: [PATCH v3 2/4] dt-bindings: PCI: mediatek: Convert to YAML schema
Message-ID: <20250926212612.GA1573360-robh@kernel.org>
References: <20250925162332.9794-1-ansuelsmth@gmail.com>
 <20250925162332.9794-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925162332.9794-3-ansuelsmth@gmail.com>

On Thu, Sep 25, 2025 at 06:23:16PM +0200, Christian Marangi wrote:
> Convert the PCI mediatek Documentation to YAML schema to enable
> validation of the supported GEN1/2 Mediatek PCIe controller.
> 
> While converting, lots of cleanup were done from the .txt with better
> specifying what is supported by the various PCIe controller variant and
> drop of redundant info that are part of the standard PCIe Host Bridge
> schema.
> 
> To reduce schema complexity the .txt is split in 2 YAML, one for
> mt7623/mt2701 and the other for every other compatible.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/pci/mediatek-pcie-mt7623.yaml    | 173 ++++++++
>  .../devicetree/bindings/pci/mediatek-pcie.txt | 289 -------------
>  .../bindings/pci/mediatek-pcie.yaml           | 404 ++++++++++++++++++
>  3 files changed, 577 insertions(+), 289 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-mt7623.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-mt7623.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-mt7623.yaml
> new file mode 100644
> index 000000000000..2f201c84e29a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-mt7623.yaml
> @@ -0,0 +1,173 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/mediatek-pcie-mt7623.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe controller on MediaTek SoCs
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt2701-pcie
> +      - mediatek,mt7623-pcie
> +
> +  reg:
> +    minItems: 4
> +    maxItems: 4
> +
> +  reg-names:
> +    items:
> +      - const: subsys
> +      - const: port0
> +      - const: port1
> +      - const: port2
> +
> +  clocks:
> +    minItems: 4
> +    maxItems: 4
> +
> +  clock-names:
> +    items:
> +      - const: free_ck
> +      - const: sys_ck0
> +      - const: sys_ck1
> +      - const: sys_ck2
> +
> +  resets:
> +    minItems: 3
> +    maxItems: 3
> +
> +  reset-names:
> +    items:
> +      - const: pcie-rst0
> +      - const: pcie-rst1
> +      - const: pcie-rst2
> +
> +  phys:
> +    minItems: 3
> +    maxItems: 3
> +
> +  phy-names:
> +    items:
> +      - const: pcie-phy0
> +      - const: pcie-phy1
> +      - const: pcie-phy2
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - ranges
> +  - clocks
> +  - clock-names
> +  - '#interrupt-cells'
> +  - resets
> +  - reset-names
> +  - phys
> +  - phy-names
> +  - power-domains
> +  - pcie@0,0
> +  - pcie@1,0
> +  - pcie@2,0
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
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

Drop this node. It's not part of this schema.

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

Use <> on each entry.

> +
> +            pcie@0,0 {
> +                device_type = "pci";
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
> +                device_type = "pci";
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
> +                device_type = "pci";
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
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> deleted file mode 100644
> index 684227522267..000000000000
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> +++ /dev/null
> @@ -1,289 +0,0 @@
> -MediaTek Gen2 PCIe controller
> -
> -Required properties:
> -- compatible: Should contain one of the following strings:
> -	"mediatek,mt2701-pcie"
> -	"mediatek,mt2712-pcie"
> -	"mediatek,mt7622-pcie"
> -	"mediatek,mt7623-pcie"
> -	"mediatek,mt7629-pcie"
> -	"airoha,en7523-pcie"
> -- device_type: Must be "pci"
> -- reg: Base addresses and lengths of the root ports.
> -- reg-names: Names of the above areas to use during resource lookup.
> -- #address-cells: Address representation for root ports (must be 3)
> -- #size-cells: Size representation for root ports (must be 2)
> -- clocks: Must contain an entry for each entry in clock-names.
> -  See ../clocks/clock-bindings.txt for details.
> -- clock-names:
> -  Mandatory entries:
> -   - sys_ckN :transaction layer and data link layer clock
> -  Required entries for MT2701/MT7623:
> -   - free_ck :for reference clock of PCIe subsys
> -  Required entries for MT2712/MT7622:
> -   - ahb_ckN :AHB slave interface operating clock for CSR access and RC
> -	      initiated MMIO access
> -  Required entries for MT7622:
> -   - axi_ckN :application layer MMIO channel operating clock
> -   - aux_ckN :pe2_mac_bridge and pe2_mac_core operating clock when
> -	      pcie_mac_ck/pcie_pipe_ck is turned off
> -   - obff_ckN :OBFF functional block operating clock
> -   - pipe_ckN :LTSSM and PHY/MAC layer operating clock
> -  where N starting from 0 to one less than the number of root ports.
> -- phys: List of PHY specifiers (used by generic PHY framework).
> -- phy-names : Must be "pcie-phy0", "pcie-phy1", "pcie-phyN".. based on the
> -  number of PHYs as specified in *phys* property.
> -- power-domains: A phandle and power domain specifier pair to the power domain
> -  which is responsible for collapsing and restoring power to the peripheral.
> -- bus-range: Range of bus numbers associated with this controller.
> -- ranges: Ranges for the PCI memory and I/O regions.
> -
> -Required properties for MT7623/MT2701:
> -- #interrupt-cells: Size representation for interrupts (must be 1)
> -- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
> -  Please refer to the standard PCI bus binding document for a more detailed
> -  explanation.
> -- resets: Must contain an entry for each entry in reset-names.
> -  See ../reset/reset.txt for details.
> -- reset-names: Must be "pcie-rst0", "pcie-rst1", "pcie-rstN".. based on the
> -  number of root ports.
> -
> -Required properties for MT2712/MT7622/MT7629:
> --interrupts: A list of interrupt outputs of the controller, must have one
> -	     entry for each PCIe port
> -- interrupt-names: Must include the following entries:
> -	- "pcie_irq": The interrupt that is asserted when an MSI/INTX is received
> -- linux,pci-domain: PCI domain ID. Should be unique for each host controller
> -
> -In addition, the device tree node must have sub-nodes describing each
> -PCIe port interface, having the following mandatory properties:
> -
> -Required properties:
> -- device_type: Must be "pci"
> -- reg: Only the first four bytes are used to refer to the correct bus number
> -  and device number.
> -- #address-cells: Must be 3
> -- #size-cells: Must be 2
> -- #interrupt-cells: Must be 1
> -- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
> -  Please refer to the standard PCI bus binding document for a more detailed
> -  explanation.
> -- ranges: Sub-ranges distributed from the PCIe controller node. An empty
> -  property is sufficient.
> -
> -Examples for MT7623:
> -
> -	hifsys: syscon@1a000000 {
> -		compatible = "mediatek,mt7623-hifsys",
> -			     "mediatek,mt2701-hifsys",
> -			     "syscon";
> -		reg = <0 0x1a000000 0 0x1000>;
> -		#clock-cells = <1>;
> -		#reset-cells = <1>;
> -	};
> -
> -	pcie: pcie@1a140000 {
> -		compatible = "mediatek,mt7623-pcie";
> -		device_type = "pci";
> -		reg = <0 0x1a140000 0 0x1000>, /* PCIe shared registers */
> -		      <0 0x1a142000 0 0x1000>, /* Port0 registers */
> -		      <0 0x1a143000 0 0x1000>, /* Port1 registers */
> -		      <0 0x1a144000 0 0x1000>; /* Port2 registers */
> -		reg-names = "subsys", "port0", "port1", "port2";
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		#interrupt-cells = <1>;
> -		interrupt-map-mask = <0xf800 0 0 0>;
> -		interrupt-map = <0x0000 0 0 0 &sysirq GIC_SPI 193 IRQ_TYPE_LEVEL_LOW>,
> -				<0x0800 0 0 0 &sysirq GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>,
> -				<0x1000 0 0 0 &sysirq GIC_SPI 195 IRQ_TYPE_LEVEL_LOW>;
> -		clocks = <&topckgen CLK_TOP_ETHIF_SEL>,
> -			 <&hifsys CLK_HIFSYS_PCIE0>,
> -			 <&hifsys CLK_HIFSYS_PCIE1>,
> -			 <&hifsys CLK_HIFSYS_PCIE2>;
> -		clock-names = "free_ck", "sys_ck0", "sys_ck1", "sys_ck2";
> -		resets = <&hifsys MT2701_HIFSYS_PCIE0_RST>,
> -			 <&hifsys MT2701_HIFSYS_PCIE1_RST>,
> -			 <&hifsys MT2701_HIFSYS_PCIE2_RST>;
> -		reset-names = "pcie-rst0", "pcie-rst1", "pcie-rst2";
> -		phys = <&pcie0_phy PHY_TYPE_PCIE>, <&pcie1_phy PHY_TYPE_PCIE>,
> -		       <&pcie2_phy PHY_TYPE_PCIE>;
> -		phy-names = "pcie-phy0", "pcie-phy1", "pcie-phy2";
> -		power-domains = <&scpsys MT2701_POWER_DOMAIN_HIF>;
> -		bus-range = <0x00 0xff>;
> -		ranges = <0x81000000 0 0x1a160000 0 0x1a160000 0 0x00010000	/* I/O space */
> -			  0x83000000 0 0x60000000 0 0x60000000 0 0x10000000>;	/* memory space */
> -
> -		pcie@0,0 {
> -			reg = <0x0000 0 0 0 0>;
> -			#address-cells = <3>;
> -			#size-cells = <2>;
> -			#interrupt-cells = <1>;
> -			interrupt-map-mask = <0 0 0 0>;
> -			interrupt-map = <0 0 0 0 &sysirq GIC_SPI 193 IRQ_TYPE_LEVEL_LOW>;
> -			ranges;
> -		};
> -
> -		pcie@1,0 {
> -			reg = <0x0800 0 0 0 0>;
> -			#address-cells = <3>;
> -			#size-cells = <2>;
> -			#interrupt-cells = <1>;
> -			interrupt-map-mask = <0 0 0 0>;
> -			interrupt-map = <0 0 0 0 &sysirq GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
> -			ranges;
> -		};
> -
> -		pcie@2,0 {
> -			reg = <0x1000 0 0 0 0>;
> -			#address-cells = <3>;
> -			#size-cells = <2>;
> -			#interrupt-cells = <1>;
> -			interrupt-map-mask = <0 0 0 0>;
> -			interrupt-map = <0 0 0 0 &sysirq GIC_SPI 195 IRQ_TYPE_LEVEL_LOW>;
> -			ranges;
> -		};
> -	};
> -
> -Examples for MT2712:
> -
> -	pcie1: pcie@112ff000 {
> -		compatible = "mediatek,mt2712-pcie";
> -		device_type = "pci";
> -		reg = <0 0x112ff000 0 0x1000>;
> -		reg-names = "port1";
> -		linux,pci-domain = <1>;
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names = "pcie_irq";
> -		clocks = <&topckgen CLK_TOP_PE2_MAC_P1_SEL>,
> -			 <&pericfg CLK_PERI_PCIE1>;
> -		clock-names = "sys_ck1", "ahb_ck1";
> -		phys = <&u3port1 PHY_TYPE_PCIE>;
> -		phy-names = "pcie-phy1";
> -		bus-range = <0x00 0xff>;
> -		ranges = <0x82000000 0 0x11400000  0x0 0x11400000  0 0x300000>;
> -		status = "disabled";
> -
> -		#interrupt-cells = <1>;
> -		interrupt-map-mask = <0 0 0 7>;
> -		interrupt-map = <0 0 0 1 &pcie_intc1 0>,
> -				<0 0 0 2 &pcie_intc1 1>,
> -				<0 0 0 3 &pcie_intc1 2>,
> -				<0 0 0 4 &pcie_intc1 3>;
> -		pcie_intc1: interrupt-controller {
> -			interrupt-controller;
> -			#address-cells = <0>;
> -			#interrupt-cells = <1>;
> -		};
> -	};
> -
> -	pcie0: pcie@11700000 {
> -		compatible = "mediatek,mt2712-pcie";
> -		device_type = "pci";
> -		reg = <0 0x11700000 0 0x1000>;
> -		reg-names = "port0";
> -		linux,pci-domain = <0>;
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names = "pcie_irq";
> -		clocks = <&topckgen CLK_TOP_PE2_MAC_P0_SEL>,
> -			 <&pericfg CLK_PERI_PCIE0>;
> -		clock-names = "sys_ck0", "ahb_ck0";
> -		phys = <&u3port0 PHY_TYPE_PCIE>;
> -		phy-names = "pcie-phy0";
> -		bus-range = <0x00 0xff>;
> -		ranges = <0x82000000 0 0x20000000 0x0 0x20000000 0 0x10000000>;
> -		status = "disabled";
> -
> -		#interrupt-cells = <1>;
> -		interrupt-map-mask = <0 0 0 7>;
> -		interrupt-map = <0 0 0 1 &pcie_intc0 0>,
> -				<0 0 0 2 &pcie_intc0 1>,
> -				<0 0 0 3 &pcie_intc0 2>,
> -				<0 0 0 4 &pcie_intc0 3>;
> -		pcie_intc0: interrupt-controller {
> -			interrupt-controller;
> -			#address-cells = <0>;
> -			#interrupt-cells = <1>;
> -		};
> -	};
> -
> -Examples for MT7622:
> -
> -	pcie0: pcie@1a143000 {
> -		compatible = "mediatek,mt7622-pcie";
> -		device_type = "pci";
> -		reg = <0 0x1a143000 0 0x1000>;
> -		reg-names = "port0";
> -		linux,pci-domain = <0>;
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_LOW>;
> -		interrupt-names = "pcie_irq";
> -		clocks = <&pciesys CLK_PCIE_P0_MAC_EN>,
> -			 <&pciesys CLK_PCIE_P0_AHB_EN>,
> -			 <&pciesys CLK_PCIE_P0_AUX_EN>,
> -			 <&pciesys CLK_PCIE_P0_AXI_EN>,
> -			 <&pciesys CLK_PCIE_P0_OBFF_EN>,
> -			 <&pciesys CLK_PCIE_P0_PIPE_EN>;
> -		clock-names = "sys_ck0", "ahb_ck0", "aux_ck0",
> -			      "axi_ck0", "obff_ck0", "pipe_ck0";
> -
> -		power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
> -		bus-range = <0x00 0xff>;
> -		ranges = <0x82000000 0 0x20000000  0x0 0x20000000  0 0x8000000>;
> -		status = "disabled";
> -
> -		#interrupt-cells = <1>;
> -		interrupt-map-mask = <0 0 0 7>;
> -		interrupt-map = <0 0 0 1 &pcie_intc0 0>,
> -				<0 0 0 2 &pcie_intc0 1>,
> -				<0 0 0 3 &pcie_intc0 2>,
> -				<0 0 0 4 &pcie_intc0 3>;
> -		pcie_intc0: interrupt-controller {
> -			interrupt-controller;
> -			#address-cells = <0>;
> -			#interrupt-cells = <1>;
> -		};
> -	};
> -
> -	pcie1: pcie@1a145000 {
> -		compatible = "mediatek,mt7622-pcie";
> -		device_type = "pci";
> -		reg = <0 0x1a145000 0 0x1000>;
> -		reg-names = "port1";
> -		linux,pci-domain = <1>;
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
> -		interrupt-names = "pcie_irq";
> -		clocks = <&pciesys CLK_PCIE_P1_MAC_EN>,
> -			 /* designer has connect RC1 with p0_ahb clock */
> -			 <&pciesys CLK_PCIE_P0_AHB_EN>,
> -			 <&pciesys CLK_PCIE_P1_AUX_EN>,
> -			 <&pciesys CLK_PCIE_P1_AXI_EN>,
> -			 <&pciesys CLK_PCIE_P1_OBFF_EN>,
> -			 <&pciesys CLK_PCIE_P1_PIPE_EN>;
> -		clock-names = "sys_ck1", "ahb_ck1", "aux_ck1",
> -			      "axi_ck1", "obff_ck1", "pipe_ck1";
> -
> -		power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
> -		bus-range = <0x00 0xff>;
> -		ranges = <0x82000000 0 0x28000000  0x0 0x28000000  0 0x8000000>;
> -		status = "disabled";
> -
> -		#interrupt-cells = <1>;
> -		interrupt-map-mask = <0 0 0 7>;
> -		interrupt-map = <0 0 0 1 &pcie_intc1 0>,
> -				<0 0 0 2 &pcie_intc1 1>,
> -				<0 0 0 3 &pcie_intc1 2>,
> -				<0 0 0 4 &pcie_intc1 3>;
> -		pcie_intc1: interrupt-controller {
> -			interrupt-controller;
> -			#address-cells = <0>;
> -			#interrupt-cells = <1>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> new file mode 100644
> index 000000000000..e3afedb77a01
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> @@ -0,0 +1,404 @@
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
> +      - enum:
> +          - mediatek,mt2712-pcie
> +          - mediatek,mt7622-pcie
> +          - mediatek,mt7629-pcie
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

Looks to me like max is 1 entry which is either port0 or port1.

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

Isn't the max 1?

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
> +  - interrupts
> +  - interrupt-names
> +  - interrupt-controller
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
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

The point of spliting this into 2 schemas was to reduce or get rid of 
all the if/then schemas.

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

This goes in the top-level.

> +
> +        power-domains: false
> +
> +      required:
> +        - phys
> +        - phy-names
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

Move this list to the top level and this should only be 'minItems: 6' 
here.

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
> +unevaluatedProperties: false
> +
> +examples:
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

