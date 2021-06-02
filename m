Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DF23984DA
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 11:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhFBJGt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 05:06:49 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51318 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhFBJGt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jun 2021 05:06:49 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 4AF621C0B77; Wed,  2 Jun 2021 11:05:05 +0200 (CEST)
Date:   Wed, 2 Jun 2021 11:05:04 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     stuart hayes <stuart.w.hayes@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, kw@linux.com,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
Subject: Re: [PATCH v2] Add support for PCIe SSD status LED management
Message-ID: <20210602090504.GA10900@amd>
References: <20210601203820.3647-1-stuart.w.hayes@gmail.com>
 <3d1272b8-4edc-f2b1-85ea-f5cea65b4871@infradead.org>
 <20210601223812.GA5128@amd>
 <6ee11975-fad7-1a82-f7f3-279ebd4f67cb@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <6ee11975-fad7-1a82-f7f3-279ebd4f67cb@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>>  [ok] [locate] failed rebuild pfa hotspare ica ifa invalid disabled
> >
> >So what does this do? Turns the LED on if driver is in "ok" or
> >"locate" states?
> >
>=20
> This would cause the system to somehow show the user that that this drive
> (or drive slot) is the one that it wants a person to be able to physically
> locate (possibly by flashing a blue LED on/near the drive), and also that
> the drive is OK.  It would presumably do that by lighting the LEDs on/near
> the drive with certain colors and/or flashing patterns, though it could, =
in
> theory, put "OK" in an LCD on the drive slot.  How the states are display=
ed
> to the user is beyond the scope of the specs.
>=20
> (The _DSM and NPEM specs provide for a way to control status LEDs on a dr=
ive
> or drive slot.  Typically drives will have 2 or 3 LEDs that are illuminat=
ed
> in different colors or flashing patterns to indicate various states (like
> those listed in IBPI / SFF-8489), though the _DSM / NPEM specs do not
> specify how the states are displayed.)

Well, LED subsystem expects to know how many LEDs are there and what
the LEDs are, and expects individual control over them.

"2 or 3 LEDs with unknown patterns", or LCD display is outside of scope
of LED subsystem, so this should be independend.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmC3Sb8ACgkQMOfwapXb+vLO/wCfXD0QnFJOu1pLpdrkK39BvJfO
+ecAnA1cgKwSxSnTJB7nhaGBxQ8O4Ion
=ZKpO
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
