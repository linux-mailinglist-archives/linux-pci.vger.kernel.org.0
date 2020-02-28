Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56D58173588
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 11:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgB1Kou (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 05:44:50 -0500
Received: from foss.arm.com ([217.140.110.172]:36370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgB1Kou (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Feb 2020 05:44:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 156444B2;
        Fri, 28 Feb 2020 02:44:49 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3044F3F73B;
        Fri, 28 Feb 2020 02:44:48 -0800 (PST)
Date:   Fri, 28 Feb 2020 10:44:42 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>, maz@kernel.org
Subject: Re: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Message-ID: <20200228104442.GA2874@e121166-lin.cambridge.arm.com>
References: <1580400771-12382-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1580400771-12382-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20200225114013.GB6913@e121166-lin.cambridge.arm.com>
 <MN2PR02MB63365B50058B35AA37341BC9A5ED0@MN2PR02MB6336.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR02MB63365B50058B35AA37341BC9A5ED0@MN2PR02MB6336.namprd02.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+MarcZ, FHI]

On Tue, Feb 25, 2020 at 02:39:56PM +0000, Bharat Kumar Gogada wrote:

[...]

> > > +/* ECAM definitions */
> > > +#define ECAM_BUS_NUM_SHIFT		20
> > > +#define ECAM_DEV_NUM_SHIFT		12
> > 
> > You don't need these ECAM_* defines, you can use pci_generic_ecam_ops.
> Does this need separate ranges region for ECAM space ? 
> We have ECAM and controller space in same region.

You can create an ECAM window with pci_ecam_create where *cfgres
represent the ECAM area, I don't get what you mean by "same region".

Do you mean "contiguous" ? Or something else ?

> > > +
> > > +/**
> > > + * struct xilinx_cpm_pcie_port - PCIe port information
> > > + * @reg_base: Bridge Register Base
> > > + * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
> > > + * @irq: Interrupt number
> > > + * @root_busno: Root Bus number
> > > + * @dev: Device pointer
> > > + * @leg_domain: Legacy IRQ domain pointer
> > > + * @irq_misc: Legacy and error interrupt number  */ struct
> > > +xilinx_cpm_pcie_port {
> > > +	void __iomem *reg_base;
> > > +	void __iomem *cpm_base;
> > > +	u32 irq;
> > > +	u8 root_busno;
> > > +	struct device *dev;
> > > +	struct irq_domain *leg_domain;
> > > +	int irq_misc;
> > > +};
> > > +
> > > +static inline u32 pcie_read(struct xilinx_cpm_pcie_port *port, u32
> > > +reg) {
> > > +	return readl(port->reg_base + reg);
> > > +}
> > > +
> > > +static inline void pcie_write(struct xilinx_cpm_pcie_port *port,
> > > +			      u32 val, u32 reg)
> > > +{
> > > +	writel(val, port->reg_base + reg);
> > > +}
> > > +
> > > +static inline bool cpm_pcie_link_up(struct xilinx_cpm_pcie_port
> > > +*port) {
> > > +	return (pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
> > > +		XILINX_CPM_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
> > 
> > 	u32 val = pcie_read(port, XILINX_CPM_PCIE_REG_PSCR);
> > 
> > 	return val & XILINX_CPM_PCIE_REG_PSCR_LNKUP;
> > 
> > And this function call is not that informative anyway - it is used just to print a log
> > whose usefulness is questionable.
> We need this logging information customers are using this info in case
> of link down failure.

Out of curiosity, to do what ?

[...]

> > > +/**
> > > + * xilinx_cpm_pcie_intx_map - Set the handler for the INTx and mark
> > > +IRQ as valid
> > > + * @domain: IRQ domain
> > > + * @irq: Virtual IRQ number
> > > + * @hwirq: HW interrupt number
> > > + *
> > > + * Return: Always returns 0.
> > > + */
> > > +static int xilinx_cpm_pcie_intx_map(struct irq_domain *domain,
> > > +				    unsigned int irq, irq_hw_number_t hwirq) {
> > > +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> > 
> > INTX are level IRQs, the flow handler must be handle_level_irq.
> Accepted will change.
> > 
> > > +	irq_set_chip_data(irq, domain->host_data);
> > > +	irq_set_status_flags(irq, IRQ_LEVEL);
> > 
> > The way INTX are handled in this patch is wrong. You must set-up a chained IRQ
> > with the appropriate flow handler, current code uses an IRQ action and that's an
> > IRQ layer violation and it goes without saying that it is almost certainly broken.
> In our controller we use same irq line for controller errors and
> legacy errors.  we have two cases here where error interrupts are
> self-consumed by controller, and legacy interrupts are flow handled.
> Its not INTX handling alone for this IRQ line .  So chained IRQ can be
> used for self consumed interrupts too ?

No. In this specific case both solutions are not satisfying, we need to
give it some thought, I will talk to Marc (CC'ed) to find the best
option here going forward.

Thanks,
Lorenzo
