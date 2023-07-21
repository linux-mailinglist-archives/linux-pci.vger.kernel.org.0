Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A92575BBAF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 03:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjGUBDu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 21:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGUBDt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 21:03:49 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893FA2718;
        Thu, 20 Jul 2023 18:03:44 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A166281B1;
        Fri, 21 Jul 2023 09:03:36 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 09:03:36 +0800
Received: from [192.168.125.127] (113.72.147.86) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 09:03:35 +0800
Message-ID: <2ace898a-c919-1388-28cd-0c39ac88dc62@starfivetech.com>
Date:   Fri, 21 Jul 2023 09:03:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 8/9] PCI: PLDA: starfive: Add JH7110 PCIe controller
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
 <20230719102057.22329-9-minda.chen@starfivetech.com>
 <20230720-vanquish-upcoming-1145e052c849@wendy>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20230720-vanquish-upcoming-1145e052c849@wendy>
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



On 2023/7/20 19:14, Conor Dooley wrote:
> On Wed, Jul 19, 2023 at 06:20:56PM +0800, Minda Chen wrote:
>> Add StarFive JH7110 SoC PCIe controller platform
>> driver codes.
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
>> ---
>>  MAINTAINERS                                 |   7 +
>>  drivers/pci/controller/plda/Kconfig         |   8 +
>>  drivers/pci/controller/plda/Makefile        |   1 +
>>  drivers/pci/controller/plda/pcie-plda.h     |  58 ++-
>>  drivers/pci/controller/plda/pcie-starfive.c | 415 ++++++++++++++++++++
>>  5 files changed, 487 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/pci/controller/plda/pcie-starfive.c
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f02618c2bdf5..b88a54a24ae5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20356,6 +20356,13 @@ S:	Supported
>>  F:	Documentation/devicetree/bindings/watchdog/starfive*
>>  F:	drivers/watchdog/starfive-wdt.c
>>  
>> +STARFIVE JH71x0 PCIE DRIVER
>> +M:	Minda Chen <minda.chen@starfivetech.com>
>> +L:	linux-pci@vger.kernel.org
>> +S:	Supported
>> +F:	Documentation/devicetree/bindings/pci/starfive*
>> +F:	drivers/pci/controller/plda/pcie-starfive.c
>> +
>>  STATIC BRANCH/CALL
>>  M:	Peter Zijlstra <peterz@infradead.org>
>>  M:	Josh Poimboeuf <jpoimboe@kernel.org>
>> diff --git a/drivers/pci/controller/plda/Kconfig b/drivers/pci/controller/plda/Kconfig
>> index a3c790545843..eaf72954da9f 100644
>> --- a/drivers/pci/controller/plda/Kconfig
>> +++ b/drivers/pci/controller/plda/Kconfig
>> @@ -24,4 +24,12 @@ config PCIE_MICROCHIP_HOST
>>  	  Say Y here if you want kernel to support the Microchip AXI PCIe
>>  	  Host Bridge driver.
>>  
>> +config PCIE_STARFIVE_HOST
>> +	tristate "StarFive PCIe host controller"
>> +	select PCIE_PLDA_HOST
> 
> Ditto here, I think this suffers from the same issue, although its
> probably only really randconfigs that'll trigger it.
> 
ok, thanks, I will change it with microchip.
>> +	help
>> +	  Say Y here if you want to support the StarFive PCIe controller
>> +	  in host mode. StarFive PCIe controller uses PLDA PCIe
>> +	  core.
>> +
>>  endmenu
