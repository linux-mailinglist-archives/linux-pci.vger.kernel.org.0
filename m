Return-Path: <linux-pci+bounces-6053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F0589FE8C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 19:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07E71F242EE
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 17:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F0F17BB11;
	Wed, 10 Apr 2024 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELJtWoV/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56E53EA69;
	Wed, 10 Apr 2024 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770322; cv=none; b=pj8i6NTwpRz21cSvIDvWRmoi60O70T3veJQYbh3uFzlA1TziwemzhEySWKogme7pKA8MwpgTTLn1kMbqf5tgAiDgK/+V+wDJ0NB4BydfAW8tPenskKy28jnnWvpM/md6fVLMYZlbc674Zv0ToFDwAtEocRJ+pgDe+e3oMoPdkWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770322; c=relaxed/simple;
	bh=WLlddfp2+ZgiviFBbFbot52MremZ90azsOwdk9ybE0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCm79jL5wFIGzZQmVlTBqusrIwUB+GzyRWG5yHl7SuVLFU8MzOStynYju4GimAcYCY3ESue5eAB/bQ/EokkaKbDFnXNGDwH5PSR4KfAVYevLKMb3xXZruFXLYvvI/sdWOqr9FUeIsAuQNDrZlyfbDRMLOxu2/pnkwF8NjgnJpIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELJtWoV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDF9C433F1;
	Wed, 10 Apr 2024 17:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712770321;
	bh=WLlddfp2+ZgiviFBbFbot52MremZ90azsOwdk9ybE0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ELJtWoV/Y36h5tXrUe6/rj19IYt0LypzyGhqI+vvVHOeHEaQ8LCVFGgi/hhb+CMUx
	 /sGdSD2ND5S8HGawQtQqa8HOrYlRG9o7dQ6iT7T5elxPo8+6gMC/SptqCBppGbFlZj
	 ZRd8hv1xDoKg2jYQIPOWlg7TbgSNHSSxky30KnqjsNdZwPXVNZA0O0Xa0+44h6INtU
	 uSFxSZvRJ+wc9JcHYl9sgf3FHYmLypmtS/ybizS77bBMKk0cmOCsr+Q/crbVo4v+Sk
	 nyyZNSLhM+lG/zRPu+Pr4zA28EogSTPk/R9NUrhm11lryT7AshkFTjz/JzzaPLHvDK
	 NVuOGiiL38UVg==
Date: Wed, 10 Apr 2024 12:31:59 -0500
From: Rob Herring <robh@kernel.org>
To: matthew.gerlach@linux.intel.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: PCI: altera: Convert to YAML
Message-ID: <20240410173159.GA733161-robh@kernel.org>
References: <20240405145322.3805828-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405145322.3805828-1-matthew.gerlach@linux.intel.com>

