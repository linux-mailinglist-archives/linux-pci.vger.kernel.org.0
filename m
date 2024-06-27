Return-Path: <linux-pci+bounces-9380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD3A91AB12
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 17:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916661C226D0
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 15:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF7F198A09;
	Thu, 27 Jun 2024 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IM5S1reW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4D7197A61;
	Thu, 27 Jun 2024 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501782; cv=none; b=dwKO4A+LMVzJXGub92KsZvsbIcAyTFdBpkGvlGFtVsIQoI48v5V7gbNcT80Q7tkAbEYDQSnU7kp0cGLuAtbkFIgDI8FzkvHYAzTolIRZpPBaz81WomfS8uuxQUfZZbJ+IRc9VaBMhCMYClmjx8xP3M/LFotXBwoJu68V/IdsG8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501782; c=relaxed/simple;
	bh=IMOuy42GDAFC2FD3yx7fGuAt6p6IPLwFyJf9jzkK88Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfKyzzmC1ijxZIEzjlyBVfCaoIl0nr5QwC8tcEI9Y7lfRFlTdh/Y+DyE/JUyAvFULtCQvjFhHIEwUXPQFz8lDx4aAwjMCdWT6Bn9AyscUwxzd3ZrRgE7l5eBioD7IesFcDPGxAvl8jg9Triiwh7Ur5UXyX/x7xPGBUum3vjIHHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IM5S1reW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B128DC2BBFC;
	Thu, 27 Jun 2024 15:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719501782;
	bh=IMOuy42GDAFC2FD3yx7fGuAt6p6IPLwFyJf9jzkK88Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IM5S1reW0TiFzFDXONX/TmwOg4ODUf5HwPEUPmFoO1+CkUyq+nC8Mt2YGXbxBVpXK
	 2qWnLTo4MQKQPm0NEn8T4WIOtBB44c8xoyz9drfDflv3gqc7gZx3W5rhnZD8AOo1tU
	 2P5X9RnJTZeUllTa/jMHP0SO0hM5bX4HOo44JIL2S1Pim1zsxMjhQaYYCvJLSbtHCk
	 sZtKIgt2oHx6PVFrt6n69DbyVytRMhUGaiesUw9+pQQ4dR9TWO/BQIcYfetzvWER91
	 yK+x6vzBqxk+ECL6xOJD6slpY8t9OXbuDErUgWyaTqXlY6g4Wp6Hw9q/S9iE8naCrE
	 cp6GdX1GJuq7Q==
Date: Thu, 27 Jun 2024 16:22:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com,
	linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v2 1/4] dt-bindings: PCI: mediatek-gen3: add support for
 Airoha EN7581
Message-ID: <20240627-evergreen-oppressor-21deb5c83412@spud>
References: <cover.1719475568.git.lorenzo@kernel.org>
 <c11a40dbe3e1d1e4847ceee8715c1f670fd1887b.1719475568.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bIMezDrpTcKbQIo4"
Content-Disposition: inline
In-Reply-To: <c11a40dbe3e1d1e4847ceee8715c1f670fd1887b.1719475568.git.lorenzo@kernel.org>


--bIMezDrpTcKbQIo4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 10:12:11AM +0200, Lorenzo Bianconi wrote:
> Introduce Airoha EN7581 entry in mediatek-gen3 PCIe controller binding
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml      | 68 +++++++++++++++++--
>  1 file changed, 63 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yam=
l b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 76d742051f73..59112adc9ba1 100644
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
>      maxItems: 6
> =20
>    assigned-clocks:
> @@ -147,6 +148,9 @@ allOf:
>            const: mediatek,mt8192-pcie
>      then:
>        properties:
> +        clocks:
> +          maxItems: 6
> +
>          clock-names:
>            items:
>              - const: pl_250m
> @@ -155,6 +159,15 @@ allOf:
>              - const: tl_32k
>              - const: peri_26m
>              - const: top_133m
> +
> +        resets:
> +          minItems: 1
> +          maxItems: 2
> +
> +        reset-names:
> +          minItems: 1
> +          maxItems: 2
> +
>    - if:
>        properties:
>          compatible:
> @@ -164,6 +177,9 @@ allOf:
>                - mediatek,mt8195-pcie
>      then:
>        properties:
> +        clocks:
> +          maxItems: 6

How come this is maxItems and not minItems? The max is always 6, before
and after your patch.

Cheers,
Conor.

--bIMezDrpTcKbQIo4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn2D0AAKCRB4tDGHoIJi
0oPFAP9SiYTTYpY6A5LoY15O+RsQ0xC2rbZfeH+2l8EZPQptfwEAwy1aHN1FUMTj
Yzkp8qaOA+8BKhOvmX4DGsHmGPLurgo=
=wYS7
-----END PGP SIGNATURE-----

--bIMezDrpTcKbQIo4--

