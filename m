Return-Path: <linux-pci+bounces-9577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FA792398F
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 11:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1011C219DA
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 09:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE53152533;
	Tue,  2 Jul 2024 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ52Eem6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A1115216E;
	Tue,  2 Jul 2024 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719911546; cv=none; b=HgCBIPuOYIbmQQp/2m+oP5k5p24eEx1+QTU3LeO/yPz++enLW0HrS0FDxiTvBCiHsFJIImQKstrhwd7czw9PfD2GH9lRMzoVhSEhz//GF3Xi+XS9rFitJCTKZP26ibtwKVHYCAUv3KKCGVkmxigars1azAYE/2U3Dzg/CQMKxJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719911546; c=relaxed/simple;
	bh=QfDqM+46RuWvbEKiE81isawn+VstMt3edIuywum410E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUBee6l/Zry0886DRwQJU7CE85AgEacgIIMWAB+DKaMoqB5F9+D23bI4L8zMhiaou4zhMa1p1g2SnPu+1R/0GpRnO6RGWf/Fo2Kf+BfVUH/2eWirkMNJtmIVqQhRTpMz8jib8/K0UI/GS37i46Y1XTL0KijQJZe48msSDS36Xg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZ52Eem6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4443AC116B1;
	Tue,  2 Jul 2024 09:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719911545;
	bh=QfDqM+46RuWvbEKiE81isawn+VstMt3edIuywum410E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fZ52Eem6mvS159XLg0r9UR2KRx/n++dhirNQSlh8sJD74YmiG/PtmB1XQzqZZb9Qi
	 PKBMWn5qo2Na1F5LZrrYvg9+by9VnWVH/4Vs2sAgIHXADVognnbpX8egw4z3VirDiZ
	 VPpkrdh4ktFXruFAYMdjJXC+SW7wmhDKK/Rn1EXIkF8efrNEu7ZKw3cAWwcetPxem9
	 He4Y2cKFlKff4qqTYs5bWv9HtRD7AvZX21F3HcrMWI3OxOsdgmq8nuz08OMpRwI5QE
	 cNtgztlvlq4IypiWB3lxRsdWZTY0mFXpFDHhH2i4R/fUMBvb3j5idVz7w3OOcOOzlz
	 f26vy5hZSJMMg==
Date: Tue, 2 Jul 2024 11:12:21 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com,
	linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v3 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
Message-ID: <ZoPEdU0Eg-f-mbgC@lore-rh-laptop>
References: <27d28fabbf761e7a38bc6c8371234bf6a6462473.1719668763.git.lorenzo@kernel.org>
 <20240701202156.GA15356@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HIQev7ftCHv4QrpC"
Content-Disposition: inline
In-Reply-To: <20240701202156.GA15356@bhelgaas>


--HIQev7ftCHv4QrpC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, Jun 29, 2024 at 03:51:54PM +0200, Lorenzo Bianconi wrote:
> > Introduce support for Airoha EN7581 PCIe controller to mediatek-gen3
> > PCIe controller driver.
>=20
> > +/* PCIe reset line delay in ms */
> > +#define PCIE_RESET_TIME_MS		100
>=20
> Is this something required by the PCIe base spec, or is it specific to
> EN7581?  Either way it would be nice to have a citation to the spec
> (revision and section number).  If it's generic to PCIe, it should be
> in drivers/pci/pci.h so other drivers can use the same thing.

It is just the time needed by the EN7581 reset controller to complete the o=
peration,
it is not something PCIe generic (it is something just related to EN7581 So=
C).
Do you think we should move it in EN7581 reset controller codebase?

Regards,
Lorenzo

--HIQev7ftCHv4QrpC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZoPEcgAKCRA6cBh0uS2t
rN35AP9EfUH7hNs7C3dKX0KvkFnD1J8wnkXNrAJzJw0HtLwpmAEAn6bO3foyRPn3
JK+WBsXC8supqVXB8FsdyzUHrHGzTgw=
=p+m8
-----END PGP SIGNATURE-----

--HIQev7ftCHv4QrpC--

