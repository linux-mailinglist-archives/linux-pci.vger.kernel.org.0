Return-Path: <linux-pci+bounces-26698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143CEA9B24F
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 17:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D48E4A3077
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD151A841C;
	Thu, 24 Apr 2025 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evU1wmVS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1281422AB;
	Thu, 24 Apr 2025 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508643; cv=none; b=JlTrhelYfv56clCAD1t5GALLZSD3WwUviHg6ou33tJ949pIKsRvnNwHYeBPfz35R6YgVGG2dCIjh1v2a2bg0GRQTGWBVkAFv25VQMk8ZUUDzbl9uW2urU/sgKFWRYv9Tk73S175dnwS5kT8qf7x4ONS4yj4iGMoKEcNFH8etwNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508643; c=relaxed/simple;
	bh=F2Zu0d83wpmzJlR6hgO8n1irqHavV/MPiGgpkEDFoNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmu42jwAOnniqxvYmtZhtHOyd6MzKrqciHUVuC1Ofl1GiYdnlJ2YGw4vJJJt70/WWSS6gAWzAZ+j8UT1FK8uEmnA89y8fhVJABfcFuNJgFhpX/qhor4zy1CH7pAe6I3GxsKetqmAjqC7ybEQkHz4rLl5lQxyVhKzKageI0QEe+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evU1wmVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCF8C4CEE3;
	Thu, 24 Apr 2025 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745508642;
	bh=F2Zu0d83wpmzJlR6hgO8n1irqHavV/MPiGgpkEDFoNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=evU1wmVS8ajBXXfPEORI3cWyfH2tPHntaBg6lFcqMUxVnYovlUsBbW6M1DJLwKZ3w
	 6XkiWJh2/6r57vFUWfRhAlYpdj4eRsW5SyD87EGXYGO0JrXKAoIkUxh4GELZVf6jy4
	 dm6VGkgfC0UbTIZBSxJCf7+gYrsj/CC5hhCNBqc/ZGUv6T7/IVLpDZmeHfinRahR0e
	 okXlXh00ZfnpwzIsEkRc8dMwvwjrWKnJ7xUSeBrCFkNhUTxnY5IC/14CpN/hVrvu54
	 EMmlYNbW4gdX9WNhGmFKA1Si9/eZ1xeLfuXrHl5MsarNKL8PFtRN75mcSC/KJQBH1+
	 FUxX4zMjspxNQ==
Date: Thu, 24 Apr 2025 16:30:37 +0100
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
Message-ID: <20250424-proposal-decrease-ba384a37efa6@spud>
References: <20250424010445.2260090-1-hans.zhang@cixtech.com>
 <20250424010445.2260090-3-hans.zhang@cixtech.com>
 <20250424-elm-magma-b791798477ab@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GFIonBy2QUjipRLN"
Content-Disposition: inline
In-Reply-To: <20250424-elm-magma-b791798477ab@spud>


--GFIonBy2QUjipRLN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 04:29:35PM +0100, Conor Dooley wrote:
> On Thu, Apr 24, 2025 at 09:04:41AM +0800, hans.zhang@cixtech.com wrote:
> > From: Manikandan K Pillai <mpillai@cadence.com>
> >=20
> > Document the compatible property for HPA (High Performance Architecture)
> > PCIe controller EP configuration.
>=20
> Please explain what makes the new architecture sufficiently different
> from the existing one such that a fallback compatible does not work.
>=20
> Same applies to the other binding patch.

Additionally, since this IP is likely in use on your sky1 SoC, why is a
soc-specific compatible for your integration not needed?

>=20
> Thanks,
> Conor.
>=20
> >=20
> > Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
> > Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> > ---
> >  .../devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml          | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.ya=
ml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
> > index 98651ab22103..a7e404e4f690 100644
> > --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
> > +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
> > @@ -7,14 +7,16 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  title: Cadence PCIe EP Controller
> > =20
> >  maintainers:
> > -  - Tom Joseph <tjoseph@cadence.com>
> > +  - Manikandan K Pillai <mpillai@cadence.com>
> > =20
> >  allOf:
> >    - $ref: cdns-pcie-ep.yaml#
> > =20
> >  properties:
> >    compatible:
> > -    const: cdns,cdns-pcie-ep
> > +    enum:
> > +      - cdns,cdns-pcie-ep
> > +      - cdns,cdns-pcie-hpa-ep
> > =20
> >    reg:
> >      maxItems: 2
> > --=20
> > 2.47.1
> >=20



--GFIonBy2QUjipRLN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaApZHQAKCRB4tDGHoIJi
0h91AQCl6p1lnD7DkZJBQGatyBpgmjcCvY6y3d8js+Mbf1hBUAD4n6/pTLDh6mpo
JwqSQwAfhCxv8hBjwJwMbAtwYOAiDA==
=N1px
-----END PGP SIGNATURE-----

--GFIonBy2QUjipRLN--

