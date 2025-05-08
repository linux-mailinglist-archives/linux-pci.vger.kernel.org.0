Return-Path: <linux-pci+bounces-27446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BF7AAFDF8
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 16:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760D2503AC1
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 14:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B58027A11E;
	Thu,  8 May 2025 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAbuPQB9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3455278169;
	Thu,  8 May 2025 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716161; cv=none; b=VjP7tY69YhzsYmmgxtxwiHilHRtozXDvuAhBbELSfEYn5zbBCVgUF+dr3qKvAnFmJmYJpNxV9XkAwZKI2Pw+Ur+gWtO57jH89V1kIznNjK449f2mNOOfbZ8h5XfrMLTqKidMJlPR4RVkXMCaIdAbP+AK95TM6LHnnryINbI8W3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716161; c=relaxed/simple;
	bh=3sph70K7tbu8/YzMrRwGcqavagjwvO/xYYwjATmmdXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIDC8bzhb2e1JbB1YLL96gqGcJPkd+zQZEB332vcYlIWd8rauoSzUXeO0DvWdId67bXxJ6Ld8ftM/Mmywz19orCa1zFRsFYwvM22H+tj7h9vy6a+Y/cCvJwDDcQQPxqIuvj5hgrAcPTh5uDPAueLmcgJ69d7RXZAZxCpVpfOmT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAbuPQB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CC4C4CEED;
	Thu,  8 May 2025 14:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746716160;
	bh=3sph70K7tbu8/YzMrRwGcqavagjwvO/xYYwjATmmdXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AAbuPQB9LmgaEoA8iWd4ABBrgsumCnyQWKSp8TzmXJGRnx2RcjOcFM9gmT4KP+gZM
	 7MXlN3jJSTDLQUBXh3Tn8CZSxHHV+nO76VVc6YYayZ8wvcy6xR+cXJIQO91kVpTwo4
	 66W/qtJD58QJvEmarBqimUgq5t1lMoRSGTTUQn3z+tdFG5boh5hrAaklcN9BSGHfrZ
	 6o4xanrubBikkDhmoM8UHTqdEVAvzPmXaZm+vcDfJMWZB3UD78tNW7LyRatjm3xJXl
	 pqIuA6IKZ7XdC9fyql5kjJCsZo+7qgpIqyTy5/FhPhRbDQHlphsNaYS+vlf0sXXP/T
	 gHLzzKMoXx/Ww==
Date: Thu, 8 May 2025 15:55:55 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joyce Ooi <joyce.ooi@intel.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Move altr,msi-controller to
 interrupt-controller directory
Message-ID: <20250508-donut-radiator-66d06a36e8e8@spud>
References: <20250507154253.1593870-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MPh2K4ynGn9ngJl9"
Content-Disposition: inline
In-Reply-To: <20250507154253.1593870-1-robh@kernel.org>


--MPh2K4ynGn9ngJl9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 10:42:53AM -0500, Rob Herring (Arm) wrote:
> While altr,msi-controller is used with PCI, it is not a PCI host bridge
> and is just an MSI provider. Move it with other MSI providers in the
> 'interrupt-controller' directory.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--MPh2K4ynGn9ngJl9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaBzF+wAKCRB4tDGHoIJi
0hx6AP9MH4cTQdoahYIWy4tKS1Uo3KGmbcyM5IZnCm2u05kBbAD9GLxG0FsIniey
CsrB+KAm76x/ZHArBtB2OU0tQ6KOWw8=
=/Kh0
-----END PGP SIGNATURE-----

--MPh2K4ynGn9ngJl9--

