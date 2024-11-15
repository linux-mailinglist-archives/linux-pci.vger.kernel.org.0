Return-Path: <linux-pci+bounces-16850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D08899CDB40
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 10:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 430EEB22148
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 09:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7570E18A6AF;
	Fri, 15 Nov 2024 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UghehhMv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE36189F39
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662113; cv=none; b=Jy69N6w4EZvUgzCuv9s6mzMJavEwKkUU6FLgOVYr+88OiApQJ7+N86NQwpQX1ucJvZOZo3NVQ54XnYM8KClBQ3krOvEiWFICujK+jWGLr7/pmd5GpNhKOCffytH10VQyJydABu62Vha+iw0WTCDLG9rcY/4L1VWv3d7NSJn360g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662113; c=relaxed/simple;
	bh=JGcQJOfvTUFJj/MD2Hu4QlmPKdgk9EdvvQsKVG943GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKcunjnc+DD4qJGn2Qk2E8/9T8F8ykBfqIgVPLZggf9SCspatpE/6e1whrv3BVZfdMxMIHT6tphbqSlbEuoKcx8RO4CyXkbrhjGnLEMXqiDiwcYOvSnSI8AsLdtsDIBX+ipZLFE/Na9llkWb26MQhJP0lr/I8si20FrpfGIIQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UghehhMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AB1C4CECF;
	Fri, 15 Nov 2024 09:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731662112;
	bh=JGcQJOfvTUFJj/MD2Hu4QlmPKdgk9EdvvQsKVG943GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UghehhMvUJ5PBZM8CrNVwIFy42gb08UP6dc0/9g2YGdqdREUxGWlj12E1EGdUUVPF
	 uJFPsXWpSbxPIhvHFlmimdk6iP1KNt0fqFSkjXNKYP2pgiL+bPNfYpC3wLCpTb7Web
	 EU2qGkQs4zIggLYPL1g3bNap5ezDYxfSOS/xxxqGm06CNxzM8Z8BQjK+UK2gzbLI+J
	 HclkiEy+zyTvy5GbJlG05s4qwrf9R2LRDGNZuR0BVnlC0EsmPbSirMVhledONdtGjN
	 FQxCBSbA/legB2u5Z6L15iNfUHOVTClLWuvxY6bhyDgyPsc1bmd7aRGc3WNJ39vQi3
	 Ps8e8KNwg5YXA==
Date: Fri, 15 Nov 2024 10:15:07 +0100
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
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/4] PCI: mediatek-gen3: Move reset/assert callbacks
 in .power_up()
Message-ID: <ZzcRG3OInXZ2TP-Z@lore-rh-laptop>
References: <20241109-pcie-en7581-fixes-v2-0-0ea3a4af994f@kernel.org>
 <20241109-pcie-en7581-fixes-v2-3-0ea3a4af994f@kernel.org>
 <20241115090231.nwmxl6acspxqflpc@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SrMGir1++zYv7uQM"
Content-Disposition: inline
In-Reply-To: <20241115090231.nwmxl6acspxqflpc@thinkpad>


--SrMGir1++zYv7uQM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, Nov 09, 2024 at 10:28:39AM +0100, Lorenzo Bianconi wrote:
> > In order to make the code more readable, move phy and mac reset lines
> > assert/de-assert configuration in .power_up() callback
> > (mtk_pcie_en7581_power_up()/mtk_pcie_power_up()).
> >=20
>=20
> I don't understand how moving the code (duplicting it also) makes the cod=
e more
> readable. Could you please explain?

Hi Manivannan,

this has been requested by Bjorn in
https://patchwork.kernel.org/project/linux-pci/patch/aca00bd672ee576ad96d27=
9414fc0835ff31f637.1720022580.git.lorenzo@kernel.org/#26110282

>=20
> > Introduce PCIE_MTK_RESET_TIME_US macro for the time needed to
> > complete PCIe reset on MediaTek controller.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/pci/controller/pcie-mediatek-gen3.c | 28 ++++++++++++++++++++-=
-------
> >  1 file changed, 20 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/=
controller/pcie-mediatek-gen3.c
> > index 8c8c733a145634cdbfefd339f4a692f25a6e24de..1ad93d2407810ba873d9a16=
da96208b3cc0c3011 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -120,6 +120,9 @@
> > =20
> >  #define MAX_NUM_PHY_RESETS		3
> > =20
> > +/* Time in us needed to complete PCIe reset on MediaTek controller */
>=20
> No need of this comment. Macro name itself is explanatory.

ack, I will fix it.

Regards,
Lorenzo

>=20
> - Mani
>=20
> > +#define PCIE_MTK_RESET_TIME_US		10
> > +
> >  /* Time in ms needed to complete PCIe reset on EN7581 SoC */
> >  #define PCIE_EN7581_RESET_TIME_MS	100
> > =20
> > @@ -867,6 +870,14 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen=
3_pcie *pcie)
> >  	int err;
> >  	u32 val;
> > =20
> > +	/*
> > +	 * The controller may have been left out of reset by the bootloader
> > +	 * so make sure that we get a clean start by asserting resets here.
> > +	 */
> > +	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
> > +				  pcie->phy_resets);
> > +	reset_control_assert(pcie->mac_reset);
> > +
> >  	/*
> >  	 * Wait for the time needed to complete the bulk assert in
> >  	 * mtk_pcie_setup for EN7581 SoC.
> > @@ -941,6 +952,15 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie =
*pcie)
> >  	struct device *dev =3D pcie->dev;
> >  	int err;
> > =20
> > +	/*
> > +	 * The controller may have been left out of reset by the bootloader
> > +	 * so make sure that we get a clean start by asserting resets here.
> > +	 */
> > +	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
> > +				  pcie->phy_resets);
> > +	reset_control_assert(pcie->mac_reset);
> > +	usleep_range(PCIE_MTK_RESET_TIME_US, 2 * PCIE_MTK_RESET_TIME_US);
> > +
> >  	/* PHY power on and enable pipe clock */
> >  	err =3D reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets,=
 pcie->phy_resets);
> >  	if (err) {
> > @@ -1013,14 +1033,6 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *=
pcie)
> >  	 * counter since the bulk is shared.
> >  	 */
> >  	reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets, pcie->p=
hy_resets);
> > -	/*
> > -	 * The controller may have been left out of reset by the bootloader
> > -	 * so make sure that we get a clean start by asserting resets here.
> > -	 */
> > -	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets, pcie->phy=
_resets);
> > -
> > -	reset_control_assert(pcie->mac_reset);
> > -	usleep_range(10, 20);
> > =20
> >  	/* Don't touch the hardware registers before power up */
> >  	err =3D pcie->soc->power_up(pcie);
> >=20
> > --=20
> > 2.47.0
> >=20
>=20
> --=20
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

--SrMGir1++zYv7uQM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZzcRGAAKCRA6cBh0uS2t
rIZRAP9lkLZ21zAHZX2cmYhCDHsB3Dka4V3SIPgL3D0ExpmzTgEAoZVmGhfQHuM2
iBl8NcVaLGfGiQ8tT+Uf+4pk+FqFTgw=
=ZgWM
-----END PGP SIGNATURE-----

--SrMGir1++zYv7uQM--

