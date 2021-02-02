Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308AD30CC9C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 21:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240240AbhBBUBo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 15:01:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232851AbhBBNrU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 08:47:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8E7E64F93;
        Tue,  2 Feb 2021 13:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612273309;
        bh=lrgu37PQY9gKgzLHomntqVwJNVrZZKNWqcd6OBNf6hA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lP7CntQBMbVQJpEaaiYL7FNJfFN62FdN/GcMCAopAu3GeFeVdRngp79sVRpzFuHK5
         TD5qm7vP35cKE27SqbfUnQslx8BchPj39SM6t3rctdUC8fYtCSE4pQocYrTa0iN/0t
         d3FXWFCxMFvch8y6MGZ18wvBLBYTgHhaxOiLNKDwuznwWMH/xSyFPOFz3kqVjyuXZ0
         zRzPBx8du28F2J7+fEf6S8AW6tZIr7+Fk1oGqZHo5IfxHe5n3QmWIbNh9GJ1DWeuGS
         WNY6QFW1AReemuHlARlf6l+8hftt/ZTfX7rBzAc8J6+5GpSagbMIx44wB9Lpu37BSB
         l0Kc3Fk6ocsSg==
Date:   Tue, 2 Feb 2021 13:41:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 09/13] pci: dwc: pcie-kirin: allow to optionally require
 a regulator
Message-ID: <20210202134101.GB5154@sirena.org.uk>
References: <cover.1612271903.git.mchehab+huawei@kernel.org>
 <7f4abd1ba9f4b33fe6f66213f56aa4269db74317.1612271903.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <7f4abd1ba9f4b33fe6f66213f56aa4269db74317.1612271903.git.mchehab+huawei@kernel.org>
X-Cookie: Only God can make random selections.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 02, 2021 at 02:29:54PM +0100, Mauro Carvalho Chehab wrote:
> On Hikey 970, there's a power supply controlled by Hi6421v600
> regulator that turns on the PCI devices on the board. Without
> that, no PCI hardware would work.
>=20
> As this is device-dependent, such regulator line should be
> optional.

Supplies should only be optional if they may be physically absent from
the system, if they are just sometimes not described well in firmware
they should be requested via the normal regulator_get() interface, the
core will supply a dummy regulator if there is nothing at all in the
firmware description.

Supplies should also generally be referred to with the naming used in
the datasheet for the part.

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAZVm0ACgkQJNaLcl1U
h9DRtAf+K9FZJNlyTA10opaKROPalDvJYAUzGS29QifY8rP5q40puTuZCei9grQM
Qxa47bzq4jvwxU8OEg6BID3Orcf7Q+OMe5RV0e58Okl62F4uBXJaVWYp8mnwPpKW
tPebWtJPWh9PJts0TMok3Noq/AZ8UQxmyiOasj8izrMxk3FEVidRAtXpHbFw+Rwa
YkTAk/4y4pZhz9pKYGuEXGLj5spn4O7+SiONjxuMB+SZMHLH4foQFiCtmul6upY9
2UYXjt4NUMCphxNykQ8UeAWDWoQ9txj7vRHFl5YPp0MIbRCNcHFuJEDjZsfQIbFH
PQQBEahCUOHsorC5pbyEuDrKH60SPw==
=WkEg
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
