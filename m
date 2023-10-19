Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1697CF176
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 09:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjJSHjz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 03:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbjJSHjt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 03:39:49 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28B513A;
        Thu, 19 Oct 2023 00:39:45 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id BFBBE24E2A5;
        Thu, 19 Oct 2023 15:39:42 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 19 Oct
 2023 15:39:41 +0800
Received: from [192.168.125.85] (183.27.99.123) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 19 Oct
 2023 15:39:40 +0800
Message-ID: <f80c685e-4513-4962-9b47-d6c85d632dd2@starfivetech.com>
Date:   Thu, 19 Oct 2023 15:39:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 16/22] PCI: microchip: Add event IRQ domain ops to
 struct plda_event
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
 <20231011110514.107528-17-minda.chen@starfivetech.com>
 <20231018-worrier-sizably-b13023f54b36@spud>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20231018-worrier-sizably-b13023f54b36@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.99.123]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/10/18 19:30, Conor Dooley wrote:
> On Wed, Oct 11, 2023 at 07:05:08PM +0800, Minda Chen wrote:
>> PolarFire Implements none-PLDA event interrupts. So the whole event
>> domain ops can not be re-used.
> 
> IIRC, the reason things are like this is to work around the lack of an
> msi controller and are not as a result of changes made to the PLDA IP
> by us.
> 
Oh.  For this reason that new added interrupts have to add to 
global events field, not the MSI. I will add this to commit messages.
Thanks

>> PLDA event domain ops instances will be implemented
>> in later patch.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks,
> Conor.
> 
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> ---
>>  drivers/pci/controller/plda/pcie-microchip-host.c | 9 ++++++---
>>  drivers/pci/controller/plda/pcie-plda.h           | 1 +
>>  2 files changed, 7 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
>> index fca1520d56c9..2825c1f5563d 100644
>> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
>> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
>> @@ -811,13 +811,15 @@ static const struct plda_event_ops mc_event_ops = {
>>  };
>>  
>>  static const struct plda_event mc_event = {
>> +	.domain_ops             = &mc_event_domain_ops,
>>  	.event_ops              = &mc_event_ops,
>>  	.request_event_irq      = mc_request_event_irq,
>>  	.intx_event             = EVENT_LOCAL_PM_MSI_INT_INTX,
>>  	.msi_event              = EVENT_LOCAL_PM_MSI_INT_MSI,
>>  };
>>  
>> -static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
>> +static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port,
>> +				      const struct irq_domain_ops *ops)
>>  {
>>  	struct device *dev = port->dev;
>>  	struct device_node *node = dev->of_node;
>> @@ -831,7 +833,8 @@ static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
>>  	}
>>  
>>  	port->event_domain = irq_domain_add_linear(pcie_intc_node, port->num_events,
>> -						   &mc_event_domain_ops, port);
>> +						   ops, port);
>> +
>>  	if (!port->event_domain) {
>>  		dev_err(dev, "failed to get event domain\n");
>>  		of_node_put(pcie_intc_node);
>> @@ -930,7 +933,7 @@ static int plda_init_interrupts(struct platform_device *pdev,
>>  		return -EINVAL;
>>  	}
>>  
>> -	ret = plda_pcie_init_irq_domains(port);
>> +	ret = plda_pcie_init_irq_domains(port, event->domain_ops);
>>  	if (ret) {
>>  		dev_err(dev, "failed creating IRQ domains\n");
>>  		return ret;
>> diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
>> index 6571a4befac9..080932cbe8c4 100644
>> --- a/drivers/pci/controller/plda/pcie-plda.h
>> +++ b/drivers/pci/controller/plda/pcie-plda.h
>> @@ -129,6 +129,7 @@ struct plda_pcie_rp {
>>  };
>>  
>>  struct plda_event {
>> +	const struct irq_domain_ops *domain_ops;
>>  	const struct plda_event_ops *event_ops;
>>  	int (*request_event_irq)(struct plda_pcie_rp *pcie,
>>  				 int event_irq, int event);
>> -- 
>> 2.17.1
>> 
