Return-Path: <linux-pci+bounces-17698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91E39E42CD
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 19:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9223F168FCA
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 18:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA6820766D;
	Wed,  4 Dec 2024 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uU433nzt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F61207667;
	Wed,  4 Dec 2024 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733334505; cv=none; b=TuYTzNWBQnGbGL9sYYSj+/8cBJr07ZzlTPCIS2/s2ML0+hbR7GxWF504lSXEogSzJ1qmF+PPwpLf+UuFSPFaQRlB3oJXUZsp/dts7O+xC70CjIAAfmsGkF35+Kaexn45TYBrGgNpTuQ8mAW8qvTAM/ywEtr6OiLnjjcSyGxsnuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733334505; c=relaxed/simple;
	bh=8V5VzTCO37ZItxdQHsQqFsXfNowDoUuqyZ+6bm+pT90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZGsECf5H23VTrBJSPvNiIq0QjJt6VUwY7ck9QgG81R1bksp5mpMh2H9ZepQlYODuTav5l46DQ82j55KNEjhH0xGVjHHS3/cFTxxjrlj+PFb2Zx5zmWash9F2Lvy9xwIsrDrJ1qCM80HCSGba5oKf54DcV2VqQfeVQq0pHu2aCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uU433nzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA43C4CECD;
	Wed,  4 Dec 2024 17:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733334505;
	bh=8V5VzTCO37ZItxdQHsQqFsXfNowDoUuqyZ+6bm+pT90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uU433nztW+UCKZW7MvmQVSQMpULXdF+T6hwMrMojRXLPaHoEB1iI5mtjNuKsPbNcY
	 1R0r24j4hke5yAyihvCReBC5kJJDoWOEO/ngBP28FebUfoOzcRmklOr37qGlIAmu4F
	 EpElaA0eJXSYsoeJdBKKJUfV92Z8fdjDUJchDi2eAplti8s59tBTg18kBs0/gZe9it
	 canoS7cKXPrQEZNpWaCTjnCAXPuBzHnCxOqrzUkd4uUlN7krpnI4mCAm75CSjH2Bdj
	 91BnpC4a4k/nRFIV9YWQJyCHTb4Sav0ZkrO5uNeYTR404pdbEKMIqoU3Y9z9Hn/wEk
	 xYxo71rFBa5hw==
Date: Wed, 4 Dec 2024 17:48:20 +0000
From: Conor Dooley <conor@kernel.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jingoohan1@gmail.com, michal.simek@amd.com,
	bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v3 1/3] dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr
 support
Message-ID: <20241204-marvelous-lubricant-048e71139b32@spud>
References: <20241204115026.3014272-1-thippeswamy.havalige@amd.com>
 <20241204115026.3014272-2-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eG1elIiPl7F+xKpP"
Content-Disposition: inline
In-Reply-To: <20241204115026.3014272-2-thippeswamy.havalige@amd.com>


--eG1elIiPl7F+xKpP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2024 at 05:20:24PM +0530, Thippeswamy Havalige wrote:
> Add support for mdb slcr aperture that is only supported for AMD Versal2
> devices.
>=20
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
> Changes in v3:
> -------------
> - Introduced below changes in dwc yaml schema.
> ---
>  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Do=
cumentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> index 548f59d76ef2..02cc04339d75 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> @@ -113,6 +113,8 @@ properties:
>                enum: [ smu, mpu ]
>              - description: Tegra234 aperture
>                enum: [ ecam ]
> +            - description: AMD MDB PCIe slcr region
> +              enum: [ mdb_pcie_slcr ]

Why's this an enum when it has a single value? Shouldn't it be a const?

--eG1elIiPl7F+xKpP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1CV5AAKCRB4tDGHoIJi
0mwZAP0eQzJVvbk78ztSzy2R7LrDiT93/iDaGOYSDLHo4Sjx8gEApZo1t8UV2Acb
4dXG9MHZ7/BVvciSQt/Qc9W9WgSRiws=
=9eaJ
-----END PGP SIGNATURE-----

--eG1elIiPl7F+xKpP--

