Return-Path: <linux-pci+bounces-4457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6613387084C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 18:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB16CB2184C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 17:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2B0612E3;
	Mon,  4 Mar 2024 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gc1pVrP6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72C660263;
	Mon,  4 Mar 2024 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573527; cv=none; b=VG+0GpTEFCgWFRQbYrR3W+rLHwrbbcMSuQ93hUFvP/k7ms2V3oRkOQFUiL6t0M/WXzeyqSnJ8EgKToWCsGNPMWyT1+GjH1dGpalhsIO3roDtqeOjdycdneeqZlw5NBypv+6ZInjLp3fWEP5CXzGPsyhaTG3yc9l/hK51tTzG5k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573527; c=relaxed/simple;
	bh=38e2oSmYkFdfqVimVr3SP98oCdN93ZviMVDXcyH3WtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3EiqVHUZiSj1+tfmaWqb8eey/F+TPa3fBJ/uUa4S5I9FoKuPhBEDj/zucgXogrbwV0RUTULe5oLRyHLrglWYye2mxyJr5X3MnbA+TDNtaRuyUdyDR32KpWwK1uwUjQqgBtMHIQNlgrcyx/WEo+PrpLhTGqFPNo57uz05LXGigQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gc1pVrP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C43C433F1;
	Mon,  4 Mar 2024 17:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709573527;
	bh=38e2oSmYkFdfqVimVr3SP98oCdN93ZviMVDXcyH3WtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gc1pVrP6KQdsSgPjjpLrVbzKlT1v6Hz4ZgrBMyz6huI7e9rAewfHUO4Pcz8oi96j+
	 OIBxQvQR7AesDOpCqJB9uaEsOhWDAtjFH7AUOmUsnaRUYff0AMXLOOxwZvKgho/fuv
	 HTLoEwBaUJ5ltgHVbf9IZVNBowqrrCuQdmZu7sAdxL7YJprP82jxWnqqSiL1Wf4N/8
	 EGVVTOAe7pwT0qDpx5jobMeU3F53WVE/UzcdlIJJNGQETdrxqm2syjP5xAN7fa4fLM
	 J2p8E1DUuyx+DUVkiJ4Fy91Q8R93KAkq+NX8z3uSF03k5rBKoditoMajnPczP2n5HZ
	 2aFd3e31vrG4w==
Date: Mon, 4 Mar 2024 11:32:04 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: conor@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, helgaas@kernel.org, imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: pci: layerscape-pci: Convert to yaml
 format
Message-ID: <20240304173204.GA777171-robh@kernel.org>
References: <20240301162741.765524-1-Frank.Li@nxp.com>
 <20240301162741.765524-2-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301162741.765524-2-Frank.Li@nxp.com>

On Fri, Mar 01, 2024 at 11:27:39AM -0500, Frank Li wrote:
> Split layerscape-pci.txt into two yaml files: fsl,layerscape-pcie-ep.yaml
> and fsl,layerscape-pcie.yaml.
> yaml files contain the same content as the original txt file.
> 
> Do below changes to pass dtb_binding check:
> - Remove dma-coherent and fsl,pcie-scfg because not every SOC need it.

You mean 'remove from required' right? Because they are still here.

> - Set unevaluatedProperties to true in fsl,layerscape-pcie.yaml.

Sorry, but that's not acceptable either. You need the $ref's in this 
patch.

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/pci/fsl,layerscape-pcie-ep.yaml  |  87 +++++++++++++
>  .../bindings/pci/fsl,layerscape-pcie.yaml     | 121 ++++++++++++++++++
>  .../bindings/pci/layerscape-pci.txt           |  79 ------------
>  3 files changed, 208 insertions(+), 79 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> new file mode 100644
> index 0000000000000..cf517e4e46a33
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Layerscape PCIe Root Complex(RC) controller
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description:
> +  This PCIe RC controller is based on the Synopsys DesignWare PCIe IP
> +  and thus inherits all the common properties defined in snps,dw-pcie.yaml.
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
> +          - fsl,ls1028a-pcie-ep
> +          - fsl,ls2046a-pcie-ep
> +          - fsl,ls2088a-pcie-ep
> +          - fsl,ls1046a-pcie-ep
> +          - fsl,ls1043a-pcie-ep
> +          - fsl,ls1012a-pcie-ep
> +          - fsl,lx2160ar2-pcie-ep
> +      - const: fsl,ls-pcie-ep
> +
> +  reg:
> +    description: base addresses and lengths of the PCIe controller register blocks.

