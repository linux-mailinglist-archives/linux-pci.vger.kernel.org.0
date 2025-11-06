Return-Path: <linux-pci+bounces-40532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 992FCC3CF8D
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 18:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEFD04E1617
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 17:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247F634F246;
	Thu,  6 Nov 2025 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+5gLqTQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E834F225D6;
	Thu,  6 Nov 2025 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451844; cv=none; b=JPj7TTcwst4Qb4wIuJ/ApIp0S8ATxzkW2Mll/UpjekRiktJqCUYIgmYLLmPIv5oRyc3ebA571xcvnAsCHyrM0wbc/sFOL6HdUvQPRCmSmFQ5m678S3oaOybHNVIVnmRnmmNWtVeOCgpc7iCHa5mvG+Cs5iKw+Q5d7G61IxK6stE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451844; c=relaxed/simple;
	bh=UnXS+32sgS7AJSR2SoposJwC2eun1G19mYNc72E2K9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/uE9I64BtsbJsEfY7LYIsb1Dy3c3iRQCYHcFzBLSfL0+k5782RvRTHIS14uU/iB1RP0VzrdjPuvPpwyVbgagFeQGi85LzAR8m5H+hqO3dU4qIMza6YkTwFL5FPQwRPomlPgcLKAUeHyF6ABM82gw2jtqxy86hIg9nMTVVL4fRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+5gLqTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF523C116B1;
	Thu,  6 Nov 2025 17:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762451842;
	bh=UnXS+32sgS7AJSR2SoposJwC2eun1G19mYNc72E2K9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T+5gLqTQgqFu/RfWCN2JY9reasd2XIE7GssvtBAvYl1UNjmyo8HO+ya6lnnGoKuOR
	 SB1KXP728LboNv1GZ/ihMQlxUtNXd2yb6VhmS+MB1sSazXtTdyjwKNV5+yKQwc2aDg
	 bOlbl224sxBSSMixdmxTAJv3qrM1B557gb6s+CnAHPUlsIzyxeheNuYwaxy+uvYP62
	 g2KcTWhsAcxCV4DUAaNHVnXW/gLthd9C2cfzX4afddm5bGRW+eKs1nFSSfksQ7rrw4
	 PeAbeyTrcbHswsO4jxLcUystypu6fnnS3PQhXu8j0/zYDCz8BWyvUagIXYgt/XwbZv
	 aVv49Asr7zvBw==
Date: Thu, 6 Nov 2025 17:57:17 +0000
From: Conor Dooley <conor@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical Key
 M connector
Message-ID: <20251106-legibly-resupply-1d3cef545229@spud>
References: <20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com>
 <20251105-pci-m2-v1-1-84b5f1f1e5e8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uAYGTx5GDWafj68j"
Content-Disposition: inline
In-Reply-To: <20251105-pci-m2-v1-1-84b5f1f1e5e8@oss.qualcomm.com>


--uAYGTx5GDWafj68j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 02:45:49PM +0530, Manivannan Sadhasivam wrote:
> Add the devicetree binding for PCIe M.2 Mechanical Key M connector. This
> connector provides interfaces like PCIe and SATA to attach the Solid State
> Drives (SSDs) to the host machine along with additional interfaces like
> USB, and SMB for debugging and supplementary features. At any point of
> time, the connector can only support either PCIe or SATA as the primary
> host interface.
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
>  .../bindings/connector/pcie-m2-m-connector.yaml    | 121 +++++++++++++++=
++++++
>  1 file changed, 121 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-m-connec=
tor.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.=
yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..2db23e60fdaefabde6f208e4a=
e0c9dded3a513f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/pcie-m2-m-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe M.2 Mechanical Key M Connector
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> +
> +description:
> +  A PCIe M.2 M connector node represents a physical PCIe M.2 Mechanical =
Key M
> +  connector. The Mechanical Key M connectors are used to connect SSDs to=
 the
> +  host system over PCIe/SATA interfaces. These connectors also offer opt=
ional
> +  interfaces like USB, SMB.
> +
> +properties:
> +  compatible:
> +    const: pcie-m2-m-connector

Is this something generated from a standard that's going to be
practically identical everywhere, or just some qcom thing?

--uAYGTx5GDWafj68j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQzhfQAKCRB4tDGHoIJi
0t1uAQDc5pmQNbPwDyEMTn5FPMnQn+G5mQWnMFTjroDojrxmzwD/ceWjD/qF8RZb
JhTn84HyG8HzouxenXWUck33JLAQFQg=
=ayfa
-----END PGP SIGNATURE-----

--uAYGTx5GDWafj68j--

