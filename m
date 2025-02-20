Return-Path: <linux-pci+bounces-21928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C72A3E55C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 20:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCD218951FA
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 19:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB351E47B3;
	Thu, 20 Feb 2025 19:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQg7iSG9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFF71B21BD;
	Thu, 20 Feb 2025 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081250; cv=none; b=EksoG/HZvlfyaaEiRN5PUQXdAd96eKqnyLkgBMMHhOrel7Kv4k+oeIcoAcjpbvTSTU+zO8Y/N83WYaPoC77qEBZoau/f+rM32MrzeJtgFHY76wS2ty7q85Reqfb5fv5++Hdty6uLsgrkrkEOn2JpjogxS+bx6kWiXWnZx/UABr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081250; c=relaxed/simple;
	bh=a9vt04KA1MDS4IICjnNI7NCM4qTVHSnqdKEThe5pCWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccbgIQ3XTA1b1gVYePiCatFSIvVftcMaKhHwOoFiBQrXYxR6qWmm1Qq8xYm4uBRTFhClB4X48qMCcRTSm9XkcdzBfRDf1uOyn60ybCL8v40LyEsQyPi/ayvdrHpmzJldv3jD1CQKT4hcjpR+sfiPdefcEGVnnVEIx6GCkV3p550=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQg7iSG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D37C4CED1;
	Thu, 20 Feb 2025 19:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740081249;
	bh=a9vt04KA1MDS4IICjnNI7NCM4qTVHSnqdKEThe5pCWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MQg7iSG9gDofeH2db6FMxQ4jnpVbPFEcDl8ph5EUlpJO8G63JdIlDLObGPuKS5pMI
	 lk17YCoLTggN4zVHaZMNBM9CzEwry5dgb7VzyXza5dkMOeU/bhoRLTjw68HqrLmGyv
	 IBn6xG2Krt+uxu94rpTlrt8P8q9vBgGpSPXM1l0Kj2rM/X22wJaLSEOEY1Z8XebjUL
	 wv3WIjR6/54P8pi0qBaEnYTl8t9Uk45zyKl3saOXo4/EjXONd7EQp+Pnw4PAVSVDKu
	 yT6799UpILNO0RMUvOkUGbRBMUxxdfe89QZ9RGOg8A6KDbfu/zYWQ52HY4JcvcjF94
	 vXffU5owGoIzQ==
Date: Thu, 20 Feb 2025 20:54:06 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] PCI: mediatek-gen3: Configure PBUS_CSR registers
 for EN7581 SoC
Message-ID: <Z7eIXsupArd8xH7_@lore-desk>
References: <20250202-en7581-pcie-pbus-csr-v2-2-65dcb201c9a9@kernel.org>
 <20250220182046.GA304343@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r7/KtajXtvVLSXMm"
Content-Disposition: inline
In-Reply-To: <20250220182046.GA304343@bhelgaas>


--r7/KtajXtvVLSXMm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 20, Bjorn Helgaas wrote:
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
>=20
> Are these addresses something that should be expressed in devicetree?

Do you have any example/pointer for it?

> It seems unusual to encode addresses directly in a driver.

AFAIK they are fixed for EN7581 SoC.

Regards,
Lorenzo

>=20
> Bjorn

--r7/KtajXtvVLSXMm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ7eIXgAKCRA6cBh0uS2t
rODVAQCdAljwq2vNJmbULwgMrd2Aor9AHVtCJcbBL3l5en3JtwD+Iruof33D+sne
2PSsZLFo/2Gaai40Zvly4mtcqRcDGAs=
=lTq/
-----END PGP SIGNATURE-----

--r7/KtajXtvVLSXMm--

