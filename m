Return-Path: <linux-pci+bounces-9115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6909133A8
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 14:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6E21F22C24
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 12:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1FF14A4F7;
	Sat, 22 Jun 2024 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hv6Wv2fU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A805A788;
	Sat, 22 Jun 2024 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719057848; cv=none; b=kQg3WSo7BCA5FwRyZhdj9hGgbhHQyFTratghQE0r3O1lrT0taCFHXxeGdd3kq33cQ6e5W4crzqq11xi47lDlZ0KgSKDi2VW5w8rdonvLunwMWsJiKe3Ip6mTEclFb4icvEAFTRJABlFiw4K1yZexYPUXih8rGKAh+T1jJi6NsBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719057848; c=relaxed/simple;
	bh=bndS5pMZkKTWWaUQd6hAfpSl8eZxrw6wZkum0MTaeg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCTDtQtiUiHpm+jBJjhGLMR3WMqOHS2QCLabp8bx+uW1R/oH9K/wUAqFLzHuKKV+hllpSNYoxT6c/zHG0WCDX8XNPc2H6pSwjg+sy13ZAWRSizOEcRwdSGoVUwTyPOggEAzx4npUSs2adnZkwI4yy+m8unfjPqHK52T7xC4wR64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hv6Wv2fU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D07C3277B;
	Sat, 22 Jun 2024 12:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719057847;
	bh=bndS5pMZkKTWWaUQd6hAfpSl8eZxrw6wZkum0MTaeg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hv6Wv2fUNb+mRwD586K29L49SfMozAN6jcGPY6fNbnvf9KrpTngTUeN91fgMaY8ee
	 jaQmxUmXf+pubmlllsiTdLw/bb5FgnFoIVkyVKKBI4MyBzVkbFam36FXzI8/fuAJWI
	 cYaS8L+Ag4EH1SQPvechTcU3X86sMS+jP57JdsWEfUI4MWDUdRb5u1uhGDcHOjOH4B
	 2c+rWITIwwEiBgZScvqpsUTZEMCR5BtKsCysSPAmaDx+1oc8G/R3Aw+vv7cs+h1VRi
	 AfQNsrNjIy+Rbvj7SFVLuXqi5e/fzDVSLAV6dHxGpp5pZzm89hn+GlO1zjlUEGOYcg
	 ElQ8tUbLklWbg==
Date: Sat, 22 Jun 2024 13:04:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-mediatek@lists.infradead.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH 1/4] dt-bindings: PCI: mediatek-gen3: add support for
 Airoha EN7581
Message-ID: <20240622-ripple-skylight-cdf172afde61@spud>
References: <cover.1718980864.git.lorenzo@kernel.org>
 <a215d6d8a91fccdbd1a28dd3262a3e5db1b728fd.1718980864.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Lh9pV1WQQOrM5d3z"
Content-Disposition: inline
In-Reply-To: <a215d6d8a91fccdbd1a28dd3262a3e5db1b728fd.1718980864.git.lorenzo@kernel.org>


--Lh9pV1WQQOrM5d3z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 04:48:47PM +0200, Lorenzo Bianconi wrote:
> Introduce Airoha EN7581 entry in mediatek-gen3 PCIe controller binding
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml      | 25 +++++++++++++++----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yam=
l b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 76d742051f73..0f35cf49de63 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -53,6 +53,7 @@ properties:
>                - mediatek,mt8195-pcie
>            - const: mediatek,mt8192-pcie
>        - const: mediatek,mt8192-pcie
> +      - const: airoha,en7581-pcie
> =20
>    reg:
>      maxItems: 1
> @@ -76,20 +77,20 @@ properties:
> =20
>    resets:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 3
> =20
>    reset-names:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 3
>      items:
> -      enum: [ phy, mac ]
> +      enum: [ phy, mac, phy-lane0, phy-lane1, phy-lane2 ]
> =20
>    clocks:
> -    minItems: 4
> +    minItems: 1
>      maxItems: 6
> =20
>    clock-names:
> -    minItems: 4
> +    minItems: 1

You've now relaxed the clock requirements for all devices,
and permitted an extra reset on the existing platforms. You'll need to
add some per-device min/maxItems constraints to solve that.

Thanks,
Conor.


>      maxItems: 6
> =20
>    assigned-clocks:
> @@ -186,6 +187,20 @@ allOf:
>              - const: tl_26m
>              - const: peri_26m
>              - const: top_133m
> +  - if:
> +      properties:
> +        compatible:
> +          const: airoha,en7581-pcie
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: sys_ck
> +        reset-names:
> +          items:
> +            - const: phy-lane0
> +            - const: phy-lane1
> +            - const: phy-lane2
> =20
>  unevaluatedProperties: false
> =20
> --=20
> 2.45.2
>=20
>=20

--Lh9pV1WQQOrM5d3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZna9sgAKCRB4tDGHoIJi
0m+4AP49uMd4z2YZFaIFWw40rA8bLfRzXXAW/AIcPSJya74d4gD9FHj4ehDkPlBP
oVkG3h1+IyeeqLBBlKcv/0pR147NXwk=
=Uy7o
-----END PGP SIGNATURE-----

--Lh9pV1WQQOrM5d3z--

