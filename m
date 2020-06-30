Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547D020FF66
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 23:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgF3VqD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 17:46:03 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:53576 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbgF3VqD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jun 2020 17:46:03 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 797B31C0C0A; Tue, 30 Jun 2020 23:45:59 +0200 (CEST)
Date:   Tue, 30 Jun 2020 23:45:59 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jesse Barnes <jsbarnes@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20200630214559.GA7113@duo.ucw.cz>
References: <20200602050626.GA2174820@kroah.com>
 <CAA93t1puWzFx=1h0xkZEkpzPJJbBAF7ONL_wicSGxHjq7KL+WA@mail.gmail.com>
 <20200603060751.GA465970@kroah.com>
 <CACK8Z6EXDf2vUuJbKm18R6HovwUZia4y_qUrTW8ZW+8LA2+RgA@mail.gmail.com>
 <20200603121613.GA1488883@kroah.com>
 <CACK8Z6EOGduHX1m7eyhFgsGV7CYiVN0en4U0cM4BEWJwk2bmoA@mail.gmail.com>
 <20200605080229.GC2209311@kroah.com>
 <CACK8Z6GR7-wseug=TtVyRarVZX_ao2geoLDNBwjtB+5Y7VWNEQ@mail.gmail.com>
 <20200607113632.GA49147@kroah.com>
 <CAJmaN=m5cGc8019LocvHTo-1U6beA9-h=T-YZtQEYEb_ry=b+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <CAJmaN=m5cGc8019LocvHTo-1U6beA9-h=T-YZtQEYEb_ry=b+Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Yes such drivers should be fixed, no doubt.  But without lots of
> fuzzing (we're working on this) and testing we'd like to avoid
> exposing that attack surface at all.
>=20
> I think your suggestion to disable driver binding once the initial
> bus/slot devices have been bound will probably work for this
> situation.  I just wanted to be clear that without some auditing,
> fuzzing, and additional testing, we simply have to assume that drivers
> are *not* secure and avoid using them on untrusted devices until we're
> fairly confident they can handle them (whether just misbehaving or
> malicious), in combination with other approaches like IOMMUs of
> course.  And this isn't because we don't trust driver authors or
> kernel developers to dtrt, it's just that for many devices (maybe USB
> is an exception) I think driver authors haven't had to consider this
> case much, and so I think it's prudent to expect bugs in this area
> that we need to find & fix.

We normally trust the hardware NOT to be malicious. (Because if hacker
has physical access to hardware and lot of resources, you lost).

This is still true today, but maybe trusting USB devices is bad idea,
so drivers are being cleaned up. PCI drivers will be WORSE in this
regard. And you can't really protect against malicious CPU, and it is
very very hard to protect against malicous RAM (probably not practical
without explicit CPU support).

Linux was designed with "don't let hackers near your hardware" threat
model in mind.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXvuylwAKCRAw5/Bqldv6
8vGdAJ0QKiY2OtzgdgyV2OtyuW+u9KMnagCcD9BR/9VGydJ0oNx7BA9liQVujEY=
=2jEj
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
