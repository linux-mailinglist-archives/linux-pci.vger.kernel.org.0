Return-Path: <linux-pci+bounces-17791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432699E5C81
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 18:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C075F166E2A
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 17:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43F6224B01;
	Thu,  5 Dec 2024 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLI0xY6M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AC2224AFA;
	Thu,  5 Dec 2024 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418351; cv=none; b=sIcRN7RVgysaS3UfzOYAX0jBZSLU9WOX1IaOfGnwZ3n73Fhs2VFeqbKvhfdcoDGl1j2mm3WCVAY+jkcZymybn6UySGSBCtqJDNKPGes71/pJ2Ci43VRX8AZmXO9IUXmtezgoDDgjGwElSxWS4+7vU4RjHSwAgBIxp8L8P1OBnpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418351; c=relaxed/simple;
	bh=+Ta7ODN+agEhvbgrJJw1jUucd5srUw+hGfUFlOpCmtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMFCJaX159P9pRhgJLm/ImLwQctO1RNGqO43xUD5UtSbsx9MMSoUhbh0T62HZ4uBtLale2DMGc2GpgyYrEJxNZ12UcqI6MStqAb4FdqTMFDVP6zOrxePi6N9YvecYAmVaiWK/OVIC/45zA7vHo5K/4CVt8APqSWk4s6h7EEjN8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLI0xY6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C9CC4CEDD;
	Thu,  5 Dec 2024 17:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733418349;
	bh=+Ta7ODN+agEhvbgrJJw1jUucd5srUw+hGfUFlOpCmtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qLI0xY6MoeZmOqx0tLF+nZ+CMCqUKpfdOl1FE3f8gea824GeEGKOargQIxVwtPPEX
	 BI+LKunB0+T1H9eWtm5D5hSxreYgbQ3GaAv30RHXasel1suib64g8aur/7Zbi4sQzy
	 HPz1pTzRkBdbErPymLmklLFSvrxuvFwgfOVUIUHPOqDLgg6Tahr9lLFdi6H5HSaOyA
	 w59aHBRR0q5gu1/cqfdrLFXUwvSTT2Ij+wo/sscGoHZoKN+C4rWL5gGlVX9ZWzMxFH
	 +tmcLK/8yx9LhCmgOZomadLuRQ2SM5jgQK6HLCsftubAuYDIWs3PoJ29owO+JrLTZ1
	 MK3aee9b3Q6IQ==
Date: Thu, 5 Dec 2024 17:05:43 +0000
From: Conor Dooley <conor@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: PCI: dwc: rockchip: Add rk3576 support
Message-ID: <20241205-backfire-support-68a48f6dcb80@spud>
References: <20241205103623.878181-1-kever.yang@rock-chips.com>
 <20241205103623.878181-2-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oHiiIfBKH0NLyHDs"
Content-Disposition: inline
In-Reply-To: <20241205103623.878181-2-kever.yang@rock-chips.com>


--oHiiIfBKH0NLyHDs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2024 at 06:36:18PM +0800, Kever Yang wrote:
> rk3576 is using the same controller as rk3568.
>=20
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--oHiiIfBKH0NLyHDs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1HdZwAKCRB4tDGHoIJi
0mbNAP0bakK9HI1zyUDdT4MjngUTtGcHn4JEUnGw4bxCEQ/MjwEArPBI/XuL37Ya
RoA1adWL3DNLYDM6srHpI0CInum9IgQ=
=BTAd
-----END PGP SIGNATURE-----

--oHiiIfBKH0NLyHDs--

