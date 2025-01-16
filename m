Return-Path: <linux-pci+bounces-19989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A36A13FCD
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 17:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDBFC16A964
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 16:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C432122A7E1;
	Thu, 16 Jan 2025 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOfFT6hz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9748E13959D;
	Thu, 16 Jan 2025 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737045984; cv=none; b=qFOBgJvyBjQSOKp7OfvwhOdire1ZGJV3L2GnpyA4ZLipVI81veBa/rk/TrRJAE4Qkc0/3zgBCqJa9IW+JnDryzpSjMzZvbyPQ66GY78oHC8WHElsswbFi6Smv8JJnZrhUFDdnCF5KySJM1HDUJ7eDRf1xFcUnOu03p0SBKjLn2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737045984; c=relaxed/simple;
	bh=L/KZG4Pm9PuHsf+j03WeS+nOje6TuEkm+2ySm7d+8gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuCPLy10ohKHOa525NSqDn00NFGgPJOncmKX5OuBnkI7UsRaTZZ7E6qnGGJq/K8a0ciuDvuN3+pybhE/Z94pPN18ElGEGx+VeAAo0qd7QArJv/I520epDamNdBgR8Cbe+CSbd/nXv22DAcWB9aIFOi67elj3auqHos/pdTs6Azc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOfFT6hz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A581DC4CED6;
	Thu, 16 Jan 2025 16:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737045984;
	bh=L/KZG4Pm9PuHsf+j03WeS+nOje6TuEkm+2ySm7d+8gE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rOfFT6hzINfBNG2t5Ib7U6Py9ZdRmVfFv4p5E5ARNWl0UfYKz+JM87qYpw114/8v7
	 +OM7BfMT183k0cdGd6LHwGhxgZmUY+rO/OeOiNM221osCENMeW2mfIwdVCYj235ZEA
	 CQgCTLnmrB+XOQXQinlOsrRxxWKGN3tEvHL1Er1dnRrycMJ0VcKeqYHL+uwFWXltKC
	 vXgGHMG9+4GtMN1LqLStiFDs7bYVq1/e/oVp4K9Xt03l/0DyvbEzlBDj2i2gDczd0S
	 ZhyY/jPEyrdgM6ISRnREe77DVAOIm4CYrKwKFrwi3oA9Pr58m8+9c22zz9C57K78xO
	 NRdOteiiOwIJA==
Date: Thu, 16 Jan 2025 16:46:19 +0000
From: Conor Dooley <conor@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: daire.mcnamara@microchip.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, conor.dooley@microchip.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ilpo.jarvinen@linux.intel.com,
	kevin.xie@starfivetech.com
Subject: Re: [PATCH v10 1/3] PCI: microchip: Fix outbound address translation
 tables
Message-ID: <20250116-debatable-hazelnut-6501986373fa@spud>
References: <20250115001309.GA508227@bhelgaas>
 <20250116154253.GA584488@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dISYL3zSj/IQb+CW"
Content-Disposition: inline
In-Reply-To: <20250116154253.GA584488@bhelgaas>


--dISYL3zSj/IQb+CW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 09:42:53AM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 14, 2025 at 06:13:10PM -0600, Bjorn Helgaas wrote:
> > On Fri, Oct 11, 2024 at 03:00:41PM +0100, daire.mcnamara@microchip.com =
wrote:
> > > From: Daire McNamara <daire.mcnamara@microchip.com>
> > >=20
> > > On Microchip PolarFire SoC (MPFS) the PCIe Root Port can be behind on=
e of
> > > three general-purpose Fabric Interface Controller (FIC) buses that
> > > encapsulate an AXI-M interface. That FIC is responsible for managing
> > > the translations of the upper 32-bits of the AXI-M address. On MPFS,
> > > the Root Port driver needs to take account of that outbound address
> > > translation done by the parent FIC bus before setting up its own
> > > outbound address translation tables.  In all cases on MPFS,
> > > the remaining outbound address translation tables are 32-bit only.
> > >=20
> > > Limit the outbound address translation tables to 32-bit only.
> >=20
> > I don't quite understand what this is saying.  It seems like the code
> > keeps only the low 32 bits of a PCI address and throws away any
> > address bits above the low 32.
> >=20
> > If that's what the FIC does, I wouldn't describe the FIC as
> > "translating the upper 32 bits" since it sounds like the translation
> > is just truncation.
> >=20
> > I guess it must be more complicated than that?  I assume you can still
> > reach BARs that have PCI addresses above 4GB using CPU loads/stores?
> >=20
> > The apertures through the host bridge for MMIO access are described by
> > DT ranges properties, so this must be something that can't be
> > described that way?
>=20
> Ping?  I'd really like to understand this before the v6.14 merge
> window opens on Sunday.

