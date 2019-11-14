Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C71FC71C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2019 14:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfKNNPV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Nov 2019 08:15:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:45580 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726139AbfKNNPV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Nov 2019 08:15:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C4837B325;
        Thu, 14 Nov 2019 13:15:18 +0000 (UTC)
Message-ID: <5d706b02fb23c2dd6422306ff8d43a90910e36b8.camel@suse.de>
Subject: Re: [PATCH 1/4] dt-bindings: pci: add bindings for brcmstb's PCIe
 device
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        mbrugger@suse.com, linux-pci@vger.kernel.org, phil@raspberrypi.org,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, james.quinlan@broadcom.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net
Date:   Thu, 14 Nov 2019 14:15:13 +0100
In-Reply-To: <20191113041533.GA25497@bogus>
References: <20191106214527.18736-1-nsaenzjulienne@suse.de>
         <20191106214527.18736-2-nsaenzjulienne@suse.de>
         <20191113041533.GA25497@bogus>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-EezwcX763lm760dEcyfv"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-EezwcX763lm760dEcyfv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-11-12 at 22:15 -0600, Rob Herring wrote:
> On Wed, Nov 06, 2019 at 10:45:23PM +0100, Nicolas Saenz Julienne wrote:
> > From: Jim Quinlan <james.quinlan@broadcom.com>
> >=20
> > The DT bindings description of the brcmstb PCIe device is described.
> > This node can only be used for now on the Raspberry Pi 4.
> >=20
> > This was based on Jim's original submission[1], converted to yaml and
> > adapted to the RPi4 case.
> >=20
> > [1] https://patchwork.kernel.org/patch/10605937/
> >=20
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > Co-developed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  .../bindings/pci/brcm,stb-pcie.yaml           | 116 ++++++++++++++++++
> >  1 file changed, 116 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/brcm,stb-pcie=
.yaml
>=20
> I'm working on a common PCI host schema that should cut down some of the=
=20
> standard props.

Is there a way for me to have a look at it so I can rebase the binding on t=
op
of it?

> > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > new file mode 100644
> > index 000000000000..0b81c26f8568
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > @@ -0,0 +1,116 @@
> > +# SPDX-License-Identifier: GPL-2.0
>=20
> Dual license new bindings please:
>=20
> # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

Noted

> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Brcmstb PCIe Host Controller Device Tree Bindings
> > +
> > +maintainers:
> > +  - Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > +
> > +properties:
> > +  compatible:
> > +    const: brcm,bcm2711-pcie # The Raspberry Pi 4
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 2
> > +    items:
> > +      - description: PCIe host controller
> > +      - description: builtin MSI controller
> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    maxItems: 2
> > +    items:
> > +      - const: pcie
> > +      - const: msi
> > +
> > +  "#address-cells":
> > +    const: 3
> > +
> > +  "#size-cells":
> > +    const: 2
> > +
> > +  "#interrupt-cells":
> > +    const: 1
> > +
> > +  interrupt-map-mask: true
> > +
> > +  interrupt-map: true
>=20
> 4 entries?

You're right, for this specific case, as XHCI is hardwired and only uses on=
e
irq, we'd only need the first entry.  Although who knows, maybe they are wi=
red
nonetheless. I guess it's safer to assume they aren't for now.

> You'll need to bracket <> each entry in the example and dts.

Ok

> > +
> > +  ranges: true
>=20
> How many entries?

One, I'll update it.

> > +
> > +  dma-ranges: true
>=20
> How many entries?

One, I'll update it.

> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: sw_pcie
> > +
> > +  msi-controller:
> > +    description: Identifies the node as an MSI controller.
> > +    type: boolean
> > +
> > +  msi-parent:
> > +    description: MSI controller the device is capable of using.
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +
> > +  linux,pci-domain:
> > +    description: PCI domain ID. Should be unique for each host control=
ler.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  brcm,enable-ssc:
> > +    description: Indicates usage of spread-spectrum clocking.
> > +    type: boolean
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - "#interrupt-cells"
> > +  - interrupt-map-mask
> > +  - interrupt-map
> > +  - ranges
> > +  - dma-ranges
> > +  - linux,pci-domain
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    scb {
> > +            #address-cells =3D <2>;
> > +            #size-cells =3D <1>;
> > +            pcie0: pcie@7d500000 {
> > +                    compatible =3D "brcm,bcm2711-pcie";
> > +                    reg =3D <0x0 0x7d500000 0x9310>;
> > +                    #address-cells =3D <3>;
> > +                    #size-cells =3D <2>;
> > +                    #interrupt-cells =3D <1>;
> > +                    interrupts =3D <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> > +                                 <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> > +                    interrupt-names =3D "pcie", "msi";
> > +                    interrupt-map-mask =3D <0x0 0x0 0x0 0x7>;
> > +                    interrupt-map =3D <0 0 0 1 &gicv2 GIC_SPI 143
> > IRQ_TYPE_LEVEL_HIGH
> > +                                     0 0 0 2 &gicv2 GIC_SPI 144
> > IRQ_TYPE_LEVEL_HIGH
> > +                                     0 0 0 3 &gicv2 GIC_SPI 145
> > IRQ_TYPE_LEVEL_HIGH
> > +                                     0 0 0 4 &gicv2 GIC_SPI 146
> > IRQ_TYPE_LEVEL_HIGH>;
> > +                    msi-parent =3D <&pcie0>;
> > +                    msi-controller;
> > +                    ranges =3D <0x02000000 0x0 0xf8000000 0x6 0x000000=
00 0x0
> > 0x04000000>;
> > +                    dma-ranges =3D <0x02000000 0x0 0x00000000 0x0 0x00=
000000
> > 0x0 0x80000000>;
> > +                    linux,pci-domain =3D <0>;
> > +                    brcm,enable-ssc;
> > +            };
> > +    };
> > --=20
> > 2.23.0
> >=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


--=-EezwcX763lm760dEcyfv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3NU2EACgkQlfZmHno8
x/707Af/c0al+IHK9wVKSNbl43BuvRZ4DBZLfHID0a6HS5Ny3bkHWhnn2iXzj4g8
CZWrcyzTGuS5y54dI9NORjH64zYSFPjz/wY6sB6EFb9Rd/7iT7HFbHEZZNcSosq+
n4OAQRlGYjkK8/TGS7e/5Q+8/9aIByDftdSUPGK249n8Rj4Fd0tiJbYQE+FVfelA
ivEScJDu0CGuwC20nzDhoden5m2qV1Sk4FAs4rKPKkTWpi1z/qh0czMTEa7i7hcf
KPzJu3WLCIxwurXQWd6xnm6roonW81larpDkYjFuGLZ1zoZvG5Q92aobXiKQftmG
tqRo3Bz/w9DhSHoFv7Ka50ERyTZyHQ==
=v018
-----END PGP SIGNATURE-----

--=-EezwcX763lm760dEcyfv--

