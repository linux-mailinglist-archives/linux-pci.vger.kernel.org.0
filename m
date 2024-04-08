Return-Path: <linux-pci+bounces-5900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81EB89CCF6
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 22:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4792837AE
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 20:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB0743AAD;
	Mon,  8 Apr 2024 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M52aGI7T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AB27482;
	Mon,  8 Apr 2024 20:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712608477; cv=none; b=L5nMgek0el1sX64Q142iubPYca6q8vv7er7Paiu2+tO1MubMPBgScAdCt/stvzCV2RmtndZzZJiNroOw+XumT3O5L5IipceifJbawEqBfYMg1u2E/ce2a+JVOhzGb+Ak/YWn9nHB1QEYvLznzdcWrpjsZLeq7Q1HpZfmhMIXfzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712608477; c=relaxed/simple;
	bh=PWIA8V18WJY7Lf1DeBwmmMK2HKVS/EQgzN2tHA3xTLY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qHdSzP6DgPufQCeY7Zr98W0N/aYF+xxV38lTRDQwm+B3W55gP0ENM4pA5SPpVYnwAulTIkKy1Az1ExpJu/9ISVaqOwZxs6rJhruvt2pC95L30GzpCupQDuJx/oTrOBtEh5Awli4qPEab+0x5Tr8hshhgscB+Q8qqBBS6Fj5XwUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M52aGI7T; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712608476; x=1744144476;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PWIA8V18WJY7Lf1DeBwmmMK2HKVS/EQgzN2tHA3xTLY=;
  b=M52aGI7TMenruHGW/jxiEnVJ+KQ1m4eKM5ecIRuN3hxtxzt8YVfhcVZO
   prp9Te2iYhpbOCdHvL3+50wTiAQKfDtCHGxcf4V3UP/ZNMyigyZ6rjSCN
   TOCq4PBTesEAyGIMUWaYCHYRj7lh4MXP3Fd4NMBgV6MmsiSjFisMSoYGP
   xei7U0oxHkSQhVLPvOFeOxAdXLNFBNYi8qL7och2j3jR8g6SPz28+KyD6
   obAuao5VV7gMAEb5S+pT0qrtKlFTU7DnIQO1LES3hZZ9NAt8yhLR48POu
   K2xaXoSbxxN7TNneTtOUr6Hv79QCJTBiJgQ+Gh4AIdJbWrvopgoboTQli
   w==;
X-CSE-ConnectionGUID: DmLl1g8xTJG7xG9pXOOgtg==
X-CSE-MsgGUID: x7I2YA0gSSKjBWsTrR25SQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="19285619"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19285619"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 13:34:35 -0700
X-CSE-ConnectionGUID: j47fw3sGTuCeJaeCJgxwUg==
X-CSE-MsgGUID: e/mxbEINTRCpqmcD3UwM+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20121978"
Received: from sj-4150-psse-sw-opae-dev2.sj.intel.com ([10.233.115.162])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 13:34:34 -0700
Date: Mon, 8 Apr 2024 13:34:24 -0700 (PDT)
From: matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@sj-4150-psse-sw-opae-dev2
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
    krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: PCI: altera: Convert to YAML
In-Reply-To: <2ece9ac2-899c-4185-b0f3-8ab939afc1e5@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2404081309050.381257@sj-4150-psse-sw-opae-dev2>
References: <20240405145322.3805828-1-matthew.gerlach@linux.intel.com> <2ece9ac2-899c-4185-b0f3-8ab939afc1e5@linaro.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Sun, 7 Apr 2024, Krzysztof Kozlowski wrote:

> On 05/04/2024 16:53, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Convert the device tree bindings for the Altera Root Port PCIe controller
>> from text to YAML.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>> v2:
>>  - Move allOf: to bottom of file, just like example-schema is showing
>
> No, just open it and you will see it is placed differently...

I see what you mean. I will match the ordering of example-schema.

>
>>  - add constraint for reg and reg-names
>
> Not complete...

I will complete.

>
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
>
> This is derivative of previous work, which is easily visible by doing
> the same mistakes in DTS as they were before.

This is definitely derivative of previous work, and I want to fix the 
DTS mistakes too.

>
> You now added fresh copyrights ignoring all previous work, even though
> you copied it. I don't agree.
>
> If you want to ignore previous copyrights, then at least don't copy
> existing code... although even that would not be sufficient.

Ignoring previous copyrights was not my intent. There is no copyright 
statement in the original text version of the device tree bindings. Should 
that lack of copyright statement carry forward?

>
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
>
> Drop items.

I will drop the items.

>
>> +      - enum:
>> +          - altr,pcie-root-port-1.0
>> +          - altr,pcie-root-port-2.0
>> +
>
> Missing reg with constraints.

I will add the following here:

   reg:
     minItems: 2
     maxItems: 3

   reg-names:
     minItems: 2
     maxItems: 3

>
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
>> +
>> +  msi-parent: true
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - device_type
>> +  - interrupts
>> +  - interrupt-map
>> +  - interrupt-map-mask
>> +
>> +unevaluatedProperties: false
>> +
>> +allOf:
>> +  - $ref: /schemas/pci/pci-bus.yaml#
>
> That's deprecated, as explained in its description.  You should use
> pci-host-bridge.yaml.

I will switch to pci-host-bridge.yaml.

>
>
>
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
>
> unevaluated goes here, just like example-schema.

Yes, just like the example-schema

>
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
>
> That's two entries.

I will fix the broken DTS as follows:

        ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000>,
                 <0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
>
> Best regards,
> Krzysztof
>
>

Thank you for the review,
Matthew Gerlach

