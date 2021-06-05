Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A41439CAD6
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jun 2021 22:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhFEUOo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Jun 2021 16:14:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhFEUOo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Jun 2021 16:14:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DBA86120E;
        Sat,  5 Jun 2021 20:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622923975;
        bh=oiClRQ8zNAbJxP7fr7sthVt6TG4eCBIs03ldx9MHKTU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pHygaBTofx5Zsas0gkUSSpCT0vgcTPSrpT6Fh1j1q/hLCci+7T7jPo2Tq+UNwXfZP
         zypnr1hvpJ7Msl0qOpvIFZ4iVVq8lWtitKrV4Y/0QY4V8ZWZuNTYy4Tyh1cGXTNUAj
         wanvE40shXxxW/ERojHgWuO7XtukY2L9lbwi51AN3HBQRVleXSZKFqCC3gF1Dg63ze
         Mtovy7QZS8DngLJZ5JK7kCbWsz7OI3f21IVdrlJ4hmTytgUUQJv+gRK3IEcvUK8BiD
         wXKFkM88scyhwOdT6K3K379+54FFEEutJp0VESbDo9RYRSt7yZgNrh1A+haLt7nbGZ
         u1P/+0gGqTcTg==
Date:   Sat, 5 Jun 2021 15:12:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sandor Bodo-Merle <sbodomerle@gmail.com>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Ray Jui <ray.jui@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: iproc: restrict multi-MSI to single core CPUs
Message-ID: <20210605201253.GA2318292@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210605171736.15755-1-sbodomerle@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lorenzo, linux-pci]

You can use this to find the appropriate cc list:

  ./scripts/get_maintainer.pl -f drivers/pci/controller/pcie-iproc-msi.c

I added Lorenzo and linux-pci for you.

Please update the subject line to:

  PCI: iproc: Support multi-MSI only on uniprocessor kernel

On Sat, Jun 05, 2021 at 07:17:36PM +0200, Sandor Bodo-Merle wrote:
> Commit fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
> introduced multi-MSI support with a broken allocation mechanism (it failed to
> reserve the proper number of bits from the inner domain).  Natural alignment of
> the base vector number was also not guaranteed.

This sounds like it's fixing *two* problems: the bitmap allocation
problem above, and the multi-MSI restriction problem below.  Please
split this into two separate patches if possible.

> The interrupt affinity scheme used by this driver is incompatible with
> multi-MSI as implies moving the doorbell address to that of another MSI group.
> This isn't possible for Multi-MSI, as all the MSIs must have the same doorbell
> address. As such it is restricted to systems with single CPU core.

Please rewrap the commit log to fit in 75 columns, so it still fits
in 80 when "git log" indents it.

s/as implies/as it implies/
s/Multi-MSI/multi-MSI/ (or capitalize them all; just be consistent)
s/with single CPU core/with a single CPU/

Using "core" here ("single core CPUs" or "single CPU core") suggests
that this has something to do with single-core CPUs vs multi-core
CPUs, but I don't think that's the case.

The patch says the important thing is whether the kernel supports one
CPU or several CPUs.  Whether they're in a single package or not is
irrelevant.  And apparently multi-MSI even works fine when you boot a
uniprocessor kernel (CONFIG_NR_CPUS=1) on a multi-processor machine.

> Fixes: fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
> Reported-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Sandor Bodo-Merle <sbodomerle@gmail.com>
> ---
>  drivers/pci/controller/pcie-iproc-msi.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git drivers/pci/controller/pcie-iproc-msi.c drivers/pci/controller/pcie-iproc-msi.c

Patch is incorrectly generated and lacks a path element, so doesn't
apply cleanly.  I don't know how you did this, but it should look like
this (note the leading "a/" and "b/"):

  diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c

> index eede4e8f3f75..2e42c460b626 100644
> --- drivers/pci/controller/pcie-iproc-msi.c
> +++ drivers/pci/controller/pcie-iproc-msi.c
> @@ -171,7 +171,7 @@ static struct irq_chip iproc_msi_irq_chip = {
>  
>  static struct msi_domain_info iproc_msi_domain_info = {
>  	.flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> -		MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
> +		MSI_FLAG_PCI_MSIX,
>  	.chip = &iproc_msi_irq_chip,
>  };
>  
> @@ -252,18 +252,15 @@ static int iproc_msi_irq_domain_alloc(struct irq_domain *domain,
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
> +	/* Allocate 'nr_irqs' multiplied by 'nr_cpus' number of MSI vectors each time */

Can you wrap this comment so it fits in 80 columns, please?  The rest
of the file is formatted for 80 columns, so it will be nice if this
matches.

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
> @@ -284,7 +281,8 @@ static void iproc_msi_irq_domain_free(struct irq_domain *domain,
>  	mutex_lock(&msi->bitmap_lock);
>  
>  	hwirq = hwirq_to_canonical_hwirq(msi, data->hwirq);
> -	bitmap_clear(msi->bitmap, hwirq, msi->nr_cpus);
> +	bitmap_release_region(msi->bitmap, hwirq,
> +			      order_base_2(msi->nr_cpus * nr_irqs));
>  
>  	mutex_unlock(&msi->bitmap_lock);
>  
> @@ -539,6 +537,9 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
>  	mutex_init(&msi->bitmap_lock);
>  	msi->nr_cpus = num_possible_cpus();
>  
> +	if (msi->nr_cpus == 1)
> +		iproc_msi_domain_info.flags |=  MSI_FLAG_MULTI_PCI_MSI;
> +
>  	msi->nr_irqs = of_irq_count(node);
>  	if (!msi->nr_irqs) {
>  		dev_err(pcie->dev, "found no MSI GIC interrupt\n");
> -- 
> 2.31.0
> 
