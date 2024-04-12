Return-Path: <linux-pci+bounces-6158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EB08A22C2
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 02:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B17F1C21041
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 00:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F61536C;
	Fri, 12 Apr 2024 00:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jshMclaE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F2E161;
	Fri, 12 Apr 2024 00:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712880296; cv=none; b=XRX0lwyHX+D9HzBxxCaIPgzNNLYxiJLFUjMvkUUA9I5DlQLskt+XLKbGVosOXnUngPpVFFroRnmhi1GezYkIrcLCj5h5dNOYt+AzhCrd+ThqUOYXUKLqankVV84iALTCPvbclYPuPYaA4h3BLJ6ZvHDjrji8WL7RrS1LjYWljjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712880296; c=relaxed/simple;
	bh=NyrufYflZQsz24CNEg+9x1m4HQeabvk+5HUYpQBPq/o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fPzrIH58nGv6rHewaHSjLfePUEAKwhbahfRY+CNbHLAq03TkK9nfXnbrHTQNr9Wunh2M8WA4Dk0/tpL1xjb+gUmvseR46Z9I9eMqC+F0F0HicNdbIraEtzIhZ9wRpdvzSaSrBqNBF2b8HStTB3HVbbXj1RfOe3+8XOTbYuCPeuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jshMclaE; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712880295; x=1744416295;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NyrufYflZQsz24CNEg+9x1m4HQeabvk+5HUYpQBPq/o=;
  b=jshMclaEUBPq7CSct1EUM02gO5DdbLyBWE/pn438Y1EDGzXm32njRGAN
   meeE4ZGeDD0SVrYVIHnDK+McV5qKeDPo5Kgj6rgCIMZ0yXDsa4zOe5grh
   Krqs+83g8+Ry+dcUrmuUf/dTLkgkTfT/x1NAvPdKx+pBR9jk6u55abLRg
   Qvq4lZXyTZOhYvYDeV5SBkN4NiLx97fIGmq87Mk4irfXYri1PZIPvgtYM
   b3meOLLMihPhPkRM3F3uWyX2oxMYK9Rk38juWjpIMMgmTpme4Jf6qpDqX
   BXbPUqaqf2LW23HN2Vh35ganr0l2euJFoR4ILv68bv6SbVP2wetVWY8kG
   A==;
X-CSE-ConnectionGUID: yCACObOFQeqUXOBmvx4k6w==
X-CSE-MsgGUID: VqSVflGyS8iyhzrvvmVfjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8882675"
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="8882675"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 17:04:54 -0700
X-CSE-ConnectionGUID: Pd9JT0nqS8Ssu3svs3QJ+A==
X-CSE-MsgGUID: b6R3xiLWSqWRpBNHhB1ZDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="21031337"
Received: from sj-4150-psse-sw-opae-dev2.sj.intel.com ([10.233.115.162])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 17:04:53 -0700
Date: Thu, 11 Apr 2024 17:04:52 -0700 (PDT)
From: matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@sj-4150-psse-sw-opae-dev2
To: Rob Herring <robh@kernel.org>
cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
    krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: PCI: altera: Convert to YAML
In-Reply-To: <20240410173159.GA733161-robh@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2404111700280.410528@sj-4150-psse-sw-opae-dev2>
References: <20240405145322.3805828-1-matthew.gerlach@linux.intel.com> <20240410173159.GA733161-robh@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Wed, 10 Apr 2024, Rob Herring wrote:

