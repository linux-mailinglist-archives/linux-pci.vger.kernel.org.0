Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D58DA1262FD
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 14:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfLSNLe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 08:11:34 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57394 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSNLd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 08:11:33 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBJDBQsl052727;
        Thu, 19 Dec 2019 07:11:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576761086;
        bh=i559tmImdB2C8E9k2UVVXe+nlV6Y3cE9qW3tVaTY3co=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nojvxPlYz4iAWt9AfMUf+QMWqQcTeG5HEqbgaAajcJ+CFZ3IOO5Awn5YmI1rb4ilk
         NRt4ApovoDImeVH8NR1pww4zBzjdeTHD7AGgJBFl/4lvFsuXJqVtQAUhLi1aWxcCx/
         8/AHGwrQQKOO6p8L94j4Gmv5+J7dboq/r7xSVrYI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBJDBQhK087007
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Dec 2019 07:11:26 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Dec 2019 07:11:25 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Dec 2019 07:11:25 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBJDBM58034668;
        Thu, 19 Dec 2019 07:11:23 -0600
Subject: Re: [PATCH 09/13] dt-bindings: PCI: Add host mode dt-bindings for
 TI's J721E SoC
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-10-kishon@ti.com> <20191219000841.GA4251@bogus>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <2c6984cc-731a-622f-7d90-c53e22f09f7b@ti.com>
Date:   Thu, 19 Dec 2019 18:43:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219000841.GA4251@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 19/12/19 5:38 am, Rob Herring wrote:
> On Mon, Dec 09, 2019 at 02:51:43PM +0530, Kishon Vijay Abraham I wrote:
>> Add host mode dt-bindings for TI's J721E SoC.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../bindings/pci/ti,j721e-pci-host.yaml       | 161 ++++++++++++++++++
>>  1 file changed, 161 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>> new file mode 100644
>> index 000000000000..96184e1f419f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>> @@ -0,0 +1,161 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/pci/ti,j721e-pci-host.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: TI J721E PCI Host (PCIe Wrapper)
>> +
>> +maintainers:
>> +  - Kishon Vijay Abraham I <kishon@ti.com>
> 
> There's now a PCI bus schema. Reference it here:
> 
> allOf:
>   - $ref: "/schemas/pci/pci-bus.yaml#"
> 
>> +
>> +properties:
>> +  compatible:
>> +      enum:
>> +          - ti,j721e-pcie-host
> 
> Indentation.
> 
>> +
>> +  reg:
>> +    maxItems: 4
>> +
>> +  reg-names:
>> +    items:
>> +      - const: intd_cfg
>> +      - const: user_cfg
>> +      - const: reg
>> +      - const: cfg
>> +
>> +  ti,syscon-pcie-ctrl:
>> +    description: Phandle to the SYSCON entry required for configuring PCIe mode
>> +                 and link speed.
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/phandle
> 
> You can drop the 'allOf' here if there aren't more constraints.
> 
>> +
>> +  max-link-speed:
>> +    minimum: 1
>> +    maximum: 3
>> +
>> +  num-lanes:
>> +    minimum: 1
>> +    maximum: 2
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +    description: clock-specifier to represent input to the PCIe
>> +
>> +  clock-names:
>> +    items:
>> +      - const: fck
>> +
> 
>> +  "#address-cells":
>> +    const: 3
>> +
>> +  "#size-cells":
>> +    const: 2
>> +
>> +  bus-range:
>> +    description: Range of bus numbers associated with this controller.
> 
> Drop these 3 as they are all standard.
> 
>> +
>> +  cdns,max-outbound-regions:
>> +    description: As defined in
>> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/int32
> 
> Can be negative? Use uint32.
> 
> The int* definitions are kind of broken until dtc is fixed to maintain 
> sign.
> 
>> +      - enum: [16]
> 
> const: 16
> 
>> +
>> +  cdns,no-bar-match-nbits:
>> +    description: As defined in
>> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/int32
>> +      - enum: [64]
>> +
>> +  vendor-id:
>> +    const: 0x104c
>> +    description: As defined in
>> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
> 
> And elsewhere. Drop the description.
> 
>> +
>> +  device-id:
>> +    const: 0xb00d
>> +    description: As defined in
>> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
>> +
>> +  msi-map: true
>> +
>> +  dma-coherent:
>> +    description: Indicates that the PCIe IP block can ensure the coherency
>> +
>> +  ranges: true
> 
> Don't you know how many?
> 
>> +
>> +  reset-gpios:
>> +    description: GPIO specifier for the PERST# signal
>> +
>> +  phys:
>> +    description: As defined in
>> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
>> +
>> +  phy-names:
>> +    description: As defined in
>> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - ti,syscon-pcie-ctrl
>> +  - max-link-speed
>> +  - num-lanes
>> +  - power-domains
>> +  - clocks
>> +  - clock-names
> 
>> +  - "#address-cells"
>> +  - "#size-cells"
> 
> Can drop these 2. The bus schema requires them.
> 
>> +  - bus-range
>> +  - cdns,max-outbound-regions
>> +  - cdns,no-bar-match-nbits
>> +  - vendor-id
>> +  - device-id
>> +  - msi-map
>> +  - dma-coherent
>> +  - ranges
> 
> Can drop, too.
> 
>> +  - reset-gpios
> 
> Isn't having this board dependent?

All board dts files should have it though.
I'll fix all the comments given here.

Thanks
Kishon
