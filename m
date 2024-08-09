Return-Path: <linux-pci+bounces-11557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF26194D682
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 20:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B9F1F22C38
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 18:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3A815921B;
	Fri,  9 Aug 2024 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l09XT3hV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A304F12C52E;
	Fri,  9 Aug 2024 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723228985; cv=none; b=JxzV/hCgCFbwcEcNz5DysNAY1wO2TAfkc5+UmUWe8b35BTQmN6n/On5iFKy6Yk3WfaS5P9tZjBXMWluhCcYmoeG3od7/aSRLnDrQb6zkrfrR2Dpmg8LgxC8Siew2gWyMY1UFhl7iQevqaA/B8W840E57TRPdU54paTpVS9x+Wrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723228985; c=relaxed/simple;
	bh=F8O9fNcSYO4qz1LsnVTOJbOetsfwTl/NnQqRqznPtk8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rbsa8ieUBeXon0b3VCrhyyfABu5ngMIAWKGa49yikpaXeoaoj5Nb6YUjLlMnclr8kK4luP3oXMnVEY7zJRLh81MGTkePXDqjW+97a21g+jgsrT0AKk3DvWwyvGWXVTwNemVfroq2wchMhuBUxo3DNDJauUruOA1gz0BLTiv/K5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l09XT3hV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723228984; x=1754764984;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=F8O9fNcSYO4qz1LsnVTOJbOetsfwTl/NnQqRqznPtk8=;
  b=l09XT3hV+LMZYSREkm/osLh9iAx/okJv47Uy1/tfy32fTv3egUVQAHkk
   zC2qrN2gySSRoNcgNZEuEltlshfa4HGg8oKRKqn175l2MywUqTq8AyM2b
   MiZFcuB2sxxz3TX6sTfSCeXbK4LpIJNcok+y8Gect9aHEepGXUkFOlhJV
   ogYhOO6u1mcc8x0Ztnf10VEvDb+UCQIG45XIUTWFSmXKFu3QktUChv8KG
   WA4/f/wtpVBm2p/uAgMyAq1ebS9/f3Lca2uD0CFU3A/XE/dzoOuRU1qqh
   jAJgQ3NVrRnpWW42ZOmytqLiVukqom0kuntntJeQEg54CdEIeRenuWFWz
   Q==;
X-CSE-ConnectionGUID: H3BuTkXGTCWY2k/8+eBnuQ==
X-CSE-MsgGUID: WTAuBVipTkS3R2C0LZP/Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="31991581"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="31991581"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 11:41:05 -0700
X-CSE-ConnectionGUID: 1/e1L5hlS7mZaJVYCHaZ9Q==
X-CSE-MsgGUID: NjQ9dNgTQ2qFbDoic/pd1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="57878076"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 11:41:05 -0700
Date: Fri, 9 Aug 2024 11:41:04 -0700 (PDT)
From: matthew.gerlach@linux.intel.com
To: Rob Herring <robh@kernel.org>
cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com, 
    krzk+dt@kernel.org, conor+dt@kernel.org, dinguyen@kernel.org, 
    joyce.ooi@intel.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: PCI: altera: Convert to YAML
In-Reply-To: <20240809181401.GA973841-robh@kernel.org>
Message-ID: <98185d65-805f-f09d-789-6eda61c4b36d@linux.intel.com>
References: <20240809151213.94533-1-matthew.gerlach@linux.intel.com> <20240809151213.94533-2-matthew.gerlach@linux.intel.com> <20240809181401.GA973841-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Fri, 9 Aug 2024, Rob Herring wrote:

> On Fri, Aug 09, 2024 at 10:12:07AM -0500, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Convert the device tree bindings for the Altera Root Port PCIe controller
>> from text to YAML. Update the entries in the interrupt-map field to have
>> the correct number of address cells for the interrupt parent.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>> v8:
>
> v2 or v8 or ??? I'm confused and tools will be too.

Sorry for the confusion. Patch 1 and patch 2 were individually reviewed 
previously. Patch 1 was previously reviewed up to v8, and I included them 
in the greater patch set for convience and completeness, and this is v2 of
the entire patch set.

