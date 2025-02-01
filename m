Return-Path: <linux-pci+bounces-20618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2976CA248DD
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 13:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578F07A3374
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 12:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A3913AA53;
	Sat,  1 Feb 2025 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpq9H9wz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6752484A30;
	Sat,  1 Feb 2025 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738411803; cv=none; b=ZWj/4ciKtk382f0UVBXVR/IoL+gVgSeP6HUrq+mLVBAmBLTLGmnWz32jfvFI8mIK2TEfqdWb2pwQOvNM/afgK0DjbCQP7crR10x3d6alr+QCAoB6K7PDil98ii4M9M/b853mRzEYfx4iw2WVMHMzW64rpRdNDcHMOVUlELJ9rHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738411803; c=relaxed/simple;
	bh=X0s4c1z7BZ7bSDDIII2Wq8XIoVPljTquKppMciXTq00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VR2nTS1sahvtVxNJM04AYY1cViSjZNlhUnapsAzAH8Q2Kam8Hx7/cQgHmzowQTkhWMv4WL4+yWPvdM9lBob2Aojb7qE0JB6gAbXl49ZOAi7Ivz1XCl2BbzpRaUMhjZl/6U8AcYxfyiZNs1AAn1bFTrGzUk4uyz33L+CI/OAcOiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpq9H9wz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C261DC4CED3;
	Sat,  1 Feb 2025 12:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738411803;
	bh=X0s4c1z7BZ7bSDDIII2Wq8XIoVPljTquKppMciXTq00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cpq9H9wzoeKLys+TJRtugW5oiduKaC/GKF69xFa7GJzYWan0Tbm224z1hSpD4KgcX
	 y9ooIpWAJVP1kUcyMxuJqtwqIDHxJREb50SZjH5L2PbhHZPOtzjTfnIhg2rqR3rklA
	 d28CXTBnN4lDxaa4/HjGCn892eErdhkUHg2iwdWbUPPk+xH6oBczCszx5tQ5JQ+SQ5
	 ecXhK0iQq+8lOZQ3QacSq76jQXWWvDTw58gEf96uN1DKUTe/l0sURAfiOo/dZiYMV3
	 ZZ9dX3fEKtJ9jjc4+5umFoKHODuuZm/llTRC94qapOlo82nUOeCuNxOtGI0TwqawwW
	 g57AtHVZum1aQ==
Date: Sat, 1 Feb 2025 13:10:00 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: mediatek-gen3: Configure PBUS_CSR registers for
 EN7581 SoC
Message-ID: <Z54PGPz1fJ0yiTJw@lore-desk>
References: <20250115-en7581-pcie-pbus-csr-v1-0-40d8fcb9360f@kernel.org>
 <20250115-en7581-pcie-pbus-csr-v1-2-40d8fcb9360f@kernel.org>
 <20250118-astonishing-ermine-of-painting-4d3eaa@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LgyfW4RVq7N0GtkC"
Content-Disposition: inline
In-Reply-To: <20250118-astonishing-ermine-of-painting-4d3eaa@krzk-bin>


--LgyfW4RVq7N0GtkC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Jan 15, 2025 at 06:32:31PM +0100, Lorenzo Bianconi wrote:

[./.]

>=20
> No, don't sprinkle compatibles in other drivers. It does not scale, does
> not allow reuse and you kind of try to escape ABI break, but you won't.
> This is still clear ABI break without any statement in commit msg and
> without explanation.
>=20
> NAK.
>=20
> Relationship between devices is expressed with phandles. There are
> plenty of examples how to do that with syscon.

ack, I will fix it in v2.

Regards,
Lorenzo

>=20
> Best regards,
> Krzysztof
>=20

--LgyfW4RVq7N0GtkC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ54PGAAKCRA6cBh0uS2t
rJaQAQDvoThUNUgQ9p0u9J7P0D1NUZr6t4u565b4/aq7YCxqJgD+IWQYJyLpBXTv
OTQVwK0TDl9pNcOoMhg3kyCg1i+IWwc=
=uMb3
-----END PGP SIGNATURE-----

--LgyfW4RVq7N0GtkC--

