Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 683A8126314
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 14:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfLSNNR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 08:13:17 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56236 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSNNR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 08:13:17 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBJDD7UZ002286;
        Thu, 19 Dec 2019 07:13:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576761188;
        bh=KpH/tH+NsOsRovCmkYgi/0I9FOPMrHG3B7b6JVEqIBE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GK1cbM7HGrsGlHyIwq3TvwgMootFKhnrfTJ6xdxhfI2jWttjRU+6bS7CvJJRMV6Ns
         Fy1X2rit3h1sXjIBI1C0gsaOBHK8HIfj3LzDID3SnVFdV2L0SoCufpiVHa+d6XltYC
         3ZxjXuWhR1bOHoPjfnpfAAvsJsISvV/xk8hyvqos=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBJDD7nb020647
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Dec 2019 07:13:07 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Dec 2019 07:13:06 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Dec 2019 07:13:06 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBJDD38D090087;
        Thu, 19 Dec 2019 07:13:03 -0600
Subject: Re: [PATCH 10/13] dt-bindings: PCI: Add EP mode dt-bindings for TI's
 J721E SoC
To:     Rob Herring <robh@kernel.org>, Tom Joseph <tjoseph@cadence.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-11-kishon@ti.com> <20191219001408.GA20303@bogus>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <fb090674-abff-e2e1-492d-0585100980d0@ti.com>
Date:   Thu, 19 Dec 2019 18:44:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219001408.GA20303@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Tom

On 19/12/19 5:44 am, Rob Herring wrote:
> On Mon, Dec 09, 2019 at 02:51:44PM +0530, Kishon Vijay Abraham I wrote:
>> Add PCIe EP mode dt-bindings for TI's J721E SoC.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../bindings/pci/ti,j721e-pci-ep.yaml         | 113 ++++++++++++++++++
>>  1 file changed, 113 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>> new file mode 100644
>> index 000000000000..4e2af4733998
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>> @@ -0,0 +1,113 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/pci/ti,j721e-pci-ep.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: TI J721E PCI EP (PCIe Wrapper)
>> +
>> +maintainers:
>> +  - Kishon Vijay Abraham I <kishon@ti.com>
>> +
>> +properties:
>> +  compatible:
>> +      enum:
>> +          - ti,j721e-pcie-ep
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
>> +      - const: mem
>> +
>> +  ti,syscon-pcie-ctrl:
>> +    description: Phandle to the SYSCON entry required for configuring PCIe mode
>> +                 and link speed.
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/phandle
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
>> +  cdns,max-outbound-regions:
>> +    description: As defined in
>> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/int32
> 
> uint32
> 
>> +      - enum: [16]
>> +
>> +  max-functions:
>> +    minimum: 1
>> +    maximum: 6
> 
> Needs a type ref. Or a common definition.
> 
>> +
>> +  dma-coherent:
>> +    description: Indicates that the PCIe IP block can ensure the coherency
>> +
>> +  phys:
> 
> How many? Need to convert cdns,cdns-pcie-host.txt...


Tom, Can you convert cdns,cdns-pcie-host.txt to YAML binding?
> 
>> +    description: As defined in
>> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
>> +
>> +  phy-names:
>> +    description: As defined in
>> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
> 
> For all the properties shared with host mode, it might make sense to 
> define a common schema with all those properties and then include it in 
> the host and endpoint schemas.

Sure.

Thanks
Kishon
