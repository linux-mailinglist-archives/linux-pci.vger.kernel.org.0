Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBA534E46D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 11:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhC3J3v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 05:29:51 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52356 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhC3J3m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Mar 2021 05:29:42 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12U9TNfT025028;
        Tue, 30 Mar 2021 04:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617096563;
        bh=SyUbvgmeLGI6nGnrfGyJb7UDzXwfVV31iX4s+By/M0g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=u7QToUNQD3z2Gxpn4a2gX3b0qVVQGC8AW/NrsXipo6L04A1pSJnFdUrjLroX2I3tX
         Ka7sdwKXs8y+y+Kl0mpDTshck3/50enXclfsgzs24ey0eHUVtrh2T5qBs0OAzX64Gi
         0uQFzqOBXdLiZke9GU3YYVjQ/RT5/Fa/GiLshcC8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12U9TNV4042979
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Mar 2021 04:29:23 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 30
 Mar 2021 04:29:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 30 Mar 2021 04:29:23 -0500
Received: from [10.250.234.46] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12U9TH7e129563;
        Tue, 30 Mar 2021 04:29:18 -0500
Subject: Re: [PATCH 1/6] dt-bindings: PCI: ti,am65: Add PCIe host mode
 dt-bindings for TI's AM65 SoC
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <20210325090026.8843-1-kishon@ti.com>
 <20210325090026.8843-2-kishon@ti.com>
 <20210325233812.GA1943834@robh.at.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <985bd950-7bdf-d9b5-0a89-c05a56739c68@ti.com>
Date:   Tue, 30 Mar 2021 14:59:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210325233812.GA1943834@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 26/03/21 5:08 am, Rob Herring wrote:
> On Thu, Mar 25, 2021 at 02:30:21PM +0530, Kishon Vijay Abraham I wrote:
>> Add PCIe host mode dt-bindings for TI's AM65 SoC.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../bindings/pci/ti,am65-pci-host.yaml        | 111 ++++++++++++++++++
>>  1 file changed, 111 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>> new file mode 100644
>> index 000000000000..b77e492886fa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>> @@ -0,0 +1,111 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/pci/ti,am65-pci-host.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: TI AM65 PCI Host
>> +
>> +maintainers:
>> +  - Kishon Vijay Abraham I <kishon@ti.com>
>> +
>> +allOf:
>> +  - $ref: /schemas/pci/pci-bus.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,am654-pcie-rc
>> +
>> +  reg:
>> +    maxItems: 4
>> +
>> +  reg-names:
>> +    items:
>> +      - const: app
>> +      - const: dbics
> 
> Please use 'dbi' like everyone else if this isn't shared with the other 
> TI DW PCI bindings.

I'm just converting existing binding in pci-keystone.txt to yaml.
Documentation/devicetree/bindings/pci/pci-keystone.txt

Device tree for AM65 is also already in the upstream kernel.

I can try to remove the am65 specific part from pci-keystone.txt
> 
>> +      - const: config
>> +      - const: atu
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  ti,syscon-pcie-id:
>> +    description: Phandle to the SYSCON entry required for getting PCIe device/vendor ID
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  ti,syscon-pcie-mode:
>> +    description: Phandle to the SYSCON entry required for configuring PCIe in RC or EP mode.
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  msi-map: true
>> +
>> +  dma-coherent: true
>> +
>> +patternProperties:
>> +  "interrupt-controller":
> 
> Don't need quotes.

sure, will fix it.
> 
>> +    type: object
>> +    description: interrupt controller to handle legacy interrupts.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - max-link-speed
>> +  - num-lanes
>> +  - power-domains
>> +  - ti,syscon-pcie-id
>> +  - ti,syscon-pcie-mode
>> +  - msi-map
>> +  - ranges
>> +  - reset-gpios
>> +  - phys
>> +  - phy-names
>> +  - dma-coherent
> 
> 'interrupt-controller' node is optional?

yeah, upstream DT doesn't have interrupt-controller. It's added as part
of this series.

Thanks
Kishon
> 
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    bus {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        pcie0_rc: pcie@5500000 {
>> +                compatible = "ti,am654-pcie-rc";
>> +                reg =  <0x0 0x5500000 0x0 0x1000>,
>> +                       <0x0 0x5501000 0x0 0x1000>,
>> +                       <0x0 0x10000000 0x0 0x2000>,
>> +                       <0x0 0x5506000 0x0 0x1000>;
>> +                reg-names = "app", "dbics", "config", "atu";
>> +                power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
>> +                #address-cells = <3>;
>> +                #size-cells = <2>;
>> +                ranges = <0x81000000 0 0          0x0 0x10020000 0 0x00010000>,
>> +                         <0x82000000 0 0x10030000 0x0 0x10030000 0 0x07FD0000>;
>> +                ti,syscon-pcie-id = <&pcie_devid>;
>> +                ti,syscon-pcie-mode = <&pcie0_mode>;
>> +                bus-range = <0x0 0xff>;
>> +                num-viewport = <16>;
>> +                max-link-speed = <2>;
>> +                dma-coherent;
>> +                interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
>> +                msi-map = <0x0 &gic_its 0x0 0x10000>;
>> +                #interrupt-cells = <1>;
>> +                interrupt-map-mask = <0 0 0 7>;
>> +                interrupt-map = <0 0 0 1 &pcie0_intc 0>, /* INT A */
>> +                                <0 0 0 2 &pcie0_intc 0>, /* INT B */
>> +                                <0 0 0 3 &pcie0_intc 0>, /* INT C */
>> +                                <0 0 0 4 &pcie0_intc 0>; /* INT D */
>> +
>> +                pcie0_intc: interrupt-controller {
>> +                        interrupt-controller;
>> +                        #interrupt-cells = <1>;
>> +                        interrupt-parent = <&gic500>;
>> +                        interrupts = <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>;
>> +                };
>> +        };
>> -- 
>> 2.17.1
>>
