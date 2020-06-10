Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9361F57EF
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 17:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbgFJPhW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 11:37:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:34026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgFJPhV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jun 2020 11:37:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 345F3AD75;
        Wed, 10 Jun 2020 15:37:23 +0000 (UTC)
Message-ID: <252b688105ddff381798ec3150066288762178b0.camel@suse.de>
Subject: Re: [PATCH v2 1/9] dt-bindings: reset: Add a binding for the RPi
 Firmware reset controller
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        gregkh@linuxfoundation.org, wahrenst@gmx.net,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Date:   Wed, 10 Jun 2020 17:37:15 +0200
In-Reply-To: <c3dc9b7e-4440-7e8a-3da8-b147c48c4c40@gmail.com>
References: <20200609175003.19793-1-nsaenzjulienne@suse.de>
         <20200609175003.19793-2-nsaenzjulienne@suse.de>
         <c3dc9b7e-4440-7e8a-3da8-b147c48c4c40@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-n+aTWdme6r8Au4n90Rrf"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-n+aTWdme6r8Au4n90Rrf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian, thanks for the review :)

On Tue, 2020-06-09 at 11:07 -0700, Florian Fainelli wrote:
>=20
> On 6/9/2020 10:49 AM, Nicolas Saenz Julienne wrote:
> > The firmware running on the RPi VideoCore can be used to reset and
> > initialize HW controlled by the firmware.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> >=20
> > ---
> >=20
> > Changes since v1:
> >  - Correct cells binding as per Florian's comment
> >  - Change compatible string to be more generic
> >=20
> >  .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 21 +++++++++++++++++++
> >  1 file changed, 21 insertions(+)
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
>=20
> Is this a stray '>' character? If so, with that fixed:

No, it marks the formatting of the text below. | will keep the formatting a=
s
is, > will leave the formatting to whatever is going to use it.

Regards,
Nicolas


--=-n+aTWdme6r8Au4n90Rrf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7g/isACgkQlfZmHno8
x/5KnggAkIaMw+no0jjwGGwmLpYNI37OtXTlkJh7+vxBbP3/KDoYuOKodikYKYi7
06IGVl60YiOtYKZmeBUpt5vxCnGpFdccflCssnih0CSXLSUYSA+0+XQ7/8WI+wDF
iyBAZWn+BTleK3nJRM1EzWuiJvsH6hqE0X9SWqrH549wvJUKoh/EPMllsrrl2rr4
k3MTRQ1qUaDh+m+ZxKA14Ah1Gwhm1nOnx0LLti9+W02o270Y7dQnWwzfXwlGJHPi
kCkA5gj9PzDFq9+csd+n8ek73GJEoyQEsgphDBQbQCVb3uMpioF4jqdDxQaKFC21
NG2lzd8rO+0Rlc3UUvOFg+sB04SUcg==
=8jr+
-----END PGP SIGNATURE-----

--=-n+aTWdme6r8Au4n90Rrf--

