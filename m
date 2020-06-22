Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88C9203A65
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jun 2020 17:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgFVPLv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 11:11:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:34938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729092AbgFVPLu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jun 2020 11:11:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4385C1C2;
        Mon, 22 Jun 2020 15:11:48 +0000 (UTC)
Message-ID: <0c0546cfe855eee1381c629b2ffd7f65427c7091.camel@suse.de>
Subject: Re: [PATCH v4 6/9] Revert "USB: pci-quirks: Add Raspberry Pi 4
 quirk"
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        tim.gover@raspberrypi.org, linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Date:   Mon, 22 Jun 2020 17:11:47 +0200
In-Reply-To: <CAHp75Vcpo49BUe+cApfbB2BXFLz0SyLjWkO_6Uw=sYEcJEBMPg@mail.gmail.com>
References: <20200622103817.476-1-nsaenzjulienne@suse.de>
         <20200622103817.476-7-nsaenzjulienne@suse.de>
         <CAHp75Vcpo49BUe+cApfbB2BXFLz0SyLjWkO_6Uw=sYEcJEBMPg@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Zq9AyheKyzYDNZWNBe3P"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-Zq9AyheKyzYDNZWNBe3P
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, 2020-06-22 at 17:44 +0300, Andy Shevchenko wrote:
> On Mon, Jun 22, 2020 at 5:26 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > This reverts commit c65822fef4adc0ba40c37a47337376ce75f7a7bc.
> >=20
> > The initialization of Raspberry Pi 4's USB chip is now handled through =
a
> > reset controller. No need to directly call the firmware routine trough =
a
>=20
> trough -> through.
>=20
> > pci quirk.
>=20
> pci -> PCI.
>=20

Noted

> ...
>=20
> > -
> > -#include <soc/bcm2835/raspberrypi-firmware.h>
> > -
>=20
> Leave one blank line here.

This being a revert, does it make sense to do so? If we are 100% strict abo=
ut
it, the space should come from a separate patch.

That said, if you insist I'll be happy to edit it.

Regards,
Nicolas


--=-Zq9AyheKyzYDNZWNBe3P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7wyjMACgkQlfZmHno8
x/5RwQf9Gk8jsNrvTnTJXkRwMNEL0Mdzw8RgEAwejQl5NOwsppJumfhgWhZ3vxzs
3gZHICLAA0gPBGCfo15zf+H/vTl1XEnfSyBV+kHubW1/Y8nxWEJbCNF2f/Gwc34v
9/92zP+A7QabSkh25J5+v277behur31ujzE/4PS98rwW1sQma7OlBSWzdzzBYvg4
TWxskFXEuA24fuqVmedx7Uf4/1q8gXoJA5BFfICCsU3RcVtCKCK3MBfNWm5WTmVe
jsjfLTZxiDcQgbMCppn/a9JBamick5PnzGCxk2mOBeviqZtUNF2EzZQimrPd7XeC
vgENiHN6wAjEctHYpN5wTjrWEUco4Q==
=SWIn
-----END PGP SIGNATURE-----

--=-Zq9AyheKyzYDNZWNBe3P--

