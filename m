Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25286DC4CF
	for <lists+linux-pci@lfdr.de>; Mon, 10 Apr 2023 11:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjDJJFX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Apr 2023 05:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjDJJFW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Apr 2023 05:05:22 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2C730C3;
        Mon, 10 Apr 2023 02:05:20 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 04B7C24E2A1;
        Mon, 10 Apr 2023 17:05:19 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 10 Apr
 2023 17:05:18 +0800
Received: from [192.168.125.108] (113.72.145.176) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 10 Apr
 2023 17:05:17 +0800
Message-ID: <430f1eb0-e348-8a4e-b501-16b8c3b2494f@starfivetech.com>
Date:   Mon, 10 Apr 2023 17:05:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 1/3] dt-binding: pci: add JH7110 PCIe dt-binding
 documents.
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230406111142.74410-1-minda.chen@starfivetech.com>
 <20230406111142.74410-2-minda.chen@starfivetech.com>
 <38bc48bf-7d8c-8ddd-861f-3b7f3d2edce6@linaro.org>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <38bc48bf-7d8c-8ddd-861f-3b7f3d2edce6@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.176]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.2 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/4/7 2:24, Krzysztof Kozlowski wrote:
> On 06/04/2023 13:11, Minda Chen wrote:
>> Add PCIe controller driver dt-binding documents
>> for StarFive JH7110 SoC platform.
> 
> Use subject prefixes matching the subsystem (which you can get for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching). Missing: 's'
> 
> Subject: drop second/last, redundant "dt-binding documents". The
> "dt-bindings" prefix is already stating that these are bindings and
> documentation.
> 
> Drop also full stop.
> 
ok, thanks
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> ---
>>  .../bindings/pci/starfive,jh7110-pcie.yaml    | 163 ++++++++++++++++++
>>  1 file changed, 163 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
>> new file mode 100644
>> index 000000000000..fa4829766195
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
>> @@ -0,0 +1,163 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/starfive,jh7110-pcie.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: StarFive JH7110 PCIe 2.0 host controller
>> +
>> +maintainers:
>> +  - Minda Chen <minda.chen@starfivetech.com>
>> +
>> +allOf:
>> +  - $ref: /schemas/pci/pci-bus.yaml#
>> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: starfive,jh7110-pcie
>> +
>> +  reg:
>> +    maxItems: 2
>> +
>> +  reg-names:
>> +    items:
>> +      - const: reg
>> +      - const: config
>> +
>> +  msi-parent: true
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 4
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
>> +      - description: AXI SLAVE reset
>> +      - description: AXI SLAVE0 reset
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
>> +      items:
>> +        - description: phandle to System Register Controller stg_syscon node.
>> +        - description: register0 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
>> +        - description: register1 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
>> +        - description: register2 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
>> +        - description: register3 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
>> +    description:
>> +      The phandle to System Register Controller syscon node and the offset
>> +      of STG_SYSCONSAIF__SYSCFG register for PCIe. Total 4 regsisters offset
>> +      for PCIe.
>> +
>> +  pwren-gpios:
>> +    description: Should specify the GPIO for controlling the PCI bus device power on.
> 
> What are these? Different than defined in gpio-consumer-common?
> 
power gpio board level configuration. It it not a requried property
>> +    maxItems: 1
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +
>> +  phys:
>> +    maxItems: 1
>> +
>> +  interrupt-controller:
>> +    type: object
>> +    properties:
>> +      '#address-cells':
>> +        const: 0
>> +
>> +      '#interrupt-cells':
>> +        const: 1
>> +
>> +      interrupt-controller: true
>> +
>> +    required:
>> +      - '#address-cells'
>> +      - '#interrupt-cells'
>> +      - interrupt-controller
>> +
>> +    additionalProperties: false
>> +
>> +required:
>> +  - reg
>> +  - reg-names
>> +  - "#interrupt-cells"
> 
> Keep consistent quotes - either ' or "
> 
> Are you sure this is correct? You have interrupt controller as child node.
> 
> 
>> +  - interrupts
>> +  - interrupt-map-mask
>> +  - interrupt-map
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - msi-controller
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    bus {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        pcie0: pcie@2B000000 {
> 
> Lowercase hex. Everywhere.
> 
ok
>> +            compatible = "starfive,jh7110-pcie";
>> +            #address-cells = <3>;
>> +            #size-cells = <2>;
>> +            #interrupt-cells = <1>;
>> +            reg = <0x0 0x2B000000 0x0 0x1000000>,
>> +                  <0x9 0x40000000 0x0 0x10000000>;
> 
> reg (and reg-names and ranges) is always second property.
> 
ok
>> +            reg-names = "reg", "config";
>> +            device_type = "pci";
>> +            starfive,stg-syscon = <&stg_syscon 0xc0 0xc4 0x130 0x1b8>;
>> +            bus-range = <0x0 0xff>;
>> +            ranges = <0x82000000  0x0 0x30000000  0x0 0x30000000 0x0 0x08000000>,
>> +                     <0xc3000000  0x9 0x00000000  0x9 0x00000000 0x0 0x40000000>;
>> +            interrupt-parent = <&plic>;
>> +            interrupts = <56>;
>> +            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
>> +            interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc0 0x1>,
>> +                            <0x0 0x0 0x0 0x2 &pcie_intc0 0x2>,
>> +                            <0x0 0x0 0x0 0x3 &pcie_intc0 0x3>,
>> +                            <0x0 0x0 0x0 0x4 &pcie_intc0 0x4>;
> 
> 
> Best regards,
> Krzysztof
> 
