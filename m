Return-Path: <linux-pci+bounces-19954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B48A137FB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 11:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96BFB188A80E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 10:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6325919539F;
	Thu, 16 Jan 2025 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0t9msqz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAFD1DDC1F
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737023609; cv=none; b=bhJWiUjqOEYwJwVK8rfk3MRbpzCDwHkeIh+htbzkwjKytff2/tmGrpRW0O5rSlskFP0lFrrByM+t0KuUl2C0eC2O6Ey/cl58QPq9wR7H20IYwUdkmiI829IFQYbmjIsnqnUCXYpxxchmW5yklepFew2NY+ncFXRR1jcA4X7fixM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737023609; c=relaxed/simple;
	bh=S+g0KwJKhEGGe+s0qjck8zl1QAQR7IzypnJhI9sb/gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZwLXVZGdcLuhiGibHRqAiPVr0J+3jPTz1tyvAYFougi0VHAZ9G4OgegS0OehGSWE6r+3RZkM7PhzUVZEoTyAr3T7ZPl6sHme6bjetFRpU+e0EX33AxAEMUZTcAnBnZYGi7bFxw+NSBLu0sTDOX2PXNX3oRp8pXea4uh7cz47DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0t9msqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18742C4CED6;
	Thu, 16 Jan 2025 10:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737023606;
	bh=S+g0KwJKhEGGe+s0qjck8zl1QAQR7IzypnJhI9sb/gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0t9msqzYXzRFVJkhPK83dEQJDpnYF9mZGlMJzJNy1niLUhu6AMF+N7B7aw1iFmFD
	 1fAOmcCTasqh4+06+fceLgtZF2fKwj0UdaHC6c1g+dJUHtCUejZZMkZ5Kjs1TM+jtT
	 lPY04G5ITi1hi/mrvN1BlfbOb7aa2L90fzwu9wgmUnc4fpYw9vCIrTQ5+exsNPGWOM
	 GBG7SS8Fx1+RZoQ8tyKcCDkUBbpxLqyptYsGQEe6V32JrD6dLcuH5Z6DEDyKZaLu1W
	 003DVDiq0vjn48KJYp9quDVPYPylYp9P3spQqqNWSgHAvPIv7Tpf5JO5oUoOMlFJmi
	 ihVxdg5HbpWfg==
Date: Thu, 16 Jan 2025 11:33:23 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mediatek-gen3: Remove leftover mac_reset assert for
 Airoha EN7581 SoC.
Message-ID: <Z4jgczH63wfdfU27@lore-desk>
References: <20250115-pcie-en7581-remove-mac_reset-v1-1-61c2652e189f@kernel.org>
 <1f143d85c24d4691299072d582142f36c018c878.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Vk7D2QuutwXiu5yy"
Content-Disposition: inline
In-Reply-To: <1f143d85c24d4691299072d582142f36c018c878.camel@pengutronix.de>


--Vk7D2QuutwXiu5yy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mi, 2025-01-15 at 18:58 +0100, Lorenzo Bianconi wrote:
> > Remove a leftover assert for mac_reset line in mtk_pcie_en7581_power_up=
().
> > This is not armful since EN7581 does not requires mac_reset and
>               ^ harmful

ack, I will fix it.

>=20
> > mac_reset is not defined in EN7581 device tree.
> >
>=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/pci/controller/pcie-mediatek-gen3.c | 1 -
> >  1 file changed, 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/=
controller/pcie-mediatek-gen3.c
> > index aa24ac9aaecc749b53cfc4faf6399913d20cdbf2..0f64e76e2111468e6a45388=
9ead7fbc75804faf7 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -940,7 +940,6 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3=
_pcie *pcie)
> >  	 */
> >  	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
> >  				  pcie->phy_resets);
> > -	reset_control_assert(pcie->mac_reset);
>=20
> Is it ok to keep the mac_reset assert in mtk_pcie_power_down() ?

yes, since it is in common between mtk chipset and airoha one.
reset_control_assert() just returns if rstc is NULL.

>=20
> >  	/* Wait for the time needed to complete the reset lines assert. */
> >  	msleep(PCIE_EN7581_RESET_TIME_MS);
> >=20
> > ---
> > base-commit: d02e16e4e05d5d2530a4836ca92318c6a6b21b01
>=20
> I can't find this commit, which tree is it on?

it is in next tree:

commit d02e16e4e05d5d2530a4836ca92318c6a6b21b01
Merge: 07eecfa5d467 9dfc6850cfa4
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
Date:   Wed Jan 15 13:56:57 2025 +0000

    Merge branch 'resource'
   =20
    * resource:
      PCI: Encourage resource request API users to supply driver name


Regards,
Lorenzo

>=20
> regards
> Philipp

--Vk7D2QuutwXiu5yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ4jgcwAKCRA6cBh0uS2t
rD2VAQD0Qbr6I8sYkx4eqnBqrDn/gH4xjGSC0w0smSCqEcW7tgD/Y3UAhJwS/hbm
MSdL+AxX5xXh2mKfBkXGhM7w1jLgqAI=
=K7Oy
-----END PGP SIGNATURE-----

--Vk7D2QuutwXiu5yy--

