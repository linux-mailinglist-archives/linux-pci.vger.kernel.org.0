Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9431FCAB6
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 12:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgFQKWQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 06:22:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:36332 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFQKWQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jun 2020 06:22:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C9C2AAC50;
        Wed, 17 Jun 2020 10:22:17 +0000 (UTC)
Message-ID: <2b435e7fcf2c4600cf1618132f107a49d826d375.camel@suse.de>
Subject: Re: [PATCH v3 1/9] dt-bindings: reset: Add a binding for the RPi
 Firmware reset controller
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Philipp Zabel <p.zabel@pengutronix.de>, f.fainelli@gmail.com,
        gregkh@linuxfoundation.org, wahrenst@gmx.net,
        linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Date:   Wed, 17 Jun 2020 12:22:10 +0200
In-Reply-To: <babff895a0b5e2cd63082bd38f087bd1bc345671.camel@pengutronix.de>
References: <20200612171334.26385-1-nsaenzjulienne@suse.de>
         <20200612171334.26385-2-nsaenzjulienne@suse.de>
         <babff895a0b5e2cd63082bd38f087bd1bc345671.camel@pengutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-SUf4bLGSB+5z9632Byq0"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-SUf4bLGSB+5z9632Byq0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2020-06-17 at 11:55 +0200, Philipp Zabel wrote:
> Hi Nicolas,
>=20
> On Fri, 2020-06-12 at 19:13 +0200, Nicolas Saenz Julienne wrote:
> > The firmware running on the RPi VideoCore can be used to reset and
> > initialize HW controlled by the firmware.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> >=20
> > ---
> > Changes since v2:
> >  - Add include file for reset IDs
> >=20
> > Changes since v1:
> >  - Correct cells binding as per Florian's comment
> >  - Change compatible string to be more generic
> >=20
> >  .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 21 +++++++++++++++++++
> >  .../reset/raspberrypi,firmware-reset.h        | 13 ++++++++++++
> >  2 files changed, 34 insertions(+)
> >  create mode 100644 include/dt-bindings/reset/raspberrypi,firmware-rese=
t.h
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2=
835-
> > firmware.yaml
> > b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
> > firmware.yaml
> > index b48ed875eb8e..23a885af3a28 100644
> > --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
> > firmware.yaml
> > +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-
> > firmware.yaml
> > @@ -39,6 +39,22 @@ properties:
> >        - compatible
> >        - "#clock-cells"
> > =20
> > +  reset:
> > +    type: object
> > +
> > +    properties:
> > +      compatible:
> > +        const: raspberrypi,firmware-reset
> > +
> > +      "#reset-cells":
> > +        const: 1
> > +        description: >
> > +          The argument is the ID of the firmware reset line to affect.
> > +
> > +    required:
> > +      - compatible
> > +      - "#reset-cells"
> > +
> >      additionalProperties: false
> > =20
> >  required:
> > @@ -55,5 +71,10 @@ examples:
> >              compatible =3D "raspberrypi,firmware-clocks";
> >              #clock-cells =3D <1>;
> >          };
> > +
> > +        reset: reset {
> > +            compatible =3D "raspberrypi,firmware-reset";
> > +            #reset-cells =3D <1>;
> > +        };
> >      };
> >  ...
> > diff --git a/include/dt-bindings/reset/raspberrypi,firmware-reset.h
> > b/include/dt-bindings/reset/raspberrypi,firmware-reset.h
> > new file mode 100644
> > index 000000000000..1a4f4c792723
> > --- /dev/null
> > +++ b/include/dt-bindings/reset/raspberrypi,firmware-reset.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2020 Nicolas Saenz Julienne
> > + * Author: Nicolas Saenz Julienne <nsaenzjulienne@suse.com>
> > + */
> > +
> > +#ifndef _DT_BINDINGS_RASPBERRYPI_FIRMWARE_RESET_H
> > +#define _DT_BINDINGS_RASPBERRYPI_FIRMWARE_RESET_H
> > +
> > +#define RASPBERRYPI_FIRMWARE_RESET_ID_USB	0
> > +#define RASPBERRYPI_FIRMWARE_RESET_NUM_IDS	1
> > +
> > +#endif
>=20
> Are there going to be any more firmware controlled resets in the future?

There are not right now, but it's likely some will show up in the future. I
have some contenders in mind, which I'll request once we settle on a design
here, but it ultimately depends on what the RPi people decide to implement.

Regards,
Nicolas


--=-SUf4bLGSB+5z9632Byq0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7p7tIACgkQlfZmHno8
x/5gbQf+NdkkGDqz0A6JT3txmSyClQsVqxhiMqgbCjdVtLi8EHQ6VKQLpz6o9Tfr
BQY0MADjoJqdwne4+fryTGo6UPQqCRzitdc1RCPHX7YXnXK1x3tQZ39IqBf7hZqZ
i/8dNQ7g057lEcxI8ZdS9E0DcBy7LuIqvROjPcgYyeoEkmg3WdzKSVOWBv6RLVC2
/jSfNFWWvUu3a94VqQqORqVn63oYrmPdYMsE/KBgG925yvYmz3vCwSMOUmIyeLja
N2edh+OTAMNtfof6a7LOnvFEI/0G2GOn6q0mTxrQP2M+8IgUOnSu5P2rOmn6lFo2
9N2BwOQZ5Zy7RTqa/XQrEpqvnSF9Pw==
=BLff
-----END PGP SIGNATURE-----

--=-SUf4bLGSB+5z9632Byq0--

