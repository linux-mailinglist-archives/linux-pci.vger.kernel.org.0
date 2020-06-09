Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D501F3950
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 13:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgFILOY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 07:14:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:57828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728938AbgFILOV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 07:14:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1D01AABCE;
        Tue,  9 Jun 2020 11:14:23 +0000 (UTC)
Message-ID: <2cee4af79f5f599eb1a6c1f6f0ece504eb111799.camel@suse.de>
Subject: Re: [PATCH 1/9] dt-bindings: reset: Add a binding for the RPi
 Firmware USB reset
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        gregkh@linuxfoundation.org, wahrenst@gmx.net, robh@kernel.org,
        mathias.nyman@linux.intel.com, Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, tim.gover@raspberrypi.org,
        helgaas@kernel.org, lorenzo.pieralisi@arm.com,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 09 Jun 2020 13:14:17 +0200
In-Reply-To: <ffc9ec9e-bd1c-a8dd-8a68-a15bf95c919b@gmail.com>
References: <20200608192701.18355-1-nsaenzjulienne@suse.de>
         <20200608192701.18355-2-nsaenzjulienne@suse.de>
         <ffc9ec9e-bd1c-a8dd-8a68-a15bf95c919b@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-frycM163Ry/rWh+gs2/d"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-frycM163Ry/rWh+gs2/d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-06-08 at 12:58 -0700, Florian Fainelli wrote:
>=20
> On 6/8/2020 12:26 PM, Nicolas Saenz Julienne wrote:
> > The firmware running on the RPi VideoCore can be used to reset and
> > initialize the board's xHCI controller. The reset controller is passed
> > to the PCI device through the DT, hence this binding.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 21 +++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2=
835-
> > firmware.yaml
> > b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
> > firmware.yaml
> > index b48ed875eb8e..8f9d0986c28f 100644
> > --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
> > firmware.yaml
> > +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
> > firmware.yaml
> > @@ -39,6 +39,22 @@ properties:
> >        - compatible
> >        - "#clock-cells"
> > =20
> > +  usb-reset:
> > +    type: object
> > +
> > +    properties:
> > +      compatible:
> > +        const: raspberrypi,firmware-usb-reset
>=20
> I would make this less USB centric, even if this is the only consumer of
> the reset controller for now, there could, in premise be other blocks
> that require a reset (e.g.: V3D) that would involve going to the VPU
> firmware because of various requirements (security, register blocking etc=
.).

I like the idea, I'll introduce this in v2.

> > +
> > +      "#clock-cells":
>=20
> Did not you mean #reset-cells here?
>=20

Sorry I missed that.

Regards,
Nicolas


--=-frycM163Ry/rWh+gs2/d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7fbwkACgkQlfZmHno8
x/4Fjwf/dpmZ6iwo1Evmz4GIdKPmASwHY2EwMJw9mBAU8Nx/FHwm7WSfpJ+LkMU5
/2Qw5BvO882IZAxiCyz8tN3yigapEK8EyuawgZRZtT2hBqnlGhfs4TEgEhkub1Mo
LdYOs9YFYQZ9kLeZO21TnBi/aqlRYj5cKKaxcZKgtPsGxrJJ37DgUmLYm06Q3llm
lmGUMIdGKm7Gfcgc0BLac7AF2EY7vreHtCaBB6e1Dg8BOqLAT9776fbLJmmqR+zY
2u6xZ7BL6W4i4wv1WJcJOdTC0R5fhB833Ko+XOKWNARY3iqZVBCU+Xk6A5s4vNDH
s76WnK0O5nGoaF1JTbtRf31QUEbKVg==
=hu0w
-----END PGP SIGNATURE-----

--=-frycM163Ry/rWh+gs2/d--

