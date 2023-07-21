Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DA775BBBB
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 03:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjGUBMj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 21:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGUBMi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 21:12:38 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B03271C;
        Thu, 20 Jul 2023 18:12:37 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id BD5868178;
        Fri, 21 Jul 2023 09:12:35 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 09:12:35 +0800
Received: from [192.168.125.127] (113.72.147.86) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 09:12:34 +0800
Message-ID: <e4668a72-b180-0b54-bf58-69b43ae0b529@starfivetech.com>
Date:   Fri, 21 Jul 2023 09:12:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 4/9] PCI: microchip: Move PCIe driver to PLDA directory
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230719102057.22329-1-minda.chen@starfivetech.com>
 <20230719102057.22329-5-minda.chen@starfivetech.com>
 <20230720-exception-spectator-b48ecb9d4c39@wendy>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20230720-exception-spectator-b48ecb9d4c39@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.86]
X-ClientProxiedBy: EXCAS065.cuchost.com (172.16.6.25) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/7/20 20:26, Conor Dooley wrote:
> Hey Minda,
> 
> On Wed, Jul 19, 2023 at 06:20:52PM +0800, Minda Chen wrote:
>> Move Microchip specific platform codes to PLDA directory.
>> Including clock init, interrupt event handle and platform
>> init codes.
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> 
> Something else that I noticed, looking at what is not in the diff here,
> but is everything under the "/* PCIe Controller Phy Regs */" comment
> that remains in the microchip driver not also common to the plda IP?
> 
> Thanks,
> Conor.
I changed it to "PCIe Controller Reg" in patch8 ... It looks not the Phy register..
Maybe I don't change it. And I will squash this patch with patch3.
