Return-Path: <linux-pci+bounces-16177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6347F9BF964
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 23:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4B01F225ED
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 22:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA8B1DDC33;
	Wed,  6 Nov 2024 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ejqg1IDH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5AA1917F3;
	Wed,  6 Nov 2024 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730932831; cv=none; b=M3vcjkTSm/oxqaM/nWvv2ux0/fpsMAfWvLlK1kI33ERXb2JybSOaKFcBdxLZYtB0YjTzyLfvy+XeWl540fTuzVCKME90sFwzGtNZkWranLI6g1tPdGbHlWzaEof1c9yRD0NaHS48c4vlGBbhawy928PDUSXXwAy9GxIQ5S1rRvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730932831; c=relaxed/simple;
	bh=zlGCzVAGRGtkQDBPcQQg/UhnzVd+u1CKmbHht0FUdm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2Amll/nbhlOSPk3jPt7mrw8Yp068AFkycrxLzuT8jm/su12/Z69ztsSDtubpX460UeUg0Xk+KDPenax6sf+owHVrwhaEStJt0ei7ropUCeSU0ecRCpAS1PBM7mpHL7LpWGBRxY09E6U7VDi3Rc5ClAKZCGkRLdX5SolLZCYkME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ejqg1IDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94ADC4CECD;
	Wed,  6 Nov 2024 22:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730932831;
	bh=zlGCzVAGRGtkQDBPcQQg/UhnzVd+u1CKmbHht0FUdm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ejqg1IDHwzlcXm+gTVfHyG/fH9dn2aye1emFSVwYUpLaRVBns6ZFdN+jTqji92nya
	 wNQ8OtReYzup80Z6PZqSGQrtWd5UQzSLLE20QAcOrK8hj36qEdKBDwf+F5g45svYtZ
	 iJeMOJ19xgjWFFl2DmzcFcGF2pMeb/wBmIvFyFDK770WA4yBTnl7QWhm7sRWWLgZ9p
	 46AHtzrmU3TgQdA+CkQnW9tLM7ai2LBbo+FCgDYU3HG2Q/v+6dQQ6kln27zonzGsOr
	 B3URqqckrkan9d5iqjFR2+Jas0sW+GHEmAVYWMXYXtGXMyrbGyd+K+faKSkFK/oP7m
	 u1um5ZFqX0uQg==
Date: Wed, 6 Nov 2024 23:40:28 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com,
	linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v4 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
Message-ID: <ZyvwXHMRz0kI0J5O@lore-desk>
References: <aca00bd672ee576ad96d279414fc0835ff31f637.1720022580.git.lorenzo@kernel.org>
 <20241106203219.GA1530199@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ICCrOV43i12jfSvz"
Content-Disposition: inline
In-Reply-To: <20241106203219.GA1530199@bhelgaas>


--ICCrOV43i12jfSvz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Jul 03, 2024 at 06:12:44PM +0200, Lorenzo Bianconi wrote:
> > Introduce support for Airoha EN7581 PCIe controller to mediatek-gen3
> > PCIe controller driver.
> > ...
>=20
> > +static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
> > +{
> > +	struct device *dev =3D pcie->dev;
> > +	int err;
> > +	u32 val;
> > +
> > +	/*
> > +	 * Wait for the time needed to complete the bulk assert in
> > +	 * mtk_pcie_setup for EN7581 SoC.
> > +	 */
> > +	mdelay(PCIE_EN7581_RESET_TIME_MS);

Hi Bjorn,

>=20
> It looks wrong to me to do the assert and deassert in different
> places:
>=20
>   mtk_pcie_setup
>     reset_control_bulk_assert(pcie->phy_resets)        <--
>     mtk_pcie_en7581_power_up
>       mdelay(PCIE_EN7581_RESET_TIME_MS)
>       reset_control_bulk_deassert(pcie->phy_resets)    <--
>       mdelay(PCIE_EN7581_RESET_TIME_MS)
>=20
> That makes the code hard to understand.

The phy reset line was already asserted running reset_control_assert() in
mtk_pcie_setup() and de-asserted running reset_control_deassert() in
mtk_pcie_power_up() before adding EN7581 support. Moreover, EN7581 requires
to run phy_init()/phy_power_on() before de-asserting the phy reset lines.
I guess I can add a comment to make it more clear. Agree?

>=20
> > +	err =3D phy_init(pcie->phy);
> > +	if (err) {
> > +		dev_err(dev, "failed to initialize PHY\n");
> > +		return err;
> > +	}
> > +
> > +	err =3D phy_power_on(pcie->phy);
> > +	if (err) {
> > +		dev_err(dev, "failed to power on PHY\n");
> > +		goto err_phy_on;
> > +	}
> > +
> > +	err =3D reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets,=
 pcie->phy_resets);
