Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C7B77B388
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 10:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjHNILr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 04:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbjHNILd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 04:11:33 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783F41702;
        Mon, 14 Aug 2023 01:11:14 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id CD8E0819D;
        Mon, 14 Aug 2023 16:11:07 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 14 Aug
 2023 16:11:07 +0800
Received: from [192.168.125.127] (183.27.98.20) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 14 Aug
 2023 16:11:06 +0800
Message-ID: <8f526ab4-d254-d612-3ebb-ec4813a5174b@starfivetech.com>
Date:   Mon, 14 Aug 2023 16:11:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 3/4] dt-bindings: PCI: Add StarFive JH7110 PCIe
 controller
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230727103949.26149-1-minda.chen@starfivetech.com>
 <20230727103949.26149-4-minda.chen@starfivetech.com>
 <20230810224727.GA1445828-robh@kernel.org>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20230810224727.GA1445828-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.20]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/8/11 6:47, Rob Herring wrote:
> On Thu, Jul 27, 2023 at 06:39:48PM +0800, Minda Chen wrote:
>> Add StarFive JH7110 SoC PCIe controller dt-bindings.
>> JH7110 using PLDA XpressRICH PCIe host controller IP.
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  .../bindings/pci/starfive,jh7110-pcie.yaml    | 133 ++++++++++++++++++
>>  1 file changed, 133 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
>> new file mode 100644
>> index 000000000000..9273e029fb20
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
>> @@ -0,0 +1,133 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/starfive,jh7110-pcie.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: StarFive JH7110 PCIe host controller
>> +
>> +maintainers:
>> +  - Kevin Xie <kevin.xie@starfivetech.com>
>> +
>> +allOf:
>> +  - $ref: /schemas/pci/pci-bus.yaml#
> 
> Can go in common schema. Unless endpoint mode is or is going to be 
> supported?
> 
>> +  - $ref: plda,xpressrich3-axi-common.yaml#
>> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> 
> This is a bit odd. Do you really need to define the host bridge as an 
> msi-controller? Many host bridges are, but they don't need to be defined 
> as one in DT because PCIe spec defines its own way to do MSIs. 
> 
Ok, I will delete this.
>> +  - $ref: /schemas/gpio/gpio-consumer-common.yaml#
> 
> No, you don't need to reference this. You need to define what properties 
> from it you use (reset-gpios).
> 
> Though if this is for PERST#, then I'd use "perst-gpios" instead.
> 
> And why is that not common? It's board specific, not SoC,  whether or 
> not there's GPIO control of it.
> 
OK
>> +
>> +properties:
>> +  compatible:
>> +    const: starfive,jh7110-pcie
>> +
>> +  clocks:
>> +    items:
>> +      - description: NOC bus clock
>> +      - description: Transport layer clock
>> +      - description: AXI MST0 clock
>> +      - description: APB clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: noc
>> +      - const: tl
>> +      - const: axi_mst0
>> +      - const: apb
>> +
>> +  resets:
>> +    items:
>> +      - description: AXI MST0 reset
>> +      - description: AXI SLAVE0 reset
>> +      - description: AXI SLAVE reset
>> +      - description: PCIE BRIDGE reset
>> +      - description: PCIE CORE reset
>> +      - description: PCIE APB reset
>> +
>> +  reset-names:
>> +    items:
>> +      - const: mst0
>> +      - const: slv0
>> +      - const: slv
>> +      - const: brg
>> +      - const: core
>> +      - const: apb
>> +
>> +  starfive,stg-syscon:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      - items:
>> +          - description: phandle to System Register Controller stg_syscon node.
>> +          - description: register0 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
>> +          - description: register1 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
>> +          - description: register2 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
>> +          - description: register3 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
>> +    description:
>> +      The phandle to System Register Controller syscon node and the offset
>> +      of STG_SYSCONSAIF__SYSCFG register for PCIe. Total 4 regsisters offset
>> +      for PCIe.
> 
> Perhaps somewhere in here state what these registers are for.
> 
The offsets will be removed.
>> +
>> +  phys:
>> +    description:
>> +      Specified PHY is attached to PCIe controller.
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - resets
>> +  - starfive,stg-syscon
> 
>> +  - "#interrupt-cells"
>> +  - interrupt-map-mask
>> +  - interrupt-map
> 
> These can all be common.
> 
> So could 'compatible' though it is implicitly required anyways as 
> without it, the schema is never applied.
> 
OK, Thanks.
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        pcie0: pcie@2b000000 {
>> +            compatible = "starfive,jh7110-pcie";
>> +            reg = <0x9 0x40000000 0x0 0x10000000>,
>> +                  <0x0 0x2b000000 0x0 0x1000000>;
>> +            reg-names = "cfg", "apb";
>> +            #address-cells = <3>;
>> +            #size-cells = <2>;
>> +            #interrupt-cells = <1>;
>> +            device_type = "pci";
>> +            ranges = <0x82000000  0x0 0x30000000  0x0 0x30000000 0x0 0x08000000>,
>> +                     <0xc3000000  0x9 0x00000000  0x9 0x00000000 0x0 0x40000000>;
>> +            starfive,stg-syscon = <&stg_syscon 0xc0 0xc4 0x130 0x1b8>;
>> +            bus-range = <0x0 0xff>;
>> +            interrupt-parent = <&plic>;
>> +            interrupts = <56>;
>> +            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
>> +            interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc0 0x1>,
>> +                            <0x0 0x0 0x0 0x2 &pcie_intc0 0x2>,
>> +                            <0x0 0x0 0x0 0x3 &pcie_intc0 0x3>,
>> +                            <0x0 0x0 0x0 0x4 &pcie_intc0 0x4>;
>> +            msi-parent = <&pcie0>;
> 
> Weird!?
> 
I will delete this.
>> +            msi-controller;
>> +            clocks = <&syscrg 86>,
>> +                     <&stgcrg 10>,
>> +                     <&stgcrg 8>,
>> +                     <&stgcrg 9>;
>> +            clock-names = "noc", "tl", "axi_mst0", "apb";
>> +            resets = <&stgcrg 11>,
>> +                     <&stgcrg 12>,
>> +                     <&stgcrg 13>,
>> +                     <&stgcrg 14>,
>> +                     <&stgcrg 15>,
>> +                     <&stgcrg 16>;
>> +            reset-gpios = <&gpios 26 GPIO_ACTIVE_LOW>;
>> +            phys = <&pciephy0>;
>> +
>> +            pcie_intc0: interrupt-controller {
>> +                #address-cells = <0>;
>> +                #interrupt-cells = <1>;
>> +                interrupt-controller;
>> +            };
>> +        };
>> +    };
>> -- 
>> 2.17.1
>> 
