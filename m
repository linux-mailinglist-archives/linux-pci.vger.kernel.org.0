Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2B221EFE5
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 13:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgGNL7Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 07:59:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:50290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgGNL7Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jul 2020 07:59:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 710A2B013;
        Tue, 14 Jul 2020 11:59:25 +0000 (UTC)
Message-ID: <ed42e27eaf48fd19cc8ccccd15b0b25ba1d836ae.camel@suse.de>
Subject: Re: [PATCH v3 1/9] dt-bindings: reset: Add a binding for the RPi
 Firmware reset controller
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh@kernel.org>
Cc:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>, linux-usb@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com, devicetree@vger.kernel.org
Date:   Tue, 14 Jul 2020 13:59:21 +0200
In-Reply-To: <20200713182356.GA413630@bogus>
References: <20200612171334.26385-1-nsaenzjulienne@suse.de>
         <20200612171334.26385-2-nsaenzjulienne@suse.de>
         <20200713182356.GA413630@bogus>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-cyjjn9iMFbQ+NRASHXx8"
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-cyjjn9iMFbQ+NRASHXx8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-07-13 at 12:23 -0600, Rob Herring wrote:
> On Fri, Jun 12, 2020 at 07:13:25PM +0200, Nicolas Saenz Julienne wrote:
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
>=20
> I'm not really thrilled how this is evolving with a node per provider.=
=20
> There's no reason you can't just add #clock-cells and #reset-cells to=20
> the parent firmware node.

What are the downsides? The way I see it there is not much difference. And =
this
way of handling things is feels more intuitive and flexible (overlays can
control what to enable easily, we can take advantage of the platform device
core).

> I probably should have complained with the clocks node, but that's only=
=20
> pending for 5.9.

Note that there are more users for this pattern: "raspberrypi,firmware-ts" =
and
"raspberrypi,firmware-gpio". Actually you were the one to originally propos=
e
this it[1]. :P

There already is a fair amount of churn in these drivers because of all the=
 DT
changes we did in the past, and if we need to change how we integrate these
again, I'd really like it to be for good.

> The bigger issue is this stuff is just trickling in one bit at a time=20
> which gives no context for review. What's next? Is it really a mystery=
=20
> as to what functions the firmware provides?

We have no control over it, RPi engineers integrate new designs and new
firmware interfaces show up. This is a good example of it.

I proposed them to use SCMI as it covers most of what they are already
providing here. But no luck so far.

> You don't have to have a driver in place for every function.

I see your point, it could be more monolithic, that said, having a driver i=
s
essential. See the reverts I managed to pull off at the end of the series.

[1] https://patchwork.kernel.org/patch/10166783/#21421571


--=-cyjjn9iMFbQ+NRASHXx8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl8NnhkACgkQlfZmHno8
x/7gMAf/WpgWrzZn8OWvm5HWyZhbLlpudApJFqIMveDTldhi/2C/3fqEMLewG6PW
XjENuKydy6YXzpsn4CMxU8M2ELLf8hBU6rN0om2oW9IcQuxbNCT/DLQjjXxkzLkk
HBZnE4AomVfl9BgNPVHtwodK1tmCuNLSxLggfnCmkgAB5/6mV3/1VhKUEe4AmTba
/r7ZMNhJJHDdOc5BqCtPLj2MxwNzaFLhEgxR9TmYQuzX66BFJwggq/If8088Ektx
pk1jTsE+mkRsOUq2Pdu2kl6WQM0mxOyPefDgJDQwry/YePCuVj1JOVeCnKvKgbF5
JGPa7jelAE3azkvNQOBKXW1HiBYgsQ==
=tEOc
-----END PGP SIGNATURE-----

--=-cyjjn9iMFbQ+NRASHXx8--

