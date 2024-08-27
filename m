Return-Path: <linux-pci+bounces-12294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DE19614B9
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 18:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598571F211EF
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 16:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9661C6893;
	Tue, 27 Aug 2024 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hedFYLG2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEB61C27;
	Tue, 27 Aug 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777771; cv=none; b=tiF2pgo+dyOuizzyDz3iJnWAD8lTGmvKIypwb1N7vuXmBWPcRWi2KG1M/UQY8mLlxlH/cg9tBqISn1wzil5dP9D/6wIFba8LMa3MZx7x2ovnTdWvcbY0KUarc+XniXOa6lUxKmipVa9CTZx3nxUy6I4ZsUVdplkSxmxIhB6J9No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777771; c=relaxed/simple;
	bh=TpgY5Goxq3Cb2OOuAE/kh9u2rtmTr3lvYDP7Tgu5rSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/jiYzxrxsj1hajj4as0uKOOuBl0MOEp4GNxgvysjhQzYtYEPAJSut6A1+hflnHWsfI6Vind1mxTKSbEnt94NlOgZFOodSoVcXoyeYvaQl6fziJZx6gZ9rIv31dh0vEs3la8u/TO53pZvtnvR2ZJCpZ8ZSbQj0BMUBV9yLmnU80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hedFYLG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77D3C4AF63;
	Tue, 27 Aug 2024 16:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724777770;
	bh=TpgY5Goxq3Cb2OOuAE/kh9u2rtmTr3lvYDP7Tgu5rSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hedFYLG280viYumUxRNfeuVYQ53WQMvOuhkG+AqbMfgJck8q7U1F3GxtFOTMziu07
	 rbD2xgSmxKUpk3nnW9XZnJMXBz6o8jbaRBy2k51+4MRtOJSq6h4vn2C7Rf4BLl5UEz
	 d9iy4umTjg1bt1ncruuY9JXtlO6Ai6f0/+Lffjzo77RNLu/2SHaFghcrEMNM/Aai7M
	 2eGJmevsSyeLZWB3DvoIM+t/4InlLMRQwMArTqp4ZQN3IeDrsCSxctRGMDAFSK3mud
	 NybessVmdUBU/GqSHy3uAQNEPGmZpjIeny2RgCEGnFZmPP37GZwbnYkyCFqVyt4ezX
	 TqtEGMpVzxBkA==
Date: Tue, 27 Aug 2024 17:56:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Olof Johansson <olof@lixom.net>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 1/3] dt-bindings: PCI: layerscape-pci: Replace
 fsl,lx2160a-pcie with fsl,lx2160ar2-pcie
Message-ID: <20240827-sepia-setup-fb8396972b54@spud>
References: <20240826-2160r2-v1-0-106340d538d6@nxp.com>
 <20240826-2160r2-v1-1-106340d538d6@nxp.com>
 <20240827-breeding-vagrancy-22cd1e1f9428@spud>
 <Zs3/qnkcSl4pQQSg@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RgNqtIwAT2TJQYCf"
Content-Disposition: inline
In-Reply-To: <Zs3/qnkcSl4pQQSg@lizhi-Precision-Tower-5810>


--RgNqtIwAT2TJQYCf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 12:32:42PM -0400, Frank Li wrote:
> On Tue, Aug 27, 2024 at 05:14:32PM +0100, Conor Dooley wrote:
> > On Mon, Aug 26, 2024 at 05:38:32PM -0400, Frank Li wrote:
> > > fsl,lx2160a-pcie compatible is used for mobivel according to
> > > Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
> > >
> > > fsl,layerscape-pcie.yaml is used for designware PCIe controller bindi=
ng. So
> > > change it to fsl,lx2160ar2-pcie and allow fall back to fsl,ls2088a-pc=
ie.
> > >
> > > Sort compatible string.
> > >
> > > Fixes: 24cd7ecb3886 ("dt-bindings: PCI: layerscape-pci: Convert to YA=
ML format")
> >
> > I don't understand what this fixes tag is for, this is a brand new
> > compatible that you are adding, why does it need a fixes tag pointing to
> > the conversion?
>=20
> Because previous convert wrongly included "fsl,lx2160a-pcie" here, which
> already used for mobivel pci controler, descripted in
> layerscape-pcie-gen4.txt.
>=20
> This patch fix this problem, rename fsl,lx2160a-pcie to fsl,lx2160ar2-pcie

Ah, I see that now. Lost in the noise of reordering the list first time
around.

--RgNqtIwAT2TJQYCf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZs4FJQAKCRB4tDGHoIJi
0vLRAPsFrYnP12WBONWVolx0rNNnFpQTkL5y3HnprcmHPNCnZQD+NFrvy1AmEWLb
DBcuFN8q7NWORpAJEjIQcsxB6hIy7wk=
=BUL8
-----END PGP SIGNATURE-----

--RgNqtIwAT2TJQYCf--

