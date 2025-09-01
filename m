Return-Path: <linux-pci+bounces-35266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F283BB3E358
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 14:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FAEF444525
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 12:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4136B3376B9;
	Mon,  1 Sep 2025 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lI0ji8jV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1898B326D74;
	Mon,  1 Sep 2025 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730123; cv=none; b=QqAKpa6P9wwQGjpSRAjlDWfsWVUMwCyqBd6L8uCph080Pn/C6aCZKeoAhlhXJVzWew8+ZyOiDMEO5ttu7SbE3MB2sqCpREPY9UQ0uFH5mXEEi48imDga6hgB1tMD/INPY4fbcxX8mDYi5zjV8y5kJhdh9l1VbO/josiPHrRXRSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730123; c=relaxed/simple;
	bh=ujiWbkguC4G/QKN1jDXb1VaBVSfBowmGk5Q6gUDa2go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSeMjiX6IwbCGaJvim+ygCtkdlePkIlfn0yt18AOJD9Xfy0NMjPUk1xLS/5nbx28kez6wJtTlEXGbyxmvUKNQ0LU9Xhi3be2aIB0IOhdULolGnH6QVKUD68LIrMwIqOA8naQHsfvgfBkKf35j7k0u1CqM+/iv2E+3KKFNmBmEuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lI0ji8jV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9B9C4CEF0;
	Mon,  1 Sep 2025 12:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756730122;
	bh=ujiWbkguC4G/QKN1jDXb1VaBVSfBowmGk5Q6gUDa2go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lI0ji8jVEa80XtdzuXetPyNrshQ7VD6Tx2WlVck6VtTQi6wMVbilyjaRZjUIaKPsW
	 ELm26o33N0GyfMCzqaP6RT9KJaYtC0c2QHI8ihjEWvva1yAKTBb/6yIGehbtRtAx/4
	 JiqZ+/Vh+GB1KuLiNdQ6sgt9cbev+40Jvjtge63Z0H7GrczYSrZb4hsS8dXNU2QmE8
	 i9qrU8wYZoQ8QQ+KBgJJ5ObuLgogoz7GDFCbhS9ODJVgKmj3Y7bELHT9NQeSpVWbAF
	 Pu8BG7FYEH+HR1nmlA6Ux9AsaHkNd86nPzAEUv7XQp/bpvifznwNRN8sk0JxaknO62
	 jQDBROeFu/Nmg==
Date: Mon, 1 Sep 2025 13:35:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Longbin Li <looong.bin@gmail.com>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
 cond_[startup|shutdown]_parent()
Message-ID: <5c07c5bc-1b02-4b18-89b6-da13c16d62ab@sirena.org.uk>
References: <20250827062911.203106-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8+qB4jhtfVp3Vnqv"
Content-Disposition: inline
In-Reply-To: <20250827062911.203106-1-inochiama@gmail.com>
X-Cookie: Are we on STRIKE yet?


--8+qB4jhtfVp3Vnqv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 02:29:07PM +0800, Inochi Amaoto wrote:
> For msi controller that only supports MSI_FLAG_PCI_MSI_MASK_PARENT,
> the newly added callback irq_startup() and irq_shutdown() for
> pci_msi[x]_templete will not unmask/mask the interrupt when startup/
> shutdown the interrupt. This will prevent the interrupt from being
> enabled/disabled normally.
>=20
> Add the missing check for MSI_FLAG_PCI_MSI_MASK_PARENT in the
> cond_[startup|shutdown]_parent(). So the interrupt can be normally
> unmasked/masked if it does not support MSI_FLAG_PCI_MSI_MASK_PARENT.

Tested-by: Mark Brown <broonie@kernel.org>

This is causing multiple platforms to fail to boot in -next, it'd be
great if we could get it merged to fix them.

--8+qB4jhtfVp3Vnqv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi1kwQACgkQJNaLcl1U
h9AISwf+OqBpOBQXDTFYrn1WyG1exWW9S2S+zzlJHVp7cStWQBX/cZiL3QHTtZOU
rhSYvXHTcLKTfuIy1iKZhXwfX+IxOdKp51EYdq15jxBiz6l4ocANxNsu9N2tyzvs
R8IHJE+Yn6krq/ZZcnhAPTNDQfodpXpi4gp4oWnFulNFh47afuH7u3NOaXQ25NLz
RXZX1rzYozrwpcTxQuLj/XdfktCZ4nFQrH86Q5oOyZuMd2QY96Z3Za4il7pzDn1D
M0mnzgJH61OT3MYUcVa9lP/wr24sXapWOT3bGJMHTHxpvrJxOojbv8pg20lUMxoV
lftu3Lacxg/nDD1xoNFZ+cZQ6uqdgA==
=qbns
-----END PGP SIGNATURE-----

--8+qB4jhtfVp3Vnqv--

