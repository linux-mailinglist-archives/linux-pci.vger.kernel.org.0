Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C853BA2F5
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 17:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhGBP5y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jul 2021 11:57:54 -0400
Received: from maynard.decadent.org.uk ([95.217.213.242]:50992 "EHLO
        maynard.decadent.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhGBP5x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jul 2021 11:57:53 -0400
X-Greylist: delayed 926 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Jul 2021 11:57:53 EDT
Received: from 168.7-181-91.adsl-dyn.isp.belgacom.be ([91.181.7.168] helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1lzLGk-0004Ip-Ng; Fri, 02 Jul 2021 17:39:54 +0200
Received: from ben by deadeye with local (Exim 4.94.2)
        (envelope-from <ben@decadent.org.uk>)
        id 1lzLGf-001UmD-PL; Fri, 02 Jul 2021 17:39:49 +0200
Message-ID: <237a49d8a113f44b55e537f6f2f99b7db9d97485.camel@decadent.org.uk>
Subject: Re: [PATCH 1/2] PCI: Call MPS fixup quirks early
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Marek =?ISO-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        =?ISO-8859-1?Q?R=F6tti?= 
        <espressobinboardarmbiantempmailaddress@posteo.de>,
        Zachary Zhang <zhangzg@marvell.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Date:   Fri, 02 Jul 2021 17:39:43 +0200
In-Reply-To: <20210701152512.GA55520@bjorn-Precision-5520>
References: <20210701152512.GA55520@bjorn-Precision-5520>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-bgrN+a4HOYy97Q+kIw+b"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 91.181.7.168
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-bgrN+a4HOYy97Q+kIw+b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-07-01 at 10:25 -0500, Bjorn Helgaas wrote:
[...]
> After 27d868b5e6cfa, pci_configure_device() did actually call
> pcie_set_mps(), which updates the Device Control register (possibly
> restricted by dev->pcie_mpss, which is set by this quirk).
>=20
> The fixup_mpss_256() quirk was added in 2011 by a94d072b2023 ("PCI:
> Add quirk for known incorrect MPSS").  Interesting that 27d868b5e6cfa
> was merged in 2015 but apparently nobody noticed until now.  I guess
> those Solarflare devices aren't widely used?
[...]

The key thing is that this quirk was working around an issue with
legacy interrupts, while the sfc and sfc-falcon drivers have always
preferred to use MSIs if available.  (But I also don't think many
SFC4000-based NICs were sold, and they were EOL'd about 10 years ago.)

Ben.
>=20

--=20
Ben Hutchings
[W]e found...that it wasn't as easy to get programs right as we had
thought. I realized that a large part of my life from then on was going
to be spent in finding mistakes in my own programs.
                                                 - Maurice Wilkes, 1949

--=-bgrN+a4HOYy97Q+kIw+b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmDfMz8ACgkQ57/I7JWG
EQkWCw//XXi1mIbkVday8wdafklHJvcU/n6+vMrHa1opAGCRiILGUfuuw1GLmrti
7mttUcfPOpOtMYz9n0FaOxjzEYv0KF7Pl7re5EdZLT6dJnqa0u2p85EbnyiOEKVL
5ngFpvNNxLla692wUWfH6Dcp2D3fybQJo0TVDef4GSsNuAj6MbQGHV1egCheB+eo
qRcHJis4LYhjzSiWUW9O0SJe1CwstxntnGCnjXl3o1H+VTJLrzk7Fc3StSWfvMgv
qCLkYynO/zOkMGJw/ZkqWKMd56vIrUFNlQ4cN4cThOMPMKHGmlVD6l74z5csgnfr
DaRvFIKDLjciAIjXZ/nr8Mp8trSuq4ULJxDDAVO0lnUHA/lz4PzsVZjctctVNtY9
cj1kGSC6Zmw78SXIjXEbhoUCt0ugs0lnWiQjk4/3+cNId7xtn9WMwyxDTJWLhM1l
LGpNCDsg1LylaHsapKTAw71NUIQ1ZJjjPNNx+dyaiim3Z9QhiwzMAem7eNLqvE98
CYkONtsLekxVNuWs3GVI2XYoi8j5/rcWojnESfrb01lLW6ETRcErJA6PTzFDVDlS
9yxEj4anhmcgX+Z7dHdjRXjb6FE1z3tQIM3pe+DtCKg1TkgmxDp7MDj/SrmzQ6Ub
11VmwUxzZJUe/CuySK8cgxZbNI6hZqSpmEWmCjZ+qxG8uv0zJO0=
=rwnt
-----END PGP SIGNATURE-----

--=-bgrN+a4HOYy97Q+kIw+b--
