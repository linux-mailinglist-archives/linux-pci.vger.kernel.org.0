Return-Path: <linux-pci+bounces-26697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D19E0A9B24A
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 17:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E34D4C0BED
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 15:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2574622156E;
	Thu, 24 Apr 2025 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuGbuwfg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEBC21858E;
	Thu, 24 Apr 2025 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508581; cv=none; b=Z6NYj45IARxEDY0tfNvUUU5CmIgtUs3BxqWdR/FCn5mkNDHWtm6PGEl+WUo4jOTABxUgnrQwCoy/zYQLyZ5OPodZvQYWXOn5LtKnR06ge47u/+U6Vs8KrkDU1J5vY8cY7cauD7jP8FkGwzqtoXPtUilknHZda9RmgWvGVBNPd/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508581; c=relaxed/simple;
	bh=gJMXb5Q43o3Fb4QJuirndJOOwFsWCUxS3ZYHfpMPb2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVxtgKuJZDNgl7jaStn53Lz73cGpOkUUkAZIOOonWGA5UA8SAZWYRf5L6vnLgj8L+UaoFyNcx5t1L6dblsegwcnGyhbMHgBPRHs3lgc5/cbclzljd/OdiovmwD2hyb0UuRALqctQpoqSSmv1J1al5SFTRWh7CU0BDPEi1rmbgak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuGbuwfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5BCC4CEE3;
	Thu, 24 Apr 2025 15:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745508580;
	bh=gJMXb5Q43o3Fb4QJuirndJOOwFsWCUxS3ZYHfpMPb2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VuGbuwfgyk4N/REz0W07BpsASNmI2i1yitcccHX/AsB4D0K7o4eI9AMqxXILkcFEb
	 7ya0E48cGdvoxfW5deXxwV3FEiPrMZ5b58Y0tI52zAtXquXz/QzzrSpJJNfDAMcFPl
	 1Wn3vaX3u4fUKPUCVivTii1TVMKM5CpTPeLPqZDNHOKQtBUXayyKyWZieXNtss0g+s
	 fP9N+Yk12R1/p77gzvn0+TQZvd78qTa7vF5BaOXJzajcUOyUrBfMqJCTGgVfmtdYMX
	 kOIIoBn9p7q+7bqQZ4K3TbKZwgGDMtDtlLQM4oHoBuKdFKoJfMRoeELC53RSJWbAO0
	 OHOgB2DljArhQ==
Date: Thu, 24 Apr 2025 16:29:35 +0100
From: Conor Dooley <conor@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, peter.chen@cixtech.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manikandan K Pillai <mpillai@cadence.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: pci: cadence: Extend compatible for
 new EP configurations
Message-ID: <20250424-elm-magma-b791798477ab@spud>
References: <20250424010445.2260090-1-hans.zhang@cixtech.com>
 <20250424010445.2260090-3-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="454NY30T6bQMXXoG"
Content-Disposition: inline
In-Reply-To: <20250424010445.2260090-3-hans.zhang@cixtech.com>


--454NY30T6bQMXXoG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 09:04:41AM +0800, hans.zhang@cixtech.com wrote:
> From: Manikandan K Pillai <mpillai@cadence.com>
>=20
> Document the compatible property for HPA (High Performance Architecture)
> PCIe controller EP configuration.

Please explain what makes the new architecture sufficiently different
=66rom the existing one such that a fallback compatible does not work.

Same applies to the other binding patch.

Thanks,
Conor.

>=20
> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> ---
>  .../devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml          | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml=
 b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
> index 98651ab22103..a7e404e4f690 100644
> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
> @@ -7,14 +7,16 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Cadence PCIe EP Controller
> =20
>  maintainers:
> -  - Tom Joseph <tjoseph@cadence.com>
> +  - Manikandan K Pillai <mpillai@cadence.com>
> =20
>  allOf:
>    - $ref: cdns-pcie-ep.yaml#
> =20
>  properties:
>    compatible:
> -    const: cdns,cdns-pcie-ep
> +    enum:
> +      - cdns,cdns-pcie-ep
> +      - cdns,cdns-pcie-hpa-ep
> =20
>    reg:
>      maxItems: 2
> --=20
> 2.47.1
>=20

--454NY30T6bQMXXoG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaApY3wAKCRB4tDGHoIJi
0rK/AP4nrPcNsP38PNXcx54GaBf5sG4UalO/FuQz5Dz7yOZGFAD/amuYZ5gKuxRP
KtjJk3wqU0L4S+0rakEht7b0TzpiBAs=
=xccu
-----END PGP SIGNATURE-----

--454NY30T6bQMXXoG--

