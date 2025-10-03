Return-Path: <linux-pci+bounces-37533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25207BB6847
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 13:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90493B39E0
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 11:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080112EAD0A;
	Fri,  3 Oct 2025 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SylRB0m1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF91081720;
	Fri,  3 Oct 2025 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759489732; cv=none; b=DHRgFjzQUuiY/bkq9PJXct1yVPXYuiLQLCMDJN+XyHGeeI4hbypCjwU+6htdTJOcbiYH1pdAmewsjOD2iFMeFMtbuF2JaVUZlXgKa9mUXH+UL2/6TpmNSCtWZ32/vNZvo/0AA0lqXPOr0GFVSc8uf+yKWQQkAHXFDv8yh3JDW44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759489732; c=relaxed/simple;
	bh=Qqb8NIJ7UArlqzST4/1DpbR3N4j0f9ZT/J3xqzy6rm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9MnjbEREavdvg69s1bgGOZEPzmZnnC7ODgyVoXLO5qHYK228JP11Pcwig9UDGJFB1kiBCJWmFEo/rUoV+mYd7pqfoZarWlCFwJ/aD/cxjOc2z6p/pVgzk7hTAGVw1AwILKXZEdepwaOfA1oDVdlGq5/ISrIVXHap/82XxItp1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SylRB0m1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC87C4CEF5;
	Fri,  3 Oct 2025 11:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759489731;
	bh=Qqb8NIJ7UArlqzST4/1DpbR3N4j0f9ZT/J3xqzy6rm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SylRB0m1joaKYgTLulMhzX0MhuAOpn1eXp4TfFtk0pZo/05IfVuRdOjO8tTc4r5fu
	 OPsI/A8OUydTasL9A1Huva9QI7rCvLCuhmpO7PcN8eSGAhuthsxaAnw38wXXsKFm5V
	 3xSJ+vmnC6Qowu0IPnRzTU3eWA2J6V+gcU363dPg3L4AXN4JY0lTYcwo1Mwz40BpJb
	 D5otfzN8xfbKUMUKfBq7LvsKw3kEXicexcKMRD+A74CzQY824oWgeYO+a/AYslFexu
	 BFxpBe4/z0d2+h/UL/vdN9qT8wF28Rf4YAy1Yg3lq8FI/l6C7Xg0qCJPET1CO7qLHm
	 mOeuLVCLE4Nxw==
Date: Fri, 3 Oct 2025 12:08:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kw@linux.com
Subject: Re: [PATCH 3/7] ASoC: Intel: soc-acpi: add NVL match tables
Message-ID: <533d2d46-27dc-467f-b121-f4535f325aaf@sirena.org.uk>
References: <20251002084252.7305-1-peter.ujfalusi@linux.intel.com>
 <20251002084252.7305-4-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VASl+GsgNTamOKDS"
Content-Disposition: inline
In-Reply-To: <20251002084252.7305-4-peter.ujfalusi@linux.intel.com>
X-Cookie: hangover, n.:


--VASl+GsgNTamOKDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 02, 2025 at 11:42:48AM +0300, Peter Ujfalusi wrote:
> For now the tables are basic for mockup devices

Acked-by: Mark Brown <broonie@kernel.org>

--VASl+GsgNTamOKDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjfrr0ACgkQJNaLcl1U
h9Ds+wf+MrJG8kPzbDNK6JVOiuQ+1zsUWpPTaD0XC4TLarOyqTj9Ft0bXqi620+T
1CsqxbRxhw6rVde8ji8rSF6EfVQNk8BJxU1cB7Rq3oPlHcZaUxmEo5Ws76GhJ/Xp
8r3uPW8sfGS47IRdm3NM6CcZOB9xO9X7v6fpnBhT5UliPm3XFgvF4X56BXJBlo7c
m5ozNFXRjhn/yCi0b5CDj4zvV9SML1YXgvW2xmGowLGzFL85ds7046eVX8gVWCmP
NMgrJtKaVWj9f/biUBqM91vO82VTjkIy7Q7BbMAyidivul4Fokg4qNySMXcWpfn3
Kx63ky8E0taJ/y6jFdowLG1v/5TUmw==
=X7Tt
-----END PGP SIGNATURE-----

--VASl+GsgNTamOKDS--

