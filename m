Return-Path: <linux-pci+bounces-16068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF7A9BD44F
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 19:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92DD61C22FF3
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 18:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC20F17BEB7;
	Tue,  5 Nov 2024 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqSCKavn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70AD4D8D0
	for <linux-pci@vger.kernel.org>; Tue,  5 Nov 2024 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730830435; cv=none; b=rL6qCcKP+XMNDxan/HQbQWCAV4aYsxxjIQ4tBjLelR/UxohrWGSpTGpnWo2X44J0NRlnSt7BKD6CmRka/GWpzjZ8QCXSBDJLyh7+wJI1/dVVRk/vj33k+r9nxICi9p8z9Z29R1pxRFujmkmFBxXjOyugZ1pG2RqGL76aKmWNBrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730830435; c=relaxed/simple;
	bh=Xen1diBQCGTGkPai9ifyoSgzJwfYP1crTTlWxSXYi88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0i4gjqoXw/h0PrSL7mUu5PJcHpgDE8zIok9V0CSib+oAnu4Y4i64NOFZkrNBRG5zzKjzzZoaNAoBeiIO1k9Am/AmsMTD+8G2bwZcMBofc+ozuMHqQfDVlwVn/x8obSqe5ADGQHC84q98vRrvyoqaSWnWxdEkFkeJDH2XKf7JaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqSCKavn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD60C4CED1;
	Tue,  5 Nov 2024 18:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730830435;
	bh=Xen1diBQCGTGkPai9ifyoSgzJwfYP1crTTlWxSXYi88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SqSCKavngCVgtakBFoK/QNvcJ95y8UC2eRzb2nESbNueDZokzXwbZhNU6eXkXGDIE
	 PmbAaOwf33zXa3RPAIQnzyiJ/RiZlzbVC8kX/ByVVWiUEFrmMENr1ZX06kWa3OFlg7
	 Dxy3Zp/ruYbsfdTCbPXEoHeuxSMzhwAASoZQsAD0LDuFY37y2oDkVl1cjET1dPJl3e
	 fnnWCUK7WOyKctQABU15LbyG4ZhFemim+6MEvOW22b9MnmvDzR93XHU/oPnWhfVZmZ
	 HjVV7nGe3krmgq14Iv5e6kwqk/FdaL1XQuitcu87xe1YT4s9mi1uK45zfPkinl4CBy
	 Scj+bvKXgmu7w==
Date: Tue, 5 Nov 2024 19:13:52 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
	Hui Ma <hui.ma@airoha.com>
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Avoid PCIe resetting via
 PCIE_RSTB for Airoha EN7581 SoC
Message-ID: <ZypgYOn7dcYIoW4i@lore-desk>
References: <20241104-pcie-en7581-rst-fix-v2-1-ffe5839c76d8@kernel.org>
 <20241105172254.GA1447085@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vqWK8aRdzgQTTEkC"
Content-Disposition: inline
In-Reply-To: <20241105172254.GA1447085@bhelgaas>


--vqWK8aRdzgQTTEkC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Nov 04, 2024 at 11:00:05PM +0100, Lorenzo Bianconi wrote:
> > Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
> > causing occasional PCIe link down issues. In order to overcome the
> > problem, PCIE_RSTB signals are not asserted/released during device prob=
e or
> > suspend/resume phase and the PCIe block is reset using REG_PCI_CONTROL
> > (0x88) and REG_RESET_CONTROL (0x834) registers available via the clock
> > module.
> > Introduce flags field in the mtk_gen3_pcie_pdata struct in order to
> > specify per-SoC capabilities.
>=20
> Add blank lines between paragraphs so we know where they end.

ack, I will fix it in v2.

>=20
> Where does this alternate way of doing reset (using REG_PCI_CONTROL
> and REG_RESET_CONTROL) happen?  Why isn't there something in this
> patch to use that alternate method at the same points where
> PCIE_PE_RSTB is used?

REG_RESET_CONTROL (0x834) is already asserted/released in the following flo=
w:

mtk_pcie_en7581_power_up() -> reset_control_bulk_deassert() -> en7523_reset=
_update()
https://github.com/torvalds/linux/blob/master/drivers/clk/clk-en7523.c#L470

REG_PCI_CONTROL (0x88) is already asserted/released in the following flow:
mtk_pcie_en7581_power_up() -> clk_bulk_enable() -> en7581_pci_enable()
https://github.com/torvalds/linux/blob/master/drivers/clk/clk-en7523.c#L385


>=20
> If we don't need to assert reset for Airoha EN7581, why do we need to
> do it for the other SoCs?

I guess the other SoCs (mtk ones) do not have the same hw issue with
PCIE_PE_RSTB (but I am not sure about it).

Regards,
Lorenzo

