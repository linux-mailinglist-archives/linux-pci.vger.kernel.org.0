Return-Path: <linux-pci+bounces-16877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F709CDFB0
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 14:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47793B21568
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 13:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CE01B6CE0;
	Fri, 15 Nov 2024 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqRWThO4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C09452F71
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731676550; cv=none; b=KstfEB+cyCc7RenOy+JlXeSxf60qoQ4GW11RtcWxXI+Ll4JJPQkyveYAHXPOl2mGIitWc0k7w9I/2uQSnyx+fVeq2PGqzu6WqzrEPSzUb4lhujhcwbqv/uo16WpB06x2WhiFZ16HHxglI0Uwx5eXZRxU0dByT6E1o23iEUfRa2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731676550; c=relaxed/simple;
	bh=70ptQYo30UwVusaCHZRa/EN+gh7OcDEFJVb5k9kd/W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiW85Hg03Wsiz6CtSXOmbBINYAhe3dE0mUKrI/oJGuvB3CwgLA1bBlEHnU1dteI77tJL2/5XuIlw0EA5fD6oJz7qaxZCEHMDji8NI667po9wV0+J5AGAhkhGXdKybRSc7JfCOcnYs92XTST91ZwIvuqD7m6KvE3N5Jl/Y9GrGCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqRWThO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4795C4CECF;
	Fri, 15 Nov 2024 13:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731676549;
	bh=70ptQYo30UwVusaCHZRa/EN+gh7OcDEFJVb5k9kd/W8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PqRWThO4yBC11BlqCVLdvCdiqntr2dtVg/ncjFDMvzDXzSMfdrNqx6YfIslFKNN+Y
	 0taDWV3MkBOsEZJn2Hq93JcBQ5L/EguelK7R/c6ye/N6bJwLFIKFZ1tAXovsdR55QR
	 Qg+hVCXH6nmQi4t9nyJtCIU2jWY3zUrsJ72DWfdI0CSpiVwI4oYgxW+NPX2Div5FA1
	 Z4oU/RwvHbVlBjkC562ZQwZh9wbMkcyaqCCjXUFcaQ/LxAE8gTOo72U9V2cb9Kbtuk
	 u9D12+eeLHqFr7hWWMWy9LW/82SL6w7jBGbCaAo12g4sc3p+Hqz1gYudvh+jSfXM6n
	 bR5s+IFutX9oQ==
Date: Fri, 15 Nov 2024 14:15:45 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/4] PCI: mediatek-gen3: Move reset/assert callbacks
 in .power_up()
Message-ID: <ZzdJgeX2dp_z1QmJ@lore-rh-laptop>
References: <20241109-pcie-en7581-fixes-v2-0-0ea3a4af994f@kernel.org>
 <20241109-pcie-en7581-fixes-v2-3-0ea3a4af994f@kernel.org>
 <20241115090231.nwmxl6acspxqflpc@thinkpad>
 <ZzcRG3OInXZ2TP-Z@lore-rh-laptop>
 <20241115123707.in4x27ub4wtwdggh@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Az29kcYdHjsISUBm"
Content-Disposition: inline
In-Reply-To: <20241115123707.in4x27ub4wtwdggh@thinkpad>


--Az29kcYdHjsISUBm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 15, Manivannan Sadhasivam wrote:
> On Fri, Nov 15, 2024 at 10:15:07AM +0100, Lorenzo Bianconi wrote:
> > > On Sat, Nov 09, 2024 at 10:28:39AM +0100, Lorenzo Bianconi wrote:
> > > > In order to make the code more readable, move phy and mac reset lin=
es
> > > > assert/de-assert configuration in .power_up() callback
> > > > (mtk_pcie_en7581_power_up()/mtk_pcie_power_up()).
> > > >=20
> > >=20
> > > I don't understand how moving the code (duplicting it also) makes the=
 code more
> > > readable. Could you please explain?
> >=20
> > Hi Manivannan,
> >=20
> > this has been requested by Bjorn in
> > https://patchwork.kernel.org/project/linux-pci/patch/aca00bd672ee576ad9=
6d279414fc0835ff31f637.1720022580.git.lorenzo@kernel.org/#26110282
> >=20
>=20
> Ok. The description needs to state the reason i.e., the
> reset_control_bulk_assert() is moved to make it pair with
> reset_control_bulk_deassert() in mtk_pcie_setup() and
> mtk_pcie_en7581_power_up().

