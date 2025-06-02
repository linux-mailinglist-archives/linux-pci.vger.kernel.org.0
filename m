Return-Path: <linux-pci+bounces-28792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93404ACA9C9
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 09:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1CBA189C331
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 07:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C5513AD1C;
	Mon,  2 Jun 2025 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="gKpj/VTD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A13D4CB5B
	for <linux-pci@vger.kernel.org>; Mon,  2 Jun 2025 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748848596; cv=none; b=rU6H96SVw6LYFvZMFNIekD/C8BvGJg4GEw+PCX51GRKBX6ig5lzussBzaxFGa+4dwgZomGs9DjNclnxtoKSqCi5okwLFHc3v5sZkR9lelRU5VVtpU0KVMq+hmdCSAF+kpwMUeCwrfl8Z7rOWAg0ovtpk0P0ta/+vvvw0LcZ3v8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748848596; c=relaxed/simple;
	bh=4ts3ILevWOPYqx+gXJKBFw80Ij8IEjysS1Tj+hCyd9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqLVYbN8aCRJHAPFLt7lG/bnuJ+eJQF0TdIE125ClCccfVm0ouEU81bwzGH7WvHR84N7k9oQiqUB3ZpqdDr4M6WHrmk9lYEczz8671fF0Nrd+oyNIn6Z48BYrvM/pCuTwpDA0g3hsvm3pwOODlSBwXavZ/KAO+ZKjtt2NSh5lFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=gKpj/VTD; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=4ts3
	ILevWOPYqx+gXJKBFw80Ij8IEjysS1Tj+hCyd9E=; b=gKpj/VTDWEUb0RdiAHS/
	ax63fKQeGg2XTYEIm1BeN1RwE1lI6Q587Mra4bC8y8vgIP/IRrQHmnaisEtkSqsl
	tS+S3VLIkjcYapmcmYRoMSM5UCNJhl3X89Vpk007lmHUTi5a2EKgeMTtoVPvq4Bx
	k4MjPWFpEVEzvySiQq7YSaTkHDtjs8Vib4HH0smMMYjYy6nRXA/uQC7LWzfEM5yH
	6oN+zq4kqL5nszFnTlJRPdK/K+oxHhswwyva8xLvMRHcZ9R76KsPjNYQ/tnRJwBM
	8cTyApmfsBvVlf6O3+SK4V0FTUabO+bo+0MdY1OtHp/IhHcypCeGlPE/K9EZ3f+h
	Gg==
Received: (qmail 3287185 invoked from network); 2 Jun 2025 09:16:24 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 Jun 2025 09:16:24 +0200
X-UD-Smtp-Session: l3s3148p1@mkeYipE2bTltKPDF
Date: Mon, 2 Jun 2025 09:16:23 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be,
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
	p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, john.madieu.xa@bp.renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2 0/8] PCI: rzg3s-host: Add PCIe driver for Renesas
 RZ/G3S SoC
Message-ID: <aD1Px6zvXnan3rq6@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Claudiu <claudiu.beznea@tuxon.dev>, bhelgaas@google.com,
	lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be,
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
	p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, john.madieu.xa@bp.renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250530111917.1495023-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+ZEsolx7UMbGHb56"
Content-Disposition: inline
In-Reply-To: <20250530111917.1495023-1-claudiu.beznea.uj@bp.renesas.com>


--+ZEsolx7UMbGHb56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Please provide your feedback.

Don't have bandwidth for a review, but I did test this series on my
G3S/SMARC with a x1 PCIe USB controller. Worked fine, I could access USB
devices with it.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--+ZEsolx7UMbGHb56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmg9T8IACgkQFA3kzBSg
KbYrDw//fVqzg9qvc/j2in3DmuPNolbFXSgSdXbnHeaP64s7ZMvP1VjP7lm2xRXV
mnnKbzEvCpQqJusArmqUVao96p/Sr/PKfWLK5P+bVreIOp4JHL6B4/n3GGgWB4gY
W+pXg2OSSLXUUn84eIfR9q4ExE5NJ67LH0FucGCE2MLf69mR8JemaIOzsjcArKme
XWJwwlQ3O+VmBtOM3vbw8FPOOsh9lGyxS2Euc26Si36zsQGuKKNCAR+DumFKCTXm
cJa9heoLi/Tse5sUAXVSn1fxLkyLx5NFJNY8NtIzO8AvP3ZymGZdEH3fLVc7e0T5
CVGvrh39mKJFFWsTaEe2cazD910SmVIvHvAt7H9WOpkhxDk0Qn2Xx1KKyctO2Ktf
qwa4liCYjx7aE+Kf2zoZTc+XaAUad/rG47vIZSb7dNThe/x31LOCStVXcwbFX53i
zYGUGZ64uj4I8x7+Cv9Key/mPrwMOqtsKmc0p7jS72WrXzRpSIyMxFbYCthpEKBO
ueJFNcA/xDkCsjTW1tY2+VitZe0OL4Zi3IGunkNk2X3VL931ONqNvFe84uBcOQ2q
Ktm8IvF6zWCwBKGjuOe+DsrRA8DnSiScFvA3tlPOy0jkDFkNSL9aVrG0dH9+OLrK
oApyRKwdLFyMjCyoKyV1WOjwOv8IE5WzXCpIOrWBjj189aJMp+0=
=bmYM
-----END PGP SIGNATURE-----

--+ZEsolx7UMbGHb56--

