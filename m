Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76789508AF4
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 16:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbiDTOqI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 10:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344885AbiDTOqH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 10:46:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F7742A30
        for <linux-pci@vger.kernel.org>; Wed, 20 Apr 2022 07:43:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nhBY2-0004UR-5W; Wed, 20 Apr 2022 16:43:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nhBY0-004BRC-D3; Wed, 20 Apr 2022 16:43:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nhBXy-004Ura-Cr; Wed, 20 Apr 2022 16:43:10 +0200
Date:   Wed, 20 Apr 2022 16:43:10 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-pci@vger.kernel.org, Ian Cowan <ian@linux.cowan.aero>,
        kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: microchip: Add a missing semicolon
Message-ID: <20220420144310.nza6vvwbd57gr4z6@pengutronix.de>
References: <20220420065832.14173-1-u.kleine-koenig@pengutronix.de>
 <YmAKKcBVGuBHwhUb@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n2yfu2qawsewx23r"
Content-Disposition: inline
In-Reply-To: <YmAKKcBVGuBHwhUb@robh.at.kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--n2yfu2qawsewx23r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 20, 2022 at 08:27:05AM -0500, Rob Herring wrote:
> On Wed, Apr 20, 2022 at 08:58:32AM +0200, Uwe Kleine-K=F6nig wrote:
> > If the driver is configured as a module (after allowing this by changing
> > PCIE_MICROCHIP_HOST from bool to tristate) the missing semicolon makes =
the
> > compiler very unhappy. While there isn't a real problem as
> > MODULE_DEVICE_TABLE always evaluates to nothing for a built-in driver,
> > do it right for consistency with other drivers.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >=20
> > I wonder if there is a technical reason to have PCIE_MICROCHIP_HOST (and
> > some others) only bool. With this patch applied the driver compiles just
> > fine with PCIE_MICROCHIP_HOST=3Dm.
>=20
> Historical copy-n-paste.

For the record: I sent a patch to allow PCIE_MICROCHIP_HOST=3Dm:

https://lore.kernel.org/linux-pci/20220420093449.38054-1-u.kleine-koenig@pe=
ngutronix.de
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--n2yfu2qawsewx23r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJgG/sACgkQwfwUeK3K
7AnXsAf/fy26/vSTV6IQX1El1Ss/OwM7thbG5jbHU1pa6WGE7z18ahZI3yBhLl6l
JECRZDYE3F36RgG2VaEGb9kATEGE0PAEVDkAYETt7OfRreRG3H/snpjllV8aIwDY
kA1/YnMuQ3Jy2seeZB80C0WP0rLalMDgxpFAtNgMIGcQxJVeJU8T85r3tzF+wIL9
XbjGPdvG2aSFmdG44NU65OcoVYqY0XgTsKDoWTxSTZ0EoUDDXlQmTjWBkszXqcsp
sSKOxtN2wwAUA01JJNu+6n1zDyEbXpCUzfk/cO3G2jC5/39YD2WpXwwv4B3+3qAB
sv7q/0rj9a2j6BA/pXOOE3oDLHgsrg==
=v9gV
-----END PGP SIGNATURE-----

--n2yfu2qawsewx23r--
