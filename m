Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDE243B0A8
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 12:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhJZLAn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 07:00:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232840AbhJZLAm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Oct 2021 07:00:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10A8F60C4A;
        Tue, 26 Oct 2021 10:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635245899;
        bh=VJI5lKGLCEnHTM2XKYq5kpokq1eyOKv3nZvB6oSX6iI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0nDHmUZYJu1sh0KaumGV8/WwXUe2hnA6se9sTtEb2P/q1ZBrxQC/citRv//6N7J5
         5ZZxXaklOn8vawrgdtxvw31SWmCmMsm7zSVYLqaiG+5unri3xlhPioZxMHGkZKKEN7
         9FtyqSOjYtFzSQQRbpYRf00gsSiWKRKxSdtUqK0G301JRPiBsvZNg/1q1V/oLaDA6e
         PrQG2QJX1l0VC9u6PYHbDd81vXLUf4Qc1HKn/U7IL50qmS8MxAFkYdt6FBPlHksWhu
         4Z9j0CU53oJeBkDVfJatFxBoOFYjB6XkxSdQyBs8DHbatbg4kuF38OQw0O8/dXy/sj
         0V2bhGfhzsUrw==
Date:   Tue, 26 Oct 2021 11:58:14 +0100
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
Message-ID: <YXffRmvPYwetsg3L@sirena.org.uk>
References: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
 <1634886750-13861-4-git-send-email-hongxing.zhu@nxp.com>
 <20211025111312.GA31419@francesco-nb.int.toradex.com>
 <YXaTxDJjhpcj5XBV@sirena.org.uk>
 <AS8PR04MB8676A0F3DA3248C6A27801148C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CM9V7cdtbJ/epuLB"
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8676A0F3DA3248C6A27801148C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-Cookie: Times approximate.
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--CM9V7cdtbJ/epuLB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 26, 2021 at 02:18:18AM +0000, Richard Zhu wrote:

> > I should probably also say that the check for the regulator looks buggy=
 as well,
> > regulators should only be optional if they can be physically absent whi=
ch does
> > not seem likely for PCI devices.  If the driver is not doing something =
to
> > reconfigure the hardware to account for a missing supply this is genera=
lly a big
> > warning sign.
> >=20
> > I really don't understand why regulator support is so frequently proble=
matic
> > for PCI controllers.  :(

> [Richard Zhu] Hi Mark:
> The _enabled check is used because that this regulator is optional in the=
 HW design.
> To make the codes clean and aligned on different HW boards, the _enabled =
check is added.

I would be really surprised to see PCI hardware that was able to support
a supply being physically absent, and this use of _is_enabled() is quite
simply not how any of this is supposed to work in the regulator API even
for regulators that can be optional.

> The root cause is that the error return is not handled properly by the co=
ntroller driver.
> I.MX PCIe controller doesn't support the Hot-Plug, and it would return -1=
10 error
> when PCIe link never came up. Thus, the _probe would be failed in the end.
> The clocks/regulator usage balance should be considered by i.MX PCIe cont=
roller, that's all.
> It's not a general case, and the problem is not caused by the regulator s=
upport.

Perhaps it's not causing problems in this design but if the supply is
ever shared with anything else then the software will run into trouble.
There will also be problems with the error handling on a system where
the regulator needs to be controlled.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--CM9V7cdtbJ/epuLB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmF330UACgkQJNaLcl1U
h9A2rAf/TXfjNuS1ZmCvM9JPsvkTyS9t0JH1Y8KuUtNmbOh51YbCBVZ8o/toaYJ8
3VZy5Ptw8l/2KnbYlSEaFFGbiJpIcVkOw6Qo7nKSnArIMJIB/uM+Jb/1YRnXXdF5
SE+AIC+vPcUPWSGQsljXr1jttE954+U6sCO6QhWlRWjIP7O+sxpL+7v6uw3SBpYp
9HEJF3oeXJMRqkhyC4YKZ1emojKPHT3sVWUaQyRDRQD3m+7QjLGIWJ+JNB/gEcXv
2r8yXKuijwOmrTP7niPOLXez48txft/1ojj8Fb6bbaHlPlQp9c3kWgO6/RoCAwf9
8lqP9o/zPqn8jhq+wb4DCHrE5hOi5w==
=f1Cl
-----END PGP SIGNATURE-----

--CM9V7cdtbJ/epuLB--
