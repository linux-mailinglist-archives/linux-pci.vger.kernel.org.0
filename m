Return-Path: <linux-pci+bounces-16250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC0E9C0A1C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 16:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC121C21BAF
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 15:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29D31714DF;
	Thu,  7 Nov 2024 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiZblABR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D138DC8
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993342; cv=none; b=HRC7r8d12mrLQr07/V42cTapPze8Grm4XohMztmzh80990hADHdz1/dCki1p7/rijPxvxtGTRoyh5OprATs7GGng6W+nhcMV9h/I5VSQcOgbC0+LWOITO7PauOUQ0AW92x0X3h+pFO2ixoTN118TXdcmOw4y9mm+cBPUHi9qnjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993342; c=relaxed/simple;
	bh=i18faHWRnV4eHB93H4auKl9l5lsG8izxHR+bYJX1GZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4/z0UxyIFzygTt363/owwbYGSRYB+ivNb/dOmC/SHFOjdrbAQOo4a1Aa/o7QzaVI5uYKfKFwje8RonMzYMgNebsO/6u6OjeiFZRvt0Y62nmyAgfYLsnk5+fCY9bd9xbJquOq8x00lqfZ4wgxTw+723fShm6Z0YZUlR0Coxg7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiZblABR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6366C4CECC;
	Thu,  7 Nov 2024 15:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730993342;
	bh=i18faHWRnV4eHB93H4auKl9l5lsG8izxHR+bYJX1GZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OiZblABRlEI6/1E/4sy0X6jbZkCmR8JiTxWKaP/AjbE2aje70Q8g0RUDY9tRam6TZ
	 fqK/ngzlOCE9diDF6pl5jOWxuLhJhitbyWuZK0jk2uYYC5O/Z3NFLhB4scWBe5X2rW
	 PFnxFLlkBuK7xgiv7rZsTEvI+2cMQDM/7dUNj+s0a7sUm8OAqoGZE+C6CFnKBZVMAT
	 PR61jHJ5Z6n0f3n9eCjE3W+SZoqWWFaoyeBV44mYj6YR7Q0m8xkKK5LGP6tZkND+4h
	 kk3tBk2vJZdhxM3z7lFLZg1fced1qSjHU9JWp2nVWZCOVo0xh6WruonlmMRx2TiSQt
	 HAzrhq/G7lcyQ==
Date: Thu, 7 Nov 2024 16:28:58 +0100
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
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] PCI: mediatek-gen3: rely on clk_bulk_prepare_enable
 in mtk_pcie_en7581_power_up
Message-ID: <ZyzcuqwjqBEBMx8g@lore-desk>
References: <20241107-pcie-en7581-fixes-v1-2-af0c872323c7@kernel.org>
 <20241107151953.GA1614560@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H/ItTzle+i5kLD9o"
Content-Disposition: inline
In-Reply-To: <20241107151953.GA1614560@bhelgaas>


--H/ItTzle+i5kLD9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Nov 07, 2024 at 02:50:54PM +0100, Lorenzo Bianconi wrote:
> > Squash clk_bulk_prepare and clk_bulk_enable in
> > clk_bulk_prepare_enable in mtk_pcie_en7581_power_up routine
>=20
> Thank you, this is much better.
>=20
> Can you add "()" after function names in subject and commit logs here
> and in other patches?

sure, I will do in v2.

Regards,
Lorenzo

>=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/pci/controller/pcie-mediatek-gen3.c | 14 +++-----------
> >  1 file changed, 3 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/=
controller/pcie-mediatek-gen3.c
> > index 0fac0b9fd785e463d26d29d695b923db41eef9cc..8c8c733a145634cdbfefd33=
9f4a692f25a6e24de 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -903,12 +903,6 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen=
3_pcie *pcie)
> >  	pm_runtime_enable(dev);
> >  	pm_runtime_get_sync(dev);
> > =20
> > -	err =3D clk_bulk_prepare(pcie->num_clks, pcie->clks);
> > -	if (err) {
> > -		dev_err(dev, "failed to prepare clock\n");
> > -		goto err_clk_prepare;
> > -	}
> > -
> >  	val =3D FIELD_PREP(PCIE_VAL_LN0_DOWNSTREAM, 0x47) |
> >  	      FIELD_PREP(PCIE_VAL_LN1_DOWNSTREAM, 0x47) |
> >  	      FIELD_PREP(PCIE_VAL_LN0_UPSTREAM, 0x41) |
> > @@ -921,17 +915,15 @@ static int mtk_pcie_en7581_power_up(struct mtk_ge=
n3_pcie *pcie)
> >  	      FIELD_PREP(PCIE_K_FINETUNE_MAX, 0xf);
> >  	writel_relaxed(val, pcie->base + PCIE_PIPE4_PIE8_REG);
> > =20
> > -	err =3D clk_bulk_enable(pcie->num_clks, pcie->clks);
> > +	err =3D clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
> >  	if (err) {
> >  		dev_err(dev, "failed to prepare clock\n");
> > -		goto err_clk_enable;
> > +		goto err_clk_init;
> >  	}
> > =20
> >  	return 0;
> > =20
> > -err_clk_enable:
> > -	clk_bulk_unprepare(pcie->num_clks, pcie->clks);
> > -err_clk_prepare:
> > +err_clk_init:
> >  	pm_runtime_put_sync(dev);
> >  	pm_runtime_disable(dev);
> >  	reset_control_assert(pcie->mac_reset);
> >=20
> > --=20
> > 2.47.0
> >=20

--H/ItTzle+i5kLD9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZyzcugAKCRA6cBh0uS2t
rHNYAP4izFeIALB2fJZjBjL5FEJFYYnPEQAtEvUU1M+XANkcNwD/bj7ZFmIGEzRe
lW3qqkFAghafQ6mO8XHHsNN0u3SqWQA=
=rPvS
-----END PGP SIGNATURE-----

--H/ItTzle+i5kLD9o--

