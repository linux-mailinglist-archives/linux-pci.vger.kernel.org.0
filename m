Return-Path: <linux-pci+bounces-9130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09C1913937
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 11:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A331F21C17
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 09:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C523D51C;
	Sun, 23 Jun 2024 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSk0Jcf0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ED538C;
	Sun, 23 Jun 2024 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719135097; cv=none; b=ZqJ7GpR3OX1v52R/cYkuEBXMzY38hI1VMy+VZ7D2NIT0Yuf2MwNj5xDQn4PY8jJ8V3TPxYloOdKZNNh+M99I6brfE3ZpOi/ZkXHSYIRcwycHreY1dW8dngM5U/cE3NM2GOEken8BvfMM4mxYih4pXaiKGBGhC5nP6UQHkwYgGC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719135097; c=relaxed/simple;
	bh=mmkFqQCWNWhI9vMGLTThsVmNtKKLibTwrxANXk3fnLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJEY3rZtRCSOOZ+xp46ficY/PmDLMoTAQ4ih0C+yBvANo9UUHqIhSCrAjLItMYtrBLPex8N7mniRod4o8Z0lBHei0gJc/pHV/zWkqv+H/buFAyyuJZjuM6/4VmsSelASnbbNl9Miao3Q9asQ2xR0eXa7AB+X7n3yunBzl3xNmCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSk0Jcf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144BAC2BD10;
	Sun, 23 Jun 2024 09:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719135096;
	bh=mmkFqQCWNWhI9vMGLTThsVmNtKKLibTwrxANXk3fnLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gSk0Jcf0ZmSdEdzC9y2jzm4UfWnBwEVmUJA1s9qbCCGCpaHX62uNp9LcAN1Empo3w
	 2h3Zy6S1Fvv4OJftNEBmG7kvQb1OmcIiyJDNi874ISwu0rmLhtQnY3CzME0TY9ik8p
	 wMZpwejzkWvDCxsATVljcrKzaoyg44Z3cP67EV596U4en/Vxt/caop8qMiH4pwTPTx
	 XQ/1WJgzokRw0FnqecQwAutSwfmCNGSlz+cBq9pF82vNAEqBrokcwXG+tGRNGMSBLY
	 g54QTHtZf3xRBNT+o+cLOmUjbfRouMfu6bACDgTV5zV5BrVH/Jq1dxFj45pexVELJq
	 gN6DV0kxmP5jw==
Date: Sun, 23 Jun 2024 11:31:32 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-mediatek@lists.infradead.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH 1/4] dt-bindings: PCI: mediatek-gen3: add support for
 Airoha EN7581
Message-ID: <ZnfrdF8Q7kRUudq1@lore-desk>
References: <cover.1718980864.git.lorenzo@kernel.org>
 <a215d6d8a91fccdbd1a28dd3262a3e5db1b728fd.1718980864.git.lorenzo@kernel.org>
 <20240622-ripple-skylight-cdf172afde61@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="74VzLLej2lJJYR4f"
Content-Disposition: inline
In-Reply-To: <20240622-ripple-skylight-cdf172afde61@spud>


--74VzLLej2lJJYR4f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, Jun 21, 2024 at 04:48:47PM +0200, Lorenzo Bianconi wrote:
> > Introduce Airoha EN7581 entry in mediatek-gen3 PCIe controller binding
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../bindings/pci/mediatek-pcie-gen3.yaml      | 25 +++++++++++++++----
> >  1 file changed, 20 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.y=
aml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > index 76d742051f73..0f35cf49de63 100644
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
>=20
> You've now relaxed the clock requirements for all devices,
> and permitted an extra reset on the existing platforms. You'll need to
> add some per-device min/maxItems constraints to solve that.

ack, I will fix it in v2.

Regards,
Lorenzo

>=20
> Thanks,
> Conor.
>=20
>=20
> >      maxItems: 6
> > =20
> >    assigned-clocks:
> > @@ -186,6 +187,20 @@ allOf:
> >              - const: tl_26m
> >              - const: peri_26m
> >              - const: top_133m
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          const: airoha,en7581-pcie
> > +    then:
> > +      properties:
> > +        clock-names:
> > +          items:
> > +            - const: sys_ck
> > +        reset-names:
> > +          items:
> > +            - const: phy-lane0
> > +            - const: phy-lane1
> > +            - const: phy-lane2
> > =20
> >  unevaluatedProperties: false
> > =20
> > --=20
> > 2.45.2
> >=20
> >=20



--74VzLLej2lJJYR4f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZnfrdAAKCRA6cBh0uS2t
rOkIAQCVSXTV3xENYTEyf+1j+ekpZaKsAp4R8xyTSgF2apueWAEA4MkUFvZFd35T
MsWFBfAu26UqJSHFbAHsudq/K+3O0gI=
=W1o1
-----END PGP SIGNATURE-----

--74VzLLej2lJJYR4f--

