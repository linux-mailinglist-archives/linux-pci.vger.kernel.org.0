Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CFC39BC7B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 18:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhFDQEf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 12:04:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230410AbhFDQEf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 12:04:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00F7E613F3;
        Fri,  4 Jun 2021 16:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622822569;
        bh=6dzasOgEWu9CjupxUlAg8mGO8y6qtfmZ/ZEkjf7yUxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jpWXY0H221k4DW06WHX+qPJL3iG0J2EFMFoK4Up8y9yMY3cMBTZeAbsG4ND+jD9UR
         +qnNU7sPE78/47UIOWlqJEN+WyzTtQn588eH8coio31PoR2VeEjFphMPZokO1alaM0
         GuQX1lvWY0yyJ9Dz/OxifycNmA3pWJcOU5jwLEzIUaPUxJOzfRg1QghVZuAOODHklb
         f8FkA/mT1VK3m6xd2UEaNJsGKQZla6C4m7NudShV5kz+0xjMbslhbvuvwK6uEA3LVs
         zyBQsQTSF69we56w4S5FKHvp1GRcmParv2BcW5Ise2xPBNdDWkRhRVT4jNxK4NULND
         KNhO1tf1HsKUQ==
Received: by pali.im (Postfix)
        id 53168990; Fri,  4 Jun 2021 18:02:46 +0200 (CEST)
Date:   Fri, 4 Jun 2021 18:02:46 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/42] PCI: aardvark: Fix support for MSI interrupts
Message-ID: <20210604160246.vrix6fngictqpmbg@pali>
References: <20210506153153.30454-1-pali@kernel.org>
 <20210506153153.30454-18-pali@kernel.org>
 <87czu2q25h.wl-maz@kernel.org>
 <20210507144420.24aess56cc7ie2x2@pali>
 <875yzupl52.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875yzupl52.wl-maz@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 07 May 2021 17:24:25 Marc Zyngier wrote:
