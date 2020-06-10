Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD431F5870
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 17:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgFJP5O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 11:57:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:43328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbgFJP5O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jun 2020 11:57:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0ACD7AD0D;
        Wed, 10 Jun 2020 15:57:16 +0000 (UTC)
Message-ID: <07cdfbbacb0f48e3671f4c7197a1ea58d99845e1.camel@suse.de>
Subject: Re: [PATCH v2 7/9] usb: host: pci-quirks: Bypass xHCI quirks for
 Raspberry Pi 4
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        USB <linux-usb@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        tim.gover@raspberrypi.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Date:   Wed, 10 Jun 2020 17:57:10 +0200
In-Reply-To: <CAHp75VcxjpMYgQV+Mv2_A6gT+qkG_Kihe4Ke+avJ6e6UNdZCnA@mail.gmail.com>
References: <20200609175003.19793-1-nsaenzjulienne@suse.de>
         <20200609175003.19793-8-nsaenzjulienne@suse.de>
         <CAHp75VcxjpMYgQV+Mv2_A6gT+qkG_Kihe4Ke+avJ6e6UNdZCnA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-WmpqyWN/a5eP/Qxbeom/"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-WmpqyWN/a5eP/Qxbeom/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,
Thanks for the review.

On Tue, 2020-06-09 at 21:43 +0300, Andy Shevchenko wrote:
> On Tue, Jun 9, 2020 at 8:50 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > The board doesn't need the quirks to be run, and takes care of its own
> > initialization trough a reset controller device. So let's bypass them.
>=20
> through

Noted

> ...
>=20
> > +       if (pdev->vendor =3D=3D PCI_VENDOR_ID_VIA && pdev->device =3D=
=3D 0x3483 &&
> > +           of_device_is_compatible(of_get_parent(pdev->bus->dev.of_nod=
e),
> > +                                   "brcm,bcm2711-pcie"))
> > +               return;
>=20
> No put?

Missed that, sorry.

Regards,
Nicolas


--=-WmpqyWN/a5eP/Qxbeom/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7hAtYACgkQlfZmHno8
x/6pWQf/YjKJWkjl0Ry3wqgSqq6nMS36oLTSH/79Hi6/YsHTATPPaFZVfYKGHySy
dMxtJVZ+/SUqUHcRJrl6st0RcuPMrs6y76YD/JFuDjzUTOMUcaVme2biY/nDWEEA
1ToKs4Ia2m7bounaSimqF0w9oCjKOegt0sFWLKSCK4EGLwsSOZ2LWbSP3ctfWS1Z
hw6QmkXus2BIZwI/QkTIZ86PK2SujUFKAkiVJFdfyYcbwNCZpWy2iK8s7pffLyyR
t15gNXP8ocI2PVnm/DlN/HtlbQfWwB7HjeQp3FI92pNLh/KaRP8+hEhuqasynyLf
nnR5NeCeENrzGhC4sE28IAlygd+kvw==
=UAUo
-----END PGP SIGNATURE-----

--=-WmpqyWN/a5eP/Qxbeom/--

