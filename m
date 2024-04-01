Return-Path: <linux-pci+bounces-5500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 708438945F3
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 22:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96481F2215A
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 20:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A4353E01;
	Mon,  1 Apr 2024 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5zHUrJJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902F446535;
	Mon,  1 Apr 2024 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712003125; cv=none; b=g67ftFdpgl4kLs3H+v9ynJ4j30yXNIS4sNziFg6UUbaqeUiv9f51TmlRplgCLTqYDOtueDIIOxecLVNxFEcglq2pXMQYktTdPdEtc/fapQAOscdyurTkFcPazEFGZxxoi28UaytdQYOqt2UiFG7t+SvVYvtISRR6X3UAQIVrapQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712003125; c=relaxed/simple;
	bh=CvWR4wz2QN3K88UxICPNN1tDin69DPFPxypKgy4+mHM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f7qyiShtIsJFRxr3TW13LyLbhtjYcFycS2441YTizbouh9+Fb6E3X3FP2EeJSMTF1b1cWpK5zc3hlOv+8pmT+wGQd2cZcQvCPrGzQahMGGGnZPRCgm7LEsBEwhcNadosmTvVYue8p/idFgLv+4oJVbII9lh9j01ABX3lDOqs+8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5zHUrJJ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712003123; x=1743539123;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CvWR4wz2QN3K88UxICPNN1tDin69DPFPxypKgy4+mHM=;
  b=F5zHUrJJdPTgWXEHIoPxpRQUTqJqJY6S2U/8Yc3kBzzPvGAR/4vPbnPm
   wdvE97Kv/P9XqnbhoXpsAUZG9AxHmS+5Pt3qrIjb3m/mhUu9pTOC17IGv
   M6QxwHqH7m1epBZFMJWAHgCJUOE3k1cDWMw4pz1clZWfHj7+rK2TAv4Ti
   4oi2K+dIbm2rcfcLsMtt+b0H0bulQgl7dhlj75pZdkgzOuwv0aDqAG6I1
   ODtktwmItu6JX0+w8yzrNKlkhqiIWBY0ENAY42TgQpwqHGPQxB8J07kGh
   QOKtjvFTvjRRAvaCAQd4tZfgWNqepzGesiGeBmKXorXAXntIGU1vB7Na7
   g==;
X-CSE-ConnectionGUID: s1auBxXjTmCVtkgNChi2lw==
X-CSE-MsgGUID: CqW5D2GTSAWubJbPP5snOQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7081836"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="7081836"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 13:25:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="22516384"
Received: from sj-4150-psse-sw-opae-dev2.sj.intel.com ([10.233.115.162])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 13:25:23 -0700
Date: Mon, 1 Apr 2024 13:25:13 -0700 (PDT)
From: matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@sj-4150-psse-sw-opae-dev2
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
cc: joyce.ooi@intel.com, bhelgaas@google.com, lpieralisi@kernel.org, 
    kw@linux.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
    conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pci: altera: covert to yaml
In-Reply-To: <bfa6150b-e27e-41c3-a1a7-41e46f52f6ea@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2404011306560.362977@sj-4150-psse-sw-opae-dev2>
References: <20240329170031.3379524-1-matthew.gerlach@linux.intel.com> <bfa6150b-e27e-41c3-a1a7-41e46f52f6ea@linaro.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Fri, 29 Mar 2024, Krzysztof Kozlowski wrote:

> On 29/03/2024 18:00, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Covert the device tree bindings for the Altera Root
>> Port controller from text to yaml.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>
> ...
>
>> diff --git a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
>> new file mode 100644
>> index 000000000000..8f1ad1362ad1
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
>> +allOf:
>> +  - $ref: /schemas/pci/pci-bus.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - altr,pcie-root-port-1.0
>> +          - altr,pcie-root-port-2.0
>> +
>> +  reg:
>> +    minItems: 2
>> +    maxItems: 3
>> +
>> +  reg-names:
>> +    description:
>> +      TX slave port region (Txs)
>> +      Control register access region (Cra)
>> +      Hard IP region if altr,pcie-root-port-2.0 (Hip)
>
> All these go to reg as description of items.
>
> Both - reg and reg-names - need constraints per variant in
> allOf:if:then:. Move allOf: to bottom of file, just like example-schema
> is showing.

I understand. I added a constraint and moved allOf: to bottom of file, 
just like the example-schema is showing.

>
>
>> +
>> +    items:
>> +      - const: Txs
>> +      - const: Cra
>> +      - const: Hip
>> +    minItems: 2
>> +
>> +  device_type:
>> +    const: pci
>
> I don't think you need it.

I removed it.

>
>> +
>> +  "#address-cells":
>> +    const: 3
>
> Drop

Dropped

>
>> +
>> +  "#size-cells":
>> +    const: 2
>
> Drop

Dropped

>
>> +
>> +  interrupts:
>> +    minItems: 1
>
> This should be maxItems.

I changed it to maxItems

>
>> +
>> +  interrupt-map-mask:
>> +    items:
>> +      - const: 0
>> +      - const: 0
>> +      - const: 0
>> +      - const: 7
>
> I guess as well.
>
>> +
>> +  interrupt-map:
>> +    maxItems: 4
>> +
>> +  "#interrupt-cells":
>> +    const: 1
>
> Drop

If I remove "#interrupt-cells", then I get the following error:
/home/mgerlach/git/linux-next/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml: 
properties: '#interrupt-cells' is a dependency of 'interrupt-map'
 	from schema $id: 
http://devicetree.org/meta-schemas/interrupts.yaml#

>
>> +
>> +  msi-parent:
>> +    description: Link to the hardware entity that serves as the MSI controller.
>
> Just true.
>
> Please open existing, recent PCI bindings and look how it is done.

I see a couple of examples of the following:

   msi-parent: true


>
>> +
>> +  bus-range:
>> +    description: PCI bus numbers covered.
>
> Drop

Dropped.

>
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - device_type
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - interrupts
>> +  - interrupt-map
>> +  - interrupt-map-mask
>> +  - "#interrupt-cells"
>
> This also needs cleaning.

I removed Dropped items.

>
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    pcie_0: pcie@c00000000 {
>> +        compatible = "altr,pcie-root-port-1.0";
>> +        reg = <0xc0000000 0x20000000>,
>> +            <0xff220000 0x00004000>;
>
> Misaligned.

I fixed the alignments.

>
>> +        reg-names = "Txs", "Cra";
>> +        interrupt-parent = <&hps_0_arm_gic_0>;
>> +        interrupts = <0 40 4>;
>
> Use defines for common constnats.

I added constants from arm_gic.h and irq.h.

>
>> +        #interrupt-cells = <1>;
>> +        bus-range = <0x0 0xFF>;
>
> Lowercase hex

I changed to lower case.

>
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
>> +              0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
>
> Misaligned.
>
>
> Best regards,
> Krzysztof
>
>

Thank you for the timely and thorough review. Version 2 of the patch will 
be submitted soon.

Matthew Gerlach

