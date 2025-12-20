Return-Path: <linux-pci+bounces-43465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A718ECD2A4E
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 09:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89D533014DF9
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 08:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91902F6925;
	Sat, 20 Dec 2025 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="d+JEPb+8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A5F2F691C
	for <linux-pci@vger.kernel.org>; Sat, 20 Dec 2025 08:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766219071; cv=none; b=gOY6M0+yoVkO1EB+P2Ex62ubZlWNg4Qm8LNhKFYCRV4yXPZPw5Yh0aTEFdw7RcjaroMQLoAqaPdkpAIaB79QGx+xtE7icayLPaCD4Kzv9U/4VeQhTImImGiQTLUVJKNtQ8oAIZuehRiYFRobaYr5klBtUdTVuxUFVumi+Eg+YuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766219071; c=relaxed/simple;
	bh=8P2ghxO1RHdk3jwEPrs2LZp+JPLi+ujXA9eISimS9do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/ZeL0IU8y+U4tJVY8N2x5QFumZvkP5niz2qYTI4LyMGXcjEF60gK7ZhlVTaqB/TBeD1d72AJ5WsvB6u1Ewq/krvA37HoLJm7uTRu1ndOxTtyclSlhwmHA2IYW4d2e+JBdnTtrBpm60YxJwgPsSFzHW1rd2Zaj6+6IZuietPkpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=d+JEPb+8; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=8P2g
	hxO1RHdk3jwEPrs2LZp+JPLi+ujXA9eISimS9do=; b=d+JEPb+8yfkJjfrMoOZh
	unJ/rI97J3yLfESHrip7xbxZT8hxvNe0LWul6THt47sWJp01rBFo2d/qQAkzFaV6
	yJtAAAeryiwVNXTJN/M6xxCvnM51pHNgcWEMDZdmn5yGreQdc1V2KN5JuquMG68v
	IQrRlyQycI469U8bT4bGt92AUKdxtoBqUWlu/vCegE6uisRNngGGqscxdA2DYaf2
	it1B3XZRDhAInb8ly2MCEFSHWR9/Wb5by5Ewv5uk5ei2TaDoK6lD5jcTCfqsfLdQ
	MqziHs0vBfunNI61NZJplvuzHw+MuCTBWHMZK6b+jIO+iy4Owj7jb7sb28JEwwhY
	MA==
Received: (qmail 3031901 invoked from network); 20 Dec 2025 09:24:27 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Dec 2025 09:24:27 +0100
X-UD-Smtp-Session: l3s3148p1@mjkW7F1G4NkgAwDPXwGNABSvzf//pZhn
Date: Sat, 20 Dec 2025 09:24:20 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: rzg3s-host: Use pci_generic_config_write()
 for the root bus
Message-ID: <aUZdNOygobOBZLcI@shikoro>
References: <20251217111510.138848-1-claudiu.beznea.uj@bp.renesas.com>
 <20251217111510.138848-2-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eSVP0FZ7UduElnxs"
Content-Disposition: inline
In-Reply-To: <20251217111510.138848-2-claudiu.beznea.uj@bp.renesas.com>


--eSVP0FZ7UduElnxs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 01:15:09PM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The Renesas RZ/G3S host controller allows writing to read-only PCIe
> configuration registers when the RZG3S_PCI_PERM_CFG_HWINIT_EN bit is set =
in
> the RZG3S_PCI_PERM register. However, callers of struct pci_ops::write
> expect the semantics defined by the PCIe specification, meaning that writ=
es
> to read-only registers must not be allowed.
>=20
> The previous custom struct pci_ops::write implementation for the root bus
> temporarily enabled write access before calling pci_generic_config_write(=
).
> This breaks the expected semantics.
>=20
> Remove the custom implementation and simply use pci_generic_config_write(=
).
>=20
> Along with this change, the updates of the PCI_PRIMARY_BUS,
> PCI_SECONDARY_BUS, and PCI_SUBORDINATE_BUS registers were moved so that
> they no longer depends on the RZG3S_PCI_PERM_CFG_HWINIT_EN bit in the
> RZG3S_PCI_PERM_CFG register, since these registers are R/W.
>=20
> Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--eSVP0FZ7UduElnxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmlGXTQACgkQFA3kzBSg
KbYl3g/8DQ7s/GbVwYOpQfEjTgrr6AGQRBmnmapVmtw0H4jzLZeL6D1D+3HkbTJD
IaCsFxYYRNe005c1ccjCGwlKMmpAJRpST2XOmUoppzg2CNNu90N+xW5NTFRvRN2w
I6hSayPCUQI/a56riU9jkPs3ziPP8kZAZTC84uYycFe06TGiVsp//EA2ZagqH79L
HTYF2bP9LnBw8dZNbcqggLDHHxKpDM2nhT3bMhNQG7pbtr6VRFGkma5Lze8MdXbR
zx84u6v1jb2nFFQ80Joe6JrM82sC1XrDSVjCbz3OFAYwCE4so/v8rp1UlNw9yGow
Hrzo/30MxNIZv2q8yMdyp506TaydPm0Vs0QUX4pm874eDuWiiM7/DHwnOku8Zf0y
lzjda53VsUi05fEyG8qF1RnUq3kMNITZsgVnb2jFtiEFKOQN/5A9MQ7EJVSXQnGy
SaAeCz1kCv+oUuEZpjRjMNO1AxBQlNM3ooojz6bcpgmoe4W9ql2yNLwXcCs4tDyC
F9HkT592vqiumWJflwxcLK95B+o2ej3EG4YuqVUV2bdzIVZ7Ne1fQVeBsHhauwgP
wsIk/dRp63AsIjU+cc2FuivsWXD/i+joJ/mwor/ToJr75O1Jb2f6udCbvlDRgpt2
5NahndfKIOPlgWTJXbkMxlf69vkAXnZi+IgNnTDPZzIHYJwGCDQ=
=aVJ3
-----END PGP SIGNATURE-----

--eSVP0FZ7UduElnxs--

