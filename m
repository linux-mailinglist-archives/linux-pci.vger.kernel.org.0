Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF906771AD6
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 08:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjHGGzM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 02:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjHGGzL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 02:55:11 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85D41A4;
        Sun,  6 Aug 2023 23:55:08 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id A4AE524E251;
        Mon,  7 Aug 2023 14:54:51 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 7 Aug
 2023 14:54:52 +0800
Received: from [192.168.125.127] (113.72.146.246) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 7 Aug
 2023 14:54:51 +0800
Message-ID: <6c1a4b77-996e-9274-bece-84fe42d6099a@starfivetech.com>
Date:   Mon, 7 Aug 2023 14:54:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/4] dt-bindings: PCI: Add StarFive JH7110 PCIe
 controller
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230727103949.26149-1-minda.chen@starfivetech.com>
 <20230727103949.26149-4-minda.chen@starfivetech.com>
 <20230804-irregular-distrust-c5d46afe3d9c@wendy>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20230804-irregular-distrust-c5d46afe3d9c@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.146.246]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/8/4 15:10, Conor Dooley wrote:
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
>> +  - $ref: plda,xpressrich3-axi-common.yaml#
>> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
>> +  - $ref: /schemas/gpio/gpio-consumer-common.yaml#
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
> These property names tie them closely with naming on the jh7110, but
> there's little value in specifying all of these offsets when you have
> one implementation where they are all fixed.
Yes, the offset value is tied to SoC. 
> Do you know what the jh81xx stuff is going to do yet w.r.t. PCI and if
> so, how could you reuse this property?
I do not participate in jh8100. But I heard sys-syscon is exist in 81xx.
But I think stg-syscon and sys-syscon  can be move to a common dt-binding doc.
Bot 71x0 and 81x0 driver can use this. 
> Particularly, saying "register 0" seems unlikely to transfer well
> between SoCs.
> I'd be inclined to drop the offsets entirely & rely on match data to
> provide them if needed in the future.
That's ok. The dts can change to starfive,stg-syscon = <&stg_syscon>;
I will try to move the offset to driver match data.
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
>> +  - "#interrupt-cells"
>> +  - interrupt-map-mask
>> +  - interrupt-map
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
> 
> nit: you don't need labels in examples if they are not referenced
> anywhere.
> 
> Otherwise, this looks good to me.
> 
> Thanks,
> Conor.
> 
ok, thanks.
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
