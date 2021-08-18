Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5423EFD4C
	for <lists+linux-pci@lfdr.de>; Wed, 18 Aug 2021 09:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbhHRHFj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Aug 2021 03:05:39 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:47968 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237636AbhHRHFi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Aug 2021 03:05:38 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C95671C0B77; Wed, 18 Aug 2021 09:05:03 +0200 (CEST)
Date:   Wed, 18 Aug 2021 09:05:03 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <kbusch@kernel.org>, kw@linux.com
Subject: Re: [PATCH v3] Add support for PCIe SSD status LED management
Message-ID: <20210818070503.GF22282@amd>
References: <20210813213653.3760-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SnV5plBeK2Ge1I9g"
Content-Disposition: inline
In-Reply-To: <20210813213653.3760-1-stuart.w.hayes@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--SnV5plBeK2Ge1I9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch adds support for the PCIe SSD Status LED Management
> interface, as described in the "_DSM Additions for PCIe SSD Status LED
> Management" ECN to the PCI Firmware Specification revision 3.2.
>=20
> It will add (led_classdev) LEDs to each PCIe device that has a supported
> _DSM interface (one off/on LED per supported state). Both PCIe storage
> devices, and the ports to which they are connected, can support this
> interface.
>=20
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>

I believe these are not LEDs, right? This is something that displays
information to the user, but how exactly it is implemented is up to
BIOS vendor.

I don't think it is good fit for LED subsystem.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--SnV5plBeK2Ge1I9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmEcsR8ACgkQMOfwapXb+vIVSgCfUMxYs1RxDaTLaH5M4HXezQIp
CfEAnjzHY8jyLj1X0R84mCOzygEWtU1p
=dGpW
-----END PGP SIGNATURE-----

--SnV5plBeK2Ge1I9g--
