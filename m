Return-Path: <linux-pci+bounces-3251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A163884EA07
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 22:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8DC51C228E5
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 21:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8D54A990;
	Thu,  8 Feb 2024 21:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWLEbdJl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED68D149DF8;
	Thu,  8 Feb 2024 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707426163; cv=none; b=PyHDmeuqRxIYx2YR8jIpGnZtsqA0Ax7zNdml1LM2n/xs3PCNWUpmftw1S1JruptprmwxQEmxPB2cA0sLrdsXyysL6UprhV0DLsSFB3sT98ujJzCfkJmrZ/PBAjIZqrcg+F6GiCYBJGnUIiSGIt7ucOjGmkEtcyuixr83FA30G4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707426163; c=relaxed/simple;
	bh=9o+cviq5kEoHDzHUTgK5/QBBVE/KPaRbFcYqh1I4jLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3K5D8xAlNgRm/dLjrsaBYyC3Sr5QSD6kzJ6oYYPqL9w8GcNXch4tVrwhtX6MQf6MYDi4MV7j5Xiqn33kfp4R4aNIvCFyJDjJ85nuLe9jhyAt4QYvIZFdHpC/4MRIzqqtFXtQrol5M8MWgEyP32ujNOK8/mhBsnjBAtlZUJl9Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWLEbdJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40310C433C7;
	Thu,  8 Feb 2024 21:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707426162;
	bh=9o+cviq5kEoHDzHUTgK5/QBBVE/KPaRbFcYqh1I4jLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gWLEbdJlYl/ZYqS0IDroMY0q3MKyhayNdE3lxjCV8DseZVr0HAsMYVgBIPZthF6Ni
	 cG/kZeF5dWlyRKgqKZx6Je1i1hcYG9HM3k+P+qqNipRim4O9xo9wNbEVLr9k22Kr/m
	 N+lrEYH6s1yHBLpEryXvwY6+6yFYdjP6dlBS0btEgPDSjAyi8GdGwqc2X1Er4S4sp0
	 Qb6IGt2czmBZPofBcQ/nigwIEGHl6QEvZGdkuHfj1QWjM00H/4Bqk/NnlVBx5Nx2TD
	 1JQJgvR1Od4cUoha3xUzYs2A/s90HvVLmmfSxenzeB/4maAo2LjoDWKALPUocwje4o
	 m5H6LmzdLQaAQ==
Date: Thu, 8 Feb 2024 21:02:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: pci: layerscape-pci: Convert to yaml
 file
Message-ID: <20240208-moisten-jaws-35a4935dca44@spud>
References: <20240207231550.2663689-1-Frank.Li@nxp.com>
 <20240208-subfloor-polka-96bbbbc27fb0@spud>
 <ZcUyqaxf52GivQnd@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WmaGg2xNACeUW1/d"
Content-Disposition: inline
In-Reply-To: <ZcUyqaxf52GivQnd@lizhi-Precision-Tower-5810>


--WmaGg2xNACeUW1/d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 02:59:37PM -0500, Frank Li wrote:
> On Thu, Feb 08, 2024 at 07:26:15PM +0000, Conor Dooley wrote:
> > On Wed, Feb 07, 2024 at 06:15:49PM -0500, Frank Li wrote:
> > > Convert layerscape pcie bind document to yaml file.
> > >=20
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >=20
> > Please don't send new versions before giving people a chance to finish
> > the discussion on the existing ones. This is not the first time in the
> > last few days I am asking you this. Nobody pays me to review DT
> > bindings, so you'll have to accept that I will take some time to reply.
>=20
> Usb-glitch patch
> v1, I sent at Jan 19.=20
> v2, I sent at Jan 21.
> v4, at Jan 24.=20

Actually, I think I need to apologise. My first reply to you on v1 came
after you send the v4, so you didn't send new versions in that case
during a conversation - but sending 4 versions in 5 days is just going
to lead to people reviewing the old versions of a series. Please just
take a little more time between versions :)

> Generally, I send patch quick because I accepted their suggestion. It will
> be clear base on the new version. There are not big dissension need be
> discussed.=20
>=20
> About this one, I think first one have bigger problem because just convert
> txt to yaml file. Base on this version will be easy to discuss futher.

> The samething for me, nobody pays me to work this patch, which is my extra
> work.

Thanks for spending your free time working on binding conversions :)

--WmaGg2xNACeUW1/d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcVBbQAKCRB4tDGHoIJi
0un1AP9TsH6E9Z5p9TZzobwdGratw7ep4NgGW8SdqVgfGcKhzwD/VoMWX8J7YO+m
oh7+i17+eYHwZ6LfCUlirk576gpNTQ4=
=5N4M
-----END PGP SIGNATURE-----

--WmaGg2xNACeUW1/d--

