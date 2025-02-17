Return-Path: <linux-pci+bounces-21613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47034A382CC
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 13:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC143AC158
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 12:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4118D21773C;
	Mon, 17 Feb 2025 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zj3zJVGL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196BA18DB37;
	Mon, 17 Feb 2025 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739794743; cv=none; b=jYm0vk/D5h79EpR5M50012rHUPSVF8RcG7wReQSo+jHzT3Q1N5GO9fMKNjuGk1KD8dN6jjnNwJL/sHNg63LIG/S8HZBqPc+eln44rvAITYwHj/g6vfWnu7ik9RPKsvkgEwLOGpM9c0dycY8X5wj5yrH5U8G0ZXeN7/3fiIVBmCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739794743; c=relaxed/simple;
	bh=wyEMxJSE4ut2qD9vvgKYF1uHbf5olLm7PCB7mopaezc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRTNw8sV+SMEejLtrYPLL82eePjXyNoWuz434iFr1/b2sU8JN4Kc3qcxBZU4iCKXEyW1AXf4LPDxv2zmuk1cHSw/nCYwEjwFzv2IFKtCndqL+WY4i9L9n/RMykLG15QPzffuGPTzi3kmS+E/pUTe7ZVTXwsvV6xrApo+7RHCnqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zj3zJVGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256D2C4CED1;
	Mon, 17 Feb 2025 12:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739794742;
	bh=wyEMxJSE4ut2qD9vvgKYF1uHbf5olLm7PCB7mopaezc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zj3zJVGLaouZLXnzIJXFuNsrKpMsmPoeDnw9lLcRLibpLL+oIqHjoQnx53/NpJMaT
	 1obkaYTrOUIoO+baSTIgHL3v+87w0VtQxnnPh71a6wpmwuy0OlH/uutPpBt2ASdEXw
	 Y1a2lkUKXWaHGBHR/ao6nkcEvLaBe4SbvJCu0rwZySIQcJfLNqJO6AtZsIjlcQXqAt
	 FJ1jA4lLVpjCBWk1vSr7bY0oGqyJx9vu4bR5NYF+SFaWIvvWyyTLhAXMr3Qb/A0wlo
	 GUzWRedJnc7Q4WYfKXUEGhiklHWnDqROR2KlwtKY5zO7ZIHZUhEBsP01yqAW2DqRha
	 b95ToCfNsaezA==
Date: Mon, 17 Feb 2025 13:19:00 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] PCI: mediatek-gen3: Configure PBUS_CSR registers
 for EN7581 SoC
Message-ID: <Z7MpNADDFxPTX1Yy@lore-desk>
References: <20250202-en7581-pcie-pbus-csr-v2-0-65dcb201c9a9@kernel.org>
 <20250202-en7581-pcie-pbus-csr-v2-2-65dcb201c9a9@kernel.org>
 <20250214171106.ul3fwzcwhadhdwhj@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2DDNq2ksAqtJIqnN"
Content-Disposition: inline
In-Reply-To: <20250214171106.ul3fwzcwhadhdwhj@thinkpad>


--2DDNq2ksAqtJIqnN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, Feb 02, 2025 at 08:34:24PM +0100, Lorenzo Bianconi wrote:
> > Configure PBus base address and address mask to allow the hw
> > to detect if a given address is on PCIE0, PCIE1 or PCIE2.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/pci/controller/pcie-mediatek-gen3.c | 30 +++++++++++++++++++++=
+++++++-
> >  1 file changed, 29 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/=
controller/pcie-mediatek-gen3.c
> > index aa24ac9aaecc749b53cfc4faf6399913d20cdbf2..9c2a592cae959de8fbe9ca5=
c5c2253f8eadf2c76 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/irqchip/chained_irq.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/kernel.h>
> > +#include <linux/mfd/syscon.h>
> >  #include <linux/module.h>
> >  #include <linux/msi.h>
> >  #include <linux/of_device.h>
> > @@ -24,6 +25,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_domain.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> >  #include <linux/reset.h>
> > =20
> >  #include "../pci.h"
> > @@ -127,6 +129,13 @@
> > =20
> >  #define PCIE_MTK_RESET_TIME_US		10
> > =20
> > +#define PCIE_EN7581_PBUS_ADDR(_n)	(0x00 + ((_n) << 3))
> > +#define PCIE_EN7581_PBUS_ADDR_MASK(_n)	(0x04 + ((_n) << 3))
> > +#define PCIE_EN7581_PBUS_BASE_ADDR(_n)	\
> > +	((_n) =3D=3D 2 ? 0x28000000 :	\
> > +	 (_n) =3D=3D 1 ? 0x24000000 : 0x20000000)
> > +#define PCIE_EN7581_PBUS_BASE_ADDR_MASK	GENMASK(31, 26)
> > +
> >  /* Time in ms needed to complete PCIe reset on EN7581 SoC */
> >  #define PCIE_EN7581_RESET_TIME_MS	100
> > =20
> > @@ -931,7 +940,8 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie=
 *pcie)
> >  static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
> >  {
> >  	struct device *dev =3D pcie->dev;
> > -	int err;
> > +	struct regmap *map;
> > +	int err, slot;
> >  	u32 val;
> > =20
> >  	/*
> > @@ -945,6 +955,24 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen=
3_pcie *pcie)
> >  	/* Wait for the time needed to complete the reset lines assert. */
> >  	msleep(PCIE_EN7581_RESET_TIME_MS);
> > =20
> > +	map =3D syscon_regmap_lookup_by_phandle(dev->of_node,
> > +					      "mediatek,pbus-csr");
> > +	if (IS_ERR(map))
> > +		return PTR_ERR(map);
>=20
> So this is going to regress the devicetree's that do not define this sysc=
on
> region? But I do not see any devicetree using this 'airoha,en7581-pcie'
> compatible, so not sure if this is going to be an issue. Are the downstre=
am
> devicetrees used?

AFAIK there is no upstream or downstream (e.g. OpenWrt) en7581 dts with PCIe
support yet so I do not know if this is an issue or not. If so, I guess we
need to add the proper Fixes tag:

Fixes: f6ab898356dd ("PCI: mediatek-gen3: Add Airoha EN7581 support")

Regards,
Lorenzo

>=20
> - Mani
>=20
> --=20
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

--2DDNq2ksAqtJIqnN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ7MpNAAKCRA6cBh0uS2t
rIuEAP9rnTTRV1mWaP3Z7uCsLUu0NlHr8BpEtVsjDGVDIPv7+wEA9eryLOzy0dp5
zACOFi5/qvhsY75r70+bG8mpUeyRYg8=
=IvLf
-----END PGP SIGNATURE-----

--2DDNq2ksAqtJIqnN--

