Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4558575A714
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 08:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjGTG7f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 02:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjGTG7d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 02:59:33 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1575DCC;
        Wed, 19 Jul 2023 23:59:29 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 21FB424E3BF;
        Thu, 20 Jul 2023 14:59:27 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 20 Jul
 2023 14:59:27 +0800
Received: from [192.168.125.127] (113.72.147.86) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 20 Jul
 2023 14:59:23 +0800
Message-ID: <5e4d5920-f346-a6ae-8548-f70d9fa911fe@starfivetech.com>
Date:   Thu, 20 Jul 2023 14:59:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 1/9] dt-bindings: PCI: Add PLDA XpressRICH PCIe host
 common properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230719102057.22329-1-minda.chen@starfivetech.com>
 <20230719102057.22329-2-minda.chen@starfivetech.com>
 <c1dea7c8-2bc4-a113-0d40-098228fe3860@linaro.org>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <c1dea7c8-2bc4-a113-0d40-098228fe3860@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.86]
X-ClientProxiedBy: EXCAS063.cuchost.com (172.16.6.23) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/7/19 18:52, Krzysztof Kozlowski wrote:
> On 19/07/2023 12:20, Minda Chen wrote:
>> Add PLDA XpressRICH PCIe host common properties dt-binding doc.
>> Microchip PolarFire PCIe host using PLDA IP.
>> Extract properties from Microchip PolarFire PCIe host.
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  .../pci/plda,xpressrich-pcie-common.yaml      | 72 +++++++++++++++++++
>>  1 file changed, 72 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-common.yaml
> 
> How is it related with existing plda,xpressrich3-axi?
> 
 yes, I just found plda,xpressrich3-axi. It is same IP in ARM juno soc. But it is firmware-initialized while microchip and starfive not.
maybe I can rename this file to plda,xpressrich3-axi-common.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-common.yaml b/Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-common.yaml
>> new file mode 100644
>> index 000000000000..3627a846c5d1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-common.yaml
>> @@ -0,0 +1,72 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/plda,xpressrich-pcie-common.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: PLDA XpressRICH PCIe host common properties
>> +
>> +maintainers:
>> +  - Daire McNamara <daire.mcnamara@microchip.com>
>> +  - Minda Chen <minda.chen@starfivetech.com>
>> +
>> +description:
>> +  Generic PLDA XpressRICH PCIe host common properties.
>> +
>> +select: false
> 
> This should not be needed.
> 
ok
>> +
>> +properties:
>> +  reg:
>> +    description:
>> +      At least host IP register set and configuration space are
> 
> "At least" does not fit here since you do not allow anything else.
> 
I will delete "At least"
>> +      required for normal controller work.
>> +    maxItems: 2
>> +
>> +  reg-names:
>> +    oneOf:
>> +      - items:
>> +          - const: cfg
>> +          - const: apb
>> +      - items:
>> +          - const: host
>> +          - const: cfg
> 
> Maybe keep similar order, so cfg followed by host?
> 
I will follow cfg, apb
> Best regards,
> Krzysztof
> 
