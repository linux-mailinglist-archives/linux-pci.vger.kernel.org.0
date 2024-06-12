Return-Path: <linux-pci+bounces-8674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2BB905810
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 18:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5B91C20A08
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 16:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D84B181301;
	Wed, 12 Jun 2024 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+aevC0c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474A9180A91
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208093; cv=none; b=fnlaaFybuR3T7e3rp42kyIhFvbGmXhSgRz8BD5MLzKSt0PK443sBk0Mjlj6kcorT0EY1pa7/QiYbwLEh1hbdJWeR9K8xEXMVIwfT5/a2RmPuz6YIi3baAcMq33MBRWMd6dTKMGQFxmkfzjEmXiC7pl4TOswNTUzVVcg/F3prCWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208093; c=relaxed/simple;
	bh=koJhvF9uRyo4fkWk7z9zsznr3icpU4UOgpXk1pXcWRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEsVIfkXFXRmIQO9m82CA9cTxfAGt4wXtwDW6CyqjDoYrX0QPt5dJajkImH6uMpvtLABqJCjKRXxn514FNlLEHya/85m9KPVWqPErdokn/cCJuUeDcZlEu4VA5+xPyl6WoPwtUgtLGM+MTkQZA678neuz+09zKimpDsxMnS8EaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+aevC0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2315DC116B1;
	Wed, 12 Jun 2024 16:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718208093;
	bh=koJhvF9uRyo4fkWk7z9zsznr3icpU4UOgpXk1pXcWRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f+aevC0c/6uTMbQ4l2iksrbcZQCXoh+0WiYKrF921TK+LAJ0BKaiN8JHG+sZTK0+E
	 eAKDF/M4UEV5T0KcXsS3zAI9wfUCYihuuX6zZ8/LU5j03HXtCxviwmEEzXN0zIrJRQ
	 Trm5h8m2jDnNw1ATBz6IwQlx6MQg7nYQ4qtUEuOHLDrJa1hKi/qcGEFoDE/d0OVDsJ
	 0U3OFOCLapZx6EN9tVfY6s4Ktb24J8SeJXs+FJNvPFjb7wV4TAqSi7icy33nQu8aEr
	 yydVCw/rOG08g3IXABt92exDSXeSa2G3l41Hqpvb4u4fLT8ypwV9SC7QubGJZ8pS3h
	 glsrl1x3HCM1Q==
Date: Wed, 12 Jun 2024 17:01:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	=?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 2/5] ASoC: SOF: Intel: add initial support for PTL
Message-ID: <ZmnGWdZ0GrE9lnk2@finisterre.sirena.org.uk>
References: <20240612065858.53041-1-pierre-louis.bossart@linux.intel.com>
 <20240612065858.53041-3-pierre-louis.bossart@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QTJB/OyqEFSB6dAf"
Content-Disposition: inline
In-Reply-To: <20240612065858.53041-3-pierre-louis.bossart@linux.intel.com>
X-Cookie: A Smith & Wesson beats four aces.


--QTJB/OyqEFSB6dAf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 08:58:55AM +0200, Pierre-Louis Bossart wrote:
> Clone LNL for now.

There's a dependency somewhere I think:

In file included from /build/stage/linux/sound/soc/sof/intel/pci-ptl.c:10:
/build/stage/linux/include/linux/pci.h:1063:51: error: =E2=80=98PCI_DEVICE_=
ID_INTEL_HDA_
PTL=E2=80=99 undeclared here (not in a function); did you mean =E2=80=98PCI=
_DEVICE_ID_INTEL_HDA_
MTL=E2=80=99?
 1063 |         .vendor =3D PCI_VENDOR_ID_##vend, .device =3D PCI_DEVICE_ID=
_##vend##
_##dev, \
      |                                                   ^~~~~~~~~~~~~~
/build/stage/linux/sound/soc/sof/intel/pci-ptl.c:52:11: note: in expansion =
of ma
cro =E2=80=98PCI_DEVICE_DATA=E2=80=99
   52 |         { PCI_DEVICE_DATA(INTEL, HDA_PTL, &ptl_desc) }, /* PTL */
      |           ^~~~~~~~~~~~~~~

--QTJB/OyqEFSB6dAf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZpxlgACgkQJNaLcl1U
h9CAQgf9Hs8BaVfHcGEf8NBixx3jvjRXrQbsSmyieNXwrywCjaBi1XyuhcSVlm8x
9SLdzSgSwvRrfc/dJp9JZ6KPXCfy8Oa8eTig4d3fOdH1OTNzi0ozbujoBQJsK4Q+
FpOI5TgoPVTIyB83Jw5veJcBJ6z226XuBWLIuEolMXOxiGnEF36F2SWJR1YsoWvV
mb6AMh7Z0/24I59pKQkYtRMCNDUb+ZTVI5JpUZsY6eN2ZMpTemK0qVdQB73Js6rz
LKT9apbpusHbhINzUJhxlW0VUkvjCDwhwieHxiqc2PWJSm2O6eomkGQ68AeFCNo9
0VY870zURF8U1LbuEd1unijh8E75tA==
=CtkJ
-----END PGP SIGNATURE-----

--QTJB/OyqEFSB6dAf--

