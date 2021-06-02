Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0E4399605
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 00:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhFBWmp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 18:42:45 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:45762 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhFBWmp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jun 2021 18:42:45 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1F91F1C0B76; Thu,  3 Jun 2021 00:41:00 +0200 (CEST)
Date:   Thu, 3 Jun 2021 00:40:59 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     stuart hayes <stuart.w.hayes@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, kw@linux.com,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
Subject: Re: [PATCH v2] Add support for PCIe SSD status LED management
Message-ID: <20210602224059.GA19673@duo.ucw.cz>
References: <20210601203820.3647-1-stuart.w.hayes@gmail.com>
 <3d1272b8-4edc-f2b1-85ea-f5cea65b4871@infradead.org>
 <20210601223812.GA5128@amd>
 <6ee11975-fad7-1a82-f7f3-279ebd4f67cb@gmail.com>
 <20210602090504.GA10900@amd>
 <552ca26f-c7ab-3496-743f-f95e80eb578b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <552ca26f-c7ab-3496-743f-f95e80eb578b@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This would cause the system to somehow show the user that that this d=
rive
> > > (or drive slot) is the one that it wants a person to be able to physi=
cally
> > > locate (possibly by flashing a blue LED on/near the drive), and also =
that
> > > the drive is OK.  It would presumably do that by lighting the LEDs on=
/near
> > > the drive with certain colors and/or flashing patterns, though it cou=
ld, in
> > > theory, put "OK" in an LCD on the drive slot.  How the states are dis=
played
> > > to the user is beyond the scope of the specs.
> > >=20
> > > (The _DSM and NPEM specs provide for a way to control status LEDs on =
a drive
> > > or drive slot.  Typically drives will have 2 or 3 LEDs that are illum=
inated
> > > in different colors or flashing patterns to indicate various states (=
like
> > > those listed in IBPI / SFF-8489), though the _DSM / NPEM specs do not
> > > specify how the states are displayed.)
> >=20
> > Well, LED subsystem expects to know how many LEDs are there and what
> > the LEDs are, and expects individual control over them.
> >=20
> > "2 or 3 LEDs with unknown patterns", or LCD display is outside of scope
> > of LED subsystem, so this should be independend.

>=20
> Yes... I had originally submitted this without using the LED subsystem, a=
nd
> Greg K-H said I had to (see
> https://www.spinics.net/lists/linux-pci/msg102013.html).  Here's the
> relevant bit.

=2E..

> So I'm not sure what to do.

Explain to Greg that you don't know how particular system implements
the indication. It can be small display, 2 LEDs, 3 LEDs, etc... LED
subsystem expects direct LED control.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYLgI+wAKCRAw5/Bqldv6
8kykAJ9dyoWhTggfJ0iwRUlJlM9S4ODhugCfZFeHTIX7D/7Axs8FeMCfV7dnViU=
=Xqva
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
