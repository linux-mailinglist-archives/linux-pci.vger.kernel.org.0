Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EE07A34AF
	for <lists+linux-pci@lfdr.de>; Sun, 17 Sep 2023 10:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjIQIuF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Sep 2023 04:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjIQIte (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Sep 2023 04:49:34 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8B3185;
        Sun, 17 Sep 2023 01:49:27 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 6C53224DCA6;
        Sun, 17 Sep 2023 16:49:20 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sun, 17 Sep
 2023 16:49:20 +0800
Received: from [192.168.125.57] (113.72.144.67) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sun, 17 Sep
 2023 16:49:19 +0800
Message-ID: <0ce30520-7286-dfa0-2e16-e5145b950945@starfivetech.com>
Date:   Sun, 17 Sep 2023 16:49:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 02/19] PCI: microchip: Move pcie-microchip-host.c to
 plda directory
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230915102243.59775-1-minda.chen@starfivetech.com>
 <20230915102243.59775-3-minda.chen@starfivetech.com>
 <20230916-outcome-obedient-fda7043bcca7@spud>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20230916-outcome-obedient-fda7043bcca7@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.67]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/9/16 8:09, Conor Dooley wrote:
> On Fri, Sep 15, 2023 at 06:22:26PM +0800, Minda Chen wrote:
>> For Microchip Polarfire PCIe host is PLDA XpressRich IP,
>> move to plda directory. Prepare for refactor the codes.
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>>  MAINTAINERS                                        |  2 +-
>>  drivers/pci/controller/Kconfig                     |  9 +--------
>>  drivers/pci/controller/Makefile                    |  2 +-
>>  drivers/pci/controller/plda/Kconfig                | 14 ++++++++++++++
>>  drivers/pci/controller/plda/Makefile               |  2 ++
>>  .../controller/{ => plda}/pcie-microchip-host.c    |  2 +-
>>  6 files changed, 20 insertions(+), 11 deletions(-)
>>  create mode 100644 drivers/pci/controller/plda/Kconfig
>>  create mode 100644 drivers/pci/controller/plda/Makefile
>>  rename drivers/pci/controller/{ => plda}/pcie-microchip-host.c (99%)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 90f13281d297..b1050804e6d2 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -16647,7 +16647,7 @@ M:	Daire McNamara <daire.mcnamara@microchip.com>
>>  L:	linux-pci@vger.kernel.org
>>  S:	Supported
>>  F:	Documentation/devicetree/bindings/pci/microchip*
>> -F:	drivers/pci/controller/*microchip*
>> +F:	drivers/pci/controller/plda/*microchip*
> 
> The riscv patchwork automation is complaining that you have added
> maintainers pattern errors with this patch. If you run
> ./scripts/get_maintainer.pl --self-test=patterns
> it'll tell you what the bad pattern is. Not sure why I never actually
> dumped the output of that test into the failure report, so I can't
> immediately tell you what is wrong.
Okay. I will check this.
