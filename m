Return-Path: <linux-pci+bounces-16287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E97E9C1165
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 22:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C0F1F26930
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 21:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5114218932;
	Thu,  7 Nov 2024 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snaNZ8tS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2792170C2;
	Thu,  7 Nov 2024 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731016582; cv=none; b=FFHzczQo7gj++4XB+weDzNgNsANyWOhziJMuVGBihyehLeC2B6HR+/rJAJYsyVLw5BLhgEfpjLCNIlLo4BXWL+sctgFWYg8p5vwsFLMxtcQHHCM0/kIE9GDIqpfV1yFWxtP375izsOGe82bdPIdgAPuPuXL5Gs2iGYvjg+3m0P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731016582; c=relaxed/simple;
	bh=5Eo6qcoFVa2y7T4CA1LjJm2ItuxSl1cXVLYwgGdG78A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQRhbCF3e6Ar5o5sRQE8VnAcNDQsYtjepnLBGAzrFCGf1nBrHYncIgAZqtITJBCuoo1AAcsBVOTiAKAbmhV+qpvpCUDW5RTOVuM9CFHLh6qwbbTrVv8dVOSBz078+PklUo2xigEdsXHlh+GLu+Mkqb2W5IspDqCvFz+Xo74wbas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snaNZ8tS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D54C4CECC;
	Thu,  7 Nov 2024 21:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731016582;
	bh=5Eo6qcoFVa2y7T4CA1LjJm2ItuxSl1cXVLYwgGdG78A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snaNZ8tSicUvWD7PrD0LYJBkh3bGKBJbprEa1e+L3I9yynNSTobD5JQQuUlyw1qa4
	 Dee43LquYgLNye0D58HYWkPeK3vv1Fjl0PXXslYuvC/3FzXfQISP8Pcb0zMXYgFz6m
	 cHamLikSD3g7zIowC61gJhcQ6Dzrt2BQgKRDoFdySc2MndGz9iPb5vcRGQdzAvC7Z6
	 HGDMn/bHcXYLINTIT8HTZQ+glD+27KI5EUbkg5H4pd2BskirInQW74jUwTvq/3MSq1
	 MHi0wzGVR3iunnxMS2AQJf0gXVODH79ifsLJyVx7jKw2SbAk3eVgwUXVxrhrF6xmBt
	 22vW8hoSJemEg==
Date: Thu, 7 Nov 2024 22:56:19 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com,
	linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com, Hui.Ma@airoha.com
Subject: Re: [PATCH v4 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
Message-ID: <Zy03gz7czVIMQUcD@lore-desk>
References: <ZyzpGSyAVe6bz9H2@lore-desk>
 <20241107164624.GA1618716@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1W+fFQH7ARG+B5PJ"
Content-Disposition: inline
In-Reply-To: <20241107164624.GA1618716@bhelgaas>


--1W+fFQH7ARG+B5PJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Nov 07, 2024 at 05:21:45PM +0100, Lorenzo Bianconi wrote:
> > On Nov 07, Bjorn Helgaas wrote:
> > > On Thu, Nov 07, 2024 at 08:39:43AM +0100, Lorenzo Bianconi wrote:
> > > > > On Wed, Nov 06, 2024 at 11:40:28PM +0100, Lorenzo Bianconi wrote:
> > > > > > > On Wed, Jul 03, 2024 at 06:12:44PM +0200, Lorenzo Bianconi wr=
ote:
> > > > > > > > Introduce support for Airoha EN7581 PCIe controller to medi=
atek-gen3
> > > > > > > > PCIe controller driver.
> > > > > > > > ...
> > >=20
> > > > > > > Is this where PERST# is asserted?  If so, a comment to that e=
ffect
> > > > > > > would be helpful.  Where is PERST# deasserted?  Where are the=
 required
> > > > > > > delays before deassert done?
> > > > > >=20
> > > > > > I can add a comment in en7581_pci_enable() describing the PERST=
 issue for
> > > > > > EN7581. Please note we have a 250ms delay in en7581_pci_enable(=
) after
> > > > > > configuring REG_PCI_CONTROL register.
> > > > > >=20
> > > > > > https://github.com/torvalds/linux/blob/master/drivers/clk/clk-e=
n7523.c#L396
> > > > >=20
> > > > > Does that 250ms delay correspond to a PCIe mandatory delay, e.g.,
> > > > > something like PCIE_T_PVPERL_MS?  I think it would be nice to hav=
e the
> > > > > required PCI delays in this driver if possible so it's easy to ve=
rify
> > > > > that they are all covered.
> > > >=20
> > > > IIRC I just used the delay value used in the vendor sdk. I do not
> > > > have a strong opinion about it but I guess if we move it in the
> > > > pcie-mediatek-gen3 driver, we will need to add it in each driver
> > > > where this clock is used. What do you think?
> > >=20
> > > I don't know what the 250ms delay is for.  If it is for a required PCI
> > > delay, we should use the relevant standard #define for it, and it
> > > should be in the PCI controller driver.  Otherwise it's impossible to
> > > verify that all the drivers are doing the correct delays.
> >=20
> > ack, fine to me. Do you prefer to keep 250ms after clk_bulk_prepare_ena=
ble()
> > in mtk_pcie_en7581_power_up() or just use PCIE_T_PVPERL_MS (100)?
> > I can check if 100ms works properly.
>=20
> It's not clear to me where the relevant events are for these chips.
>=20
> Do you have access to the PCIe CEM spec?  The diagram in r6.0, sec
> 2.2.1, is helpful.  It shows the required timings for Power Stable,
> REFCLK Stable, PERST# deassert, etc.
>=20
> Per sec 2.11.2, PERST# must be asserted for at least 100us (T_PERST),
> PERST# must be asserted for at least 100ms after Power Stable
> (T_PVPERL), and PERST# must be asserted for at least 100us after
> REFCLK Stable.
>=20
> It would be helpful if we could tell by reading the source where some
> of these critical events happen, and that the relevant delays are
> there.  For example, if PERST# is asserted/deasserted by
> "clk_enable()" or similar, it's not at all obvious from the code, so
> we should have a comment to that effect.

I reviewed the vendor sdk and it just do something like in clk_enable():

	...
	val =3D readl(0x88);
	writel(val | BIT(16) | BIT(29) | BIT(26), 0x88);
	/*wait link up*/
	mdelay(1000);
	...

@Hui.Ma: is it fine use msleep(100) (so PCIE_T_PVPERL_MS) instead of msleep=
(1000)
(so PCIE_LINK_RETRAIN_TIMEOUT_MS)?

Regards,
Lorenzo

>=20
> Bjorn

--1W+fFQH7ARG+B5PJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZy03gwAKCRA6cBh0uS2t
rJ64AP40vgr/oweTeYBRjXYZBVQY5QwDDuhEhSNWwtsmfHK6fAEAtiON0J6fTwIC
3wlDpNdKoaRVFQc7zFP/K1csNJqSNgk=
=KhIT
-----END PGP SIGNATURE-----

--1W+fFQH7ARG+B5PJ--

