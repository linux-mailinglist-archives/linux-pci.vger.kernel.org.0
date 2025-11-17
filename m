Return-Path: <linux-pci+bounces-41463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B651C666A2
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 23:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 557612912A
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 22:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A99A34B19C;
	Mon, 17 Nov 2025 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lI/pl0lN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A952F7475;
	Mon, 17 Nov 2025 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417642; cv=none; b=dF478pQbgofBRmKh5Sx9Sy3egS/lVHz5RQY0+Nt/vJkGjJ35fkYZjDHHEmzDtOmmG+KAZ7oNgQ2zWTprH0TJHJwiAmBYQUojqSQySE7oDvY40mpbmmZGEt4PP9+ChhnEEwEPBFI75HZfaPnZii4JHKwoJFtkMkuPJrG/S8DDXIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417642; c=relaxed/simple;
	bh=7Xd20imrbtGgnXJ3jPRH56ORSA3mGDUGiu8VDY8+wQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8/bU4VODjdM+pFK3ex1FPFMFXG1gzQ3W/5hBv2oMxK8lnK1LMx4J1kCK4eolKZwRPRQ0wcp8vht4cw8KzFs7bCz0PXjsbTXYFvuyLEdMi29NfZy1+QHVqlKJMoE9VLg5yPgrBqalrufNTMi1cp8Pk76F83GXZGQ3RgALelG5YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lI/pl0lN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EEEC4CEFB;
	Mon, 17 Nov 2025 22:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763417640;
	bh=7Xd20imrbtGgnXJ3jPRH56ORSA3mGDUGiu8VDY8+wQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lI/pl0lN6EX8s9iMhr6hihgzqMq8MaevBIbaVdxbeBCszr1DXBmtkgy28tbas56y7
	 FBSRgEq9e6GtxUDy0/q80zOBM+kudxzZK60maqj0+HRQ1GPB9It3lIiyJJ2b9nJwWV
	 M86UA5cgtRag0DHuXtiRgN5EMZQ5L4j34Fc+I8fZmQ+PpGh6pPkDXNX5wWGrlKyiAA
	 vGVJC+PBnAv8+iuFUIbFc5rRFKi7wT/U4XA+t4dNdRyCCVHYnnLHU5FRe5CyByxrph
	 Orr77XGG9naWfY2a45e4BdsX/smNf/REhy0VCvYfP+3Y5hLoTA5QlO97a3iIvqKw6c
	 XaRQPx3EfSBvg==
Date: Mon, 17 Nov 2025 16:13:57 -0600
From: Rob Herring <robh@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 2/8] dt-bindings: PCI: Add ASPEED PCIe RC support
Message-ID: <20251117221357.GA806266-robh@kernel.org>
References: <20251117-upstream_pcie_rc-v5-0-b4a198576acf@aspeedtech.com>
 <20251117-upstream_pcie_rc-v5-2-b4a198576acf@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117-upstream_pcie_rc-v5-2-b4a198576acf@aspeedtech.com>

On Mon, Nov 17, 2025 at 08:37:49PM +0800, Jacky Chou wrote:
> ASPEED AST2600 provides one PCIe RC for Gen2 and AST2700 provides three
> PCIe RC for two Gen4 and one Gen2. All of these RCs have just one root
> port to connect to PCIe device. And also have Mem, I/O access, legacy
> interrupt and MSI.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../bindings/pci/aspeed,ast2600-pcie.yaml          | 149 +++++++++++++++++++++
>  1 file changed, 149 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml b/Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
> new file mode 100644
> index 000000000000..459b5c49657a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
> @@ -0,0 +1,149 @@
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
> +  memory and I/O windows, MSI and INTx interrupts, and integration with
> +  the SoC's clock, reset, and pinctrl subsystems. On AST2600, the PCIe Root
> +  Port device number is always 8.
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
> +    description: INTx and MSI interrupt
> +
> +  resets:
> +    items:
> +      - description: PCIe controller reset
> +
> +  reset-names:
> +    items:
> +      - const: h2x
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
> +  interrupt-controller: true
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
> +  - msi-controller
> +  - interrupt-controller
> +  - interrupt-map-mask
> +  - interrupt-map
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +
> +    pcie0: pcie@1e770000 {
> +      compatible = "aspeed,ast2600-pcie";
> +      device_type = "pci";
> +      reg = <0x1e770000 0x100>;
> +      #address-cells = <3>;
> +      #size-cells = <2>;
> +      interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
> +      bus-range = <0x00 0xff>;
> +
> +      ranges = <0x01000000 0x0 0x00018000 0x00018000 0x0 0x00008000
> +                0x02000000 0x0 0x60000000 0x60000000 0x0 0x20000000>;
> +
> +      resets = <&syscon ASPEED_RESET_H2X>;
> +      reset-names = "h2x";
> +
> +      #interrupt-cells = <1>;
> +      msi-controller;
> +
> +      aspeed,ahbc = <&ahbc>;
> +
> +      interrupt-controller;
> +      interrupt-map-mask = <0 0 0 7>;
> +      interrupt-map = <0 0 0 1 &pcie0 0>,
> +                      <0 0 0 2 &pcie0 1>,
> +                      <0 0 0 3 &pcie0 2>,
> +                      <0 0 0 4 &pcie0 3>;
> +
> +      pcie@8,0 {

This node and the properties need to be in the schema along with a ref 
to pci-pci-bridge.yaml.

> +        reg = <0x804000 0 0 0 0>;

The address should not have the bus number as it is dynamic.

> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        device_type = "pci";
> +        resets = <&syscon ASPEED_RESET_PCIE_RC_O>;
> +        reset-names = "perst";

Not sure this name is correct. PERST is a signal on the connector going 
downstream to the endpoint.

> +        clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_pcierc1_default>;
> +        phys = <&pcie_phy1>;
> +        ranges;
> +      };
> +    };
> 
> -- 
> 2.34.1
> 

