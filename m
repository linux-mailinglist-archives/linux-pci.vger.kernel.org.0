Return-Path: <linux-pci+bounces-19748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E53A10D4E
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 18:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C36A17A29D3
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 17:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ABA1F9F60;
	Tue, 14 Jan 2025 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shZOKpVB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6772D1F9F52;
	Tue, 14 Jan 2025 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874975; cv=none; b=S1P0pUVR9dG6CtbXqo60Ee4on//Gx1P7G3RhC2GEx2YPliL3SU1MpvvEzzbB4vtbRdp3baEFKfn73YjPJ+46fE/XpHPP/lNiXIgn/zKvGyOTVZ3MZvYBNL9Gp4sMuLVw/6+YJmPeOzYRD38mvKSAG+To1eV1eaK2KEkyte1qTEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874975; c=relaxed/simple;
	bh=vakzlSu8gGyMeYuYAvXAQVD+/c7CpXnXrkt59ASXPew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIHAEFNUjbibgZXFwdo7qW26SuFRo+v6AKmUA7moeF40g0iPnzUkkWU9JkBCGJHZ8VN9FqjsiWJd9oHJVJW0QPOz6DbmPa83kGdAjYu+/nG7h7jeFHYJQwSezYYd50fpuZWQHiR81/lpgd7O03SqR15ubYm9arDc22Me1JEEqUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shZOKpVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F51C4CEDD;
	Tue, 14 Jan 2025 17:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736874975;
	bh=vakzlSu8gGyMeYuYAvXAQVD+/c7CpXnXrkt59ASXPew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=shZOKpVBYQa62bI8IntW9zBsf97gRfuVtWhZt8pSFxXwiAAWhxpRheU51X6vGr5JA
	 Sqj5ftYNSTZjypDBwVOIcmoLnTm7XxqclH+UYyPtg/Jf7lcRHiqAeZe+N/sZ781DJE
	 RQ6czJBLYags8XtgB8IXNDW3kAtgXqFBJhsc2uj9HLmOvIwIJGxVttUu2pEAhaMxJn
	 MZUiwCO0LZIoAxYa+W+2cthNPkzsZLsGOwXvsDIooJLkM6NQae6GD4LEsHdBNky6mp
	 Pn3V3lFGQTUu1aOKCZmyo5l4ClVaIddNyJnIgSNdD6oiZzFxdUMjF+jHWwh4R1RANT
	 j+GHfCjvKVdQw==
Date: Tue, 14 Jan 2025 17:16:10 +0000
From: Conor Dooley <conor@kernel.org>
To: daire.mcnamara@microchip.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	conor.dooley@microchip.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ilpo.jarvinen@linux.intel.com,
	kevin.xie@starfivetech.com
Subject: Re: [PATCH v10 0/3] Fix address translations on MPFS PCIe controller
Message-ID: <20250114-espresso-display-846f670d2088@spud>
References: <20241011140043.1250030-1-daire.mcnamara@microchip.com>
 <20241113-unified-humongous-cda4f06a6240@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DWPIzAWKXiqE8nuk"
Content-Disposition: inline
In-Reply-To: <20241113-unified-humongous-cda4f06a6240@spud>


--DWPIzAWKXiqE8nuk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey folks,

Has this patchset fallen through the cracks?

Cheers,
Conor.

