Return-Path: <linux-pci+bounces-11553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F4194D625
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 20:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BDD5B20BE6
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 18:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B2014659F;
	Fri,  9 Aug 2024 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPftGWCX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B467E4C634;
	Fri,  9 Aug 2024 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723227243; cv=none; b=EtUOXzVPw15RZfM257mkHPph261SqfCH2FqobwMLpjlwPoC26cgVd5X8CMDt0I6b58uMaI8badFUYr1p/YzSEM2J/NzmSRmw9orzCKBrACIArNS5T8jnXirQ87uNEO2VDMv+6HC1a8LyrxLNTNEBJl6CpYflBSGLTq100rmyJgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723227243; c=relaxed/simple;
	bh=juuKC2o1X97/NQLMvh4+TQj21ZK6EXnrcksM+JTcSqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UARHQyfGF7awZVELh7QkEs+cMpckzF0RgHtgweKvpgmj7O3+HJITS1Aq7Sw0fSDTpJNUArF2pkzwTqVNb9uoyAXBdzBOl6L9NYsDjixWLOAZXa8h34Ee3ygOu1T57l4NYch8zs46adibU1MwM1upV6psHlYAuUyCA+XDU9WRGHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPftGWCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AF3C32782;
	Fri,  9 Aug 2024 18:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723227243;
	bh=juuKC2o1X97/NQLMvh4+TQj21ZK6EXnrcksM+JTcSqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GPftGWCXsvvQaJqheHBaCHbq5XVBU6HeimghKaJ2iNA5kVi1kaHJx6DkUnzca5SvT
	 9fSfa13ryx/buk6yUaL2Tk/OXfqXzXTsy/WlwLJ0m0nffLIaqmhUh8dcXqAidwBmjJ
	 h+MNeqy+wLb9m//0Y9PsQGMZTwZutjgtOSp0RwBsk/VxjpB845IIgOj85ybmAY0rLJ
	 c9hoSsVo1sE0hmb+iSJlu9jh/5KJsTXC1RlLHROKW74Fr6DukqNFt/LEoKLXhroJCe
	 qQvOaVy4sNWt7XOjuVqqZwOs3w1hGN7Aeg7aTYh7h6UGyTvTHdxdIF26nWn5bcAMC7
	 F9ABMFjuXKLWw==
Date: Fri, 9 Aug 2024 12:14:01 -0600
From: Rob Herring <robh@kernel.org>
To: matthew.gerlach@linux.intel.com
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, dinguyen@kernel.org,
	joyce.ooi@intel.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: PCI: altera: Convert to YAML
Message-ID: <20240809181401.GA973841-robh@kernel.org>
References: <20240809151213.94533-1-matthew.gerlach@linux.intel.com>
 <20240809151213.94533-2-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809151213.94533-2-matthew.gerlach@linux.intel.com>

On Fri, Aug 09, 2024 at 10:12:07AM -0500, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Convert the device tree bindings for the Altera Root Port PCIe controller
> from text to YAML. Update the entries in the interrupt-map field to have
> the correct number of address cells for the interrupt parent.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> v8:

v2 or v8 or ??? I'm confused and tools will be too.

>  - Precisely constrain the number of items for reg and reg-names properties.
>    Constrain maxItems to 2 for altr,pcie-root-port-1.0.
>    Constrain minItems to 3 for altr,pcie-root-port-2.0.
> 
> v7:
>  - Keep original example dts, but fix warnings of interrupt-map field.
> 
> v6:
>  - Fix dt_binding_check warnings by creating interrupt-controller subnode
>    and fixing interrupt-map.
>  - Updated filename in MAINTAINERS.
> 
> v5:
>  - add interrupt-controller #interrupt-cells to required field
>  - don't touch original example dts
> 
> v4:
>  - reorder reg-names to match original binding
>  - move reg and reg-names to top level with limits.
> 
> v3:
>  - Added years to copyright
>  - Correct order in file of allOf and unevaluatedProperties
>  - remove items: in compatible field
>  - fix reg and reg-names constraints
>  - replace deprecated pci-bus.yaml with pci-host-bridge.yaml
>  - fix entries in ranges property
>  - remove device_type from required
> 
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
>  .../devicetree/bindings/pci/altera-pcie.txt   |  50 --------
>  .../bindings/pci/altr,pcie-root-port.yaml     | 114 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 115 insertions(+), 51 deletions(-)
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
> index 000000000000..52533fccc134
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
> @@ -0,0 +1,114 @@
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
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - altr,pcie-root-port-1.0
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 2
> +
> +        reg-names:
> +          maxItems: 2
> +
> +    else:
> +      properties:
> +        reg:
> +          minItems: 3
> +
> +        reg-names:
> +          minItems: 3
> +
> +
> +unevaluatedProperties: false
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
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +        bus-range = <0x0 0xff>;
> +        device_type = "pci";
> +        msi-parent = <&msi_to_gic_gen_0>;
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        interrupt-map-mask = <0 0 0 7>;
> +        interrupt-map = <0 0 0 1 &pcie_0 0 0 0 1>,
> +                        <0 0 0 2 &pcie_0 0 0 0 2>,
> +                        <0 0 0 3 &pcie_0 0 0 0 3>,
> +                        <0 0 0 4 &pcie_0 0 0 0 4>;
> +        ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000>,
> +                 <0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1e71f97fb674..53f239114400 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17435,7 +17435,7 @@ PCI DRIVER FOR ALTERA PCIE IP
>  M:	Joyce Ooi <joyce.ooi@intel.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
> -F:	Documentation/devicetree/bindings/pci/altera-pcie.txt
> +F:	Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
>  F:	drivers/pci/controller/pcie-altera.c
>  
>  PCI DRIVER FOR APPLIEDMICRO XGENE
> -- 
> 2.34.1
> 

