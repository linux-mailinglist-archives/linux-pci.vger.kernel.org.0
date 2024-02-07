Return-Path: <linux-pci+bounces-3214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8837B84CF9F
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 18:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAFE51C21030
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 17:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDE4823B4;
	Wed,  7 Feb 2024 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/L2yQQm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761D441C7C;
	Wed,  7 Feb 2024 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707326280; cv=none; b=aFbBBOt+/ymgGX0IMHVvY2KFii3bcciq5YLdxP5o/FzQQRhdBL+/7cUw2dnqsQQiPUE3az/xh9xIrp7bNQG5KZS0fhiC3ANH85MCuA7dC9Yc3Wus+xTpqwUTbi3COHZ1TXGybsrBZ55ra51HX504N3yz8qk31LF2mx99/92Z8uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707326280; c=relaxed/simple;
	bh=AifL6QYyqG53TI48TuU1GDWfHn3Aaxdxr+6Bcd1YliY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcNXiBfRGRLbvWY3qddKDCKzxzq5dC9UvPHqoZaqPnOx4rx3BpEsNsd6D/etrhrTYe0Gbq2qpLCfdV+tJwc284Ah692Q9NA1S5vLyPM7VSHXS3OcOP0koIr7ilApGDK+J7CjPcA/L7kNQ2Eq6L8qpVhsobza2bLemNa2YRLF0Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/L2yQQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCF7C433F1;
	Wed,  7 Feb 2024 17:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707326280;
	bh=AifL6QYyqG53TI48TuU1GDWfHn3Aaxdxr+6Bcd1YliY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/L2yQQmYa895GsoyX4Lt15r0xvtYdIz0J4pPvvLtwpQzZF8MBMaPylvvQk2zRQzn
	 nJKuNGIMKoOtDvf4ey9+9c9L6XyYFP5NmElThKbIeyqcb2Dhw50XhQF7rK/hQypxKk
	 Pj+SjOPurY33w6k76xhGSlXdipyjZS8dX47ZdbJLGa57dtwf+OUml/waQGnyKK95zy
	 RHJY+UW579d1X/C5RmZxqNaqW5kZFtIKtXQtpfYaFiFTrA8CWLYphCuQsbh/dQzhDo
	 atsZ8XbTm8yLbQCjoYQnHbBkc3MW5khL6gi32S6AA1Cy3Rrra0b+e8CV9eedOLrKR9
	 2G9GYcKj3223w==
Date: Wed, 7 Feb 2024 17:17:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: pci: layerscape-pci: Convert to yaml
 file
Message-ID: <20240207-yoga-mobility-90a728f6342c@spud>
References: <20240207062403.304367-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Yz26zNuFXxc4q6EN"
Content-Disposition: inline
In-Reply-To: <20240207062403.304367-1-Frank.Li@nxp.com>


--Yz26zNuFXxc4q6EN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Frank,

On Wed, Feb 07, 2024 at 01:24:02AM -0500, Frank Li wrote:
> Convert layerscape pcie bind document to yaml file.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/pci/fsl,layerscape-pcie-ep.yaml  |  84 +++++++++
>  .../bindings/pci/fsl,layerscape-pcie.yaml     | 163 ++++++++++++++++++
>  .../bindings/pci/layerscape-pci.txt           |  79 ---------
>  3 files changed, 247 insertions(+), 79 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-=
pcie-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-=
pcie.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci.=
txt
>=20
> diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep=
=2Eyaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> new file mode 100644
> index 0000000000000..3b592c820eb4c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Layerscape PCIe controller
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description: |+

Are you sure that you need this chomping operator?

> +  This PCIe endpoint controller is based on the Synopsys DesignWare PCIe=
 IP

> +  and thus inherits all the common properties defined in snps,dw-pcie-ep=
=2Eyaml.

You shouldn't need this statement given you have the ref: below.

> +
> +  This controller derives its clocks from the Reset Configuration Word (=
RCW)
> +  which is used to describe the PLL settings at the time of chip-reset.
> +
> +  Also as per the available Reference Manuals, there is no specific 'ver=
sion'
> +  register available in the Freescale PCIe controller register set,
> +  which can allow determining the underlying DesignWare PCIe controller =
version
> +  information.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,ls2088a-pcie-ep
> +      - fsl,ls1088a-pcie-ep
> +      - fsl,ls1046a-pcie-ep
> +      - fsl,ls1028a-pcie-ep
> +      - fsl,lx2160ar2-pcie-ep

