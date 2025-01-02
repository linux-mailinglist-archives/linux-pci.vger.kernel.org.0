Return-Path: <linux-pci+bounces-19158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80309FF8B8
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 12:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD187A15B7
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 11:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FC118FDB2;
	Thu,  2 Jan 2025 11:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2ePCEQB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E3B22083
	for <linux-pci@vger.kernel.org>; Thu,  2 Jan 2025 11:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735817360; cv=none; b=BOGuQvDIgCSgMlx/2EjXqGOw0UlJLMqoR4Mcm7ZxuuQ8pi7AwlNDEwXBQe71+3TYoAOVnWUGxaE+SK80S6c+5QnqqIuzluZ6VSYNzXyaUtIZio5Eh1E8Tgg8KjxEpm/JP/HUgF5gxtHB0fXSvSnCOQ6lDnPHwpQ0SRm7Sxh16rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735817360; c=relaxed/simple;
	bh=BsVLFIudwmLHKq9cvrX81yCcvG7hbmBcBnWpo5dVIeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXT+o6256ACtAiCFFyKD52EkzxXvGzeWkRi8VZ5NMpFt8SMlBtRsIlLfg9mmkBZ/otTucu/cbyqmrMTlDSGXsioJYZNElzqSRRMLFgKBNbFaAJyr1MGfzlRcbbe0iG9MSqnyoEB5qWLJxAHME7W+ewKCgDhRFGCScFsQTwuvXP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2ePCEQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B557C4CED0;
	Thu,  2 Jan 2025 11:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735817360;
	bh=BsVLFIudwmLHKq9cvrX81yCcvG7hbmBcBnWpo5dVIeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y2ePCEQBPzD3S5N1O65KL4gEe1CJVZTgG1HFFy0f0TO44O+gA5C6BkhshJdnfcCeZ
	 gzwTM0K/PmRf3Y4WxcbR0ynXEZImUqn49SZGGuDA9vYGP6jcfQqXaRaJOaM3hKjmuX
	 5Ah+//iGBjGv2QaN3dHdj/QUpB9Yide4n3tD+WLWl2sN04bo0cOwUSPFo4Xf8ry7gO
	 ukg3fcFozaBglJN7x9o0SsQuC2+ZLv0oJZz4qayha+n3ZkG1aup7R/+x+wUaDIqse7
	 PyoPeSBXr/FieykEYc+jJUQL8dDQlQ/3RXtiiCu8XdfY8Kl6Z6Hp8idWEwm/R2SE2s
	 lzIV5iYOzjxAw==
Date: Thu, 2 Jan 2025 12:29:17 +0100
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
Subject: Re: [PATCH v3] PCI: mediatek-gen3: Avoid PCIe resetting via
 PCIE_RSTB for Airoha EN7581 SoC
Message-ID: <Z3Z4jcwtgcXk9Zo6@lore-desk>
References: <20241113-pcie-en7581-rst-fix-v3-1-23c5082335f7@kernel.org>
 <20241230185810.GA3960934@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PirDLZErFthZy50t"
Content-Disposition: inline
In-Reply-To: <20241230185810.GA3960934@bhelgaas>


--PirDLZErFthZy50t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Nov 13, 2024 at 02:58:08PM +0100, Lorenzo Bianconi wrote:
> > Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
> > causing occasional PCIe link down issues. In order to overcome the
> > problem, PCIE_RSTB signals are not asserted/released during device prob=
e or
> > suspend/resume phase and the PCIe block is reset using REG_PCI_CONTROL
> > (0x88) and REG_RESET_CONTROL (0x834) registers available in the clock
> > module running clk_bulk_prepare_enable in mtk_pcie_en7581_power_up().
> >=20
> > Introduce flags field in the mtk_gen3_pcie_pdata struct in order to
> > specify per-SoC capabilities.

Hi Bjorn,

similar to the other series, this patch is already in Krzysztof's branch.
Do you prefer to resend it or just incremental changes?

