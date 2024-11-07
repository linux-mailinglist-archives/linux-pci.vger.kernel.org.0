Return-Path: <linux-pci+bounces-16198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3979BFF41
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 08:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F59AB21E0A
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 07:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D63419596F;
	Thu,  7 Nov 2024 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tv5xJKY1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F2D194C6F;
	Thu,  7 Nov 2024 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730965186; cv=none; b=fHU+XVpm0qLqAQciHPMqSb+nV3Pylirp6LH1mck4mrs6MQt2gdh00ylRQlw1KO1hVzzQh3tU5UraNhjCMkAi/hnP6+mSpqO4vfANo6WaRgxLjkwFTG8Cm81/WAfpMgadTEFA+4HmL9ZDy+8CBa5jMa83GqmAFcNm9053oNLxh/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730965186; c=relaxed/simple;
	bh=OF7uVedWDkVcu3u4hTGElGYjTCq1Zh0FZbzgtFlmKS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P65ogPOmWidaLM0cI5yPlYTUfy3mwsbMGtB1Stl26wVME4FqN9irPwD1OaC4mhcn+0+8EMV6SYN4WVEvhJVqpwDEEz0AgvfMlubcAPTNn8YaWVKuPPSj637TZlsalbtYi0yY+/+fNbZsPCL4C5nuwOtsiSV/nzjjrfywInakNzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tv5xJKY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73ADEC4CECC;
	Thu,  7 Nov 2024 07:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730965185;
	bh=OF7uVedWDkVcu3u4hTGElGYjTCq1Zh0FZbzgtFlmKS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tv5xJKY1TeK8ah+qZVYnrRwl4f5IJdTxaXzKHIHq8ciU9e19Xj4NRuXhXM5lj/enN
	 1hX4slCdNIzz/r5/NnZcN5JUo7m+EyRkwhR1bckvSM11waKfz2jGorbJ68RfPMjiUr
	 LP6zp0+XL18V9kN5LpPA8R5WP8yNqLnRFJm0w4e558EobqIh0O7/bcHgqbQ+rWVe3j
	 2JOkvTYIdhh9CKrATFqzUf+tRe4h77jdJkrq4T7voo/VuIHM1KEHholi04OzTGPnwv
	 IUsdfc5mM6vv5ZPmVPxCGvKTFuhczK/tghS8FCpuMtbcUvAjCPehdhm4WtYXavBqXX
	 diL4BYRaaf//A==
Date: Thu, 7 Nov 2024 08:39:43 +0100
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
Message-ID: <Zyxuv-2SPuEXiL5R@lore-desk>
References: <ZyvwXHMRz0kI0J5O@lore-desk>
 <20241106233123.GA1580663@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SkwM6sguX1BTFpU9"
Content-Disposition: inline
In-Reply-To: <20241106233123.GA1580663@bhelgaas>


