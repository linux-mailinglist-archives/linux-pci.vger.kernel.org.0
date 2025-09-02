Return-Path: <linux-pci+bounces-35341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A16DB40F25
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 23:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35077010F8
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 21:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6E33570BE;
	Tue,  2 Sep 2025 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luFQ2z1C"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379FF3570B8;
	Tue,  2 Sep 2025 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847543; cv=none; b=mKSWMbFQvywt5e8U9pDs0zwY08BFX2BAwdl6G9O1hjWDGLx04KA0T5LiuKkJT0j0n4c4WwuHl160TxwH6YqfSZppkLczO7+0JUnehKUcshEiP4uJLwntJRz2gOmzFzPPo1CUVUtB7qC5S3QDSj8nPaPRp3zALmMSKu7/+4IXxoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847543; c=relaxed/simple;
	bh=GapsPE0aKjOsj/qJoAYb40Z1D6PTon6aeSohfFPAuzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWp2XhASzWoCyk6tAOfPw4Sr0T7FmOvZfuLKHCbz7IgTeH66C7dQ23D+Rn3UgVGVqRTm6rrg36DZNCHKm+UIcX8EEPVttZeM195Wzs5gFFJrYWVfQV2BXvjXyUkww1kqAnmxuKpL7tvgAFwy0Qo4gcv7qi7iHqkqgJZm+18xHnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luFQ2z1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91524C4CEED;
	Tue,  2 Sep 2025 21:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756847542;
	bh=GapsPE0aKjOsj/qJoAYb40Z1D6PTon6aeSohfFPAuzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=luFQ2z1CC0aNdVLIANDxZ0V9aM1cSpxaoqrjjYWZUnCkYRFx7s9eRrkwPTqxzQrf9
	 jxA1rMgN31Exw34cNQDZ42JO9f+PfqIjNsq80CO2/V8bKj+5mu9rYzYKR0D1D2r4C/
	 Ukq1fbSV/XkTjU6xjopAsFiVmvvO/5a/AC/crHx07Y84sQg/myI0CzTXDSnK+8U4Ke
	 14eE5fhbCrnOKTag4F5U5gjlNwRTfH2emvWRgLuy0ZBRrNOo1fOEH3qQbCttH0V1tJ
	 7tPURRQ2zVBOg8pf34fosE9Vypa981lvccN0DQtCafYaaGCm3n47XxDuTXDfl9QBPw
	 0UeAv33nHfS5Q==
Date: Tue, 2 Sep 2025 16:12:21 -0500
From: Rob Herring <robh@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, vkoul@kernel.org, kishon@kernel.org,
	linus.walleij@linaro.org, p.zabel@pengutronix.de,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 03/10] dt-bindings: PCI: Add ASPEED PCIe RC support
Message-ID: <20250902211221.GA1179675-robh@kernel.org>
References: <20250901055922.1553550-1-jacky_chou@aspeedtech.com>
 <20250901055922.1553550-4-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901055922.1553550-4-jacky_chou@aspeedtech.com>

