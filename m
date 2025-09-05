Return-Path: <linux-pci+bounces-35502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42614B44D73
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 07:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3ECA3BC019
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 05:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4892EBDC5;
	Fri,  5 Sep 2025 05:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0CmTSir"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E578B2EBBA3;
	Fri,  5 Sep 2025 05:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757049684; cv=none; b=PZe32einFQHSiJwlSLIyEMN7Msx9DO2NB0WGNaFajgtEVH92llCnXM1xiJGMDqGHbf8ljeUrEtUWROFbHWqP8kwCp4cbrvsCcZgJe1ujmQbe8Zi/nuVnyE9fRwJ9jWHT59vcvR2Ti31/FnYf2H1me3ESDGYkonS2JUZcwn41ZqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757049684; c=relaxed/simple;
	bh=mqIISEo7LPLprFNDEUcKEaTHvMz7CvLt6reLpOwI+yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WP+LBbGFv1gMNaizmqR3WxNUH6K5ppHy7Q2LMT/kB78vSh1Ph6Xj1Ql1Em+cPhYY0dzEjivAMYBhI3zJ2SRHJjAKn5UglIJohNSbNB91AfWnJtZWqCkM/h7Z8cAnSUHGlfYUq5hY+8XAuqkiCr8/ZX1ZpWdsy0cYTVeknUuM0jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0CmTSir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26279C4CEF5;
	Fri,  5 Sep 2025 05:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757049683;
	bh=mqIISEo7LPLprFNDEUcKEaTHvMz7CvLt6reLpOwI+yU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0CmTSirH7yBCDozYoC9DlsvzZCfvAFIewxsKM229y/tgJZn5KvA0nn3sSZy76qey
	 0S5HgHbORGIloKt+m8EPv9nwzjEz43zvj3GBh53cftXZ8LLcH2zIdfbPPrP54KB6BQ
	 Y2h836z0EzbOsronUrzBLoG3jbU4WNYmVjvqvhHWcF1NTZg3/tqWeUc2cGUFYxeukL
	 kfQqw2XDwWAaZUdqwkQ76KnorupCoWqE331UKGXqY7Fus4/Dm24wxaW1aZzCZRbE2e
	 gkSyeEO9z828d4a56/6cKYREIuv1xIUvsIvs2LWAKAjEAlx31YF3I/J3fbDyUTP1PM
	 JQ3SWIjkiqXVQ==
Date: Fri, 5 Sep 2025 10:51:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, vkoul@kernel.org, kishon@kernel.org, 
	linus.walleij@linaro.org, p.zabel@pengutronix.de, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 03/10] dt-bindings: PCI: Add ASPEED PCIe RC support
Message-ID: <xg5avkbsoux7rw7dg67bhf7rupgr66nzak27y2jmcerrqhlb4u@l63vz3jaie2g>
References: <20250901055922.1553550-1-jacky_chou@aspeedtech.com>
 <20250901055922.1553550-4-jacky_chou@aspeedtech.com>
 <20250902211221.GA1179675-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250902211221.GA1179675-robh@kernel.org>

On Tue, Sep 02, 2025 at 04:12:21PM GMT, Rob Herring wrote:
> On Mon, Sep 01, 2025 at 01:59:15PM +0800, Jacky Chou wrote:
> > ASPEED AST2600 provides one PCIe RC for Gen2 and AST2700 provides three
> > PCIe RC for two Gen4 and one Gen2. All of these RCs have just one root
> > port to connect to PCIe device. And also have Mem, I/O access, legacy
> > interrupt and MSI.
> > 
> > Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> > ---
> >  .../bindings/pci/aspeed,ast2600-pcie.yaml     | 179 ++++++++++++++++++
> >  1 file changed, 179 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml b/Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
> > new file mode 100644
> > index 000000000000..fe75bf2961c8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
> > @@ -0,0 +1,179 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/aspeed,ast2600-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ASPEED PCIe Root Complex Controller
> > +
> > +maintainers:
> > +  - Jacky Chou <jacky_chou@aspeedtech.com>
> > +
> > +description:
> > +  The ASPEED PCIe Root Complex controller provides PCI Express Root Complex
> > +  functionality for ASPEED SoCs, such as the AST2600 and AST2700.
> > +  This controller enables connectivity to PCIe endpoint devices, supporting
> > +  memory and I/O windows, MSI and legacy interrupts, and integration with
> > +  the SoC's clock, reset, and pinctrl subsystems.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - aspeed,ast2600-pcie
> > +      - aspeed,ast2700-pcie
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  ranges:
> > +    minItems: 2
> > +    maxItems: 2
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: IntX and MSI interrupt
> > +
> > +  resets:
> > +    items:
> > +      - description: PCIe controller reset
> > +
> > +  reset-names:
> > +    items:
> > +      - const: h2x
> > +
> > +  msi-parent: true
> > +
> > +  aspeed,ahbc:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle to the ASPEED AHB Controller (AHBC) syscon node.
> > +      This reference is used by the PCIe controller to access
> > +      system-level configuration registers related to the AHB bus.
> > +      To enable AHB access for the PCIe controller.
> > +
> > +  aspeed,pciecfg:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle to the ASPEED PCIe configuration syscon node.
> > +      This reference allows the PCIe controller to access
> > +      SoC-specific PCIe configuration registers. There are the others
> > +      functions such PCIe RC and PCIe EP will use this common register
> > +      to configure the SoC interfaces.
> > +

