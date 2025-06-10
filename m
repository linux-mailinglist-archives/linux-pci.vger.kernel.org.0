Return-Path: <linux-pci+bounces-29340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56CEAD3D55
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 17:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16ACC3AACDA
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 15:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B560B248F5A;
	Tue, 10 Jun 2025 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTpMfumv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A3D248F50;
	Tue, 10 Jun 2025 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749569017; cv=none; b=TGOE5DId7AzW1+LGCN+Z6xNjPOyHfhjnR2ydxKpo0jpt/mpgeQrpbMsucdQ2Cwnu0UKXhuZ7A4smQAV0BYxhh1nvdqhEV0q9EbxyYXew25WJpMNA+RAL137n+Ju2tkqK8KduA4YflGpkC47s1GrjFAWipIfUj/cIH3lUOSjSO/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749569017; c=relaxed/simple;
	bh=GdC3hbu2lBWJrq1c5FNhywQS8uf44LJI+yaHMwNtUZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhvA2Ic36b8XOJdGzMUvfBG2YvnChzeZPfJPPJG4f17Fn/vHJty+FpU25WoWxeS/wvO/ulUCktyboLu5TA6mpLkPtWlyhm0IMj5zkCrAnMMzNEXn3+Hfnn2Ess5mU0hp9miZ0TmnYbQ8jvnO7N7eGrl0IEFTvdVBG/ly93/38aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTpMfumv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBF9C4CEED;
	Tue, 10 Jun 2025 15:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749569017;
	bh=GdC3hbu2lBWJrq1c5FNhywQS8uf44LJI+yaHMwNtUZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YTpMfumv//WkKeU1pjfa4/ARYTp4er7sYZcbWH7Qgd06JSTvoaaIHYhvfyV+OsRxe
	 KlD8ovmvs9jUneKVjEbQDT47TlVjrD+OWWBAXgl/QLAhgxu8jpyrQgIYSNb/AYIfVo
	 j9kLNX5UZ4TTUVtAn9cBmjIK4UTTWyT6FbUjk7eodk0Hmks8lKuGonOfGsOotLGu9J
	 4Ch1Rc44Zy/t9sG0UhEZ5Sjqoc9R33EQ5+n9c0p6RuhlUZ+jylbx/+TgiM5Xv33iPO
	 WhT/r9Ntl0xzsZVZUR2PCoYdHhCLAdkUAFJZlAflyHLada9PrrTsc7zQNzdTumIozf
	 1fPqbyu51psrQ==
Date: Tue, 10 Jun 2025 16:23:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt bindings: PCI: brcmstb: Include cable-modem SoCs
Message-ID: <20250610-satin-wages-2ae29a2a3520@spud>
References: <20250609221710.10315-1-james.quinlan@broadcom.com>
 <20250609221710.10315-2-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZDyAQUps/4oIxyh6"
Content-Disposition: inline
In-Reply-To: <20250609221710.10315-2-james.quinlan@broadcom.com>


--ZDyAQUps/4oIxyh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 09, 2025 at 06:17:04PM -0400, Jim Quinlan wrote:
> Add four Broadcom Cable Modem SoCs to the compatibility list.

In your commit messages, you should mention why these devices are not
capable of using fallbacks.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

>=20
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/D=
ocumentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index c4f9674e8695..5a7b0ed9464d 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -15,6 +15,9 @@ properties:
>        - enum:
>            - brcm,bcm2711-pcie # The Raspberry Pi 4
>            - brcm,bcm2712-pcie # Raspberry Pi 5
> +          - brcm,bcm3162-pcie # Broadcom DOCSIS 4.0 CMTS w/ 64b ARM
> +          - brcm,bcm3390-pcie # Broadcom DOCSIS 3.1 CM w/ 32b ARM
> +          - brcm,bcm3392-pcie # Broadcom DOCSIS 3.1 CM w/ 64b ARM
>            - brcm,bcm4908-pcie
>            - brcm,bcm7211-pcie # Broadcom STB version of RPi4
>            - brcm,bcm7216-pcie # Broadcom 7216 Arm
> @@ -23,6 +26,7 @@ properties:
>            - brcm,bcm7435-pcie # Broadcom 7435 MIPs
>            - brcm,bcm7445-pcie # Broadcom 7445 Arm
>            - brcm,bcm7712-pcie # Broadcom STB sibling of Rpi 5
> +          - brcm,bcm33940-pcie # Broadcom DOCSIS 4.0 CM w/ 64b ARM
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.43.0
>=20

--ZDyAQUps/4oIxyh6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaEhN8wAKCRB4tDGHoIJi
0tmAAQDHXwi683jRmX1Bx3NVDFjzYk9W0gkH+7s8QG2OnV8LrAEA133Af6pObKAg
bs044xuxHkN8aohFLG72Xi6Q3IdYyQ0=
=Bkpe
-----END PGP SIGNATURE-----

--ZDyAQUps/4oIxyh6--