You need to define how many entries and what they are.

Missing 'reg-names'?

> +
> +  interrupts:
> +    description: A list of interrupt outputs of the controller. Must contain an
> +      entry for each entry in the interrupt-names property.

You need to define how many entries and what they are.

> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 3
> +    description: It could include the following entries.
> +    items:
> +      oneOf:
> +        - description:
> +            Used for interrupt line which reports AER events when
> +            non MSI/MSI-X/INTx mode is used.
> +          const: aer
> +        - description:
> +            Used for interrupt line which reports PME events when
> +            non MSI/MSI-X/INTx mode is used.
> +          const: pme
> +        - description:
> +            Used for SoCs(like ls2080a, lx2160a, ls2080a, ls2088a, ls1088a)
> +            which has a single interrupt line for miscellaneous controller
> +            events(could include AER and PME events).
> +          const: intr

The way this works is the common schema defines all possible names. This 
schema needs to define how many entries, which names you use, and what 
is the order. So you need to add 'pme' and 'aer' to 
snps,dw-pcie-ep.yaml. 

I imagine the order of entries is a mess here, and I don't expect 
there's any new Layerscape platforms coming. So this binding can just 
say:

minItems: 1
maxItems: 3
items:
  enum: [ aer, pme, intr ]

> +
> +  fsl,pcie-scfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Must include two entries.
> +      The first entry must be a link to the SCFG device node
> +      The second entry is the physical PCIe controller index starting from '0'.
> +      This is used to get SCFG PEXN registers
> +
> +  dma-coherent:
> +    description: Indicates that the hardware IP block can ensure the coherency
> +      of the data transferred from/to the IP block. This can avoid the software
> +      cache flush/invalid actions, and improve the performance significantly

Already listed in the common schema, so you can drop.

> +
> +  big-endian:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: If the PEX_LUT and PF register block is in big-endian, specify
> +      this property.
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-names
> +
> diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> new file mode 100644
> index 0000000000000..3f2d058701d22
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> @@ -0,0 +1,121 @@
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
> +  and thus inherits all the common properties defined in snps,dw-pcie.yaml.
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
> +    description: base addresses and lengths of the PCIe controller register blocks.

You need to define how many entries and what they are.


> +
> +  interrupts:
> +    description: A list of interrupt outputs of the controller. Must contain an
> +      entry for each entry in the interrupt-names property.

You need to define how many entries and what they are.

> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 3
> +    description: It could include the following entries.
> +    items:
> +      oneOf:
> +        - description:
> +            Used for interrupt line which reports AER events when
> +            non MSI/MSI-X/INTx mode is used.
> +          const: aer
> +        - description:
> +            Used for interrupt line which reports PME events when
> +            non MSI/MSI-X/INTx mode is used.
> +          const: pme
> +        - description:
> +            Used for SoCs(like ls2080a, lx2160a, ls2080a, ls2088a, ls1088a)
> +            which has a single interrupt line for miscellaneous controller
> +            events(could include AER and PME events).
> +          const: intr

Similar comment here, but the names are already defined in 
snps,dw-pcie.yaml.

> +
> +  fsl,pcie-scfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Must include two entries.
> +      The first entry must be a link to the SCFG device node
> +      The second entry is the physical PCIe controller index starting from '0'.
> +      This is used to get SCFG PEXN registers
> +
> +  dma-coherent:
> +    description: Indicates that the hardware IP block can ensure the coherency
> +      of the data transferred from/to the IP block. This can avoid the software
> +      cache flush/invalid actions, and improve the performance significantly

Drop

> +
> +  big-endian:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: If the PEX_LUT and PF register block is in big-endian, specify
> +      this property.
> +
> +unevaluatedProperties: true
> +
> +required:

> +  - compatible
> +  - reg

Both required in common schema. Drop.

> +  - interrupt-names
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

