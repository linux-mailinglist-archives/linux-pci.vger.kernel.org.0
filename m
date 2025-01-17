Return-Path: <linux-pci+bounces-20054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07368A14E02
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 11:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E40DF7A14CE
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 10:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518A91FCD11;
	Fri, 17 Jan 2025 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQ5DSdcE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232331F91FF;
	Fri, 17 Jan 2025 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737111187; cv=none; b=Utr+oFjXHBIcz+GbaUEL/Fwcnx7WWRnsNQka7Kd2DNTgd9mCMwbVic6E++9ZDFn/iHucfUuCXENdbAPp+yH5Sn/pT73wxoRqwzvo6k/CRfGZqMy6rf3QMsH/6Xi3P2WfOTZzUGf6f60lsBYJKItXvmseD+6gsHg3kmilJ6QgImI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737111187; c=relaxed/simple;
	bh=clfmPsDnhw+wE0upSIEwc6wMMI+dZgv1+mZMbJmb82g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COH/9Eviivq5dXpOI/Lc3mRfNBr5Fm7G8tSLhxcy+1gsTT9snLkZfsNbvCKvawpZuH1bfcbCn3lfdhdPILVlAkqH8mRymBPBV1GHoNYhuhlkZJonTnOWZoqBUefAwV94Np76Tuck+/P0cL7j3l86Ldfb4EhbShHAsZAsORtRlE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQ5DSdcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC224C4CEE2;
	Fri, 17 Jan 2025 10:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737111186;
	bh=clfmPsDnhw+wE0upSIEwc6wMMI+dZgv1+mZMbJmb82g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQ5DSdcEkUPFYvHlXHE2A3iioHbUm8cVXx7u1kaT7Q4abfLBMul8QHLM+H2CrzTwG
	 CQPn9ykaK3DoxKpj/p3PaPfli9VfxF8SZ8hCXhqRiF4UpKgG2cYbqCn09M7Bz6GQtM
	 /cycsAhuI07gz5fGKLirnUrQYpvLGkA8DvCgABOSgdSP3/Nf/2T25oXYf49z7FjUUv
	 HxC5EriEIOsFfPxHXXULyjjGHv6qct9NEQHDayaGFHUn7CiZ5YVuB1/UJBcucq5hoC
	 oiBTn7cLIxPGBlf6C7e5hi0chkCkNjtUw/3VxSngzPzVJpl/2Vd2gnkj4bpFWyws8O
	 o8TllyWw8ENAg==
Date: Fri, 17 Jan 2025 10:53:01 +0000
From: Conor Dooley <conor@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: daire.mcnamara@microchip.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, conor.dooley@microchip.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ilpo.jarvinen@linux.intel.com,
	kevin.xie@starfivetech.com, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v10 1/3] PCI: microchip: Fix outbound address translation
 tables
Message-ID: <20250117-curliness-flashback-83519e708b52@spud>
References: <20250116-removed-evoke-1908811ab92a@spud>
 <20250116180255.GA593378@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="naCVrCOd0vJ9L2aC"
Content-Disposition: inline
In-Reply-To: <20250116180255.GA593378@bhelgaas>


--naCVrCOd0vJ9L2aC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 12:02:55PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 16, 2025 at 05:45:33PM +0000, Conor Dooley wrote:
> > On Thu, Jan 16, 2025 at 11:07:22AM -0600, Bjorn Helgaas wrote:
> > > [+cc Frank, original patch at
> > > https://lore.kernel.org/r/20241011140043.1250030-2-daire.mcnamara@mic=
rochip.com]
> > >=20
> > > On Thu, Jan 16, 2025 at 04:46:19PM +0000, Conor Dooley wrote:
> > > > On Thu, Jan 16, 2025 at 09:42:53AM -0600, Bjorn Helgaas wrote:
> > > > > On Tue, Jan 14, 2025 at 06:13:10PM -0600, Bjorn Helgaas wrote:
> > > > > > On Fri, Oct 11, 2024 at 03:00:41PM +0100, daire.mcnamara@microc=
hip.com wrote:
> > > > > > > From: Daire McNamara <daire.mcnamara@microchip.com>
> > > > > > >=20
> > > > > > > On Microchip PolarFire SoC (MPFS) the PCIe Root Port can be b=
ehind one of
> > > > > > > three general-purpose Fabric Interface Controller (FIC) buses=
 that
