Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B0F7F1F20
	for <lists+linux-pci@lfdr.de>; Mon, 20 Nov 2023 22:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjKTVWk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Nov 2023 16:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjKTVWj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Nov 2023 16:22:39 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A73C4
        for <linux-pci@vger.kernel.org>; Mon, 20 Nov 2023 13:22:35 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r5Bis-0003ul-3Z; Mon, 20 Nov 2023 22:22:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r5Bir-00AR9K-GD; Mon, 20 Nov 2023 22:22:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r5Bir-004dlI-2D; Mon, 20 Nov 2023 22:22:25 +0100
Date:   Mon, 20 Nov 2023 22:22:24 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Will Deacon <will@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rob Herring <robh@kernel.org>, kernel@pengutronix.de,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: host-generic: Convert to platform remove callback
 returning void
Message-ID: <20231120212224.txokceaqze76zqjd@pengutronix.de>
References: <20231020092107.2148311-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kkpmyjxdmyewg7s2"
Content-Disposition: inline
In-Reply-To: <20231020092107.2148311-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--kkpmyjxdmyewg7s2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Oct 20, 2023 at 11:21:07AM +0200, Uwe Kleine-K=F6nig wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code.  However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>=20
> pci_host_common_remove() returned zero unconditionally. With that
> converted to return void instead, the generic pci host driver can be
> switched to .remove_new trivially.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

who feels responsible to apply this patch?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kkpmyjxdmyewg7s2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVbzhAACgkQj4D7WH0S
/k5VIQgAggsuCUSvEVOl1DNLul8HNUkR6YBL39EYEQvH5sO3+EC5mvEbTUIu6YH4
eTpjjRCbdzVgmM9PSp3gR3kM4UyZU+7Bg7SfkyKjIqrTiu8ECeMagCKq/RYJnyzk
6bAQ/ReAUKaw+OwwLoiIzXHrmmpJS43XD3vZDqn3vElw1IBRvFX6K4chTczBPBaA
pXNW/KpBxHUMmRrA0Am/xrf+lqemHAqibYuFPWFpo9dglrUhrri17OrrX2941Lc7
XQIbxd63hqs0yvgYNcmQJ8kMxOQY5Dibvs7kKyIg2U7ek9YjSN9aNysUZ6yor6oI
nxXXwn+EwxOXmK4eT9i7bkus8tPj3g==
=FEnO
-----END PGP SIGNATURE-----

--kkpmyjxdmyewg7s2--
