Return-Path: <linux-pci+bounces-4273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9553E86D1DD
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 19:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51878287D0A
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 18:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C187BAEB;
	Thu, 29 Feb 2024 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+5mCg7w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E9B160648;
	Thu, 29 Feb 2024 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230604; cv=none; b=PF2R9DcFxiXe289hewIjPrgT7SETZr8wJNxAfMgN+EVa2FB/iEPL3RfKaYVu9sk07A79JgOKI52gcXZ+Wg+lEl1bh8HBNRoY5rljLECZCtppxahMbSEFxx5JAvhCheanvGmbXep1vNt+as6Kxztghgc2K5l5RUUxQIF8VOzEBT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230604; c=relaxed/simple;
	bh=3CbSXxuONRZ0lG9ZqV/7qAp0SdzOirXNAMLNdA3lpGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5dJ1/VolaZflqca+TiVUeEk4OdHulaYxdpNvhd1AuQqDnnWYM/ogX7jtAEWjuymvc0MZ22LurEOeHRJMghjfocS9j8qzv5uSDVhIihUssatEBuJUdMZFjlyyyor90GdI++YSe48+omUVUtnlksLKBqrRcJEb/aYx/1jK1nD3Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+5mCg7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B116C433F1;
	Thu, 29 Feb 2024 18:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709230604;
	bh=3CbSXxuONRZ0lG9ZqV/7qAp0SdzOirXNAMLNdA3lpGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+5mCg7w63r7Z5MFOKERYRB7WPa7MXWJ72o5e+WXXyPAuANuGl/DHcU4BjOeJqEFT
	 8iX7/DIfW8qsldkc4ZC4VMrTbv/troUkZO3qae4Z/yu7zhwgRzSlrmPuYswtxFGDGv
	 Ixcdjub4uFUPtvgkjFrjCU6HsP5u9kA8eaVJPpr3h0M4GDTq1ffijdek5YG5JgBkNo
	 fQs7N1NjawmnnJvv7YThPna82xkHQ789SX7AGhwzMJ9qwXufFkxG9pR99/WlWZJWzM
	 K7qKC9aS0d7oCO6mzW+XA3U2qjTqaL+mwk/c7SQllHjJNKGVPmjVkXwSAllFi1jhUF
	 UlNG+JOc46xtA==
Date: Thu, 29 Feb 2024 18:16:39 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: helgaas@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org
Subject: Re: [PATCH v5 5/5] dt-bindings: pci: layerscape-pci-ep: Remove
 'fsl,pcie-scfg' and 'dma-coherence' from required
Message-ID: <20240229-putdown-gyration-6aaa6d156547@spud>
References: <20240228190321.580846-1-Frank.Li@nxp.com>
 <20240228190321.580846-6-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i/bXdY1OaIYJCArs"
Content-Disposition: inline
In-Reply-To: <20240228190321.580846-6-Frank.Li@nxp.com>


--i/bXdY1OaIYJCArs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 02:03:21PM -0500, Frank Li wrote:
> Remove 'fsl,pcie-scfg' and 'dma-coherence' properties from required becau=
se
> not all chips is dma coherenced and have supplement configuration unit
> (scfg).
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

I'd squash this with 3/5 and move both of them before the addition of
the reference to the main snps stuff. That way you'll not get
dt_binding_check complaints on multiple patches.

Cheers,
Conor.

> ---
>  .../devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml         | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep=
=2Eyaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> index e75b8853dca8c..07965683beece 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> @@ -67,8 +67,6 @@ required:
>    - compatible
>    - reg
>    - interrupt-names
> -  - fsl,pcie-scfg
> -  - dma-coherence
> =20
>  allOf:
>    - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
> --=20
> 2.34.1
>=20

--i/bXdY1OaIYJCArs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeDKBwAKCRB4tDGHoIJi
0gE3AP4uvIutdJbc+UtQUdw8Ctv+/W7dwfFJ2yR2E9RtaHN1SgEAx9+lhU1T/ZFP
HrV6OMDlJTF/of4ImXSZsFXNN873cA0=
=RyZI
-----END PGP SIGNATURE-----

--i/bXdY1OaIYJCArs--

