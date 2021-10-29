Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792D843FBB5
	for <lists+linux-pci@lfdr.de>; Fri, 29 Oct 2021 13:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhJ2Lse (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Oct 2021 07:48:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230492AbhJ2Lse (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Oct 2021 07:48:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 657E960FC4;
        Fri, 29 Oct 2021 11:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635507965;
        bh=ADRsTG4KktqVoeo8au9Xp0rvCANd8RBoqqfeQJgiGEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sO28/ddoZql7s0Bfn4pYerXoM34G8N1Zse6CK9yYoLJA+HIYf4DOcawUn8MaMUgQy
         FhkBqwXGqeN9wGXKKG8d5DYtJacckppyEgGn4vLtRThZ41zw3ksAcSiHfKPtRVA0JS
         bXBr3mDgER35cE+0RgnFjZwfzn2Nm2kClusbqGyrpdnZAuMhxwbBSUANfNa9MG8axk
         q9DcgNWpRqR+R4IuG1eFGdnlhLPTDIYgiXIPrIW2z5GNMxq6pxND5Y2Usl50abEXwf
         6v/Zi3yzxxBth0Bq9SIZQSAY10Hb6iPrOPxP/4mGQf6+nMrsQ/TXkEqy1MhOPrI/be
         7GCLROftAItsA==
Date:   Fri, 29 Oct 2021 12:46:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link never
 came up
Message-ID: <YXve+HlpEWOzZ+k3@sirena.org.uk>
References: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
 <1634886750-13861-4-git-send-email-hongxing.zhu@nxp.com>
 <20211025111312.GA31419@francesco-nb.int.toradex.com>
 <YXaTxDJjhpcj5XBV@sirena.org.uk>
 <AS8PR04MB8676A0F3DA3248C6A27801148C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <YXffRmvPYwetsg3L@sirena.org.uk>
 <AS8PR04MB8676AF8685A951E19B1CE0688C869@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <YXqOcAIO2aYkr1sM@sirena.org.uk>
 <AS8PR04MB8676CF52F4D8E9E4E6C07F758C879@AS8PR04MB8676.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ypW26rZg14WCTdak"
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8676CF52F4D8E9E4E6C07F758C879@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-Cookie: "Just the facts, Ma'am"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--ypW26rZg14WCTdak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 29, 2021 at 03:58:41AM +0000, Richard Zhu wrote:

> > The driver should undo any enables it did itself, it should not undo any
> > enables that anything else did which means it should never be basing
> > decisions on regulator_is_enabled().  While the regulator may not be
> > shared in the particular board you're looking at it may be shared in ot=
her
> > systems.

> [Richard Zhu] Understood. Thanks.
> Can I disabled this regulator in PCIe probe failure handler without the
>  regulator_is_enabled() check?

If the driver called regulator_enable() (and that didn't return an
error) it can always call regulator_disable() as many times as it called
regulator_enable(), no need to check if the regulator is still enabled. =20
When the driver hasn't successfully called regulator_enable() it
shouldn't call regulator_disable() even if the regualtor is enabled.
This means that after your driver has enabled the regulator it can just
disable it but between the regulator_get() and regulator_enable() it
shouldn't do that.

--ypW26rZg14WCTdak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmF73vcACgkQJNaLcl1U
h9AhbwgAgIcDmfHvv15AGtB8E/+5w/Jb0ChT7nLC0JRtsFgKrTA91hhmwjwOuQzb
WmH5Ef8qFggm/GpfB58c48KB7SA4vks6kGjzAzro/fJQ4+9Bh6S0o62Ghnf78lKu
dWdIvSnbeX1rXE/FoMF7sUMOi3dyKYAhOgYOQJFV0o6vEkgQJVqkkvCjupeGg8YO
7PeZfXvfzyTySuXVAmeSoinqb7EOR0U40WhbTqo9JzA2n8xp42GhJtdwIuX9b3Ml
J1t0QLqdFvfcr+cdW28R+fJNF7JDdSyTmuAtjfIryp9LylxqcK9hV2ySAs6Gourw
wvbdT+rMkhIjbi744gQnAdDXOQ49kg==
=Upjl
-----END PGP SIGNATURE-----

--ypW26rZg14WCTdak--
