Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4A66F2CDC
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 11:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388044AbfKGKxj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 05:53:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:59998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727278AbfKGKxj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 05:53:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3269B2CD;
        Thu,  7 Nov 2019 10:53:36 +0000 (UTC)
Message-ID: <df7a30583436589449ec9cb587b5ab5e8985d3d7.camel@suse.de>
Subject: Re: [PATCH 1/4] dt-bindings: pci: add bindings for brcmstb's PCIe
 device
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        mbrugger@suse.com, linux-pci@vger.kernel.org, phil@raspberrypi.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, james.quinlan@broadcom.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net
Date:   Thu, 07 Nov 2019 11:53:34 +0100
In-Reply-To: <20191107103235.GW9723@e119886-lin.cambridge.arm.com>
References: <20191106214527.18736-1-nsaenzjulienne@suse.de>
         <20191106214527.18736-2-nsaenzjulienne@suse.de>
         <20191107103235.GW9723@e119886-lin.cambridge.arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-lSQQztMt1wJEBprNfTIe"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-lSQQztMt1wJEBprNfTIe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-11-07 at 10:32 +0000, Andrew Murray wrote:
> On Wed, Nov 06, 2019 at 10:45:23PM +0100, Nicolas Saenz Julienne wrote:
> > From: Jim Quinlan <james.quinlan@broadcom.com>
>=20
> Nit: Looking at past git history, ideally the patch subject would be
> 'dt-bindings: *PCI*: *A*dd bindings for brcmstb's PCIe.

Noted.

> > The DT bindings description of the brcmstb PCIe device is described.
> > This node can only be used for now on the Raspberry Pi 4.
> >=20
> > This was based on Jim's original submission[1], converted to yaml and
> > adapted to the RPi4 case.
>=20
> Thanks for picking this up.
>=20
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
> >=20
> > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > new file mode 100644
> > index 000000000000..0b81c26f8568
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > @@ -0,0 +1,116 @@
> > +# SPDX-License-Identifier: GPL-2.0
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
> > +
> > +  ranges: true
> > +
> > +  dma-ranges: true
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: sw_pcie
> > +
> > +  msi-controller:	/* We use the domain number as our controller number=
 */
> > 	pcie->id =3D of_get_pci_domain_nr(dn);
> > 	if (pcie->id < 0)
> > 		return pcie->id;
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
>=20
> I don't think pci-domain is *required* is it?

You're right, I missed that one. It was needed on some of the STB devices b=
ut
not in the RPi4's case. I'll remove it in v2.

Regards,
Nicolas


--=-lSQQztMt1wJEBprNfTIe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3D964ACgkQlfZmHno8
x/6Dlgf9F45I7R8USQ8gJmC9ajqlrRMvsDHlY81jEgVLxDCZbF0PRe59u1wFyB3G
/FikTo9UHzdlxoh53V+s79l0sfIUfivDe1QA6OHUBOLl5DjK4db9igX6SnEX7EQi
baB5K6bwJgtqYOyOmwkyHoxBrkTCUkURwqQ6Qn49s9Q2mNzgjAe1VHredXV6BvT8
ZcUDwz6voiY4wSEZen9tHqVoKQdSRgq8GGrohiHPzvyShfv515AckbEMKzR0Z5cf
f73H4sNp9/P/2fk4Rtvujc22rSvHPLcHIUGZalz8tcxdGIKX02Lh1Fjx9hAzdxJZ
0i/rcLENlxAAYJW2YCYp5ILND4hVEg==
=Sc3w
-----END PGP SIGNATURE-----

--=-lSQQztMt1wJEBprNfTIe--

