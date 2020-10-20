Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A06B2943D3
	for <lists+linux-pci@lfdr.de>; Tue, 20 Oct 2020 22:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409466AbgJTU0w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Oct 2020 16:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409465AbgJTU0v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Oct 2020 16:26:51 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF11B2225F;
        Tue, 20 Oct 2020 20:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603225611;
        bh=CoUtfiz1kJOgqm2tXEx9S/5pbvU3UpVwAFCiJ9qXS8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=xddF3ZR8ii5p//dq8dMtng4XHR7pnWAxY/TjbVcfI+6bRFtOtq1UAN1VpXQLh/mYZ
         xExhtl03serbIOClQrXJMMTsjdvJp03tbDbU9tOxhto0W6y1NSsKpEWFR6D8l/AEuC
         RMdjjeg5JHpmsxEoQd4tlYSuAqkmdDlaVvmMfawE=
Date:   Tue, 20 Oct 2020 15:26:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH 5/6] x86/apic/msi: Use Real PCI DMA device when
 configuring IRTE
Message-ID: <20201020202649.GA394225@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728194945.14126-6-jonathan.derrick@intel.com>
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

As Thomas (and Stephen) pointed out, this conflicts with 7ca435cf857d
("x86/irq: Cleanup the arch_*_msi_irqs() leftovers"), which removes
native_setup_msi_irqs().

Stephen resolved the conflict by dropping this hunk.  I would rather
just drop this patch completely from the PCI tree.  If I keep the
patch, (1) Linus will have to resolve the conflict, and worse, (2)
it's not clear what happened to the use of pci_real_dma_dev() here.
It will just vanish into the ether with no explanation other than
"this function was removed."

Is dropping this patch the correct thing to do?  Or do you need to add
pci_real_dma_dev() elsewhere to compensate?

> ---
>  arch/x86/kernel/apic/msi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
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
