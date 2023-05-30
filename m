Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432E8716331
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 16:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjE3OIy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 10:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjE3OIl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 10:08:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7C3D9
        for <linux-pci@vger.kernel.org>; Tue, 30 May 2023 07:08:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q400v-0004ps-Ru; Tue, 30 May 2023 16:07:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q400o-003tfR-8p; Tue, 30 May 2023 16:07:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q400n-009WHq-B9; Tue, 30 May 2023 16:07:45 +0200
Date:   Tue, 30 May 2023 16:07:42 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Joyce Ooi <joyce.ooi@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Toan Le <toan@os.amperecomputing.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org, kernel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 00/15] PCI: Convert to platform remove callback returning
 void
Message-ID: <20230530140742.ebbrxmpieuphbmz3@pengutronix.de>
References: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qk26xz6flafy3g2q"
Content-Disposition: inline
In-Reply-To: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--qk26xz6flafy3g2q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bjorn,

On Tue, Mar 21, 2023 at 08:31:53PM +0100, Uwe Kleine-K=F6nig wrote:
> this series adapts the platform drivers below drivers/pci to use the
> .remove_new() callback. Compared to the traditional .remove() callback
> .remove_new() returns no value. This is a good thing because the driver c=
ore
> doesn't (and cannot) cope for errors during remove. The only effect of a
> non-zero return value in .remove() is that the driver core emits a warnin=
g. The
> device is removed anyhow and an early return from .remove() usually yield=
s a
> resource leak.
>=20
> By changing the remove callback to return void driver authors cannot
> reasonably assume any more that there is some kind of cleanup later.
>=20
> All drivers were easy to convert as they all returned zero in their
> remove callback. Only for iproc the conversion wasn't trivial, the other
> were converted using coccinelle.
>=20
> There are no interdependencies between these patches. So even if there
> are some concerns for individual patches, I ask you to apply the
> remaining set. Then I only have to care for the review feedback of the
> refused patches. (Having said that I don't expect any serious objection,
> just things like squashing or separating patches, or maybe I picked a
> wrong subject prefix.)

These patches wait for application for quite some time now. They apply
just fine to v6.4-rc1 and next/master. Would be great to get them in
during the next merge window and ideally give them some time in next
before.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qk26xz6flafy3g2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmR2Ay0ACgkQj4D7WH0S
/k5qnwgAnpUxpx4rn6WEsDH7Xm3DdX2vIesYJvk7oOO95SBT/vP6MAkPvzaDUJfe
WVi/Oz1Ka8FPwOop8vkbb8M3nQIjNjB9OfI+6fW+55MvN9guFPI/Utl1TIscmgQz
YnH2pnHF7uIzKApPtniNZJ6CDy1deepI9SK9Vyx/eMbuppFuUfVz5NR+vdR8e1FA
o+DEn8E+tjfjwSb0FdxgTv+Subwm4oPwuYrhyv3bJZ17YenL7OoGc8coPdQr13BS
Mq7t/nM05p/vZtkey55UWA3E+SEsbGz64ikmcv1hfwGVq2aRi8qO+aCUnhe3LX9m
GZAiwIh4ypdjtDXIIMwGjMatqA4QQA==
=tfIE
-----END PGP SIGNATURE-----

--qk26xz6flafy3g2q--