On Mon, Sep 01, 2025 at 01:59:15PM +0800, Jacky Chou wrote:
> ASPEED AST2600 provides one PCIe RC for Gen2 and AST2700 provides three
> PCIe RC for two Gen4 and one Gen2. All of these RCs have just one root
> port to connect to PCIe device. And also have Mem, I/O access, legacy
> interrupt and MSI.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../bindings/pci/aspeed,ast2600-pcie.yaml     | 179 ++++++++++++++++++
>  1 file changed, 179 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml b/Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
> new file mode 100644
> index 000000000000..fe75bf2961c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
> @@ -0,0 +1,179 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/aspeed,ast2600-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED PCIe Root Complex Controller
> +
> +maintainers:
> +  - Jacky Chou <jacky_chou@aspeedtech.com>
> +
> +description:
> +  The ASPEED PCIe Root Complex controller provides PCI Express Root Complex
> +  functionality for ASPEED SoCs, such as the AST2600 and AST2700.
> +  This controller enables connectivity to PCIe endpoint devices, supporting
> +  memory and I/O windows, MSI and legacy interrupts, and integration with
> +  the SoC's clock, reset, and pinctrl subsystems.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-pcie
> +      - aspeed,ast2700-pcie
> +
> +  reg:
> +    maxItems: 1
> +
> +  ranges:
> +    minItems: 2
> +    maxItems: 2
> +
> +  interrupts:
> +    maxItems: 1
> +    description: IntX and MSI interrupt
> +
> +  resets:
> +    items:
> +      - description: PCIe controller reset
> +
> +  reset-names:
> +    items:
> +      - const: h2x
> +
> +  msi-parent: true
> +
> +  aspeed,ahbc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the ASPEED AHB Controller (AHBC) syscon node.
> +      This reference is used by the PCIe controller to access
> +      system-level configuration registers related to the AHB bus.
> +      To enable AHB access for the PCIe controller.
> +
> +  aspeed,pciecfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the ASPEED PCIe configuration syscon node.
> +      This reference allows the PCIe controller to access
> +      SoC-specific PCIe configuration registers. There are the others
> +      functions such PCIe RC and PCIe EP will use this common register
> +      to configure the SoC interfaces.
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
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2600-pcie
> +    then:
> +      required:
> +        - aspeed,ahbc
> +    else:
> +      properties:
> +        aspeed,ahbc: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2700-pcie
> +    then:
> +      required:
> +        - aspeed,pciecfg
> +    else:
> +      properties:
> +        aspeed,pciecfg: false
> +
> +required:
> +  - reg
> +  - interrupts
> +  - bus-range
> +  - ranges
> +  - resets
> +  - reset-names
> +  - msi-parent
> +  - msi-controller
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - interrupt-controller
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +
> +    apb {
> +      #address-cells = <1>;
> +      #size-cells = <1>;

No need to show this node.

> +
> +      pcie0: pcie@1e770000 {
> +        compatible = "aspeed,ast2600-pcie";
> +        device_type = "pci";
> +        reg = <0x1e770000 0x100>;
> +        linux,pci-domain = <0>;
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
> +        bus-range = <0x80 0xff>;
> +
> +        ranges = <0x01000000 0x0 0x00018000 0x00018000 0x0 0x00008000
> +            0x02000000 0x0 0x70000000 0x70000000 0x0 0x10000000>;
> +
> +        status = "disabled";

Examples should be enabled. Drop.

> +
> +        resets = <&syscon ASPEED_RESET_H2X>;
> +        reset-names = "h2x";
> +
> +        #interrupt-cells = <1>;
> +        msi-parent = <&pcie0>;

There shouldn't be any need to point to yourself.

> +        msi-controller;
> +
> +        aspeed,ahbc = <&ahbc>;
> +
> +        interrupt-map-mask = <0 0 0 7>;
> +        interrupt-map = <0 0 0 1 &pcie_intc0 0>,
> +                        <0 0 0 2 &pcie_intc0 1>,
> +                        <0 0 0 3 &pcie_intc0 2>,
> +                        <0 0 0 4 &pcie_intc0 3>;
> +        pcie_intc0: interrupt-controller {
> +          interrupt-controller;
> +          #address-cells = <0>;
> +          #interrupt-cells = <1>;
> +        };
> +
> +        pcie@8,0 {
> +          reg = <0x804000 0 0 0 0>;
> +          #address-cells = <3>;
> +          #size-cells = <2>;
> +          device_type = "pci";
> +          resets = <&syscon ASPEED_RESET_PCIE_RC_O>;
> +          reset-names = "perst";
> +          clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
> +          pinctrl-names = "default";
> +          pinctrl-0 = <&pinctrl_pcierc1_default>;
> +          phys = <&pcie_phy1>;
> +          ranges;
> +        };
> +      };
> +    };
> -- 
> 2.43.0
> 

