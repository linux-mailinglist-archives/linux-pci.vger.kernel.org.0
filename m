Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5283A37F0
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 01:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhFJXe4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 19:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhFJXe4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jun 2021 19:34:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06CB7613F5;
        Thu, 10 Jun 2021 23:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623367979;
        bh=5Ko7Rq/QR9NVEAWeDUO4huuw6PedGgRkrSNCex35rf8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GFK+Ul2jFGh65k/v5b7T9VsTFqtyubnntXYtmjh6kR8nK+TxY2ds5yqtq2V08LKDj
         Jl0zV1OTPmvXQqCQB6VVpr6M9jhOwodVjP+9UoGCY8/sHeksReku3w85KqebVhV3vv
         Sv1/7sZGyV8KeErIK2/o/b3dynhaNkGB7LcDctQLVHPrzgdwQrQWZdOvgwVna21e/s
         ApbU+aSnuJ9kGZNkRzDZq7xdqzLdVgRrrnKg1t+csR+ZwSsRVQ0kBG8NUr483maZKQ
         qQAblClE2Ot+PHlkeVdoXdlWlI8MjeuyRlUGNYegFov/osj5jV5y7MmOTi5r9lpqR3
         onyU7ipt8xQWw==
Date:   Thu, 10 Jun 2021 18:32:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sandor Bodo-Merle <sbodomerle@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH 1/2] PCI: iproc: fix the base vector number allocation
 for multi-MSI
Message-ID: <20210610233257.GA2794291@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210606123044.31250-1-sbodomerle@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 06, 2021 at 02:30:43PM +0200, Sandor Bodo-Merle wrote:
> Commit fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
> introduced multi-MSI support with a broken allocation mechanism (it failed
> to reserve the proper number of bits from the inner domain).  Natural
> alignment of the base vector number was also not guaranteed.
> 
> Fixes: fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
> Reported-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Sandor Bodo-Merle <sbodomerle@gmail.com>

Looks good to me; thanks for splitting this.  I think Lorenzo will
take care of this and maybe he'll also adjust the subject to match the
other patch, e.g.,

  - PCI: iproc: fix the base vector number allocation for multi-MSI
  + PCI: iproc: Fix multi-MSI base vector number allocation

> ---
>  drivers/pci/controller/pcie-iproc-msi.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
> index eede4e8f3f75..557d93dcb3bc 100644
> --- a/drivers/pci/controller/pcie-iproc-msi.c
> +++ b/drivers/pci/controller/pcie-iproc-msi.c
> @@ -252,18 +252,18 @@ static int iproc_msi_irq_domain_alloc(struct irq_domain *domain,
>  
>  	mutex_lock(&msi->bitmap_lock);
>  
> -	/* Allocate 'nr_cpus' number of MSI vectors each time */
> -	hwirq = bitmap_find_next_zero_area(msi->bitmap, msi->nr_msi_vecs, 0,
> -					   msi->nr_cpus, 0);
> -	if (hwirq < msi->nr_msi_vecs) {
> -		bitmap_set(msi->bitmap, hwirq, msi->nr_cpus);
> -	} else {
> -		mutex_unlock(&msi->bitmap_lock);
> -		return -ENOSPC;
> -	}
> +	/*
> +	 * Allocate 'nr_irqs' multiplied by 'nr_cpus' number of MSI vectors
> +	 * each time
> +	 */
> +	hwirq = bitmap_find_free_region(msi->bitmap, msi->nr_msi_vecs,
> +					order_base_2(msi->nr_cpus * nr_irqs));
>  
>  	mutex_unlock(&msi->bitmap_lock);
>  
> +	if (hwirq < 0)
> +		return -ENOSPC;
> +
>  	for (i = 0; i < nr_irqs; i++) {
>  		irq_domain_set_info(domain, virq + i, hwirq + i,
>  				    &iproc_msi_bottom_irq_chip,
> @@ -284,7 +284,8 @@ static void iproc_msi_irq_domain_free(struct irq_domain *domain,
>  	mutex_lock(&msi->bitmap_lock);
>  
>  	hwirq = hwirq_to_canonical_hwirq(msi, data->hwirq);
> -	bitmap_clear(msi->bitmap, hwirq, msi->nr_cpus);
> +	bitmap_release_region(msi->bitmap, hwirq,
> +			      order_base_2(msi->nr_cpus * nr_irqs));
>  
>  	mutex_unlock(&msi->bitmap_lock);
>  
> -- 
> 2.31.0
> 
