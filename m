Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CD2763593
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 13:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjGZLsl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jul 2023 07:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbjGZLsj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2023 07:48:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E62F2
        for <linux-pci@vger.kernel.org>; Wed, 26 Jul 2023 04:48:09 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qOczB-0005pA-Ln; Wed, 26 Jul 2023 13:47:21 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 47A741FB4B5;
        Wed, 26 Jul 2023 11:47:20 +0000 (UTC)
Date:   Wed, 26 Jul 2023 13:47:19 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
        support@ems-wuensche.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-can@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/2] can: ems_pci: move ASIX AX99100 ids to pci_ids.h
Message-ID: <20230726-hubcap-jersey-83445f9e5531-mkl@pengutronix.de>
References: <20230720102859.2985655-1-jiaqing.zhao@linux.intel.com>
 <20230720102859.2985655-3-jiaqing.zhao@linux.intel.com>
 <20230720-document-tingle-e5d555714021-mkl@pengutronix.de>
 <61bbb2e6-8c18-d2fc-ce1e-78d462ac1bba@linux.intel.com>
 <2023072657-unloved-magma-8cf2@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t6js5eclfcsqqax7"
Content-Disposition: inline
In-Reply-To: <2023072657-unloved-magma-8cf2@gregkh>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--t6js5eclfcsqqax7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.07.2023 13:38:22, Greg Kroah-Hartman wrote:
> On Thu, Jul 20, 2023 at 10:54:01PM +0800, Jiaqing Zhao wrote:
> > On 2023-07-20 18:40, Marc Kleine-Budde wrote:
> > > On 20.07.2023 10:28:59, Jiaqing Zhao wrote:
> > >> Move PCI Vendor and Device ID of ASIX AX99100 PCIe to Multi I/O
> > >> Controller to pci_ids.h for its serial and parallel port driver
> > >> support in subsequent patches.
> > >=20
> > > Sorry, I haven't noticed the change in "include/linux/pci_ids.h", that
> > > the other patches depend on. How to coordinate among the subsystems?
> > >=20
> > > I don't mind taking the entire (v1) series with the Acks from the
> > > tty/serial and parport maintainers, or give my Acked-by to upstream
> > > via their trees.
> >=20
> > Add tty and parport maintainers to this thread.
> >=20
> > I'd like to ask other maintainers' opinion as I'm not sure which option
> > is better and I had no similar experience before.=20
>=20
> Either is fine with me, I can just take them all through my tty tree as
> that's simplest for me :)

Go ahead!

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--t6js5eclfcsqqax7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmTBB8QACgkQvlAcSiqK
BOjobgf9E968vJVXb8xxGUp+xNfrKHksWTMZpC5ObFx3vrq/Lsiz4u9Pw7ZFYaIQ
2wzOdPjqX7VUAtsAz1EUE05RTKSonK5+2f5Whp37Zaslf/UKet01MJcDK/9jrI23
F6ikSwOqFwRww1pX6b/VpQrALCmCQMWRUgwfThSY0uFbGa3vCtC75CU6t6XwcMiD
i72n8+LU3ylzD1kDUiavPBZjlR6RdI4cW6RrtT5/6CX4Oqxs7GWw6qVerw9uBnzn
rRCvmoqDymIGp1Tb2xw1c+Ckt7fWohsngZ0m00XaG7Cp2Yr21M/03UD+6QHyJdtN
y89e5PzuysAKybhCyBwd3OXpe/l4Uw==
=v+NL
-----END PGP SIGNATURE-----

--t6js5eclfcsqqax7--