How should this be handled for better clarity? Would it be better to not 
to include Patch 1 and 2 in the patch set and refer to them, or would it 
better to remove the history in patch 1 and 2, or something else?

Thanks,
Matthew Gerlach

>
>>  - Precisely constrain the number of items for reg and reg-names properties.
>>    Constrain maxItems to 2 for altr,pcie-root-port-1.0.
>>    Constrain minItems to 3 for altr,pcie-root-port-2.0.
>>
>> v7:
>>  - Keep original example dts, but fix warnings of interrupt-map field.
>>
>> v6:
>>  - Fix dt_binding_check warnings by creating interrupt-controller subnode
>>    and fixing interrupt-map.
>>  - Updated filename in MAINTAINERS.
>>
>> v5:
>>  - add interrupt-controller #interrupt-cells to required field
>>  - don't touch original example dts
>>
>> v4:
>>  - reorder reg-names to match original binding
>>  - move reg and reg-names to top level with limits.
>>
>> v3:
>>  - Added years to copyright
>>  - Correct order in file of allOf and unevaluatedProperties
>>  - remove items: in compatible field
>>  - fix reg and reg-names constraints
>>  - replace deprecated pci-bus.yaml with pci-host-bridge.yaml
>>  - fix entries in ranges property
>>  - remove device_type from required
>>
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
>>  .../devicetree/bindings/pci/altera-pcie.txt   |  50 --------
>>  .../bindings/pci/altr,pcie-root-port.yaml     | 114 ++++++++++++++++++
>>  MAINTAINERS                                   |   2 +-
>>  3 files changed, 115 insertions(+), 51 deletions(-)
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
>> index 000000000000..52533fccc134
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
>> @@ -0,0 +1,114 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +# Copyright (C) 2015, 2019, 2024, Intel Corporation
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
>> +    enum:
>> +      - altr,pcie-root-port-1.0
>> +      - altr,pcie-root-port-2.0
>> +
>> +  reg:
>> +    items:
>> +      - description: TX slave port region
>> +      - description: Control register access region
>> +      - description: Hard IP region
>> +    minItems: 2
>> +
>> +  reg-names:
>> +    items:
>> +      - const: Txs
>> +      - const: Cra
>> +      - const: Hip
>> +    minItems: 2
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  interrupt-controller: true
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
>> +
>> +  msi-parent: true
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - interrupts
>> +  - "#interrupt-cells"
>> +  - interrupt-controller
>> +  - interrupt-map
>> +  - interrupt-map-mask
>> +
>> +allOf:
>> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - altr,pcie-root-port-1.0
>> +    then:
>> +      properties:
>> +        reg:
>> +          maxItems: 2
>> +
>> +        reg-names:
>> +          maxItems: 2
>> +
>> +    else:
>> +      properties:
>> +        reg:
>> +          minItems: 3
>> +
>> +        reg-names:
>> +          minItems: 3
>> +
>> +
>> +unevaluatedProperties: false
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
>> +        interrupt-controller;
>> +        #interrupt-cells = <1>;
>> +        bus-range = <0x0 0xff>;
>> +        device_type = "pci";
>> +        msi-parent = <&msi_to_gic_gen_0>;
>> +        #address-cells = <3>;
>> +        #size-cells = <2>;
>> +        interrupt-map-mask = <0 0 0 7>;
>> +        interrupt-map = <0 0 0 1 &pcie_0 0 0 0 1>,
>> +                        <0 0 0 2 &pcie_0 0 0 0 2>,
>> +                        <0 0 0 3 &pcie_0 0 0 0 3>,
>> +                        <0 0 0 4 &pcie_0 0 0 0 4>;
>> +        ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000>,
>> +                 <0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1e71f97fb674..53f239114400 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -17435,7 +17435,7 @@ PCI DRIVER FOR ALTERA PCIE IP
>>  M:	Joyce Ooi <joyce.ooi@intel.com>
>>  L:	linux-pci@vger.kernel.org
>>  S:	Supported
>> -F:	Documentation/devicetree/bindings/pci/altera-pcie.txt
>> +F:	Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
>>  F:	drivers/pci/controller/pcie-altera.c
>>
>>  PCI DRIVER FOR APPLIEDMICRO XGENE
>> --
>> 2.34.1
>>
>

