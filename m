Return-Path: <linux-pci+bounces-17996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67F39EAB0E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 09:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E6C166A7C
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 08:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AC722E3F8;
	Tue, 10 Dec 2024 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6NiurQQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D882F12DD88;
	Tue, 10 Dec 2024 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820771; cv=none; b=VWmycLt50XO9RcLQN7ZrmlGPnfOL8xcJR7qUr4+szXZl8bWsFrrQBxYP9qubvdFCN27jf6YqDBbInLq41d2qqxqgvzLd+ZHc7OButvQzFg0QpvcTwfHrnQwzZEDxxh9BJq8BS3nfsXDTY7lnNQec4PjPRrq1VCGqv2Br3XR4Cuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820771; c=relaxed/simple;
	bh=KP7mBNP2pd/DwOBjVN/npe0wHUj0p6vln405+1vkD6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOmTDuwHyU7sTTl/ekIxOWfxTHgI6YczXjIxScKSdT9eTNi62n2w4QJxeS/2dclHJwputDGeXCDCsrvi09VypEnkGjhx1heqT7ueS/KKiKyo4xlIiPZrqD5bywNjgLMPKcnTKg+DNOlFpkJLlt+9e/k3dC4RMFDI7uMcDf6bVoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6NiurQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6BCC4CED6;
	Tue, 10 Dec 2024 08:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733820770;
	bh=KP7mBNP2pd/DwOBjVN/npe0wHUj0p6vln405+1vkD6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f6NiurQQ4XDxs1gH4XW/dww86rdwL0dyRBY+6cVYQy0dFPRAglysBqyDso5C3KC3R
	 IpdFgRWwWUxxTvvsTOKRlr7kyICGceIqQCtfH+qojPFNpN5S1iWR2Bt6MFP7GuIaYO
	 MwmLF+jKgTihBsI8QxB/WHBsU2Xca8fxgafYjp0pVEPo8WEycukLJ8cd+5T4qh/kMY
	 cfC1j6+8/DATplAI0a8wUogZDvpBBE0cHnSY98sqoSqXnhA8Uxp4zIdf77rqV3kNyF
	 JBGwDKJrC/izfdjhXh1krX1D9xhtdrPJif2nOQWpJbx4Nt9w/PJYWEJ+U4xtN+fuW5
	 mUTCeKhY6fXLQ==
Date: Tue, 10 Dec 2024 09:52:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Frank <Li@nxp.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: PCI: mobiveil: convert
 mobiveil-pcie.txt to yaml format
Message-ID: <t3mrs7bap5fbiyxpth5r364al4ca2s72ddsoqgutbrlhrgwqae@qmcjeis2akwp>
References: <20241206222529.3706373-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241206222529.3706373-1-Frank.Li@nxp.com>

On Fri, Dec 06, 2024 at 05:25:27PM -0500, Frank Li wrote:
> Convert device tree binding doc mobiveil-pcie.txt to yaml format. Merge
> layerscape-pcie-gen4.txt into this file.
> 
> Additional change:
> - interrupt-names: "aer", "pme", "intr", which align order in examples.
> - reg-names: csr_axi_slave, config_axi_slave, which align existed dts file.

mobiveil-pcie.txt binding suggested reversed orders of above, so please
mention that you unify the order to match layerscape-pcie-gen4 and
existing Layerscape DTS users.


...


> +++ b/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
> @@ -0,0 +1,167 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/mbvl,gpex40-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mobiveil AXI PCIe Root Port Bridge
> +
> +maintainers:
> +  - Frank Li <Frank Li@nxp.com>
> +
> +description:
> +  Mobiveil's GPEX 4.0 is a PCIe Gen4 root port bridge IP. This configurable IP
> +  has up to 8 outbound and inbound windows for the address translation.
> +
> +  NXP Layerscape PCIe Gen4 controller (Deprecated) base on Mobiveil's GPEX 4.0.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mbvl,gpex40-pcie
> +      - fsl,lx2160a-pcie

Please reverse them to keep alphabetical order.

> +
> +  reg:
> +    items:
> +      - description: PCIe controller registers
> +      - description: Bridge config registers
> +      - description: GPIO registers to control slot power
> +      - description: MSI registers
> +    minItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: csr_axi_slave
> +      - const: config_axi_slave
> +      - const: gpio_slave
> +      - const: apb_csr
> +    minItems: 2
> +
> +  apio-wins:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      numbers of requested apio outbound windows
> +        1. Config window
> +        2. Memory window
> +    default: 2
> +    maximum: 256
> +
> +  ppio-wins:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: number of requested ppio inbound windows
> +    default: 1
> +    maximum: 256
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 3
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 3
> +
> +  dma-coherent: true
> +
> +  msi-parent: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,lx2160a-pcie
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 2
> +
> +        reg-names:
> +          maxItems: 2
> +

interrupts:
  minItems: 3

> +        interrupt-names:
> +          items:
> +            - const: aer
> +            - const: pme
> +            - const: intr
> +    else:
> +      properties:
> +        dma-coherent: false
> +        msi-parent: false

reg? interrupts? interrupt-names?



> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    pcie@b0000000 {
> +        compatible = "mbvl,gpex40-pcie";
> +        reg = <0xb0000000 0x00010000>,
> +              <0xa0000000 0x00001000>,
> +              <0xff000000 0x00200000>,
> +              <0xb0010000 0x00001000>;
> +        reg-names = "csr_axi_slave",
> +                    "config_axi_slave",
> +                    "gpio_slave",
> +                    "apb_csr";
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        device_type = "pci";
> +        apio-wins = <2>;
> +        ppio-wins = <1>;
> +        bus-range = <0x00000000 0x000000ff>;
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +        interrupt-parent = <&gic>;
> +        interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-map-mask = <0 0 0 7>;
> +        interrupt-map = <0 0 0 0 &pci_express 0>,
> +                        <0 0 0 1 &pci_express 1>,
> +                        <0 0 0 2 &pci_express 2>,
> +                        <0 0 0 3 &pci_express 3>;
> +        ranges = <0x83000000 0 0x00000000 0xa8000000 0 0x8000000>;

Please keep ranges after reg-names

> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        pcie@3400000 {
> +            compatible = "fsl,lx2160a-pcie";
> +            reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
> +                   0x80 0x00000000 0x0 0x00001000>; /* configuration space */
> +            reg-names = "csr_axi_slave", "config_axi_slave";
> +            interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
> +                         <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
> +                        <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> +            interrupt-names = "aer", "pme", "intr";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            device_type = "pci";
> +            apio-wins = <8>;
> +            ppio-wins = <8>;
> +            dma-coherent;
> +            bus-range = <0x0 0xff>;
> +            msi-parent = <&its>;
> +            ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>;

Ditto here

> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0 0 0 7>;
> +            interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> +        };

Best regards,
Krzysztof