So these config registers are part of the PCIe domain? Is so, accessing them as
syscon is wrong. You should configure the registers directly from the RC and EP
controller drivers.

> > +  interrupt-controller:
> > +    description: Interrupt controller node for handling legacy PCI interrupts.

s/legacy PCI interrupts/INTx

> > +    type: object
> > +    properties:
> > +      '#address-cells':
> > +        const: 0
> > +      '#interrupt-cells':
> > +        const: 1
> > +      interrupt-controller: true
> > +
> > +    required:
> > +      - '#address-cells'
> > +      - '#interrupt-cells'
> > +      - interrupt-controller
> > +
> > +    additionalProperties: false
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: aspeed,ast2600-pcie
> > +    then:
> > +      required:
> > +        - aspeed,ahbc
> > +    else:
> > +      properties:
> > +        aspeed,ahbc: false
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: aspeed,ast2700-pcie
> > +    then:
> > +      required:
> > +        - aspeed,pciecfg
> > +    else:
> > +      properties:
> > +        aspeed,pciecfg: false
> > +
> > +required:
> > +  - reg
> > +  - interrupts
> > +  - bus-range
> > +  - ranges
> > +  - resets
> > +  - reset-names
> > +  - msi-parent
> > +  - msi-controller
> > +  - interrupt-map-mask
> > +  - interrupt-map
> > +  - interrupt-controller
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/ast2600-clock.h>
> > +
> > +    apb {
> > +      #address-cells = <1>;
> > +      #size-cells = <1>;
> 
> No need to show this node.
> 
> > +
> > +      pcie0: pcie@1e770000 {
> > +        compatible = "aspeed,ast2600-pcie";
> > +        device_type = "pci";
> > +        reg = <0x1e770000 0x100>;
> > +        linux,pci-domain = <0>;
> > +        #address-cells = <3>;
> > +        #size-cells = <2>;
> > +        interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
> > +        bus-range = <0x80 0xff>;

Why bus number starts from 128?

> > +
> > +        ranges = <0x01000000 0x0 0x00018000 0x00018000 0x0 0x00008000
> > +            0x02000000 0x0 0x70000000 0x70000000 0x0 0x10000000>;
> > +
> > +        status = "disabled";
> 
> Examples should be enabled. Drop.
> 
> > +
> > +        resets = <&syscon ASPEED_RESET_H2X>;
> > +        reset-names = "h2x";
> > +
> > +        #interrupt-cells = <1>;
> > +        msi-parent = <&pcie0>;
> 
> There shouldn't be any need to point to yourself.
> 
> > +        msi-controller;
> > +
> > +        aspeed,ahbc = <&ahbc>;
> > +
> > +        interrupt-map-mask = <0 0 0 7>;
> > +        interrupt-map = <0 0 0 1 &pcie_intc0 0>,
> > +                        <0 0 0 2 &pcie_intc0 1>,
> > +                        <0 0 0 3 &pcie_intc0 2>,
> > +                        <0 0 0 4 &pcie_intc0 3>;
> > +        pcie_intc0: interrupt-controller {
> > +          interrupt-controller;
> > +          #address-cells = <0>;
> > +          #interrupt-cells = <1>;
> > +        };
> > +
> > +        pcie@8,0 {
> > +          reg = <0x804000 0 0 0 0>;

Why the device number starts from 8?

If there are platform specific reasons behind this numbering scheme, it should
be mentioned in the description.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

