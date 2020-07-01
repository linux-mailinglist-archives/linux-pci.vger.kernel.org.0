Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE3F210A1A
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jul 2020 13:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbgGALIP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jul 2020 07:08:15 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:46708 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730159AbgGALIP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jul 2020 07:08:15 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 949071C0C0A; Wed,  1 Jul 2020 13:08:13 +0200 (CEST)
Date:   Wed, 1 Jul 2020 13:08:13 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pavel Machek <pavel@denx.de>, Jesse Barnes <jsbarnes@google.com>,
        Rajat Jain <rajatja@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
Message-ID: <20200701110813.GA11023@amd>
References: <20200603121613.GA1488883@kroah.com>
 <CACK8Z6EOGduHX1m7eyhFgsGV7CYiVN0en4U0cM4BEWJwk2bmoA@mail.gmail.com>
 <20200605080229.GC2209311@kroah.com>
 <CACK8Z6GR7-wseug=TtVyRarVZX_ao2geoLDNBwjtB+5Y7VWNEQ@mail.gmail.com>
 <20200607113632.GA49147@kroah.com>
 <CAJmaN=m5cGc8019LocvHTo-1U6beA9-h=T-YZtQEYEb_ry=b+Q@mail.gmail.com>
 <20200630214559.GA7113@duo.ucw.cz>
 <20200701065426.GC2044019@kroah.com>
 <20200701084750.GA7144@amd>
 <20200701105714.GA2098169@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20200701105714.GA2098169@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Yes, it originally was designed that way, but again, the world has
> > > changed so we have to change with it.  That is why USB has for a long
> > > time now, allowed you to not bind drivers to devices that you do not
> > > "trust", and that trust can be determined by userspace.  That all came
> > > about thanks to the work done by the wireless USB spec people and ker=
nel
> > > authors, which showed that maybe you just don't want to trust any dev=
ice
> > > that comes within range of your system :)
> >=20
> > Again, not disagreeing; but note the scale here.
> >=20
> > It is mandatory to defend against malicious wireless USB devices.
>=20
> Turns out there are no more wireless USB devices in the world, and the
> code for that is gone from Linux :)
>=20
> > We probably should work on robustness against malicious USB devices.
>=20
> We are, and do have, that support today.
>=20
> > Malicious PCI-express devices are lot less of concern.
>=20
> Not really, they are a lot of concern to some people.  Valid attacks are
> out there today, see the thunderbolt attacks that numerous people have
> done and published recently and for many years.

In this case PCI-express meant internal cards in PCs. Yes, thunderbolt
would be higher concern than internal card.

> > Defending against malicious CPU/RAM does not make much sense.
>=20
> That's what the spectre and rowhammer fixes have been for :)

Yeah, and that's why we have whitelist of working CPUs and only work
on those, riiight? :-). [There's difference between "malicious" and
"buggy".]

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl78bp0ACgkQMOfwapXb+vIMwQCgxMUU2uCXMx6F3qqoXwrtOcsB
PR4AoIv02DSIJXj0/Qp/43XbkGAtf5kj
=O1gR
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
