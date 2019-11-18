Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC3321004E6
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 12:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfKRL7d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 06:59:33 -0500
Received: from foss.arm.com ([217.140.110.172]:33340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfKRL7d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 06:59:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F6D11FB;
        Mon, 18 Nov 2019 03:59:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D2553F6C4;
        Mon, 18 Nov 2019 03:59:31 -0800 (PST)
Date:   Mon, 18 Nov 2019 11:59:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     shawn.lin@rock-chips.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, bhelgaas@google.com, heiko@sntech.de,
        lgirdwood@gmail.com, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: rockchip: Simplify optional regulator handling
Message-ID: <20191118115930.GC9761@sirena.org.uk>
References: <1eebc002101931012d337cda23d18f85b0326361.1573908530.git.robin.murphy@arm.com>
 <347bc3ef8399577e4cef3fdbf3af34d20b4ad27e.1573908530.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Content-Disposition: inline
In-Reply-To: <347bc3ef8399577e4cef3fdbf3af34d20b4ad27e.1573908530.git.robin.murphy@arm.com>
X-Cookie: no maintenance:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2019 at 12:54:20PM +0000, Robin Murphy wrote:
> Null checks are both cheaper and more readable than having !IS_ERR()
> splattered everywhere.

> -	if (IS_ERR(rockchip->vpcie3v3))
> +	if (!rockchip->vpcie3v3)
>  		return;
> =20
>  	/*
> @@ -611,6 +611,7 @@ static int rockchip_pcie_parse_host_dt(struct rockchi=
p_pcie *rockchip)
>  		if (PTR_ERR(rockchip->vpcie12v) !=3D -ENODEV)
>  			return PTR_ERR(rockchip->vpcie12v);
>  		dev_info(dev, "no vpcie12v regulator found\n");
> +		rockchip->vpcie12v =3D NULL;

According to the API NULL is a valid regulator.  We don't currently
actually do this but it's storing up surprises if you treat it as
invalid.

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3Sh6EACgkQJNaLcl1U
h9AOkgf/VTgP3xuhrmrWsbUIyqn+9NRUQlo2cBfiCB08Dqwn+Nyoeb6LLY0SnG6R
ezJOmBDiE/Ih8trc+IRq/nAgaM620I3ZLeodmwtndxikXe2QEl59zkpmiY3JQDlG
prOhuT1YC88FD5fPT1bmSxJyRpLwZ/dI4fP0SwuGn7sYXdv0285guwMhP80Kjn9p
Z8Z5x2AG7D41r8QMatZ0q0/W2rma7jdcE4J7yllyxDOHA8BqMX8GQs3UGohFU1GR
9bs8wM7zhZYoWS7YCuRmytgh85YUV1i/iM0OqGhzni4/ir6jQ89uZA4/KEk5S/MO
OkxQcqTDVXdu97bEOyC3ofVQiby50w==
=OHJP
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--
