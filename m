Return-Path: <linux-pci+bounces-3881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC37D8601A6
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 19:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44040285491
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 18:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3274914263B;
	Thu, 22 Feb 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5mJCdFR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FCA1EB3A;
	Thu, 22 Feb 2024 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626676; cv=none; b=NXhCotJOl9Bpp82iYQ229hE+2ONyhQy8h8hwhc19UkKTQRV+UEjp21tE0ltEcLDtAX1N6VgQpsFb9Xb49b3ckBTPHeuOK704Blsnd9zmZ3rWy13c/qSrzw0nXpX0NQv5JKewXEwLVflJIyPdAA31Vc3TMIwlw1jufgMG25BvH1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626676; c=relaxed/simple;
	bh=zSwQ+29IemVAKsJR/QppCLHoxlyDpZ3/5G5UcwkHZ9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5EERpoXSnu6WH/0t/5cILyXA9LWnqIUW3sCK/kZQqStzJ7iDK3v6QmWUfiJN6VFdjkJd/+Vhx3wSmwqrD+fo2/3/kv7qx6jygK0azaVo7tI1TxzBNhZ5Nb74i2PHtUVNbQNSNIK3IpTHIqWS09H2OS0f+YnxoSG4QeWyGEl5IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5mJCdFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217C8C433F1;
	Thu, 22 Feb 2024 18:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708626675;
	bh=zSwQ+29IemVAKsJR/QppCLHoxlyDpZ3/5G5UcwkHZ9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E5mJCdFRarCvwy2IdOpt8oKhCoNcJU6+NxrAr098IA9x0H1YS/hyHxGAJdfAUzVGl
	 lWAZjQy9ortegc+W3weeRlrky15kfRe/B9oks65Pld3RIHeWTeywjg24LpRHvC3nVh
	 eBvV1quVZX0Aq3tes6jTO3Nw6ztMXdEtIjhPd0pWAiiht2jOMc1bl4fmihOveKQhbT
	 NNTIKf/YD+VQswufCEHRC9RDUfQE1xc2nbz92py0VSYeQsPhnYzDEb6yQtdE1xbMSi
	 aU/xVu+7FJhfTW4zUobEv13BOM+k7j8gc3v2sg/jSujXtaFJkPHb2VX5Qi58cV6FQd
	 XIA5nvee7DJ0A==
Date: Thu, 22 Feb 2024 12:30:48 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: pci: layerscape-pci: Convert to yaml
 format
Message-ID: <20240222183048.GA3652979-robh@kernel.org>
References: <20240214194145.2669744-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214194145.2669744-1-Frank.Li@nxp.com>

On Wed, Feb 14, 2024 at 02:41:44PM -0500, Frank Li wrote:
> Convert the layerscape-pci PCIe binding document to yaml format.
> 
> Additionally, changes for the layerscape-pci endpoint part:
> - Add interrupt name 'pme' restriction for fsl,ls1028a-pcie-ep,
> fsl,ls1046a-pcie-ep, and fsl,ls1088a-pcie-ep.
> - Add register name restrictions: 'reg' and 'addr_space'. 'addr_space' is
> required by snps,dw-pcie-ep.
> - Add an example.
> 
> Changes for the layerscape-pci root complex part:
> - Add required property: 'reg-names', "#address-cells", "#size-cells",
> 'device_type', 'bus-range', 'ranges', "#interrupt-cells",
> 'interrupt-map-mask' and 'interrupt-map'.
> - Interrupt-names requirement split to each compatible string.
> - Add register name restrictions: 'reg' and 'config'. 'config' is required
> by snps,dw-pcie.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     There are log discuss at v1. If I missed something, let me know.
>     
>     Change from v2 to v3
>     - update commit message, show change compare txt file
>     - add failback compatible fsl,ls-pcie-ep.
>     - add commit message about 'addr_space' and 'config'.
>     
>     Change from v1 to v2
>     - remove '|-'
>     - dma-coherent: true
>     - add interrupts and interrupt-names at before Allof
>     - remove ref to snps,pcie*.yaml, some reg-names are not aligned with in
>     drivers
>     - Add an example for pcie-ep
> 
>  .../bindings/pci/fsl,layerscape-pcie-ep.yaml  | 110 +++++++++++
>  .../bindings/pci/fsl,layerscape-pcie.yaml     | 182 ++++++++++++++++++
>  .../bindings/pci/layerscape-pci.txt           |  79 --------
>  3 files changed, 292 insertions(+), 79 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> new file mode 100644
> index 0000000000000..b384a0b2fe22e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> @@ -0,0 +1,110 @@
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

