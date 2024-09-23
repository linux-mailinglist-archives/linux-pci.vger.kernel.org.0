Return-Path: <linux-pci+bounces-13394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90E1983918
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 23:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0314FB20BF0
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 21:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F032678C73;
	Mon, 23 Sep 2024 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZBBLzsn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B273F9D5
	for <linux-pci@vger.kernel.org>; Mon, 23 Sep 2024 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727126961; cv=none; b=XDoo0x0gzqPD5L6WtfSz7dMZ0MCff2tvbh85PhTjR3FUTihXWx27ahckSAQRBwNMJ7EpH8twR2DKgJhGWNUbxRYwVbhL4cDpmrua5vp+VBZtfFzh29ghpqTih0Bae8NdoSX8AZL8dW1YotkRlzB/g0todVx0oRBG+YRKx9a04bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727126961; c=relaxed/simple;
	bh=aPsXlsQTc4iQomHCqP6FGAc3aR0AhJ/h9kmcL5q8DMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjUoCzfX45qITj+srWlo8ZwLfUP8qp2CZkch++EdsDVI2/PI6lOlmQ7YOfsKoSfnF94RmbBOsYH10Zj7Y/B4Hm/YzxEBngWrSG//c8HWHKH5fEDJv9bCXtuY6GW+Ens/lG8dlpzluns47oCcg4h3nR0CaoB8/cO/hn0RK5IL5NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZBBLzsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8551C4CEC4;
	Mon, 23 Sep 2024 21:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727126961;
	bh=aPsXlsQTc4iQomHCqP6FGAc3aR0AhJ/h9kmcL5q8DMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pZBBLzsnMF6VS0JNZsP3ofiiVwXFaZtz84STcAEp+Xv/m3w39J39wh4dpHhrPsoGU
	 NRGrrev2gSKkyM08YBIpjf5+KRcDD2ZKFLOz0yRhHZ9cRzp30aLb/U0H0L/ZwTSyg1
	 NJzxxGp5v/GqYyYY34E2dPdLH6hDPnQCCQq/RYw28hJcGSCRAD3tYbr8alBpnosMe4
	 H9qHnUxNoNtGmcaTCHtUoHKCqn3lRaR561QimVpdE2xqeiKOo4DsemGjdJxP2lPP1r
	 vyf8qu3GiTzlkOiOZRetxMjXjDyC2tng226uUnKUrnCm7l2hqoAkEdH11Ewh9Nn6cI
	 tqmnHk5YiDaDg==
Date: Mon, 23 Sep 2024 23:29:18 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
	Hui Ma <hui.ma@airoha.com>
Subject: Re: [PATCH] PCI: mediatek-gen3: Avoid PCIe resetting for Airoha
 EN7581 SoC
Message-ID: <ZvHdrsx0PZhKWU_6@lore-desk>
References: <20240920-pcie-en7581-rst-fix-v1-1-1043fb63ffc9@kernel.org>
 <20240923171041.GA1158802@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CeZNBjXD8FkiuUtc"
Content-Disposition: inline
In-Reply-To: <20240923171041.GA1158802@bhelgaas>