Daire's been having some issues getting onto the corporate VPN to send
his reply, I've pasted it below on his behalf:

There are 3 Fabric Inter Connect (FIC) buses on PolarFire SoC - each of
these FIC buses contain an AXI master bus and are 64-bits wide. These
AXI-Masters (each with an individual 64-bit AXI base address =E2=80=93 for =
example
FIC1=E2=80=99s AXI Master has a base address of 0x2000000000) are connected=
 to
general purpose FPGA logic. This FPGA logic is, in turn, connected to a
2nd 32-bit AXI master which is attached to the PCIe block in RootPort mode.
Conceptually, on the other side of this configurable logic, there is a
32-bit bus to a hard PCIe rootport.  So, again conceptually, outbound addre=
ss
translation looks like this:

                 Processor Complex =C3=A0 FIC (64-bit AXI-M) =C3=A0 Configu=
rable Logic =C3=A0 32-bit AXI-M =C3=A0 PCIe Rootport
		 (This how it came to me from Daire, I think the =C3=A1 is meant to
		 be an arrow)

 This allows a designer two broad choices:

    Choice of FIC (effectively choice of AXI bus)
    Ability to offset the AXI address of any peripherals they add in the
    Fabric.

=20

So, for the case of an outbound AXI address, from the processors=E2=80=99 p=
oint
of view (or Linux=E2=80=99 point of view if you prefer), the processor uses=
 a
64-bit AXI address, then =E2=80=93 in a very general way of viewing the pro=
cess
and thinking only about accessing the PCIe device =E2=80=93 the FPGA logic =
can
be configured to adjust that AXI-M address to any arbitrary =E2=80=9Caddres=
s=E2=80=9D
before it passes that new =E2=80=9Caddress=E2=80=9D to the Root Port over a=
 second 32-bit
AXI bus (the main constraint is that the FPGA logic can only use a 32-bit
address on that AXI-M interface to the Root Port).

=20

To manage this complexity, Microchip have design rules for customers
building their FPGA logic where we strongly recommend that they only
interact with  the upper 32 bits of the 64-bit address in the FPGA logic
and pass the lower 32 bits through (unmodified) to the AXI-M side of the
PCIe Root Port. This allows them to =E2=80=9Cmove=E2=80=9D a 64-bit AXI-M w=
indow for their
PCIe Root Port (as viewed by the processor) for their particular design =E2=
=80=93
if they need to - so that they can also access any other AXI-M windows
associated with any other peripherals they might add to their design.

=20

In practise, so far, all customers, and our own internal boards have all
started by using one of two major reference designs from us (one using FIC1
where the AXI-M window destined for the PCIe Root Port starts at 0x20000000=
00
and one using FIC2 where its AXI-M window, again destined for the PCIe Root
Port starts at 0x3000000000).

best,

daire

--dISYL3zSj/IQb+CW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ4k32wAKCRB4tDGHoIJi
0r8aAP9OljF2t/djmQEXjTcwQv5O/kjOlC4cmIz8YFYInFE7uQEAir30agpuqLBv
IoeWvvIUCLBDbl111pYfb88kL/pz0gY=
=NBkU
-----END PGP SIGNATURE-----

--dISYL3zSj/IQb+CW--

