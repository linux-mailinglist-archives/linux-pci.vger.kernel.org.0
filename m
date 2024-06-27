Return-Path: <linux-pci+bounces-9383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0E991AC81
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 18:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68ED4B23F78
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 16:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212D0199395;
	Thu, 27 Jun 2024 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkTVsFGh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA86E197A65;
	Thu, 27 Jun 2024 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505352; cv=none; b=n8gtziQ0tENm+FMpkz7hvhB0gz3BE7ZSQQGC6ImzLLudzVDoyOyT4pb19tesETBNoi6CD6arzavNvOEy2NA5sP4hOniRe+a83u+SQ4hOvGBKUmCdkT/3Hf4A1/Pd+L5CMgqcxyo7vQ27Lc+60uEr1Hm7ZCIllBALbAB3bScBFsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505352; c=relaxed/simple;
	bh=TMnrFsjqTQSFOQs7nIdl6/67gGRZGNEZGkvjDhvZqvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajKQR3+2EHorOBc119GRQ0ktl2lf/1Wc1eTg/HqCUKkxLqiUaqw7sRRG96EMRRA6SUiSjkc8APpPzs7QM97imP1MHTROZOWC2LyF4cWgyOvD9QDRy7uQujc8n6oWWx2oNTphDg6TigCicjKKnImb1BQsYD80sckea82V3zsiBxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkTVsFGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA85C2BBFC;
	Thu, 27 Jun 2024 16:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719505351;
	bh=TMnrFsjqTQSFOQs7nIdl6/67gGRZGNEZGkvjDhvZqvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BkTVsFGhqUuZ2Es9Q5UvBx5RFlrHO58V1O6B3TRwelvxkIyL4ySfxxS40sUY3F3R0
	 FentU0+s3sWywiz8PAGk0HYmc6bJoktx8/hxRU2eFp6nIibWgWVJfXDMKR+TPE1bx/
	 u6LiVVijXAVewGUbomz0Sxf5soBihgvSQtL/OmTPsE1bkr2iuQE0zYTuONKcmlWtd6
	 EXsD7irBelwyIPfVS73FSPYlbGU3trPHNruS0MZGKj1KgZwZL2zHgVZ9SNnbwgYhdm
	 5TaSnC8ioToQ0zwCa9D+oEW5JBpcvmEuLYT11jrmRZe/UsiUQiaK8jeK6XF6tnj/Z2
	 hw9th42gY863g==
Date: Thu, 27 Jun 2024 17:22:27 +0100
From: Conor Dooley <conor@kernel.org>
To: matthew.gerlach@linux.intel.com
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	joyce.ooi@intel.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] dt-bindings: PCI: altera: Convert to YAML
Message-ID: <20240627-finer-expel-2c7ab9f05733@spud>
References: <20240614163520.494047-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9ilwJNtWwmRhDcGd"
Content-Disposition: inline
In-Reply-To: <20240614163520.494047-1-matthew.gerlach@linux.intel.com>


--9ilwJNtWwmRhDcGd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Been stalling replying here, was wondering if Rob would look given he
reviewed the previous versions.

On Fri, Jun 14, 2024 at 11:35:20AM -0500, matthew.gerlach@linux.intel.com w=
rote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> Convert the device tree bindings for the Altera Root Port PCIe controller
> from text to YAML. Update the entries in the interrupt-map field to have
> the correct number of address cells for the interrupt parent.
>=20
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> diff --git a/Documentation/devicetree/bindings/pci/altera-pcie.txt b/Docu=
mentation/devicetree/bindings/pci/altera-pcie.txt
> deleted file mode 100644
> index 816b244a221e..000000000000
> --- a/Documentation/devicetree/bindings/pci/altera-pcie.txt
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -* Altera PCIe controller
> -
> -Required properties:
> -- compatible :	should contain "altr,pcie-root-port-1.0" or "altr,pcie-ro=
ot-port-2.0"
> -- reg:		a list of physical base address and length for TXS and CRA.
> -		For "altr,pcie-root-port-2.0", additional HIP base address and length.
> -- reg-names:	must include the following entries:
> -		"Txs": TX slave port region
> -		"Cra": Control register access region

> -		"Hip": Hard IP region (if "altr,pcie-root-port-2.0")

I think this should be constrained in the new yaml binding by setting
maxItems: for reg/reg-names to 2 for 1.0 and, if I am not
misunderstanding what "must include" means, minItems: to 3 for 2.0.

Thanks,
Conor.

> diff --git a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.ya=
ml b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
> new file mode 100644
> index 000000000000..0aaf5dbcc9cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2015, 2019, 2024, Intel Corporation
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/altr,pcie-root-port.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Altera PCIe Root Port
> +
> +maintainers:
> +  - Matthew Gerlach <matthew.gerlach@linux.intel.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - altr,pcie-root-port-1.0
> +      - altr,pcie-root-port-2.0
> +
> +  reg:
> +    items:
> +      - description: TX slave port region
> +      - description: Control register access region
> +      - description: Hard IP region
> +    minItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: Txs
> +      - const: Cra
> +      - const: Hip
> +    minItems: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  interrupt-map-mask:
> +    items:
> +      - const: 0
> +      - const: 0
> +      - const: 0
> +      - const: 7
> +
> +  interrupt-map:
> +    maxItems: 4
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  msi-parent: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - "#interrupt-cells"
> +  - interrupt-controller
> +  - interrupt-map
> +  - interrupt-map-mask
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#

--9ilwJNtWwmRhDcGd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn2RwwAKCRB4tDGHoIJi
0qYAAP4wDJobiNVvDe2lGN5IVp5yaFQBWs3S96o3aWzteZHlxwD/Rdn4PgaiT4i+
MzHMBW+Uslp5+U4KxXeTXIBrp8WeSwA=
=b0h0
-----END PGP SIGNATURE-----

--9ilwJNtWwmRhDcGd--