Where's the reference to the DWC schema?

> +
> +  This controller derives its clocks from the Reset Configuration Word (RCW)
> +  which is used to describe the PLL settings at the time of chip-reset.
> +
> +  Also as per the available Reference Manuals, there is no specific 'version'
> +  register available in the Freescale PCIe controller register set,
> +  which can allow determining the underlying DesignWare PCIe controller version
> +  information.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - fsl,ls2088a-pcie-ep
> +          - fsl,ls1088a-pcie-ep
> +          - fsl,ls1046a-pcie-ep
> +          - fsl,ls1028a-pcie-ep
> +          - fsl,lx2160ar2-pcie-ep
> +      - const: fsl,ls-pcie-ep
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
> +    description: A phandle to the SCFG device node. The second entry is the
> +      physical PCIe controller index starting from '0'. This is used to get
> +      SCFG PEXN registers.
> +
> +  big-endian:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: If the PEX_LUT and PF register block is in big-endian, specify
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
> +    oneOf:
> +      - anyOf:
> +          - const: pme
> +          - const: aer
> +      - const: intr
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
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
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      pcie_ep1: pcie-ep@3400000 {
> +        compatible = "fsl,ls1028a-pcie-ep", "fsl,ls-pcie-ep";
> +        reg = <0x00 0x03400000 0x0 0x00100000
> +              0x80 0x00000000 0x8 0x00000000>;
> +        reg-names = "regs", "addr_space";
> +        interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
> +        interrupt-names = "pme";

> +        num-ib-windows = <6>;
> +        num-ob-windows = <8>;

Not documented and deprecated.

> +        status = "disabled";

Examples should be enabled.

> +      };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> new file mode 100644
> index 0000000000000..988929729580a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> @@ -0,0 +1,182 @@
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
> +  This controller derives its clocks from the Reset Configuration Word (RCW)
> +  which is used to describe the PLL settings at the time of chip-reset.
> +
> +  Also as per the available Reference Manuals, there is no specific 'version'
> +  register available in the Freescale PCIe controller register set,
> +  which can allow determining the underlying DesignWare PCIe controller version
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
> +    description: A phandle to the SCFG device node. The second entry is the
> +      physical PCIe controller index starting from '0'. This is used to get
> +      SCFG PEXN registers.
> +
> +  big-endian:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: If the PEX_LUT and PF register block is in big-endian, specify
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
> +    maxItems: 3
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 3
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - "#address-cells"
> +  - "#size-cells"
> +  - device_type
> +  - bus-range

This should never be required unless you have some restriction in the 
h/w. DWC generally doesn't.

> +  - ranges
> +  - interrupts
> +  - interrupt-names
> +  - "#interrupt-cells"
> +  - interrupt-map-mask
> +  - interrupt-map

The common PCI and DWC schemas already make most of these required, so 
you don't need to here.

> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,lx2160a-pcie
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 2
> +        interrupt-names:
> +          items:
> +            - const: pme
> +            - const: aer
> +            - const: intr
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
> +            - fsl,ls1021a-pcie
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
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      pcie@3400000 {
> +        compatible = "fsl,ls1088a-pcie";
> +        reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
> +            <0x20 0x00000000 0x0 0x00002000>; /* configuration space */
> +        reg-names = "regs", "config";
> +        interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
> +        interrupt-names = "aer";
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        dma-coherent;
> +        device_type = "pci";
> +        bus-range = <0x0 0xff>;
> +        ranges = <0x81000000 0x0 0x00000000 0x20 0x00010000 0x0 0x00010000   /* downstream I/O */
> +                 0x82000000 0x0 0x40000000 0x20 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +        msi-parent = <&its>;
> +        #interrupt-cells = <1>;
> +        interrupt-map-mask = <0 0 0 7>;
> +        interrupt-map = <0000 0 0 1 &gic 0 0 0 109 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0000 0 0 2 &gic 0 0 0 110 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0000 0 0 3 &gic 0 0 0 111 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0000 0 0 4 &gic 0 0 0 112 IRQ_TYPE_LEVEL_HIGH>;
> +        iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
> +      };
> +    };
> +...