> > > > > > > encapsulate an AXI-M interface. That FIC is responsible for m=
anaging
> > > > > > > the translations of the upper 32-bits of the AXI-M address. O=
n MPFS,
> > > > > > > the Root Port driver needs to take account of that outbound a=
ddress
> > > > > > > translation done by the parent FIC bus before setting up its =
own
> > > > > > > outbound address translation tables.  In all cases on MPFS,
> > > > > > > the remaining outbound address translation tables are 32-bit =
only.
> > > > > > >=20
> > > > > > > Limit the outbound address translation tables to 32-bit only.
> > > > > >=20
> > > > > > I don't quite understand what this is saying.  It seems like th=
e code
> > > > > > keeps only the low 32 bits of a PCI address and throws away any
> > > > > > address bits above the low 32.
> > > > > >=20
> > > > > > If that's what the FIC does, I wouldn't describe the FIC as
> > > > > > "translating the upper 32 bits" since it sounds like the transl=
ation
> > > > > > is just truncation.
> > > > > >=20
> > > > > > I guess it must be more complicated than that?  I assume you ca=
n still
> > > > > > reach BARs that have PCI addresses above 4GB using CPU loads/st=
ores?
> > > > > >=20
> > > > > > The apertures through the host bridge for MMIO access are descr=
ibed by
> > > > > > DT ranges properties, so this must be something that can't be
> > > > > > described that way?
> > > > >=20
> > > > > Ping?  I'd really like to understand this before the v6.14 merge
> > > > > window opens on Sunday.
> > > >=20
> > > > Daire's been having some issues getting onto the corporate VPN to s=
end
> > > > his reply, I've pasted it below on his behalf:
> > > >=20
> > > > There are 3 Fabric Inter Connect (FIC) buses on PolarFire SoC - eac=
h of
> > > > these FIC buses contain an AXI master bus and are 64-bits wide. The=
se
> > > > AXI-Masters (each with an individual 64-bit AXI base address =E2=80=
=93 for example
> > > > FIC1=E2=80=99s AXI Master has a base address of 0x2000000000) are c=
onnected to
> > > > general purpose FPGA logic. This FPGA logic is, in turn, connected =
to a
> > > > 2nd 32-bit AXI master which is attached to the PCIe block in RootPo=
rt mode.
> > > > Conceptually, on the other side of this configurable logic, there i=
s a
> > > > 32-bit bus to a hard PCIe rootport.  So, again conceptually, outbou=
nd address
> > > > translation looks like this:
> > > >=20
> > > >                  Processor Complex =C3=A0 FIC (64-bit AXI-M) =C3=A0=
 Configurable Logic =C3=A0 32-bit AXI-M =C3=A0 PCIe Rootport
> > > > 		 (This how it came to me from Daire, I think the =C3=A1 is meant =
to
> > > > 		 be an arrow)
> > > >=20
> > > >  This allows a designer two broad choices:
> > > >=20
> > > >     Choice of FIC (effectively choice of AXI bus)
> > > >     Ability to offset the AXI address of any peripherals they add i=
n the
> > > >     Fabric.
> > > >=20
> > > > So, for the case of an outbound AXI address, from the processors=E2=
=80=99 point
> > > > of view (or Linux=E2=80=99 point of view if you prefer), the proces=
sor uses a
> > > > 64-bit AXI address, then =E2=80=93 in a very general way of viewing=
 the process
> > > > and thinking only about accessing the PCIe device =E2=80=93 the FPG=
A logic can
> > > > be configured to adjust that AXI-M address to any arbitrary =E2=80=
=9Caddress=E2=80=9D
> > > > before it passes that new =E2=80=9Caddress=E2=80=9D to the Root Por=
t over a second 32-bit
> > > > AXI bus (the main constraint is that the FPGA logic can only use a =
32-bit
> > > > address on that AXI-M interface to the Root Port).
> > > >=20
> > > > To manage this complexity, Microchip have design rules for customers
> > > > building their FPGA logic where we strongly recommend that they only
> > > > interact with  the upper 32 bits of the 64-bit address in the FPGA =
logic
> > > > and pass the lower 32 bits through (unmodified) to the AXI-M side o=
f the
> > > > PCIe Root Port. This allows them to =E2=80=9Cmove=E2=80=9D a 64-bit=
 AXI-M window for their
> > > > PCIe Root Port (as viewed by the processor) for their particular de=
sign =E2=80=93
> > > > if they need to - so that they can also access any other AXI-M wind=
ows
> > > > associated with any other peripherals they might add to their desig=
n.
> > > >=20
> > > > In practise, so far, all customers, and our own internal boards hav=
e all
> > > > started by using one of two major reference designs from us (one us=
ing FIC1
> > > > where the AXI-M window destined for the PCIe Root Port starts at 0x=
2000000000
> > > > and one using FIC2 where its AXI-M window, again destined for the P=
CIe Root
> > > > Port starts at 0x3000000000).
> > >=20
> > > Is there something special about this that cannot be described by a DT
> > > 'ranges' property?  This sounds conceptually similar to Frank's nice
> > > picture at
> > > https://lore.kernel.org/r/20241119-pci_fixup_addr-v8-2-c4bfa5193288@n=
xp.com
> >=20
> > Aye, it is similar, it is described using ranges properties, will end
> > up looking something like:
>=20
> So is this patch a symptom that is telling us we're not paying
> attention to 'ranges' correctly?

Sounds to me like there's something missing core wise, if you've got
several drivers having to figure it out themselves.

> The whole point of Frank's patches is to get rid of hard-coded masks
> like MC_OUTBOUND_TRANS_TBL_MASK because because 'ranges' should
> already contain that information.
>=20
> If 'ranges' is sufficent to describe the address spaces and
> translations between them, the driver wouldn't need to be concerned
> with FIC and AXI-M addresses; they would just be described in a
> generic way in the DT 'ranges'.

Daire seems to think what Frank's done should work here, but it'd need
to be looked into of course. Devicetree should look the same in both
cases, do you want it as a new version or as a follow up?

Cheers,
Conor.

--naCVrCOd0vJ9L2aC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ4o2jQAKCRB4tDGHoIJi
0hSSAP0fEWQvc3fUi1kJp3+GUXrZ4y7lgnUcHMqA08pU14t3eQEAnPJd7wB6gOtp
/WWYI7OeLb1eK2w4ioOJM1NSePWCCgk=
=ioTQ
-----END PGP SIGNATURE-----

--naCVrCOd0vJ9L2aC--