--SkwM6sguX1BTFpU9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Nov 06, 2024 at 11:40:28PM +0100, Lorenzo Bianconi wrote:
> > > On Wed, Jul 03, 2024 at 06:12:44PM +0200, Lorenzo Bianconi wrote:
> > > > Introduce support for Airoha EN7581 PCIe controller to mediatek-gen3
> > > > PCIe controller driver.
> > > > ...
> > >=20
> > > > +static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
> > > > +{
> > > > +	struct device *dev =3D pcie->dev;
> > > > +	int err;
> > > > +	u32 val;
> > > > +
> > > > +	/*
> > > > +	 * Wait for the time needed to complete the bulk assert in
> > > > +	 * mtk_pcie_setup for EN7581 SoC.
> > > > +	 */
> > > > +	mdelay(PCIE_EN7581_RESET_TIME_MS);
> >=20
> > > It looks wrong to me to do the assert and deassert in different
> > > places:
> > >=20
> > >   mtk_pcie_setup
> > >     reset_control_bulk_assert(pcie->phy_resets)        <--
> > >     mtk_pcie_en7581_power_up
> > >       mdelay(PCIE_EN7581_RESET_TIME_MS)
> > >       reset_control_bulk_deassert(pcie->phy_resets)    <--
> > >       mdelay(PCIE_EN7581_RESET_TIME_MS)
> > >=20
> > > That makes the code hard to understand.
> >=20
> > The phy reset line was already asserted running reset_control_assert() =
in
> > mtk_pcie_setup() and de-asserted running reset_control_deassert() in
> > mtk_pcie_power_up() before adding EN7581 support. Moreover, EN7581 requ=
ires
> > to run phy_init()/phy_power_on() before de-asserting the phy reset line=
s.
> > I guess I can add a comment to make it more clear. Agree?
>=20
> I assume the first deassert(phy_resets) in mtk_pcie_setup() is not
> paired with anything in this driver.

correct

>=20
> I think it would be better to pair the other assert/deasserts in the
> same functions like the below.  Then it's easy to see the matching.

ack, I will post a fix for it

>=20
> While looking at this, I noticed that we assert(mac_reset) in
> mtk_pcie_setup(), but it's never deasserted for EN7581.

ack, I will post a fix for it

>=20
>   mtk_pcie_setup
>     reset_control_bulk_deassert(phy_resets)
>     mtk_pcie_en7581_power_up
>       reset_control_bulk_assert(phy_resets)  # move here
>       reset_control_assert(mac_reset)        # move here
>       mdelay(PCIE_EN7581_RESET_TIME_MS)
>       phy_init
>       phy_power_on
>       reset_control_deassert(mac_reset)      # add; seems missing?
>       reset_control_bulk_deassert(phy_resets)
>       mdelay(PCIE_EN7581_RESET_TIME_MS)
>=20
>   mtk_pcie_setup
>     reset_control_bulk_deassert(phy_resets)
>     mtk_pcie_power_up
>       reset_control_bulk_assert(phy_resets)  # move here
>       reset_control_assert(mac_reset)        # move here
>       reset_control_bulk_deassert(phy_resets)
>       phy_init
>       phy_power_on
>       reset_control_deassert(mac_reset)
>=20
> > > > +	err =3D phy_init(pcie->phy);
> > > > +	if (err) {
> > > > +		dev_err(dev, "failed to initialize PHY\n");
> > > > +		return err;
> > > > +	}
> > > > +
> > > > +	err =3D phy_power_on(pcie->phy);
> > > > +	if (err) {
> > > > +		dev_err(dev, "failed to power on PHY\n");
> > > > +		goto err_phy_on;
> > > > +	}
> > > > +
> > > > +	err =3D reset_control_bulk_deassert(pcie->soc->phy_resets.num_res=
ets, pcie->phy_resets);
> > > > +	if (err) {
> > > > +		dev_err(dev, "failed to deassert PHYs\n");
> > > > +		goto err_phy_deassert;
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * Wait for the time needed to complete the bulk de-assert above.
> > > > +	 * This time is specific for EN7581 SoC.
> > > > +	 */
> > > > +	mdelay(PCIE_EN7581_RESET_TIME_MS);
> > > > +
> > > > +	pm_runtime_enable(dev);
> > > > +	pm_runtime_get_sync(dev);
> > > > +
> > >=20
> > > > +	err =3D clk_bulk_prepare(pcie->num_clks, pcie->clks);
> > > > +	if (err) {
> > > > +		dev_err(dev, "failed to prepare clock\n");
> > > > +		goto err_clk_prepare;
> > > > +	}
> > > > +
> > > > +	val =3D FIELD_PREP(PCIE_VAL_LN0_DOWNSTREAM, 0x47) |
> > > > +	      FIELD_PREP(PCIE_VAL_LN1_DOWNSTREAM, 0x47) |
> > > > +	      FIELD_PREP(PCIE_VAL_LN0_UPSTREAM, 0x41) |
> > > > +	      FIELD_PREP(PCIE_VAL_LN1_UPSTREAM, 0x41);
> > > > +	writel_relaxed(val, pcie->base + PCIE_EQ_PRESET_01_REG);
> > > > +
> > > > +	val =3D PCIE_K_PHYPARAM_QUERY | PCIE_K_QUERY_TIMEOUT |
> > > > +	      FIELD_PREP(PCIE_K_PRESET_TO_USE_16G, 0x80) |
> > > > +	      FIELD_PREP(PCIE_K_PRESET_TO_USE, 0x2) |
> > > > +	      FIELD_PREP(PCIE_K_FINETUNE_MAX, 0xf);
> > > > +	writel_relaxed(val, pcie->base + PCIE_PIPE4_PIE8_REG);
> > >=20
> > > Why is this equalization stuff in the middle between
> > > clk_bulk_prepare() and clk_bulk_enable()?  Is the split an actual
> > > requirement, or could we use clk_bulk_prepare_enable() here, like we
> > > do in mtk_pcie_power_up()?
> >=20
> > Nope, we can replace clk_bulk_enable() with clk_bulk_prepare_enable() a=
nd
> > remove clk_bulk_prepare() in mtk_pcie_en7581_power_up() since we actual=
ly
> > implements just enable callback for EN7581 in clk-en7523.c.
> >=20
> > > If the split is required, a comment about why would be helpful.
> > >=20
> > > > +	err =3D clk_bulk_enable(pcie->num_clks, pcie->clks);
> > > > +	if (err) {
> > > > +		dev_err(dev, "failed to prepare clock\n");
> > > > +		goto err_clk_enable;
> > > > +	}
> > >=20
> > > Per https://lore.kernel.org/r/ZypgYOn7dcYIoW4i@lore-desk,
> > > REG_PCI_CONTROL is asserted/deasserted here by en7581_pci_enable().
> >=20
> > correct
> >=20
> > > Is this where PERST# is asserted?  If so, a comment to that effect
> > > would be helpful.  Where is PERST# deasserted?  Where are the required
> > > delays before deassert done?
> >=20
> > I can add a comment in en7581_pci_enable() describing the PERST issue f=
or
> > EN7581. Please note we have a 250ms delay in en7581_pci_enable() after
> > configuring REG_PCI_CONTROL register.
> >=20
> > https://github.com/torvalds/linux/blob/master/drivers/clk/clk-en7523.c#=
L396
>=20
> Does that 250ms delay correspond to a PCIe mandatory delay, e.g.,
> something like PCIE_T_PVPERL_MS?  I think it would be nice to have the
> required PCI delays in this driver if possible so it's easy to verify
> that they are all covered.

IIRC I just used the delay value used in the vendor sdk. I do not have a st=
rong
opinion about it but I guess if we move it in the pcie-mediatek-gen3 driver=
, we
will need to add it in each driver where this clock is used. What do you th=
ink?

Regards,
Lorenzo

>=20
> Bjorn

--SkwM6sguX1BTFpU9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZyxuvwAKCRA6cBh0uS2t
rFEQAQDZvJA94ZUr5Q+qYfreXv2YWgDIn0wXsSmdZWK8dKtF8AEAhGu0vKD+JOYK
ORyTYxUPc6l6vMTwvoB7PaJz0xrmdQc=
=BQEf
-----END PGP SIGNATURE-----

--SkwM6sguX1BTFpU9--