ack, I will update the commit log.

>=20
> Btw, could you explain why reset_control_bulk_deassert() is present in
> mtk_pcie_setup()?

it is because the clock is shared for Airoha EN7581 and we need to be sure
rstc->deassert_count is not 0 running reset_control_bulk_assert().

https://github.com/torvalds/linux/blob/master/drivers/reset/core.c#L483

Regards,
Lorenzo

>=20
> - Mani
>=20
> > >=20
> > > > Introduce PCIE_MTK_RESET_TIME_US macro for the time needed to
> > > > complete PCIe reset on MediaTek controller.
> > > >=20
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > >  drivers/pci/controller/pcie-mediatek-gen3.c | 28 +++++++++++++++++=
+++--------
> > > >  1 file changed, 20 insertions(+), 8 deletions(-)
> > > >=20
> > > > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/=
pci/controller/pcie-mediatek-gen3.c
> > > > index 8c8c733a145634cdbfefd339f4a692f25a6e24de..1ad93d2407810ba873d=
9a16da96208b3cc0c3011 100644
> > > > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > > > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > > > @@ -120,6 +120,9 @@
> > > > =20
> > > >  #define MAX_NUM_PHY_RESETS		3
> > > > =20
> > > > +/* Time in us needed to complete PCIe reset on MediaTek controller=
 */
> > >=20
> > > No need of this comment. Macro name itself is explanatory.
> >=20
> > ack, I will fix it.
> >=20
> > Regards,
> > Lorenzo
> >=20
> > >=20
> > > - Mani
> > >=20
> > > > +#define PCIE_MTK_RESET_TIME_US		10
> > > > +
> > > >  /* Time in ms needed to complete PCIe reset on EN7581 SoC */
> > > >  #define PCIE_EN7581_RESET_TIME_MS	100
> > > > =20
> > > > @@ -867,6 +870,14 @@ static int mtk_pcie_en7581_power_up(struct mtk=
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
> > > > @@ -941,6 +952,15 @@ static int mtk_pcie_power_up(struct mtk_gen3_p=
cie *pcie)
> > > >  	struct device *dev =3D pcie->dev;
> > > >  	int err;
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
> > > > +	usleep_range(PCIE_MTK_RESET_TIME_US, 2 * PCIE_MTK_RESET_TIME_US);
> > > > +
> > > >  	/* PHY power on and enable pipe clock */
> > > >  	err =3D reset_control_bulk_deassert(pcie->soc->phy_resets.num_res=
ets, pcie->phy_resets);
> > > >  	if (err) {
> > > > @@ -1013,14 +1033,6 @@ static int mtk_pcie_setup(struct mtk_gen3_pc=
ie *pcie)
> > > >  	 * counter since the bulk is shared.
> > > >  	 */
> > > >  	reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets, pci=
e->phy_resets);
> > > > -	/*
> > > > -	 * The controller may have been left out of reset by the bootload=
er
> > > > -	 * so make sure that we get a clean start by asserting resets her=
e.
> > > > -	 */
> > > > -	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets, pcie-=
>phy_resets);
> > > > -
> > > > -	reset_control_assert(pcie->mac_reset);
> > > > -	usleep_range(10, 20);
> > > > =20
> > > >  	/* Don't touch the hardware registers before power up */
> > > >  	err =3D pcie->soc->power_up(pcie);
> > > >=20
> > > > --=20
> > > > 2.47.0
> > > >=20
> > >=20
> > > --=20
> > > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D
>=20
>=20
>=20
> --=20
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

--Az29kcYdHjsISUBm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZzdJfgAKCRA6cBh0uS2t
rAc+AP9ub7dajbYVmtXzENOojOgxYKgGlbym8v7JFbk2MDEf7AEA72IU0ALoGmk1
Uh4ep6rnZJgFC0aB3YAo3lXmumLpxww=
=VKZA
-----END PGP SIGNATURE-----

--Az29kcYdHjsISUBm--

