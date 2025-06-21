Return-Path: <linux-pci+bounces-30290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D604CAE28EA
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 14:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CEC53B3412
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 12:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8151F560B;
	Sat, 21 Jun 2025 12:08:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEE517BD9;
	Sat, 21 Jun 2025 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750507698; cv=none; b=g09zmv+jusa0aZxX3evMzJ2xN0VAKYhtRgdU3dgawoGoesXyd/Dhi27L7xyyEWGNddIelI2toXBE/MeBVASSOPNybPFELdKzGvwZ4ThN38ZFSKDw6/6e45zsVCEBXZUofd0rKdI67n0+RT1h+EHIPg+dSTCYwNcB8sOcmmS3NF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750507698; c=relaxed/simple;
	bh=PVutjCvF0vPCTCFJSyQhPTr8h5VKHWz6rTR2umg5+dU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZLrw7MJWvaR8PZXdIucBLI1CHBpXvtAVCBY86LneVfy4icbjR6iKel0TwqWYEZAxWfEiQjMSdkDjwbZ0l8uLp0ZdKRWwEN177JymjS0UuS1WjG0CspE7O0zYgwBCWbY66SizkZd8m9EZUrfm5KP0yqVNusraY/J8a7nhk5IAugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1501:2e0:4cff:fe68:186] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1uSx0d-002Zp7-17;
	Sat, 21 Jun 2025 12:07:46 +0000
Received: from ben by deadeye with local (Exim 4.98.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1uSx0b-00000002DA8-2BOP;
	Sat, 21 Jun 2025 14:07:45 +0200
Message-ID: <b73fbb3e3f03d842f36e6ba2e6a8ad0bb4b904fd.camel@decadent.org.uk>
Subject: Re: [PATCH] agp/amd64: Bind to unsupported devices only if AGP is
 present
From: Ben Hutchings <ben@decadent.org.uk>
To: Lukas Wunner <lukas@wunner.de>, David Airlie <airlied@redhat.com>, Bjorn
 Helgaas <helgaas@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit	
 <suravee.suthikulpanit@amd.com>, Andi Kleen <ak@linux.intel.com>, Ahmed
 Salem	 <x0rw3ll@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	linux-pci@vger.kernel.org
Date: Sat, 21 Jun 2025 14:07:40 +0200
In-Reply-To: <f8ff40f35a9a5836d1371f60e85c09c5735e3c5e.1750497201.git.lukas@wunner.de>
References: 
	<f8ff40f35a9a5836d1371f60e85c09c5735e3c5e.1750497201.git.lukas@wunner.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-IShTDvXsHnknrgU9+DAa"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1501:2e0:4cff:fe68:186
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-IShTDvXsHnknrgU9+DAa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2025-06-21 at 11:40 +0200, Lukas Wunner wrote:
> Since commit 172efbb40333 ("AGP: Try unsupported AGP chipsets on x86-64 b=
y
> default"), the AGP driver for AMD Opteron/Athlon64 CPUs attempts to bind
> to any PCI device.
>=20
> On modern CPUs exposing an AMD IOMMU, this results in a message with
> KERN_CRIT severity:
>=20
>   pci 0000:00:00.2: Resources present before probing
>=20
> The driver used to bind only to devices exposing the AGP Capability, but
> that restriction was removed by commit 6fd024893911 ("amd64-agp: Probe
> unknown AGP devices the right way").
[...]

That didn't remove any restriction as the probe function still started
by checking for an AGP capability.  The change I made was that the
driver would actually bind to devices with the AGP capability instead of
starting to use them without binding.

Ben.

--=20
Ben Hutchings
All the simple programs have been written, and all the good names taken

--=-IShTDvXsHnknrgU9+DAa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmhWoIwACgkQ57/I7JWG
EQlQtA/+JWg9KmRhoIceKsq3MOX5PVC5l817NZi+UTsWn7CY9PLm0O3cYDOA1xpk
eNBOcGI856GwPXtS49QYSg24cri4ZmIITsQ7/MsQTcWLiKXafH5zJK8qAI41hDae
68THfQ7P3wCE7C1l2EeKpRB00WY9qdDvIM9NchQhhdwDvxSIz5CiUI7SQ0oOPfDS
rkdSYMKD3SmsdS1TmzxpvdhOinHLgQz7J1ytZyHKS3fVW0W/s3UUXaNrCBKHfpEF
DjqcGCoi4iZGzAE8GFCxQbCzHLDcOWa5KwEeOk65qwmlXMTicx6WSNAI+X/hfwoa
UwdYdq5ZyN+NmWeovD2hrB8ft2yuMi+vbtNub3a0Q2wnEHMt7J6LtTcsLkXrr7te
6ugunBIOtBXNQQgmkXqy2fIsIhmLvWW9X0PE/yTqs8FqoPvNBsWQKI6PucYklizH
ng5AKucwYbUGm59AKKzO2cAt+scr/iQnD2YPjCLqpXD5+Qgb2Z8KKQFqU4FwG85a
/iVdVb6rYISMm/yQiPXQoepyS7JmR2OOCxer7NNLil0V9NZbOZdwpu03goaoL+in
v3cG6YGJaVhRrFFJ2BMG9RIRAHsWeXdYNNCWvXO3k9dw4foeNuJrs4AT+QqFpVFb
8nHbjQAXT4i2kziPGLivlNVit3pwVwxoNd84L5C2M7h3xADwNTQ=
=2m0D
-----END PGP SIGNATURE-----

--=-IShTDvXsHnknrgU9+DAa--

