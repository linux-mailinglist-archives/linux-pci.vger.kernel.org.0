Return-Path: <linux-pci+bounces-22050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D7AA40361
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 00:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE1217A06F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 23:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59B31FF1A9;
	Fri, 21 Feb 2025 23:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+u+7RU9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A22417CA17;
	Fri, 21 Feb 2025 23:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740179935; cv=none; b=EBuzjjVD0QV07bv8Wgw6uY1DaMx+jjV7tPXN4hH76G4ZzzrAWkyEvyIubsu9SsSkI2zX04+cEteRU9JRAKlOhSEyZU3i+Uj6YeX0vV3EtF+s0UPPt1NAX5f371nEVmJ0OS5YqX6nNGUIRAQpM3HJv+yCTlV7rOUfjZcw0wCPL38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740179935; c=relaxed/simple;
	bh=bh8MK+CIx4qSkdZpY0HJlhJNS5esuf77OVKu5WUvHuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQWV0FWCwjWTFKI18J7EnkBM+QWhxlIXTdxzOg0DzTT+WYg1XYSc2C0I5SdZ4efXkmVU2Pl0WucOHI9iVlDbCJxKUZxoFy76jjPPcZxszOaRuAxBIzoyDjn1zmrHuRUuhGDXs2yqEtfzlSPJo1Dr0n6YwTKmQf8tcUbKYco/2wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+u+7RU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAAFC4CED6;
	Fri, 21 Feb 2025 23:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740179935;
	bh=bh8MK+CIx4qSkdZpY0HJlhJNS5esuf77OVKu5WUvHuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H+u+7RU9a0icTCmI0SZc7EVHIeD1fpkft5BFO35JBXIHy7/91y2cX9lMr8JRft8ZQ
	 GQ4TGaMhaRKlYo6cmKFUZoKQffJGjNYute5/KweKyYHXQ2J7/AbMEj3pT1AR/lm6/I
	 0OWpTUoS2A9uJAds4htiS6Mzr6iIRINF1GRVeSH594Sjv0ndDbZDDKKPa3FRRafarz
	 StI2Qt6QjA4DMm57clg6MoVQDUx8rZ+wR5qe53Kjq/ZJfnkfhUn2E5cRZvrB5v/F65
	 0wPg6meOtdfdD+TFPN5WWZlookkaLs87u8RZ+YO+ZSHwzDurxdD860pO64tpiy6JZQ
	 fNpeyWYSIaeGg==
Date: Sat, 22 Feb 2025 00:18:52 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hui Ma =?utf-8?B?KOmprOaFpyk=?= <Hui.Ma@airoha.com>,
	Ryder Lee <Ryder.Lee@mediatek.com>,
	Jianjun Wang =?utf-8?B?KOeOi+W7uuWGmyk=?= <Jianjun.Wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Frank Li <Frank.li@nxp.com>, upstream <upstream@airoha.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMi8y?= =?utf-8?Q?=5D_PCI?=
 =?utf-8?Q?=3A?= mediatek-gen3: Configure PBUS_CSR registers for EN7581 SoC
Message-ID: <Z7kJ3Ejd4Mi_Lj0b@lore-desk>
References: <SG2PR03MB6341ACD4DADDB280A8ACAA29FFC72@SG2PR03MB6341.apcprd03.prod.outlook.com>
 <20250221183131.GA353053@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hp33MBzSzf7qlCOL"
Content-Disposition: inline
In-Reply-To: <20250221183131.GA353053@bhelgaas>


--hp33MBzSzf7qlCOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]

> >
> > 	Pbus-csr (base and mask) is used to determine the address
> > 	range can be access by PCIe bus.
> >=20
> > 1FBE3400 PCIE0_MEM_BASE 32 PCIE0 base address
> > 1FBE3404 PCIE0_MEM_MASK 32 PCIE0 base address mask
> > 1FBE3408 PCIE1_MEM_BASE 32 PCIE1 base address
> > 1FBE340C PCIE1_MEM_MASK 32 PCIE1 base address mask
> > 1FBE3410 PCIE2_MEM_BASE 32 PCIE2 base address
> > 1FBE3414 PCIE2_MEM_MASK 32 PCIE2 base address mask
>=20
> "Can be accessed by PCIe bus" sounds like DMA.  Is that what you mean?
>=20
> I doubt it, because if you have multiple host bridges, I assume they
> would all be able to handle DMA to all of system memory.
>=20
> It would make more sense if this is some sort of description of host
> bridge apertures, e.g., something like this to allow CPU MMIO accesses
> to reach the first 2GB of PCI memory space below any of the pcie0,
> pcie1, pcie2 host bridges:
>=20
>   pcie0 0000:00: root bus resource [mem 0x84000000000-0x8407fffffff] (bus=
 address [0x00000000-0x7fffffff])
>   pcie1 0001:00: root bus resource [mem 0x84100000000-0x8417fffffff] (bus=
 address [0x00000000-0x7fffffff])
>   pcie2 0002:00: root bus resource [mem 0x84200000000-0x8427fffffff] (bus=
 address [0x00000000-0x7fffffff])
>=20
> But I think this would be described via 'ranges' properties.  And I
> think it would make sense if the driver had to learn this address map
> from devicetree and program it into the hardware, so maybe that's
> what Pbus-csr is for?  Total speculation on my part.

I agree we should provide these info to the driver via the dts.

Do you agree to pass the register offsets, base address and base mask values
in the 'mediatek,pbus-csr' phandle array? Something like:

pcie0: pcie@1fc00000 {
	...
	mediatek,pbus-csr =3D <&pbus_csr 0x0 0x20000000 0x4 0xfc000000>;
	...
}

where:
- reg offset for base address:	0x0
- base address value:		0x20000000
- reg offset for base mask:	0x4
- base mask value:		0xfc000000

Or do you prefer to just pass register offsets in mediatek,pbus-csr phandle
array and get base address values reading ranges property? Something like:

pcie0: pcie@1fc00000 {
	...
	ranges =3D <0x02000000 0 0x20000000 0x0 0x20000000 0 0x4000000>;
	...
	mediatek,pbus-csr =3D <&pbus_csr 0x0 0x4>;
	...
}

Considering the latter, even if it is not a real problem for EN7581 since we
have just a single range, what if we have multiple ranges?

Regards,
Lorenzo

>=20
> Bjorn

--hp33MBzSzf7qlCOL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ7kJ3AAKCRA6cBh0uS2t
rEKAAQDNYeXQYGRzd9+9wAO0ybTsoTJ2fnuWrjzrVO6+sUE+LwD/QJLaQ4gD9o+V
fBwmUiVyD2DtiPqn6pxkbb3L2+XrbQI=
=bd+w
-----END PGP SIGNATURE-----

--hp33MBzSzf7qlCOL--

