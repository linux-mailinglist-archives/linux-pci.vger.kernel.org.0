Return-Path: <linux-pci+bounces-21933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 592F1A3E7A1
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 23:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3015A7AB754
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 22:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C719D2641F8;
	Thu, 20 Feb 2025 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gObFMExE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2C52641E3;
	Thu, 20 Feb 2025 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740091198; cv=none; b=BfsMMUZc3EtntGSH7koxJlSbkOWfl62NDgdC5TUGaEQ9s6vAZ1K33iWAtOuhca+h/7pRJwTMdU6DZ3DncyLn++GkFeUk/IBpytH/JwMW51QQRlysHv7prx885NOYj+I89+G6A4eYY9jSnUvW/yko7/NBdx8sp/HzoLDVIgMc2L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740091198; c=relaxed/simple;
	bh=p1o9tsd4MJKpv+j9LivH9jaM7Ei2Uell1wpGa2aaLFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckjENPc7+PFRaT9XU4F04V/bLDFO+oRkEg+HApLQOxmBZaYz/M088BHqKXKWHIkcoAsBJIuCzsrPsAu2pkeT4IQ6VhGyWaoduLOQrzQwYITgVFPsK4qjItbpb2g3OSOM87SwXXHn69BIoBdzJrYzc34/ialhTZDUNITKCl8VN4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gObFMExE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916D7C4CED1;
	Thu, 20 Feb 2025 22:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740091197;
	bh=p1o9tsd4MJKpv+j9LivH9jaM7Ei2Uell1wpGa2aaLFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gObFMExEl5qdklvlvzVjuB8ZpB4OKMBuTGEWsmjPOLYv00dcOyrDIcIIQAomN34Qd
	 hKH6JZrkgQq7zEkBbhYapGDtiYyY0lHKVNoXsKP5Tr5Q1oHtQsZMgKHPWTEJDf7ZQv
	 PeOzR1giqrDEDlanmtoe1Wyj2NjjEpcULYoSTQ7RJQFsxKRw8O9IGhXJ29F2v5vsGc
	 9KuazZpl6KfofKziuSKIpk9s8eaJ3Oskpq56FyYQZlOpMSRLL9h6gGtBK8GDBHygKu
	 XfISsSXGB2jIJFzog/sPeYQkcTy1QA7vzji+7JPQwIpTnz1SQo3PdG3BkpSlzRoecy
	 a+Bnrt0wUYw5g==
Date: Thu, 20 Feb 2025 23:39:54 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
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
Message-ID: <Z7evOgTgCK_IL2i9@lore-desk>
References: <20250202-en7581-pcie-pbus-csr-v2-0-65dcb201c9a9@kernel.org>
 <20250202-en7581-pcie-pbus-csr-v2-2-65dcb201c9a9@kernel.org>
 <20250219182650.gxzlbl6ovgbacmkm@thinkpad>
 <Z7ePW/Y9vajLjPdr@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l8/woIF9RLKv3zSp"
Content-Disposition: inline
In-Reply-To: <Z7ePW/Y9vajLjPdr@lizhi-Precision-Tower-5810>


