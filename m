Return-Path: <linux-pci+bounces-16346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B056C9C22C0
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 18:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11421C23523
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 17:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E44718E36D;
	Fri,  8 Nov 2024 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDKJrTqY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C05208C4
	for <linux-pci@vger.kernel.org>; Fri,  8 Nov 2024 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731086162; cv=none; b=qWOExbvj1TX7OrvuDQTouGKSPeXRCvco1q7oyYygfml4iRRUceiVEP6le3WCov1zsvBRRqMfrXvh1cGsapIlX7p9ivZRUfGc+wO46/ZucrlMXL6VV66IPwsKmGFsylsp7AHLmSZ4JdP/jHZw1kQ5lPurqm6Kk5rgtNq/fitSUfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731086162; c=relaxed/simple;
	bh=k0xll76MHqvxLaZR25USTSXDgvhxHc72FiFw4Fp/71A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3iffgj7lx/8btmetmIx8SXZ/pqZIBt5IuwSos2/lByVxLbNnmkojth70zHiKQpYxs5CddP+1RjMY4qrbujCtwUn4XIsjfww9eKw7l4LidJfhdPEpxID0tVgRE88XGmsfJtD+NQXhhuBR7dDPingtePD2L2zJHNKNJ4S4l2fggI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDKJrTqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4152FC4CECF;
	Fri,  8 Nov 2024 17:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731086161;
	bh=k0xll76MHqvxLaZR25USTSXDgvhxHc72FiFw4Fp/71A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cDKJrTqY9lsU0wTCPUufm/SLE0KgoPrvYKHTcmvQeJesbathuWJAXlH81TBPfK6rt
	 sRs3q/tFTfK/OjSPDeKcMI4ekfFAmTsZoUtpNwTx+iYOOx4K3VYC/7tTlvILv/s6a5
	 YtT7IBC/eB/2EBrCtXluhRED/BTPA+LQ3PfIbfehODeAdw5g9jLYVargM2yRYzIS5o
	 s8ntQ4j+1Vfy16yK27X/iUcxDhm9wmTFb0n7q3smUg030tcJHMk0bZtwyoD+7JN8tn
	 9uc71RHlIAnM/5SlLo0h3PVCweaXSy8jQY7K3ulH88x0Bky+QmL2zRe3SdKFEJIjZd
	 wqG2FTiWdEHgg==
Date: Fri, 8 Nov 2024 18:15:59 +0100
From: "lorenzo@kernel.org" <lorenzo@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jianjun Wang =?utf-8?B?KOeOi+W7uuWGmyk=?= <Jianjun.Wang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	Ryder Lee <Ryder.Lee@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI: mediatek-gen3: Move reset/assert callbacks in
 .power_up()
Message-ID: <Zy5HT63apyjYWJ-6@lore-desk>
References: <547216d36f8eaa313690ff8b52407ae46b8e9c40.camel@mediatek.com>
 <20241108164817.GA1665283@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mP5VRDHikAF8nc1W"
Content-Disposition: inline
In-Reply-To: <20241108164817.GA1665283@bhelgaas>


--mP5VRDHikAF8nc1W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 08, Bjorn Helgaas wrote:
> On Fri, Nov 08, 2024 at 02:51:15AM +0000, Jianjun Wang (=E7=8E=8B=E5=BB=
=BA=E5=86=9B) wrote:
> > On Thu, 2024-11-07 at 10:21 -0600, Bjorn Helgaas wrote:
> > > On Thu, Nov 07, 2024 at 05:08:55PM +0100, Lorenzo Bianconi wrote:
> > > > > On Thu, Nov 07, 2024 at 02:50:55PM +0100, Lorenzo Bianconi wrote:
> > > > > > In order to make the code more readable, move phy and mac
> > > > > > reset lines assert/de-assert configuration in .power_up
> > > > > > callback (mtk_pcie_en7581_power_up/mtk_pcie_power_up).
> > > >=20
> > > > ...
> > > > > Is there a requirement that the PHY and MAC reset ordering be
> > > > > different for EN7581 vs other chips?
> > > > >=20
> > > > > EN7581:
> > > > >=20
> > > > >   assert PHY reset
> > > > >   assert MAC reset
> > > > >   power on PHY
> > > > >   deassert PHY reset
> > > > >   deassert MAC reset
> > > > >=20
> > > > > others:
> > > > >=20
> > > > >   assert PHY reset
> > > > >   assert MAC reset
> > > > >   deassert PHY reset
> > > > >   power on PHY
> > > > >   deassert MAC reset
> > > > >=20
> > > > > Is there one order that would work for both?
> > > >=20
> > > > EN7581 requires to run phy_init()/phy_power_on() before deassert
> > > > PHY reset lines.
> > >=20
> > > And the other chips require the PHY power-on to be *after*
> > > deasserting PHY reset?
> >=20
> > For MediaTek's chips, the reset will clear all register values and
> > reset the hardware state. Therefore, we can only initialize and
> > power-on the MAC and PHY after deasserting their resets.
>=20
> OK, it sounds like you're saying the Airoha EN7581 is not a MediaTek
> chip and does require a different ordering of PHY reset deassert and
> PHY power-on:
>=20
>   - EN7581 requires PHY power-on before PHY reset deassert,
>=20
>   - other chips require PHY reset deassert before PHY power-on.
>=20
> That's fine and probably worth a short comment in
> mtk_pcie_en7581_power_up(), e.g., "Unlike the MediaTek controllers,
> the Airoha EN7581 requires PHY power-on before PHY reset deassert".
>=20
> Bjorn

ack, I will add it.

Regards,
Lorenzo

--mP5VRDHikAF8nc1W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZy5HTgAKCRA6cBh0uS2t
rMXUAPwKaa0k+wzeRsFnVFQl6FYhu8AAuAyB7EJEhAKPeWFLRgEAvNRquIoimvKX
1geNkZm6VWuYNkLa0MCU4Xkk/Y7xfw8=
=E6vM
-----END PGP SIGNATURE-----

--mP5VRDHikAF8nc1W--

