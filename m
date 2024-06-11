Return-Path: <linux-pci+bounces-8604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC529904300
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 20:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47C71C21D65
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 18:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B5F74413;
	Tue, 11 Jun 2024 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unaY0Fja"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF07406E;
	Tue, 11 Jun 2024 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128618; cv=none; b=eYaITjzucmNo+mg2a0JQ24G6O7qIg+yc97NF4WGZm004c1wQuZQfGs2rtdGAVn7mpj5mWK/LFudd0q237mriELf6226nKCwfR1nxmAMAwJ90/oiX02Om+ysT16FCN06K52JfFX7BOrrYUXClCiX+2Y+v9WMfKEpQ8XiAa8X0j/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128618; c=relaxed/simple;
	bh=UERodzDXvGbnqLdrOtjYNb9Mfs0u0k6LIAWwfXfiCS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDWWKBrOuTAVcFMvAyfimzzf7HLhP8aWY+1qxCMBHj4VU9mGhWhpLMCknxCdMZpUnWaQ5w0mcmgL+NdJvNCmBeRrQe1M6uy86dmmid1jSZFLkcfyRJlAJPtvVpNQvTDJyTioFMf2bKeDx5Z463qRGbsqy4NBZSZO5dEpby1ijOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unaY0Fja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A21C2BD10;
	Tue, 11 Jun 2024 17:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718128618;
	bh=UERodzDXvGbnqLdrOtjYNb9Mfs0u0k6LIAWwfXfiCS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=unaY0FjaN+ovVHS0qx4c9gkXG9iRwNE3bo9Evgwar48vk3rTi+8i+JTMjrRw7bxzV
	 OUTsWMUrtxLzyOuybd0zSupPbNKSym471d6foZo24A/vAMDWHKJgw5HI1Ei7JDjPtw
	 WT94Bz5k4H1PxL3O5dpFh96fTziX4WdhbyAi4x6aO5+qePH6vw/LWU1q++35C3PRoR
	 1lJUpVUQ2h55SzYEUT3CG7f4Vu9BQuvnQTEvx/psRQtO3XFzrXWy4PU/xTqvDFNSLB
	 S0nn4jCQJLNlSb+QuLOPozz1h3uHTzridRNJDOu3ElJMbJ6ktT/deBI/Yry1HDmBKw
	 y8HgQvF8ftVQw==
Date: Tue, 11 Jun 2024 18:56:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 2/2] PCI: microchip: rework reg region handing
Message-ID: <20240611-retorted-variety-cd69c39238eb@spud>
References: <20240527-flint-whacky-4fb21c38476b@wendy>
 <20240611171054.GA989979@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Yrv/4CxhjMg6gFq+"
Content-Disposition: inline
In-Reply-To: <20240611171054.GA989979@bhelgaas>


--Yrv/4CxhjMg6gFq+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 12:10:54PM -0500, Bjorn Helgaas wrote:
> On Mon, May 27, 2024 at 10:37:17AM +0100, Conor Dooley wrote:
> > The PCI host controller on PolarFire SoC has multiple "instances", each
> > with their own bridge and ctrl address spaces. The original binding has
> > an "apb" register region, and it is expected to be set to the base
> > address of the host controllers register space. Defines in the driver
> > were used to compute the addresses of the bridge and ctrl address ranges
> > corresponding to instance1. Some customers want to use instance0 however
> > and that requires changing the defines in the driver, which is clearly
> > not a portable solution.
> >=20
> > The binding has been changed from a single register region to a pair,
> > corresponding to the bridge and ctrl regions respectively, so modify the
> > driver to read these regions directly from the devicetree rather than
> > compute them from the base address of the abp region.
> >=20
> > To maintain backwards compatibility with the existing binding, the
> > driver retains code to handle the "abp" reg and computes the base
> > address of the bridge and ctrl regions using the defines if it is
> > present. reg-names has always been a required property, so this is
> > safe to do.
>=20
> When you update this, can you add something about the objective to the
> subject line?  "rework reg region handling" just says "we did
> something", but not why or what the benefit is.
>=20
> The cover letter ("support using either instance 1 or 2") has good
> information that could be part of this.

Ye, sure.

--Yrv/4CxhjMg6gFq+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmiP5QAKCRB4tDGHoIJi
0r7KAP93yL6qKBVlWqUGW4RwUK9tkjCiHyW61h74yRHyxSwQzQD/Zp0LhXPVtVgq
4CzQDZSafRaOf1ALkyXbSFJG2YFS8AI=
=tgsL
-----END PGP SIGNATURE-----

--Yrv/4CxhjMg6gFq+--

