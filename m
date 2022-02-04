Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256424A9D99
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 18:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbiBDRYH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 12:24:07 -0500
Received: from foss.arm.com ([217.140.110.172]:58300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234250AbiBDRYH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Feb 2022 12:24:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE0811396;
        Fri,  4 Feb 2022 09:24:06 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B108A3F774;
        Fri,  4 Feb 2022 09:24:05 -0800 (PST)
Date:   Fri, 4 Feb 2022 17:24:00 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 02/23] PCI: aardvark: Fix reading MSI interrupt number
Message-ID: <20220204172400.GA4867@lpieralisi>
References: <20220110015018.26359-1-kabel@kernel.org>
 <20220110015018.26359-3-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220110015018.26359-3-kabel@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 10, 2022 at 02:49:57AM +0100, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> In advk_pcie_handle_msi() the authors expect that when bit i in the W1C
> register PCIE_MSI_STATUS_REG is cleared, the PCIE_MSI_PAYLOAD_REG is
> updated to contain the MSI number corresponding to index i.
> 
> Experiments show that this is not so, and instead PCIE_MSI_PAYLOAD_REG
> always contains the number of the last received MSI, overall.
> 
> Do not read PCIE_MSI_PAYLOAD_REG register for determining MSI interrupt
> number. Since Aardvark already forbids more than 32 interrupts and uses
> own allocated hwirq numbers, the msi_idx already corresponds to the
> received MSI number.
> 
> Fixes: 8c39d710363c ("PCI: aardvark: Add Aardvark PCI host controller driver")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
>  drivers/pci/controller/pci-aardvark.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 62baddd2ca95..fd95ad64c887 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -1393,7 +1393,6 @@ static void advk_pcie_remove_irq_domain(struct advk_pcie *pcie)
>  static void advk_pcie_handle_msi(struct advk_pcie *pcie)
>  {
>  	u32 msi_val, msi_mask, msi_status, msi_idx;
> -	u16 msi_data;
>  
>  	msi_mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
>  	msi_val = advk_readl(pcie, PCIE_MSI_STATUS_REG);
> @@ -1403,13 +1402,9 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
>  		if (!(BIT(msi_idx) & msi_status))
>  			continue;
>  
> -		/*
> -		 * msi_idx contains bits [4:0] of the msi_data and msi_data
> -		 * contains 16bit MSI interrupt number
> -		 */
>  		advk_writel(pcie, BIT(msi_idx), PCIE_MSI_STATUS_REG);
> -		msi_data = advk_readl(pcie, PCIE_MSI_PAYLOAD_REG) & PCIE_MSI_DATA_MASK;

Ok, it took me a while to understand how aardvark handles MSIs.

IIUC, msi_data contains the payload of the latest MSI write received.

First off, I believe that using a Linux IRQ number for MSI data
(payload)(I guess you rely on its truncated bits [4:0] to trigger the
related MSI IRQs, which I believe is questionable - if not broken) is
not a good idea.

Is my understanding correct ?

This patch and the following one are fixing this. Given that this is IRQ
domain code if Marc can cast a look into it that would help me, to make
sure I have not missed anything.

Certainly replacing the MSI payload to the HW irq number makes sense to
me (and this patch makes sense too, I think mainline code may miss some
MSI IRQs if I understand this patch correctly).

Lorenzo

> -		generic_handle_irq(msi_data);
> +		if (generic_handle_domain_irq(pcie->msi_inner_domain, msi_idx) == -EINVAL)
> +			dev_err_ratelimited(&pcie->pdev->dev, "unexpected MSI 0x%02x\n", msi_idx);
>  	}
>  
>  	advk_writel(pcie, PCIE_ISR0_MSI_INT_PENDING,
> -- 
> 2.34.1
> 