> > +	if (err) {
> > +		dev_err(dev, "failed to deassert PHYs\n");
> > +		goto err_phy_deassert;
> > +	}
> > +
> > +	/*
> > +	 * Wait for the time needed to complete the bulk de-assert above.
> > +	 * This time is specific for EN7581 SoC.
> > +	 */
> > +	mdelay(PCIE_EN7581_RESET_TIME_MS);
> > +
> > +	pm_runtime_enable(dev);
> > +	pm_runtime_get_sync(dev);
> > +
>=20
> > +	err =3D clk_bulk_prepare(pcie->num_clks, pcie->clks);
> > +	if (err) {
> > +		dev_err(dev, "failed to prepare clock\n");
> > +		goto err_clk_prepare;
> > +	}
> > +
> > +	val =3D FIELD_PREP(PCIE_VAL_LN0_DOWNSTREAM, 0x47) |
> > +	      FIELD_PREP(PCIE_VAL_LN1_DOWNSTREAM, 0x47) |
> > +	      FIELD_PREP(PCIE_VAL_LN0_UPSTREAM, 0x41) |
> > +	      FIELD_PREP(PCIE_VAL_LN1_UPSTREAM, 0x41);
> > +	writel_relaxed(val, pcie->base + PCIE_EQ_PRESET_01_REG);
> > +
> > +	val =3D PCIE_K_PHYPARAM_QUERY | PCIE_K_QUERY_TIMEOUT |
> > +	      FIELD_PREP(PCIE_K_PRESET_TO_USE_16G, 0x80) |
> > +	      FIELD_PREP(PCIE_K_PRESET_TO_USE, 0x2) |
> > +	      FIELD_PREP(PCIE_K_FINETUNE_MAX, 0xf);
> > +	writel_relaxed(val, pcie->base + PCIE_PIPE4_PIE8_REG);
>=20
> Why is this equalization stuff in the middle between
> clk_bulk_prepare() and clk_bulk_enable()?  Is the split an actual
> requirement, or could we use clk_bulk_prepare_enable() here, like we
> do in mtk_pcie_power_up()?

Nope, we can replace clk_bulk_enable() with clk_bulk_prepare_enable() and
remove clk_bulk_prepare() in mtk_pcie_en7581_power_up() since we actually
implements just enable callback for EN7581 in clk-en7523.c.

>=20
> If the split is required, a comment about why would be helpful.
>=20
> > +	err =3D clk_bulk_enable(pcie->num_clks, pcie->clks);
> > +	if (err) {
> > +		dev_err(dev, "failed to prepare clock\n");
> > +		goto err_clk_enable;
> > +	}
>=20
> Per https://lore.kernel.org/r/ZypgYOn7dcYIoW4i@lore-desk,
> REG_PCI_CONTROL is asserted/deasserted here by en7581_pci_enable().

correct

>=20
> Is this where PERST# is asserted?  If so, a comment to that effect
> would be helpful.  Where is PERST# deasserted?  Where are the required
> delays before deassert done?

I can add a comment in en7581_pci_enable() describing the PERST issue for
EN7581. Please note we have a 250ms delay in en7581_pci_enable() after
configuring REG_PCI_CONTROL register.

https://github.com/torvalds/linux/blob/master/drivers/clk/clk-en7523.c#L396

Regards,
Lorenzo

>=20
> Bjorn

--ICCrOV43i12jfSvz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZyvwXAAKCRA6cBh0uS2t
rEp6AQCtSYy3YAUzds8hvCM6UpvkI2xTYG22JsIAv0MIYQIuXgEA0T+smyZrSC8l
SWuzngL5C7nN60iXccYVAU+/Lr2MsAs=
=FAIL
-----END PGP SIGNATURE-----

--ICCrOV43i12jfSvz--

