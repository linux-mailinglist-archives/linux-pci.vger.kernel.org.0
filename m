Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB40B508867
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 14:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353382AbiDTMrG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 08:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353371AbiDTMrE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 08:47:04 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5E6205C2;
        Wed, 20 Apr 2022 05:44:16 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DA22924000F;
        Wed, 20 Apr 2022 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650458653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oSLULjswgGSEpCqqpKaDV5ExgTNekfcIrTBoL1UaO/s=;
        b=FvJ4uNqwtnvVXETbu6CpsxfD/rs02ip9UOIUEZm2QOqMfCoLn1so+E9L3YE8uAscgy3jCc
        E8csaPktYtHLJUBf745e5DGWMj/+SfdxwOYAsFKo02YEhYfWVacuP8zj51xYTwCeCoW2qP
        9jPwOlEiyuIbBeo84G+pm8e6xuPlIowKudnkoMow1mo/7b+AqOLG7KVUTgrgIFLbkcTV9L
        FUITsB9lusIZzdXnyTWKmHSD9N0yEhMxLtgYwDQYrOVXnYHy3UH5j+ubZtd7kmX1h/s8iL
        wXckS3VD9sIPJoLqcoO0zhGpPcg+sbLgXYLKsWMEMcXSGunnrftntFn/S2ltBg==
Date:   Wed, 20 Apr 2022 14:44:11 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRz?= =?UTF-8?B?a2k=?= 
        <kw@linux.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: PCI: renesas-pci-usb: Convert
 bindings to json-schema
Message-ID: <20220420144411.2d369b49@bootlin.com>
In-Reply-To: <YlhkwvGdcf4ozTzG@robh.at.kernel.org>
References: <20220414074011.500533-1-herve.codina@bootlin.com>
        <20220414074011.500533-3-herve.codina@bootlin.com>
        <YlhkwvGdcf4ozTzG@robh.at.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On Thu, 14 Apr 2022 13:15:30 -0500
Rob Herring <robh@kernel.org> wrote:

> On Thu, Apr 14, 2022 at 09:40:05AM +0200, Herve Codina wrote:
> > Convert Renesas PCI bridge bindings documentation to json-schema.
> > Also name it 'renesas,pci-usb' as it is specifically used to
> > connect the PCI USB controllers to AHB bus. =20
>=20
> Please name it based on compatible strings. renesas,pci-rcar-gen2.yaml

Ok, renamed.

>=20
> >=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  .../devicetree/bindings/pci/pci-rcar-gen2.txt |  84 -----------
> >  .../bindings/pci/renesas,pci-usb.yaml         | 134 ++++++++++++++++++
> >  2 files changed, 134 insertions(+), 84 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/pci/pci-rcar-gen2=
.txt
> >  create mode 100644 Documentation/devicetree/bindings/pci/renesas,pci-u=
sb.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/=
Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> > deleted file mode 100644
...
> > diff --git a/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml=
 b/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
> > new file mode 100644
...
> > index 000000000000..3f8d79b746c7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
> > @@ -0,0 +1,134 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/renesas,pci-usb.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas AHB to PCI bridge
> > +
> > +maintainers:
> > +  - Marek Vasut <marek.vasut+renesas@gmail.com>
> > +  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > +
> > +description: |
> > +  This is the bridge used internally to connect the USB controllers to=
 the
> > +  AHB. There is one bridge instance per USB port connected to the inte=
rnal
> > +  OHCI and EHCI controllers.
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-bus.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - renesas,pci-r8a7742      # RZ/G1H
> > +              - renesas,pci-r8a7743      # RZ/G1M
> > +              - renesas,pci-r8a7744      # RZ/G1N
> > +              - renesas,pci-r8a7745      # RZ/G1E
> > +              - renesas,pci-r8a7790      # R-Car H2
> > +              - renesas,pci-r8a7791      # R-Car M2-W
> > +              - renesas,pci-r8a7793      # R-Car M2-N
> > +              - renesas,pci-r8a7794      # R-Car E2
> > +          - const: renesas,pci-rcar-gen2 # R-Car Gen2 and RZ/G1
> > +
> > +  reg:
> > +    description: |
> > +      A list of physical regions to access the device. The first is
> > +      the operational registers for the OHCI/EHCI controllers and the
> > +      second is for the bridge configuration and control registers.
> > +    minItems: 2
> > +    maxItems: 2
> > +
> > +  interrupts:
> > +    description: Interrupt for the device.
> > +
> > +  interrupt-map:
> > +    description: |
> > +      Standard property used to define the mapping of the PCI interrup=
ts
> > +      to the GIC interrupts.
> > +
> > +  interrupt-map-mask:
> > +    description:
> > +      Standard property that helps to define the interrupt mapping.
> > +
> > +  clocks:
> > +    description: The reference to the device clock.
> > +
> > +  bus-range:
> > +    description: |
> > +      The PCI bus number range; as this is a single bus, the range
> > +      should be specified as the same value twice. =20
>=20
> items:
>   const: 0

Well, some other values are present in some dtsi files such as
'bus_range =3D <1 1>;' or 'bus_range =3D <2 2>;' in r8a7742.dtsi.

The constraint is to have the same value twice. Is there a way
to specify this constraint ?

>=20
> > +
> > +  "#address-cells":
> > +    const: 3
> > +
> > +  "#size-cells":
> > +    const: 2
> > +
> > +  "#interrupt-cells":
> > +    const: 1 =20
>=20
> All these are defined by pci-bus.yaml

Right.
Replaced by:

"#address-cells": true
"#size-cells": true
"#interrupt-cells": true

Is that correct ?

>=20
> > +
> > +  dma-ranges:
> > +    description: |
> > +      A single range for the inbound memory region. If not supplied,
> > +      defaults to 1GiB at 0x40000000. Note there are hardware restrict=
ions on
> > +      the allowed combinations of address and size. =20
>=20
> 'a single range' =3D=3D 'maxItems: 1'

Ok, maxItems added.

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-map
> > +  - interrupt-map-mask
> > +  - clocks
> > +  - bus-range
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - "#interrupt-cells"
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/r8a7790-cpg-mssr.h>
> > +
> > +    bus {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +
> > +        pci0: pci@ee090000  {
> > +            compatible =3D "renesas,pci-r8a7790", "renesas,pci-rcar-ge=
n2";
> > +            device_type =3D "pci";
> > +            clocks =3D <&cpg CPG_MOD 703>;
> > +            reg =3D <0 0xee090000 0 0xc00>,
> > +                  <0 0xee080000 0 0x1100>;
> > +            interrupts =3D <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> > +            status =3D "disabled"; =20
>=20
> Don't disable your example.

Ok, done


Thanks for the review.
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
