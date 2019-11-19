Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5B3102300
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 12:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbfKSL21 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 06:28:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:60244 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfKSL21 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 06:28:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9BA60BBFA;
        Tue, 19 Nov 2019 11:28:25 +0000 (UTC)
Message-ID: <5050053fc650e526d91e194465b21ae1730d571c.camel@suse.de>
Subject: Re: [PATCH v2 2/6] dt-bindings: PCI: Add bindings for brcmstb's
 PCIe device
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, maz@kernel.org,
        phil@raspberrypi.org, linux-kernel@vger.kernel.org,
        jeremy.linton@arm.com, Eric Anholt <eric@anholt.net>,
        mbrugger@suse.com, bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <wahrenst@gmx.net>, james.quinlan@broadcom.com,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Date:   Tue, 19 Nov 2019 12:28:22 +0100
In-Reply-To: <20191119111735.GQ43905@e119886-lin.cambridge.arm.com>
References: <20191112155926.16476-1-nsaenzjulienne@suse.de>
         <20191112155926.16476-3-nsaenzjulienne@suse.de>
         <20191119111735.GQ43905@e119886-lin.cambridge.arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-aRfpxxU/pqUdFGe5x0kl"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-aRfpxxU/pqUdFGe5x0kl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-11-19 at 11:17 +0000, Andrew Murray wrote:
> On Tue, Nov 12, 2019 at 04:59:21PM +0100, Nicolas Saenz Julienne wrote:
> > From: Jim Quinlan <james.quinlan@broadcom.com>
> >=20
> > The DT bindings description of the brcmstb PCIe device is described.
> > This node can only be used for now on the Raspberry Pi 4.
> >=20
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > Co-developed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> >=20
> > ---
> >=20
> > Changes since v1:
> >   - Fix commit Subject
> >   - Remove linux,pci-domain
> >=20
> > This was based on Jim's original submission[1], converted to yaml and
> > adapted to the RPi4 case.
> >=20
> > [1] https://patchwork.kernel.org/patch/10605937/
> >=20
> >  .../bindings/pci/brcm,stb-pcie.yaml           | 110 ++++++++++++++++++
> >  1 file changed, 110 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/brcm,stb-pcie=
.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > new file mode 100644
> > index 000000000000..4cbb18821300
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > @@ -0,0 +1,110 @@
> > +# SPDX-License-Identifier: GPL-2.0
>=20
> I think in the last revision Rob asked you to change the license to
> the following:
>=20
> # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

Yes, but I had already sent this series by then. v3 will have all the fixes=
 in.

Regards,
Nicolas


--=-aRfpxxU/pqUdFGe5x0kl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3T0dYACgkQlfZmHno8
x/5LJgf/Q5Qh0zHUdY3QyjOEG6rvYIpqvit4rkhX3Feo92k3mEcYqJpkVsUWYWlx
5cL7rwP7YjYHl7wQEKjEdp7i5pOYk/TGorh5yQ/W7VMhgmOyZ2ofIVOmeUz+lcXj
7gGHa/2Fet0RMhMzvQl+Xm7/Fw5MEMDQDJSOZtmzcL4aanTI1pkh1UaA5NeXMP25
rrOfpPI2AqXjM5Qp35EGQZ9xuVVbSZpr602VXkAEeAOz3VSJoHbe4/J1wy+tPtbS
qn2/r0CLy0ndPVyogNhX+vWVgRCITMH/B+KhuhhxXqjbUAylC5JGurpTrDE37kO6
wA3wosxY3hFskV5PdpLlIq7x6tboGQ==
=oQ4d
-----END PGP SIGNATURE-----

--=-aRfpxxU/pqUdFGe5x0kl--