On Fri, Apr 05, 2024 at 09:53:22AM -0500, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Convert the device tree bindings for the Altera Root Port PCIe controller
> from text to YAML.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v2:
>  - Move allOf: to bottom of file, just like example-schema is showing
>  - add constraint for reg and reg-names
>  - remove unneeded device_type
>  - drop #address-cells and #size-cells
>  - change minItems to maxItems for interrupts:
>  - change msi-parent to just "msi-parent: true"
>  - cleaned up required:
>  - make subject consistent with other commits coverting to YAML
>  - s/overt/onvert/g
> ---
>  .../devicetree/bindings/pci/altera-pcie.txt   |  50 ---------
>  .../bindings/pci/altr,pcie-root-port.yaml     | 106 ++++++++++++++++++
>  2 files changed, 106 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/altera-pcie.txt b/Documentation/devicetree/bindings/pci/altera-pcie.txt
> deleted file mode 100644
> index 816b244a221e..000000000000
> --- a/Documentation/devicetree/bindings/pci/altera-pcie.txt
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -* Altera PCIe controller
> -
> -Required properties:
> -- compatible :	should contain "altr,pcie-root-port-1.0" or "altr,pcie-root-port-2.0"
> -- reg:		a list of physical base address and length for TXS and CRA.
> -		For "altr,pcie-root-port-2.0", additional HIP base address and length.
> -- reg-names:	must include the following entries:
> -		"Txs": TX slave port region
> -		"Cra": Control register access region
> -		"Hip": Hard IP region (if "altr,pcie-root-port-2.0")
> -- interrupts:	specifies the interrupt source of the parent interrupt
> -		controller.  The format of the interrupt specifier depends
> -		on the parent interrupt controller.
> -- device_type:	must be "pci"
> -- #address-cells:	set to <3>
> -- #size-cells:		set to <2>
> -- #interrupt-cells:	set to <1>
> -- ranges:	describes the translation of addresses for root ports and
> -		standard PCI regions.
> -- interrupt-map-mask and interrupt-map: standard PCI properties to define the
> -		mapping of the PCIe interface to interrupt numbers.
> -
> -Optional properties:
> -- msi-parent:	Link to the hardware entity that serves as the MSI controller
> -		for this PCIe controller.
> -- bus-range:	PCI bus numbers covered
> -
> -Example
> -	pcie_0: pcie@c00000000 {
> -		compatible = "altr,pcie-root-port-1.0";
> -		reg = <0xc0000000 0x20000000>,
> -			<0xff220000 0x00004000>;
> -		reg-names = "Txs", "Cra";
> -		interrupt-parent = <&hps_0_arm_gic_0>;
> -		interrupts = <0 40 4>;
> -		interrupt-controller;
> -		#interrupt-cells = <1>;
> -		bus-range = <0x0 0xFF>;
> -		device_type = "pci";
> -		msi-parent = <&msi_to_gic_gen_0>;
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		interrupt-map-mask = <0 0 0 7>;
> -		interrupt-map = <0 0 0 1 &pcie_0 1>,
> -			            <0 0 0 2 &pcie_0 2>,
> -			            <0 0 0 3 &pcie_0 3>,
> -			            <0 0 0 4 &pcie_0 4>;
> -		ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000
> -			  0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
> -	};
> diff --git a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
> new file mode 100644
> index 000000000000..999dcda05f55
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2024, Intel Corporation
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
> +    items:
> +      - enum:
> +          - altr,pcie-root-port-1.0
> +          - altr,pcie-root-port-2.0
> +
> +  interrupts:
> +    maxItems: 1
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

Already defined in the common schema, drop.

> +
> +  msi-parent: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - device_type

Drop.

> +  - interrupts
> +  - interrupt-map
> +  - interrupt-map-mask
> +
> +unevaluatedProperties: false
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - altr,pcie-root-port-1.0
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: TX slave port region
> +            - description: Control register access region
> +
> +        reg-names:
> +          items:
> +            - const: Txs
> +            - const: Cra
> +
> +    else:
> +      properties:
> +        reg:
> +          items:
> +            - description: Hard IP region
> +            - description: TX slave port region
> +            - description: Control register access region
> +
> +        reg-names:
> +          items:
> +            - const: Hip
> +            - const: Txs
> +            - const: Cra
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    pcie_0: pcie@c00000000 {
> +        compatible = "altr,pcie-root-port-1.0";
> +        reg = <0xc0000000 0x20000000>,
> +              <0xff220000 0x00004000>;
> +        reg-names = "Txs", "Cra";
> +        interrupt-parent = <&hps_0_arm_gic_0>;
> +        interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> +        #interrupt-cells = <1>;
> +        bus-range = <0x0 0xff>;
> +        device_type = "pci";
> +        msi-parent = <&msi_to_gic_gen_0>;
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        interrupt-map-mask = <0 0 0 7>;
> +        interrupt-map = <0 0 0 1 &pcie_intc 1>,
> +                        <0 0 0 2 &pcie_intc 2>,
> +                        <0 0 0 3 &pcie_intc 3>,
> +                        <0 0 0 4 &pcie_intc 4>;
> +        ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000
> +                  0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
> +    };
> -- 
> 2.34.1
> 

