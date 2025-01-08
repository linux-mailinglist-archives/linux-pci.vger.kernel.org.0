Return-Path: <linux-pci+bounces-19521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44321A05722
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 10:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4123B1619D3
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 09:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5B61F3D54;
	Wed,  8 Jan 2025 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmBJBt3y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85D71A0BED;
	Wed,  8 Jan 2025 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736329313; cv=none; b=ZXgezme6HQh0gFZI5wAWYCUPUBKOilDxnazr6XSN8pvt/xidde9LlU1jvEt/UxcWPvBMVXVMiOUts58dOOffrBUGEHaQ//F5ptAwWfMoiwhldHYMgdoUCZf6j2KzMswanO4mCiJ5BW8PbhI3J4ClozHo1AISGZj5s6qFcblAsU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736329313; c=relaxed/simple;
	bh=EntXp4xoflKbAqPs1HYoj7ukYN+nnJIPOzYENz4cHvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HG2gT/1aGak9QnLpGTE4NStPQOrEgGKRl90HLPhr7tltmrcej3MbVBQ8lRNHz9Ef+s4/6PkykxqmuEtFiFOUEDhtRKhPlhjdVnj3wiNVDz0+8swb6JHqg3Au7Akz+0aYmTm7zH0NEIOD1rZJNyWmSweAgks5NeyZJU1CwSA1+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmBJBt3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF3EC4CEE0;
	Wed,  8 Jan 2025 09:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736329312;
	bh=EntXp4xoflKbAqPs1HYoj7ukYN+nnJIPOzYENz4cHvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZmBJBt3ye5TWgQ2ebPu+INxrnEO7li5c1DTwrmISGqEEPqqEJbpeHBgfqe+0wxPYb
	 l/sISxNY67Y+aQ85lTp78YdVXn7i3WjvUjRjOqIaVWyp9l42NN2lnJGlJX6LSwbHkP
	 FKRQq/N4Gg6pE0NgXR9vPAi7cl9RuLQwKKR/kUOQeleLZ+8pNAYZLJTjci/2zlxh0G
	 ajkzB8tcdSN9v7z5QOl6TlroM9nC4lhKTuD1F6hQeR/1d0oIYpuGHESFsCjseXxmtp
	 dIcziBACMLrsq9c7A3mn6gHWqWohkKzW7L4WD8IiboSaDR1A8e8rqNGGMqsHFH5jwf
	 zVwMC/GGy2BmQ==
Date: Wed, 8 Jan 2025 10:41:49 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 5/6] PCI: mediatek-gen3: Add reset delay in
 mtk_pcie_en7581_power_up()
Message-ID: <Z35IXRLX0xDX7Kr7@lore-desk>
References: <20241130-pcie-en7581-fixes-v5-5-dbffe41566b3@kernel.org>
 <20250103183527.GA3959656@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UfOoG4Z6S4fyWZJw"
Content-Disposition: inline
In-Reply-To: <20250103183527.GA3959656@bhelgaas>


--UfOoG4Z6S4fyWZJw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
> If you repost this series, here are a few comments/typos.  Otherwise
> we can do the trivial updates on the branch.
>=20
> In subject: this patch doesn't *add* a delay; it *moves* it.

ack, I will fix it.

>=20
> On Sat, Nov 30, 2024 at 12:20:14AM +0100, Lorenzo Bianconi wrote:
> > Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
> > causing occasional PCIe link down issues. In order to overcome the
> > problem, PCIe block is reset using REG_PCI_CONTROL (0x88) and
> > REG_RESET_CONTROL (0x834) registers available in the clock module
> > running clk_bulk_prepare_enable in mtk_pcie_en7581_power_up().
>=20
> Add parens after clk_bulk_prepare_enable.

ack, I will fix it.

>=20
> > In order to make the code more readable, move the wait for the time
> > needed to complete the PCIe reset from en7581_pci_enable() to
> > mtk_pcie_en7581_power_up().
> > Reduce reset timeout from 250ms to the standard PCIE_T_PVPERL_MS value
> > (100ms) since it has no impact on the driver behavior.
> >
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/clk/clk-en7523.c                    | 1 -
> >  drivers/pci/controller/pcie-mediatek-gen3.c | 7 +++++++
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
> > index 22fbea61c3dcc05e63f8fa37e203c62b2a6fe79e..bf9d9594bef8a54316e28e5=
6a1642ecb0562377a 100644
> > --- a/drivers/clk/clk-en7523.c
> > +++ b/drivers/clk/clk-en7523.c
> > @@ -393,7 +393,6 @@ static int en7581_pci_enable(struct clk_hw *hw)
> >  	       REG_PCI_CONTROL_PERSTOUT;
> >  	val =3D readl(np_base + REG_PCI_CONTROL);
> >  	writel(val | mask, np_base + REG_PCI_CONTROL);
> > -	msleep(250);
> > =20
> >  	return 0;
> >  }
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/=
controller/pcie-mediatek-gen3.c
> > index 01e8fde96080fa55f6c23c7d1baab6e22c49fcff..da01e741ff290464d28e172=
879520dbe0670cc41 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -977,6 +977,13 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen=
3_pcie *pcie)
> >  		goto err_clk_prepare_enable;
> >  	}
> > =20
> > +	/*
> > +	 * Airoha EN7581 performs PCIe reset via clk callabacks since it has a
> > +	 * hw issue with PCIE_PE_RSTB signal. Add wait for the time needed to
> > +	 * complete the PCIe reset.
>=20
> s/callabacks/callbacks/

ack, I will fix it.

Regards,
Lorenzo

>=20
> > +	 */
> > +	msleep(PCIE_T_PVPERL_MS);
> > +
> >  	return 0;
> > =20
> >  err_clk_prepare_enable:
> >=20
> > --=20
> > 2.47.0
> >=20

--UfOoG4Z6S4fyWZJw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ35IXQAKCRA6cBh0uS2t
rNfuAP95qW2o5+5pMdA45lJJrd8AAwCrPov/N/UcDypJjjfnsQEAlJiNopVu7YmP
HOKH4pXQZe272nswX6233GV357WPqwk=
=k4Zn
-----END PGP SIGNATURE-----

--UfOoG4Z6S4fyWZJw--

