Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD616DD490
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 09:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjDKHp2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 03:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjDKHpP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 03:45:15 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87B435A0;
        Tue, 11 Apr 2023 00:45:10 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 31E2B24E2E3;
        Tue, 11 Apr 2023 15:45:09 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 11 Apr
 2023 15:45:09 +0800
Received: from [192.168.125.108] (113.72.145.176) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 11 Apr
 2023 15:45:08 +0800
Message-ID: <a37bcd12-73b7-0503-e82b-ab880bd43f16@starfivetech.com>
Date:   Tue, 11 Apr 2023 15:45:07 +0800
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
 <430f1eb0-e348-8a4e-b501-16b8c3b2494f@starfivetech.com>
 <f37964c6-0a75-2900-e6a7-282f5366696c@linaro.org>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <f37964c6-0a75-2900-e6a7-282f5366696c@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.176]
X-ClientProxiedBy: EXCAS065.cuchost.com (172.16.6.25) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.2 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/4/10 23:21, Krzysztof Kozlowski wrote:
> On 10/04/2023 11:05, Minda Chen wrote:
>>>> +
>>>> +  starfive,stg-syscon:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>> +    items:
>>>> +      items:
>>>> +        - description: phandle to System Register Controller stg_syscon node.
>>>> +        - description: register0 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
>>>> +        - description: register1 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
>>>> +        - description: register2 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
>>>> +        - description: register3 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
>>>> +    description:
>>>> +      The phandle to System Register Controller syscon node and the offset
>>>> +      of STG_SYSCONSAIF__SYSCFG register for PCIe. Total 4 regsisters offset
>>>> +      for PCIe.
>>>> +
>>>> +  pwren-gpios:
>>>> +    description: Should specify the GPIO for controlling the PCI bus device power on.
>>>
>>> What are these? Different than defined in gpio-consumer-common?
>>>
>> power gpio board level configuration. It it not a requried property
> 
> What is "board level configuration"? Again - is it different than
> powerdown-gpios from gpio-consumer-common.yaml?
> 
> 
I am sorry. I will change to powerdown-gpios follow gpio-consumer-common.yaml
> 
> Best regards,
> Krzysztof
> 
