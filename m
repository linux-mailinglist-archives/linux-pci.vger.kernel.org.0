Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDD475ED64
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 10:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjGXIYh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 04:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjGXIYh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 04:24:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCB7131
        for <linux-pci@vger.kernel.org>; Mon, 24 Jul 2023 01:24:36 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qNqri-0006rs-8V; Mon, 24 Jul 2023 10:24:26 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 089851F8383;
        Mon, 24 Jul 2023 08:24:25 +0000 (UTC)
Date:   Mon, 24 Jul 2023 10:24:24 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
        support@ems-wuensche.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-can@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/2] can: ems_pci: move ASIX AX99100 ids to pci_ids.h
Message-ID: <20230724-race-ferret-da65df408c39-mkl@pengutronix.de>
References: <20230720102859.2985655-1-jiaqing.zhao@linux.intel.com>
 <20230720102859.2985655-3-jiaqing.zhao@linux.intel.com>
 <20230720-document-tingle-e5d555714021-mkl@pengutronix.de>
 <77d86059-e8ad-88a6-f2b1-6b4f3aeb24be@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4oltf3q7seyn6acf"
Content-Disposition: inline
In-Reply-To: <77d86059-e8ad-88a6-f2b1-6b4f3aeb24be@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--4oltf3q7seyn6acf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.07.2023 14:39:58, Jiaqing Zhao wrote:
>=20
>=20
> On 2023-07-20 18:40, Marc Kleine-Budde wrote:
> > On 20.07.2023 10:28:59, Jiaqing Zhao wrote:
> >> Move PCI Vendor and Device ID of ASIX AX99100 PCIe to Multi I/O
> >> Controller to pci_ids.h for its serial and parallel port driver
> >> support in subsequent patches.
> >=20
> > Sorry, I haven't noticed the change in "include/linux/pci_ids.h", that
> > the other patches depend on. How to coordinate among the subsystems?
> >=20
> > I don't mind taking the entire (v1) series with the Acks from the
> > tty/serial and parport maintainers, or give my Acked-by to upstream
> > via their trees.
>=20
> Since in ems_pci there are only definition changes, I think having your
> Acked-by and upstream via the serial/parallel tree might be better.

Fine with me. Please add my:

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

to the patches 1 and 2.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4oltf3q7seyn6acf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS+NTQACgkQvlAcSiqK
BOhIpgf+OVV9C6jo/4vj9wH+9+OzBsVuMZipzVGDpENiJHZtOnqyYGowEQ7cATZd
sIfah8FSnDzgdxa+AXoFK9gacW4aRkVvO2hKsXxZ0DWGsulS5uspPS0PCAlop2Tv
fVhLAcO/3menljs+GxEereei348356BCFX3fUTB9qUFnF/C1ykqmd04b4KOPFdq/
ZnWnl7RWZNb6t+/RDn0B9//N/dNT1nfZIvskFLKIl+/DavlAJhz6IvdaDezkSqD0
yXhStO30bzoJ5zyyhsLEX+gFkN5wOgh7Zrd0uvMCdHis9WUx78kRdmSjpKDQPHwJ
H34MX7vcZQalJpnZ5BYavYS3jG/HtQ==
=hCT9
-----END PGP SIGNATURE-----

--4oltf3q7seyn6acf--
