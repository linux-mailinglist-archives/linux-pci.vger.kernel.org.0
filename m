Return-Path: <linux-pci+bounces-17235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 145809D688E
	for <lists+linux-pci@lfdr.de>; Sat, 23 Nov 2024 11:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE6816120D
	for <lists+linux-pci@lfdr.de>; Sat, 23 Nov 2024 10:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2813F7E107;
	Sat, 23 Nov 2024 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAZDa2TR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F534A0A;
	Sat, 23 Nov 2024 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732357066; cv=none; b=e8a2IkkGuB7Ys3VVHaym0PjXaeEeh9jNEtG2V8P1TM8pCGhoXjHMeafx02Q+BW49tY/YSjRcl94tMQpxGtbNemlRRgdGj64C0ekZGjp/WggYrT69jP797SwFC7RdRA0RAnKydJRoSXIG+OEV6lMv8k7jiV7EWj4JxUWV4d8Jo+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732357066; c=relaxed/simple;
	bh=0rdrQoLAvrP9GeeQDmFLTU4Ij1FObv0T5hb19RDhLLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNVxIz80UtSJuBiHwpclYyiOQPmxaCV8BdNamEavAQrfANqY4jfWsOXZfeR8724QGshN6o3IwOGR5016RswQciTTA/J/V/VoVxfyZkbzwtB55D/5JC6oxvfF+NEIVwe6Ag5RXYt0Jpjc/IuiEXqIAeAo11alPkkIhvpC1jjSf0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAZDa2TR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5445C4CECD;
	Sat, 23 Nov 2024 10:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732357065;
	bh=0rdrQoLAvrP9GeeQDmFLTU4Ij1FObv0T5hb19RDhLLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAZDa2TRbmJsJZZUgFUdt69U8MLFL3b4DDD2bsUPLpQoO3ArmzULlLRg0xAd18+x5
	 7cN2jmmiMt7ERQQ0w8v8esvzaP9D2yAm8JFpeG9O985fs1Mbcqobt/p9YMCNGkxg29
	 RjuzFbJZO7XFx3GeZNbEbRTcElKBUz7FzkgsHUWq+pvBrC96TPPTl+AIRqDZR7hbB1
	 7bLOZSrYeQRIi2y5VxNy7pNVEdrmy0zT3Mim2pBxBCnRjEy/AgMkPPeCRDYoOSFk3A
	 bCuOAwQQF5zh+KlTXQ8Hxs9EwvRBb+EHmbYxsgNsiHPFSBsXt4769wYroQBrTE1O/M
	 +TwVoJlUQwYYg==
Date: Sat, 23 Nov 2024 11:17:42 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 5/6] PCI: mediatek-gen3: Add reset delay in
 mtk_pcie_en7581_power_up()
Message-ID: <Z0GrxtFsGbL08X7P@lore-desk>
References: <20241118-pcie-en7581-fixes-v4-0-24bb61703ad7@kernel.org>
 <20241118-pcie-en7581-fixes-v4-5-24bb61703ad7@kernel.org>
 <20241123091026.qxoeb2qye7kcwikj@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jHZfs2ffVCIlHxKc"
Content-Disposition: inline
In-Reply-To: <20241123091026.qxoeb2qye7kcwikj@thinkpad>


--jHZfs2ffVCIlHxKc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Nov 18, 2024 at 09:04:57AM +0100, Lorenzo Bianconi wrote:
> > Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
> > causing occasional PCIe link down issues. In order to overcome the
> > problem, PCIe block is reset using REG_PCI_CONTROL (0x88) and
> > REG_RESET_CONTROL (0x834) registers available in the clock module
> > running clk_bulk_prepare_enable in mtk_pcie_en7581_power_up().
> > In order to make the code more readable, move the wait for the time
> > needed to complete the PCIe reset from en7581_pci_enable() to
> > mtk_pcie_en7581_power_up().
> > Reduce reset timeout from 250ms to PCIE_T_PVPERL_MS (100ms).
> >=20
>=20
> and this reduced timeout has no impact on the behavior? If so, it'd be go=
od to
> state it explicitly. But this information can be added while applying the=
 patch,
> so no need to resend just for this.

nope, we discussed this here:
https://patchwork.kernel.org/project/linux-pci/patch/aca00bd672ee576ad96d27=
9414fc0835ff31f637.1720022580.git.lorenzo@kernel.org/#26114968

no worries, I will fix it in v5 since I need to repost to address a
comment in patch 3/6.

Regards,
Lorenzo

>=20
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>=20
> - Mani
>=20
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
> > index e4f890a73cb8ada7423301fa7a9acc3e177d0cad..f47c0f2995d94ea99bf4114=
6657bd90b87781a7c 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -980,6 +980,13 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen=
3_pcie *pcie)
> >  		goto err_clk_prepare_enable;
> >  	}
> > =20
> > +	/*
> > +	 * Airoha EN7581 performs PCIe reset via clk callabacks since it has a
> > +	 * hw issue with PCIE_PE_RSTB signal. Add wait for the time needed to
> > +	 * complete the PCIe reset.
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
>=20
> --=20
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

--jHZfs2ffVCIlHxKc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ0GrxgAKCRA6cBh0uS2t
rKMoAP93x075FJWNtocxh9wxnIcNLCF8UkTmdf1GPkTZaVez8QD/cjBj4ekttnp+
gQmsMix69h2OLk1qTdpWWs3j91WJoQw=
=AKOK
-----END PGP SIGNATURE-----

--jHZfs2ffVCIlHxKc--

