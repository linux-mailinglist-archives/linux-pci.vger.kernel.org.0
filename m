Return-Path: <linux-pci+bounces-20896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CC3A2C410
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 14:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4F6188DFD6
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 13:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574621EDA3E;
	Fri,  7 Feb 2025 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfjvOGqn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A62F13BAE4;
	Fri,  7 Feb 2025 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936061; cv=none; b=IuF29jndPLRBItLwhTVnJfUfykTevSqTJnnQwRq3XOwE+nzLmIQlV6MnBTKdeKM6Lxv/nqHktVki0wZ4/NogrgVMoHXqpwer2fGSUozwDZbfW2XMeyqkOk3biff5551L9rU1Kq5aqRFOyeV1r5UxxOQHn9Sn2e09kxAUDIpgNvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936061; c=relaxed/simple;
	bh=uBQ1famFvoY/Lcb70uekbtaFYTvtmzkryqa2fAmSOkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rebonv8DHrSVWB0/G532t6Oq0buXisjiwjyAg6QxwDEDBKav7VWHhnYro8aF+w/TrRqoEl5Htd3JqAfPmWRZCrNYP54SDxkaGoKfbFyxZh5HjVzCLUvsejFkRVEvwGMuZ+rz6SFqoMRpmIlTHbUlPYyunmXc6ca/XMPK4Bf6j6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfjvOGqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5142C4CED1;
	Fri,  7 Feb 2025 13:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738936061;
	bh=uBQ1famFvoY/Lcb70uekbtaFYTvtmzkryqa2fAmSOkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rfjvOGqn5r4Wt/uPvxR/qvXnndAyOkkGyZkFqFlXZiBMzNfLUZAXY82JDM3xF6vd1
	 RGG5c+7MTMZctAUR13iw37mXChAort3mfxWceiJ8f+5YiSzSmQVMcD2RFT9J6jQrvz
	 OzKxjY556U8OilPIzxZ2nNbnp61cETPoGT4QGpSE2MFDMvSV8IjWn1+TRlY+Vk06oU
	 Zpe/7Q5B3fTMvyrGrIdoNJ2Zu7pArA4A4gJJYR/MOk+WeXC4lVRa2LmdFVcZDXRKSH
	 XEtU7IeOaNCNDWJb2NJXjH1Gwcwvw3++INDx8gwXyPM6gMF3jRGchZCWxPZolMeu4y
	 StnPiVqfIleXg==
Date: Fri, 7 Feb 2025 13:47:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ASoC: SOF: Intel: pci-ptl: Add support for PTL-H
Message-ID: <a4836940-ebbe-422c-a5f9-fdf83f84bd47@sirena.org.uk>
References: <20250207133736.4591-1-peter.ujfalusi@linux.intel.com>
 <20250207133736.4591-4-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G3YjZ3bA0oD0VIhI"
Content-Disposition: inline
In-Reply-To: <20250207133736.4591-4-peter.ujfalusi@linux.intel.com>
X-Cookie: MMM-MM!!  So THIS is BIO-NEBULATION!


--G3YjZ3bA0oD0VIhI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 07, 2025 at 03:37:35PM +0200, Peter Ujfalusi wrote:
> PTL-H uses the same configuration as PTL.

Acked-by: Mark Brown <broonie@kernel.org>

--G3YjZ3bA0oD0VIhI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmemDvcACgkQJNaLcl1U
h9BwUgf+Joou1s8rR6AWZnJd02P/O2SCnnLlZkkobECLp/tl+v5Rchvh8SR17bT8
JLZgUsVQ8em1X82PZ5gjchnfFSgMa8/vpKfryIBFlJ9G1lMIVN/v5iVvZE2U++DP
Bwpp68d4SKag8k7T9F6kwFZ/4uoErFcm6n5xa7NybQuRQaX/XIHh6WTvIgBKxDkQ
9FGAwaCOpjdyrc1xFGHg58FFezAPdFbxItYuut8+OKkD6MqkmSBSJQYa8umi9ZFf
Z3F91neUYI8A7ASQN9UMnRqgjqzYtH6DV7uD7SQNk33KKE31jAlnZsWl/RYxkAGf
NAyzEiD8mQa+k620ni7MLLHuRl0Lgw==
=JgLV
-----END PGP SIGNATURE-----

--G3YjZ3bA0oD0VIhI--