Where did the fallback compatible go?

> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: regs
> +      - const: addr_space

The example uses "regs" and "config". Where did addr_space come from?

> +  fsl,pcie-scfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: A phandle to the SCFG device node. The second entry is =
the
> +      physical PCIe controller index starting from '0'. This is used to =
get
> +      SCFG PEXN registers.
> +
> +  dma-coherent:

dma-coherent: true

> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Indicates that the hardware IP block can ensure the coh=
erency
> +      of the data transferred from/to the IP block. This can avoid the s=
oftware
> +      cache flush/invalid actions, and improve the performance significa=
ntly.
> +
> +  big-endian:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: If the PEX_LUT and PF register block is in big-endian, =
specify
> +      this property.
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names

This was not previously required, why is it required now?

> +  - "#address-cells"
> +  - "#size-cells"
> +  - device_type
> +  - bus-range
> +  - ranges
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,ls1028a-pcie-ep
> +            - fsl,ls1046a-pcie-ep
> +            - fsl,ls1088a-pcie-ep
> +    then:
> +      properties:
> +        interrupt-names:
> +          items:
> +            - const: pme

Please define the interrupt properties at the top-level and constrain
them on a per-device basis.

> +
> +unevaluatedProperties: false
> diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.ya=
ml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> new file mode 100644
> index 0000000000000..e3719da306f25
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> @@ -0,0 +1,163 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#

Only brief comments here, as it most is the same comments as for the=20
> +
> +title: Freescale Layerscape PCIe controller
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description: |+
> +  This PCIe host controller is based on the Synopsys DesignWare PCIe IP
> +  and thus inherits all the common properties defined in snps,dw-pcie.ya=
ml.

Same two comments here as above.

> +
> +  This controller derives its clocks from the Reset Configuration Word (=
RCW)
> +  which is used to describe the PLL settings at the time of chip-reset.
> +
> +  Also as per the available Reference Manuals, there is no specific 'ver=
sion'
> +  register available in the Freescale PCIe controller register set,
> +  which can allow determining the underlying DesignWare PCIe controller =
version
> +  information.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,ls1021a-pcie
> +      - fsl,ls2080a-pcie
> +      - fsl,ls2085a-pcie
> +      - fsl,ls2088a-pcie
> +      - fsl,ls1088a-pcie
> +      - fsl,ls1046a-pcie
> +      - fsl,ls1043a-pcie
> +      - fsl,ls1012a-pcie
> +      - fsl,ls1028a-pcie
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: regs
> +      - const: config
> +
> +  fsl,pcie-scfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: A phandle to the SCFG device node. The second entry is =
the
> +      physical PCIe controller index starting from '0'. This is used to =
get
> +      SCFG PEXN registers.
> +
> +  dma-coherent:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Indicates that the hardware IP block can ensure the coh=
erency
> +      of the data transferred from/to the IP block. This can avoid the s=
oftware
> +      cache flush/invalid actions, and improve the performance significa=
ntly.

Same here.

> +
> +  big-endian:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: If the PEX_LUT and PF register block is in big-endian, =
specify
> +      this property.
> +
> +  msi-parent: true
> +
> +  iommu-map: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names

Same here.

> +  - "#address-cells"
> +  - "#size-cells"
> +  - device_type
> +  - bus-range
> +  - ranges
> +  - interrupts
> +  - interrupt-names
> +  - "#interrupt-cells"
> +  - interrupt-map-mask
> +  - interrupt-map
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +

> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,ls1028a-pcie
> +            - fsl,ls1046a-pcie
> +            - fsl,ls1043a-pcie
> +            - fsl,ls1012a-pcie
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 2
> +        interrupt-names:
> +          items:
> +            - const: pme
> +            - const: aer
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,ls2080a-pcie
> +            - fsl,ls2085a-pcie
> +            - fsl,ls2088a-pcie
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +        interrupt-names:
> +          items:
> +            - const: intr
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,ls1088a-pcie
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +        interrupt-names:
> +          items:
> +            - const: aer

And same here.

Thanks,
Conor.

--Yz26zNuFXxc4q6EN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcO7QwAKCRB4tDGHoIJi
0kXFAP4yOTRC0bvtmQ0MsFVdS8ujw5GGs55XSRHGIrRROZqvmQD/UpsDMcsu2Gnm
G6u8JTfv3mObcAOn6C4X3dj7YZblYgI=
=iaaK
-----END PGP SIGNATURE-----

--Yz26zNuFXxc4q6EN--

