Return-Path: <linux-pci+bounces-24836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2E6A72F82
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 12:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69833B6554
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 11:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ACA210F4A;
	Thu, 27 Mar 2025 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fE+X4b1w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334C8440C;
	Thu, 27 Mar 2025 11:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743075215; cv=none; b=ObocryrmJa3qf9UpgIkNf08bD6HDvFDKVPTtoRmdj+uPbQ0FOvlAxSGDWxdGfVjGsP+BaPmRwXh1iNOs97YfC07GWZq/CMhDsZHkzZTTPtL2h0zI446PXrPEkJeIVgLsMcwirsVJ5pOOjN2GFI64VdVQW1RslNS1E23d0OOHyhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743075215; c=relaxed/simple;
	bh=LlM1BSHZ9HGeLI6TzmIaSytFaCV3jPNneKD8n0ivMNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8y+FqQxiQUdOK7HeQ8oSDOvMlZDwylC/YktY/yZTdrJ1CiyH64Ed/kUFtW7BUuTfe0q7/wdjHyJRvHVCt9KJkRmH/Pj/thqxrwh3q7A0KLl4hobMAA2eKzX47cRnEwhj5GazmA2qd94fdLKrmwe5YTFcJOEZrntQUEC3HRkrbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fE+X4b1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F27C4CEDD;
	Thu, 27 Mar 2025 11:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743075214;
	bh=LlM1BSHZ9HGeLI6TzmIaSytFaCV3jPNneKD8n0ivMNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fE+X4b1wxvUFV8s34bIDCxIofDhuiGuBNvwU43r4Y+oFDV0oTUOkBoL9gyETF/oHv
	 tcg1O8ZPfUAufSQ1vejt6O4DP3d808t9DBOluT/NwtEOKGuDiNnX1B5Mr6vd/NkMOj
	 mUGRPLi+AQoyVlpFxHLQRHrxP9m/MBoT8CbCqXw+bvoLfCcz9hxoYVpbYdlS7aFjxW
	 vWQbmhfTCEP8NcMXc3RkDxLAXR7Sk+mICLkQ2W/uUh0T1XD6lKJYQ0pWLbP70v1ov5
	 274x6ofyLLF0Oo0ZS47RFp2B+GVcPlix5Zyqd4IQmNMyXKSLL5de4p/iqEhVY2Ho9/
	 IJfgscVPyvtkQ==
Date: Thu, 27 Mar 2025 11:33:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>, Hannes Reinecke <hare@suse.de>,
	Al Viro <viro@zeniv.linux.org.uk>, Li Zetao <lizetao1@huawei.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] mtip32xx: Remove unnecessary PCI function calls
Message-ID: <b1aa0663-afe4-4fe2-b311-e1e0c9930314@sirena.org.uk>
References: <20250327110707.20025-2-phasta@kernel.org>
 <20250327110707.20025-3-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pd8goGw0e2pe9hhP"
Content-Disposition: inline
In-Reply-To: <20250327110707.20025-3-phasta@kernel.org>
X-Cookie: Multics is security spelled sideways.


--Pd8goGw0e2pe9hhP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 27, 2025 at 12:07:07PM +0100, Philipp Stanner wrote:
> pcim_iounmap_regions() is deprecated. Moreover, it is not necessary to
> call it in the driver's remove() function or if probe() fails, since it
> does cleanup automatically on driver detach.

Acked-by: Mark Brown <broonie@kernel.org>

--Pd8goGw0e2pe9hhP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmflN4cACgkQJNaLcl1U
h9Bg0gf/SdUIZuMAvDjjum537HCUp/d3IiAWo2tPl9cBi5na/HGuYCxifauxJyQC
MB+yL+xZXivD3XYRlfBLU/nwFA+zxjbXUvzbdeg5vvcz92AVqHmiB35mh2U6q60j
Z4iR2BBaWGx5JCmzq0+830sSIu0ukch8nDslMHHUQAIjGnufhsK8RiB3U22qdSKI
JoMMBwZEDFz742aA0CxOluoSa5nnLP3naxjmJEz0mtbE4N1OohttGAOoQsIuYO3T
jShNX4fsykw0rZmFyGYdrPpdVp+307X+Fing342Vu4P6jnzP8lrVNyLx7XiXWPWa
VHW3QIIhEYJhLe1BAAER1rwk7Di6mQ==
=YeSr
-----END PGP SIGNATURE-----

--Pd8goGw0e2pe9hhP--

