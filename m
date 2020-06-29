Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD7E20D7A2
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jun 2020 22:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733159AbgF2Tb2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jun 2020 15:31:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:36750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733164AbgF2Tb1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Jun 2020 15:31:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5418FAD33;
        Mon, 29 Jun 2020 15:19:59 +0000 (UTC)
Message-ID: <9e6d34b0d31829f1b6760191c9424dda65963bcd.camel@suse.de>
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
Date:   Mon, 29 Jun 2020 17:19:57 +0200
In-Reply-To: <6ddaf69d4f5ad188864f62dcdbfbbe32acef9820.camel@pengutronix.de>
References: <20200612171334.26385-1-nsaenzjulienne@suse.de>
         <20200612171334.26385-3-nsaenzjulienne@suse.de>
         <c1ccb77ef0bc56b96a8ad991f8345d0ffbd76fc2.camel@pengutronix.de>
         <b324122e8bd93302215a77d0dcf6d8b2897d3597.camel@suse.de>
         <6ddaf69d4f5ad188864f62dcdbfbbe32acef9820.camel@pengutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-pYGBGq9PFJmcLEyUIZhw"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-pYGBGq9PFJmcLEyUIZhw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-06-26 at 12:43 +0200, Philipp Zabel wrote:
> On Wed, 2020-06-17 at 12:44 +0200, Nicolas Saenz Julienne wrote:
> > On Wed, 2020-06-17 at 12:02 +0200, Philipp Zabel wrote:
> > > Hi Nicolas,
> > >=20
> > > On Fri, 2020-06-12 at 19:13 +0200, Nicolas Saenz Julienne wrote:
> > > > Raspberry Pi 4's co-processor controls some of the board's HW
> > > > initialization process, but it's up to Linux to trigger it when
> > > > relevant. Introduce a reset controller capable of interfacing with
> > > > RPi4's co-processor that models these firmware initialization routi=
nes
> > > > as
> > > > reset lines.
> > > >=20
> > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> > >=20
> > > Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> >=20
> > Thanks!
> >=20
> > > If there is a good reason for the single DT specified reset id, I can
> > > pick up patches 1 and 2.
> >=20
> > The idea here is to make sure we're reasonably covered against further
> > changes
> > in firmware. If we define constraints too narrow it can be a pain to su=
pport
> > new features without breaking backwards compatibility in dt.
>=20
> Ok.
>=20
> > > If you change the dts patch 4 to use a number instead of the reset id
> > > define for now, there wouldn't even be a dependency between these res=
et
> > > and dts patches.
> >=20
> > I was under the impression that having an explicit definition was nice =
to
> > have.
> > What's troubling about creating the dependency?
>=20
> Just that the last patch has to wait for the reset patches to be merged
> before it can be applied.

TBH there is no hurry, this only provides a better design on something that=
's
already available upstream. USB works on RPi4, so I don't mind if this gets
delayed a release.

Regards,
Nicolas


--=-pYGBGq9PFJmcLEyUIZhw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl76Bp4ACgkQlfZmHno8
x/4Ajwf+K267YktdZT35ap4okjOsWgkfqAIAwxP52bNAwkVqxoMvi5Bvt7bQiZhF
6yW4hejw30Ynb5u18w0FNOECF0/hV8XCTPYHcBDqplrtVwDAJSvHkjRZ4Ta4yR0e
afhITI1v66VKfk6fXq/6a3UEC0mZoUX1JY+eVo2M7tQEgGGQrNjU1kTUl9nwJkSb
E9iYX4L+qtAfXtvirFebov4CrdX2zZRaaQpRPIFGh2ZMBpXFIFaOVVBe9DS4Wbav
kIKuL2AIisi8ZY6yssQTxECJuzir//mqRN+yBvmOJaB8Va83E7AaE1pE1uN0JhhN
/P/W9lzR8Ku7wbNuORr35TFIKyEiXg==
=iSMN
-----END PGP SIGNATURE-----

--=-pYGBGq9PFJmcLEyUIZhw--

