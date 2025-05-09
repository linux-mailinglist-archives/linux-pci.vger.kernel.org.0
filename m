Return-Path: <linux-pci+bounces-27469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D809CAB0777
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 03:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB749C3F24
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 01:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1139683A14;
	Fri,  9 May 2025 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHte9XYn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EBD469D;
	Fri,  9 May 2025 01:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746754346; cv=none; b=sHyirhce9QZ/MipIx0oXym2vnGRJeI7qW6Sjwdtam2qVdSx/ZtKCn0NIZOw8XiMBriVKlYRUFdDdJ3S08PNgXU5UAf/S2CKDmG1YiH2DlmNDKxuCAqoQL0Ypgf4bttxVe3c7R5fLkt4E6VU0+x47vv+fzKsZygSysgUEoTvB/rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746754346; c=relaxed/simple;
	bh=LGBZP+0De5qBKzVYRK91W9sUX+AgvjCJZKczVH5pGZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aD9VyhFW1rI9H8wj11cNrgZNg6SsV5+UCGXs3GA42dfbqrJIQF2ciTikN6zbTnL70hkbQpk10RpPqmqpBi4lRttfglXvxlBt+Q3B0dwH+H+iVU8IgIOO5OLP3SlDvO+B+bHfFZzVDPH6LFJkYpMUbjHgH/4jKwEFF8Qi2wjWwpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHte9XYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8FEC4CEE7;
	Fri,  9 May 2025 01:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746754345;
	bh=LGBZP+0De5qBKzVYRK91W9sUX+AgvjCJZKczVH5pGZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MHte9XYn6HMHn3ARto3QQ0SiI2s/gKUtic5sjOReVdoJUEYrmAXbfYmpBLanzFHkY
	 rYJYfhilNgYXMNyPKrJ4j8NQZUClzNdtQAPvht9ya608Hu4DklLd0MLu/H8iETPy0z
	 F/CzqvMG83/in32TVGBSPUvABDz3VBOaEc7tVB2g0vpiOmbuC27vX3QIllche34tBE
	 l5luMDCKwqwzplgvZMmcZzLHgcAYSHTMp9+HZuTFnkwh3EfAy9rUKdPxG09czdjnfx
	 nQ3+K+7Vk51Iw6urIqUjwkr6Wuukt4TD4FC6DA8uhp6jWSdKfuvcNHLCZ3GRRCFFpW
	 DphVvG24zvBxg==
Date: Fri, 9 May 2025 10:32:22 +0900
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	guennadi.liakhovetski@linux.intel.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] ASoC: SOF: Intel: add initial support for WCL
Message-ID: <aB1bJpLx3aRzYuVQ@finisterre.sirena.org.uk>
References: <20250508180240.11282-1-peter.ujfalusi@linux.intel.com>
 <20250508180240.11282-4-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dnbjKym447hVCsoL"
Content-Disposition: inline
In-Reply-To: <20250508180240.11282-4-peter.ujfalusi@linux.intel.com>
X-Cookie: Well begun is half done.


--dnbjKym447hVCsoL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 08, 2025 at 09:02:38PM +0300, Peter Ujfalusi wrote:
> Clone PTL and adjust the number of cores from 5 to 3.

Acked-by: Mark Brown <broonie@kernel.org>

--dnbjKym447hVCsoL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgdWyUACgkQJNaLcl1U
h9DsEQf9E7FgyihuxEBw34iVKKDCWsITXVvXK7QQ5sOJyXhhmNvz740PkInXafV2
D6x8okwIwehLLeZ3BBtbiHsJbaa7a0UWiP0GVO+fLkBjRQBS4utUXb4iXk74vL/C
3z6pTVi/6ItEmRQNArvKl/ag3RoMrNIP0j5tr25/7P/aQ+Ob4m5FnlC6i1qtR+Ba
k3u68D5XsWmI+HEWCe5+6Nf5RbNlruv69yMHfJ18NvW2vI/lCMCV6nFvXJ1El1ej
Q1zAa+sYwbvFimCGbbW3/uejkQmPZyZ1+NXJEmibmOwpSAY9hbop0xyM4zx+a3pG
Mke5YNuG2wAMsvA394xlEleuUvNNfw==
=s7Nl
-----END PGP SIGNATURE-----

--dnbjKym447hVCsoL--

