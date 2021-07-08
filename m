Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C903BF787
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jul 2021 11:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhGHJ0T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jul 2021 05:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhGHJ0T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jul 2021 05:26:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA05C061574
        for <linux-pci@vger.kernel.org>; Thu,  8 Jul 2021 02:23:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1QFp-0004jm-Ls; Thu, 08 Jul 2021 11:23:33 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1QFo-00036H-1b; Thu, 08 Jul 2021 11:23:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1QFo-0007fe-03; Thu, 08 Jul 2021 11:23:32 +0200
Date:   Thu, 8 Jul 2021 11:23:18 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        kernel@pengutronix.de, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Make struct pci_epf_driver::remove return
 void
Message-ID: <20210708092318.zksrx77fx53y45bt@pengutronix.de>
References: <20210223090757.57604-1-u.kleine-koenig@pengutronix.de>
 <2a12ff97-a916-d70e-9e5b-b796e9c58288@ti.com>
 <20210705154650.roeaqika5ptknrnt@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gdhr36g2kwaoa2cn"
Content-Disposition: inline
In-Reply-To: <20210705154650.roeaqika5ptknrnt@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--gdhr36g2kwaoa2cn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 05, 2021 at 05:46:50PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Tue, Jun 22, 2021 at 03:29:27PM +0530, Kishon Vijay Abraham I wrote:
> > On 23/02/21 2:37 pm, Uwe Kleine-K=F6nig wrote:
> > > The driver core ignores the return value of pci_epf_device_remove()
> > > (because there is only little it can do when a device disappears) and
> > > there are no pci_epf_drivers with a remove callback.
> > >=20
> > > So make it impossible for future drivers to return an unused error co=
de
> > > by changing the remove prototype to return void.
> > >=20
> > > The real motivation for this change is the quest to make struct
> > > bus_type::remove return void, too.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > Fine with this change!
> >=20
> > FWIW:
> > Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>=20
> Thanks for the ack. How can I expect this patch to go into mainline now?
> Will Bjorn pick it up now that you acked?

There is a series[1] that I'd like to get into mainline during the next
merge window and that depends on this patch. Ideally it would go in
for v5.14-rc1, otherwise I'd like to add it to the series changing
bus_type::remove that it goes in together. Would be sad if I had to
delay this cleanup for this dependency not going in.

Best regards
Uwe

[1] https://lore.kernel.org/lkml/20210706154803.1631813-1-u.kleine-koenig@p=
engutronix.de


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gdhr36g2kwaoa2cn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDmw/0ACgkQwfwUeK3K
7AlYuggAg0xDgHqXT0iruioVCPhVocLb6LxWjezE4XN75ysLZeTRQkMjDL+XhJ73
nUSYnul815fJCh4St6CBGO3qJhTa9gqdlU29/hrtJ7olTddm7i+qc12YVwqYNwfE
xpRTjsphIhv8sThUHoupZ+JyjthDMkzak9JP6WthSry+nhP52nSWqQZJ8PC993a0
SRenvTuOgKsLCtV1cD7L8UjxEbRYW/Etam2yI2LMEmKNxyx7etHNk6zWDPayqiIN
estnj4gbQmXEtYQyN/ZT9mexAqinx/WLm0cyiKkVvwBbDqwH32e3CqZBWZjtiY8k
uojZp2ogX/IMUkJfotP9M9qYYVS5Ug==
=jFiT
-----END PGP SIGNATURE-----

--gdhr36g2kwaoa2cn--
