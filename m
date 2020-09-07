Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888C625FF1B
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 18:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgIGQZ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 12:25:58 -0400
Received: from foss.arm.com ([217.140.110.172]:37268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729910AbgIGOcx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 10:32:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DE7A31B;
        Mon,  7 Sep 2020 07:32:11 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0901D3F73C;
        Mon,  7 Sep 2020 07:32:09 -0700 (PDT)
Date:   Mon, 7 Sep 2020 15:32:07 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH 5/6] x86/apic/msi: Use Real PCI DMA device when
 configuring IRTE
Message-ID: <20200907143207.GC9474@e121166-lin.cambridge.arm.com>
References: <20200728194945.14126-1-jonathan.derrick@intel.com>
 <20200728194945.14126-6-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728194945.14126-6-jonathan.derrick@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 28, 2020 at 01:49:44PM -0600, Jon Derrick wrote:
> VMD retransmits child device MSI/X with the VMD endpoint's requester-id.
> In order to support direct interrupt remapping of VMD child devices,
> ensure that the IRTE is programmed with the VMD endpoint's requester-id
> using pci_real_dma_dev().
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  arch/x86/kernel/apic/msi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'd need an x86 maintainer ACK on this patch.

Thanks,
Lorenzo

> diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
> index c2b2911feeef..7ca271b8d891 100644
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -189,7 +189,7 @@ int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  
>  	init_irq_alloc_info(&info, NULL);
>  	info.type = X86_IRQ_ALLOC_TYPE_MSI;
> -	info.msi_dev = dev;
> +	info.msi_dev = pci_real_dma_dev(dev);
>  
>  	domain = irq_remapping_get_irq_domain(&info);
>  	if (domain == NULL)
> -- 
> 2.27.0
> 
