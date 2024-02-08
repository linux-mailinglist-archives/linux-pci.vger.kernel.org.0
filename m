Return-Path: <linux-pci+bounces-3243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5728784E8E8
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 20:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78BEA1C24B16
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 19:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20242381C5;
	Thu,  8 Feb 2024 19:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUG5n/3N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE9F376FD;
	Thu,  8 Feb 2024 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420381; cv=none; b=tVgqTpVKgGQC6l0Ma3Q8GXh2U+lhPAV8nujkBEOahOcRLefWvYf3jxqd/LtMOLD5FUUlnQMnNhRpRM3sz6VGNfJ8oYvttw+3V6Jn35b64Av/FJks/XHf+5jvJJ0bvvDjx6up4VSypW11sp3DTI/T/9o+b2lUQerNgTLS2CDjrLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420381; c=relaxed/simple;
	bh=biJlj7vhbrf9o2ZlnVMqywQXI9Tsh+VpWr7/U4LkYfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAAuTyvFzQIzJiAot4uzpOf8eg5q+K3DvYpgoWlJv6PWAIwJQ3LIGhiMuxqiI+5dgrRsgwRe9Hc6oKX6E92PW+/h9SrA8uT+2ZIkeQJ6ieXMnzbdsBEVnuzgepFiOd4rV9vg7r+jJgcLqle8vWRYTrwFeaq/M812d9gHXBphtls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUG5n/3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C6EC433C7;
	Thu,  8 Feb 2024 19:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707420380;
	bh=biJlj7vhbrf9o2ZlnVMqywQXI9Tsh+VpWr7/U4LkYfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hUG5n/3N8YRaazVF3WtzvtumqN3Yl9XxF/J0+WV1+PSnqw3PuXJ1gjgVOPmxfkzCL
	 qgQxa54d4dbgjJ89N+wT4aA9ljJ2k+/cejuNuclii7HAvHCy/Vn5L1O9tdevqa5Ebv
	 HZ5jF2pLMseB2/Y97N1tPtWBBLvwxJnujNMkvuxLN7GrcvzSwyRNbW0T3ClvqtYYF+
	 SIkUnHC1bj5pYsu8oNQsEDtXiaOjqHABHjR/FuzdVCDdBpZ3tOo4OPayZg8d0mKjBe
	 IyiBvodBBMf6qRMvlP3oUjkBXt+zcn+rh6bjxciw/8APW4HsYDqIY+bklPAr2aW9o/
	 VY+CyHGirqd0A==
Date: Thu, 8 Feb 2024 19:26:15 +0000
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
Subject: Re: [PATCH v2 1/1] dt-bindings: pci: layerscape-pci: Convert to yaml
 file
Message-ID: <20240208-subfloor-polka-96bbbbc27fb0@spud>
References: <20240207231550.2663689-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c8zVfnGHMbU1k5gA"
Content-Disposition: inline
In-Reply-To: <20240207231550.2663689-1-Frank.Li@nxp.com>


--c8zVfnGHMbU1k5gA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 06:15:49PM -0500, Frank Li wrote:
> Convert layerscape pcie bind document to yaml file.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Please don't send new versions before giving people a chance to finish
the discussion on the existing ones. This is not the first time in the
last few days I am asking you this. Nobody pays me to review DT
bindings, so you'll have to accept that I will take some time to reply.

Thanks,
Conor.

