Return-Path: <linux-pci+bounces-23479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC660A5D831
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 09:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C8D188A875
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 08:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB13233D99;
	Wed, 12 Mar 2025 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f42uPoTw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1440522FF58;
	Wed, 12 Mar 2025 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768127; cv=none; b=e0H506zh+/PUcOPjrR547NCcDUM816EsmF53hQ7kiqKuI5qF4ObouoQt4nWwlsINx4asHtggxlIk7esRhmqTsR+jEIId2xIuVE4z0AG8qbQGCtHo00dwNPqz5FkCcOCaSPDB1MerTJq7F8Rcuxz7NlcFhZYYwwOaXgxF5Op1TkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768127; c=relaxed/simple;
	bh=/V6VN9hiNJE0Pb3fRkMlElXGmJOzB9q4YyeZw9aMy6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbnrsNZRnjXU1+sooLQRcQYIzPSHgoceN3FxAqJRHv5s6gwHfDJ2zYV2hLfkGvxz6GC+jOgzz739WnUAP1RkGSKJX8T1NgZhuC/SdOeFgZtCDcqbpidbrsn3DH7u7FV4EZS8W81W4GDpsD1Vuwq+3h4Vt4BHwp3Z+gB6Ho7C9pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f42uPoTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07F6C4CEE3;
	Wed, 12 Mar 2025 08:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741768126;
	bh=/V6VN9hiNJE0Pb3fRkMlElXGmJOzB9q4YyeZw9aMy6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f42uPoTwlrz8LTab9lmksBP8A/im1Tzh77vlcDn2na4re4i1CkmuI+IBZcf19xjf+
	 WQBYqH+SXZPzeoKa690YPVlFbErul6HMbiA8rqEBDfZb2XqBOx0mqJZZ8B3yJeBX2u
	 5YEGGH3+3brpfHeiRA6loef1fw62jPGCTHPCUVHNz206hXFD+x5dkJaXghet12SoEz
	 U1nsCfmIYZTk8N2EI5UQEKqUkQH/ZaxiqKbfJZPS5Vg9YgLh1IFw5tE2ccPlvjLAIq
	 7GKO1MSBiLcuiEBfU/tAe9fcxRUv8sItbenaVuXmEh53tfc4yNDzlp04qv+BBtuTGO
	 f+lRSHCACTvEg==
Date: Wed, 12 Mar 2025 09:28:43 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: soc: airoha: Add the pbus-csr node for
 EN7581 SoC
Message-ID: <Z9FFu9DlAdonbOeC@lore-desk>
References: <20250311-en7581-pbus_csr-binding-v2-1-1fc5b5e482e3@kernel.org>
 <20250312081117.GJ8350@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KCPVwl5RS58A8bfe"
Content-Disposition: inline
In-Reply-To: <20250312081117.GJ8350@google.com>


--KCPVwl5RS58A8bfe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> dt-bindings: mfd: syscon: Add the pbus-csr node for Airoha EN7581 SoC

ack, this is a leftover from v1. I will fix it in v3.

Regards,
Lorenzo

>=20
> > Introduce pbus-csr document bindings in syscon.yaml for EN7581 SoC.
> > The airoha pbus-csr block provides a configuration interface for the PB=
US
> > controller used to detect if a given address is accessible on PCIe
> > controller.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > Changes in v2:
> > - Move EN7581 pbus-csr binding in syscon.yaml
> > - Link to v1: https://lore.kernel.org/r/20250308-en7581-pbus_csr-bindin=
g-v1-1-999bdc0e0e74@kernel.org
> > ---
> >  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Docume=
ntation/devicetree/bindings/mfd/syscon.yaml
> > index 4d67ff26d445050cab2ca2fd8b49f734a93b8766..7639350e7ede40c8934f41f=
854ff219354fb3e5b 100644
> > --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> > @@ -27,6 +27,7 @@ select:
> >      compatible:
> >        contains:
> >          enum:
> > +          - airoha,en7581-pbus-csr
> >            - al,alpine-sysfabric-service
> >            - allwinner,sun8i-a83t-system-controller
> >            - allwinner,sun8i-h3-system-controller
> > @@ -126,6 +127,7 @@ properties:
> >    compatible:
> >      items:
> >        - enum:
> > +          - airoha,en7581-pbus-csr
> >            - al,alpine-sysfabric-service
> >            - allwinner,sun8i-a83t-system-controller
> >            - allwinner,sun8i-h3-system-controller
> >=20
> > ---
> > base-commit: d71fc910c58ed85a2ad5143502030bff73fc2088
> > change-id: 20250308-en7581-pbus_csr-binding-974e1b40fb36
> >=20
> > Best regards,
> > --=20
> > Lorenzo Bianconi <lorenzo@kernel.org>
> >=20
>=20
> --=20
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

--KCPVwl5RS58A8bfe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ9FFuwAKCRA6cBh0uS2t
rNLjAP9kWmIslDzWiifcSRt/tCjw8MyHIlsBk7LZcPCPHhA8zQD9G9Tj0lZtTehd
7rMBOTrvKOq6sLriO3Bmeq7M9CoTrAg=
=e28a
-----END PGP SIGNATURE-----

--KCPVwl5RS58A8bfe--

