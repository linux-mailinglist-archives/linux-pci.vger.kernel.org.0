Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC17F50A550
	for <lists+linux-pci@lfdr.de>; Thu, 21 Apr 2022 18:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiDUQ1t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Apr 2022 12:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiDUQVg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 12:21:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D51D3879C
        for <linux-pci@vger.kernel.org>; Thu, 21 Apr 2022 09:18:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nhZVl-0000VX-VH; Thu, 21 Apr 2022 18:18:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nhZVl-004OZ9-1k; Thu, 21 Apr 2022 18:18:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nhZVi-004jEg-QT; Thu, 21 Apr 2022 18:18:26 +0200
Date:   Thu, 21 Apr 2022 18:18:23 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor.Dooley@microchip.com
Cc:     pali@kernel.org, robh@kernel.org, lorenzo.pieralisi@arm.com,
        kw@linux.com, Daire.McNamara@microchip.com,
        linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
        ian@linux.cowan.aero, kernel@pengutronix.de, bhelgaas@google.com
Subject: Re: [PATCH] PCI: microchip: Allow driver to be built as a module
Message-ID: <20220421161823.btbuktvz62jgn43a@pengutronix.de>
References: <20220420093449.38054-1-u.kleine-koenig@pengutronix.de>
 <20220420164139.k37fc3xixn4j7kug@pali>
 <bad31f90-f853-fdff-c91c-1a695ff162d1@microchip.com>
 <20220421134121.pnhlwm74yzd5bdrs@pali>
 <787e21f9-9db6-8c20-4983-17ff59b4e045@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kst6joue5ym25znx"
Content-Disposition: inline
In-Reply-To: <787e21f9-9db6-8c20-4983-17ff59b4e045@microchip.com>
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


--kst6joue5ym25znx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 21, 2022 at 01:55:01PM +0000, Conor.Dooley@microchip.com wrote:
> On 21/04/2022 13:41, Pali Roh=E1r wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > On Thursday 21 April 2022 11:31:16 Conor.Dooley@microchip.com wrote:
> >> On 20/04/2022 16:41, Pali Roh=E1r wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you kno=
w the content is safe
> >>>
> >>> On Wednesday 20 April 2022 11:34:49 Uwe Kleine-K=F6nig wrote:
> >>>> There are no known reasons to not use this driver as a module,
> >>>
> >>> Hello! I think that there are reasons. pcie-microchip-host.c driver u=
ses
> >>> builtin_platform_driver() and not module_platform_driver(); it does n=
ot
> >>> implement .remove driver callback and also has set suppress_bind_attrs
> >>> to true. I think that all these parts should be properly implemented
> >>> otherwise it does not have sane reasons to use driver as loadable and
> >>> unloadable module.
> >>>
> >>> Btw, I implemented proper module support for pci-mvebu.c driver
> >>> recently, so you can take an inspiration. See:
> >>> https://lore.kernel.org/linux-pci/20211126144307.7568-1-pali@kernel.o=
rg/t/#u
> >>
> >> Hmm, so what is the way forward here, are you happy to do it yourself
> >> or do you not have the hardware/would rather that we did it?
> >=20
> > Hello! It would be needed to implement remove callback. But I do not
> > have hardware for doing and testing it, so I do not feel that I can do
> > it. I think that somebody with hardware and documentation should look at
> > it and decide what is required to do in remove/cleanup procedure.
> >=20
> > Also it would be needed to investigate if something more is needed to
> > change builtin_platform_driver() to module_platform_driver(). If there
> > are not some other steps which needs to be done in correct sequence and
> > usage of builtin_platform_driver() currently ensures it.
>=20
> Was more wondering if this was something Uwe had hardware for than
> yourself, since he was poking around at the driver. But (assuming he
> doesnt either) I'll add this to our todo :)

FTR: I don't have the hardware, I just touched the driver because I
found that missing ; that didn't hurt with the driver =3Dy. Wondering why
it was bool was just the obvious next thought.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kst6joue5ym25znx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJhg8wACgkQwfwUeK3K
7AlcrQf/fpDv5hRmub/lY8nt361Jl+CW1q66Upw6uqqJwBYp7o26wAweDR/aGlge
PxgL9Y90hUqU+E0/WFAX8Qy0p4F7JrFV274OnXPnZ1+Q6u8HPmpY8zt5R0eDFxPX
RdDg+8enClpCHca+qlJ9NgVz+apad7/UX29Vi5Ef5M1rqbP3mjVljygRkeaN+yi1
qinmmCMw5cLh7S0vdnghQRm/f+znYNMYYQt24zyv1ikAtAB/K3s64JRyWPNbpsp5
pOYcCMedQZ1+YD1NuSGI3Pkh83KWH460WuUnibjCeftKS+ttpUHFFi3ukgIGg45a
Az3wqnC/HnbbsOXjkZ9s2GNSnoboMw==
=GuDg
-----END PGP SIGNATURE-----

--kst6joue5ym25znx--
