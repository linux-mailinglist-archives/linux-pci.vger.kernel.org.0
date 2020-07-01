Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EC52106AC
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jul 2020 10:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgGAIry (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jul 2020 04:47:54 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:56330 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgGAIrx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jul 2020 04:47:53 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CD6F41C0C0F; Wed,  1 Jul 2020 10:47:50 +0200 (CEST)
Date:   Wed, 1 Jul 2020 10:47:50 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jesse Barnes <jsbarnes@google.com>,
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
Message-ID: <20200701084750.GA7144@amd>
References: <20200603060751.GA465970@kroah.com>
 <CACK8Z6EXDf2vUuJbKm18R6HovwUZia4y_qUrTW8ZW+8LA2+RgA@mail.gmail.com>
 <20200603121613.GA1488883@kroah.com>
 <CACK8Z6EOGduHX1m7eyhFgsGV7CYiVN0en4U0cM4BEWJwk2bmoA@mail.gmail.com>
 <20200605080229.GC2209311@kroah.com>
 <CACK8Z6GR7-wseug=TtVyRarVZX_ao2geoLDNBwjtB+5Y7VWNEQ@mail.gmail.com>
 <20200607113632.GA49147@kroah.com>
 <CAJmaN=m5cGc8019LocvHTo-1U6beA9-h=T-YZtQEYEb_ry=b+Q@mail.gmail.com>
 <20200630214559.GA7113@duo.ucw.cz>
 <20200701065426.GC2044019@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20200701065426.GC2044019@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > We normally trust the hardware NOT to be malicious. (Because if hacker
> > has physical access to hardware and lot of resources, you lost).
>=20
> That is what we originally thought, however the world has changed and we
> need to be better about this, now that it is trivial to create a "bad"
> device.

I'm not disagreeing.

> > This is still true today, but maybe trusting USB devices is bad idea,
> > so drivers are being cleaned up. PCI drivers will be WORSE in this
> > regard. And you can't really protect against malicious CPU, and it is
> > very very hard to protect against malicous RAM (probably not practical
> > without explicit CPU support).
> >=20
> > Linux was designed with "don't let hackers near your hardware" threat
> > model in mind.
>=20
> Yes, it originally was designed that way, but again, the world has
> changed so we have to change with it.  That is why USB has for a long
> time now, allowed you to not bind drivers to devices that you do not
> "trust", and that trust can be determined by userspace.  That all came
> about thanks to the work done by the wireless USB spec people and kernel
> authors, which showed that maybe you just don't want to trust any device
> that comes within range of your system :)

Again, not disagreeing; but note the scale here.

It is mandatory to defend against malicious wireless USB devices.

We probably should work on robustness against malicious USB devices.

Malicious PCI-express devices are lot less of concern.

Defending against malicious CPU/RAM does not make much sense.

Notice that it is quite easy to generate -100V on the USB and kill
your motherboard. Also notice that malicious parts of the hardware
don't need to be electrically connected to the rest of system, and
that they don't even have to contain any electronics. You just have to
be careful. https://en.wikipedia.org/wiki/The_Thing_(listening_device)

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl78TbYACgkQMOfwapXb+vIPVQCfaLKmBpCjrjpOL7yk4eKC2WOg
zAIAoLekMQziYoPoMQ53aRvdTzLzgVqb
=qNCF
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
