Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F3175AAEA
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 11:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjGTJc0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 05:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjGTJcO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 05:32:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222294493
        for <linux-pci@vger.kernel.org>; Thu, 20 Jul 2023 02:26:20 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qMPvE-0001QP-NM; Thu, 20 Jul 2023 11:26:08 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2355C1F6110;
        Thu, 20 Jul 2023 09:26:07 +0000 (UTC)
Date:   Thu, 20 Jul 2023 11:26:06 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] add support for ASIX AX99100
Message-ID: <20230720-enlarged-scratch-5c8629dc8bea-mkl@pengutronix.de>
References: <20230718174200.2862849-1-jiaqing.zhao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p6ccc7kw3oatnm5q"
Content-Disposition: inline
In-Reply-To: <20230718174200.2862849-1-jiaqing.zhao@linux.intel.com>
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


--p6ccc7kw3oatnm5q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.07.2023 17:41:56, Jiaqing Zhao wrote:
> This patch adds kernel inbox driver support for the serial port and
> parallel port mode controller of ASIX AX99100 PCIe to Multi I/O
> Controller. This device has 4 separate PCI functions and each functions
> can be configured to operate in different modes.
>=20
> This patchset is tested with ASIX AX99100 in following modes:
> * 4 x Serial Port
> * 2 x Serial Port
> * 2 x Serial Port + 1 x Parallel Port
> * 1 x Parallel Port

I think it's better to split the series into subsystems. For CAN that
would be patches 1 and 2. Please add support@ems-wuensche.com and
uttenthaler@ems-wuensche.com on Cc.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--p6ccc7kw3oatnm5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS4/akACgkQvlAcSiqK
BOhxdgf/SWvDQp7oKl0hy/pf7oUnlBLlQcXCv3JXbrRDfYQsqM9pMEoy9T8pb68n
UQqP/3GWxbH8u/Ajwo4j2E52vKraiIbkpiOKa0lFWVjlPMhwO3WhENsn1LECE1D6
WmJlz9AMjKNaR69ncoNsWVig2xmyD2RRurAQdFIBYsDQcuIRqF0u3/Lisbm97rCK
x2fAyeYkG4/VcwZOQkkJDpphcT7YTIHeDwe02d3PFp8JypcSVIkRnZrWqc43o9ux
kOyrpa3+X26pxGRPBIojd21HB4q74r7ziQbUqU0X4IJcML8cELTQt12ngfWMtFES
XimYTl0QvduhSs8NtEwrGbWIecQ+zw==
=Wz7L
-----END PGP SIGNATURE-----

--p6ccc7kw3oatnm5q--
