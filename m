Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78B3397C7A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 00:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbhFAWj4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Jun 2021 18:39:56 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:45720 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbhFAWjz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Jun 2021 18:39:55 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C5B651C0B76; Wed,  2 Jun 2021 00:38:12 +0200 (CEST)
Date:   Wed, 2 Jun 2021 00:38:12 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, kw@linux.com,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
Subject: Re: [PATCH v2] Add support for PCIe SSD status LED management
Message-ID: <20210601223812.GA5128@amd>
References: <20210601203820.3647-1-stuart.w.hayes@gmail.com>
 <3d1272b8-4edc-f2b1-85ea-f5cea65b4871@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <3d1272b8-4edc-f2b1-85ea-f5cea65b4871@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >  # echo "ok locate" >/sys/class/leds/0000:88:00.0::drive_status/states
> >  # cat /sys/class/leds/0000:88:00.0::drive_status/states

This has two problems: ":" already has special meaning in LED name,
and we'd prefer not to have new "states" interface unless absolutely
neccessary.

> >  [ok] [locate] failed rebuild pfa hotspare ica ifa invalid disabled

So what does this do? Turns the LED on if driver is in "ok" or
"locate" states?

> > +Date:		April 2021
> > +Contact:	linux-pci@vger.kernel.org
> > +Description:
> > +		This attribute indicates the status states supported by a drive
> > +		or drive slot's LEDs, as defined in the "_DSM additions for PCIe
> > +		SSD Status LED Management" ECN to the PCI Firmware Specification
> > +		Revision 3.2, dated 12 February 2020, and in "Native PCIe
> > +		Enclosure Management", section 6.29 of the PCIe Base Spec 5.0.
> > +
> > +		Only supported states will be shown, and the currently active
> > +		states are shown in brackets.  The active state(s) can be written
> > +		by echoing a space or comma separated string of states to this
> > +		attribute.  For example:
> > +
> > +		# echo "ok locate" >/sys/class/leds/0000:88:00.0::drive_status/states
> > +		# cat /sys/class/leds/0000:88:00.0::drive_status/states
> > +		[ok] [locate] failed rebuild pfa hotspare ica ifa

This goes against "one value per file", really needs better
description, and probably needs different interface.

> > +config PCIE_SSD_LEDS
> > +	tristate "PCIe SSD status LED support"
> > +	depends on ACPI && NEW_LEDS
>=20
> I expect that should be LEDS_CLASS instead of NEW_LEDS.
> Did you test it with NEW_LEDS=3Dy and LEDS_CLASS not set?
>=20
>=20
> [adding Pavel and linux-leds m.l. for other review]

Thank you!
							Pavel
						=09
--=20
http://www.livejournal.com/~pavelmachek

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmC2ttMACgkQMOfwapXb+vIulACfZx70hqsH6Itfnxhc5x1h93Ta
T50AoJh8FJYwexyDjwEJCEp90khmjJSm
=EPZH
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