> On Fri, Apr 05, 2024 at 09:53:22AM -0500, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Convert the device tree bindings for the Altera Root Port PCIe controller
>> from text to YAML.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>> v2:
>>  - Move allOf: to bottom of file, just like example-schema is showing
>>  - add constraint for reg and reg-names
>>  - remove unneeded device_type
>>  - drop #address-cells and #size-cells
>>  - change minItems to maxItems for interrupts:
>>  - change msi-parent to just "msi-parent: true"
>>  - cleaned up required:
>>  - make subject consistent with other commits coverting to YAML
>>  - s/overt/onvert/g
>> ---
>>  .../devicetree/bindings/pci/altera-pcie.txt   |  50 ---------
>>  .../bindings/pci/altr,pcie-root-port.yaml     | 106 ++++++++++++++++++
>>  2 files changed, 106 insertions(+), 50 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
>>  create mode 100644 Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/altera-pcie.txt b/Documentation/devicetree/bindings/pci/altera-pcie.txt
>> deleted file mode 100644
>> index 816b244a221e..000000000000
>> --- a/Documentation/devicetree/bindings/pci/altera-pcie.txt
>> +++ /dev/null
>> @@ -1,50 +0,0 @@
>> -* Altera PCIe controller
>> -
>> -Required properties:
>> -- compatible :	should contain "altr,pcie-root-port-1.0" or "altr,pcie-root-port-2.0"
>> -- reg:		a list of physical base address and length for TXS and CRA.
>> -		For "altr,pcie-root-port-2.0", additional HIP base address and length.
>> -- reg-names:	must include the following entries:
>> -		"Txs": TX slave port region
>> -		"Cra": Control register access region
>> -		"Hip": Hard IP region (if "altr,pcie-root-port-2.0")
>> -- interrupts:	specifies the interrupt source of the parent interrupt
>> -		controller.  The format of the interrupt specifier depends
>> -		on the parent interrupt controller.
>> -- device_type:	must be "pci"
>> -- #address-cells:	set to <3>
>> -- #size-cells:		set to <2>
>> -- #interrupt-cells:	set to <1>
>> -- ranges:	describes the translation of addresses for root ports and
>> -		standard PCI regions.
>> -- interrupt-map-mask and interrupt-map: standard PCI properties to define the
>> -		mapping of the PCIe interface to interrupt numbers.
>> -
>> -Optional properties:
>> -- msi-parent:	Link to the hardware entity that serves as the MSI controller
>> -		for this PCIe controller.
>> -- bus-range:	PCI bus numbers covered
>> -
>> -Example
>> -	pcie_0: pcie@c00000000 {
>> -		compatible = "altr,pcie-root-port-1.0";
>> -		reg = <0xc0000000 0x20000000>,
>> -			<0xff220000 0x00004000>;
>> -		reg-names = "Txs", "Cra";
>> -		interrupt-parent = <&hps_0_arm_gic_0>;
>> -		interrupts = <0 40 4>;
>> -		interrupt-controller;
>> -		#interrupt-cells = <1>;
>> -		bus-range = <0x0 0xFF>;
>> -		device_type = "pci";
>> -		msi-parent = <&msi_to_gic_gen_0>;
>> -		#address-cells = <3>;
>> -		#size-cells = <2>;
>> -		interrupt-map-mask = <0 0 0 7>;
>> -		interrupt-map = <0 0 0 1 &pcie_0 1>,
>> -			            <0 0 0 2 &pcie_0 2>,
>> -			            <0 0 0 3 &pcie_0 3>,
>> -			            <0 0 0 4 &pcie_0 4>;
>> -		ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000
>> -			  0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
>> -	};
>> diff --git a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
>> new file mode 100644
>> index 000000000000..999dcda05f55
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
>> @@ -0,0 +1,106 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +# Copyright (C) 2024, Intel Corporation
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/altr,pcie-root-port.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Altera PCIe Root Port
>> +
>> +maintainers:
>> +  - Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - altr,pcie-root-port-1.0
>> +          - altr,pcie-root-port-2.0
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  interrupt-map-mask:
>> +    items:
>> +      - const: 0
>> +      - const: 0
>> +      - const: 0
>> +      - const: 7
>> +
>> +  interrupt-map:
>> +    maxItems: 4
>> +
>> +  "#interrupt-cells":
>> +    const: 1
>
> Already defined in the common schema, drop.

When I remove the lines above, "make dt_binding_check" gives me the 
warning, properties: '#interrupt-cells' is a dependency of 'interrupt-map'.

>
>> +
>> +  msi-parent: true
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - device_type
>
> Drop.

I will drop this in v3.

>
>> +  - interrupts
>> +  - interrupt-map
>> +  - interrupt-map-mask
>> +
>> +unevaluatedProperties: false
>> +
>> +allOf:
>> +  - $ref: /schemas/pci/pci-bus.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - altr,pcie-root-port-1.0
>> +    then:
>> +      properties:
>> +        reg:
>> +          items:
>> +            - description: TX slave port region
>> +            - description: Control register access region
>> +
>> +        reg-names:
>> +          items:
>> +            - const: Txs
>> +            - const: Cra
>> +
>> +    else:
>> +      properties:
>> +        reg:
>> +          items:
>> +            - description: Hard IP region
>> +            - description: TX slave port region
>> +            - description: Control register access region
>> +
>> +        reg-names:
>> +          items:
>> +            - const: Hip
>> +            - const: Txs
>> +            - const: Cra
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    pcie_0: pcie@c00000000 {
>> +        compatible = "altr,pcie-root-port-1.0";
>> +        reg = <0xc0000000 0x20000000>,
>> +              <0xff220000 0x00004000>;
>> +        reg-names = "Txs", "Cra";
>> +        interrupt-parent = <&hps_0_arm_gic_0>;
>> +        interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
>> +        #interrupt-cells = <1>;
>> +        bus-range = <0x0 0xff>;
>> +        device_type = "pci";
>> +        msi-parent = <&msi_to_gic_gen_0>;
>> +        #address-cells = <3>;
>> +        #size-cells = <2>;
>> +        interrupt-map-mask = <0 0 0 7>;
>> +        interrupt-map = <0 0 0 1 &pcie_intc 1>,
>> +                        <0 0 0 2 &pcie_intc 2>,
>> +                        <0 0 0 3 &pcie_intc 3>,
>> +                        <0 0 0 4 &pcie_intc 4>;
>> +        ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000
>> +                  0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
>> +    };
>> --
>> 2.34.1
>>
>

