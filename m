Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1211C3BA54D
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 23:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhGBV4o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jul 2021 17:56:44 -0400
Received: from maynard.decadent.org.uk ([95.217.213.242]:51094 "EHLO
        maynard.decadent.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhGBV4n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jul 2021 17:56:43 -0400
Received: from 168.7-181-91.adsl-dyn.isp.belgacom.be ([91.181.7.168] helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1lzR6w-00054O-31; Fri, 02 Jul 2021 23:54:10 +0200
Received: from ben by deadeye with local (Exim 4.94.2)
        (envelope-from <ben@decadent.org.uk>)
        id 1lzR6q-001VUY-Fh; Fri, 02 Jul 2021 23:54:04 +0200
Message-ID: <4fa5e3e5e998aff53f30380087564a837420f4d6.camel@decadent.org.uk>
Subject: Re: [PATCH 1/2] PCI: Call MPS fixup quirks early
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marek =?ISO-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org,
        Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        =?ISO-8859-1?Q?R=F6tti?= 
        <espressobinboardarmbiantempmailaddress@posteo.de>,
        Zachary Zhang <zhangzg@marvell.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Date:   Fri, 02 Jul 2021 23:53:48 +0200
In-Reply-To: <20210702162448.GA192062@bjorn-Precision-5520>
References: <20210702162448.GA192062@bjorn-Precision-5520>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-F1o1FToVlxKhxvCN3IT+"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 91.181.7.168
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-F1o1FToVlxKhxvCN3IT+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-07-02 at 11:24 -0500, Bjorn Helgaas wrote:
> On Fri, Jul 02, 2021 at 05:39:43PM +0200, Ben Hutchings wrote:
> > On Thu, 2021-07-01 at 10:25 -0500, Bjorn Helgaas wrote:
> > [...]
> > > After 27d868b5e6cfa, pci_configure_device() did actually call
> > > pcie_set_mps(), which updates the Device Control register (possibly
> > > restricted by dev->pcie_mpss, which is set by this quirk).
> > >=20
> > > The fixup_mpss_256() quirk was added in 2011 by a94d072b2023 ("PCI:
> > > Add quirk for known incorrect MPSS").  Interesting that 27d868b5e6cfa
> > > was merged in 2015 but apparently nobody noticed until now.  I guess
> > > those Solarflare devices aren't widely used?
> > [...]
> >=20
> > The key thing is that this quirk was working around an issue with
> > legacy interrupts, while the sfc and sfc-falcon drivers have always
> > preferred to use MSIs if available.  (But I also don't think many
> > SFC4000-based NICs were sold, and they were EOL'd about 10 years ago.)

Also, most of the read-only PCIe config registers on the SFC4000 are
initialised from flash, and the commit message implies MPSS was changed
on later boards.

> Just out of curiosity, do you happen to remember the legacy interrupt
> connection?  MPS has to do with the maximum TLP size, and it's not
> obvious to me why using INTx vs MSI would matter there.
[...]

No I don't.  I had completely forgotten about this, so I'm just
combining my commit message for the quirk with my general knowledge of
that chip.

(The bug I actually remember involving legacy interrupts, affecting
both SFC4000 and SFC9020, required a horrible workaround in the
driver.)

Ben.

--=20
Ben Hutchings
[W]e found...that it wasn't as easy to get programs right as we had
thought. I realized that a large part of my life from then on was going
to be spent in finding mistakes in my own programs.
                                                 - Maurice Wilkes, 1949

--=-F1o1FToVlxKhxvCN3IT+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmDfiuwACgkQ57/I7JWG
EQme/Q//bHiGnsrAsK0nndywzHnBdVhifaRzulUnEXZ+UX1r1b2qF/pGG7tKt3qI
iZWPdbCJIg/rLTFUK2ST0bKwtHU3ZVv01nO7zdvD6YOP1gXqEKSY+J7mXj4p7xzT
z5Viaj6wSjfRmNnAO0lMZgsiC02k0PjZ0ixS22sVy29mQpr5c9z0xAOtjsNqdqaW
lTNUB9izbFjXlOr3kI2x31E7QYngbXUpGSTfFFMYC095IBP91N1rd7qYqePXy5n/
Bnkl5gM2/QE8cfHZzf2qoXrrtKG8ixsiFxcUPKrFg2j1FjsKH1Xj4+vl2bbEBnCL
nWBYaxmZBHOu22Dqv0wlt5RcIkS/fj/gYRW9paVybk2+rYLO4Zd35Lvf8RuFKafd
2XLkcDTHcdT5BFe0RUgsq6Yw/dsU/0BrsKaw0rFcAb49Q3xHwOmaHW7Y6QT91EQQ
MLszVjEKfsFLltZXo0BAULP9cb+vBBGazdIe7QJS3hODfPYkMSXMFYbjOajgigAp
aF5bbhavO8qkPmS6iUxN3ZJPR9N6/d3cAhI5Lky3imtqA9lm32DxzdRj8hyo87no
pqc7zyDHGNeoHt+z1nwpOPW9fz27ZP4y3HlTIHov+Lh1nzY95hIeXZVyAtN6/BQG
FlE+EgQ76wyZcrogeQmJ93A2EqewWYMFb26KI/D5VQJmXyr4Epo=
=Ncl2
-----END PGP SIGNATURE-----

--=-F1o1FToVlxKhxvCN3IT+--
