Return-Path: <linux-pci+bounces-8586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A509D903CCE
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 15:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3751F21947
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 13:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE4917C7C0;
	Tue, 11 Jun 2024 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dkfn9bGA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAF1178CCF;
	Tue, 11 Jun 2024 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718111570; cv=none; b=tbnxSbTcl0AzCuVwh/I30SFt7DjKf1crdgD68bGXnQp+/5VFZvl3cXbqgKPk1RHD1cVltMaWx4N01/BzL/+dPvk8hyFf6uFC58dgtlvo4Mi0vutPp6oyNL7OY+rrylyOMgWqxV3WNpkHZnD2alhoyggbfmIHKn9vatGLLshpBxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718111570; c=relaxed/simple;
	bh=OGe3r2/6pOkH3bSOKeGtF6RD1v4JiSo+hRENqhCkqew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naif1t1/8A/vUWp5zTkQW39GvJ4LcF96ztRwQqL59HiVfkhN1dBxyvm5Y/ntjhtCQYS1kmLU+l685dldwLnG27kaYH3n5IIAVZs1ilyBVKe5r9d9VJ0XQIylZE6YHpquHP2K+twkvbisrYBbewp9Wb7msrwxlXBrsmGKhE5S6qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dkfn9bGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A823CC2BD10;
	Tue, 11 Jun 2024 13:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718111570;
	bh=OGe3r2/6pOkH3bSOKeGtF6RD1v4JiSo+hRENqhCkqew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dkfn9bGAJxiqPyULSPh28vzRbnNR6uLlnIrDo64O2djHmmF+9RmhcOl1CvS6RlPCw
	 pEJ2EeFIlvJ2EkvwVCxHDm6slBdVLgQr4kN+c7fu1vggrJNAQ9FU4FVyenGIoeEKIZ
	 GepRVPGZdqhokEa+3vxMyNcH4/J0S6sBObj0+l1nCYzNlO0dGTz9njTbNCnfqNnsSW
	 k2nXmY37Jup2keBhBI+3nFdUIX9sYSAJ+XVaGfcfvON3MDtvtB3cBR5RM/GwnlHNj1
	 +5k/Mos4HWpzcryvLv3rM0CC0LbLDh3IMsleknX2XOrTBCPVUhzp8aMzyluerjV77T
	 PGUGdv3n3DVTA==
Date: Tue, 11 Jun 2024 14:12:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Daire McNamara <daire.mcnamara@microchip.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 2/2] PCI: microchip: rework reg region handing
Message-ID: <20240611-relapsing-hurt-3a5f37743784@spud>
References: <20240527-slather-backfire-db4605ae7cd7@wendy>
 <20240527-flint-whacky-4fb21c38476b@wendy>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="66+HdzG+IeYp/nLS"
Content-Disposition: inline
In-Reply-To: <20240527-flint-whacky-4fb21c38476b@wendy>


--66+HdzG+IeYp/nLS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 10:37:17AM +0100, Conor Dooley wrote:
> @@ -1150,28 +1129,44 @@ static int mc_host_probe(struct platform_device *=
pdev)
> =20
>  	port->dev =3D dev;
> =20
> -	port->axi_base_addr =3D devm_platform_ioremap_resource(pdev, 1);
> -	if (IS_ERR(port->axi_base_addr))
> -		return PTR_ERR(port->axi_base_addr);
> +	/*
> +	 * The original, incorrect, binding that lumped the control and
> +	 * bridge addresses together still needs to be handled by the driver.
> +	 */
> +	axi_base_addr =3D devm_platform_ioremap_resource_byname(pdev, "apb");

I noticed yesterday that this will print an error during boot, which I
don't really want for the devices using the updated format. I'll send a
v2 tomorrow with the reg region probing inverted.

Thanks,
Conor.

> +	if (!IS_ERR(axi_base_addr)) {
> +		port->bridge_base_addr =3D axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
> +		port->ctrl_base_addr =3D axi_base_addr + MC_PCIE1_CTRL_ADDR;
> +		goto addrs_set;
> +	}
> =20
> +	port->bridge_base_addr =3D devm_platform_ioremap_resource_byname(pdev, =
"bridge");
> +	if (IS_ERR(port->bridge_base_addr))
> +		return dev_err_probe(dev, PTR_ERR(port->bridge_base_addr),
> +				     "legacy apb register and bridge region missing");
> +
> +	port->ctrl_base_addr =3D devm_platform_ioremap_resource_byname(pdev, "c=
trl");
> +	if (IS_ERR(port->ctrl_base_addr))
> +		return dev_err_probe(dev, PTR_ERR(port->ctrl_base_addr),
> +				     "legacy apb register and ctrl region missing");
> +
> +addrs_set:
>

--66+HdzG+IeYp/nLS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmhNTQAKCRB4tDGHoIJi
0m6kAP9Yi9S7w0ZvHdiZWSo84UEHKpHj2Y1/n5bHC+FrPclaqgD8DZbVakSMXx/j
Ui6ZHfzPJVENrprpWkS4r/azLfon1A4=
=qPrU
-----END PGP SIGNATURE-----

--66+HdzG+IeYp/nLS--

