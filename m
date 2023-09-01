Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FD378F794
	for <lists+linux-pci@lfdr.de>; Fri,  1 Sep 2023 05:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244921AbjIAD6B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Aug 2023 23:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjIAD6B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Aug 2023 23:58:01 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE27CFE;
        Thu, 31 Aug 2023 20:57:56 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1474580CF;
        Fri,  1 Sep 2023 11:57:47 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 1 Sep
 2023 11:57:48 +0800
Received: from [192.168.125.127] (183.27.96.188) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 1 Sep
 2023 11:57:45 +0800
Message-ID: <837c3675-51d4-2eba-e8c6-3065d6e5d301@starfivetech.com>
Date:   Fri, 1 Sep 2023 11:57:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 08/11] PCI: microchip: Move IRQ init functions to
 pcie-plda-host.c
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
References: <20230825090129.65721-1-minda.chen@starfivetech.com>
 <20230825090129.65721-9-minda.chen@starfivetech.com>
 <20230825-sip-pentagon-e1760dcfce58@wendy>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20230825-sip-pentagon-e1760dcfce58@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.96.188]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/8/25 20:09, Conor Dooley wrote:
> Daire, can you look at this one too please?
> 
> On Fri, Aug 25, 2023 at 05:01:26PM +0800, Minda Chen wrote:
>> Move IRQ init functions to pcie-plda-host.c.
>> mc_handle_event() is merged to plda_handle_event().
>> Set most of the IRQ functions to static in pcie-plda-host.c
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> 
>> -void plda_handle_event(struct irq_desc *desc)
>> +static void plda_handle_event(struct irq_desc *desc)
>>  {
>>  	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
>>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>> @@ -264,14 +268,18 @@ void plda_handle_event(struct irq_desc *desc)
>>  
>>  	chained_irq_enter(chip, desc);
>>  
>> -	val = readl_relaxed(port->bridge_addr + ISTATUS_LOCAL);
>> -	origin = val;
>> -	val = val >> A_ATR_EVT_POST_ERR_SHIFT;
>> -	events |= val & 0xff;
>> -	if (origin & PM_MSI_INT_INTX_MASK)
>> -		events |= BIT(EVENT_PM_MSI_INT_INTX);
>> -	val = (origin >> PM_MSI_INT_MSI_SHIFT) & 0xf;
>> -	events |= val << EVENT_PM_MSI_INT_MSI;
>> +	if (port->ops && port->ops->get_events) {
> 
> I still don't love the dancing here. Can you just always register a
> callback?
> 
> Thanks,
> Conor.
> 
OK, Thanks.
>> +		events = port->ops->get_events(port);
>> +	} else {
>> +		val = readl_relaxed(port->bridge_addr + ISTATUS_LOCAL);
>> +		origin = val;
>> +		val = val >> A_ATR_EVT_POST_ERR_SHIFT;
>> +		events |= val & 0xff;
>> +		if (origin & PM_MSI_INT_INTX_MASK)
>> +			events |= BIT(EVENT_PM_MSI_INT_INTX);
>> +		val = (origin >> PM_MSI_INT_MSI_SHIFT) & 0xf;
>> +		events |= val << EVENT_PM_MSI_INT_MSI;
>> +	}
>>  
>>  	for_each_set_bit(bit, &events, port->num_events)
>>  		generic_handle_domain_irq(port->event_domain, bit);
