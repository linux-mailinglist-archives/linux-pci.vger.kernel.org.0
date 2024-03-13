Return-Path: <linux-pci+bounces-4788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EEB87A8CC
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 14:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F392B21EE2
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 13:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9607A43AB2;
	Wed, 13 Mar 2024 13:56:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from vm3.sequanux.org (static.68.236.76.144.clients.your-server.de [144.76.236.68])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3BC39860;
	Wed, 13 Mar 2024 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.236.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338176; cv=none; b=MPUHcOpCpxPQ6bFf9PdElOlxlj0yqMyFL7tDhlCsh9d9HGPzIlSe4mRGjehCxHKTSbetM0mBZmCgJPsZAVnWquNpqj5VAdFBgV86FBOjS5ugfp+VE3d2g60fGwPptM0Q6Ju01XFq+Q3sH5UuD3oXyNPpzuVtziNooS9HxwZ+VrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338176; c=relaxed/simple;
	bh=3xfXWowKXIUy7WOzMOjdDR46YrTwruVTW+DQSDGDdL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBNe6bjV5Xs1cz3JB55CKrTCPzpaPHk2dpT8Nyx2i0Jc9YtGYKHDoOasrpJgeD4ztLom+gJ55znnNP2eMT9agP4RkZM7LAnrCBc86pPvBZhoL4zfFDXu2MRbV1DJ62vtTm4htQr/Web4EaOMgnTsZ2hdDTxOGaI2S60U6EWDZCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sequanux.org; spf=pass smtp.mailfrom=sequanux.org; arc=none smtp.client-ip=144.76.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sequanux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sequanux.org
Received: from localhost (localhost.localdomain [127.0.0.1])
	by vm3.sequanux.org (Postfix) with ESMTP id 75860108ACB;
	Wed, 13 Mar 2024 14:55:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at vm3.sequanux.org
Received: from vm3.sequanux.org ([127.0.0.1])
	by localhost (vm3.sequanux.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8xtazUWw3KBV; Wed, 13 Mar 2024 14:55:20 +0100 (CET)
Received: from localhost (ns3093303.ip-145-239-244.eu [145.239.244.120])
	by vm3.sequanux.org (Postfix) with ESMTPSA id 1D9DE108A60;
	Wed, 13 Mar 2024 14:55:20 +0100 (CET)
Date: Wed, 13 Mar 2024 14:55:03 +0100
From: simon.guinot@sequanux.org
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Simon Guinot <simon.guinot@seagate.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: fix link retrain status in
 pcie_wait_for_link_delay()
Message-ID: <ZfGwN0PWF6M9kp0v@localhost>
References: <20240313094938.484113-1-simon.guinot@seagate.com>
 <53b2239b-4a23-a948-a422-4005cbf76148@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FV8bZ/8jnt890/Cz"
Content-Disposition: inline
In-Reply-To: <53b2239b-4a23-a948-a422-4005cbf76148@linux.intel.com>


--FV8bZ/8jnt890/Cz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 02:00:21PM +0200, Ilpo J=C3=A4rvinen wrote:
> On Wed, 13 Mar 2024, Simon Guinot wrote:
>=20
> > The current code in pcie_wait_for_link_delay() handles the value
> > returned by pcie_failed_link_retrain() as an integer, expecting 0
> > when the link has been successfully retrained. The issue is that
> > pcie_failed_link_retrain() returns a boolean: "true" if the link
> > has been successfully retrained and "false" otherwise. This leads
> > pcie_wait_for_link_delay() to return an incorrect "active link"
> > status when pcie_failed_link_retrain() is called.
> >=20
> > This patch fixes the check of the value returned by
> > pcie_failed_link_retrain() in pcie_wait_for_link_delay().
> >=20
> > Note that this bug induces abnormal timeout delays when a PCI device
> > is unplugged (around 60 seconds per bridge / secondary bus removed).
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: 1abb47390350 ("Merge branch 'pci/enumeration'")
> > Signed-off-by: Simon Guinot <simon.guinot@seagate.com>
>=20
> Hi Simon,
>=20
> Thanks for your patch. There's, however, already a better series to fix=
=20
> this and other related issues. Bjorn just hasn't gotten into applying the=
m=20
> yet:
>=20
> https://patchwork.kernel.org/project/linux-pci/list/?series=3D824858
>=20
> (I proposed a patch very similar to yours month ago, but Maciej came up=
=20
> a better way to fix all the issues.)

Hi Ilpo,

Thanks for pointing this patch series. This indeed fixes the timeout delay
issue I observed.

Simon

--FV8bZ/8jnt890/Cz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXW8DgovlR3VS5hA0zyg/RDPmszoFAmXxsDQACgkQzyg/RDPm
szpC7RAAz4J+6UCQTn9hQ6BWFzd6ZG5Zc/U4EngEO9f4l9qVqC/EyZW9Q3fm9rms
oj5tuUPW5SlbX+ZwO9xL3Hqb4vtRZfeNSEam4Pt4CQnDEV1d0E9mmj+Qt36b1rTc
xOROQ86VHgKZSXu8PrMqfVKaWBUeUr3tuwO1LjU/RsmAUWNJtwPuBtBrQlBG/UU9
WpfvZ+W2XyudnTH3ItLkE/sz06i51659+zkjDSdeggoZQPG6AZ6DdKz7UH8KOqoZ
xu4jFrwQuoGyHB/S1umY2ozxglCZNwMdg5QHVWjgwAjTZIwD+cfTsQ5AOmx4BK3J
HOqeL2ZBL1/gSkgFsjqnP+0TMVNjeWu1AjADmtZaBPnBIH0G+Ig0wdt4IA1QUJ1Z
Q21qLL6w2DltvPBP1X1DK8vm49zvEpo7ESbXKTeeTLvXkCeMg41jPAixJKlAGLIl
gGodBF+vjDWgWoJmGbV2NAUcWTM39+TaaVSag81Y+binDxEttjxiHgPcxC34VQzU
Xghq/Hrz8tBZflWsRtsxtohbkBrLeyF1Pw0MmNYkLPD4KPUB8uNsIU+ffKXZLrBh
AACWGmo2BQCaRraQnTBCsP34sN2cjh88KgLGHHeJ4hFJ1Nu2Ma4Jvn6L29QcNoaT
aleFsGK1RHgFjP/NN7dV7VXEzy601LOscZA7nJAYr4ldEbMl/40=
=5eFO
-----END PGP SIGNATURE-----

--FV8bZ/8jnt890/Cz--

