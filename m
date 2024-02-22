Return-Path: <linux-pci+bounces-3882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 937FB8601B5
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 19:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDBE2881C8
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 18:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582921EA95;
	Thu, 22 Feb 2024 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8oT0tXV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A2C14B800;
	Thu, 22 Feb 2024 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626875; cv=none; b=iQdQH4hxd9doAb48goykcLAk3C8rM8KRUAW7sPewFYu6ejUDUR3d2znbZE5M4vOheibD+BTQVOkiFi2Dnxn8YZ4zj/hjHahgJAvZ1+1dZVP2Lv3d7yjuUBP+rwkI6dMQ5Ome0fLrI1StTV+/reXuuakXzioXTThPX/a0ZP6qC+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626875; c=relaxed/simple;
	bh=bvKuvKytbBtOqC4SY6tWbkwrs+qn3Ow0VkeI33yKTic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVzUrBpGyPqlKU0yuYsa/qATyhrOs4lMibCHybmu1doko36YX9FZ5dBfz5655Z4uniN+yQo9lr7pvWIluyj6B5rcNRbOEjOuVJ8SNEOU3gUmPgr+hv2tHb0xMFQIBoAPmIJgJN2iK0a6ZyY6vugjWyChW35B0olGZ7lCTq3BVus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8oT0tXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8EDC433C7;
	Thu, 22 Feb 2024 18:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708626874;
	bh=bvKuvKytbBtOqC4SY6tWbkwrs+qn3Ow0VkeI33yKTic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G8oT0tXVU4X7BItZoA+QBGG7v64UjhuOc2fwK5PtsL5lxYiSvr+oioLkQ/YUj/Bfj
	 ZSQHeZq3IHUe8srHmb3OOGEdQttgW7ucrf67qQC92RsPJAG7Ss1pnYpqTNAaKpnwnT
	 7XGmI5ZsPjpIX9BBv1tG+ndivz4pDp9Qaiy9KS50Lp8tqv92FEeWf6jECYQfrOUvDn
	 LD9O4UQOCars0jZwM3YUEMhJUwVsj02JNejh/4Y0NwZkJSFquzxytyLJZk1V57/wxi
	 eXih8b7HxjUWmHslJr8KxgliYRk/cOXrxpnoRpV6k4bMcHwDd/AAHC7jh9Di55mXWu
	 jC/7CCBQCatCw==
Date: Thu, 22 Feb 2024 18:34:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: pci: layerscape-pci: Convert to yaml
 format
Message-ID: <20240222-cardboard-mousiness-1f0cc1389f5d@spud>
References: <20240214194145.2669744-1-Frank.Li@nxp.com>
 <ZdPJys6OWGewNgX4@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pmwBZ8CSTAd4wZRC"
Content-Disposition: inline
In-Reply-To: <ZdPJys6OWGewNgX4@lizhi-Precision-Tower-5810>


--pmwBZ8CSTAd4wZRC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 04:36:10PM -0500, Frank Li wrote:
> On Wed, Feb 14, 2024 at 02:41:44PM -0500, Frank Li wrote:
> > Convert the layerscape-pci PCIe binding document to yaml format.
> >=20
> > Additionally, changes for the layerscape-pci endpoint part:
> > - Add interrupt name 'pme' restriction for fsl,ls1028a-pcie-ep,
> > fsl,ls1046a-pcie-ep, and fsl,ls1088a-pcie-ep.
> > - Add register name restrictions: 'reg' and 'addr_space'. 'addr_space' =
is
> > required by snps,dw-pcie-ep.
> > - Add an example.
> >=20
> > Changes for the layerscape-pci root complex part:
> > - Add required property: 'reg-names', "#address-cells", "#size-cells",
> > 'device_type', 'bus-range', 'ranges', "#interrupt-cells",
> > 'interrupt-map-mask' and 'interrupt-map'.
> > - Interrupt-names requirement split to each compatible string.
> > - Add register name restrictions: 'reg' and 'config'. 'config' is requi=
red
> > by snps,dw-pcie.
>=20
> @conor
>     Any comments about this one?

Sorry I missed this - I've been sick the last week and probably
overzealously deleted stuff from my mailbox. I see Rob replied to this
as I was in the process of reading through the patch, so I only left two
minor comments here.


> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    soc {
> > +      #address-cells =3D <2>;
> > +      #size-cells =3D <2>;
> > +
> > +      pcie_ep1: pcie-ep@3400000 {

Nit: unused label.

> > +allOf:
> > +  - $ref: /schemas/pci/pci-bus.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - fsl,lx2160a-pcie
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 2
> > +        interrupt-names:
> > +          items:
> > +            - const: pme
> > +            - const: aer
> > +            - const: intr

You set maxItems to 2 but there are 3 names. That doesn't seem right!

Chers,
Conor.

--pmwBZ8CSTAd4wZRC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdeTtgAKCRB4tDGHoIJi
0n4oAPjEU95BElZ57lil+e0CiVomgjohQVzInjwCtSiJvxOTAP9enJlRBahLf2bB
iF6yOklO25g+/lcbiEUHvAvFfjUOBw==
=dDxo
-----END PGP SIGNATURE-----

--pmwBZ8CSTAd4wZRC--