On Wed, Nov 13, 2024 at 11:50:44AM +0000, Conor Dooley wrote:
> On Fri, Oct 11, 2024 at 03:00:40PM +0100, daire.mcnamara@microchip.com wr=
ote:
> > From: Daire McNamara <daire.mcnamara@microchip.com>
> >=20
> > Hi all,
> >=20
> > On Microchip PolarFire SoC (MPFS), the PCIe controller is connected to =
the
> > CPU via one of three Fabric Interface Connectors (FICs).  Each FIC pres=
ent
> > to the CPU complex as 64-bit AXI-M and 64-bit AXI-S.  To preserve
> > compatibility with other PolarFire family members, the PCIe controller =
is
> > connected to its encapsulating FIC via a 32-bit AXI-M and 32-bit AXI-S
> > interface.
> >=20
> > Each FIC is implemented in FPGA logic and can incorporate logic along i=
ts 64-bit
> > AXI-M to 32-bit AXI-M chain (including address translation) and, likewi=
se, along
> > its 32-bit AXI-S to 64-bit AXI-S chain (again including address transla=
tion).
> >=20
> > In order to reduce the potential support space for the PCIe controller =
in
> > this environment, MPFS supports certain reference designs for these add=
ress
> > translations: reference designs for cache-coherent memory accesses
> > and reference designs for non-cache-coherent memory accesses. The preci=
se
> > details of these reference designs and associated customer guidelines
> > recommending that customers adhere to the addressing schemes used in th=
ose
> > reference designs are available from Microchip, but the implication for=
 the
> > PCIe controller address translation between CPU-space and PCIe-space ar=
e:
> >=20
> > For outbound address translation, the PCIe controller address translati=
on tables
> > are treated as if they are 32-bit only.  Any further address translatio=
n must
> > be done in FPGA fabric.
> >=20
> > For inbound address translation, the PCIe controller is configurable fo=
r two
> > cases:
> > * In the case of cache-coherent designs, the base of the AXI-S side of =
the
> >   address translation must be set to 0 and the size should be 4 GiB wid=
e. The
> >   FPGA fabric must complete any address translations based on that 0-ba=
sed
> >   address translation.
> > * In the case of non-cache coherent designs, the base of AXI-S side of =
the
> >   address translation must be set to 0x8000'0000 and the size shall be =
2 GiB
> >   wide.  The FPGA fabric must complete any address translation based on=
 that
> >   0x80000000 base.
> >=20
> > So, for example, in the non-cache-coherent case, with a device tree pro=
perty
> > that maps an inbound range from 0x10'0000'0000 in PCIe space to 0x10'00=
00'0000
> > in CPU space, the PCIe rootport will translate a PCIe address of 0x10'0=
000'0000
> > to an intermediate 32-bit AXI-S address of 0x8000'0000 and the FIC is
> > responsible for translating that intermediate 32-bit AXI-S address of
> > 0x8000'0000 to a 64-bit AXI-S address of 0x10'0000'0000.
> >=20
> > And similarly, for example, in the cache-coherent case, with a device t=
ree
> > property that maps an inbound range from 0x10'0000'0000 in PCIe space to
> > 0x10'0000'0000 in CPU space, the PCIe rootport will translate a PCIe ad=
dress
> > of 0x10'0000'0000 to an intermediate 32-bit AXI-S address of 0x0000'000=
0 and
> > the FIC is responsible for translating that intermediate 32-bit AXI-S a=
ddress
> > of 0x0000'0000 to a 64-bit AXI-S address of 0x10'0000'0000.
> >=20
> > See https://lore.kernel.org/all/20220902142202.2437658-1-daire.mcnamara=
@microchip.com/T/
> > for backstory.
> >=20
> > Changes since v9:
> > - Dropped plda_setup_inbound_address_translation() from StarFive driver
>=20
> Since I had some success bumping the other series for this driver, any
> chance of some attention here?
> AFAIK, Daire's addressed what's been pointed out by reviewers and
> exempted the StarFive driver from overwriting the firmware-set values
> with once calculated from DT as they requested.


--DWPIzAWKXiqE8nuk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ4ab2gAKCRB4tDGHoIJi
0vhRAPwNhrvfDp89x6F228OGP2dYlqrqBn1VL3af3DOMXUZC0AEAzAOHwIrkkYhl
VJQeznMVIiXmNutqnmdW0BBG4n8vQAg=
=/mvA
-----END PGP SIGNATURE-----

--DWPIzAWKXiqE8nuk--

