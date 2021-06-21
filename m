Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759873AEBAA
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 16:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhFUOtU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 10:49:20 -0400
Received: from foss.arm.com ([217.140.110.172]:35726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhFUOtU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jun 2021 10:49:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35629D6E;
        Mon, 21 Jun 2021 07:47:06 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCBE43F694;
        Mon, 21 Jun 2021 07:47:04 -0700 (PDT)
Date:   Mon, 21 Jun 2021 15:47:02 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Sandor Bodo-Merle <sbodomerle@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 2/2] PCI: iproc: Support multi-MSI only on uniprocessor
 kernel
Message-ID: <20210621144702.GD27516@lpieralisi>
References: <20210606123044.31250-1-sbodomerle@gmail.com>
 <20210606123044.31250-2-sbodomerle@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606123044.31250-2-sbodomerle@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 06, 2021 at 02:30:44PM +0200, Sandor Bodo-Merle wrote:
> The interrupt affinity scheme used by this driver is incompatible with
> multi-MSI as it implies moving the doorbell address to that of another MSI
> group.  This isn't possible for multi-MSI, as all the MSIs must have the
> same doorbell address. As such it is restricted to systems with a single
> CPU.
> 
> Fixes: fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
> Reported-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Sandor Bodo-Merle <sbodomerle@gmail.com>
> ---
>  drivers/pci/controller/pcie-iproc-msi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Can you just resend the series with the very minor changes requested
fixed please ?

Please carry/apply the review tags as well.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
> index 557d93dcb3bc..81b4effeb130 100644
> --- a/drivers/pci/controller/pcie-iproc-msi.c
> +++ b/drivers/pci/controller/pcie-iproc-msi.c
> @@ -171,7 +171,7 @@ static struct irq_chip iproc_msi_irq_chip = {
>  
>  static struct msi_domain_info iproc_msi_domain_info = {
>  	.flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> -		MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
> +		MSI_FLAG_PCI_MSIX,
>  	.chip = &iproc_msi_irq_chip,
>  };
>  
> @@ -250,6 +250,9 @@ static int iproc_msi_irq_domain_alloc(struct irq_domain *domain,
>  	struct iproc_msi *msi = domain->host_data;
>  	int hwirq, i;
>  
> +	if (msi->nr_cpus > 1 && nr_irqs > 1)
> +		return -EINVAL;
> +
>  	mutex_lock(&msi->bitmap_lock);
>  
>  	/*
> @@ -540,6 +543,9 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
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