--l8/woIF9RLKv3zSp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Feb 19, 2025 at 11:56:50PM +0530, Manivannan Sadhasivam wrote:
> > On Sun, Feb 02, 2025 at 08:34:24PM +0100, Lorenzo Bianconi wrote:
> > > Configure PBus base address and address mask to allow the hw
> > > to detect if a given address is on PCIE0, PCIE1 or PCIE2.
> > >
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >
> > - Mani
> >
> > > ---
> > >  drivers/pci/controller/pcie-mediatek-gen3.c | 30 +++++++++++++++++++=
+++++++++-
> > >  1 file changed, 29 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pc=
i/controller/pcie-mediatek-gen3.c
> > > index aa24ac9aaecc749b53cfc4faf6399913d20cdbf2..9c2a592cae959de8fbe9c=
a5c5c2253f8eadf2c76 100644
> > > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > > @@ -15,6 +15,7 @@
> > >  #include <linux/irqchip/chained_irq.h>
> > >  #include <linux/irqdomain.h>
> > >  #include <linux/kernel.h>
> > > +#include <linux/mfd/syscon.h>
> > >  #include <linux/module.h>
> > >  #include <linux/msi.h>
> > >  #include <linux/of_device.h>
> > > @@ -24,6 +25,7 @@
> > >  #include <linux/platform_device.h>
> > >  #include <linux/pm_domain.h>
> > >  #include <linux/pm_runtime.h>
> > > +#include <linux/regmap.h>
> > >  #include <linux/reset.h>
> > >
> > >  #include "../pci.h"
> > > @@ -127,6 +129,13 @@
> > >
> > >  #define PCIE_MTK_RESET_TIME_US		10
> > >
> > > +#define PCIE_EN7581_PBUS_ADDR(_n)	(0x00 + ((_n) << 3))
> > > +#define PCIE_EN7581_PBUS_ADDR_MASK(_n)	(0x04 + ((_n) << 3))
> > > +#define PCIE_EN7581_PBUS_BASE_ADDR(_n)	\
> > > +	((_n) =3D=3D 2 ? 0x28000000 :	\
> > > +	 (_n) =3D=3D 1 ? 0x24000000 : 0x20000000)
>=20
> look like these data should be in dts ?
>=20
> > > +#define PCIE_EN7581_PBUS_BASE_ADDR_MASK	GENMASK(31, 26)
> > > +
> > >  /* Time in ms needed to complete PCIe reset on EN7581 SoC */
> > >  #define PCIE_EN7581_RESET_TIME_MS	100
> > >
> > > @@ -931,7 +940,8 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pc=
ie *pcie)
> > >  static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
> > >  {
> > >  	struct device *dev =3D pcie->dev;
> > > -	int err;
> > > +	struct regmap *map;
> > > +	int err, slot;
> > >  	u32 val;
> > >
> > >  	/*
> > > @@ -945,6 +955,24 @@ static int mtk_pcie_en7581_power_up(struct mtk_g=
en3_pcie *pcie)
> > >  	/* Wait for the time needed to complete the reset lines assert. */
> > >  	msleep(PCIE_EN7581_RESET_TIME_MS);
> > >
> > > +	map =3D syscon_regmap_lookup_by_phandle(dev->of_node,
> > > +					      "mediatek,pbus-csr");
> > > +	if (IS_ERR(map))
> > > +		return PTR_ERR(map);
> > > +
> > > +	/*
> > > +	 * Configure PBus base address and address mask to allow the
> > > +	 * hw to detect if a given address is on PCIE0, PCIE1 or PCIE2.
> > > +	 */
> > > +	slot =3D of_get_pci_domain_nr(dev->of_node);
>=20
> I am not sure if too much abuse domain_id here.
>=20
> > > +	if (slot < 0)
> > > +		return slot;
> > > +
> > > +	regmap_write(map, PCIE_EN7581_PBUS_ADDR(slot),
> > > +		     PCIE_EN7581_PBUS_BASE_ADDR(slot));
> > > +	regmap_write(map, PCIE_EN7581_PBUS_ADDR_MASK(slot),
> > > +		     PCIE_EN7581_PBUS_BASE_ADDR_MASK);
>=20
> look like
> 	syscon
> 	{
> 		csr1 : csr1 =3D
> 		{
> 			reg =3D <0x20000000, >; //or other property
> 		}
>=20
> 		csr2: csr2 =3D
> 		{
> 			....
> 		}
> 	}
>=20
> 	pcie1 {
> 		mediatek,pbus-csr =3D <&csr1>;
> 	}
>=20
> 	pcie2 {
>                 mediatek,pbus-csr =3D <&csr2>;
>         }
>=20
> 	...
>=20
> Or
> 	pcie1 {
>                 mediatek,pbus-csr =3D <&csr1 0x20000000>;
>         }
> 	...
>=20
> 	you can use syscon_regmap_lookup_by_phandle_args() to get address.
> Frank

ack, thx for the pointer. I will fix in v3.

Regards,
Lorenzo

>=20
>=20
> > > +
> > >  	/*
> > >  	 * Unlike the other MediaTek Gen3 controllers, the Airoha EN7581
> > >  	 * requires PHY initialization and power-on before PHY reset deasse=
rt.
> > >
> > > --
> > > 2.48.1
> > >
> >
> > --
> > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D

--l8/woIF9RLKv3zSp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ7evOgAKCRA6cBh0uS2t
rMtVAQDt7OKvwzSWH4diA2tOPVBk9hZhWEwF4ifot/vwEVB59AD8CJkJDxC/ETkp
7PzGTuXjh57IZJMnuAyy//jgFLBZfgo=
=lyct
-----END PGP SIGNATURE-----

--l8/woIF9RLKv3zSp--

