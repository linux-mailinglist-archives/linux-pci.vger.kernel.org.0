Return-Path: <linux-pci+bounces-42643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9725ECA4E41
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 19:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AE943081B88
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 18:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE45338F35;
	Thu,  4 Dec 2025 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noABDMbm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E9D33891F;
	Thu,  4 Dec 2025 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870779; cv=none; b=cwggBJO0Te5uc3ja16gb/0H9DtvYa7Eh9FTsGMBKH7ZoU3ZMusFgpUT90M6zb0oi4VB0JuEKgo3S0ZVSM7FSLfmEXCzXdw7bht4lqNSyQTL8iwnU4VqGzSGwxwOhxsYw7fLG4BmKruz0rysdvnGYiDjw89NNvNCUFT3ERHOxINg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870779; c=relaxed/simple;
	bh=BrgfaUpdhzS8+buPbojpshfeXHZeX8BfWC8VzTAmvzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBeKSycv6cPx11AAN7bBdSzhOgMSovJPhzfZdBZEiX4N1YbbkMrHJa2Qv31UwwoLoFfgskb8nfjTtAnqdkW7pbFc9Jg2KFNLoM7+K8Gk6w/m2fUOGdrP3AVz8auL9KhgFc9Ke95L0NmwwKafc/eYMPjnbtmcM6MbyaY/lX9+LUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noABDMbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEEFC4CEFB;
	Thu,  4 Dec 2025 17:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764870778;
	bh=BrgfaUpdhzS8+buPbojpshfeXHZeX8BfWC8VzTAmvzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=noABDMbmzhHIeSCx3ztm/U949iPtVsWFHNkpxyJfwxH5oFCkwcYdKL3wp0kL9/yUq
	 pO2y+rwUdZ0t3NzuAZZMV8WOsiWWxNNyRm9iGc0XJMnxpxuUwAFCL341kFHI03Dfl1
	 JorHa9EOC6S0RdHBuD/IzJY18PopQE7op7TEk63sy2FY5KtuEi0z5p/vEJMs2504NU
	 Sbs4G/PmHhY+dtKPO6PcsOJCHlcOx6vu8kSmlQIfgaOT+6PG7RqaeEeZY0z6Hx0TZd
	 5Ve9ujdbFxuMCPyDyGzyWQCPZG6SRfv0SUwcWw75Ar7m9zyswN/qHZ4fVSjHSIp9DP
	 TjLwttSUDBmGA==
Date: Thu, 4 Dec 2025 17:52:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Diederik de Haas <diederik@cknow-tech.com>
Cc: Haotian Zhang <vulab@iscas.ac.cn>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] regulator: fixed: fix GPIO descriptor leak on register
 failure
Message-ID: <6a964031-4286-4898-8c25-c0940a78f387@sirena.org.uk>
References: <20251028172828.625-1-vulab@iscas.ac.cn>
 <DEPEYUF5BRGY.UKFBWRRE8HNP@cknow-tech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CQnLQ1LmuUlseSsm"
Content-Disposition: inline
In-Reply-To: <DEPEYUF5BRGY.UKFBWRRE8HNP@cknow-tech.com>
X-Cookie: volcano, n.:


--CQnLQ1LmuUlseSsm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 04, 2025 at 12:59:53PM +0100, Diederik de Haas wrote:
> On Tue Oct 28, 2025 at 6:28 PM CET, Haotian Zhang wrote:

> > In the commit referenced by the Fixes tag,
> > devm_gpiod_get_optional() was replaced by manual
> > GPIO management, relying on the regulator core to release the
> > GPIO descriptor. However, this approach does not account for the
> > error path: when regulator registration fails, the core never
> > takes over the GPIO, resulting in a resource leak.

This should just be reverted, the core always takes ownership of and
consumes the GPIO even if it fails (that is simpler than callers working
out how far it got).  I've written a patch, I'll send it out later all
being well - thanks for reporting.

> But booting the latest 'bisect kernel', thus based on this commit:
> 636f4618b1cd ("regulator: fixed: fix GPIO descriptor leak on register failure")
> gave a different call trace and landed me in the initramfs:

It's corrupting data structures in gpiolib which will I expect be why
you're seeing varying symptoms - exactly what gets corrupted and how the
data gets looked at afterwards will vary.

--CQnLQ1LmuUlseSsm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkxynUACgkQJNaLcl1U
h9CHuQf/RH2xw7j7oGqEVvyeIC69dGOtPoJD+jvgrpRxK3QBKMHFwdVibQqXft0n
gz/D1yzFQ/e3wOLehozjh9UGxnJMjYg8G4f5duiNC73W7cW+UiNImadpuiecQhAr
7ZY7gu05VBIw3qNsBc4gtMceSKq57zJoV2jpdDK0gnExGwmbBom5FepuCClk1yMS
I+2a4jzoWOSazlleWqHMdYI7CKLeZ9Np/4uY1TxxqweIj3gbuu9SgEI6TIhzGosG
SQpyBvV08fDgJ95Sm31jukBzeiUTI/c/ul0DqSydP8/j3zmiZxc6e2gknC6iGw3E
tOQIZo9OojU+zWIA1Ij0bc/v0My50Q==
=NAVh
-----END PGP SIGNATURE-----

--CQnLQ1LmuUlseSsm--

