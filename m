Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904B3500821
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 10:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbiDNIVa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 04:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240610AbiDNIVW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 04:21:22 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B18357144
        for <linux-pci@vger.kernel.org>; Thu, 14 Apr 2022 01:18:55 -0700 (PDT)
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 604F4C0F79
        for <linux-pci@vger.kernel.org>; Thu, 14 Apr 2022 08:08:47 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0A3251C0013;
        Thu, 14 Apr 2022 08:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649923721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=epQ7ur/IC+M7rUzwT/LZw6lANOz+LVhuy2A10k1/oeQ=;
        b=kII6LdfSA0CEkzlRuXQjWlIv0Kik6u9RQCp7n/U/AgCEvR+PAXFvUNY+yFR7bYCy7lggmS
        z/2U1yA5R7X8KxnVlhFx3pPgfRHNcO80Trg7reBraLCF8jGez7WVLtD26ywYABSXKyfkPj
        vxaQRhc3OLPYmpzFqvLtEf1MJUjVZHV86paWs4ydhNUZU7hPx7vFF1EYYrVJRNWKZccssd
        +7miUHmCjYbZOEMmP0va8EOFpJPwQuhqRUAse6AA0DGtcJGaBhQyGifVzixSgPbluU3nSk
        gXQr0/j+C8PKaZgA28ZMRfZ2B8YGWeJNgGYWssxJLRFMlX/Op82MMjZjMj0Ydg==
Date:   Thu, 14 Apr 2022 10:08:35 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: PCI: renesas-pci-usb: Convert
 bindings to json-schema
Message-ID: <20220414100835.4c2efa3b@xps13>
In-Reply-To: <20220414074011.500533-3-herve.codina@bootlin.com>
References: <20220414074011.500533-1-herve.codina@bootlin.com>
        <20220414074011.500533-3-herve.codina@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Herv=C3=A9,

herve.codina@bootlin.com wrote on Thu, 14 Apr 2022 09:40:05 +0200:

> Convert Renesas PCI bridge bindings documentation to json-schema.
> Also name it 'renesas,pci-usb' as it is specifically used to
> connect the PCI USB controllers to AHB bus.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../devicetree/bindings/pci/pci-rcar-gen2.txt |  84 -----------
>  .../bindings/pci/renesas,pci-usb.yaml         | 134 ++++++++++++++++++
>  2 files changed, 134 insertions(+), 84 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/pci-rcar-gen2.t=
xt
>  create mode 100644 Documentation/devicetree/bindings/pci/renesas,pci-usb=
.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Do=
cumentation/devicetree/bindings/pci/pci-rcar-gen2.txt
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
> -- interrupt-map-mask: standard property that helps to define the interru=
pt
> -  mapping.
> -
> -Optional properties:
> -- dma-ranges: a single range for the inbound memory region. If not suppl=
ied,
> -  defaults to 1GiB at 0x40000000. Note there are hardware restrictions o=
n the
> -  allowed combinations of address and size.
> -
> -Example SoC configuration:
> -
> -	pci0: pci@ee090000  {
> -		compatible =3D "renesas,pci-r8a7790", "renesas,pci-rcar-gen2";
> -		clocks =3D <&mstp7_clks R8A7790_CLK_EHCI>;
> -		reg =3D <0x0 0xee090000 0x0 0xc00>,
> -		      <0x0 0xee080000 0x0 0x1100>;
> -		interrupts =3D <0 108 IRQ_TYPE_LEVEL_HIGH>;
> -		status =3D "disabled";
> -
> -		bus-range =3D <0 0>;
> -		#address-cells =3D <3>;
> -		#size-cells =3D <2>;
> -		#interrupt-cells =3D <1>;
> -		dma-ranges =3D <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;
> -		interrupt-map-mask =3D <0xff00 0 0 0x7>;
> -		interrupt-map =3D <0x0000 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
> -				 0x0800 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
> -				 0x1000 0 0 2 &gic 0 108 IRQ_TYPE_LEVEL_HIGH>;
> -
> -		usb@1,0 {
> -			reg =3D <0x800 0 0 0 0>;
> -			phys =3D <&usb0 0>;
> -			phy-names =3D "usb";
> -		};
> -
> -		usb@2,0 {
> -			reg =3D <0x1000 0 0 0 0>;
> -			phys =3D <&usb0 0>;
> -			phy-names =3D "usb";
> -		};
> -	};
> -
> -Example board setup:
> -
> -&pci0 {
> -	status =3D "okay";
> -	pinctrl-0 =3D <&usb0_pins>;
> -	pinctrl-names =3D "default";
> -};
> diff --git a/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml b=
/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
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
> +  This is the bridge used internally to connect the USB controllers to t=
he
> +  AHB. There is one bridge instance per USB port connected to the intern=
al
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

When the description is rather straightforward (like "this is the main
interrupt/clock") I don't think a description is expected. A number
however might be useful, I believe.

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

Maybe maxItems: 1 ?

> +
> +  bus-range:
> +    description: |
> +      The PCI bus number range; as this is a single bus, the range
> +      should be specified as the same value twice.
> +
> +  "#address-cells":
> +    const: 3
> +
> +  "#size-cells":
> +    const: 2
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  dma-ranges:
> +    description: |
> +      A single range for the inbound memory region. If not supplied,
> +      defaults to 1GiB at 0x40000000. Note there are hardware restrictio=
ns on
> +      the allowed combinations of address and size.
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
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        pci0: pci@ee090000  {
> +            compatible =3D "renesas,pci-r8a7790", "renesas,pci-rcar-gen2=
";
> +            device_type =3D "pci";
> +            clocks =3D <&cpg CPG_MOD 703>;
> +            reg =3D <0 0xee090000 0 0xc00>,
> +                  <0 0xee080000 0 0x1100>;
> +            interrupts =3D <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> +            status =3D "disabled";
> +
> +            bus-range =3D <0 0>;
> +            #address-cells =3D <3>;
> +            #size-cells =3D <2>;
> +            #interrupt-cells =3D <1>;
> +            ranges =3D <0x02000000 0 0xee080000 0 0xee080000 0 0x0001000=
0>;
> +            dma-ranges =3D <0x42000000 0 0x40000000 0 0x40000000 0 0x400=
00000>;
> +            interrupt-map-mask =3D <0xf800 0 0 0x7>;
> +            interrupt-map =3D <0x0000 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LE=
VEL_HIGH>,
> +                            <0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVE=
L_HIGH>,
> +                            <0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVE=
L_HIGH>;
> +
> +            usb@1,0 {
> +                reg =3D <0x800 0 0 0 0>;
> +                phys =3D <&usb0 0>;
> +                phy-names =3D "usb";
> +            };
> +           =20
> +            usb@2,0 {
> +                reg =3D <0x1000 0 0 0 0>;
> +                phys =3D <&usb0 0>;
> +                phy-names =3D "usb";
> +            };
> +        };
> +    };


Thanks,
Miqu=C3=A8l
