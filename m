Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27588166354
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2020 17:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgBTQlO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Feb 2020 11:41:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:43744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgBTQlO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Feb 2020 11:41:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DDBB7AFF7;
        Thu, 20 Feb 2020 16:41:11 +0000 (UTC)
Message-ID: <d8f1d9729c73ca0bdfafe13b3d57c16edec6f293.camel@suse.de>
Subject: Re: [PATCH v2 2/4] firmware: raspberrypi: Introduce vl805 init
 routine
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        tim.gover@raspberrypi.org, linux-pci@vger.kernel.org,
        wahrenst@gmx.net
Date:   Thu, 20 Feb 2020 17:41:08 +0100
In-Reply-To: <538b8ba7-e6d3-e8f2-0cc6-ce3485bc7848@gmail.com>
References: <20200219123933.2792-1-nsaenzjulienne@suse.de>
         <20200219123933.2792-3-nsaenzjulienne@suse.de>
         <538b8ba7-e6d3-e8f2-0cc6-ce3485bc7848@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-9L+CAkWKlVlZC8VcHjhe"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-9L+CAkWKlVlZC8VcHjhe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-02-19 at 11:13 -0800, Florian Fainelli wrote:
> On 2/19/20 4:39 AM, Nicolas Saenz Julienne wrote:
> > On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either b=
e
> > loaded directly from an EEPROM or, if not present, by the SoC's
> > VideCore. The function informs VideCore that VL805 was just reset, or
> > requests for a probe defer.
> >=20
> > Based on Tim Gover's downstream implementation.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
>=20
> [snip]
>=20
>=20
> > diff --git a/include/soc/bcm2835/raspberrypi-firmware.h
> > b/include/soc/bcm2835/raspberrypi-firmware.h
> > index cc9cdbc66403..a37c3a461d2a 100644
> > --- a/include/soc/bcm2835/raspberrypi-firmware.h
> > +++ b/include/soc/bcm2835/raspberrypi-firmware.h
> > @@ -8,6 +8,7 @@
> > =20
> >  #include <linux/types.h>
> >  #include <linux/of_device.h>
> > +#include <linux/pci.h>
>=20
> I would move this inclusion where we need it, which is in
> drivers/firmware/raspberrypi.c and only provide a forward declaration
> here (avoids needless rebuilds).

Noted


--=-9L+CAkWKlVlZC8VcHjhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5OtqQACgkQlfZmHno8
x/5/BQf/Q7Dm3FnyxJnB6OEt0XKSK9nzNb/iq0RrYo9FcRhaWHUkzfbR5o+SIcVP
vcd3a/3jKnNsczupJqC6NrBtAsAmxQnyxgUJ0QyZ39+0U7GOzBZ6mGZqf9zSNHQL
feOHiAdV/dg8mG/pSFp13f+nDbACArTdk5+w72u+goZtc8RzOC8OZA0eAXDS3YDD
D7nbAm4KsDleR/3yygc58it5DONAvPy0Zf/Afek+CtSqMvOCvZtyPEqQ7x6buJCb
UURCuwxRPRq165Ebja2eUhsJKou6t/eMzbiXK+ZfwaNDGsUDhKYcGp5JCkjGT+NO
LHEUOVY4+VPrliTKoP4Z2QGMDHm3Aw==
=6Ngk
-----END PGP SIGNATURE-----

--=-9L+CAkWKlVlZC8VcHjhe--

