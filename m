Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E9D214597
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jul 2020 13:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgGDLo5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Jul 2020 07:44:57 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:41148 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgGDLo5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Jul 2020 07:44:57 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7F6811C0BD2; Sat,  4 Jul 2020 13:44:53 +0200 (CEST)
Date:   Sat, 4 Jul 2020 13:44:52 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Rajat Jain <rajatja@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oohall@gmail.com, Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 0/7] Tighten PCI security, expose dev location in sysfs
Message-ID: <20200704114452.GA15530@amd>
References: <20200630044943.3425049-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <20200630044943.3425049-1-rajatja@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> * The first 3 patches tighten the PCI security using ACS, and take care
>   of a border case.
> * The 4th patch takes care of PCI bug.
> * 5th and 6th patches expose a device's location into the sysfs to allow
>   admin to make decision based on that.

I see no patch for Documentation -- new sysfs interfaces should be
documented for 5/6.

									Pavel

>  drivers/base/core.c         | 35 +++++++++++++++++++++++++++++++
>  drivers/iommu/intel/iommu.c | 31 ++++++++++++++++++---------
>  drivers/pci/ats.c           |  2 +-
>  drivers/pci/bus.c           | 13 ++++++------
>  drivers/pci/of.c            |  2 +-
>  drivers/pci/p2pdma.c        |  2 +-
>  drivers/pci/pci-acpi.c      | 13 ++++++------
>  drivers/pci/pci-driver.c    |  1 +
>  drivers/pci/pci.c           | 34 ++++++++++++++++++++++++++----
>  drivers/pci/pci.h           |  3 ++-
>  drivers/pci/probe.c         | 20 +++++++++++-------
>  drivers/pci/quirks.c        | 19 +++++++++++++----
>  include/linux/device.h      | 42 +++++++++++++++++++++++++++++++++++++
>  include/linux/device/bus.h  |  8 +++++++
>  include/linux/pci.h         | 13 ++++++------
>  15 files changed, 191 insertions(+), 47 deletions(-)
>=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8Aa7QACgkQMOfwapXb+vKywACguAX/M2pdPQp3cMcFaM8SJJbH
zsoAn1By+0ZFx363Y5WWGNssFTuDT0Al
=AJH4
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
