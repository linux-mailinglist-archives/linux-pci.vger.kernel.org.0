Return-Path: <linux-pci+bounces-19157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC06E9FF8A5
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 12:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD36160640
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 11:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A421ADFF8;
	Thu,  2 Jan 2025 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyF0xLqA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DC2194096;
	Thu,  2 Jan 2025 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735816891; cv=none; b=XsJDb4ooWSOvMVRy5TxLoOTYGtzC8VPTboCy2EDYMrKh1p9ergdYm8hOF3OHYwxxOT5yNFkr8ikkLGCUSUZWSF0GLIEm+HDlUMX6u6wf6YU1ssh3kQJAbyBj2v50OyvZ30XEqeBAc/jDd/NJpClO1NaolGxNSM0pWPmUli6DDEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735816891; c=relaxed/simple;
	bh=W65URpuT66zpoom/bKkmJ99ASzFyUtgK5KkXVL/Tpws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKce0fcsDna+lGqLHJBkhFe69XxxuknwAKN3TxNE+y+iYg9j7dAvP31sfSgsYo7JUbVxLCJTBfjmQmkBuM5zgxpZ5OQwCVPArdZk8lDcQYLevAWIYM3hexWxDoSruIUqJPOuBJ9CCHSYmaaqO9s9GchBdK8I5/JFwBqo67SPoJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyF0xLqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D572C4CEDC;
	Thu,  2 Jan 2025 11:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735816891;
	bh=W65URpuT66zpoom/bKkmJ99ASzFyUtgK5KkXVL/Tpws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lyF0xLqAH9UBeqQHJKzMr9dUKJT9Yy+Rfxt9CgZ/VrhfDqUXJuM7O0Eegw6kJi2dQ
	 132j5jGXlln0l+MZMGwwJh6OR1Z462jmAeXhCE3t2VQTJi0ug5ae3fgJ7zgnfx8qem
	 tsQbMnEC+ZaJGbYm8LZcC/pg2Ab7+sWtt9p3XR8D9ZTySwXgPZHdJaivFpFiY9Rdp7
	 pTP8fA8FqBQtbCs7NKlmV/6ZHIZuhXc9HtpoO18bZbPhXKfGySl5OnQaIsz7HOEyUQ
	 WeXwdo0Sg5FV5pp7JOn67Vr5Sh/DpAhNw+pdJsfUz8ZQsCYfrbg6t0b1Af6pMlZ7mb
	 2qIXSImj7uGxA==
Date: Thu, 2 Jan 2025 12:21:28 +0100
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
Subject: Re: [PATCH v5 1/6] PCI: mediatek-gen3: Add missing
 reset_control_deassert() for mac_rst in mtk_pcie_en7581_power_up()
Message-ID: <Z3Z2uOCUGX7uAaae@lore-desk>
References: <20241130-pcie-en7581-fixes-v5-1-dbffe41566b3@kernel.org>
 <20241230175754.GA3958277@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KseZ4mXYs1K8AxEo"
Content-Disposition: inline
In-Reply-To: <20241230175754.GA3958277@bhelgaas>


--KseZ4mXYs1K8AxEo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, Nov 30, 2024 at 12:20:10AM +0100, Lorenzo Bianconi wrote:
> > Even if this is not a real issue since Airoha EN7581 SoC does not requi=
re
> > the mac reset line, add missing reset_control_deassert() for mac reset
> > line in mtk_pcie_en7581_power_up() callback.

Hi Bjorn,

since this patch is already in Krzysztof's controller/mediatek branch, do y=
ou
want to repost the full series or just incremental changes?

>=20
> s/mac/MAC/ in English text since "mac" is an acronym, not a real word

ack, I will fix it.

>=20
> This doesn't really say why we need this patch.
>=20
> This adds both assert and deassert, so it doesn't really look like
> adding a *missing* deassert.
>=20
> On EN7581, is mac_reset optional or always absent?

AFAIK mac_reset is never used on EN7581. We added it since we were discussi=
ng in
[0] to move the reset asssert/deassert callbacks in the same routine (in the
original codeabse we have reset_control_assert(pcie->mac_reset) in mtk_pcie=
_setup()
and reset_control_deassert(pcie->mac_reset) in mtk_pcie_power_up()).
I think we can remove mac_reset support at all for EN7581.  What do you pre=
fer?

Regards,
Lorenzo

[0] https://lore.kernel.org/linux-pci/20241106233123.GA1580663@bhelgaas/

>=20
> If mac_reset is always absent for EN7581, why add this patch at all?
> If it's optional, say so.
>=20
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/pci/controller/pcie-mediatek-gen3.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/=
controller/pcie-mediatek-gen3.c
> > index 64ef8ff71b0357b9bf9ad8484095b7aa60c22271..4d1c797a32c236faf79428e=
b8a83708e9c4f21d8 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -942,6 +942,9 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3=
_pcie *pcie)
> >  	 */
> >  	mdelay(PCIE_EN7581_RESET_TIME_MS);
> > =20
> > +	/* MAC power on and enable transaction layer clocks */
> > +	reset_control_deassert(pcie->mac_reset);
> > +
> >  	pm_runtime_enable(dev);
> >  	pm_runtime_get_sync(dev);
> > =20
> > @@ -976,6 +979,7 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3=
_pcie *pcie)
> >  err_clk_prepare:
> >  	pm_runtime_put_sync(dev);
> >  	pm_runtime_disable(dev);
> > +	reset_control_assert(pcie->mac_reset);
> >  	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets, pcie->phy=
_resets);
> >  err_phy_deassert:
> >  	phy_power_off(pcie->phy);
> >=20
> > --=20
> > 2.47.0
> >=20

--KseZ4mXYs1K8AxEo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ3Z2uAAKCRA6cBh0uS2t
rNLuAP9aIvgBoSTUsdbM74sz/9xj2EI/jesibuEXgdwRznaErwD+OH6Lbxg9oaqN
0C1Pv2EwtriUpAMpokB0n1IJ9tcZhQw=
=9erM
-----END PGP SIGNATURE-----

--KseZ4mXYs1K8AxEo--

