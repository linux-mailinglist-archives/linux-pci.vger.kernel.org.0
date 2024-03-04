Return-Path: <linux-pci+bounces-4468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D13F87096F
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 19:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00ADE1C2369B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 18:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC130626A3;
	Mon,  4 Mar 2024 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMzs3NY+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC1E62173;
	Mon,  4 Mar 2024 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576452; cv=none; b=o7OWNz5gpk5TXAk2WdYMUcoWZtk2IJgthfrm/JqK3goSOmv1KilU9la2nSYWCXV7M65bHFFh8+GB6Rv7cwQA/cur2qTjpa2AhNi7g4nbZ9TA01dWsnl7YKqOPussX+o8QqVSuEllzDhkQwG7V98YImdBk0FK5Pn7/xCdsdMjvNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576452; c=relaxed/simple;
	bh=YXM5oCMz28C86WmjPKbShmnca1a3wsdAwblQgGM5f0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEujjbn9Z0Eml/2oC6QKIAHCy7khAlg9q1UXCqEg/zkDm96uzizqYPWSm58WejNDCh4tNDgZuGo/aYeFtXfrBJEMFAFmGjmEbVrwunvWF+Z0HH0Mqbz4a60Bf9D76429wyjXPN7QyvH7b7tyDZvsrgEx58HWnPvaE4Rsh3iVt3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMzs3NY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5750C433F1;
	Mon,  4 Mar 2024 18:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709576452;
	bh=YXM5oCMz28C86WmjPKbShmnca1a3wsdAwblQgGM5f0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AMzs3NY+JwcmzkeQkGPaejTJqJqe5wvmw6vhiIk3nlTajvhBCt0vdEMPyISAYXb8a
	 ABph5Yev7uUOSqswJd6hvJAsPqNaNoXADd38NyhXGs+2erk0QJQJ1dn1peFwr93Tgc
	 DzjyWzwFzMmsrwYXjMZXbstlFjdU+2sSVw9afkWBMpJUyB7/QS+Mqc53ctqsZBoPP3
	 m1DMrUfTFxzLPB/3RctgExmc72kkrPPdYQMObod3YLE2U/qMEoB2TG2sdRj27cnMfG
	 AP2chQrtN6o1nbL36n/BHhMok668o5PxyNeF7I77meO3cOEdSRjfISJX2xAeoebgjh
	 ms1HtxIi8+Zyg==
Date: Mon, 4 Mar 2024 12:20:49 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: conor@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, helgaas@kernel.org, imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org
Subject: Re: [PATCH v6 3/3] dt-bindings: pci: layerscape-pci-ep: Add
 snps,dw-pcie-ep.yaml reference
Message-ID: <20240304182049.GA851904-robh@kernel.org>
References: <20240301162741.765524-1-Frank.Li@nxp.com>
 <20240301162741.765524-4-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301162741.765524-4-Frank.Li@nxp.com>

On Fri, Mar 01, 2024 at 11:27:41AM -0500, Frank Li wrote:
> Add snps,dw-pcie-ep.yaml.
> 
> Remove context that exist in snps,dw-pcie-ep.yaml.
> 
> Add an example for pcie-ep.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/pci/fsl,layerscape-pcie-ep.yaml  | 54 ++++++++++---------
>  1 file changed, 29 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> index cf517e4e46a33..07965683beece 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> @@ -10,8 +10,7 @@ maintainers:
>    - Frank Li <Frank.Li@nxp.com>
>  
>  description:
> -  This PCIe RC controller is based on the Synopsys DesignWare PCIe IP
> -  and thus inherits all the common properties defined in snps,dw-pcie.yaml.
> +  This PCIe RC controller is based on the Synopsys DesignWare PCIe IP.
>  
>    This controller derives its clocks from the Reset Configuration Word (RCW)
>    which is used to describe the PLL settings at the time of chip-reset.
> @@ -35,31 +34,18 @@ properties:
>        - const: fsl,ls-pcie-ep
>  
>    reg:
> -    description: base addresses and lengths of the PCIe controller register blocks.
> +    maxItems: 2
> +
> +  reg-names:
> +    maxItems: 2
>  
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
> @@ -68,10 +54,7 @@ properties:
>        The second entry is the physical PCIe controller index starting from '0'.
>        This is used to get SCFG PEXN registers
>  
> -  dma-coherent:
> -    description: Indicates that the hardware IP block can ensure the coherency
> -      of the data transferred from/to the IP block. This can avoid the software
> -      cache flush/invalid actions, and improve the performance significantly
> +  dma-coherent: true
>  
>    big-endian:
>      $ref: /schemas/types.yaml#/definitions/flag
> @@ -85,3 +68,24 @@ required:
>    - reg
>    - interrupt-names
>  
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      pcie-ep@3400000 {
> +        compatible = "fsl,ls1028a-pcie-ep", "fsl,ls-pcie-ep";
> +        reg = <0x00 0x03400000 0x0 0x00100000
> +              0x80 0x00000000 0x8 0x00000000>;
> +        reg-names = "dbi", "addr_space";
> +        interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */

PME or...

> +        interrupt-names = "app";

app? You seem to just be changing the names to make the example happy. 
What do the dts files have? You need to make those pass.

Rob

