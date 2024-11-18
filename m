Return-Path: <linux-pci+bounces-17042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEF39D1022
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 12:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D570AB29D57
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 11:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C300E176AA9;
	Mon, 18 Nov 2024 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTpJ5ajV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99170148827;
	Mon, 18 Nov 2024 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731930502; cv=none; b=hvD7W/DejzqZdya/DfvGGz5mKkOhEcxyd13KwjmPJuh4SnWnBLJj/JkhP0Lpi2oG1rTOS5r01zkIFWvhhlgUrPWSaBRBRKLj4z1ZDhENwuDgCgHSUQwhMiam68rWfloqm34nsD2vhjDjmR7YV4X2kj6Yt1qTnQ/+SIiT/NewLbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731930502; c=relaxed/simple;
	bh=ECmU6i0EoWAMf6OCxHfH8eVo80Ipk+BYiYRJhQaeKac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaGatJTSWlwfGzOZie7y+vfC7rHopMjogvm6u/XUZXoSVhwpdXifM56KF9i153YnsEmyFDx13qOwD4UQDhNbBn0mTnZTwHp3aE0MRWFn68fpfE/9JZYlXW5MRxzyt6Z1QJAiLJiWl/2Q1kE+gZwEaPzh3GpxjHWataRDfyxog7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTpJ5ajV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E999C4CED0;
	Mon, 18 Nov 2024 11:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731930502;
	bh=ECmU6i0EoWAMf6OCxHfH8eVo80Ipk+BYiYRJhQaeKac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dTpJ5ajVOfRRaDI6EaOGtHKvEFFK42O9bDNFT6YXzErr5QDRmCMkt/1yCxq3CFxIt
	 wX5ptQSEB+fISDyrm3e1uPIzcY5HOyCHFNqjiZOfQd/c1QFQ3iI/ay+1ecsh+573ZR
	 7pDUFVsJ2DaZC74ziiN9jdBk776uenwViMRH9qnrfNN92q09QUDVX/Wym+2/BdmeAW
	 EsCm++is/mID3hABxcFufYrqDht4UOqB4tprWocfiUzVGU30e8KfqrxMB4vCHkeYiy
	 w9LyvuzbXPlNaFijUYSAUw3MpRVhpalYmAE2d0jvyDE1ytylWkv2vvqa7pQL4oyaVF
	 TXoqKbZImK88A==
Date: Mon, 18 Nov 2024 12:48:19 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 3/6] PCI: mediatek-gen3: Move reset/assert callbacks
 in .power_up()
Message-ID: <ZzspgzXCyds04gTY@lore-desk>
References: <20241118-pcie-en7581-fixes-v4-0-24bb61703ad7@kernel.org>
 <20241118-pcie-en7581-fixes-v4-3-24bb61703ad7@kernel.org>
 <2d7e1e5e09babb468199ac44520683fcb87d697c.camel@pengutronix.de>
 <ZzsC_hW-w6WSMYSO@lore-desk>
 <1fb3166c1f520a57c19bd3103b4585eee1e57fec.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ri31TOsdNIkAAenH"
Content-Disposition: inline
In-Reply-To: <1fb3166c1f520a57c19bd3103b4585eee1e57fec.camel@pengutronix.de>


--ri31TOsdNIkAAenH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mo, 2024-11-18 at 10:03 +0100, Lorenzo Bianconi wrote:
> > On Nov 18, Philipp Zabel wrote:
> > > On Mo, 2024-11-18 at 09:04 +0100, Lorenzo Bianconi wrote:
> > > > In order to make the code more readable, the reset_control_bulk_ass=
ert()
> > > > for PHY reset lines is moved to make it pair with
> > > > reset_control_bulk_deassert() in mtk_pcie_power_up() and
> > > > mtk_pcie_en7581_power_up(). The same change is done for
> > > > reset_control_assert() used to assert MAC reset line.
> > > >=20
> > > > Introduce PCIE_MTK_RESET_TIME_US macro for the time needed to
> > > > complete PCIe reset on MediaTek controller.
> > > >=20
> > > > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@=
collabora.com>
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > >  drivers/pci/controller/pcie-mediatek-gen3.c | 27 +++++++++++++++++=
++--------
> > > >  1 file changed, 19 insertions(+), 8 deletions(-)
> > > >=20
> > > > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/=
pci/controller/pcie-mediatek-gen3.c
> > > > index 3cfcb45d31508142d28d338ff213f70de9b4e608..2b80edd4462ad4e9f2a=
5d192db7f99307113eb8a 100644
> > > > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > > > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > > > @@ -125,6 +125,8 @@
> > > > =20
> > > >  #define MAX_NUM_PHY_RESETS		3
> > > > =20
> > > > +#define PCIE_MTK_RESET_TIME_US		10
> > > > +
> > > >  /* Time in ms needed to complete PCIe reset on EN7581 SoC */
> > > >  #define PCIE_EN7581_RESET_TIME_MS	100
> > > > =20
> > > > @@ -912,6 +914,14 @@ static int mtk_pcie_en7581_power_up(struct mtk=
_gen3_pcie *pcie)
> > > >  	int err;
> > > >  	u32 val;
> > > > =20
> > > > +	/*
> > > > +	 * The controller may have been left out of reset by the bootload=
er
> > > > +	 * so make sure that we get a clean start by asserting resets her=
e.
> > > > +	 */
> > > > +	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
> > > > +				  pcie->phy_resets);
> > > > +	reset_control_assert(pcie->mac_reset);
> > > > +
> > > >  	/*
> > > >  	 * Wait for the time needed to complete the bulk assert in
> > > >  	 * mtk_pcie_setup for EN7581 SoC.
> > >=20
> > > This comment is not correct anymore.
> >=20
> > I agree naming is hard, but I guess we can assume with 'bulk' we refer =
to both
> > phy and mac reset (similar to what we have in mtk_pcie_power_up()),
> > what do you think?
>=20
> My point is that the referenced (bulk) assert isn't in mtk_pcie_setup()
> anymore - it was just moved right above this comment.

ok, thx. I got what you mean now, I will fix it.

>=20
> I wonder why that delay is required at all, though. Does the reset
> controller driver return from reset_control_ops::assert before the
> reset line to the PCI controller is asserted?

We discussed it in a previous revision and Bjorn requested to have the requ=
ired delaies=20
in the PCIe driver.

https://patchwork.kernel.org/project/linux-pci/patch/aca00bd672ee576ad96d27=
9414fc0835ff31f637.1720022580.git.lorenzo@kernel.org/#26110282

Btw this the same approach we had in mtk_pcie_setup() before this series (u=
sleep_range(10, 20)).

Regards,
Lorenzo

>=20
> regards
> Philipp

--ri31TOsdNIkAAenH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZzspgwAKCRA6cBh0uS2t
rKN+AP9HOIPKClruDDjt4RHUOUvciZA0G8k4YuUoY/eDGjzeGQEAiAvQ9k7T4Sn6
rCEM7srXIMeT10dO19v/QyOYmkvLXQQ=
=kXhO
-----END PGP SIGNATURE-----

--ri31TOsdNIkAAenH--

