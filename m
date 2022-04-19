Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839575070D6
	for <lists+linux-pci@lfdr.de>; Tue, 19 Apr 2022 16:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344786AbiDSOn4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Apr 2022 10:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiDSOnz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2022 10:43:55 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE6721828;
        Tue, 19 Apr 2022 07:41:10 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8137D24000E;
        Tue, 19 Apr 2022 14:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650379268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9u41AmvPYzaP5UxEoTmolh4l0tPcqavKOqVOLJJD3S4=;
        b=ifnn0HaliB65Zi+kAJRPXi5a+jTdBu3WK28oWc6C177sY+9wmTGu2+9paSFyuEFrjwqb2I
        EWmhc7RgywHsmIZBb9pI0Ued52Cd7GVuNZsmVt63Tc26FASbndA/TAKJYDc96j5pQyNOdu
        fcYp1bnmDUwby5nsy3gnxN8NLoUnopiyswW2W7ktfnfeSQIXr4ulP7eyL+VtjVqYUL8PMj
        f7zQx6OMXad5pt3DJZpF8QdOa5WCux7Pu4/l4/lIq2tIi3X+a0BoN0+vRum89II7OH1qCS
        nbZrSCLzmE1NsrQeo7w8Btcm2ARDea8dHqdlyVBFfqroKGJjfWQumv3Lab1qbQ==
Date:   Tue, 19 Apr 2022 16:41:05 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: PCI: renesas-pci-usb: Convert
 bindings to json-schema
Message-ID: <20220419164105.14bf82cf@bootlin.com>
In-Reply-To: <CAMuHMdUhr7emtsxoxGP5EH2EzNK=PM_7+-32cesecjQjoW1ryQ@mail.gmail.com>
References: <20220414074011.500533-1-herve.codina@bootlin.com>
 <20220414074011.500533-3-herve.codina@bootlin.com>
 <CAMuHMdUhr7emtsxoxGP5EH2EzNK=PM_7+-32cesecjQjoW1ryQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Geert,

On Thu, 14 Apr 2022 10:28:47 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Herv=C3=A9,
>=20
> On Thu, Apr 14, 2022 at 9:40 AM Herve Codina <herve.codina@bootlin.com> w=
rote:
> > Convert Renesas PCI bridge bindings documentation to json-schema.
> > Also name it 'renesas,pci-usb' as it is specifically used to
> > connect the PCI USB controllers to AHB bus.
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com> =20
>=20
> Thanks a lot for tackling this DT binding file!
>=20
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
> > @@ -0,0 +1,134 @@
> > +# SPDX-License-Identifier: GPL-2.0 =20
>=20
> scripts/checkpatch.pl says:
> WARNING: DT binding documents should be licensed (GPL-2.0-only OR BSD-2-C=
lause)

Right, changed to "GPL-2.0-only OR BSD-2-Clause"

>=20
> > +  reg:
> > +    description: |
> > +      A list of physical regions to access the device. The first is
> > +      the operational registers for the OHCI/EHCI controllers and the
> > +      second is for the bridge configuration and control registers.
> > +    minItems: 2
> > +    maxItems: 2 =20
>=20
> reg:
>   items:
>     - description: Operational registers for the OHCI/EHCI controllers.
>     - description: Bridge configuration and control registers.

Ok, changed.

>=20
> > +
> > +  interrupts:
> > +    description: Interrupt for the device. =20
>=20
> maxItems: 1
>=20
> The description is not needed.

Ok, changed.

>=20
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
> > +    description: The reference to the device clock. =20
>=20
> maxItems: 1
>=20
> The description is not needed.

Ok, changed

>=20
> Missing "resets" and "power-domains" properties.
>=20
> Missing description of the child nodes.

"resets", "power-domains" dans child nodes added

>=20
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-map
> > +  - interrupt-map-mask
> > +  - clocks =20
>=20
> Missing "resets" and "power-domains".

Added

>=20
> > +  - bus-range
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - "#interrupt-cells"
> > +
> > +unevaluatedProperties: false =20
>=20
> Why doesn't "make dtbs_check" complain about the presence of
> e.g. "resets" in the actual DTS files?
>=20
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/r8a7790-cpg-mssr.h>
> > +
> > +    bus {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>; =20
>=20
> I think you should drop this (and the corresponding high addresses
> below).
>=20

Ok

> > +
> > +        pci0: pci@ee090000  {
> > +            compatible =3D "renesas,pci-r8a7790", "renesas,pci-rcar-ge=
n2";
> > +            device_type =3D "pci";
> > +            clocks =3D <&cpg CPG_MOD 703>;
> > +            reg =3D <0 0xee090000 0 0xc00>,
> > +                  <0 0xee080000 0 0x1100>;
> > +            interrupts =3D <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; =20
>=20
>                         power-domains =3D <&sysc R8A7790_PD_ALWAYS_ON>;
>                         resets =3D <&cpg 703>;

Ok

>=20
> > +            status =3D "disabled";
> > +
> > +            bus-range =3D <0 0>;
> > +            #address-cells =3D <3>;
> > +            #size-cells =3D <2>;
> > +            #interrupt-cells =3D <1>;
> > +            ranges =3D <0x02000000 0 0xee080000 0 0xee080000 0 0x00010=
000>;
> > +            dma-ranges =3D <0x42000000 0 0x40000000 0 0x40000000 0 0x4=
0000000>;
> > +            interrupt-map-mask =3D <0xf800 0 0 0x7>;
> > +            interrupt-map =3D <0x0000 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_=
LEVEL_HIGH>,
> > +                            <0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LE=
VEL_HIGH>,
> > +                            <0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LE=
VEL_HIGH>;
> > +
> > +            usb@1,0 {
> > +                reg =3D <0x800 0 0 0 0>;
> > +                phys =3D <&usb0 0>;
> > +                phy-names =3D "usb";
> > +            };
> > + =20
>=20
> ERROR: trailing whitespace
> #249: FILE: Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml:12=
7:
> +            $

Ok

>=20
> > +            usb@2,0 {
> > +                reg =3D <0x1000 0 0 0 0>;
> > +                phys =3D <&usb0 0>;
> > +                phy-names =3D "usb";
> > +            };
> > +        };
> > +    }; =20
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

Thanks for the review,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
