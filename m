Return-Path: <linux-pci+bounces-9731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EFF9264CB
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 17:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87669B25164
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 15:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D89C17625D;
	Wed,  3 Jul 2024 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVEzViEm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E839D1607A3;
	Wed,  3 Jul 2024 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720020421; cv=none; b=idB80JzCfS4XK/zsEobT43mgtLuIjhB6gS3RkIu48mUZ25k2YH35n3ac6N6WDDceAYTm404NjTZwFhwpasbFHaRE84Wv/1a2k8egJMyKvusiIINV7378/g5oqLh9Ne/rnL/7X2D4vGwISGOfntkJSlhO2/gJHooOxn7aXfy4OYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720020421; c=relaxed/simple;
	bh=N4vxMVbN/1wWaojq7NWBk9zI796CImfymRagg0g64Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjMSrMiDsnv9gxetZEEIt+yQm3wA5KNM94r058y4O/2XY1GLKShT2PrJfVWiAwb8jAgqybmBx+pdLJLZWTib2R/c+z9pPQ8IUNYNBPYvd/iG2wWWv0P8AoKVxwvE20QjvrGBqAS9Zun3MnDG7rr2fFf/rQxgwubMWfKFkHjVwIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVEzViEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F5EC3277B;
	Wed,  3 Jul 2024 15:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720020420;
	bh=N4vxMVbN/1wWaojq7NWBk9zI796CImfymRagg0g64Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KVEzViEmgTryvbo67ejqXputtnUtDQlLex3jcnTX6xdGCWISGhmyzC+ih0oDfpIZr
	 /epx8HHobf4nkLCTm8ypSxyNUkSSKWkxBi6s2axbegKM3uRWmqLXf4ULzWGwVfl82T
	 NBu9mIva+Hv8/67wsNpn07XitQe51XE7unH2n4/z1vP8FstR8fKTVy9y9aPZki4G06
	 eEo9qUJQu76mpbKd0HOKXTGS4+IWchtJ+qC70prlFh58dWHnuLiXqbdgrB6QhPDxNk
	 0+7x1DKFipZbUb9865pzc4ObczGt4kiKeau/CbSAiHGvyQZuUg46/fyVrA2V2hBo1N
	 vUicNMdh7rYYw==
Date: Wed, 3 Jul 2024 17:26:56 +0200
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
Message-ID: <ZoVtwLI5nIRpS2al@lore-desk>
References: <ZoPEdU0Eg-f-mbgC@lore-rh-laptop>
 <20240702163439.GA24344@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MWCaVI3Z1esYwRTI"
Content-Disposition: inline
In-Reply-To: <20240702163439.GA24344@bhelgaas>


--MWCaVI3Z1esYwRTI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, Jul 02, 2024 at 11:12:21AM +0200, Lorenzo Bianconi wrote:
> > > On Sat, Jun 29, 2024 at 03:51:54PM +0200, Lorenzo Bianconi wrote:
> > > > Introduce support for Airoha EN7581 PCIe controller to mediatek-gen3
> > > > PCIe controller driver.
> > >=20
> > > > +/* PCIe reset line delay in ms */
> > > > +#define PCIE_RESET_TIME_MS		100
> > >=20
> > > Is this something required by the PCIe base spec, or is it specific to
> > > EN7581?  Either way it would be nice to have a citation to the spec
> > > (revision and section number).  If it's generic to PCIe, it should be
> > > in drivers/pci/pci.h so other drivers can use the same thing.
> >=20
> > It is just the time needed by the EN7581 reset controller to
> > complete the operation, it is not something PCIe generic (it is
> > something just related to EN7581 SoC).  Do you think we should move
> > it in EN7581 reset controller codebase?
>=20
> I have no opinion about moving it.  But it sounds like maybe it should
> have a less generic name so it doesn't look like a generic PCIe thing.
> And also a spec citation would be helpful for future maintenance.

ack, naming is always hard :)
I do not have any specific spec for it. It is in the vendor sdk and the Air=
oha
folks confirmed just this time is needed to complete PCIe reset.

Regards,
Lorenzo

--MWCaVI3Z1esYwRTI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZoVtwAAKCRA6cBh0uS2t
rEk6AP4+COe1VSjWr8FduLJECkrFJKAoJNbnCfjXkiRge8ZcKwEAtw0c8lHSfIsU
alNV8Cygnmt3ypUilONOyRTXJe2tPAM=
=uH7b
-----END PGP SIGNATURE-----

--MWCaVI3Z1esYwRTI--

