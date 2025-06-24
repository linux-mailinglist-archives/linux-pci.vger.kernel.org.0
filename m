Return-Path: <linux-pci+bounces-30554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1367AE71BE
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 23:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E096178E0F
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 21:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A6F25B1DC;
	Tue, 24 Jun 2025 21:55:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5F725B1D8;
	Tue, 24 Jun 2025 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750802123; cv=none; b=uo17PNNtpWGLpcHJFdpoPL3kKyCR7Giw+jMjtyEHafFvJIamUdXHioXllzybx73XVMkPjagpm6nKTEqoS+szdVGYivahlGxUaJj5eiQ1vQXn4yDaJFvjkKx9Qcfk+auV3Q8DLqfocKNeXo9I8Q/YdwmMXpUkFGuqC5vvaWS+N6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750802123; c=relaxed/simple;
	bh=crb6erNNhhWTPlpZtTQ0hl4obVmhGYWyu1a8c/mTIBs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h8r4rGPviVNw8+6aDcq6cA7Z3qjdjtcRRevxADhMu8a40cKi1C6iDtG7vaIAU/U//NFaifkH1nLGYkuPeUts2ZpMy5rI/P1+/1L826MgmqRRL7ninPWYohHrXFn0ex457nYgHtCrrRyN/pYMF2tMK7W5uTD4PCjk0zzOajUGvfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1uUBbS-003Crc-1o;
	Tue, 24 Jun 2025 21:54:53 +0000
Received: from ben by deadeye with local (Exim 4.98.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1uUBbQ-00000002x1R-2RhR;
	Tue, 24 Jun 2025 23:54:52 +0200
Message-ID: <9077aab5304e1839786df9adb33c334d10c69397.camel@decadent.org.uk>
Subject: Re: [PATCH] agp/amd64: Bind to unsupported devices only if AGP is
 present
From: Ben Hutchings <ben@decadent.org.uk>
To: Lukas Wunner <lukas@wunner.de>
Cc: David Airlie <airlied@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>, 
 Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>, Andi Kleen	 <ak@linux.intel.com>, Ahmed
 Salem <x0rw3ll@gmail.com>, Borislav Petkov	 <bp@alien8.de>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	linux-pci@vger.kernel.org
Date: Tue, 24 Jun 2025 23:54:46 +0200
In-Reply-To: <aFa8JJaRP-FUyy6Y@wunner.de>
References: 
	<f8ff40f35a9a5836d1371f60e85c09c5735e3c5e.1750497201.git.lukas@wunner.de>
	 <b73fbb3e3f03d842f36e6ba2e6a8ad0bb4b904fd.camel@decadent.org.uk>
	 <aFalrV1500saBto5@wunner.de>
	 <279f63810875f2168c591aab0f30f8284d12fe02.camel@decadent.org.uk>
	 <aFa8JJaRP-FUyy6Y@wunner.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-1ac14mP05+O+KBtwB9Gp"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-1ac14mP05+O+KBtwB9Gp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2025-06-21 at 16:05 +0200, Lukas Wunner wrote:
> On Sat, Jun 21, 2025 at 03:51:44PM +0200, Ben Hutchings wrote:
> > On Sat, 2025-06-21 at 14:29 +0200, Lukas Wunner wrote:
> > > On Sat, Jun 21, 2025 at 02:07:40PM +0200, Ben Hutchings wrote:
> > > > On Sat, 2025-06-21 at 11:40 +0200, Lukas Wunner wrote:
> > > > > Since commit 172efbb40333 ("AGP: Try unsupported AGP chipsets on =
x86-64 by
> > > > > default"), the AGP driver for AMD Opteron/Athlon64 CPUs attempts =
to bind
> > > > > to any PCI device.
> > > > >=20
> > > > > On modern CPUs exposing an AMD IOMMU, this results in a message w=
ith
> > > > > KERN_CRIT severity:
> > > > >=20
> > > > >   pci 0000:00:00.2: Resources present before probing
> > > > >=20
> > > > > The driver used to bind only to devices exposing the AGP Capabili=
ty, but
> > > > > that restriction was removed by commit 6fd024893911 ("amd64-agp: =
Probe
> > > > > unknown AGP devices the right way").
> > > >=20
> > > > That didn't remove any restriction as the probe function still star=
ted
> > > > by checking for an AGP capability.  The change I made was that the
> > > > driver would actually bind to devices with the AGP capability inste=
ad of
> > > > starting to use them without binding.
> > >=20
> > > The message above would not be emitted without your change.
> > >=20
> > > The check for the AGP capability in agp_amd64_probe() is too late
> > > to prevent the message.  That's because the message is emitted
> > > before ->probe() is even called.
> >=20
> > I understand that.  But I don't feel that the explanation above
> > accurately described the history here.
>=20
> So please propose a more accurate explanation.

Something like "The driver iterates over all PCI devices, checking for
an AGP capability.  Since commit 6fd024893911 ("amd64-agp: Probe unknown
AGP devices the right way") this is done with driver_attach() and a
wildcard PCI ID table, and the preparation for probing the IOMMU device
produces this error message."

Thinking about this further:

- Why *does* the IOMMU device have resources assigned but no driver
  bound?  Is that the real bug?

- If=C2=A0not, and there's a general problem with this promiscuous probing,
  would it make more sense to:
  1. Restore the search for an AGP capability in agp_amd64_init().
  2. If and only if an AGP device is found, poke the appropriate device
     ID into agp_amd64_pci_promisc_table and then call driver_attach().
  ?

Ben.

--=20
Ben Hutchings
Horngren's Observation:
              Among economists, the real world is often a special case.

--=-1ac14mP05+O+KBtwB9Gp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmhbHqcACgkQ57/I7JWG
EQmq+Q//a55Y8Fao7E/XxVGieu3OVSsiSzpd5f/Re/J6IC2eVkPzZvd72/LuMYSq
5vsD/RWkhpkdJeab75FE0lxV0iQQ8uc3aRUoyJgf0hbOiYllNVpaubCiFdpP/fO5
klg2cksoulrf6W/ABvB+RSOVNP+XNQZSIMKoFCBYxcNY2CZ6uRdFPXWmnhfcKUl3
eViszycu7JBsLNLL24EvtoOu8JFJMXBUzVyEfvcHVcaPiLOUFsDSphEJkTMyYSGm
XrrTQTau/bzVMpjLeEZPZXKrR17EFGjpuNLbip75rt3B85Nnv+emSBjEI82UFuwy
ugTKoPRdkV+Gq1/Jzl8/6i+JArqE2PugVNQem52J97BN4MWJLczdMJGb7rg1YPNw
OMOr3CUpkvsEKY3Lq3+KFTcmjGrzp86oFkOtdPJinuL4UNXY8+FKg2dR6UM7rAMz
/HFkUdB8jOxWhvNrmRf3Gqde9mXEkennBgqyc5ERh31JVbbWsauZyLun6Sv1jpYk
yqJ1KpYyAXR7u+gpVoA9MPj6hoUOBPZPQ1xBww4tnGhJFkZRxykAAEO9lx8JY9qr
kqfjpe1Ah+jRh5iSmrcHoQ3drp7DYVzc0QoHYIPAquqTl9mDAX597qAKccgKYVMf
2mjKPmzRa4rWKb7Qu7MavAaBEuBaXZJyxcAvq3u+eGNj0hWm304=
=zBBS
-----END PGP SIGNATURE-----

--=-1ac14mP05+O+KBtwB9Gp--