>=20
> > Tested-by: Hui Ma <hui.ma@airoha.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > Changes in v2:
> > - introduce flags field in mtk_gen3_pcie_flags struct instead of adding
> >   reset callback
> > - fix the leftover case in mtk_pcie_suspend_noirq routine
> > - add more comments
> > - Link to v1: https://lore.kernel.org/r/20240920-pcie-en7581-rst-fix-v1=
-1-1043fb63ffc9@kernel.org
> > ---
> >  drivers/pci/controller/pcie-mediatek-gen3.c | 59 ++++++++++++++++++++-=
--------
> >  1 file changed, 41 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/=
controller/pcie-mediatek-gen3.c
> > index 66ce4b5d309bb6d64618c70ac5e0a529e0910511..8e4704ff3509867fc0ff799=
e9fb99e71e46756cd 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -125,10 +125,18 @@
> > =20
> >  struct mtk_gen3_pcie;
> > =20
> > +enum mtk_gen3_pcie_flags {
> > +	SKIP_PCIE_RSTB	=3D BIT(0), /* skip PCIE_RSTB signals configuration
> > +				   * during device probing or suspend/resume
> > +				   * phase in order to avoid hw bugs/issues.
> > +				   */
> > +};
> > +
> >  /**
> >   * struct mtk_gen3_pcie_pdata - differentiate between host generations
> >   * @power_up: pcie power_up callback
> >   * @phy_resets: phy reset lines SoC data.
> > + * @flags: pcie device flags.
> >   */
> >  struct mtk_gen3_pcie_pdata {
> >  	int (*power_up)(struct mtk_gen3_pcie *pcie);
> > @@ -136,6 +144,7 @@ struct mtk_gen3_pcie_pdata {
> >  		const char *id[MAX_NUM_PHY_RESETS];
> >  		int num_resets;
> >  	} phy_resets;
> > +	u32 flags;
> >  };
> > =20
> >  /**
> > @@ -402,22 +411,33 @@ static int mtk_pcie_startup_port(struct mtk_gen3_=
pcie *pcie)
> >  	val |=3D PCIE_DISABLE_DVFSRC_VLT_REQ;
> >  	writel_relaxed(val, pcie->base + PCIE_MISC_CTRL_REG);
> > =20
> > -	/* Assert all reset signals */
> > -	val =3D readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> > -	val |=3D PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
> > -	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > -
> >  	/*
> > -	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal)
> > -	 * and 2.2.1 (Initial Power-Up (G3 to S0)).
> > -	 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
> > -	 * for the power and clock to become stable.
> > +	 * Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
> > +	 * causing occasional PCIe link down. In order to overcome the issue,
> > +	 * PCIE_RSTB signals are not asserted/released at this stage and the
> > +	 * PCIe block is reset using REG_PCI_CONTROL (0x88) and
> > +	 * REG_RESET_CONTROL (0x834) registers available via the clock module.
> >  	 */
> > -	msleep(100);
> > -
> > -	/* De-assert reset signals */
> > -	val &=3D ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RS=
TB);
> > -	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > +	if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
> > +		/* Assert all reset signals */
> > +		val =3D readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> > +		val |=3D PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
> > +		       PCIE_PE_RSTB;
> > +		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > +
> > +		/*
> > +		 * Described in PCIe CEM specification sections 2.2 (PERST# Signal)
> > +		 * and 2.2.1 (Initial Power-Up (G3 to S0)).
> > +		 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
> > +		 * for the power and clock to become stable.
>=20
> Blank line between paragraphs.
>=20
> > +		 */
> > +		msleep(PCIE_T_PVPERL_MS);
> > +
> > +		/* De-assert reset signals */
> > +		val &=3D ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
> > +			 PCIE_PE_RSTB);
> > +		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > +	}
> > =20
> >  	/* Check if the link is up or not */
> >  	err =3D readl_poll_timeout(pcie->base + PCIE_LINK_STATUS_REG, val,
> > @@ -1160,10 +1180,12 @@ static int mtk_pcie_suspend_noirq(struct device=
 *dev)
> >  		return err;
> >  	}
> > =20
> > -	/* Pull down the PERST# pin */
> > -	val =3D readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> > -	val |=3D PCIE_PE_RSTB;
> > -	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > +	if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
> > +		/* Pull down the PERST# pin */
> > +		val =3D readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> > +		val |=3D PCIE_PE_RSTB;
> > +		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > +	}
> > =20
> >  	dev_dbg(pcie->dev, "entered L2 states successfully");
> > =20
> > @@ -1214,6 +1236,7 @@ static const struct mtk_gen3_pcie_pdata mtk_pcie_=
soc_en7581 =3D {
> >  		.id[2] =3D "phy-lane2",
> >  		.num_resets =3D 3,
> >  	},
> > +	.flags =3D SKIP_PCIE_RSTB,
> >  };
> > =20
> >  static const struct of_device_id mtk_pcie_of_match[] =3D {
> >=20
> > ---
> > base-commit: 3102ce10f3111e4c3b8fb233dc93f29e220adaf7
> > change-id: 20240920-pcie-en7581-rst-fix-8161658c13c4
> >=20
> > Best regards,
> > --=20
> > Lorenzo Bianconi <lorenzo@kernel.org>
> >=20

--vqWK8aRdzgQTTEkC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZypgYAAKCRA6cBh0uS2t
rPhYAP9axhSDdzxRbZRh8iXInGX5fkpcShFz0VS//r43s9MZfgEAoiTiyWcze16t
KArG5YUlc0vzQp3pjMwBStrRVcFhVQA=
=qiMV
-----END PGP SIGNATURE-----

--vqWK8aRdzgQTTEkC--

