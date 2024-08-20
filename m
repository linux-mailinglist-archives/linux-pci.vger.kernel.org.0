Return-Path: <linux-pci+bounces-11868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0845A958151
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 10:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC861C23B83
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 08:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE63D14B075;
	Tue, 20 Aug 2024 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEq+Qwwq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6225158A19;
	Tue, 20 Aug 2024 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143612; cv=none; b=JREENaDsJwTdGTFAySnjzS/LL6n9Cr5j8kS7CTxdZcsZ4UX2AwGqFY17JTFae3meI47xqS/UWkH+//YZQoyPkZWQKFsnRwQsVky8xEllpj0Y4wJAxpb4SbiMBlTb5uCzzKJSerfi8k3DXL8MEJCfXxjuj9W4N9ucNqW76rkp/LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143612; c=relaxed/simple;
	bh=jP0UPp0f7Mtz8ZNyfHvVjWkbkcPAV6QZpbFis998vsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3fCoVL3SC4yvzq6jdOu+dx55+8tKZkRF7jpPiG/ky9xF0n4hVgr7LuBdXlZ/2y7zO61A66INwOTqRaisQdidFF3TMMymxA0qAzpmFL5LocZ0s86lNTGqKG0n3tUOEf8M3nT4jNXEyikkdKPWdDSV2yPeQsWM8EvJyb8qd7jw2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEq+Qwwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7575C4AF0B;
	Tue, 20 Aug 2024 08:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724143612;
	bh=jP0UPp0f7Mtz8ZNyfHvVjWkbkcPAV6QZpbFis998vsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gEq+Qwwq8P7Xar8SqDplvBo3kIv21WIHqa/LVVSxmYF4NO4/MV+CWpvIMPueRVl95
	 LbwzPKsC50upx761bgOFb2CcjXKLKTVqi+qo6xFE6Ji0W87vTrid4TSTW0sWqbsH7P
	 aYbdz2YiGsYb2z6pzC+gIAzNijnhGMbLe1ZZDY8+29ETe3rh9fZkSLwcuafvhvt92y
	 8FIqbLjIkGFTRIPLeBaXe89rb5nAhkgGW0gB354b3hUGxksLC2mIyfTd1XmIJ9RtkH
	 85Be4m1rMGoG/elWkdV8D8M9zmjWqNgsiHlY+kcjjm1WV4ARCzi3TvQQLWtmaw60dy
	 +D7Ms6lCkbDBg==
Date: Tue, 20 Aug 2024 10:46:48 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-mediatek@lists.infradead.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v4 0/4] Add Airoha EN7581 PCIe support
Message-ID: <ZsRX-Hrn2fCITK4P@lore-desk>
References: <cover.1720022580.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IYc/7hkpgcMPfB5b"
Content-Disposition: inline
In-Reply-To: <cover.1720022580.git.lorenzo@kernel.org>


--IYc/7hkpgcMPfB5b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Introduce support for EN7581 SoC to mediatek-gen3 PCIe driver
>=20
> Changes since v3:
> - move phy initialization delay in pcie-phy driver
> - rename en7581 PCIe reset delay
> - fix compilation warning
> Changes since v2:
> - fix dt-bindings clock definitions
> - fix mtk_pcie_of_match ordering
> - add register definitions
> - move pcie-phy registers configuration in pcie-phy driver
> Changes since v1:
> - remove register magic values
> - remove delay magic values
> - cosmetics
> - fix dts binding for clock/reset
>=20
> Lorenzo Bianconi (4):
>   dt-bindings: PCI: mediatek-gen3: add support for Airoha EN7581
>   PCI: mediatek-gen3: Add mtk_gen3_pcie_pdata data structure
>   PCI: mediatek-gen3: Rely on reset_bulk APIs for PHY reset lines
>   PCI: mediatek-gen3: Add Airoha EN7581 support
>=20
>  .../bindings/pci/mediatek-pcie-gen3.yaml      |  68 ++++++-
>  drivers/pci/controller/Kconfig                |   2 +-
>  drivers/pci/controller/pcie-mediatek-gen3.c   | 180 ++++++++++++++++--
>  3 files changed, 229 insertions(+), 21 deletions(-)
>=20
> --=20
> 2.45.2
>=20

Hi all,

any update about this series? Am I supposed to do something? Thanks in adva=
nce.

Regards,
Lorenzo

--IYc/7hkpgcMPfB5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZsRX+AAKCRA6cBh0uS2t
rNVkAQDjeTpROA/Ztc6Z6ATzFvCBAg6SbtNQf3MAMx0ZNAv5wAEAqsAM5oi6C3U4
KLu/WPmuUg39yM3Z1OIwjPpCPaCGwA8=
=gLv3
-----END PGP SIGNATURE-----

--IYc/7hkpgcMPfB5b--

