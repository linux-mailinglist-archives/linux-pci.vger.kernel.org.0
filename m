Return-Path: <linux-pci+bounces-37535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17107BB6853
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 13:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B203B31CD
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 11:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6162EB843;
	Fri,  3 Oct 2025 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ji8QhABc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FF42EB5B9;
	Fri,  3 Oct 2025 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759489858; cv=none; b=Sk0vLR0sAok9jPy68+3toKxJtJifxQO63e/sKyiRMJyktTqKeiyJ8CP3q1UgGwuLeQ3mnx9k+tNIxyOYMizIin46qSaTH8w3nWQbK9eo3bsDCx7tBQD//SepiU+MQxe2/KglxRnRFi40XzN0EbVffxauRucckBGbVOXYTMRKtMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759489858; c=relaxed/simple;
	bh=s+Cpo/MBvT15ouLqwykx1UKmpiM3jIv0R9F5dNi/oh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6RDeP+5QP4eOzGL2fFXbSnGxS1X5Eu9wS1T87T/v6LIKq9CKZIZGXJK65liAZeMMlWjrKgsVBq37qLB7/1q+ErBC1xSMkvPC1dr3m371DzlNEyioT8TtT9ANYEvheXhczRjPmysq7kIw0yYIkfzCOKSxrQlFYn9I2wdSPwy4fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ji8QhABc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E4CC4CEF5;
	Fri,  3 Oct 2025 11:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759489858;
	bh=s+Cpo/MBvT15ouLqwykx1UKmpiM3jIv0R9F5dNi/oh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ji8QhABc2+q4lazvXhV4sJ7Xg23a+po+S+ZKsE+oeB/ezyclHn5b0fqvgbsJ6dhDo
	 F5iR0sOYlzEC08/D3pUWYzuCTVNh4GQYDuZ4NUrUNmWySWJ1/bjtnnSikmg5vrNkM0
	 9I123+fGHgePopV1plpjqkiDIS6akoCKm6MyKnIeYsAc4VkhmCVXSykanGfvDEBhow
	 iidpcZGBemeg/G25xpA0WaLGKFrqcBreHKYQN8+yzJ231gG9a5b6c8BFoBrBznJCFT
	 hcORxJ+pPuS5xVI3m393JXhuqkB9RRmkwg0xqdzKRVa6J+KKlnP5acXIfP+dn4LOYl
	 EEaXOoV6g2Zcg==
Date: Fri, 3 Oct 2025 12:10:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kw@linux.com
Subject: Re: [PATCH 5/7] ASoC: SOF: Intel: add initial support for NVL-S
Message-ID: <c1014619-ae05-438f-9c7e-c6501515917a@sirena.org.uk>
References: <20251002084252.7305-1-peter.ujfalusi@linux.intel.com>
 <20251002084252.7305-6-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="szFrhGKEDh8yc1XS"
Content-Disposition: inline
In-Reply-To: <20251002084252.7305-6-peter.ujfalusi@linux.intel.com>
X-Cookie: hangover, n.:


--szFrhGKEDh8yc1XS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 02, 2025 at 11:42:50AM +0300, Peter Ujfalusi wrote:
> Add support for Nova Lake S (NVL-S).

Acked-by: Mark Brown <broonie@kernel.org>

--szFrhGKEDh8yc1XS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjfrzwACgkQJNaLcl1U
h9BUygf9EV6rd0rYiW7Ia4NDg6bKxLBUTzWt3Dfg6ENaKvkuDe2h3Ok0K4SaOCYV
MGTU9ypqiALn0cnHxB6k7Kaxz2F8Q0kKbCquBJxL4Ajug3ZTSeqnKOg5JPMyEinp
H2N8z3DNEAyRj1Br2YK2DXJoGpH+q88YjQAbkicHlqPuwnY4lBP0nt4TM6RG0Xi6
/KiaEAZeFRyV8jhn03pZS/ZXbB01D34UKdJpZZbXqFI4iKpC1FBAPYAwaLzMFQeY
brl89Eg1Hg7GCSqzp4mYbArOc1B3b0KtJFK5w8xw8ennil+tSBxgIrAIwOwjiD9d
As3g/eUuV0Tc2H/aLlJxnKJYVUrPnQ==
=h3iD
-----END PGP SIGNATURE-----

--szFrhGKEDh8yc1XS--