--CeZNBjXD8FkiuUtc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, Sep 20, 2024 at 10:26:28AM +0200, Lorenzo Bianconi wrote:
> > The PCIe controller available on the EN7581 SoC does not support reset
> > via the following lines:
> > - PCIE_MAC_RSTB
> > - PCIE_PHY_RSTB
> > - PCIE_BRG_RSTB
> > - PCIE_PE_RSTB
> >=20
> > Introduce the reset callback in order to avoid resetting the PCIe port
> > for Airoha EN7581 SoC.
> >=20
> > Tested-by: Hui Ma <hui.ma@airoha.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/pci/controller/pcie-mediatek-gen3.c | 44 ++++++++++++++++++---=
--------
> >  1 file changed, 28 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/=
controller/pcie-mediatek-gen3.c
> > index 5c19abac74e8..9cea67e92d98 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -128,10 +128,12 @@ struct mtk_gen3_pcie;
> >  /**
> >   * struct mtk_gen3_pcie_pdata - differentiate between host generations
> >   * @power_up: pcie power_up callback
> > + * @reset: pcie reset callback
> >   * @phy_resets: phy reset lines SoC data.
> >   */
> >  struct mtk_gen3_pcie_pdata {
> >  	int (*power_up)(struct mtk_gen3_pcie *pcie);
> > +	void (*reset)(struct mtk_gen3_pcie *pcie);
> >  	struct {
> >  		const char *id[MAX_NUM_PHY_RESETS];
> >  		int num_resets;
> > @@ -373,6 +375,28 @@ static void mtk_pcie_enable_msi(struct mtk_gen3_pc=
ie *pcie)
> >  	writel_relaxed(val, pcie->base + PCIE_INT_ENABLE_REG);
> >  }
> > =20
> > +static void mtk_pcie_reset(struct mtk_gen3_pcie *pcie)
> > +{
> > +	u32 val;
> > +
> > +	/* Assert all reset signals */
> > +	val =3D readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> > +	val |=3D PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
> > +	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > +
> > +	/*
> > +	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal)
> > +	 * and 2.2.1 (Initial Power-Up (G3 to S0)).
> > +	 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
> > +	 * for the power and clock to become stable.
> > +	 */
> > +	msleep(100);
>=20
> I see you're just moving this, but it's a good chance to use
> PCIE_T_PVPERL_MS.

ack, I will add it.

>=20
> > +
> > +	/* De-assert reset signals */
> > +	val &=3D ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RS=
TB);
> > +	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > +}
> > +
> >  static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
> >  {
> >  	struct resource_entry *entry;
> > @@ -402,22 +426,9 @@ static int mtk_pcie_startup_port(struct mtk_gen3_p=
cie *pcie)
> >  	val |=3D PCIE_DISABLE_DVFSRC_VLT_REQ;
> >  	writel_relaxed(val, pcie->base + PCIE_MISC_CTRL_REG);
> > =20
> > -	/* Assert all reset signals */
> > -	val =3D readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> > -	val |=3D PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
> > -	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > -
> > -	/*
> > -	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal)
> > -	 * and 2.2.1 (Initial Power-Up (G3 to S0)).
> > -	 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
> > -	 * for the power and clock to become stable.
> > -	 */
> > -	msleep(100);
> > -
> > -	/* De-assert reset signals */
> > -	val &=3D ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RS=
TB);
> > -	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > +	/* Reset the PCIe port if requested by the hw */
>=20
> I don't see any real "request" from the hardware.  IIUC, this is more
> like "assert reset if this hardware supports it".

ack, %s/requested/supported. I will fix it.

Regards,
Lorenzo

>=20
> > +	if (pcie->soc->reset)
> > +		pcie->soc->reset(pcie);
> > =20
> >  	/* Check if the link is up or not */
> >  	err =3D readl_poll_timeout(pcie->base + PCIE_LINK_STATUS_REG, val,
> > @@ -1207,6 +1218,7 @@ static const struct dev_pm_ops mtk_pcie_pm_ops =
=3D {
> > =20
> >  static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_mt8192 =3D {
> >  	.power_up =3D mtk_pcie_power_up,
> > +	.reset =3D mtk_pcie_reset,
> >  	.phy_resets =3D {
> >  		.id[0] =3D "phy",
> >  		.num_resets =3D 1,
> >=20
> > ---
> > base-commit: f2024903cb387971abdbc6398a430e735a9b394c
> > change-id: 20240920-pcie-en7581-rst-fix-8161658c13c4
> >=20
> > Best regards,
> > --=20
> > Lorenzo Bianconi <lorenzo@kernel.org>
> >=20

--CeZNBjXD8FkiuUtc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZvHdrgAKCRA6cBh0uS2t
rEONAP4qiHrP6to/gC9PCjS4UG9xJ16SJrG/IlXBo0VmZrPJtAD7B2K8bXfQksAS
+/PGKL0/4VYtA7fNZEnlTYRxqoOQVw0=
=OoIH
-----END PGP SIGNATURE-----

--CeZNBjXD8FkiuUtc--

