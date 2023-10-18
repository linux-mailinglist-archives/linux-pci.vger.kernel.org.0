Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938F27CD991
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 12:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjJRKuo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 06:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRKun (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 06:50:43 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC74FF;
        Wed, 18 Oct 2023 03:50:38 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id E2B6F8068;
        Wed, 18 Oct 2023 18:50:31 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 18 Oct
 2023 18:50:32 +0800
Received: from [192.168.125.85] (183.27.98.194) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 18 Oct
 2023 18:50:30 +0800
Message-ID: <8dfdc8a5-339a-43e8-8d82-0597a6187336@starfivetech.com>
Date:   Wed, 18 Oct 2023 18:50:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/22] PCI: plda: Add PLDA default event IRQ handler
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20231011110514.107528-1-minda.chen@starfivetech.com>
 <20231011110514.107528-11-minda.chen@starfivetech.com>
 <20231018-escapable-chef-16572cda2c12@spud>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20231018-escapable-chef-16572cda2c12@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.194]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/10/18 18:44, Conor Dooley wrote:
> On Wed, Oct 11, 2023 at 07:05:02PM +0800, Minda Chen wrote:
>> Add PLDA default event IRQ handler.
>> This is first patch of refactoring IRQ handling codes.
>> The handler function will be referenced by later patch.
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> ---
>>  drivers/pci/controller/plda/pcie-plda-host.c | 5 +++++
>>  drivers/pci/controller/plda/pcie-plda.h      | 1 +
> 
> Dunno what hte PCI maintainers take is on this kind of thing, but this
> patch adds dead code, as there is no user for it until the follow-on
> patch you mention. Did someone ask you to split this out?
> 
> Cheers,
> Conor.
> 
No one. Previous this patch contain other codes. I modify this incorrect.  I will squash this with other patch. Thanks.
>>  2 files changed, 6 insertions(+)
>> 
>> diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
>> index 19131181897f..21ca6b460f5e 100644
>> --- a/drivers/pci/controller/plda/pcie-plda-host.c
>> +++ b/drivers/pci/controller/plda/pcie-plda-host.c
>> @@ -18,6 +18,11 @@
>>  
>>  #include "pcie-plda.h"
>>  
>> +irqreturn_t plda_event_handler(int irq, void *dev_id)
>> +{
>> +	return IRQ_HANDLED;
>> +}
>> +
>>  void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>>  			    phys_addr_t axi_addr, phys_addr_t pci_addr,
>>  			    size_t size)
>> diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
>> index 3deefd35fa5a..7ff7ff44c980 100644
>> --- a/drivers/pci/controller/plda/pcie-plda.h
>> +++ b/drivers/pci/controller/plda/pcie-plda.h
>> @@ -120,6 +120,7 @@ struct plda_pcie_rp {
>>  	void __iomem *bridge_addr;
>>  };
>>  
>> +irqreturn_t plda_event_handler(int irq, void *dev_id);
>>  void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>>  			    phys_addr_t axi_addr, phys_addr_t pci_addr,
>>  			    size_t size);
>> -- 
>> 2.17.1
>> 
