Return-Path: <linux-pci+bounces-9440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD8291CC55
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 13:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EDFAB20B61
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 11:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46814084C;
	Sat, 29 Jun 2024 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tq9RP4v3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC151CF8D;
	Sat, 29 Jun 2024 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719659803; cv=none; b=tudG+HoMUGk4epz94W+IrG8je87+NbkseCY3IBfnSXKDdogRnvuQi7l2Ksh7BnODjtGQH0EVINIQWvZhATLbN0o4o2zOCn1wxp2H3AF8AAd8lSXpMoCwOzHNMVp1c8Vwl6aVOYpC22af/2mdt9b0+Oa1HnnLgZ3QIv5+s7uYc90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719659803; c=relaxed/simple;
	bh=IUthPw6q8Xxh7m+uFZiIAUjqhMqeAyzsdGSzigmphv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ET2QeL1PcDs7X/Ni+vZw/4brkQD06k+aU/WUw7lJwHuVfYYr3vP+yhuMXq06vcyOmTnJLmKXZsXLr0vCiNTKY6kxEjH4h09TU5n1nuZxZOPeGBJQ92AuhIeLawSxCRDr0N6y6U5ESAfvIB65yFauH6oYNFiHYVfSZezIjSs3qXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tq9RP4v3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5014C2BBFC;
	Sat, 29 Jun 2024 11:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719659803;
	bh=IUthPw6q8Xxh7m+uFZiIAUjqhMqeAyzsdGSzigmphv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tq9RP4v3wOheZaeTkMoREvNu74nxkxyN2vHE1lEVOpqP5CAzyYguiOXp9hFL3AmLy
	 eVFZTVEfhULQydrQ1CAxQOd3S51HwZY7FmDWpZy7EGea4s8EEtg8mFAZWNCsDIAkd/
	 l6t4YxeJQkx9+B2R1Z8TtlbsBv3QikJmATPdBl7/vJPsFXNi95ZoGMS8ucc2f6BhYP
	 FVhDNA1UeiXsNJYoi4OAgIM4Kk+RvxMo/a/0eNdNJtxT9e4VnF4q3lMGvzMCGIjmKb
	 32OOyKjubihQksVJW8rvmQpcp/+rVGtkrB/zyR2NY1/FgiJNDH71t/wDrhN9PKBJ0y
	 gS0SyFCAqeTzw==
Date: Sat, 29 Jun 2024 13:16:39 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Conor Dooley <conor@kernel.org>
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
Message-ID: <Zn_tF4xNADB1Z2bE@lore-desk>
References: <cover.1719475568.git.lorenzo@kernel.org>
 <c11a40dbe3e1d1e4847ceee8715c1f670fd1887b.1719475568.git.lorenzo@kernel.org>
 <20240627-evergreen-oppressor-21deb5c83412@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yc80wPPNW1Sai7R4"
Content-Disposition: inline
In-Reply-To: <20240627-evergreen-oppressor-21deb5c83412@spud>


--Yc80wPPNW1Sai7R4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Jun 27, 2024 at 10:12:11AM +0200, Lorenzo Bianconi wrote:
> > Introduce Airoha EN7581 entry in mediatek-gen3 PCIe controller binding
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../bindings/pci/mediatek-pcie-gen3.yaml      | 68 +++++++++++++++++--
> >  1 file changed, 63 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.y=
aml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > index 76d742051f73..59112adc9ba1 100644
> > --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > @@ -53,6 +53,7 @@ properties:
> >                - mediatek,mt8195-pcie
> >            - const: mediatek,mt8192-pcie
> >        - const: mediatek,mt8192-pcie
> > +      - const: airoha,en7581-pcie
> > =20
> >    reg:
> >      maxItems: 1
> > @@ -76,20 +77,20 @@ properties:
> > =20
> >    resets:
> >      minItems: 1
> > -    maxItems: 2
> > +    maxItems: 3
> > =20
> >    reset-names:
> >      minItems: 1
> > -    maxItems: 2
> > +    maxItems: 3
> >      items:
> > -      enum: [ phy, mac ]
> > +      enum: [ phy, mac, phy-lane0, phy-lane1, phy-lane2 ]
> > =20
> >    clocks:
> > -    minItems: 4
> > +    minItems: 1
> >      maxItems: 6
> > =20
> >    clock-names:
> > -    minItems: 4
> > +    minItems: 1
> >      maxItems: 6
> > =20
> >    assigned-clocks:
> > @@ -147,6 +148,9 @@ allOf:
> >            const: mediatek,mt8192-pcie
> >      then:
> >        properties:
> > +        clocks:
> > +          maxItems: 6
> > +
> >          clock-names:
> >            items:
> >              - const: pl_250m
> > @@ -155,6 +159,15 @@ allOf:
> >              - const: tl_32k
> >              - const: peri_26m
> >              - const: top_133m
> > +
> > +        resets:
> > +          minItems: 1
> > +          maxItems: 2
> > +
> > +        reset-names:
> > +          minItems: 1
> > +          maxItems: 2
> > +
> >    - if:
> >        properties:
> >          compatible:
> > @@ -164,6 +177,9 @@ allOf:
> >                - mediatek,mt8195-pcie
> >      then:
> >        properties:
> > +        clocks:
> > +          maxItems: 6
>=20
> How come this is maxItems and not minItems? The max is always 6, before
> and after your patch.

ack, I will fix in v3

Regards,
Lorenzo

>=20
> Cheers,
> Conor.



--Yc80wPPNW1Sai7R4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZn/tFwAKCRA6cBh0uS2t
rPBkAPkByGAHSc9sSo+LyYsfPbigChxVRx3RRo8JU9/v060TNwD/UdFWihrwMXYc
d/pzY8RPKCX5ZnsPem0Fwg0h4BBQwwk=
=kx87
-----END PGP SIGNATURE-----

--Yc80wPPNW1Sai7R4--

