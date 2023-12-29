Return-Path: <linux-pci+bounces-1533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA4A81FCE7
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 04:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E12FB242AA
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 03:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3DB17FA;
	Fri, 29 Dec 2023 03:46:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C1F23BB;
	Fri, 29 Dec 2023 03:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 0434624E255;
	Fri, 29 Dec 2023 11:46:12 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 29 Dec
 2023 11:46:12 +0800
Received: from [192.168.125.85] (183.27.96.32) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 29 Dec
 2023 11:46:10 +0800
Message-ID: <fa9be81b-d81f-49a2-b879-0b9ada317e11@starfivetech.com>
Date: Fri, 29 Dec 2023 11:46:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 11/21] PCI: microchip: Add num_events field to struct
 plda_pcie_rp
Content-Language: en-US
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: Conor Dooley <conor@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>, Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Daire McNamara <daire.mcnamara@microchip.com>, "Emil
 Renner Berthing" <emil.renner.berthing@canonical.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	"Palmer Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	"Philipp Zabel" <p.zabel@pengutronix.de>, Mason Huo
	<mason.huo@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
References: <20231214072839.2367-1-minda.chen@starfivetech.com>
 <20231214072839.2367-12-minda.chen@starfivetech.com>
 <ZYxJDIf1NDoEZkBJ@lpieralisi>
From: Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <ZYxJDIf1NDoEZkBJ@lpieralisi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag



On 2023/12/27 23:55, Lorenzo Pieralisi wrote:
> On Thu, Dec 14, 2023 at 03:28:29PM +0800, Minda Chen wrote:
>> The event num is different in other platform. For re-using interrupt
>> process codes, replace macros with variable.
> 
> "The number of events is different across platforms. In order to
> share interrupt processing code, add a variable that defines the
> number of events so that it can be set per-platform instead of
> hardcoding it".
> 
> Lorenzo
> 
Thanks for reviewing. Happy new year!

All the maintainers:
 Happy new year!

>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>>  drivers/pci/controller/plda/pcie-microchip-host.c | 8 +++++---
>>  drivers/pci/controller/plda/pcie-plda.h           | 1 +
>>  2 files changed, 6 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
>> index 506e6eeadc76..7b3f4f74745d 100644
>> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
>> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
>> @@ -654,7 +654,7 @@ static void plda_handle_event(struct irq_desc *desc)
>>  
>>  	events = mc_get_events(port);
>>  
>> -	for_each_set_bit(bit, &events, NUM_EVENTS)
>> +	for_each_set_bit(bit, &events, port->num_events)
>>  		generic_handle_domain_irq(port->event_domain, bit);
>>  
>>  	chained_irq_exit(chip, desc);
>> @@ -817,7 +817,8 @@ static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
>>  		return -EINVAL;
>>  	}
>>  
>> -	port->event_domain = irq_domain_add_linear(pcie_intc_node, NUM_EVENTS,
>> +	port->event_domain = irq_domain_add_linear(pcie_intc_node,
>> +						   port->num_events,
>>  						   &plda_event_domain_ops,
>>  						   port);
>>  	if (!port->event_domain) {
>> @@ -921,7 +922,7 @@ static int plda_init_interrupts(struct platform_device *pdev, struct plda_pcie_r
>>  	if (irq < 0)
>>  		return -ENODEV;
>>  
>> -	for (i = 0; i < NUM_EVENTS; i++) {
>> +	for (i = 0; i < port->num_events; i++) {
>>  		event_irq = irq_create_mapping(port->event_domain, i);
>>  		if (!event_irq) {
>>  			dev_err(dev, "failed to map hwirq %d\n", i);
>> @@ -1013,6 +1014,7 @@ static int mc_host_probe(struct platform_device *pdev)
>>  
>>  	bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
>>  	plda->bridge_addr = bridge_base_addr;
>> +	plda->num_events = NUM_EVENTS;
>>  
>>  	/* Allow enabling MSI by disabling MSI-X */
>>  	val = readl(bridge_base_addr + PCIE_PCI_IRQ_DW0);
>> diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
>> index 3deefd35fa5a..e3d35cef9894 100644
>> --- a/drivers/pci/controller/plda/pcie-plda.h
>> +++ b/drivers/pci/controller/plda/pcie-plda.h
>> @@ -118,6 +118,7 @@ struct plda_pcie_rp {
>>  	raw_spinlock_t lock;
>>  	struct plda_msi msi;
>>  	void __iomem *bridge_addr;
>> +	int num_events;
>>  };
>>  
>>  void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>> -- 
>> 2.17.1
>> 

