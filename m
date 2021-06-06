Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0A539CF73
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jun 2021 16:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhFFOMK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Jun 2021 10:12:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230003AbhFFOMJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Jun 2021 10:12:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E489F61244;
        Sun,  6 Jun 2021 14:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622988620;
        bh=yUZEbIw5/6My/k2Khzp9Q4HUwGrxBYQor2hSmenqpGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DV9enaeW/9m7jzRjFH7MSBN5KDKWQRXUqL80k3N44NfTU/EjDZZ059hzy+Psx7yf4
         ZSxs4Hfga4+grZJUWfMzM3dq9BBKZQ39JRWaaLY0phEtuKEdsGryCrUDxxUwxmNS5t
         9hTP9sxiZPSgw1zB0rC2R3rRoqjW4He4QC51gmUkIjO0CnXBXHMpE9ZlO0PE2+v4IO
         4vcWN6pXb9GPv8Vax1DKuJ27BXEpBS8g7NIM4qeFx7bTwWWsP4MuKkfA3nu3QViVzj
         x1T9uTh5uqbFmuhYiMn7xB2M0McFFNMH9ps6FAi7Xl/c61Mb7BDHlTEtAdr16UNIxw
         X5ufMOpU39nWQ==
Received: by pali.im (Postfix)
        id 1EB837B9; Sun,  6 Jun 2021 16:10:16 +0200 (CEST)
Date:   Sun, 6 Jun 2021 16:10:15 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Sandor Bodo-Merle <sbodomerle@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: iproc: fix the base vector number allocation
 for multi-MSI
Message-ID: <20210606141015.4dypxrzytxeh75qe@pali>
References: <20210606123044.31250-1-sbodomerle@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210606123044.31250-1-sbodomerle@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sunday 06 June 2021 14:30:43 Sandor Bodo-Merle wrote:
> Commit fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
> introduced multi-MSI support with a broken allocation mechanism (it failed
> to reserve the proper number of bits from the inner domain).  Natural
> alignment of the base vector number was also not guaranteed.
> 
> Fixes: fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
> Reported-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Sandor Bodo-Merle <sbodomerle@gmail.com>

Acked-by: Pali Rohár <pali@kernel.org>

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
