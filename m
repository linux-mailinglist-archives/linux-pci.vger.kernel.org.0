Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E977783C6
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 00:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjHJWrb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 18:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjHJWrb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 18:47:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32C32D41;
        Thu, 10 Aug 2023 15:47:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81530654CA;
        Thu, 10 Aug 2023 22:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EA8C433C8;
        Thu, 10 Aug 2023 22:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691707649;
        bh=BiNFWhMnFAfcsJc6RVOOiPgvjtR8dQn1Pz6zFgiUfkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LXtJ+A/OhCVZsi/Zy3oeUdj4wcNlHJQ5cVHZ67GGME1/Fec7FuV2LdeH7cRZF6DUh
         0FSDX3CIQA6dAOJ/6ZGij/nRbqxAHWeOJKHijpB0JFwqK7tF2y/GExj3z46TYnXfyM
         ILaI0sRFV5hPZXV0MG7/l25id3K6Wp6BrugQPfRBlLnPhM1Rn/B7Mp0/4rxVPrbfV3
         ReQaUvMD7V2/7YUcXMccN6rS7zGUKhJKDvN+C+ylaS9evOEIKzlhTg5EUX2SWFGIr0
         47RszC6Oic2+O+dPJSe8yUZVcJ7GR6Qh7UrCVS7/sQpwvwkxpr5yulqEVo7mplBSSO
         AlGgT4iAmdtvg==
Received: (nullmailer pid 1478687 invoked by uid 1000);
        Thu, 10 Aug 2023 22:47:27 -0000
Date:   Thu, 10 Aug 2023 16:47:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: PCI: Add StarFive JH7110 PCIe
 controller
Message-ID: <20230810224727.GA1445828-robh@kernel.org>
References: <20230727103949.26149-1-minda.chen@starfivetech.com>
 <20230727103949.26149-4-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727103949.26149-4-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 27, 2023 at 06:39:48PM +0800, Minda Chen wrote:
> Add StarFive JH7110 SoC PCIe controller dt-bindings.
> JH7110 using PLDA XpressRICH PCIe host controller IP.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../bindings/pci/starfive,jh7110-pcie.yaml    | 133 ++++++++++++++++++
>  1 file changed, 133 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
> new file mode 100644
> index 000000000000..9273e029fb20
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
> @@ -0,0 +1,133 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/starfive,jh7110-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 PCIe host controller
> +
> +maintainers:
> +  - Kevin Xie <kevin.xie@starfivetech.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#

Can go in common schema. Unless endpoint mode is or is going to be 
supported?

> +  - $ref: plda,xpressrich3-axi-common.yaml#
> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#

This is a bit odd. Do you really need to define the host bridge as an 
msi-controller? Many host bridges are, but they don't need to be defined 
as one in DT because PCIe spec defines its own way to do MSIs. 

> +  - $ref: /schemas/gpio/gpio-consumer-common.yaml#

No, you don't need to reference this. You need to define what properties 
from it you use (reset-gpios).

Though if this is for PERST#, then I'd use "perst-gpios" instead.

And why is that not common? It's board specific, not SoC,  whether or 
not there's GPIO control of it.

> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-pcie
> +
> +  clocks:
> +    items:
> +      - description: NOC bus clock
> +      - description: Transport layer clock
> +      - description: AXI MST0 clock
> +      - description: APB clock
> +
> +  clock-names:
> +    items:
> +      - const: noc
> +      - const: tl
> +      - const: axi_mst0
> +      - const: apb
> +
> +  resets:
> +    items:
> +      - description: AXI MST0 reset
> +      - description: AXI SLAVE0 reset
> +      - description: AXI SLAVE reset
> +      - description: PCIE BRIDGE reset
> +      - description: PCIE CORE reset
> +      - description: PCIE APB reset
> +
> +  reset-names:
> +    items:
> +      - const: mst0
> +      - const: slv0
> +      - const: slv
> +      - const: brg
> +      - const: core
> +      - const: apb
> +
> +  starfive,stg-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to System Register Controller stg_syscon node.
> +          - description: register0 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
> +          - description: register1 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
> +          - description: register2 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
> +          - description: register3 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
> +    description:
> +      The phandle to System Register Controller syscon node and the offset
> +      of STG_SYSCONSAIF__SYSCFG register for PCIe. Total 4 regsisters offset
> +      for PCIe.

Perhaps somewhere in here state what these registers are for.

> +
> +  phys:
> +    description:
> +      Specified PHY is attached to PCIe controller.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +  - resets
> +  - starfive,stg-syscon

> +  - "#interrupt-cells"
> +  - interrupt-map-mask
> +  - interrupt-map

These can all be common.

So could 'compatible' though it is implicitly required anyways as 
without it, the schema is never applied.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie0: pcie@2b000000 {
> +            compatible = "starfive,jh7110-pcie";
> +            reg = <0x9 0x40000000 0x0 0x10000000>,
> +                  <0x0 0x2b000000 0x0 0x1000000>;
> +            reg-names = "cfg", "apb";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            #interrupt-cells = <1>;
> +            device_type = "pci";
> +            ranges = <0x82000000  0x0 0x30000000  0x0 0x30000000 0x0 0x08000000>,
> +                     <0xc3000000  0x9 0x00000000  0x9 0x00000000 0x0 0x40000000>;
> +            starfive,stg-syscon = <&stg_syscon 0xc0 0xc4 0x130 0x1b8>;
> +            bus-range = <0x0 0xff>;
> +            interrupt-parent = <&plic>;
> +            interrupts = <56>;
> +            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +            interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc0 0x1>,
> +                            <0x0 0x0 0x0 0x2 &pcie_intc0 0x2>,
> +                            <0x0 0x0 0x0 0x3 &pcie_intc0 0x3>,
> +                            <0x0 0x0 0x0 0x4 &pcie_intc0 0x4>;
> +            msi-parent = <&pcie0>;

Weird!?

> +            msi-controller;
> +            clocks = <&syscrg 86>,
> +                     <&stgcrg 10>,
> +                     <&stgcrg 8>,
> +                     <&stgcrg 9>;
> +            clock-names = "noc", "tl", "axi_mst0", "apb";
> +            resets = <&stgcrg 11>,
> +                     <&stgcrg 12>,
> +                     <&stgcrg 13>,
> +                     <&stgcrg 14>,
> +                     <&stgcrg 15>,
> +                     <&stgcrg 16>;
> +            reset-gpios = <&gpios 26 GPIO_ACTIVE_LOW>;
> +            phys = <&pciephy0>;
> +
> +            pcie_intc0: interrupt-controller {
> +                #address-cells = <0>;
> +                #interrupt-cells = <1>;
> +                interrupt-controller;
> +            };
> +        };
> +    };
> -- 
> 2.17.1
> 
