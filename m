Return-Path: <linux-pci+bounces-1493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C13A81F800
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 12:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4771F212DE
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 11:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9296FDE;
	Thu, 28 Dec 2023 11:58:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6382A7462;
	Thu, 28 Dec 2023 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 41A0624E257;
	Thu, 28 Dec 2023 19:58:32 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 28 Dec
 2023 19:58:32 +0800
Received: from [192.168.125.85] (183.27.97.107) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 28 Dec
 2023 19:58:31 +0800
Message-ID: <987e4153-236a-4bc6-9db6-f9ad58846267@starfivetech.com>
Date: Thu, 28 Dec 2023 19:58:30 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 12/21] PCI: microchip: Add request_event_irq()
 callback function
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
 <20231214072839.2367-13-minda.chen@starfivetech.com>
 <ZYxKYhVycTOfbDTI@lpieralisi>
From: Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <ZYxKYhVycTOfbDTI@lpieralisi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag



On 2023/12/28 0:01, Lorenzo Pieralisi wrote:
> On Thu, Dec 14, 2023 at 03:28:30PM +0800, Minda Chen wrote:
>> PolarFire implements specific PCIe interrupts except PLDA local interrupt.
> 
> Please explain to me what you want to say here.
> >> For lack of MSI controller, these interrupts have to be added to global
>> event field. PolarFire PCIe driver also register additional interrupt
>> symbol name.
> 
> And here.
> 
The sentence mean architecture should have an advance interrupt 
controller can support MSI interrupt and these new added interrupts should
be added to MSI interrupt. (Like ARM GIC high level version)

Maybe this commit message should be deleted. The commit message should claim
why add request_event_irq() callback function.

Add this callback function is for vendor register the interrupt handler and
the name of new added PCIe interrupts. 

"new added PCIe interrupts" is mean microchip new added interrupt.
#define EVENT_PCIE_L2_EXIT                      0
#define EVENT_PCIE_HOTRST_EXIT                  1
#define EVENT_PCIE_DLUP_EXIT                    2
#define EVENT_SEC_TX_RAM_SEC_ERR                3
#define EVENT_SEC_RX_RAM_SEC_ERR                4
#define EVENT_SEC_PCIE2AXI_RAM_SEC_ERR          5
#define EVENT_SEC_AXI2PCIE_RAM_SEC_ERR          6
#define EVENT_DED_TX_RAM_DED_ERR                7
#define EVENT_DED_RX_RAM_DED_ERR                8
#define EVENT_DED_PCIE2AXI_RAM_DED_ERR          9
#define EVENT_DED_AXI2PCIE_RAM_DED_ERR          10


>> PolarFire PCIe contain total 28 interrupts event while PLDA contain 13
>> local interrupts event, interrupt to event num mapping is different.
> 
> It "is different" in different platforms ? Is that correct ?
> 
yes
>> So add a callback function to support different IRQ register function.
>> Also Add PLDA default handler function, which will be moved to pcie-
>> plda-host.c in moving codes patch.
> 
> As I said before, a patch is a single self-contained change, don't
> refer to other patches, they may or may not be merged or even exist
> by the time this one hits mainline.
> 
> Lorenzo
> 
OK. I will delete the "which will be moved to pcie-plda-host.c in 
moving codes patch" and change the commit message.

>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>>  .../pci/controller/plda/pcie-microchip-host.c | 31 ++++++++++++++++---
>>  drivers/pci/controller/plda/pcie-plda.h       |  5 +++
>>  2 files changed, 32 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
>> index 7b3f4f74745d..624e4e2e97d3 100644
>> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
>> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
>> @@ -643,6 +643,11 @@ static irqreturn_t mc_event_handler(int irq, void *dev_id)
>>  	return IRQ_HANDLED;
>>  }
>>  
>> +static irqreturn_t plda_event_handler(int irq, void *dev_id)
>> +{
>> +	return IRQ_HANDLED;
>> +}
>> +
>>  static void plda_handle_event(struct irq_desc *desc)
>>  {
>>  	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
>> @@ -804,6 +809,17 @@ static int mc_pcie_init_clks(struct device *dev)
>>  	return 0;
>>  }
>>  
>> +static int mc_request_event_irq(struct plda_pcie_rp *plda, int event_irq,
>> +				int event)
>> +{
>> +	return devm_request_irq(plda->dev, event_irq, mc_event_handler,
>> +				0, event_cause[event].sym, plda);
>> +}
>> +
>> +static const struct plda_event mc_event = {
>> +	.request_event_irq = mc_request_event_irq,
>> +};
>> +
>>  static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
>>  {
>>  	struct device *dev = port->dev;
>> @@ -905,7 +921,9 @@ static void mc_disable_interrupts(struct mc_pcie *port)
>>  	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
>>  }
>>  
>> -static int plda_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp *port)
>> +static int plda_init_interrupts(struct platform_device *pdev,
>> +				struct plda_pcie_rp *port,
>> +				const struct plda_event *event)
>>  {
>>  	struct device *dev = &pdev->dev;
>>  	int irq;
>> @@ -929,8 +947,13 @@ static int plda_init_interrupts(struct platform_device *pdev, struct plda_pcie_r
>>  			return -ENXIO;
>>  		}
>>  
>> -		ret = devm_request_irq(dev, event_irq, mc_event_handler,
>> -				       0, event_cause[i].sym, port);
>> +		if (event->request_event_irq)
>> +			ret = event->request_event_irq(port, event_irq, i);
>> +		else
>> +			ret = devm_request_irq(dev, event_irq,
>> +					       plda_event_handler,
>> +					       0, NULL, port);
>> +
>>  		if (ret) {
>>  			dev_err(dev, "failed to request IRQ %d\n", event_irq);
>>  			return ret;
>> @@ -984,7 +1007,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
>>  		return ret;
>>  
>>  	/* Address translation is up; safe to enable interrupts */
>> -	ret = plda_init_interrupts(pdev, &port->plda);
>> +	ret = plda_init_interrupts(pdev, &port->plda, &mc_event);
>>  	if (ret)
>>  		return ret;
>>  
>> diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
>> index e3d35cef9894..28ed1374e1de 100644
>> --- a/drivers/pci/controller/plda/pcie-plda.h
>> +++ b/drivers/pci/controller/plda/pcie-plda.h
>> @@ -121,6 +121,11 @@ struct plda_pcie_rp {
>>  	int num_events;
>>  };
>>  
>> +struct plda_event {
>> +	int (*request_event_irq)(struct plda_pcie_rp *pcie,
>> +				 int event_irq, int event);
>> +};
>> +
>>  void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>>  			    phys_addr_t axi_addr, phys_addr_t pci_addr,
>>  			    size_t size);
>> -- 
>> 2.17.1
>> 

