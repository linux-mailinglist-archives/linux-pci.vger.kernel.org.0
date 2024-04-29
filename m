Return-Path: <linux-pci+bounces-6786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC78E8B5BBF
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 16:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480711F21788
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 14:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A70811F2;
	Mon, 29 Apr 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gB8vs2w9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616427F46C;
	Mon, 29 Apr 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401939; cv=none; b=JYXjlzyiAySk9ewbCXTIjvnKFnCOJFiaQN/O3F+tW9Hj043xNRj71DjJ/2gUcHc6nRC5nqt5OK39nz1Lq/9hcs5Z/KG5ZPDrL86NJHxwqBsrbYtKX0LOFSwiFuMxCBsS9kPiCi1YbNRio9037eSCiR9lBXKU98d9JA833cnoXxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401939; c=relaxed/simple;
	bh=HQFQVk/aUt7EGazaH6NoJ7OsnpPabPfhVzUB2hmzT9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/I7Mooe1IEybAHMsOqNGcxS5KNPWHH8aL0/N1x4r+2mR5F3osu6vmOnRFIer1QEoS3btujHRKZ3ENVKEtF2RcTKpB5pyP17Q/HPa5EziQPeSk3GGmvLTpoV4dN8qPj1aTJIKby1AY46evSyIpMmddwJ/awsO+3hz6ey/+WNHWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gB8vs2w9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0810C4AF1C;
	Mon, 29 Apr 2024 14:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714401939;
	bh=HQFQVk/aUt7EGazaH6NoJ7OsnpPabPfhVzUB2hmzT9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gB8vs2w9acQgZ/W/pBv8sEYf7kYQGoGXQovwX3dDNem++Cui0NbKVh4o/aYcv7XDa
	 P7ImS8mIsQ3AsX9dg1B9pMcdpx0qwB0jRUKGiNfLyPa4LeCLLgpSmsCjGjYEvAGsmD
	 pYnz2FZBhzpjuso7K1IcCl9tXJUwajF12cphURy+GQllvrTlY9WivRNJ4b1+tJMpCA
	 d2Q4cUEZNJi4kPGzqvQksLxhpCK0CDODJPuIOLH8bAh+k8wCGxpy8ZfaXCge2mYRzA
	 6DP/nekSmWlgKjO33JkecU++lLEdoGSUJ6iIbVJ07eHdCUrP6WhBqBh4ELR5iH0SeV
	 z6agpkn7PqvdQ==
Date: Mon, 29 Apr 2024 23:45:36 +0900
From: Mark Brown <broonie@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Drop unnecessary quotes on keys
Message-ID: <Zi-ykPmrPqBxiHNz@finisterre.sirena.org.uk>
References: <20240426202239.2837516-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BUMTG6XEkN0Ut87X"
Content-Disposition: inline
In-Reply-To: <20240426202239.2837516-1-robh@kernel.org>
X-Cookie: TANSTAAFL


--BUMTG6XEkN0Ut87X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 26, 2024 at 03:22:37PM -0500, Rob Herring (Arm) wrote:
> The yamllint quoted-strings check wasn't checking keys for quotes, but
> support for checking keys was added in 1.34 release. Fix all the errors
> found when enabling the check.

Acked-by: Mark Brown <broonie@kernel.org>

--BUMTG6XEkN0Ut87X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYvspAACgkQJNaLcl1U
h9AK6gf/Xc+HslmuppG3Hp8ImYKauCbY+zuC48rT6Z0ZCBxjrjhiGQ1U1+BJdVkZ
FZGn1bnIqVJ+yOq8uAy7L7v6DZs3NuPGLMAUJofSho2NZow1jZwDxH0Dt7L4DqRh
SErFMkHo8rTw7YGdwLp3HI0XFlkm02oJz3HJ2v+O4RLkMgkGCRgvV5iOYjupfau/
NscyXAgaFlf7wRz2rfHIP7xCsRmSNMf8M1Z4fK7miUk6iDnK6g/8CbXUMyPcrLfd
f3S5/7ZM+MjizWf5ZLYoIxPTfhoX2BfRdjb6Upu9il2gZjoLDIlrtyyJL8XZJ2Tx
FvUc+ybdxp4Ggo1kEUDK1LgU13YYOQ==
=F/JM
-----END PGP SIGNATURE-----

--BUMTG6XEkN0Ut87X--

