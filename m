Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8037E78F791
	for <lists+linux-pci@lfdr.de>; Fri,  1 Sep 2023 05:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243110AbjIADz4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Aug 2023 23:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbjIADzz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Aug 2023 23:55:55 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6A918C;
        Thu, 31 Aug 2023 20:55:48 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1EDDE24E2E2;
        Fri,  1 Sep 2023 11:55:46 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 1 Sep
 2023 11:55:47 +0800
Received: from [192.168.125.127] (183.27.96.188) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 1 Sep
 2023 11:55:44 +0800
Message-ID: <c10ee267-67b9-8546-94bd-beccf069f82a@starfivetech.com>
Date:   Fri, 1 Sep 2023 11:55:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 07/11] PCI: microchip: Rename IRQ init function
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
 <20230825090129.65721-8-minda.chen@starfivetech.com>
 <20230825-undusted-detached-1d67370c0a18@wendy>
 <20230825-numbness-easel-e0c827e97b99@wendy>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20230825-numbness-easel-e0c827e97b99@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.96.188]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/8/25 20:05, Conor Dooley wrote:
> On Fri, Aug 25, 2023 at 12:56:03PM +0100, Conor Dooley wrote:
>> Hey Minda,
>> 
>> I would like Daire to take a look at this, but I have a few more
>> smaller comments on this.
> 
> And another one that is nitpickery..
> 
>> 
>> On Fri, Aug 25, 2023 at 05:01:25PM +0800, Minda Chen wrote:
>> > Rename IRQ init function and prepare for re-use
>> > IRQ init function.
>> > Add plda_pcie_ops function pointer data structure,
>> > PolarFire PCIe uses function pointer to get
>> > their events num.
>> > 
>> > rename list:
>> > mc_init_interrupts()     -> plda_init_interrupts()
>> > mc_pcie_init_irq_domain()-> plda_pcie_init_irq_domains()
>> > 
>> > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> > ---
>> >  .../pci/controller/plda/pcie-microchip-host.c | 49 ++++++++++++++-----
>> >  drivers/pci/controller/plda/pcie-plda.h       | 14 ++++++
>> >  2 files changed, 51 insertions(+), 12 deletions(-)
>> > 
>> > diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
>> > index b1d5b5b3cee5..03e8e93ea7e4 100644
>> > --- a/drivers/pci/controller/plda/pcie-microchip-host.c
>> > +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
>> > @@ -416,7 +416,10 @@ static void mc_handle_event(struct irq_desc *desc)
>> >  
>> >  	chained_irq_enter(chip, desc);
>> >  
>> > -	events = get_events(port);
>> > +	if (port->ops && port->ops->get_events)
>> > +		events = port->ops->get_events(port);
>> > +	else
>> > +		events = get_events(port);
>> 
>> I don't really understand why we are going to having two different sorts
>> of event acquirers here. Is there a reason to not "just" register 
>> get_events() as the default callback & remove the special casing?
>> 
That's ok. All in get_events() callback
>> >  
>> >  	for_each_set_bit(bit, &events, NUM_EVENTS)
>> >  		generic_handle_domain_irq(port->event_domain, bit);
>> > @@ -562,11 +565,12 @@ static int mc_pcie_init_clks(struct device *dev)
>> >  	return 0;
>> >  }
>> >  
>> > -static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
>> > +static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port, struct plda_evt *evt)
>> 
>> Could you just spell out the word "event" in all of these data
>> structures and variables? The existing code seems to always spell it
>> out, so its a boon for consistency too.
>> 
ok
>> >  {
>> >  	struct device *dev = port->dev;
>> >  	struct device_node *node = dev->of_node;
>> >  	struct device_node *pcie_intc_node;
>> > +	const struct irq_domain_ops *ops;
>> >  
>> >  	/* Setup INTx */
>> >  	pcie_intc_node = of_get_next_child(node, NULL);
>> > @@ -575,8 +579,9 @@ static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
>> >  		return -EINVAL;
>> >  	}
>> >  
>> > -	port->event_domain = irq_domain_add_linear(pcie_intc_node, NUM_EVENTS,
>> > -						   &event_domain_ops, port);
>> > +	ops = evt->domain_ops ? evt->domain_ops : &event_domain_ops;
>> > +	port->event_domain = irq_domain_add_linear(pcie_intc_node, port->num_events,
>> > +						   ops, port);
>> >  	if (!port->event_domain) {
>> >  		dev_err(dev, "failed to get event domain\n");
>> >  		of_node_put(pcie_intc_node);
>> > @@ -661,14 +666,15 @@ static void mc_disable_interrupts(struct mc_pcie *port)
>> >  	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
>> >  }
>> >  
>> > -static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp *port)
>> > +static int plda_init_interrupts(struct platform_device *pdev,
>> > +				struct plda_pcie_rp *port, struct plda_evt *evt)
>> >  {
>> >  	struct device *dev = &pdev->dev;
>> >  	int irq;
>> >  	int i, intx_irq, msi_irq, event_irq;
>> >  	int ret;
>> >  
>> > -	ret = mc_pcie_init_irq_domains(port);
>> > +	ret = plda_pcie_init_irq_domains(port, evt);
>> >  	if (ret) {
>> >  		dev_err(dev, "failed creating IRQ domains\n");
>> >  		return ret;
>> > @@ -678,15 +684,18 @@ static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp
>> >  	if (irq < 0)
>> >  		return -ENODEV;
>> >  
>> > -	for (i = 0; i < NUM_EVENTS; i++) {
>> > +	for (i = 0; i < port->num_events; i++) {
>> >  		event_irq = irq_create_mapping(port->event_domain, i);
>> >  		if (!event_irq) {
>> >  			dev_err(dev, "failed to map hwirq %d\n", i);
>> >  			return -ENXIO;
>> >  		}
>> >  
>> > -		ret = devm_request_irq(dev, event_irq, mc_event_handler,
>> > -				       0, event_cause[i].sym, port);
>> > +		if (evt->request_evt_irq)
>> > +			ret = evt->request_evt_irq(port, event_irq, i);
>> > +		else
>> > +			ret = devm_request_irq(dev, event_irq, plda_event_handler,
>> > +					       0, NULL, port);
>> >  		if (ret) {
>> >  			dev_err(dev, "failed to request IRQ %d\n", event_irq);
>> >  			return ret;
>> > @@ -694,7 +703,7 @@ static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp
>> >  	}
>> >  
>> >  	intx_irq = irq_create_mapping(port->event_domain,
>> > -				      EVENT_LOCAL_PM_MSI_INT_INTX);
>> > +				      evt->intx_evt);
>> >  	if (!intx_irq) {
>> >  		dev_err(dev, "failed to map INTx interrupt\n");
>> >  		return -ENXIO;
>> > @@ -704,7 +713,7 @@ static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp
>> >  	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
>> >  
>> >  	msi_irq = irq_create_mapping(port->event_domain,
>> > -				     EVENT_LOCAL_PM_MSI_INT_MSI);
>> > +				     evt->msi_evt);
>> >  	if (!msi_irq)
>> >  		return -ENXIO;
>> >  
>> > @@ -717,6 +726,17 @@ static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp
>> >  	return 0;
>> >  }
>> >  
>> > +static int mc_request_evt_irq(struct plda_pcie_rp *plda, int event_irq,
>> > +			      int evt)
>> > +{
>> > +	return devm_request_irq(plda->dev, event_irq, mc_event_handler,
>> > +				0, event_cause[evt].sym, plda);
>> > +}
>> > +
>> > +static const struct plda_pcie_ops plda_ops = {
>> > +	.get_events = get_events,
>> > +};
>> 
>> This struct gets left behind in the microchip driver file, but is named
>> "plda_ops". That doesn't make sense to me, I think it should have an
>> "mc" prefix like other stuff in the file (and the microchip version of
>> get_events() should also grow a prefix IMO).
>> 
>> Thanks,
>> Conor.
>> 
OK. thanks.
>> > +
>> >  static int mc_platform_init(struct pci_config_window *cfg)
>> >  {
>> >  	struct device *dev = cfg->parent;
>> > @@ -724,6 +744,9 @@ static int mc_platform_init(struct pci_config_window *cfg)
>> >  	void __iomem *bridge_base_addr =
>> >  		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
>> >  	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
>> > +	struct plda_evt evt = {&event_domain_ops, mc_request_evt_irq,
>> > +			       EVENT_LOCAL_PM_MSI_INT_INTX,
>> > +			       EVENT_LOCAL_PM_MSI_INT_MSI};
> 
> Isn't this the normal style for struct initialisers?
> 	struct plda_evt evt = {
> 		&event_domain_ops, mc_request_evt_irq,
> 		EVENT_LOCAL_PM_MSI_INT_INTX,
> 		EVENT_LOCAL_PM_MSI_INT_MSI
> 	};
> 
>> >  	int ret;
>> >  
>> >  	/* Configure address translation table 0 for PCIe config space */
>> > @@ -740,7 +763,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
>> >  		return ret;
>> >  
>> >  	/* Address translation is up; safe to enable interrupts */
>> > -	ret = mc_init_interrupts(pdev, &port->plda);
>> > +	ret = plda_init_interrupts(pdev, &port->plda, &evt);
>> >  	if (ret)
>> >  		return ret;
>> >  
>> > @@ -761,6 +784,8 @@ static int mc_host_probe(struct platform_device *pdev)
>> >  
>> >  	plda = &port->plda;
>> >  	plda->dev = dev;
>> > +	plda->num_events = NUM_EVENTS;
>> > +	plda->ops = &plda_ops;
>> >  
>> >  	port->axi_base_addr = devm_platform_ioremap_resource(pdev, 1);
>> >  	if (IS_ERR(port->axi_base_addr))
>> > diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
>> > index 315d9874b899..ef33c1365b3e 100644
>> > --- a/drivers/pci/controller/plda/pcie-plda.h
>> > +++ b/drivers/pci/controller/plda/pcie-plda.h
>> > @@ -104,6 +104,12 @@
>> >  
>> >  #define PM_MSI_TO_MASK_OFFSET			19
>> >  
>> > +struct plda_pcie_rp;
>> > +
>> > +struct plda_pcie_ops {
>> > +	u32 (*get_events)(struct plda_pcie_rp *pcie);
>> > +};
>> > +
>> >  struct plda_msi {
>> >  	struct mutex lock;		/* Protect used bitmap */
>> >  	struct irq_domain *msi_domain;
>> > @@ -119,10 +125,18 @@ struct plda_pcie_rp {
>> >  	struct irq_domain *event_domain;
>> >  	raw_spinlock_t lock;
>> >  	struct plda_msi msi;
>> > +	const struct plda_pcie_ops *ops;
>> >  	void __iomem *bridge_addr;
>> >  	int num_events;
>> >  };
>> >  
>> > +struct plda_evt {
>> > +	const struct irq_domain_ops *domain_ops;
>> > +	int (*request_evt_irq)(struct plda_pcie_rp *pcie, int evt_irq, int event);
>> > +	int intx_evt;
>> > +	int msi_evt;
>> > +};
>> > +
>> >  void plda_handle_msi(struct irq_desc *desc);
>> >  int plda_allocate_msi_domains(struct plda_pcie_rp *port);
>> >  irqreturn_t plda_event_handler(int irq, void *dev_id);
>> > -- 
>> > 2.17.1
>> > 
> 
> 