>=20
> Is there a URL or some other way to cite erratum documentation for
> this?
>=20
> > Tested-by: Hui Ma <hui.ma@airoha.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > Changes in v3:
> > - cosmetics
> > - Link to v2: https://lore.kernel.org/r/20241104-pcie-en7581-rst-fix-v2=
-1-ffe5839c76d8@kernel.org
> >=20
> > Changes in v2:
> > - introduce flags field in mtk_gen3_pcie_flags struct instead of adding
> >   reset callback
> > - fix the leftover case in mtk_pcie_suspend_noirq routine
> > - add more comments
> > - Link to v1: https://lore.kernel.org/r/20240920-pcie-en7581-rst-fix-v1=
-1-1043fb63ffc9@kernel.org
> > ---
> >  drivers/pci/controller/pcie-mediatek-gen3.c | 60 ++++++++++++++++++++-=
--------
> >  1 file changed, 42 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/=
controller/pcie-mediatek-gen3.c
> > index 16a55711a7f3bdc8d6620029e3d2cfdd40b537b7..443072adb9b52a6934a5d1e=
38eb6fca5f86a1e13 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -128,10 +128,18 @@
> > =20
> >  struct mtk_gen3_pcie;
> > =20
> > +enum mtk_gen3_pcie_flags {
> > +	SKIP_PCIE_RSTB	=3D BIT(0), /* skip PCIE_RSTB signals configuration
> > +				   * during device probing or suspend/resume
> > +				   * phase in order to avoid hw bugs/issues.
>=20
> Maybe "Skip PERST# assertion"?
>=20
> s/in order to/to/

ack, I will fix it.

>=20
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
> > @@ -139,6 +147,7 @@ struct mtk_gen3_pcie_pdata {
> >  		const char *id[MAX_NUM_PHY_RESETS];
> >  		int num_resets;
> >  	} phy_resets;
> > +	u32 flags;
> >  };
> > =20
> >  /**
> > @@ -405,22 +414,34 @@ static int mtk_pcie_startup_port(struct mtk_gen3_=
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
> > +	 * PCIe block is reset configuting REG_PCI_CONTROL (0x88) and
>=20
> s/configuting/configuring/
>=20
> "... is reset configuring ..." doesn't read smoothly.  Maybe "reset
> *using*" or similar?  (I guess "reset using" is what you wrote in the
> commit log.)
>=20
> I think if you mention the name of the en7581 clk function, that would
> be enough, and we wouldn't need the register names, offsets, and
> "available in the clock module".

ack, I will fix it.

>=20
> > +	 * REG_RESET_CONTROL (0x834) registers available in the clock module
> > +	 * running clk_bulk_prepare_enable in mtk_pcie_en7581_power_up().
>=20
> Mention the en7581 clk function, not the generic
> clk_bulk_prepare_enable().  It's hard to get from generic to specific.

ack, I will fix it.

>=20
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
> Add PCIe CEM spec revision, since section numbers may change between
> revisions.  I know you're just moving it, but this is a good chance to
> fix this.

ack, I will fix it.
>=20
> Add blank lines between paragraphs.

ack, I will fix it.
>=20
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
> > @@ -1179,10 +1200,12 @@ static int mtk_pcie_suspend_noirq(struct device=
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
>=20
> s/Pull down .../Assert PERST#/ to match other comments above

ack, I will fix it.

Regards,
Lorenzo

>=20
> > +		val =3D readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> > +		val |=3D PCIE_PE_RSTB;
> > +		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > +	}
> > =20
> >  	dev_dbg(pcie->dev, "entered L2 states successfully");
> > =20
> > @@ -1233,6 +1256,7 @@ static const struct mtk_gen3_pcie_pdata mtk_pcie_=
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
> > base-commit: ff80d707f3cb5e8d9ec0739e0e5ed42dea179125
> > change-id: 20240920-pcie-en7581-rst-fix-8161658c13c4
> >=20
> > Best regards,
> > --=20
> > Lorenzo Bianconi <lorenzo@kernel.org>
> >=20

--PirDLZErFthZy50t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ3Z4jQAKCRA6cBh0uS2t
rCBXAQD3SD0oUw2ZZBP3AmWa2bTIzKpw1gIB/7KUaZnNoTJLhQEAmhqyCsWcYPH+
Nwes+DolAqE6JtE58jfEYgzTTYMM7ww=
=qzLh
-----END PGP SIGNATURE-----

--PirDLZErFthZy50t--

