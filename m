Return-Path: <linux-pci+bounces-16637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C4F9C6E28
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 12:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D462828DE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 11:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35202003C1;
	Wed, 13 Nov 2024 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Poj3bqoa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58C42003AD;
	Wed, 13 Nov 2024 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498649; cv=none; b=T4Nv4jT1bHPdWpp2gW20sNBxTFlzcbMljpMwz5SvU6XW6WgfpH70xX163d+LzpMd36Hu+fe/VN3KaCxLaX0kD/AdZHFnwt2/Ov1/nYiqCRMm7UVYK6XrkEpixdR35meAvUOyWjEqIp6/OrW0f7GKPm/DoN9jAeLhmCyVi58ehNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498649; c=relaxed/simple;
	bh=WExTZCA4yaeorpVmk/7SNgGCtCUo6G2L9EG0WxKDbh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2wbYjshuGajxr43hGglTL6PhNsJy6TezNdtKoy31lKrFSH8Ow51x5nU5QoipwHgGqEyftNWo7LGNWOcSQ3ii8uiEzYUwq/ZzDDrFOaTpgjQPCwZzBc2mhumhASbRYrGG9hs5Yw6Kl5AAG0r0e1Q5wmx5Pddfe4vE6RMPFHql5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Poj3bqoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CFBC4CECD;
	Wed, 13 Nov 2024 11:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731498649;
	bh=WExTZCA4yaeorpVmk/7SNgGCtCUo6G2L9EG0WxKDbh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Poj3bqoacwRuUlIv1Osav8qmvitBgJ9aL+r2j2aysowKPidLpjeJ9BQzX1n2wpEcd
	 cl99ZcPv+8GjrpLrdJJcmnO9QUVSfqvyilpMrPTB/s2PCKAW9ebvzsHtywWTTI0fxT
	 I+y0hEdptOITZO2wTz1Z3+FkODV8HzMlNNJ2upyUBiyEbFd6RqmfrZTOgtaXUS2NAA
	 7buhP7AwPdSamTvwO4uYCsLx7cNRUwG1NzO0IdFcKtAe4CV5BDASjL947TmdGW8qEX
	 SzRikgCwELGAJT9oDGL1/ptJBltK7vgYRxSGxk1kwvW5mwKdP+/NBApyhg2F2/utDb
	 qcLqK+eUqX5ig==
Date: Wed, 13 Nov 2024 11:50:44 +0000
From: Conor Dooley <conor@kernel.org>
To: daire.mcnamara@microchip.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	conor.dooley@microchip.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ilpo.jarvinen@linux.intel.com,
	kevin.xie@starfivetech.com
Subject: Re: [PATCH v10 0/3] Fix address translations on MPFS PCIe controller
Message-ID: <20241113-unified-humongous-cda4f06a6240@spud>
References: <20241011140043.1250030-1-daire.mcnamara@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sZDpzgRHz94KOTCd"
Content-Disposition: inline
In-Reply-To: <20241011140043.1250030-1-daire.mcnamara@microchip.com>


--sZDpzgRHz94KOTCd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey folks,

On Fri, Oct 11, 2024 at 03:00:40PM +0100, daire.mcnamara@microchip.com wrot=
e:
> From: Daire McNamara <daire.mcnamara@microchip.com>
>=20
> Hi all,
>=20
> On Microchip PolarFire SoC (MPFS), the PCIe controller is connected to the
> CPU via one of three Fabric Interface Connectors (FICs).  Each FIC present
> to the CPU complex as 64-bit AXI-M and 64-bit AXI-S.  To preserve
> compatibility with other PolarFire family members, the PCIe controller is
> connected to its encapsulating FIC via a 32-bit AXI-M and 32-bit AXI-S
> interface.
>=20
> Each FIC is implemented in FPGA logic and can incorporate logic along its=
 64-bit
> AXI-M to 32-bit AXI-M chain (including address translation) and, likewise=
, along
> its 32-bit AXI-S to 64-bit AXI-S chain (again including address translati=
on).
>=20
> In order to reduce the potential support space for the PCIe controller in
> this environment, MPFS supports certain reference designs for these addre=
ss
> translations: reference designs for cache-coherent memory accesses
> and reference designs for non-cache-coherent memory accesses. The precise
> details of these reference designs and associated customer guidelines
> recommending that customers adhere to the addressing schemes used in those
> reference designs are available from Microchip, but the implication for t=
he
> PCIe controller address translation between CPU-space and PCIe-space are:
>=20
> For outbound address translation, the PCIe controller address translation=
 tables
> are treated as if they are 32-bit only.  Any further address translation =
must
> be done in FPGA fabric.
>=20
> For inbound address translation, the PCIe controller is configurable for =
two
> cases:
> * In the case of cache-coherent designs, the base of the AXI-S side of the
>   address translation must be set to 0 and the size should be 4 GiB wide.=
 The
>   FPGA fabric must complete any address translations based on that 0-based
>   address translation.
> * In the case of non-cache coherent designs, the base of AXI-S side of the
>   address translation must be set to 0x8000'0000 and the size shall be 2 =
GiB
>   wide.  The FPGA fabric must complete any address translation based on t=
hat
>   0x80000000 base.
>=20
> So, for example, in the non-cache-coherent case, with a device tree prope=
rty
> that maps an inbound range from 0x10'0000'0000 in PCIe space to 0x10'0000=
'0000
> in CPU space, the PCIe rootport will translate a PCIe address of 0x10'000=
0'0000
> to an intermediate 32-bit AXI-S address of 0x8000'0000 and the FIC is
> responsible for translating that intermediate 32-bit AXI-S address of
> 0x8000'0000 to a 64-bit AXI-S address of 0x10'0000'0000.
>=20
> And similarly, for example, in the cache-coherent case, with a device tree
> property that maps an inbound range from 0x10'0000'0000 in PCIe space to
> 0x10'0000'0000 in CPU space, the PCIe rootport will translate a PCIe addr=
ess
> of 0x10'0000'0000 to an intermediate 32-bit AXI-S address of 0x0000'0000 =
and
> the FIC is responsible for translating that intermediate 32-bit AXI-S add=
ress
> of 0x0000'0000 to a 64-bit AXI-S address of 0x10'0000'0000.
>=20
> See https://lore.kernel.org/all/20220902142202.2437658-1-daire.mcnamara@m=
icrochip.com/T/
> for backstory.
>=20
> Changes since v9:
> - Dropped plda_setup_inbound_address_translation() from StarFive driver

Since I had some success bumping the other series for this driver, any
chance of some attention here?
AFAIK, Daire's addressed what's been pointed out by reviewers and
exempted the StarFive driver from overwriting the firmware-set values
with once calculated from DT as they requested.

Cheers,
Conor.

--sZDpzgRHz94KOTCd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzSSlAAKCRB4tDGHoIJi
0g1FAQC2u0D+iCxuqyDT+meB6fucL5/+NoT9+jBZbSOMhmwFuwEAtce6k4K9wbJC
7gjnNEUfwLGOHiS6J+f8vXAMSQx1lg8=
=bXAJ
-----END PGP SIGNATURE-----

--sZDpzgRHz94KOTCd--

