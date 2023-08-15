Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B1A77CB43
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 12:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbjHOKoL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 15 Aug 2023 06:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbjHOKns (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 06:43:48 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5B2198E;
        Tue, 15 Aug 2023 03:43:40 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 379AD7FD3;
        Tue, 15 Aug 2023 18:43:37 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 15 Aug
 2023 18:43:37 +0800
Received: from [192.168.125.127] (183.27.98.20) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 15 Aug
 2023 18:43:35 +0800
Message-ID: <5424ddb2-8f6b-ca15-c2f1-83e3cb9db7b6@starfivetech.com>
Date:   Tue, 15 Aug 2023 18:43:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 07/11] PCI: microchip: Rename IRQ init function
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
 <20230814082016.104181-8-minda.chen@starfivetech.com>
 <20230814-vividness-disgrace-115283ea6f9a@wendy>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20230814-vividness-disgrace-115283ea6f9a@wendy>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [183.27.98.20]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/8/14 21:55, Conor Dooley wrote:
> On Mon, Aug 14, 2023 at 04:20:12PM +0800, Minda Chen wrote:
>> Rename IRQ init function and prepare for re-use
>> IRQ init function.
>> 
>> rename list:
>> mc_init_interrupts -> plda_init_interrupts
>> mc_pcie_init_irq_domain-> plda_pcie_init_irq_domains
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> ---
>>  .../pci/controller/plda/pcie-microchip-host.c | 37 +++++++++++++------
>>  drivers/pci/controller/plda/pcie-plda.h       |  7 ++++
>>  2 files changed, 33 insertions(+), 11 deletions(-)
>> 
>> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
>> index b42f1aac3ec3..140e7ca1a5cb 100644
>> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
>> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
>> @@ -559,7 +559,7 @@ static int mc_pcie_init_clks(struct device *dev)
>>  	return 0;
>>  }
>>  
>> -static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
>> +static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port, struct plda_evt *evt)
>>  {
>>  	struct device *dev = port->dev;
>>  	struct device_node *node = dev->of_node;
>> @@ -572,8 +572,8 @@ static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
>>  		return -EINVAL;
>>  	}
>>  
>> -	port->event_domain = irq_domain_add_linear(pcie_intc_node, NUM_EVENTS,
>> -						   &event_domain_ops, port);
>> +	port->event_domain = irq_domain_add_linear(pcie_intc_node, port->num_events,
>> +						   evt->domain_ops, port);
>>  	if (!port->event_domain) {
>>  		dev_err(dev, "failed to get event domain\n");
>>  		of_node_put(pcie_intc_node);
>> @@ -658,14 +658,15 @@ static void mc_disable_interrupts(struct mc_pcie *port)
>>  	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
>>  }
>>  
>> -static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp *port)
>> +static int plda_init_interrupts(struct platform_device *pdev,
>> +				struct plda_pcie_rp *port, struct plda_evt *evt)
>>  {
>>  	struct device *dev = &pdev->dev;
>>  	int irq;
>>  	int i, intx_irq, msi_irq, event_irq;
>>  	int ret;
>>  
>> -	ret = mc_pcie_init_irq_domains(port);
>> +	ret = plda_pcie_init_irq_domains(port, evt);
>>  	if (ret) {
>>  		dev_err(dev, "failed creating IRQ domains\n");
>>  		return ret;
>> @@ -675,15 +676,18 @@ static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp
>>  	if (irq < 0)
>>  		return -ENODEV;
>>  
>> -	for (i = 0; i < NUM_EVENTS; i++) {
>> +	for (i = 0; i < port->num_events; i++) {
>>  		event_irq = irq_create_mapping(port->event_domain, i);
>>  		if (!event_irq) {
>>  			dev_err(dev, "failed to map hwirq %d\n", i);
>>  			return -ENXIO;
>>  		}
>>  
>> -		ret = devm_request_irq(dev, event_irq, mc_event_handler,
>> -				       0, event_cause[i].sym, port);
>> +		if (evt->request_evt_irq)
>> +			ret = evt->request_evt_irq(port, event_irq, i);
>> +		else
>> +			ret = devm_request_irq(dev, event_irq, plda_event_handler,
>> +					       0, NULL, port);
> 
> Is there a particular reason this if/else addition ended up in this
> patch, but the if/else addition in plda_handle_event() ended up in the
> next one?
> 
> Otherwise, this looks fine to me.
I forget to modify mc_handle_event()， So leave it to next patch.  
But I will ended up them in this patches. This patch is to modify, next patch is to move. 
