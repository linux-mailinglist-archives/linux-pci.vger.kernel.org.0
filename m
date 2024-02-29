Return-Path: <linux-pci+bounces-4272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F2D86D18A
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 19:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F1CDB266AF
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 18:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8A279DC5;
	Thu, 29 Feb 2024 18:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR5uVimo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E27678293;
	Thu, 29 Feb 2024 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230139; cv=none; b=WY1cUSX7L/xxXE7TVkbc8AcYjXJVxRzb3Ve+w1hUoAssFAzavY6NE1JgVISlS7n+4PNg7+uo6CYCBK04YxEr96RVLqrhVuehy3m9ar8xxAUWXPSLN0dazUSBkjiWaE7WLI9CLV+IkAZZZE+GDps92K54ijmbXBwJctJ4jyLT1Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230139; c=relaxed/simple;
	bh=nbZCCz5px6JjbfeYHv/GrHoTHGKZQxDjRcckuW8fpQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAcMmhb5aYeBhzAK5foetSlZs/0ad5z/laSksQVHGqk7CIdb09S41d0RWoQ0zebPvbz1q6oZRXFBdtHmzXuebpIMKAf+IhrcpVdSDDCKWE2IM+IVJtKjfvVI4W9AMn4M7/m6iYvzV1DB2hhm6SZglagLNtU7uq8vFmmyzIg1Rh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lR5uVimo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59288C433F1;
	Thu, 29 Feb 2024 18:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709230138;
	bh=nbZCCz5px6JjbfeYHv/GrHoTHGKZQxDjRcckuW8fpQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lR5uVimo391OfyuEVpj2RcpIVEXlBNj76gfYMLAl74R6gXtXEOxvPgArU7zYVEeAZ
	 QiambT42WsLDIgidy8iBWQOIPHMtFlwgMucCPCrijo94Y7/lc5QCzOkkpwhHqdbzuX
	 1GQJT7QIWJqVWO45VviJhXpDnh9oS7HB3r5MpUZXsNxZ3zpGWHSFisSLTIbAQZEQsn
	 JOAxHrGRQrACScps7QyZha392ih++0i0qenVV1F5nS6lEiYZQ87BRVRmIMR7ja7vZv
	 U/6Ylo+yUcn4Z2BWZd7UXljlPGukuJsTZb+LKoqKRp+c7gTjOX2CWZChUWih9P/7f5
	 18S4C65Dbq1Ow==
Date: Thu, 29 Feb 2024 18:08:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	linux-kernel@vger.kernel.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	helgaas@kernel.org, bhelgaas@google.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/5] dt-bindings: pci: layerscape-pci: Convert to yaml
 format
Message-ID: <20240229-strategic-premises-967eae1f6d9f@spud>
References: <20240228190321.580846-1-Frank.Li@nxp.com>
 <20240228190321.580846-2-Frank.Li@nxp.com>
 <170915420970.759733.12998246565079147606.robh@kernel.org>
 <ZeDCQezI2zj8bWBP@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Re0jwgYgtPOeuZKC"
Content-Disposition: inline
In-Reply-To: <ZeDCQezI2zj8bWBP@lizhi-Precision-Tower-5810>


--Re0jwgYgtPOeuZKC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 12:43:29PM -0500, Frank Li wrote:
> On Wed, Feb 28, 2024 at 03:03:31PM -0600, Rob Herring wrote:
> >=20
> > On Wed, 28 Feb 2024 14:03:17 -0500, Frank Li wrote:
> > > Split layerscape-pci.txt into two yaml files: fsl,layerscape-pcie-ep.=
yaml
> > > and fsl,layerscape-pcie.yaml.
> > > yaml files contain the same content as the original txt file.
> > >=20
> > > The subsequent commit will fix DTB_CHECK failure.
> > >=20
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  .../bindings/pci/fsl,layerscape-pcie-ep.yaml  |  89 +++++++++++++
> > >  .../bindings/pci/fsl,layerscape-pcie.yaml     | 123 ++++++++++++++++=
++
> > >  .../bindings/pci/layerscape-pci.txt           |  79 -----------
> > >  3 files changed, 212 insertions(+), 79 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layersc=
ape-pcie-ep.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layersc=
ape-pcie.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-=
pci.txt
> > >=20
> >=20
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> Please omit these errors. Bjorn require create a identical version as
> old txt file.
>=20
> Origial txt will cause DTB_CHECK error. The problem will be fixed at next
> patches.

One of these is a real error - caused by a typo. "dma-coherence" should
be "dma-coherent".

>=20
> >=20
> > yamllint warnings/errors:
> >=20
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/pci/fsl,layerscape-pcie.example.dtb: pcie@3400000: Unevaluated properties =
are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-=
range', 'device_type', 'interrupt-map', 'interrupt-map-mask', 'iommu-map', =
'msi-parent', 'ranges', 'reg-names' were unexpected)
> > 	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie=
=2Eyaml#
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/pci/fsl,layerscape-pcie.example.dtb: pcie@3400000: 'fsl,pcie-scfg' is a re=
quired property
> > 	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie=
=2Eyaml#
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/pci/fsl,layerscape-pcie.example.dtb: pcie@3400000: 'dma-coherence' is a re=
quired property
> > 	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie=
=2Eyaml#
> >=20
> > doc reference errors (make refcheckdocs):
> >=20
> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/2024=
0228190321.580846-2-Frank.Li@nxp.com
> >=20
> > The base for the series is generally the latest rc1. A different depend=
ency
> > should be noted in *this* patch.
> >=20
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> >=20
> > pip3 install dtschema --upgrade
> >=20
> > Please check and re-submit after running the above command yourself. No=
te
> > that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> > your schema. However, it must be unset to test all examples with your s=
chema.
> >=20

--Re0jwgYgtPOeuZKC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeDINQAKCRB4tDGHoIJi
0lRyAP9fEXfWNs46QnjOnUvH2S38xwB64vicfxsWzjSwnN6DzAD/Z/FNBFX2hAZ4
3gNGGsWbqATFWZOMzrQPjVBaQcNQKAw=
=Bh1c
-----END PGP SIGNATURE-----

--Re0jwgYgtPOeuZKC--

