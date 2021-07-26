Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E30E3D54C2
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jul 2021 10:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhGZHTy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jul 2021 03:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232684AbhGZHTy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Jul 2021 03:19:54 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 890BF60F0F;
        Mon, 26 Jul 2021 08:00:23 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1m7vXB-000ySI-KO; Mon, 26 Jul 2021 09:00:21 +0100
MIME-Version: 1.0
Date:   Mon, 26 Jul 2021 09:00:21 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     "Thokala, Srikanth" <srikanth.thokala@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, robh+dt@kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>, kw@linux.com
Subject: Re: [PATCH v10 2/2] PCI: keembay: Add support for Intel Keem Bay
In-Reply-To: <PH0PR11MB559558D60263F29C168E6C5185069@PH0PR11MB5595.namprd11.prod.outlook.com>
References: <20210607154044.26074-1-srikanth.thokala@intel.com>
 <20210607154044.26074-3-srikanth.thokala@intel.com>
 <20210621162506.GA31511@lpieralisi>
 <PH0PR11MB559558D60263F29C168E6C5185069@PH0PR11MB5595.namprd11.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <2e4554241c532f03cce30beaf7b9921f@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: srikanth.thokala@intel.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, andriy.shevchenko@linux.intel.com, mgross@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com, mallikarjunappa.sangannavar@intel.com, kw@linux.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-06-25 04:23, Thokala, Srikanth wrote:
> Hi Lorenzo,
> 
>> -----Original Message-----
>> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Sent: Monday, June 21, 2021 10:23 PM
>> To: Thokala, Srikanth <srikanth.thokala@intel.com>; maz@kernel.org
>> Cc: robh+dt@kernel.org; linux-pci@vger.kernel.org;
>> devicetree@vger.kernel.org; andriy.shevchenko@linux.intel.com;
>> mgross@linux.intel.com; Raja Subramanian, Lakshmi Bai
>> <lakshmi.bai.raja.subramanian@intel.com>; Sangannavar, Mallikarjunappa
>> <mallikarjunappa.sangannavar@intel.com>; kw@linux.com
>> Subject: Re: [PATCH v10 2/2] PCI: keembay: Add support for Intel Keem 
>> Bay
>> 
>> [+Marc]
>> 
>> On Mon, Jun 07, 2021 at 09:10:44PM +0530, srikanth.thokala@intel.com
>> wrote:
>> [...]
>> 
>> > +static void keembay_pcie_msi_irq_handler(struct irq_desc *desc)
>> > +{
>> > +	struct keembay_pcie *pcie = irq_desc_get_handler_data(desc);
>> > +	struct irq_chip *chip = irq_desc_get_chip(desc);
>> > +	u32 val, mask, status;
>> > +	struct pcie_port *pp;
>> > +
>> > +	chained_irq_enter(chip, desc);
>> > +
>> > +	pp = &pcie->pci.pp;
>> > +	val = readl(pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
>> > +	mask = readl(pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
>> > +
>> > +	status = val & mask;
>> > +
>> > +	if (status & MSI_CTRL_INT) {
>> > +		dw_handle_msi_irq(pp);
>> > +		writel(status, pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
>> > +	}
>> > +
>> > +	chained_irq_exit(chip, desc);
>> > +}
>> > +
>> > +static int keembay_pcie_setup_msi_irq(struct keembay_pcie *pcie)
>> > +{
>> > +	struct dw_pcie *pci = &pcie->pci;
>> > +	struct device *dev = pci->dev;
>> > +	struct platform_device *pdev = to_platform_device(dev);
>> > +	int irq;
>> > +
>> > +	irq = platform_get_irq_byname(pdev, "pcie");
>> > +	if (irq < 0)
>> > +		return irq;
>> > +
>> > +	irq_set_chained_handler_and_data(irq, keembay_pcie_msi_irq_handler,
>> > +					 pcie);
>> > +
>> 
>> Ok this is yet another DWC MSI incantation and given that Marc worked
>> hard consolidating them let's have a look before we merge it.
>> 
>> IIUC - this IP relies on the DWC logic to handle MSIs + custom
>> registers to detect a pending MSI IRQ because the logic in
>> dw_chained_msi_irq() is *not* enough so you have to register
>> a driver specific chained handler. This looks similar to the dra7xx
>> driver MSI handling but I am not entirely convinced it is needed.
>> 
>> I assume this code in keembay_pcie_msi_irq_handler() is required
>> owing to additional IP logic on top of the standard DWC IP, in
>> particular the PCIE_REGS_INTERRUPT_STATUS write to "clear" the
>> IRQ.
>> 
>> We need more insights before merging it so please provide them.
>> 
>> pp = &pcie->pci.pp;
>> val = readl(pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
>> mask = readl(pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
>> 
>> status = val & mask;
>> 
>> if (status & MSI_CTRL_INT) {
>> 	dw_handle_msi_irq(pp);
>> 	writel(status, pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
>> }
> 
> Yes, your understanding is correct.
> 
> Additional registers PCIE_REGS_INTERRUPT_ENABLE/_STATUS are provided
> by IP to control the interrupts.
> 
> To receive MSI interrupts, SW must enable bit '8' of _ENABLE register.
> And once a MSI is raised by the End point, bit '8' of _STATUS register
> will be set and it needs to be cleared after servicing the interrupt.

What isn't clear here is whether the other bits that are written back
are significant and have a side effect. If only bit 8 is required,
shouldn't you *only* write this bit back?

Only you can know the answer to this, but it would be good if you
could actually document this deviation from the already wonky
DWC infrastructure.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
