Return-Path: <linux-pci+bounces-21167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D01E2A3123F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 17:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5E33A2F09
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 16:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D28260A29;
	Tue, 11 Feb 2025 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDJQLqqh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57BF25EFAA;
	Tue, 11 Feb 2025 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739293141; cv=none; b=Jf01VdwOQXaUgNQY3LhluSrCgbqZ//IsmC6N+BfOoGLqsHdO8VKcgRny3/BxsRJj/49I2GCDHe13nHIiURH8+D766lKcEgcfT3pu3cL0K2AGFjAklq835AE5bnARsEn8mz3W7xmqzhKt/CXb43fNzwnduI2K+h4ejSIe/4xiXkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739293141; c=relaxed/simple;
	bh=fK//nR9SHqvEnwKbKqL6X4VpPE54Pj/YZ1rmNBO1MVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPYu1uR6wbFg/4/b5XjfI5Am2LUXd4gK83hxVlkpK7fQJZMPqAXOdf1aeO7H6AmqSEDgvrT2ugfc/RHY0PTfCobBxLahTXFip/0yxX1DrSJ3sy14Xq+dTM85g11J7idKrk1dTTM7h/S4zAcBzYZ2j8khx2rp2DA1qW6jpq+5emk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDJQLqqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDC5C4CEDD;
	Tue, 11 Feb 2025 16:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739293140;
	bh=fK//nR9SHqvEnwKbKqL6X4VpPE54Pj/YZ1rmNBO1MVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZDJQLqqh+oGAqn67HCRelQH5gESAY9mm+zGZ7Xdycr2vBiBVph6y22Lus8yFkZ0fB
	 OT/sDBBj2aUYammWqRlKDCqveVQNwoNkA6+wQpAcQnLZFDrnC9wFtcIQsHzYOkiKUa
	 9II1wSdoQjYmajeuSk5WiyiduLGVG/psHrIDtzXMSjiM9oa2Cd9iDvF+bwxkwY6siA
	 swJF48ZJL1rDlO9BbAsOQObWmFuPZ3L1H87HwWoHzwRWzT+BHhl5ZMFC8mUJUVXxPs
	 kKF7mObhHXM+KAiiptNVHkZCfPhfA3XrMOqNJPnx9eMIV2Lycw+LJJ0FlCesAj0Rlk
	 Is1RtewsQxZaA==
Date: Tue, 11 Feb 2025 16:58:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com
Subject: Re: [PATCH 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible string
 for CPM5NC Versal Net host
Message-ID: <20250211-deity-nautical-427b47e2f9a4@spud>
References: <20250211081724.320279-1-thippeswamy.havalige@amd.com>
 <20250211081724.320279-2-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O/yEPshzCBM2tE8L"
Content-Disposition: inline
In-Reply-To: <20250211081724.320279-2-thippeswamy.havalige@amd.com>


--O/yEPshzCBM2tE8L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 01:47:23PM +0530, Thippeswamy Havalige wrote:
> The Xilinx Versal Net series has Coherency and PCIe Gen5 Module
> Next-Generation compact (CPM5NC) block which supports Root Port
> controller functionality at Gen5 speed.
>=20
> Error interrupts are handled CPM5NC specific interrupt line and
> legacy interrupt is not support.

supported

>=20
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--O/yEPshzCBM2tE8L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6uBzwAKCRB4tDGHoIJi
0ramAQCQfipvdsuHCuybqCnibiqPlYnvVQaNnt84ej9LEMv7agEAk1Q9Bgs8zRA5
rCHNsVN8fITEY5OvQYyAU9beHwAG9Qs=
=nWaR
-----END PGP SIGNATURE-----

--O/yEPshzCBM2tE8L--

