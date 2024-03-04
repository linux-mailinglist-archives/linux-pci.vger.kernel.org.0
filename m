Return-Path: <linux-pci+bounces-4467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 803E5870958
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 19:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3D01F21F17
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 18:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E4762164;
	Mon,  4 Mar 2024 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcUGxUTM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4480160265;
	Mon,  4 Mar 2024 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576281; cv=none; b=WHm6bU5Sx57yoWAnEaq/WiPGIKNP0mx7R8tlTRPr5wiRkHApPuOZsWLLnIhK03/EPZN40BwoDsQNJuHgEZ3iPivkUIUPq3YbKQluQwWQ87S5Muka02PBRi6/t61i1ZMOFykG5mf+F7Eykj+D+6A0diYQ+lR7+z0ytG+D2lwvf1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576281; c=relaxed/simple;
	bh=MhVj6rlBDtv//G52D2MyGutBUo2/1sAyxm3U50UUn30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvgaD6iqmZNbEvsXzhEEkLB9IxDvQ7nE8c1YUMNOWLlR5t463NMpnr4Nqb2qKIGwEuR64fn5WJHfpfKG1yQgz4XoeNwfcg/sam435Xfuv/rf4wyu1DGFgjwbZjh3UeYVu62XR55geSxaaipDh9zV8/Ag8JAYjILeZkTLxieXuu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcUGxUTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2F3C433F1;
	Mon,  4 Mar 2024 18:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709576281;
	bh=MhVj6rlBDtv//G52D2MyGutBUo2/1sAyxm3U50UUn30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jcUGxUTMLrXoBlVWwpFwR2ePes5uBfgyy+Rb/TuNqh58LT77DJlq4X+AxNS+tn8Zh
	 gwhQXT5Lree2PNi5NHpENFpCK9KVdJrN3IXTGJ0LDF3G/nH4WFNJ7x0uB2rPTj69uz
	 xAcjEmYKnSuPqUVmBnb+q/l1wak3BTuxE4HkOHNJUcpmDizN2ezYC4VozhxnrfeNzR
	 V79/t4BCUW9wq576a9jq8CYmlvrlDjyw81et1/iHY8aLLIjqL8V03OycFd5g2rAcMr
	 X6aoJsIs1Iq+Pybu57C7GZA87n8VIzAciGeKsuk2Xs5f6SqUXET9HONdYkcI14657L
	 7xGDHB4z+VfkA==
Date: Mon, 4 Mar 2024 12:17:58 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: conor@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, helgaas@kernel.org, imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org
Subject: Re: [PATCH v6 2/3] dt-bindings: pci: layerscape-pci: Add
 snps,dw-pcie.yaml reference
Message-ID: <20240304181758.GA803086-robh@kernel.org>
References: <20240301162741.765524-1-Frank.Li@nxp.com>
 <20240301162741.765524-3-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301162741.765524-3-Frank.Li@nxp.com>

On Fri, Mar 01, 2024 at 11:27:40AM -0500, Frank Li wrote:
> Add snps,dw-pcie.yaml reference. Clean up all context that already exist in
> snps,dw-pcie.yaml. Update interrupt-names requirement for difference
> compatible string.
> 
> Set 'unevaluatedProperties' back to 'false'.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/pci/fsl,layerscape-pcie.yaml     | 104 +++++++++++++-----
>  1 file changed, 78 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> index 3f2d058701d22..137cc17933a4b 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> @@ -11,7 +11,6 @@ maintainers:
>  
>  description:
>    This PCIe RC controller is based on the Synopsys DesignWare PCIe IP
> -  and thus inherits all the common properties defined in snps,dw-pcie.yaml.
>  
>    This controller derives its clocks from the Reset Configuration Word (RCW)
>    which is used to describe the PLL settings at the time of chip-reset.
> @@ -36,31 +35,18 @@ properties:
>        - fsl,lx2160a-pcie
>  
>    reg:
> -    description: base addresses and lengths of the PCIe controller register blocks.
> +    maxItems: 2
> +
> +  reg-names:
> +    maxItems: 2

Need to define what the entries are. You change 'regs' to 'dbi' in the 
example. Was that an error in the example or are you planning on 
changing it in dts files? Besides the latter being an ABI change, I 
don't think you want to change dts files for platforms which are pretty 
stable.

>    interrupts:
> -    description: A list of interrupt outputs of the controller. Must contain an
> -      entry for each entry in the interrupt-names property.
> +    minItems: 1
> +    maxItems: 3
>  
>    interrupt-names:
>      minItems: 1
>      maxItems: 3
> -    description: It could include the following entries.
> -    items:
> -      oneOf:
> -        - description:
> -            Used for interrupt line which reports AER events when
> -            non MSI/MSI-X/INTx mode is used.
> -          const: aer
> -        - description:
> -            Used for interrupt line which reports PME events when
> -            non MSI/MSI-X/INTx mode is used.
> -          const: pme
> -        - description:
> -            Used for SoCs(like ls2080a, lx2160a, ls2080a, ls2088a, ls1088a)
> -            which has a single interrupt line for miscellaneous controller
> -            events(could include AER and PME events).
> -          const: intr
>  
>    fsl,pcie-scfg:
>      $ref: /schemas/types.yaml#/definitions/phandle
> @@ -69,23 +55,88 @@ properties:
>        The second entry is the physical PCIe controller index starting from '0'.
>        This is used to get SCFG PEXN registers
>  
> -  dma-coherent:
> -    description: Indicates that the hardware IP block can ensure the coherency
> -      of the data transferred from/to the IP block. This can avoid the software
> -      cache flush/invalid actions, and improve the performance significantly
> +  dma-coherent: true

No need to list.

> +
> +  msi-parent: true
> +
> +  iommu-map: true
>  
>    big-endian:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description: If the PEX_LUT and PF register block is in big-endian, specify
>        this property.
>  
> -unevaluatedProperties: true
> +unevaluatedProperties: false
>  
>  required:
>    - compatible
>    - reg
>    - interrupt-names
>  
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#

That's already referenced in the common schema.

> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,lx2160a-pcie
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 3

max is already 3.

minItems: 3

> +        interrupt-names:
> +          items:
> +            - const: pme
> +            - const: aer
> +            - const: intr

I guess since you figured out the ordering here, you should keep them 
despite what I said in the first patch.

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

minItems: 2
maxItems: 2

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
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -98,7 +149,7 @@ examples:
>          compatible = "fsl,ls1088a-pcie";
>          reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
>              <0x20 0x00000000 0x0 0x00002000>; /* configuration space */
> -        reg-names = "regs", "config";
> +        reg-names = "dbi", "config";
>          interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
>          interrupt-names = "aer";
>          #address-cells = <3>;
> @@ -116,6 +167,7 @@ examples:
>                          <0000 0 0 3 &gic 0 0 0 111 IRQ_TYPE_LEVEL_HIGH>,
>                          <0000 0 0 4 &gic 0 0 0 112 IRQ_TYPE_LEVEL_HIGH>;
>          iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
> +        msi-map = <0 &its 0 1>; /* Fixed-up by bootloader */
>        };
>      };
>  ...
> -- 
> 2.34.1
> 

