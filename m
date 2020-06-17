Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55101FCB33
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 12:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgFQKpJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 06:45:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:49664 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbgFQKpJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jun 2020 06:45:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 79F5AAC12;
        Wed, 17 Jun 2020 10:45:11 +0000 (UTC)
Message-ID: <b324122e8bd93302215a77d0dcf6d8b2897d3597.camel@suse.de>
Subject: Re: [PATCH v3 2/9] reset: Add Raspberry Pi 4 firmware reset
 controller
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Philipp Zabel <p.zabel@pengutronix.de>, f.fainelli@gmail.com,
        gregkh@linuxfoundation.org, wahrenst@gmx.net,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com
Date:   Wed, 17 Jun 2020 12:44:59 +0200
In-Reply-To: <c1ccb77ef0bc56b96a8ad991f8345d0ffbd76fc2.camel@pengutronix.de>
References: <20200612171334.26385-1-nsaenzjulienne@suse.de>
         <20200612171334.26385-3-nsaenzjulienne@suse.de>
         <c1ccb77ef0bc56b96a8ad991f8345d0ffbd76fc2.camel@pengutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-KqcsH4zLbO6uBhNeqN+i"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-KqcsH4zLbO6uBhNeqN+i
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-06-17 at 12:02 +0200, Philipp Zabel wrote:
> Hi Nicolas,
>=20
> On Fri, 2020-06-12 at 19:13 +0200, Nicolas Saenz Julienne wrote:
> > Raspberry Pi 4's co-processor controls some of the board's HW
> > initialization process, but it's up to Linux to trigger it when
> > relevant. Introduce a reset controller capable of interfacing with
> > RPi4's co-processor that models these firmware initialization routines =
as
> > reset lines.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>=20
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Thanks!

> If there is a good reason for the single DT specified reset id, I can
> pick up patches 1 and 2.

The idea here is to make sure we're reasonably covered against further chan=
ges
in firmware. If we define constraints too narrow it can be a pain to suppor=
t
new features without breaking backwards compatibility in dt.

> If you change the dts patch 4 to use a number instead of the reset id
> define for now, there wouldn't even be a dependency between these reset
> and dts patches.

I was under the impression that having an explicit definition was nice to h=
ave.
What's troubling about creating the dependency?

Regards,
Nicolas


--=-KqcsH4zLbO6uBhNeqN+i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7p9CwACgkQlfZmHno8
x/7mAAgAgVtbDaKmFM/GZJ/GA7I4dmOhQBlzhWyHsjI2Hp+6ZFKIGY+b9KqVzMdX
5nQP/wqDPSfiq8LzYvCRWo0totXpsNghOxPEIp9RAbhDDp/la2hLGKtQei0BxmeU
sl3JZAVMm1WpgjN7KTX7wTYttJ+NfRoGa2JRtyw2joFKcBhJUN3OCnC398MJJGfA
6Dqy4My6ptKkdJeQL/7KO6vgojwV52bcvEl/lnCD9IdeKJdyNdR8VqWN66Uhr+SW
SDwBOUcoE82o/bzlYOuQ4wPpDKAEwibDXQcRmapmYiKL1HackBHYB40sWjp2VuOh
8MBdmCLRl4oR7yWnPESbeQOwEshLGg==
=9ROq
-----END PGP SIGNATURE-----

--=-KqcsH4zLbO6uBhNeqN+i--

