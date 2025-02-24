Return-Path: <linux-pci+bounces-22186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8F2A41A59
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 11:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E533A787C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 10:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53AA250BE7;
	Mon, 24 Feb 2025 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5Pc+1tm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C40C24BBEF;
	Mon, 24 Feb 2025 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391527; cv=none; b=uoQMcVII+kGCxjgL7x+VoAZqLbvUL7YwTo/1NIQEzG1OonAfRy6QshXcwMx4PYk4x7PewhaEpybHjXtu+ptfkhk3k5NDath2kbiifTWweXp91plUTYFgkZO6yZ1u1P1gyH6qJmdJoyYk/e1B+3+Evf3Wltyoq1wNJMP6SSQeVi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391527; c=relaxed/simple;
	bh=wEPIfbmOGYU8PFcnIOPk2XbR2HBdhU31GqS8u7rbNnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meZAdy0uMjS+OuGZ5ELVpO8lBg4KC5KsT6PT/2erobMSJsApFvukPQNcESMF3OmF1E6/eEZg6x4ik2zgtCGXlEPAYymp+Xz7OOLHhXzN+OsxMJkYjnf4dq0rFzL690QYvq5nzWw2NLiPYPic9e2FIhbw9Pv/iRc5jDR78n2EfbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5Pc+1tm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881C1C4CED6;
	Mon, 24 Feb 2025 10:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740391527;
	bh=wEPIfbmOGYU8PFcnIOPk2XbR2HBdhU31GqS8u7rbNnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P5Pc+1tmhpkcRZCCeN11NsfalT6DwwEIx2gIyIrWPAeoRIBi2eurs9bxsWgiJ87eX
	 OVSKflTtnS5ZGxn+6TR7ibhqEe2h337VuaeQ3WzEhoKbvv+8sPSQ6JYezBtZK/1Yda
	 CicWrE0UKmdulEgb8TNqdjuA7ZGzLy7EHRzSPn7/lY3hd7ukOxVHKvdqY20aqw51kN
	 4TKQeXN9ysstGViRPBQh+ljrdBWGjlifPXl5K3KuU43t0d/BO0BLgpmNgIpTJzGhpp
	 GiuO60mVLEpEHeKbc16uSt7U4OWBaGunMfgB1nZSmiJ3BhFUrzfvDDVz3slPQZj/V4
	 K4CZvSz3lEBCA==
Date: Mon, 24 Feb 2025 11:05:24 +0100
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
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v3 2/2] PCI: mediatek-gen3: Configure PBUS_CSR registers
 for EN7581 SoC
Message-ID: <Z7xEZPpWLQjTMnIz@lore-desk>
References: <20250222-en7581-pcie-pbus-csr-v3-0-e0cca1f4d394@kernel.org>
 <20250222-en7581-pcie-pbus-csr-v3-2-e0cca1f4d394@kernel.org>
 <20250224055216.o23dzwimrghbr2ow@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9HSvn9LCGzDjJLIz"
Content-Disposition: inline
In-Reply-To: <20250224055216.o23dzwimrghbr2ow@thinkpad>


--9HSvn9LCGzDjJLIz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, Feb 22, 2025 at 11:43:45AM +0100, Lorenzo Bianconi wrote:

[...]

> > +
> > +	entry =3D resource_list_first_type(&host->windows, IORESOURCE_MEM);
> > +	if (!entry)
> > +		return -EINVAL;
>=20
> -ENODEV or -ENOMEM

ack, I will fix it in v4

>=20
> > +
> > +	addr =3D entry->res->start - entry->offset;
> > +	err =3D regmap_write(pbus_regmap, args[0], lower_32_bits(addr));
> > +	if (err)
>=20
> MMIO write is not supposed to fail.

ack, I will fix it in v4

>=20
> > +		return err;
> > +
> > +	size =3D lower_32_bits(resource_size(entry->res));
> > +	mask =3D size ? GENMASK(31, __fls(size)) : 0;
>=20
> Size of MEM region could be 0?

I added this check since we consider just lower_32_bits().
Do you think we should remove it?

>=20
> > +	err =3D regmap_write(pbus_regmap, args[1], mask);
> > +	if (err)
>=20
> MMIO write is not supposed to fail.

ack, I will fix it in v4

BTW I will remove your Reviwed-by tag since the patch has changed
with respect to the one you added it. Please let me know if you
prepfer to keep it.

Regards,
Lorenzo

>=20
> - Mani
>=20
> --=20
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

--9HSvn9LCGzDjJLIz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ7xEZAAKCRA6cBh0uS2t
rDHbAQCOVe744bx7qYVotAU7cnjssZp8JuF9Yjujz5rxPDkOmQEAiu1GLPn0lTz9
yCYh9rg8gckaHCPDrNtWImF2kRicoQ8=
=UbPO
-----END PGP SIGNATURE-----

--9HSvn9LCGzDjJLIz--