> On Fri, 07 May 2021 15:44:20 +0100,
> Pali Rohár <pali@kernel.org> wrote:
> > 
> > On Friday 07 May 2021 11:16:58 Marc Zyngier wrote:
> > > On Thu, 06 May 2021 16:31:28 +0100,
> > > Pali Rohár <pali@kernel.org> wrote:
> > > > 
> > > > MSI domain callback .alloc (implemented by advk_msi_irq_domain_alloc()
> > > > function) should return zero on success. Returning non-zero value indicates
> > > > failure. Fix return value of this function as in many cases it now returns
> > > > failure while allocating IRQs.
> > > > 
> > > > Aardvark hardware supports Multi-MSI and MSI_FLAG_MULTI_PCI_MSI is already
> > > > set. But when allocating MSI interrupt numbers for Multi-MSI, they need to
> > > > be properly aligned, otherwise endpoint devices send MSI interrupt with
> > > > incorrect numbers. Fix this issue by using function bitmap_find_free_region()
> > > > instead of bitmap_find_next_zero_area().
> > > > 
> > > > To ensure that aligned MSI interrupt numbers are used by endpoint devices,
> > > > we cannot use Linux virtual irq numbers (as they are random and not
> > > > properly aligned). So use hwirq numbers allocated by the function
> > > > bitmap_find_free_region(), which are aligned. This needs an update in
> > > > advk_msi_irq_compose_msi_msg() and advk_pcie_handle_msi() functions to do
> > > > proper mapping between Linux virtual irq numbers and hwirq MSI inner domain
> > > > numbers.
> > > > 
> > > > Also the whole 16-bit MSI number is stored in the PCIE_MSI_PAYLOAD_REG
> > > > register, not only lower 8 bits. Fix reading content of this register.
> > > > 
> > > > This change fixes receiving MSI interrupts on Armada 3720 boards and allows
> > > > using NVMe disks which use Multi-MSI feature with 3 interrupts.
> > > > 
> > > > Without this change, NVMe disks just freeze booting Linux on Armada 3720
> > > > boards as linux nvme-core.c driver is waiting 60s for an interrupt.
> > > > 
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > Reviewed-by: Marek Behún <kabel@kernel.org>
> > > > Cc: stable@vger.kernel.org # f21a8b1b6837 ("PCI: aardvark: Move to MSI handling using generic MSI support")
> > > > ---
> > > >  drivers/pci/controller/pci-aardvark.c | 32 ++++++++++++++++-----------
> > > >  1 file changed, 19 insertions(+), 13 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > > index 366d7480bc1b..498810c00b6d 100644
> > > > --- a/drivers/pci/controller/pci-aardvark.c
> > > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > > @@ -118,6 +118,7 @@
> > > >  #define PCIE_MSI_STATUS_REG			(CONTROL_BASE_ADDR + 0x58)
> > > >  #define PCIE_MSI_MASK_REG			(CONTROL_BASE_ADDR + 0x5C)
> > > >  #define PCIE_MSI_PAYLOAD_REG			(CONTROL_BASE_ADDR + 0x9C)
> > > > +#define     PCIE_MSI_DATA_MASK			GENMASK(15, 0)
> > > 
> > > See my comment below about this addition.
> > > 
> > > >  /* LMI registers base address and register offsets */
> > > >  #define LMI_BASE_ADDR				0x6000
> > > > @@ -861,7 +862,7 @@ static void advk_msi_irq_compose_msi_msg(struct irq_data *data,
> > > >  
> > > >  	msg->address_lo = lower_32_bits(msi_msg);
> > > >  	msg->address_hi = upper_32_bits(msi_msg);
> > > > -	msg->data = data->irq;
> > > > +	msg->data = data->hwirq;
> > > >  }
> > > >  
> > > >  static int advk_msi_set_affinity(struct irq_data *irq_data,
> > > > @@ -878,15 +879,11 @@ static int advk_msi_irq_domain_alloc(struct irq_domain *domain,
> > > >  	int hwirq, i;
> > > >  
> > > >  	mutex_lock(&pcie->msi_used_lock);
> > > > -	hwirq = bitmap_find_next_zero_area(pcie->msi_used, MSI_IRQ_NUM,
> > > > -					   0, nr_irqs, 0);
> > > > -	if (hwirq >= MSI_IRQ_NUM) {
> > > > -		mutex_unlock(&pcie->msi_used_lock);
> > > > -		return -ENOSPC;
> > > > -	}
> > > > -
> > > > -	bitmap_set(pcie->msi_used, hwirq, nr_irqs);
> > > > +	hwirq = bitmap_find_free_region(pcie->msi_used, MSI_IRQ_NUM,
> > > > +					order_base_2(nr_irqs));
> > > >  	mutex_unlock(&pcie->msi_used_lock);
> > > > +	if (hwirq < 0)
> > > > +		return -ENOSPC;
> > > >  
> > > >  	for (i = 0; i < nr_irqs; i++)
> > > >  		irq_domain_set_info(domain, virq + i, hwirq + i,
> > > > @@ -894,7 +891,7 @@ static int advk_msi_irq_domain_alloc(struct irq_domain *domain,
> > > >  				    domain->host_data, handle_simple_irq,
> > > >  				    NULL, NULL);
> > > >  
> > > > -	return hwirq;
> > > > +	return 0;
> > > >  }
> > > >  
> > > >  static void advk_msi_irq_domain_free(struct irq_domain *domain,
> > > > @@ -904,7 +901,7 @@ static void advk_msi_irq_domain_free(struct irq_domain *domain,
> > > >  	struct advk_pcie *pcie = domain->host_data;
> > > >  
> > > >  	mutex_lock(&pcie->msi_used_lock);
> > > > -	bitmap_clear(pcie->msi_used, d->hwirq, nr_irqs);
> > > > +	bitmap_release_region(pcie->msi_used, d->hwirq, order_base_2(nr_irqs));
> > > >  	mutex_unlock(&pcie->msi_used_lock);
> > > >  }
> > > >  
> > > > @@ -1048,6 +1045,7 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
> > > >  {
> > > >  	u32 msi_val, msi_mask, msi_status, msi_idx;
> > > >  	u16 msi_data;
> > > > +	int virq;
> > > >  
> > > >  	msi_mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
> > > >  	msi_val = advk_readl(pcie, PCIE_MSI_STATUS_REG);
> > > > @@ -1057,9 +1055,17 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
> > > >  		if (!(BIT(msi_idx) & msi_status))
> > > >  			continue;
> > > >  
> > > > +		/*
> > > > +		 * msi_idx contains bits [4:0] of the msi_data and msi_data
> > > > +		 * contains 16bit MSI interrupt number from MSI inner domain
> > > > +		 */
> > > >  		advk_writel(pcie, BIT(msi_idx), PCIE_MSI_STATUS_REG);
> > > > -		msi_data = advk_readl(pcie, PCIE_MSI_PAYLOAD_REG) & 0xFF;
> > > > -		generic_handle_irq(msi_data);
> > > > +		msi_data = advk_readl(pcie, PCIE_MSI_PAYLOAD_REG) & PCIE_MSI_DATA_MASK;
> > > 
> > > Can this be moved to a separate patch? It seems like this patch should
> > > only focus on correctly dealing with the irq/hwirq issues.
> > 
> > Well, hwirq is read from PCIE_MSI_PAYLOAD_REG register and it is 16-bit.
> > That is why I included this change in this patch, to fix also reading
> > IRQ number, not only setting IRQ number.
> 
> But this irq number still is a 5 bit quantity at this stage, and the

Yes, it should be 5 bit number. And in case wrongly programmed PCIe card
sends interrupt with "incorrect number" then A3720 PCIe controller
"should not try" to map this 16-bit unknown MSI interrupt number to
something in 5-bit domain (by setting upper bits to zero) and trying to
deliver this invalid interrupt via some existing virq.

Interrupt number of received MSI is stored in low 16 bits in
PCIE_MSI_PAYLOAD_REG register and you should use / validate whole
number, not just few bits from it.

> support for more than 32 MSIs only come in 3 patches later.
> 
> So this doesn't fix anything in this patch, and should be moved to
> patch 20.
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
