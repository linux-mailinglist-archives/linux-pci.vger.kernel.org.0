Return-Path: <linux-pci+bounces-10616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0649392B0
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 18:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99AC1F22053
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 16:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EC816EB57;
	Mon, 22 Jul 2024 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8ic2+ht"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6615516E89B;
	Mon, 22 Jul 2024 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721666687; cv=none; b=AIPdXTmVWCtrzqG2jP5lZ4KsHt2iuFEUmJZXLuF9zOE5DPcORvs8r+mJKmgKt7Z+K3nyyoAD5I97C0jnnBMcwoxDcL9pxfZtBb7TGVOHaxNHS4RwU1+M4aHTQ2U8j6zcObAVsJPzaOsRThwfsgUYOgicHPAyHY/BlK132uAN3eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721666687; c=relaxed/simple;
	bh=nMaQD7CcFCSVVlPv+PUVH+T24g4Li95JzDQj8TyNmdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLc++61B9BrvMZ7WVOFDZyowWs//UaWfwfAxjgas6MLyySlMeccE5277XkfBQh3EpyU9j7mFLHQPm6by7q3r5Cm+Oo8k0WaggHalgCpA50Tsnkvr2b+0QwPSHw9Pxzb2KLMFzsygN3IIbFV3NGSrCJG+XIkjIYV6wtqoTmYgLUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8ic2+ht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52104C116B1;
	Mon, 22 Jul 2024 16:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721666686;
	bh=nMaQD7CcFCSVVlPv+PUVH+T24g4Li95JzDQj8TyNmdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U8ic2+htmt2MeAxldBS//m5HkTfNo98txmw5/51xyGtpgrLCiqHXUodcNV8ygx2c2
	 X+8p50V8xfCoNUTCzG4gcsB7f1NgNufaOM+Ivccp6IyNVNNWFqM8gAhgxuhobqnCBl
	 8MavFPdJDUFXBMvxMcZGlltDnkqr9I1kFIAZ/1pziJzaZQGokjBxwTj+Js2N6WsWOc
	 LhRSzRZuOLWdtgGKcC2K7MGMUkLoFeEQiFHBCUTG0vPjJRULchLwk0uI1Xxrslj2Jl
	 zVj/l8qa/lpvW8xXOgff5SzMHwWZipgjddasZ9FK5RLFIbKkl6VEEPsAAKM0FQ3tAI
	 4tCEOPY/8wFjQ==
Date: Mon, 22 Jul 2024 17:44:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Thippeswamy Havalige <thippesw@amd.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, thippeswamy.havalige@amd.com,
	linux-arm-kernel@lists.infradead.org, michal.simek@amd.com
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: xilinx-xdma: Add schemas for
 Xilinx QDMA PCIe Root Port Bridge
Message-ID: <20240722-wham-molasses-ec515cc554a0@spud>
References: <20240722062558.1578744-1-thippesw@amd.com>
 <20240722062558.1578744-2-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0qbwwrfU/idHp2B5"
Content-Disposition: inline
In-Reply-To: <20240722062558.1578744-2-thippesw@amd.com>


--0qbwwrfU/idHp2B5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 11:55:57AM +0530, Thippeswamy Havalige wrote:
> Add YAML devicetree schemas for Xilinx QDMA Soft IP PCIe Root Port Bridge.
>=20
> Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
> ---
>  .../bindings/pci/xlnx,xdma-host.yaml          | 41 ++++++++++++++++++-
>  1 file changed, 39 insertions(+), 2 deletions(-)
> ---
> changes in v2
> - update dt node label with pcie.
> ---
> diff --git a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml b/=
Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> index 2f59b3a73dd2..28d9350a7fb4 100644
> --- a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> @@ -14,10 +14,21 @@ allOf:
> =20
>  properties:
>    compatible:
> -    const: xlnx,xdma-host-3.00
> +    enum:
> +      - xlnx,xdma-host-3.00
> +      - xlnx,qdma-host-3.00
> =20
>    reg:
> -    maxItems: 1
> +    items:
> +      - description: configuration region and XDMA bridge register.
> +      - description: QDMA bridge register.

Please constrain the new entry to only the new compatible.

> +    minItems: 1
> +
> +  reg-names:
> +    items:
> +      - const: cfg
> +      - const: breg
> +    minItems: 1
> =20
>    ranges:
>      maxItems: 2
> @@ -111,4 +122,30 @@ examples:
>                  interrupt-controller;
>              };
>          };
> +
> +        pcie@80000000 {

tbh, don't see the point of a new example for this.

> +            compatible =3D "xlnx,qdma-host-3.00";
> +            reg =3D <0x0 0x80000000 0x0 0x10000000>, <0x0 0x90000000 0x0=
 0x10000000>;
> +            reg-names =3D "cfg", "breg";
> +            ranges =3D <0x2000000 0x0 0xa8000000 0x0 0xa8000000 0x0 0x80=
00000>,
> +                     <0x43000000 0x4 0x80000000 0x4 0x80000000 0x0 0x400=
00000>;
> +            #address-cells =3D <3>;
> +            #size-cells =3D <2>;
> +            #interrupt-cells =3D <1>;
> +            device_type =3D "pci";
> +            interrupt-parent =3D <&gic>;
> +            interrupts =3D <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 85=
 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names =3D "misc", "msi0", "msi1";
> +            interrupt-map-mask =3D <0x0 0x0 0x0 0x7>;
> +            interrupt-map =3D <0 0 0 1 &pcie_intc_0 0>,
> +                            <0 0 0 2 &pcie_intc_0 1>,
> +                            <0 0 0 3 &pcie_intc_0 2>,
> +                            <0 0 0 4 &pcie_intc_0 3>;
> +            pcie_intc_1: interrupt-controller {
> +                #address-cells =3D <0>;
> +                #interrupt-cells =3D <1>;
> +                interrupt-controller;
> +            };
> +        };
>      };
> --=20
> 2.25.1
>=20

--0qbwwrfU/idHp2B5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZp6MegAKCRB4tDGHoIJi
0pcBAP9LahMFVPGTtlUm8+OhxWG5Ur/e8PepALBK4xDJtO4ONQEA7BRaZ7ZjdO/u
9xk3Bxqvw53xVCsmlLWgeSbSeylHWg0=
=+Q7I
-----END PGP SIGNATURE-----

--0qbwwrfU/idHp2B5--

