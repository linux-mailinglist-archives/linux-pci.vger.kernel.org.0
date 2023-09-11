Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36EA79BEC5
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbjIKVjJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbjIKJ4m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 05:56:42 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121FCE67;
        Mon, 11 Sep 2023 02:56:38 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CE52D1C0004; Mon, 11 Sep 2023 11:56:36 +0200 (CEST)
Date:   Mon, 11 Sep 2023 11:56:36 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        l.stach@pengutronix.de, kw@linux.com, bhelgaas@google.com,
        shawnguo@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 4.19 4/6] PCI: dwc: Provide deinit callback for
 i.MX
Message-ID: <ZP7kVCxA0cRW94tc@duo.ucw.cz>
References: <20230909002424.3578867-1-sashal@kernel.org>
 <20230909002424.3578867-4-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oDh1cs2YZRAvwuVR"
Content-Disposition: inline
In-Reply-To: <20230909002424.3578867-4-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--oDh1cs2YZRAvwuVR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Mark Brown <broonie@kernel.org>
>=20
> [ Upstream commit fc8b24c28bec19fc0621d108b9ee81ddfdedb25a ]
>=20
> The i.MX integration for the DesignWare PCI controller has a _host_exit()
> operation which undoes everything that the _host_init() operation does but
> does not wire this up as the host_deinit callback for the core, or call it
> in any path other than suspend. This means that if we ever unwind the
> initial probe of the device, for example because it fails, the regulator
> core complains that the regulators for the device were left enabled:

This is somehow not queued for 5.10. Mistake?

BR,
									Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oDh1cs2YZRAvwuVR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZP7kVAAKCRAw5/Bqldv6
8qM2AJ9pal6r14BtSkzkZHFpNPVpO0gtfACeNIQyH2r7BL5s9n0gSQaapaEwjLw=
=DEDc
-----END PGP SIGNATURE-----

--oDh1cs2YZRAvwuVR--
