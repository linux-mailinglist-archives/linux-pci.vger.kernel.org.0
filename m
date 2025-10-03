Return-Path: <linux-pci+bounces-37534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB17BB684D
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 13:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2520B3AD84D
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 11:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFFF2EB5C4;
	Fri,  3 Oct 2025 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvF2PFUq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A7F81720;
	Fri,  3 Oct 2025 11:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759489840; cv=none; b=d+f6seEtB4xPrUXXS8wE6w1Jt3nBDTAu3Wwbq+GUonkBVwddYDEpDeczugiup078PR38n7Fjps2j3B6nOah+Zy7RBfLUeg5Ete4wUomwhy2bRnGXyoAPHIswnTNmVg7THD2jAK4EFCp0pE4FrPDZ3bUE1RnDP+EH00q3nhgQXdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759489840; c=relaxed/simple;
	bh=6iyWE4Y3ov5QYW05CQyUk65TO2bWZIJ+ZqE31kiWYBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUGYLi4+pHCE9yL1gATsUZ346TiEP8nF3ocxYnyaP9Q3KBuw8MbAb/B5JP3ZyGrJjGNmH3ZfnvdueaVU/XsUEiGErZP2AMZO5eE8YTyUlAuSUQAtXOSsABYqjSWxBe2v3BNMbglYLYDUayKix4Xb+mTdhZRuI15KYqLXXj6mw9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvF2PFUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFA9C4CEF5;
	Fri,  3 Oct 2025 11:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759489839;
	bh=6iyWE4Y3ov5QYW05CQyUk65TO2bWZIJ+ZqE31kiWYBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rvF2PFUq6CoOFw1/beYlS2IJBDM8PJUi/pMDFg2Ddff7rI4P1htd3mMTNHK8jQhkR
	 S8Tp7n82i08E/T5YzUDtA8IKHy6IJ5YAYQQ+C0bRvaAr7bIxHYzQJjSeYYKZS6EACt
	 3tMwDnspAf++8sYSMPXlES6vUFaC/655eWk+9SMBeZ9lF0wjTYlyCqrxz+2CDOp2jq
	 RCPEvJPlgoto9DjVKmX+aaz4oTgchWOZ7fDBYOgKd2ZD2XWhcDFiVtBMT8+cTIt+ul
	 Z90rpr6gwzUj/ymkzKvATi6YBtoJexfB4gla/xKzweifCYy3vmFqw6Yq+HxjaARqSB
	 ORUDOlyRc0YfQ==
Date: Fri, 3 Oct 2025 12:10:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kw@linux.com
Subject: Re: [PATCH 4/7] ASoC: Intel: soc-acpi-intel-nvl-match: add rt722 l3
 support
Message-ID: <b462e116-085d-4ea8-8405-63759254ffcf@sirena.org.uk>
References: <20251002084252.7305-1-peter.ujfalusi@linux.intel.com>
 <20251002084252.7305-5-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QQWqMxJ6rfX/pxSA"
Content-Disposition: inline
In-Reply-To: <20251002084252.7305-5-peter.ujfalusi@linux.intel.com>
X-Cookie: hangover, n.:


--QQWqMxJ6rfX/pxSA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2025 at 11:42:49AM +0300, Peter Ujfalusi wrote:
> From: Bard Liao <yung-chuan.liao@linux.intel.com>
>=20
> Add rt722 on SDW link 3 support

Acked-by: Mark Brown <broonie@kernel.org>

--QQWqMxJ6rfX/pxSA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjfryoACgkQJNaLcl1U
h9DY8Af/Ua3/SM9NOP+EMcJLIJ9BBctIJu3ZNRJeFDs/HlUKzheDNzT6pS9oApCu
+fAoJ+6KLf/k8DEbyyY+D/d4OLDkDFP8bzow+nCyTlYECXfUw45OuElfkqHNdhHM
fpgIAERVr1RT/rPBBAwc92jqmHPpFvS3cLQO1zxuERORVfWalxob7EW8iq5ldGxm
CadR4eDdG8cQ7DTzAchbauGE1iRg6EqjcnGEeLyAMYEy9DYf3tTWAlTo4lGHV02L
sqLAFCr7UtQe8ccSoGmUSpKMadqmKl/eJ76POUnFkLb9Y3nO+bHwPh+vgLuwoPdk
bCpmK6Qw4mQkFu+I0MaZ61bjmF6lNw==
=BEMG
-----END PGP SIGNATURE-----

--QQWqMxJ6rfX/pxSA--

