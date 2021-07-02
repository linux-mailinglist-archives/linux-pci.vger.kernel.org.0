Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143323BA510
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 23:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhGBVh7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jul 2021 17:37:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229648AbhGBVh7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Jul 2021 17:37:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B354613FB;
        Fri,  2 Jul 2021 21:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625261726;
        bh=z7+DYpKgnBsH4gmStBPaBdAdXn1cQOKI9dZV8b3NXNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O5U27fRGk74UARzD45f9wKHvk3EX5YX9VineY9x+lwNVRwPZbVg77sihAIfNO7bNm
         weYJvacJPidHc0BudFJcR7hZSbxiqcCQXtvEMs1z0wL1XwcHPkI2wPlapiJ5EcWwUP
         baXFw8lRJ4jHmFrq38eMWFLA8KHdhmnxIzlcfaonjKEnN120lM9QSAPm7ayVP5k28l
         pfgei4X66MYPcjbKZdkHFaFp9aPyC3aslYtleoTzjJn0/9fN6REv/Tg1WTk6koylwa
         1j9lu3YAcCXGqY3OfWgAnnlGEIHjoxhMdYTfGxEpb3S3EUfjgPBeTt37NnpHBMs4gz
         /1OGn4ZesjZqg==
Received: by pali.im (Postfix)
        id 35F7167D; Fri,  2 Jul 2021 23:35:24 +0200 (CEST)
Date:   Fri, 2 Jul 2021 23:35:24 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/42] PCI: aardvark: Add support for more than 32 MSI
 interrupts
Message-ID: <20210702213524.mhpu24dxlh2fe7zm@pali>
References: <20210506153153.30454-1-pali@kernel.org>
 <20210506153153.30454-21-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210506153153.30454-21-pali@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

FYI this one patch does not work. Please drop it.

On Thursday 06 May 2021 17:31:31 Pali Rohár wrote:
> Aardvark HW can handle MSI interrupt with any 16-bit number. Received MSI
> interrupt number is visible in PCIE_MSI_PAYLOAD_REG register after clearing
> corresponding bit in PCIE_MSI_STATUS_REG register.

After doing heavy load testing I figured out that PCIE_MSI_PAYLOAD_REG
register is either buggy or unusable or there is missing some other
configuration as it contains in most cases just content of the last
received memory write operation to MSI doorbell register. And also even
after clearing corresponding bit in PCIE_MSI_STATUS_REG register.

Therefore we should avoid usage of PCIE_MSI_PAYLOAD_REG register
completely. Which implies that it is needed to use only corresponding
bit from PCIE_MSI_STATUS_REG register and so only 32 MSI interrupts are
supported.

I will address removal of PCIE_MSI_STATUS_REG register in other followup
patch.

