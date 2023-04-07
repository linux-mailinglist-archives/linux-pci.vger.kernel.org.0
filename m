Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D166DA7B8
	for <lists+linux-pci@lfdr.de>; Fri,  7 Apr 2023 04:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbjDGCdC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 22:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDGCdB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 22:33:01 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7240059C7;
        Thu,  6 Apr 2023 19:32:59 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 145AA24E342;
        Fri,  7 Apr 2023 10:32:58 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 7 Apr
 2023 10:32:57 +0800
Received: from [192.168.125.108] (183.27.97.179) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 7 Apr
 2023 10:32:56 +0800
Message-ID: <d9dde509-8923-a930-4c82-4bc8bd78ed0d@starfivetech.com>
Date:   Fri, 7 Apr 2023 10:32:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 0/3] Add JH7110 PCIe driver support
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
        Kevin Xie <kevin.xie@starfivetech.com>,
        <daire.mcnamara@microchip.com>
References: <20230406111142.74410-1-minda.chen@starfivetech.com>
 <20230406-quench-unharmed-2c11b2617e9f@wendy>
 <20230406-coming-stuffed-26f89610959c@wendy>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20230406-coming-stuffed-26f89610959c@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.179]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX171.cuchost.com
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



On 2023/4/6 19:54, Conor Dooley wrote:
> Gah, I never actually CCed Daire. Apologies for the additional email.
> 
> On Thu, Apr 06, 2023 at 12:47:41PM +0100, Conor Dooley wrote:
>> +CC Daire
>> 
>> Hey Minda,
>> 
>> On Thu, Apr 06, 2023 at 07:11:39PM +0800, Minda Chen wrote:
>> > This patchset adds PCIe driver for the StarFive JH7110 SoC.
>> > The patch has been tested on the VisionFive 2 board. The test
>> > devices include M.2 NVMe SSD and Realtek 8169 Ethernet adapter.
>> 
>> I was talking with Daire last week about some changes he's working on
>> for the microchip driver, and we seemed to recall an off-list email
>> sent to Daire & Bjorn about extracting the common PLDA bits from the
>> pcie-microchip-host driver to be used with an (at that point)
>> unreleased SoC. Perhaps Bjorn has this in his mailbox somewhere still,
>> our corporate mail policy scrubs things from over a year ago & I could
>> not find it.
>>
>> I realised that that may actually have been StarFive, and the driver on
>> your GitHub [1] certainly felt very familiar to Daire (he said it was
>> very similar to his earlier revisions of his driver).
>> 
>> I've not looked at a diff between this and the version you ship on
>> GitHub, but first a quick inspection it mostly just looks like you
>> did s/plda/sifive/ on the file.
>> 
>> I'm obviously not a PCI maintainer, but if there are common bits between
>> the two drivers, extracting common bits seems like a good idea to me...
>Thanks. It is pleasure to using same common codes. Does common bits changes
will upstream soon?
And I see there are many difference between pcie-microchip-host and our codes.
>> https://github.com/starfive-tech/linux/blob/JH7110_VisionFive2_devel/drivers/pci/controller/pcie-plda.c
>> > 
>> > This patchset should be applied after the patchset [1], [2], [3] and[4]:
>> > [1] https://patchwork.kernel.org/project/linux-riscv/cover/20230314124404.117592-1-xingyu.wu@starfivetech.com/
>> > [2] https://lore.kernel.org/all/20230315055813.94740-1-william.qiu@starfivetech.com/
>> > [3] https://patchwork.kernel.org/project/linux-phy/cover/20230315100421.133428-1-changhuang.liang@starfivetech.com/
>> > [4] https://patchwork.kernel.org/project/linux-usb/cover/20230406015216.27034-1-minda.chen@starfivetech.com/
>> 
>> How many of the dependencies here are compiletime for the driver & how
>> many of them are just for the dts patch?
>> 
PCIe rely on stg clock in [1], rely on stg syscon in [2].
Patch [2] is accepted now. Maybe I will delete this.
both [3] and [4] is PHY dependency. 
>> Cheers,
>> Conor.
> 
> 
