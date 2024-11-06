Return-Path: <linux-pci+bounces-16110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D68109BE239
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 10:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960992852E8
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 09:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6E21D9591;
	Wed,  6 Nov 2024 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDEhK9dB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570921D958B
	for <linux-pci@vger.kernel.org>; Wed,  6 Nov 2024 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884690; cv=none; b=W/O3y3Hs2+YNJHoN9FSDfLEIKqwD4xaYBsqQ9tZ4qdcOx5TfozuxtT8srpfOzK2JtbS6Ny9jrwvuTi30r8s/MBraSwbc7wd8OUG1b40LXpA9BGDsAupvuUyUG6vOLGpKhlC0+qtP/wDNPDLX7Wx52uYwnN5mwIdd3h7LYa8rihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884690; c=relaxed/simple;
	bh=4NMKth/+tbq9G9afQXTfm7cy85P47LqxOouOqVfZs1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQei/Dj2Y1S+VKYWtxqzf77gQhKfbyBYRSLzvL6MrMYYMqbXwXdUTOEXUFI6lHAUoAnaPHS/dQVgKTvGmIpkhJY7+h3ii5dqRyAJMOkt63C/wjq4CDsK/rSLCrnQmokcV3pWnlm+/Xd3UXzydL4F28b0/MriP7kJDVb67zZeQjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDEhK9dB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972DDC4CECD;
	Wed,  6 Nov 2024 09:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730884689;
	bh=4NMKth/+tbq9G9afQXTfm7cy85P47LqxOouOqVfZs1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDEhK9dBQa10BBr5wtDZqdVJA8bS/eSLMaeRQUS9pkzteq6yS1EWPPJaoIh1qR/XJ
	 4pDiuI8um12Mvaqxra6zF2EVHhbgHx759vBgncXdJXwCYgTGvHWusoeZwdXTPeeBs3
	 zUD1Qw0qhplRnGMAF76ym23PzBu9yeV4Ph1TwcvWaN5DCRIDUn/LUCYNd+yK5IO65f
	 lrA7+HhbfyePkV8TDM3yD6h/5A4XDPNsWE9iUuMEdQX7SLlLTLXAtld27jDJcse18e
	 5jqbQIhk5EezNYY4+jYDpc7ZbNq/WZ3tqgT3GSNCuejkkjSB93lb9YalZdAafoQJyw
	 EGr+b7KD3sq+g==
Date: Wed, 6 Nov 2024 10:18:07 +0100
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
Message-ID: <Zys0T-aDIilOpq0I@lore-desk>
References: <ZypgYOn7dcYIoW4i@lore-desk>
 <20241105205748.GA1484220@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qV7Iu35SJTZV/AHc"
Content-Disposition: inline
In-Reply-To: <20241105205748.GA1484220@bhelgaas>


--qV7Iu35SJTZV/AHc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, Nov 05, 2024 at 07:13:52PM +0100, Lorenzo Bianconi wrote:
> > > On Mon, Nov 04, 2024 at 11:00:05PM +0100, Lorenzo Bianconi wrote:
> > > > Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
> > > > causing occasional PCIe link down issues. In order to overcome the
> > > > problem, PCIE_RSTB signals are not asserted/released during device =
probe or
> > > > suspend/resume phase and the PCIe block is reset using REG_PCI_CONT=
ROL
> > > > (0x88) and REG_RESET_CONTROL (0x834) registers available via the cl=
ock
> > > > module.
> > > > Introduce flags field in the mtk_gen3_pcie_pdata struct in order to
> > > > specify per-SoC capabilities.
> > >=20
> > > Where does this alternate way of doing reset (using REG_PCI_CONTROL
> > > and REG_RESET_CONTROL) happen?  Why isn't there something in this
> > > patch to use that alternate method at the same points where
> > > PCIE_PE_RSTB is used?
> >=20
> > REG_RESET_CONTROL (0x834) is already asserted/released in the following=
 flow:
> >=20
> > mtk_pcie_en7581_power_up() -> reset_control_bulk_deassert() -> en7523_r=
eset_update()
> > https://github.com/torvalds/linux/blob/master/drivers/clk/clk-en7523.c#=
L470
> >=20
> > REG_PCI_CONTROL (0x88) is already asserted/released in the following fl=
ow:
> > mtk_pcie_en7581_power_up() -> clk_bulk_enable() -> en7581_pci_enable()
> > https://github.com/torvalds/linux/blob/master/drivers/clk/clk-en7523.c#=
L385
>=20
> So IIUC, you're saying that on EN7581, the PCI hierarchy is reset by
> the soc->power_up() callback, mtk_pcie_en7581_power_up(), via
> REG_PCI_CONTROL and REG_RESET_CONTROL.

yes, correct.

>=20
> I assume the hierarchy is also reset by the non-EN7581 .power_up()
> callback, mtk_pcie_power_up()?

as pointed out by Jianjun Wang, non-EN7581 family is reset via PCIE_RSTB
signals and .power_up() callback is used just for initialization.
For EN7581 family we need to reset the device via .power_up() callback
since we have a hw issue with PCIE_PE_RSTB signal (at least this is my
take-away :))

>=20
> And prior to this patch, we reset the hierarchy *again* in
> mtk_pcie_startup_port() via PCIE_RST_CTRL_REG, but this causes
> occasional "link down" issues because of a EN7581 hardware defect.

yes, correct

>=20
> So for EN7581, this patch skips the PCIE_RST_CTRL_REG reset in
> mtk_pcie_startup_port().

yes, correct

>=20
> .power_up() and mtk_pcie_startup_port() are used both at probe time
> and in mtk_pcie_resume_noirq().  So after this patch, I assume:
>=20
>   - EN7581 resets the hierarchy once at probe and resume instead of
>     twice.

yes, correct

>=20
>   - Non-EN7581 resets the hierarchy twice at probe and resume.

nope, just once since .power_up() does not reset the device.

Regards,
Lorenzo

>=20
> I assume I'm missing something (maybe mtk_pcie_power_up() doesn't
> actually reset the hierarchy?) because I don't see why we would reset
> the hierarchy twice for either controller.
>=20
> Bjorn

--qV7Iu35SJTZV/AHc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZys0TwAKCRA6cBh0uS2t
rOs7AP9NYd+xfPZYqk/9uJmxY7WUn9qLDa6qujJG0QUeuNH09wD+IXpITgFNY5yk
GuelOGXgAUV65fTPir1SMcf5eaviiAY=
=XurC
-----END PGP SIGNATURE-----

--qV7Iu35SJTZV/AHc--

