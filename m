Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BDE433616
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 14:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbhJSMiY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 08:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235726AbhJSMiX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 08:38:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CEA361260;
        Tue, 19 Oct 2021 12:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634646971;
        bh=u73RnjWbRxhH6CwTauke6NzU7tR5DI62J9FiY8yQVbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TqrwQPwytMD1dfbq9Mtnro8tcleYatLeGtxlHL9aRTHzVTrMrqRCc5Q5qIXLoP1VL
         y1gAC3s3q5RxgnG+mt1Mnd+MMkk20x3T442HHl9B7+jEiXygfHKeSDW1H5g96t6gMy
         t5gEMN/JxlbDOfqjNgSWkdM9CSjmzW997iSiZs+h0wwKEN+QnwKo+/OKMaKZDgf24S
         1GYnil1dhH0AcMlNL+G0oY5XDpSyLi83jl0XDBbmXuY2wvtFvZcg9nrO5Cj7etEUdw
         TWFZEm6guT3uA6Y236lN1khW177KNWlDxeKN2w9Zx6wKZOGJenIpOvFpLZRoVUYwfo
         KpON6gydXzB5w==
Date:   Tue, 19 Oct 2021 13:36:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Meng Li <Meng.Li@windriver.com>
Cc:     geert+renesas@glider.be, magnus.damm@gmail.com, robh+dt@kernel.org,
        marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        lorenzo.pieralisi@arm.com, kw@linux.com, bhelgaas@google.com,
        lgirdwood@gmail.com, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: pcie-rcar: add regulators support
Message-ID: <YW67tsigF89EkDWS@sirena.org.uk>
References: <20211019095858.21316-1-Meng.Li@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZkQuIMugRNgJ9HKi"
Content-Disposition: inline
In-Reply-To: <20211019095858.21316-1-Meng.Li@windriver.com>
X-Cookie: I program, therefore I am.
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--ZkQuIMugRNgJ9HKi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 19, 2021 at 05:58:58PM +0800, Meng Li wrote:

> From: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
>=20
> Add PCIe regulators for KingFisher board.
>=20
> Signed-off-by: Meng Li <Meng.Li@windriver.com>
> ---

You've not provided a Signed-off-by for Andrey, please see
Documentation/process/submitting-patches.rst for details on what this is
and why it's important.

> +	host->pcie3v3 =3D devm_regulator_get_optional(dev, "pcie3v3");

> +	host->pcie1v8 =3D devm_regulator_get_optional(dev, "pcie1v8");

Unless PCIe works without these supplies (which are in my understanding
mandatory according to the spec) these should not be optional, this API
is for supplies that may be physically absent.

--ZkQuIMugRNgJ9HKi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFuu7YACgkQJNaLcl1U
h9Arnwf+PlApDFGSrd0BxXmjAa5FJY9Vb9EbiuK19rDX3HvMtAKrjMfYkmMoO/6w
7vZ1B/AjW3O8GV7mVJZbela5JVwm3FeDUyL2YDRYsIyRChgwvD7zlUjBoT5bEZVa
kad7VwGSBXaWZfGsm5xlAsN/AAKSKxSkGu/85fYlVWNm/Cg+Mb/N+qp5O+U+jHa6
4eIsau9/dnP2Hu0wjq8+qvfTZQ9gaSqDZdXC8o1y/j5+3cWSGwwQ9cOQMnKO/YlN
w5E5pJ8UCjeA2i7PNp8bFfkGOjqft377c2jpNyrQY8uKeWW/pBCHAQB+DoqR7n2p
npgiAcdcadDCCYkAt0FBJyMjIH5oMg==
=0qYG
-----END PGP SIGNATURE-----

--ZkQuIMugRNgJ9HKi--
