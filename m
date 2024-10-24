Return-Path: <linux-pci+bounces-15190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B3A9AE12E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 11:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16DC1F22AD9
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 09:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F66F1D174A;
	Thu, 24 Oct 2024 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWboTjyI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CAC1D172B;
	Thu, 24 Oct 2024 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762696; cv=none; b=aam7HCvOFPltSexu9LhOqLO64F48v4ke6vSY3DGCbzGVfDn3N7gIyKOssIV//TmJZQyyuQd63VqlAEXbXepw4NPVL5vqM2A6tgV/2XxCjQhEMSv38ory1C0oWK3yDq2l4mHLrUasGSZ0EAVDnlWy9iLsS6K4zYxSsWN6Uv2SwGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762696; c=relaxed/simple;
	bh=TM7UNffSSOmAOZkaONHkwvnJYn+RtQ7/d5lFvohpBnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5G2/g/Q+yKGrhExYhc9tw8QCae87hUJhU/oJPWYfQ22SFAGg9dcjg/hnC65nkQuwYFBDlPLEK5LMK4QA/A+bjMOTrVePiP+6CTzgxHMPkJIuGwthPnbAI3dyZJMTn8HLnQg++x0kcm053BUJZxDTBSQJS4CXp1OTCyFljxLit8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWboTjyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EEAC4CEC7;
	Thu, 24 Oct 2024 09:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729762695;
	bh=TM7UNffSSOmAOZkaONHkwvnJYn+RtQ7/d5lFvohpBnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AWboTjyIQkjp08p9YShGmcoM7pqqYthPP6XGtm+Dl811CsjBV+JzMBevlJyusgVvG
	 ZgccgktLRRy7kuZSwAWnMKaIvfPi5q5hBURUdsnSpToD9FblTPvrdpYTurXr+WDZkT
	 tyFfGAeOymPWNi0pHE1CTqovskZ4zPQQ2LJNrBWdNHkqb5jgfE1+1nAhGAXp3QC+9X
	 jMi8qQ0igZIZghT5MSBxfjaP5aJOMap2mtjFLsMfh8cLgJ9d6K9xEc6nL3sjoeRmBY
	 K+5zsbpi5R0nct7+/NfNmuU2y9KkyzoGS5Lch0t0z7oNG8d8vZXZdeoSYuqhcvBbFU
	 TrTygL8pzHYTg==
Date: Thu, 24 Oct 2024 10:38:11 +0100
From: Conor Dooley <conor@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 0/2] PCI: microchip: support using either instance 1
 or 2
Message-ID: <20241024-gout-kinfolk-0f24b28d41b7@spud>
References: <20240814-setback-rumbling-c6393c8f1a91@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U6iyZokWShLT5gWe"
Content-Disposition: inline
In-Reply-To: <20240814-setback-rumbling-c6393c8f1a91@spud>


--U6iyZokWShLT5gWe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 09:08:40AM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> The current driver and binding for PolarFire SoC's PCI controller assume
> that the root port instance in use is instance 1. The second reg
> property constitutes the region encompassing both "control" and "bridge"
> registers for both instances. In the driver, a fixed offset is applied to
> find the base addresses for instance 1's "control" and "bridge"
> registers. The BeagleV Fire uses root port instance 2, so something must
> be done so that software can differentiate. This series splits the
> second reg property in two, with dedicated "control" and "bridge"
> entries so that either instance can be used.

Just attempting to bump this patchset. It has gone over 2 months without
response, and I am afraid it has completely fallen between the cracks.

Thanks,
Conor.

--U6iyZokWShLT5gWe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxoVgwAKCRB4tDGHoIJi
0rSkAQDDxvSCVpyNBChctdnTAmn52RkLFOl+dBGBX8kpkw1apQD+LA70iId0caDT
vs957ff3Zq274+khzayKzwkmeaf0Zgk=
=nk2E
-----END PGP SIGNATURE-----

--U6iyZokWShLT5gWe--

