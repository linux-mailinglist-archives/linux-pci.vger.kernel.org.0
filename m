Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED55B77CAFF
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 12:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbjHOKMe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 06:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbjHOKMQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 06:12:16 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6358E63;
        Tue, 15 Aug 2023 03:12:11 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 60D9B24E277;
        Tue, 15 Aug 2023 18:12:09 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 15 Aug
 2023 18:12:09 +0800
Received: from [192.168.125.127] (183.27.98.20) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 15 Aug
 2023 18:12:08 +0800
Message-ID: <f983f3cc-ebb5-18fb-891a-adc073742bb9@starfivetech.com>
Date:   Tue, 15 Aug 2023 18:12:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 06/11] PCI: plda: Add event interrupt codes and IRQ
 domain ops
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
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230814082016.104181-1-minda.chen@starfivetech.com>
 <20230814082016.104181-7-minda.chen@starfivetech.com>
 <20230814-episode-untidy-c66107a33ea0@wendy>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20230814-episode-untidy-c66107a33ea0@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.20]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/8/14 21:52, Conor Dooley wrote:
> On Mon, Aug 14, 2023 at 04:20:11PM +0800, Minda Chen wrote:
>> For PolarFire implements non-PLDA local interrupt events, most of
>> event interrupt process codes can not be re-used. PLDA implements
>> new codes and IRQ domain ops like PolarFire.
>> 
>> plda_handle_event adds a new IRQ num to event num mapping codes for
>> PLDA local event except DMA engine interrupt events. The DMA engine
>> interrupt events are implemented by vendors.
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> ---
>>  .../pci/controller/plda/pcie-microchip-host.c | 29 +++---
>>  drivers/pci/controller/plda/pcie-plda-host.c  | 99 +++++++++++++++++++
>>  drivers/pci/controller/plda/pcie-plda.h       | 19 ++++
>>  3 files changed, 133 insertions(+), 14 deletions(-)
>> 
>> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
>> index c28840315019..b42f1aac3ec3 100644
>> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
>> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
>> @@ -96,20 +96,21 @@
>>  #define EVENT_LOCAL_DMA_END_ENGINE_1		12
>>  #define EVENT_LOCAL_DMA_ERROR_ENGINE_0		13
>>  #define EVENT_LOCAL_DMA_ERROR_ENGINE_1		14
>> -#define EVENT_LOCAL_A_ATR_EVT_POST_ERR		15
>> -#define EVENT_LOCAL_A_ATR_EVT_FETCH_ERR		16
>> -#define EVENT_LOCAL_A_ATR_EVT_DISCARD_ERR	17
>> -#define EVENT_LOCAL_A_ATR_EVT_DOORBELL		18
>> -#define EVENT_LOCAL_P_ATR_EVT_POST_ERR		19
>> -#define EVENT_LOCAL_P_ATR_EVT_FETCH_ERR		20
>> -#define EVENT_LOCAL_P_ATR_EVT_DISCARD_ERR	21
>> -#define EVENT_LOCAL_P_ATR_EVT_DOORBELL		22
>> -#define EVENT_LOCAL_PM_MSI_INT_INTX		23
>> -#define EVENT_LOCAL_PM_MSI_INT_MSI		24
>> -#define EVENT_LOCAL_PM_MSI_INT_AER_EVT		25
>> -#define EVENT_LOCAL_PM_MSI_INT_EVENTS		26
>> -#define EVENT_LOCAL_PM_MSI_INT_SYS_ERR		27
>> -#define NUM_EVENTS				28
>> +#define NUM_MC_EVENTS				15
>> +#define EVENT_LOCAL_A_ATR_EVT_POST_ERR		(NUM_MC_EVENTS + EVENT_A_ATR_EVT_POST_ERR)
>> +#define EVENT_LOCAL_A_ATR_EVT_FETCH_ERR		(NUM_MC_EVENTS + EVENT_A_ATR_EVT_FETCH_ERR)
>> +#define EVENT_LOCAL_A_ATR_EVT_DISCARD_ERR	(NUM_MC_EVENTS + EVENT_A_ATR_EVT_DISCARD_ERR)
>> +#define EVENT_LOCAL_A_ATR_EVT_DOORBELL		(NUM_MC_EVENTS + EVENT_A_ATR_EVT_DOORBELL)
>> +#define EVENT_LOCAL_P_ATR_EVT_POST_ERR		(NUM_MC_EVENTS + EVENT_P_ATR_EVT_POST_ERR)
>> +#define EVENT_LOCAL_P_ATR_EVT_FETCH_ERR		(NUM_MC_EVENTS + EVENT_P_ATR_EVT_FETCH_ERR)
>> +#define EVENT_LOCAL_P_ATR_EVT_DISCARD_ERR	(NUM_MC_EVENTS + EVENT_P_ATR_EVT_DISCARD_ERR)
>> +#define EVENT_LOCAL_P_ATR_EVT_DOORBELL		(NUM_MC_EVENTS + EVENT_P_ATR_EVT_DOORBELL)
>> +#define EVENT_LOCAL_PM_MSI_INT_INTX		(NUM_MC_EVENTS + EVENT_PM_MSI_INT_INTX)
>> +#define EVENT_LOCAL_PM_MSI_INT_MSI		(NUM_MC_EVENTS + EVENT_PM_MSI_INT_MSI)
>> +#define EVENT_LOCAL_PM_MSI_INT_AER_EVT		(NUM_MC_EVENTS + EVENT_PM_MSI_INT_AER_EVT)
>> +#define EVENT_LOCAL_PM_MSI_INT_EVENTS		(NUM_MC_EVENTS + EVENT_PM_MSI_INT_EVENTS)
>> +#define EVENT_LOCAL_PM_MSI_INT_SYS_ERR		(NUM_MC_EVENTS + EVENT_PM_MSI_INT_SYS_ERR)
>> +#define NUM_EVENTS				(NUM_MC_EVENTS + NUM_PLDA_EVENTS)
> 
> Is this change not in the wrong patch & should be changed alongside the
> movement of defines? 
EVENT_xxx is new added one for PLDA codes and The event num start from 0. This add association to PLDA events.
Maybe this can be moved to patch8 or a new patch.
