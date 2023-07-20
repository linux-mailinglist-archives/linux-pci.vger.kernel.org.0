Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1B275AC31
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 12:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjGTKke (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 06:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjGTKkd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 06:40:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0723E171D
        for <linux-pci@vger.kernel.org>; Thu, 20 Jul 2023 03:40:33 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qMR53-0003bG-FA; Thu, 20 Jul 2023 12:40:21 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id F200D1F6205;
        Thu, 20 Jul 2023 10:40:19 +0000 (UTC)
Date:   Thu, 20 Jul 2023 12:40:19 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
        support@ems-wuensche.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-can@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/2] can: ems_pci: move ASIX AX99100 ids to pci_ids.h
Message-ID: <20230720-document-tingle-e5d555714021-mkl@pengutronix.de>
References: <20230720102859.2985655-1-jiaqing.zhao@linux.intel.com>
 <20230720102859.2985655-3-jiaqing.zhao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ywabkzbnj5v34fnc"
Content-Disposition: inline
In-Reply-To: <20230720102859.2985655-3-jiaqing.zhao@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--ywabkzbnj5v34fnc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.07.2023 10:28:59, Jiaqing Zhao wrote:
> Move PCI Vendor and Device ID of ASIX AX99100 PCIe to Multi I/O
> Controller to pci_ids.h for its serial and parallel port driver
> support in subsequent patches.

Sorry, I haven't noticed the change in "include/linux/pci_ids.h", that
the other patches depend on. How to coordinate among the subsystems?

I don't mind taking the entire (v1) series with the Acks from the
tty/serial and parport maintainers, or give my Acked-by to upstream
via their trees.

> Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/net/can/sja1000/ems_pci.c | 6 +-----
>  include/linux/pci_ids.h           | 4 ++++
>  2 files changed, 5 insertions(+), 5 deletions(-)

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ywabkzbnj5v34fnc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS5DxAACgkQvlAcSiqK
BOg1UAf/ZpmSvdfWjnvUZk3Qv6CwO0u6+aHK85LaqW2FCBv8xe0Ci75aMDbTPUn/
RPkl6x1csKOKwJP8AwktGovSKKMSeBDyROTbsYBbbt31pjimsw+8Iys8/fl+evQK
wZj6Smf98VWGg8FxCAOPBmdJNA6R/6nR1Wdv9Ernqemv/WmJGvEYpvbVGg6++gZj
1/vGdFAw5G6k84HAktpsynVBlTZ5lRQaJHTTavXlo+sL143PePp5aSewYBqd0e26
bAwZU/HNTcmcAhyzaczd/Hi49A6ZFZLM4RuY2pzpWFYhgYM+sel34Q95d63aA+hx
VpTBRe3wOLTGC6KkKsuoN395qO3UlA==
=6EYy
-----END PGP SIGNATURE-----

--ywabkzbnj5v34fnc--
