Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2133501ADE
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 20:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240438AbiDNSSA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 14:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiDNSR6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 14:17:58 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B55D95D9;
        Thu, 14 Apr 2022 11:15:33 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id bj24so805194oib.11;
        Thu, 14 Apr 2022 11:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8IGy2IPPiGVJ0iwPRDCGgP5nDQj4cUSLORIxYG1au4Y=;
        b=LJrTB0YqeKfSn/b6dy6EyD7BG0dt8j9oIcJ+XlWvorg+fEGSKmJD4wkPw2RsVJXZ+F
         3evmr6XTOn17/NuLTtb0LQcuoe22WjLs+HWLSBAq39qrOQtLrOY+72J0Ta8vBIeVY3P8
         UYFkErq63+ejZsLM9z4Ml91a3PTvULdQoxgck6zWAw763FaPTxTUFaW3HlGJbooUl5yn
         542eQGk/gWs3T1mRxV7Pc9Bst7S3FT36BJbVfyb6CFHES4u1+IC1ggd4Hkrk5TRfpndR
         KAq2HMzEpZ8VMmT0PMcqBUtepYbBX37ecCORLZry1K6QI0dLk+vBv+/LAAQScbndtvfM
         +uLQ==
X-Gm-Message-State: AOAM532GQkH7DjzVbiXC6kv0EkK/FFO7rDflkftSEWwZEjltYyjdJw/g
        nVQMDs6MvrJfn2e3zBqzRA==
X-Google-Smtp-Source: ABdhPJyLnT6zmtbo0o+gX8RTdsDeKCamije0iQ51DVc1rlXrhVys0qS9uVgFk+s3Kb/PdacAKPB4NA==
X-Received: by 2002:a05:6808:1691:b0:2f9:4bd7:581e with SMTP id bb17-20020a056808169100b002f94bd7581emr2113465oib.144.1649960132358;
        Thu, 14 Apr 2022 11:15:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r6-20020a0568301ac600b005cdbc6e62a9sm281322otc.39.2022.04.14.11.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 11:15:31 -0700 (PDT)
Received: (nullmailer pid 2380275 invoked by uid 1000);
        Thu, 14 Apr 2022 18:15:30 -0000
Date:   Thu, 14 Apr 2022 13:15:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: PCI: renesas-pci-usb: Convert
 bindings to json-schema
Message-ID: <YlhkwvGdcf4ozTzG@robh.at.kernel.org>
References: <20220414074011.500533-1-herve.codina@bootlin.com>
 <20220414074011.500533-3-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414074011.500533-3-herve.codina@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 14, 2022 at 09:40:05AM +0200, Herve Codina wrote:
> Convert Renesas PCI bridge bindings documentation to json-schema.
> Also name it 'renesas,pci-usb' as it is specifically used to
> connect the PCI USB controllers to AHB bus.

Please name it based on compatible strings. renesas,pci-rcar-gen2.yaml

> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../devicetree/bindings/pci/pci-rcar-gen2.txt |  84 -----------
>  .../bindings/pci/renesas,pci-usb.yaml         | 134 ++++++++++++++++++
>  2 files changed, 134 insertions(+), 84 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> deleted file mode 100644
> index aeba38f0a387..000000000000
> --- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> +++ /dev/null
> @@ -1,84 +0,0 @@
> -Renesas AHB to PCI bridge
> --------------------------
> -
> -This is the bridge used internally to connect the USB controllers to the
> -AHB. There is one bridge instance per USB port connected to the internal
> -OHCI and EHCI controllers.
> -
> -Required properties:
> -- compatible: "renesas,pci-r8a7742" for the R8A7742 SoC;
> -	      "renesas,pci-r8a7743" for the R8A7743 SoC;
> -	      "renesas,pci-r8a7744" for the R8A7744 SoC;
> -	      "renesas,pci-r8a7745" for the R8A7745 SoC;
> -	      "renesas,pci-r8a7790" for the R8A7790 SoC;
> -	      "renesas,pci-r8a7791" for the R8A7791 SoC;
> -	      "renesas,pci-r8a7793" for the R8A7793 SoC;
> -	      "renesas,pci-r8a7794" for the R8A7794 SoC;
> -	      "renesas,pci-rcar-gen2" for a generic R-Car Gen2 or
> -				      RZ/G1 compatible device.
> -
> -
> -	      When compatible with the generic version, nodes must list the
> -	      SoC-specific version corresponding to the platform first
> -	      followed by the generic version.
> -
> -- reg:	A list of physical regions to access the device: the first is
> -	the operational registers for the OHCI/EHCI controllers and the
> -	second is for the bridge configuration and control registers.
> -- interrupts: interrupt for the device.
> -- clocks: The reference to the device clock.
> -- bus-range: The PCI bus number range; as this is a single bus, the range
> -	     should be specified as the same value twice.
> -- #address-cells: must be 3.
> -- #size-cells: must be 2.
> -- #interrupt-cells: must be 1.
> -- interrupt-map: standard property used to define the mapping of the PCI
> -  interrupts to the GIC interrupts.
> -- interrupt-map-mask: standard property that helps to define the interrupt
> -  mapping.
> -
> -Optional properties:
> -- dma-ranges: a single range for the inbound memory region. If not supplied,
> -  defaults to 1GiB at 0x40000000. Note there are hardware restrictions on the
> -  allowed combinations of address and size.
> -
> -Example SoC configuration:
> -
> -	pci0: pci@ee090000  {
> -		compatible = "renesas,pci-r8a7790", "renesas,pci-rcar-gen2";
> -		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
> -		reg = <0x0 0xee090000 0x0 0xc00>,
> -		      <0x0 0xee080000 0x0 0x1100>;
> -		interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
> -		status = "disabled";
> -
> -		bus-range = <0 0>;
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		#interrupt-cells = <1>;
> -		dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;
> -		interrupt-map-mask = <0xff00 0 0 0x7>;
> -		interrupt-map = <0x0000 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
> -				 0x0800 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
> -				 0x1000 0 0 2 &gic 0 108 IRQ_TYPE_LEVEL_HIGH>;
> -
> -		usb@1,0 {
> -			reg = <0x800 0 0 0 0>;
> -			phys = <&usb0 0>;
> -			phy-names = "usb";
> -		};
> -
> -		usb@2,0 {
> -			reg = <0x1000 0 0 0 0>;
> -			phys = <&usb0 0>;
> -			phy-names = "usb";
> -		};
> -	};
> -
> -Example board setup:
> -
> -&pci0 {
> -	status = "okay";
> -	pinctrl-0 = <&usb0_pins>;
> -	pinctrl-names = "default";
> -};
> diff --git a/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml b/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
> new file mode 100644
> index 000000000000..3f8d79b746c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
> @@ -0,0 +1,134 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/renesas,pci-usb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas AHB to PCI bridge
> +
> +maintainers:
> +  - Marek Vasut <marek.vasut+renesas@gmail.com>
> +  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> +
> +description: |
> +  This is the bridge used internally to connect the USB controllers to the
> +  AHB. There is one bridge instance per USB port connected to the internal
> +  OHCI and EHCI controllers.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - renesas,pci-r8a7742      # RZ/G1H
> +              - renesas,pci-r8a7743      # RZ/G1M
> +              - renesas,pci-r8a7744      # RZ/G1N
> +              - renesas,pci-r8a7745      # RZ/G1E
> +              - renesas,pci-r8a7790      # R-Car H2
> +              - renesas,pci-r8a7791      # R-Car M2-W
> +              - renesas,pci-r8a7793      # R-Car M2-N
> +              - renesas,pci-r8a7794      # R-Car E2
> +          - const: renesas,pci-rcar-gen2 # R-Car Gen2 and RZ/G1
> +
> +  reg:
> +    description: |
> +      A list of physical regions to access the device. The first is
> +      the operational registers for the OHCI/EHCI controllers and the
> +      second is for the bridge configuration and control registers.
> +    minItems: 2
> +    maxItems: 2
> +
> +  interrupts:
> +    description: Interrupt for the device.
> +
> +  interrupt-map:
> +    description: |
> +      Standard property used to define the mapping of the PCI interrupts
> +      to the GIC interrupts.
> +
> +  interrupt-map-mask:
> +    description:
> +      Standard property that helps to define the interrupt mapping.
> +
> +  clocks:
> +    description: The reference to the device clock.
> +
> +  bus-range:
> +    description: |
> +      The PCI bus number range; as this is a single bus, the range
> +      should be specified as the same value twice.

items:
  const: 0

> +
> +  "#address-cells":
> +    const: 3
> +
> +  "#size-cells":
> +    const: 2
> +
> +  "#interrupt-cells":
> +    const: 1

All these are defined by pci-bus.yaml

> +
> +  dma-ranges:
> +    description: |
> +      A single range for the inbound memory region. If not supplied,
> +      defaults to 1GiB at 0x40000000. Note there are hardware restrictions on
> +      the allowed combinations of address and size.

'a single range' == 'maxItems: 1'
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-map
> +  - interrupt-map-mask
> +  - clocks
> +  - bus-range
> +  - "#address-cells"
> +  - "#size-cells"
> +  - "#interrupt-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/r8a7790-cpg-mssr.h>
> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pci0: pci@ee090000  {
> +            compatible = "renesas,pci-r8a7790", "renesas,pci-rcar-gen2";
> +            device_type = "pci";
> +            clocks = <&cpg CPG_MOD 703>;
> +            reg = <0 0xee090000 0 0xc00>,
> +                  <0 0xee080000 0 0x1100>;
> +            interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> +            status = "disabled";

Don't disable your example.

> +
> +            bus-range = <0 0>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            #interrupt-cells = <1>;
> +            ranges = <0x02000000 0 0xee080000 0 0xee080000 0 0x00010000>;
> +            dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;
> +            interrupt-map-mask = <0xf800 0 0 0x7>;
> +            interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> +
> +            usb@1,0 {
> +                reg = <0x800 0 0 0 0>;
> +                phys = <&usb0 0>;
> +                phy-names = "usb";
> +            };
> +            
> +            usb@2,0 {
> +                reg = <0x1000 0 0 0 0>;
> +                phys = <&usb0 0>;
> +                phy-names = "usb";
> +            };
> +        };
> +    };
> -- 
> 2.35.1
> 
> 
