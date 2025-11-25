Return-Path: <linux-pci+bounces-42084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0868C86E70
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 21:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9AD8135267F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 20:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88074333447;
	Tue, 25 Nov 2025 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwFYoMVo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FFF2DF6F8;
	Tue, 25 Nov 2025 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764100821; cv=none; b=uDGGMvcRv7KqQL6JFZlfZWiqjrQnXfMiFe4nI7NAaMh1FaAq70NveXoSsSuIio1eANguj3gSKa2s1TZfqlWU39mxc0VQI+4FtWWcGeNYODWgII003ol3j8KBpPCoQ1oLoRhR48jfhDZZZ7Rn7n/ELPIq0g8qR0nY3mec0Gzpab0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764100821; c=relaxed/simple;
	bh=7wmgeSUA+y6AQHI41p/L0fxZB3D11yKLxUkqIdhJ4v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcJWGCKS0pwaT3DZ2hAQvPawdrbAFo1yHQlOdXjcn8ZnELmP785hSpStJmE6iN6f8EMPCtGa7RVTQ2V3UWiqh4dUs0ygns8VdyX6oGndSPjMTf8FjDEwD6UgVbm2+OYkh4HGy3nwyMqqHQtUemrzsIBECt3bvPLZJLynwnzQB0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwFYoMVo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EC3C4CEF1;
	Tue, 25 Nov 2025 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764100821;
	bh=7wmgeSUA+y6AQHI41p/L0fxZB3D11yKLxUkqIdhJ4v0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HwFYoMVo8Gk7CKe0VFuuJ3okWlTZi8B5IMClLbbULWvuETHV+Ve9t4puO4DYNor8s
	 vjJfw8WGh6WkCXAwARpRreAdLkbGZzL44xB6VNiH3/WBaNDBuG9uPq2Nik7aH4f3gb
	 j5I/LXTfZw7GzlNNHiY/F9eSiSPEDvLweWIgVVUggOxys4bv5KfBFhMT0HGDPoqhP6
	 YR5Wr2kTiiIX4Ca2IeNwA/ZqULoNzTLNQVILoyPoj3fi/VCeoKrRVEw39cRl5OQ76w
	 NIXk3HETbGgQrWK5Lj6++ySiZlAdodYHe21dt8Iwi0ChcrvLy8M7a9+dVMix1YEiBg
	 R2nNqsQAkqO6g==
Date: Tue, 25 Nov 2025 20:00:14 +0000
From: Conor Dooley <conor@kernel.org>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	E Shattow <e@freeshell.de>, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] PCI: starfive: Use regulator APIs instead of GPIO
 APIs to enable the 3V3 power supply of PCIe slots
Message-ID: <20251125-encourage-junkie-f80e6933b3af@spud>
References: <20251125075604.69370-1-hal.feng@starfivetech.com>
 <20251125075604.69370-2-hal.feng@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j+BWZhcgMt7PqE4k"
Content-Disposition: inline
In-Reply-To: <20251125075604.69370-2-hal.feng@starfivetech.com>


--j+BWZhcgMt7PqE4k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 03:55:59PM +0800, Hal Feng wrote:
> The "enable-gpio" property is not documented in the dt-bindings and
> using GPIO APIs is not a standard method to enable or disable PCIe
> slot power, so use regulator APIs to replace them.
>=20
> Tested-by: Matthias Brugger <mbrugger@suse.com>

Is this actually a valid tag?
He provided one for the series on v3, which didn't include this patch.

--j+BWZhcgMt7PqE4k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaSYKzgAKCRB4tDGHoIJi
0iQMAQCnkfFlvRj+TENemCjBkED0QboWJjLXrzEVht+jLtlpwgEA+fnrqb4AUqg4
NHJcnwNxIAD5Y5XuEaUuHroA7XIZCQk=
=trKW
-----END PGP SIGNATURE-----

--j+BWZhcgMt7PqE4k--

