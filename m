Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B47E6DA818
	for <lists+linux-pci@lfdr.de>; Fri,  7 Apr 2023 05:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjDGDp4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 23:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjDGDpz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 23:45:55 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FCCE63;
        Thu,  6 Apr 2023 20:45:51 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 761F524E1B6;
        Fri,  7 Apr 2023 11:45:39 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 7 Apr
 2023 11:45:39 +0800
Received: from [192.168.125.108] (183.27.97.179) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 7 Apr
 2023 11:45:38 +0800
Message-ID: <548b4d0f-447a-23a9-0e58-3d6c80cb8e3b@starfivetech.com>
Date:   Fri, 7 Apr 2023 11:45:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 1/3] dt-binding: pci: add JH7110 PCIe dt-binding
 documents.
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
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
 <20230406-revisit-patchy-a0063d964070@spud>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20230406-revisit-patchy-a0063d964070@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.179]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.2 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/4/7 2:35, Conor Dooley wrote:
> On Thu, Apr 06, 2023 at 08:24:55PM +0200, Krzysztof Kozlowski wrote:
>> On 06/04/2023 13:11, Minda Chen wrote:
>> > +
>> > +  interrupt-controller:
>> > +    type: object
>> > +    properties:
>> > +      '#address-cells':
>> > +        const: 0
>> > +
>> > +      '#interrupt-cells':
>> > +        const: 1
>> > +
>> > +      interrupt-controller: true
>> > +
>> > +    required:
>> > +      - '#address-cells'
>> > +      - '#interrupt-cells'
>> > +      - interrupt-controller
>> > +
>> > +    additionalProperties: false
>> > +
>> > +required:
>> > +  - reg
>> > +  - reg-names
>> > +  - "#interrupt-cells"
>> 
>> Keep consistent quotes - either ' or "
>> 
>> Are you sure this is correct? You have interrupt controller as child node.
> 
> I know existing stuff in-tree is far from a guarantee that it'll be
> right, but this does at least follow what we've got for PolarFire SoC:
> Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> 
> Both PLDA and both RISC-V w/ a PLIC as the interrupt controller, so in
> similar waters.
> This note existed in the original text form binding of the Microchip
> PCI controller:
> | +NOTE:
> | +The core provides a single interrupt for both INTx/MSI messages. So,
> | +create an interrupt controller node to support 'interrupt-map' DT
> | +functionality.  The driver will create an IRQ domain for this map, decode
> | +the four INTx interrupts in ISR and route them to this domain.
> 
> Given the similarities, I figure the same requirement applies here too.
> Minda?
> 
> Cheers,
> Conor.

Yes, Thanks very much.