> ---
>=20
> Notes:
>     Change from v1 to v2
>     - remove '|-'
>     - dma-coherent: true
>     - add interrupts and interrupt-names at before Allof
>     - remove ref to snps,pcie*.yaml, some reg-names are not aligned with =
in
>     drivers
>     - Add an example for pcie-ep
>=20
>  .../bindings/pci/fsl,layerscape-pcie-ep.yaml  | 102 +++++++++++
>  .../bindings/pci/fsl,layerscape-pcie.yaml     | 167 ++++++++++++++++++
>  .../bindings/pci/layerscape-pci.txt           |  79 ---------
>  3 files changed, 269 insertions(+), 79 deletions(-)
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
> index 0000000000000..399efa7364c93
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Layerscape PCIe Endpoint(EP) controller
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description:
> +  This PCIe EP controller is based on the Synopsys DesignWare PCIe IP.
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
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: regs
> +      - const: addr_space
> +
> +  fsl,pcie-scfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: A phandle to the SCFG device node. The second entry is =
the
> +      physical PCIe controller index starting from '0'. This is used to =
get
> +      SCFG PEXN registers.
> +
> +  big-endian:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: If the PEX_LUT and PF register block is in big-endian, =
specify
> +      this property.
> +
> +  dma-coherent: true
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +
> +allOf:
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
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +      #address-cells =3D <2>;
> +      #size-cells =3D <2>;
> +
> +      pcie_ep1: pcie-ep@3400000 {
> +        compatible =3D "fsl,ls1028a-pcie-ep";
> +        reg =3D <0x00 0x03400000 0x0 0x00100000
> +              0x80 0x00000000 0x8 0x00000000>;
> +        reg-names =3D "regs", "addr_space";
> +        interrupts =3D <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interru=
pt */
> +        interrupt-names =3D "pme";
> +        num-ib-windows =3D <6>;
> +        num-ob-windows =3D <8>;
> +        status =3D "disabled";
> +      };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.ya=
ml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> new file mode 100644
> index 0000000000000..793986c5af7ff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> @@ -0,0 +1,167 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Layerscape PCIe Root Complex(RC) controller
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description:
> +  This PCIe RC controller is based on the Synopsys DesignWare PCIe IP
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
> +      - fsl,lx2160a-pcie
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
> +  big-endian:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: If the PEX_LUT and PF register block is in big-endian, =
specify
> +      this property.
> +
> +  dma-coherent: true
> +
> +  msi-parent: true
> +
> +  iommu-map: true
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
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
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +      #address-cells =3D <2>;
> +      #size-cells =3D <2>;
> +
> +      pcie@3400000 {
> +        compatible =3D "fsl,ls1088a-pcie";
> +        reg =3D <0x00 0x03400000 0x0 0x00100000>, /* controller register=
s */
> +            <0x20 0x00000000 0x0 0x00002000>; /* configuration space */
> +        reg-names =3D "regs", "config";
> +        interrupts =3D <0 108 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
> +        interrupt-names =3D "aer";
> +        #address-cells =3D <3>;
> +        #size-cells =3D <2>;
> +        dma-coherent;
> +        device_type =3D "pci";
> +        bus-range =3D <0x0 0xff>;
> +        ranges =3D <0x81000000 0x0 0x00000000 0x20 0x00010000 0x0 0x0001=
0000   /* downstream I/O */
> +                 0x82000000 0x0 0x40000000 0x20 0x40000000 0x0 0x4000000=
0>; /* non-prefetchable memory */
> +        msi-parent =3D <&its>;
> +        #interrupt-cells =3D <1>;
> +        interrupt-map-mask =3D <0 0 0 7>;
> +        interrupt-map =3D <0000 0 0 1 &gic 0 0 0 109 IRQ_TYPE_LEVEL_HIGH=
>,
> +                        <0000 0 0 2 &gic 0 0 0 110 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0000 0 0 3 &gic 0 0 0 111 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0000 0 0 4 &gic 0 0 0 112 IRQ_TYPE_LEVEL_HIGH>;
> +        iommu-map =3D <0 &smmu 0 1>; /* Fixed-up by bootloader */
> +      };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/D=
ocumentation/devicetree/bindings/pci/layerscape-pci.txt
> deleted file mode 100644
> index ee8a4791a78b4..0000000000000
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ /dev/null
> @@ -1,79 +0,0 @@
> -Freescale Layerscape PCIe controller
> -
> -This PCIe host controller is based on the Synopsys DesignWare PCIe IP
> -and thus inherits all the common properties defined in snps,dw-pcie.yaml.
> -
> -This controller derives its clocks from the Reset Configuration Word (RC=
W)
> -which is used to describe the PLL settings at the time of chip-reset.
> -
> -Also as per the available Reference Manuals, there is no specific 'versi=
on'
> -register available in the Freescale PCIe controller register set,
> -which can allow determining the underlying DesignWare PCIe controller ve=
rsion
> -information.
> -
> -Required properties:
> -- compatible: should contain the platform identifier such as:
> -  RC mode:
> -        "fsl,ls1021a-pcie"
> -        "fsl,ls2080a-pcie", "fsl,ls2085a-pcie"
> -        "fsl,ls2088a-pcie"
> -        "fsl,ls1088a-pcie"
> -        "fsl,ls1046a-pcie"
> -        "fsl,ls1043a-pcie"
> -        "fsl,ls1012a-pcie"
> -        "fsl,ls1028a-pcie"
> -  EP mode:
> -	"fsl,ls1028a-pcie-ep", "fsl,ls-pcie-ep"
> -	"fsl,ls1046a-pcie-ep", "fsl,ls-pcie-ep"
> -	"fsl,ls1088a-pcie-ep", "fsl,ls-pcie-ep"
> -	"fsl,ls2088a-pcie-ep", "fsl,ls-pcie-ep"
> -	"fsl,lx2160ar2-pcie-ep", "fsl,ls-pcie-ep"
> -- reg: base addresses and lengths of the PCIe controller register blocks.
> -- interrupts: A list of interrupt outputs of the controller. Must contai=
n an
> -  entry for each entry in the interrupt-names property.
> -- interrupt-names: It could include the following entries:
> -  "aer": Used for interrupt line which reports AER events when
> -	 non MSI/MSI-X/INTx mode is used
> -  "pme": Used for interrupt line which reports PME events when
> -	 non MSI/MSI-X/INTx mode is used
> -  "intr": Used for SoCs(like ls2080a, lx2160a, ls2080a, ls2088a, ls1088a)
> -	  which has a single interrupt line for miscellaneous controller
> -	  events(could include AER and PME events).
> -- fsl,pcie-scfg: Must include two entries.
> -  The first entry must be a link to the SCFG device node
> -  The second entry is the physical PCIe controller index starting from '=
0'.
> -  This is used to get SCFG PEXN registers
> -- dma-coherent: Indicates that the hardware IP block can ensure the cohe=
rency
> -  of the data transferred from/to the IP block. This can avoid the softw=
are
> -  cache flush/invalid actions, and improve the performance significantly.
> -
> -Optional properties:
> -- big-endian: If the PEX_LUT and PF register block is in big-endian, spe=
cify
> -  this property.
> -
> -Example:
> -
> -        pcie@3400000 {
> -                compatible =3D "fsl,ls1088a-pcie";
> -                reg =3D <0x00 0x03400000 0x0 0x00100000>, /* controller =
registers */
> -                      <0x20 0x00000000 0x0 0x00002000>; /* configuration=
 space */
> -                reg-names =3D "regs", "config";
> -                interrupts =3D <0 108 IRQ_TYPE_LEVEL_HIGH>; /* aer inter=
rupt */
> -                interrupt-names =3D "aer";
> -                #address-cells =3D <3>;
> -                #size-cells =3D <2>;
> -                device_type =3D "pci";
> -                dma-coherent;
> -                num-viewport =3D <256>;
> -                bus-range =3D <0x0 0xff>;
> -                ranges =3D <0x81000000 0x0 0x00000000 0x20 0x00010000 0x=
0 0x00010000   /* downstream I/O */
> -                          0x82000000 0x0 0x40000000 0x20 0x40000000 0x0 =
0x40000000>; /* non-prefetchable memory */
> -                msi-parent =3D <&its>;
> -                #interrupt-cells =3D <1>;
> -                interrupt-map-mask =3D <0 0 0 7>;
> -                interrupt-map =3D <0000 0 0 1 &gic 0 0 0 109 IRQ_TYPE_LE=
VEL_HIGH>,
> -                                <0000 0 0 2 &gic 0 0 0 110 IRQ_TYPE_LEVE=
L_HIGH>,
> -                                <0000 0 0 3 &gic 0 0 0 111 IRQ_TYPE_LEVE=
L_HIGH>,
> -                                <0000 0 0 4 &gic 0 0 0 112 IRQ_TYPE_LEVE=
L_HIGH>;
> -                iommu-map =3D <0 &smmu 0 1>; /* Fixed-up by bootloader */
> -        };
> --=20
> 2.34.1
>=20

--c8zVfnGHMbU1k5gA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcUq1wAKCRB4tDGHoIJi
0knIAP0conUEI0xDLtG5rFbTfR5akdlBa5fcql7l753maO/RkgEA3/RVZWkRFIjL
jUKzXUJfyP805/XgLtB8A25fFQ4x5Qg=
=5ziL
-----END PGP SIGNATURE-----

--c8zVfnGHMbU1k5gA--

