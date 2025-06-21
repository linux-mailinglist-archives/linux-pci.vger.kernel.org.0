Return-Path: <linux-pci+bounces-30292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE3BAE293B
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 15:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358913AD940
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 13:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9A8182BC;
	Sat, 21 Jun 2025 13:52:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53D58F5C;
	Sat, 21 Jun 2025 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750513927; cv=none; b=u2G64Bo01/IinzDwbxW+4LG8dU4Kwr5e0LExqCLfNS/v+7f0O6POpQpBIHsZW9Y4VmALvx+r2CKAwVSjZWRCQdLb8DFutYjPp05FjQJ47Nkk6lv+aV3S9PohTMuj4WCJNEXkt/1V8lm8JGQevd0S8U6hibFZuqeO4h/0s2RBfP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750513927; c=relaxed/simple;
	bh=grZet3Ugp6zfXZyhB0b/93HlhUZjCldUwcABDdYubM8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kj0AHIdB5AVsqY+RhBYfwDkOJ6uG90Ek6SLpcwNs4N1pwHqQhC4Kx0ZDWwaA+T4JSRxgNp/kkZfbLJ+LcoeDPcEs1ifuB9W0metQ6i2JeeK1I1DwtcV4ABIyRU3UX112nq8TRapN30s3u5BAEZ0+C4jgVkJwpq5WmQhYbzAWjpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1uSydL-002aIE-2o;
	Sat, 21 Jun 2025 13:51:51 +0000
Received: from ben by deadeye with local (Exim 4.98.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1uSydJ-00000002EDA-3RY9;
	Sat, 21 Jun 2025 15:51:49 +0200
Message-ID: <279f63810875f2168c591aab0f30f8284d12fe02.camel@decadent.org.uk>
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
Date: Sat, 21 Jun 2025 15:51:44 +0200
In-Reply-To: <aFalrV1500saBto5@wunner.de>
References: 
	<f8ff40f35a9a5836d1371f60e85c09c5735e3c5e.1750497201.git.lukas@wunner.de>
	 <b73fbb3e3f03d842f36e6ba2e6a8ad0bb4b904fd.camel@decadent.org.uk>
	 <aFalrV1500saBto5@wunner.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-B2+L4O/u7E9GREL2m76u"
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


--=-B2+L4O/u7E9GREL2m76u
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2025-06-21 at 14:29 +0200, Lukas Wunner wrote:
> On Sat, Jun 21, 2025 at 02:07:40PM +0200, Ben Hutchings wrote:
> > On Sat, 2025-06-21 at 11:40 +0200, Lukas Wunner wrote:
> > > Since commit 172efbb40333 ("AGP: Try unsupported AGP chipsets on x86-=
64 by
> > > default"), the AGP driver for AMD Opteron/Athlon64 CPUs attempts to b=
ind
> > > to any PCI device.
> > >=20
> > > On modern CPUs exposing an AMD IOMMU, this results in a message with
> > > KERN_CRIT severity:
> > >=20
> > >   pci 0000:00:00.2: Resources present before probing
> > >=20
> > > The driver used to bind only to devices exposing the AGP Capability, =
but
> > > that restriction was removed by commit 6fd024893911 ("amd64-agp: Prob=
e
> > > unknown AGP devices the right way").
> >=20
> > That didn't remove any restriction as the probe function still started
> > by checking for an AGP capability.  The change I made was that the
> > driver would actually bind to devices with the AGP capability instead o=
f
> > starting to use them without binding.
>=20
> The message above would not be emitted without your change.
>=20
> The check for the AGP capability in agp_amd64_probe() is too late
> to prevent the message.  That's because the message is emitted
> before ->probe() is even called.

I understand that.  But I don't feel that the explanation above
accurately described the history here.

Ben.

--=20
Ben Hutchings
All the simple programs have been written, and all the good names taken

--=-B2+L4O/u7E9GREL2m76u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmhWuPAACgkQ57/I7JWG
EQnuzw/9FxIyZF53ZXkjBurJx5E4AWyk9wOHNzDcc4O9/fuJiwg/vWBdY+QP6+JE
bI6eSUUvHTyFyJ9EdAy8xjOF81BE/p/cYfeAAU2U82VJGJkqkjM2T93qcmCrKRPI
sO1oBieYyOFtdxB0YQk5fq7SRql0IMpc1Di51eq8CxNZ3KR98+iwkyzKJUF8ayWc
jTkvy0dEKwvyisyffYGn8oCVEPE7rnnqBxEtMi8Z5K34NPqXI0HxT2QG7h3Wb7f4
qXx+qlJMO92nfOoYJIam60wgCVzms540/DenIexUhKTXdRz/ntaDAEBenDR8ImXr
GdrBnIzpcNHpiCEJfu1waX1k5vSchvj89zm99UmfsiyN+OOyIlkMAQNfFwjfai/t
DFz75f/dtbLq2JAMGe3hhF6qc/0c8hgjYsgE4hJT67hydl+IiZPLU7NlXrcP/y8f
mjeJac/bkDLlE3ThghuKhseYfp/kCyNGp6izMZCQqufF+47jIgTl5xUNMsnoZifr
qpcX0gEph+wG4XstjuSZEQw5pviUMmW4lRXBZkzDgdkFbVJ4vCiB+nVo2GUuMLFa
/dE8yP0BLzfdWeJz48RiXdoF4WPD7Fy5anzbQOw/eOVaKBYPBENkBeMLkp6DuH6E
h5VqtLSy3mFHMT9aD8wUgRh7zeDr+BEHDvQ19jNsU7XkQi49fvI=
=PU9j
-----END PGP SIGNATURE-----

--=-B2+L4O/u7E9GREL2m76u--

