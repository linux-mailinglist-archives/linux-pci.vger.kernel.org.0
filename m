Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF7A47E31
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 11:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfFQJVQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 05:21:16 -0400
Received: from foss.arm.com ([217.140.110.172]:42712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfFQJVQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jun 2019 05:21:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DCB8344;
        Mon, 17 Jun 2019 02:21:15 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29EBE3F246;
        Mon, 17 Jun 2019 02:21:14 -0700 (PDT)
Date:   Mon, 17 Jun 2019 10:21:08 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        marc.zyngier@arm.com, bhelgaas@google.com,
        linux-arm-kernel@lists.infradead.org, rgummal@xilinx.com
Subject: Re: [PATCH v4] PCI: xilinx-nwl: Fix Multi MSI data programming
Message-ID: <20190617092108.GA18020@e121166-lin.cambridge.arm.com>
References: <1560334679-9206-1-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560334679-9206-1-git-send-email-bharat.kumar.gogada@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 12, 2019 at 03:47:59PM +0530, Bharat Kumar Gogada wrote:
> The current Multi MSI data programming fails if multiple end points
> requesting MSI and multi MSI are connected with switch, i.e the current
> multi MSI data being given is not considering the number of vectors
> being requested in case of multi MSI.
> Ex: Two EP's connected via switch, EP1 requesting single MSI first,
> EP2 requesting Multi MSI of count four. The current code gives
> MSI data 0x0 to EP1 and 0x1 to EP2, but EP2 can modify lower two bits
> due to which EP2 also sends interrupt with MSI data 0x0 which results
> in always invoking virq of EP1 due to which EP2 MSI interrupt never
> gets handled.
> 
> Fix Multi MSI data programming with required alignment by
> using number of vectors being requested.
> 
> Fixes: ab597d35ef11 ("PCI: xilinx-nwl: Add support for Xilinx NWL PCIe
> Host Controller")
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
> V4:
>  - Using a different bitmap registration API whcih serves single and multi
>    MSI requests.
> ---
>  drivers/pci/controller/pcie-xilinx-nwl.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Applied to pci/xilinx for v5.3, please have a look and check if
the commit log I wrote provides a clear description of the issue.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 81538d7..a9e07b8 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -483,15 +483,13 @@ static int nwl_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  	int i;
>  
>  	mutex_lock(&msi->lock);
> -	bit = bitmap_find_next_zero_area(msi->bitmap, INT_PCI_MSI_NR, 0,
> -					 nr_irqs, 0);
> -	if (bit >= INT_PCI_MSI_NR) {
> +	bit = bitmap_find_free_region(msi->bitmap, INT_PCI_MSI_NR,
> +				      get_count_order(nr_irqs));
> +	if (bit < 0) {
>  		mutex_unlock(&msi->lock);
>  		return -ENOSPC;
>  	}
>  
> -	bitmap_set(msi->bitmap, bit, nr_irqs);
> -
>  	for (i = 0; i < nr_irqs; i++) {
>  		irq_domain_set_info(domain, virq + i, bit + i, &nwl_irq_chip,
>  				domain->host_data, handle_simple_irq,
> @@ -509,7 +507,8 @@ static void nwl_irq_domain_free(struct irq_domain *domain, unsigned int virq,
>  	struct nwl_msi *msi = &pcie->msi;
>  
>  	mutex_lock(&msi->lock);
> -	bitmap_clear(msi->bitmap, data->hwirq, nr_irqs);
> +	bitmap_release_region(msi->bitmap, data->hwirq,
> +			      get_count_order(nr_irqs));
>  	mutex_unlock(&msi->lock);
>  }
>  
> -- 
> 2.7.4
> 
