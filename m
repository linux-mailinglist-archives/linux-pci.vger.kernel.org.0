Return-Path: <linux-pci+bounces-40656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D52C4451C
	for <lists+linux-pci@lfdr.de>; Sun, 09 Nov 2025 19:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D68C1882011
	for <lists+linux-pci@lfdr.de>; Sun,  9 Nov 2025 18:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6951E223DD4;
	Sun,  9 Nov 2025 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="PbabfmMB"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7973921C9E5;
	Sun,  9 Nov 2025 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762713275; cv=pass; b=p4Xx9A+xFLT1Xvih6GRC2bvyrDOaVjPL2H+APorwQRjt9t3HhpgB8aaz6kLNXfdi0kiCvwfNOWKMSQmYhi5VlYok6QZETTUjwefLDFLfc9ypi7P9K16uLzmGV1/d0955GI96n2f4Q4yhfX9OEC6Hi4/Rntvg9tpCRcUMnOE9nQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762713275; c=relaxed/simple;
	bh=vcl2WRG8ig0pt4U28bUUN8ohEswzlYl2LS+IoX3RUUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPrNFg4xk3cPN06DPiMWLxEzEimgbb5LyM03GCMWzXh3o5vEivIUDrtpOyYim1d+DXa8xIKhk+1DMORT2glL9K0AArpqqc1vwL5wmmSXHfdp8rnThH902Kii8njKcoYuJA5oy3x/lmQuxT58yFCLH5Z0kC6bk0LHP7j9UBJI3kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=PbabfmMB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1762713264; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XcMiy/RXv+jq541IzJYoepbrJpmXEUy6/atk1AOEuTJiohwFhlymJIlIfi5D6SjT2wGhk8Vm5fN8j59besbIpB/I1AOcIcIFFq/qplcz2Q33X+3Fr/NzcByLCOWhrRIx9ECv+dpdM0WsaSRC4ouzSs5RN7hEJ2xSL/JbW9Lw+Hk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762713264; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9Et9UYZ8BHyLLylfji7OkuBRbSAyMrXl07spb7ym+84=; 
	b=XCNhvxRStxRQWcbg6P/HeQXuszXWJFKwem0h+qumPy9Nt8+s0FKs1hQ2I98t05uImfsFblWmGOubXhqvGZxNdCSj2ZOoHe2uO3t0bZPicW3rO7M5u10snRBY87iP4o6PuD/VDuDRqrXjZwTFtUGyGt2rHm/WojXKEt+gcpUQK4s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762713264;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=9Et9UYZ8BHyLLylfji7OkuBRbSAyMrXl07spb7ym+84=;
	b=PbabfmMBf7dRcG2nTjvlPqxmvo7AShyf90YpGbwNKdx6zsUbcPSXUowQZB3uHqVJ
	43DcYBaYUjujqg/z7mV1vXnefH01iBSyIgjPyjOgV4o3NNM0Mngl22dLqXD5kUN3gui
	9i7TFH+RlfH8dwB4F/6Oj5qHg5zRD8cjjwjdfJEM=
Received: by mx.zohomail.com with SMTPS id 1762713261111263.4400627931818;
	Sun, 9 Nov 2025 10:34:21 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id CCD33180CB7; Sun, 09 Nov 2025 19:34:09 +0100 (CET)
Date: Sun, 9 Nov 2025 19:34:09 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key M connector
Message-ID: <b6bj7tqpp55lx24qcf6czqydmjfm2xaztcada4iczptaiozc55@c5xkbdxwe5jp>
References: <20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com>
 <20251108-pci-m2-v2-1-e8bc4d7bf42d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zx4ltudquq64qrc6"
Content-Disposition: inline
In-Reply-To: <20251108-pci-m2-v2-1-e8bc4d7bf42d@oss.qualcomm.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.5.1/262.655.73
X-ZohoMailClient: External


--zx4ltudquq64qrc6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key M connector
MIME-Version: 1.0

Hi,

On Sat, Nov 08, 2025 at 08:53:19AM +0530, Manivannan Sadhasivam wrote:
> Add the devicetree binding for PCIe M.2 Mechanical Key M connector defined
> in the PCI Express M.2 Specification, r4.0, sec 5.3. This connector
> provides interfaces like PCIe and SATA to attach the Solid State Drives
> (SSDs) to the host machine along with additional interfaces like USB, and
> SMB for debugging and supplementary features. At any point of time, the
> connector can only support either PCIe or SATA as the primary host
> interface.
>=20
> The connector provides a primary power supply of 3.3v, along with an
> optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> 1.8v sideband signaling.
>=20
> The connector also supplies optional signals in the form of GPIOs for fine
> grained power management.
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>  .../bindings/connector/pcie-m2-m-connector.yaml    | 122 +++++++++++++++=
++++++
>  1 file changed, 122 insertions(+)

I would expect something similar to usb-connector.yaml, i.e. m2-connector.y=
aml,
which then defines

compatible:
  enum:
    - m2-a-connector
    - m2-b-connector
    - m2-e-connector
    - m2-m-connector

(also not sure if we need the PCIe prefix, it just seems to make the
name longer)

Greetings,

-- Sebastian

--zx4ltudquq64qrc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmkQ3p4ACgkQ2O7X88g7
+pqL0w/+KpXEgKSf9yjlKS+VW0hpy/bZByO60LcxziTV0tm18r1nRuuezSKFJsuz
GoF8wnfPkebcWhj92P0LiJuNeSSp09urvHOhB23gsBY4IzxiCTNOR0DtR/Rxl4cQ
Mh55AQe/+ZIKnTw0ru0PyDCeCI8R3+MD20PJS2QiRZinie1ydWiwtb1w4awOm8Z2
VgABufhD+koy633Zt3ION/H2E0ArauKZh2pNquZlRICeGBOJZ5tcWycCvc1/E+Km
DfykhTQ997TTS1rwIKQ/fbu7bP9l9qJ2NGQ2j1BiGHkJIZBLbV3IwpA5yowbEkRJ
WmuHh+wSMFej639g8pYzamDiXdmieOqi1BWPrU65JraaVg/TL1SSF0qTMo55DY9U
GxQIW9ED9LCDOCpFhLOjcM92Dsj3HpFvVD5sYRIg3bE4imytxXWnrYv3Oc5Nx7aD
3zDJPxLP/86+g78Z0ZZvbNtHx5pn9aUMq7bMcqUShFTb88KpPHsYCTvro+xkm4wZ
PNqMWU0mhuAfqZeCeJbkmDQWS5iOFV3NZelt/TP4l6WNaC0CkqC/juXPpzAohLet
4fAQsNim1LIDNSJBrUFoaUaLlbsbeRednbAM453Lpo6h/LoMIgEG5sAKAcr10goK
KjrZLQCqKbvXPkCkgglHsUGEHtmcMkh+GghjnG3xEG+m5ON1pYM=
=oxYb
-----END PGP SIGNATURE-----

--zx4ltudquq64qrc6--

