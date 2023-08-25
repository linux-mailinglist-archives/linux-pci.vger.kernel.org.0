Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2451F7882FF
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 11:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240396AbjHYJHF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 05:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244234AbjHYJHA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 05:07:00 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E515C212C;
        Fri, 25 Aug 2023 02:06:44 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 86D7681BB;
        Fri, 25 Aug 2023 17:06:43 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 25 Aug
 2023 17:06:43 +0800
Received: from [192.168.125.127] (113.72.145.205) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 25 Aug
 2023 17:06:42 +0800
Message-ID: <5450650c-3750-a0ee-72a1-bfa0a4545e0a@starfivetech.com>
Date:   Fri, 25 Aug 2023 17:06:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 09/11] dt-bindings: PCI: Add StarFive JH7110 PCIe
 controller
To:     Rob Herring <robh@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        Kevin Xie <kevin.xie@starfivetech.com>,
        <linux-riscv@lists.infradead.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84s?= =?UTF-8?Q?ki?= <kw@linux.com>,
        Mason Huo <mason.huo@starfivetech.com>,
        Conor Dooley <conor@kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        <devicetree@vger.kernel.org>
References: <20230814082016.104181-1-minda.chen@starfivetech.com>
 <20230814082016.104181-10-minda.chen@starfivetech.com>
 <169228685644.1140409.12427674208274594176.robh@kernel.org>
Content-Language: en-US
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <169228685644.1140409.12427674208274594176.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.205]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/8/17 23:40, Rob Herring wrote:
> 
> On Mon, 14 Aug 2023 16:20:14 +0800, Minda Chen wrote:
>> Add StarFive JH7110 SoC PCIe controller dt-bindings.
>> JH7110 using PLDA XpressRICH PCIe host controller IP.
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  .../bindings/pci/starfive,jh7110-pcie.yaml    | 120 ++++++++++++++++++
>>  1 file changed, 120 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
>> 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
Hi Rob
Thanks. 
I see other PCIe maintainer have not reviewed PCIe driver codes(or no coments).
Could you help to review PCIe driver codes patches? (I just commit new version 4). Thanks.