> The first 32 interrupt numbers are currently stored in linear map in MSI
> inner domain. Store the rest in dynamic radix tree for space efficiency.
> 
> Free interrupt numbers (available for MSI inner domain allocation) for the
> first 32 interrupts are currently stored in a bitmap. For the rest,
> introduce a linked list of allocated regions.
> 
> In the most common scenario there is only one PCIe card connected on boards
> with Armada 3720 SoC. Since in Multi-MSI mode the PCIe device can use at
> most 32 interrupts, all these interrupts are allocated in the linear map of
> MSI inner domain and marked as used in the bitmap.
> 
> For less common scenarios with PCIe devices with multiple functions or with
> a PCIe Bridge with packet switches with more connected PCIe devices more
> than 32 interrupts are requested. In this case, store each interrupt range
> from each interrupt request into the linked list as one node. In the worst
> case every PCIe function will occupy one node in this linked list.
> 
> This change allows to use all 32 Multi-MSI interrupts on every connected
> PCIe card on the Turris Mox router with Mox G module.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Marek Behún <kabel@kernel.org>
> ---
>  drivers/pci/controller/pci-aardvark.c | 71 ++++++++++++++++++++++++---
>  1 file changed, 64 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 199015215779..d74e84b0e689 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -178,11 +178,18 @@
>  #define RETRAIN_WAIT_MAX_RETRIES	10
>  #define RETRAIN_WAIT_USLEEP_US		2000
>  
> -#define MSI_IRQ_NUM			32
> +#define MSI_IRQ_LINEAR_COUNT		32
> +#define MSI_IRQ_TOTAL_COUNT		65536
>  
>  #define CFG_RD_UR_VAL			0xffffffff
>  #define CFG_RD_CRS_VAL			0xffff0001
>  
> +struct advk_msi_range {
> +	struct list_head list;
> +	u16 first;
> +	u16 count;
> +};
> +
>  struct advk_pcie {
>  	struct platform_device *pdev;
>  	void __iomem *base;
> @@ -193,7 +200,8 @@ struct advk_pcie {
>  	struct irq_chip msi_bottom_irq_chip;
>  	struct irq_chip msi_irq_chip;
>  	struct msi_domain_info msi_domain_info;
> -	DECLARE_BITMAP(msi_used, MSI_IRQ_NUM);
> +	DECLARE_BITMAP(msi_used_linear, MSI_IRQ_LINEAR_COUNT);
> +	struct list_head msi_used_radix;
>  	struct mutex msi_used_lock;
>  	int link_gen;
>  	struct pci_bridge_emul bridge;
> @@ -885,12 +893,44 @@ static int advk_msi_irq_domain_alloc(struct irq_domain *domain,
>  				     unsigned int nr_irqs, void *args)
>  {
>  	struct advk_pcie *pcie = domain->host_data;
> +	struct advk_msi_range *msi_range, *msi_range_prev, *msi_range_next;
> +	unsigned int first, count, last;
>  	int hwirq, i;
>  
>  	mutex_lock(&pcie->msi_used_lock);
> -	hwirq = bitmap_find_free_region(pcie->msi_used, MSI_IRQ_NUM,
> +
> +	/* First few used interrupt numbers are marked in bitmap (the most common) */
> +	hwirq = bitmap_find_free_region(pcie->msi_used_linear, MSI_IRQ_LINEAR_COUNT,
>  					order_base_2(nr_irqs));
> +
> +	/* And rest used interrupt numbers are stored in linked list as ranges */
> +	if (hwirq < 0) {
> +		count = 1 << order_base_2(nr_irqs);
> +		msi_range_prev = list_entry(&pcie->msi_used_radix, typeof(*msi_range), list);
> +		do {
> +			msi_range_next = list_next_entry(msi_range_prev, list);
> +			last = list_entry_is_head(msi_range_next, &pcie->msi_used_radix, list)
> +				? MSI_IRQ_TOTAL_COUNT : msi_range_next->first;
> +			first = list_entry_is_head(msi_range_prev, &pcie->msi_used_radix, list)
> +				? MSI_IRQ_LINEAR_COUNT : round_up(msi_range_prev->first +
> +								  msi_range_prev->count, count);
> +			if (first + count > last) {
> +				msi_range_prev = msi_range_next;
> +				continue;
> +			}
> +			msi_range = kzalloc(sizeof(*msi_range), GFP_KERNEL);
> +			if (msi_range) {
> +				hwirq = first;
> +				msi_range->first = first;
> +				msi_range->count = count;
> +				list_add(&msi_range->list, &msi_range_prev->list);
> +			}
> +			break;
> +		} while (!list_entry_is_head(msi_range_next, &pcie->msi_used_radix, list));
> +	}
> +
>  	mutex_unlock(&pcie->msi_used_lock);
> +
>  	if (hwirq < 0)
>  		return -ENOSPC;
>  
> @@ -908,9 +948,20 @@ static void advk_msi_irq_domain_free(struct irq_domain *domain,
>  {
>  	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
>  	struct advk_pcie *pcie = domain->host_data;
> +	struct advk_msi_range *msi_range;
>  
>  	mutex_lock(&pcie->msi_used_lock);
> -	bitmap_release_region(pcie->msi_used, d->hwirq, order_base_2(nr_irqs));
> +	if (d->hwirq < MSI_IRQ_LINEAR_COUNT) {
> +		bitmap_release_region(pcie->msi_used_linear, d->hwirq, order_base_2(nr_irqs));
> +	} else {
> +		list_for_each_entry(msi_range, &pcie->msi_used_radix, list) {
> +			if (msi_range->first != d->hwirq)
> +				continue;
> +			list_del(&msi_range->list);
> +			kfree(msi_range);
> +			break;
> +		}
> +	}
>  	mutex_unlock(&pcie->msi_used_lock);
>  }
>  
> @@ -967,6 +1018,7 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
>  	struct msi_domain_info *msi_di;
>  
>  	mutex_init(&pcie->msi_used_lock);
> +	INIT_LIST_HEAD(&pcie->msi_used_radix);
>  
>  	bottom_ic = &pcie->msi_bottom_irq_chip;
>  
> @@ -982,9 +1034,14 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
>  		MSI_FLAG_MULTI_PCI_MSI;
>  	msi_di->chip = msi_ic;
>  
> +	/*
> +	 * Aardvark HW can handle MSI interrupt with any 16bit number.
> +	 * For optimization first few interrupts are allocated in linear map
> +	 * (which is common scenario) and rest are allocated in radix tree.
> +	 */
>  	pcie->msi_inner_domain =
> -		irq_domain_add_linear(NULL, MSI_IRQ_NUM,
> -				      &advk_msi_domain_ops, pcie);
> +		__irq_domain_add(NULL, MSI_IRQ_LINEAR_COUNT, MSI_IRQ_TOTAL_COUNT, 0,
> +				 &advk_msi_domain_ops, pcie);
>  	if (!pcie->msi_inner_domain)
>  		return -ENOMEM;
>  
> @@ -1052,7 +1109,7 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
>  	msi_val = advk_readl(pcie, PCIE_MSI_STATUS_REG);
>  	msi_status = msi_val & ((~msi_mask) & PCIE_MSI_ALL_MASK);
>  
> -	for (msi_idx = 0; msi_idx < MSI_IRQ_NUM; msi_idx++) {
> +	for (msi_idx = 0; msi_idx < BITS_PER_TYPE(msi_status); msi_idx++) {
>  		if (!(BIT(msi_idx) & msi_status))
>  			continue;
>  
> -- 
> 2.20.1
> 
