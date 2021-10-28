Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4E343E03E
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 13:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhJ1Lwm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 07:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhJ1Lwl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 07:52:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97A0D60FF2;
        Thu, 28 Oct 2021 11:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635421814;
        bh=hgapdR6qmDmcLaknmcSzOPWpHEWQJN4oJ2A60mUz22E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KgMLQjA40UB0Oac51b5wK4aZ7xx0UMxlA4RAJ16ovhhwvvbxhk7D4b70Pz/+S8uSz
         r+i/F2HTqDF09Ofl7Es6xWKpmGTaaJWS2Yg/KMpUNvmbDwt8XF8U4q4ithCUrDt4Q3
         umCl434jYw4vBlhgxhsJLAGCqWZ0GruZvTfwBWhaWkNCbci8o0/GWsPcc+dciVY8PN
         LgnycatH/yG9IgJSfAODHTqc3cIw6zTU7MEngZgPi6+JrylHJg5ffOC67ARaq3N7B9
         Zyy/B2tYwUvjZ4DjksV3jOREt/J9yGIViU5jqEkpH36q0mOD5SuHVXU+qs2tdHWYno
         mBNIa7ZW6WJ/g==
Date:   Thu, 28 Oct 2021 12:50:08 +0100
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
Message-ID: <YXqOcAIO2aYkr1sM@sirena.org.uk>
References: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
 <1634886750-13861-4-git-send-email-hongxing.zhu@nxp.com>
 <20211025111312.GA31419@francesco-nb.int.toradex.com>
 <YXaTxDJjhpcj5XBV@sirena.org.uk>
 <AS8PR04MB8676A0F3DA3248C6A27801148C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <YXffRmvPYwetsg3L@sirena.org.uk>
 <AS8PR04MB8676AF8685A951E19B1CE0688C869@AS8PR04MB8676.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RKFvMGWaPRDm/WJh"
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8676AF8685A951E19B1CE0688C869@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-Cookie: try again
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--RKFvMGWaPRDm/WJh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 28, 2021 at 06:50:58AM +0000, Richard Zhu wrote:

> > I would be really surprised to see PCI hardware that was able to support a
> > supply being physically absent, and this use of _is_enabled() is quite
> > simply not how any of this is supposed to work in the regulator API even
> > for regulators that can be optional.

> [Richard Zhu] Actually, this regulator is one GPIO fixed regulator.
> Controlled by SW to turn on (GPIO high) or turn off (GPIO low) the supply.
> In some boards designs, this supply might be always on(GPIO high).
> So, in point of SW driver view, this regulator is optional.

No, it's not.  The regulator API supports the systems where the
regualtor is always on perfectly well, the client driver should not need
to do anything to support them.

> > Perhaps it's not causing problems in this design but if the supply is ever
> > shared with anything else then the software will run into trouble.
> > There will also be problems with the error handling on a system where
> > the regulator needs to be controlled.

> [Richard Zhu] This GPIO fixed regulator is only used by controller driver.
> It makes sense to disable the enabled regulator when driver probe is failed.

The driver should undo any enables it did itself, it should not undo any
enables that anything else did which means it should never be basing
decisions on regulator_is_enabled().  While the regulator may not be
shared in the particular board you're looking at it may be shared in
other systems.

--RKFvMGWaPRDm/WJh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmF6jm8ACgkQJNaLcl1U
h9BLxgf/Zm+IGEbLXWh7e1XuPxfanEkwKtL8XvVb+F4KlVIKego05HBRd7BLknFd
/HzU7BxR6iGIJE9KlLgl9p7qL6n6RZXatqZTFdkqElP/LS0WdwofBU0mYngVwUoJ
Bt9LDQBMLxU/elYGbWCDTEQ1OmZc54if7ty5z+UQuZib/L8qQqF3hDKci5jcUsOx
lPr2+lvxzDlbHRGZxseE7TZMcKtdUri58cBttYQTOgptD5HPwgD1gyx/Vg0rdimo
xfCY52Hrv7C3UToRss7CySnSZV29AY3lONKh3IjtvMqpvNo2gDWIyFARtpM/5Nob
ZJEZ+qQg+AjCsze/u0ox6CQgajm+SA==
=HgqY
-----END PGP SIGNATURE-----

--RKFvMGWaPRDm/WJh--
