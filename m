Return-Path: <linux-pci+bounces-12275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 035609609F7
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 14:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B30F1F21D33
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 12:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6F11A08B0;
	Tue, 27 Aug 2024 12:23:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71AB19EEBD;
	Tue, 27 Aug 2024 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761410; cv=none; b=EORiGyLx92zi32gve1uk7WYUZLuxQzL0E3QwLFzHbLEpuFz1QhpySo7Z/UlezPoy8ZSXjBCq3IFM3HoTRtuCtGfOK5+V+X410YBLP0rbqNA+X5I0weGmrIyAQVTj+DJwGDc9Xu8OFYbnSj8gGAsOiFoTZXWQceQEB+KJOwhd/nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761410; c=relaxed/simple;
	bh=DlcCI5dqbxV19MynyTVWrTsqnSy9wcndP02vRILSOJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6Y5Mmo0TNUx6xt/OT3GLPCCgBBK/jPAHnMCCtxwfzbmHwTg1kgXOD9sPMPtgzn07r3czjoloJbEiUc6YX44VezvLWLCBdZ3xFnQr1SUW95mXlLNtHlFpTgi4DKGqXflEpOkS07elOC2MOKfjosCcoHywiBFQ1/MJEHbsTwcFWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0E9F61C009B; Tue, 27 Aug 2024 14:23:27 +0200 (CEST)
Date: Tue, 27 Aug 2024 14:23:26 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, jonnyc@amazon.com,
	lpieralisi@kernel.org, kw@linux.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.15 25/47] PCI: al: Check IORESOURCE_BUS
 existence during probe
Message-ID: <Zs3FPsfjnO5+6QcT@duo.ucw.cz>
References: <20240801003256.3937416-1-sashal@kernel.org>
 <20240801003256.3937416-25-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T0sGyw0kuOTLMwMR"
Content-Disposition: inline
In-Reply-To: <20240801003256.3937416-25-sashal@kernel.org>


--T0sGyw0kuOTLMwMR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit a9927c2cac6e9831361e43a14d91277818154e6a ]
>=20
> If IORESOURCE_BUS is not provided in Device Tree it will be fabricated in
> of_pci_parse_bus_range(), so NULL pointer dereference should not happen
> here.
>=20
> But that's hard to verify, so check for NULL anyway.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

If the NULL can't happen, we should not really apply this to -stable.

Best regards,
								Pavel
							=09
> +++ b/drivers/pci/controller/dwc/pcie-al.c
> @@ -242,18 +242,24 @@ static struct pci_ops al_child_pci_ops =3D {
>  	.write =3D pci_generic_config_write,
>  };
> =20
> -static void al_pcie_config_prepare(struct al_pcie *pcie)
> +static int al_pcie_config_prepare(struct al_pcie *pcie)
>  {
>  	struct al_pcie_target_bus_cfg *target_bus_cfg;
>  	struct pcie_port *pp =3D &pcie->pci->pp;
>  	unsigned int ecam_bus_mask;
> +	struct resource_entry *ft;
>  	u32 cfg_control_offset;
> +	struct resource *bus;
>  	u8 subordinate_bus;
>  	u8 secondary_bus;
>  	u32 cfg_control;
>  	u32 reg;
> -	struct resource *bus =3D resource_list_first_type(&pp->bridge->windows,=
 IORESOURCE_BUS)->res;
> =20
> +	ft =3D resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
> +	if (!ft)
> +		return -ENODEV;
> +
> +	bus =3D ft->res;
>  	target_bus_cfg =3D &pcie->target_bus_cfg;
> =20
>  	ecam_bus_mask =3D (pcie->ecam_size >> PCIE_ECAM_BUS_SHIFT) - 1;
> @@ -287,6 +293,8 @@ static void al_pcie_config_prepare(struct al_pcie *pc=
ie)
>  	       FIELD_PREP(CFG_CONTROL_SEC_BUS_MASK, secondary_bus);
> =20
>  	al_pcie_controller_writel(pcie, cfg_control_offset, reg);
> +
> +	return 0;
>  }
> =20
>  static int al_pcie_host_init(struct pcie_port *pp)
> @@ -305,7 +313,9 @@ static int al_pcie_host_init(struct pcie_port *pp)
>  	if (rc)
>  		return rc;
> =20
> -	al_pcie_config_prepare(pcie);
> +	rc =3D al_pcie_config_prepare(pcie);
> +	if (rc)
> +		return rc;
> =20
>  	return 0;
>  }

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--T0sGyw0kuOTLMwMR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZs3FPgAKCRAw5/Bqldv6
8vfvAJoD7xh8OBIk3HaGLcwuPv0YOpd8vQCgkzB1k0M8tLtvsEV6HojnZcVqV8Y=
=j2Sj
-----END PGP SIGNATURE-----

--T0sGyw0kuOTLMwMR--

