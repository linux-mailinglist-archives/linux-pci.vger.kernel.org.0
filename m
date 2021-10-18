Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50F2432366
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 17:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbhJRP66 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 11:58:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232164AbhJRP66 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Oct 2021 11:58:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A477860F8F;
        Mon, 18 Oct 2021 15:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634572607;
        bh=tf0GRc39vdX2SHA3Ux0uN2NpjHKrYc2rj+YpkB44cT0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rpM0lC63cWNM8YJbmEQtoVH8zTW7h34X30+4Q378NmP28vZn0j6ubrKB/hG8R213E
         U985IfzimQm5OQJLifs4Pp/0HTXk7EIDYAeY20pajDj0iRzytHQCkJU6MEkCvPt2mq
         mjEYzZ2utfRAyPfWY+NpZ3HzecVO4vshf3SA4mQlJddEyKxXyrR2gDMae2aPqvTN/W
         3MOSSQ7BJGQiiPyPq2DrxgXol7/6JFhyRG0BG1xHvCEwdvAd3V1su8PNuhaUyHQFBi
         4gxLZ3WwKtaW+KicRY5bsWF6OzHWInYIuwDhDxuzxV7rOT5fTTE/ScC8+IT8uydYc1
         6i7q2AO2JgSFQ==
Date:   Mon, 18 Oct 2021 10:56:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     hch@infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Remove the unused pci wrappers pci_pool_xxx()
Message-ID: <20211018155645.GA2238252@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018124110.214-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 18, 2021 at 08:41:09PM +0800, Cai Huoqing wrote:
> The wrappers around dma_pool_xxx should go away, so
> remove the unused pci wrappers.
> Prefer using dma_pool_xxx() instead of the pci wrappers
> pci_pool_xxx(), and the use of pci_pool_xxx was already
> removed.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Applied to pci/misc for v5.16, thanks!

I updated the commit log as:

  PCI: Remove unused pci_pool wrappers

  The pci_pool users have been converted to dma_pool.  Remove the unused
  pci_pool wrappers.

> ---
> v1->v2: *Revert the implicit inclusion of dma_pool.h
> 
>  include/linux/pci.h | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 94c75f3a4a19..74529d0388de 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1500,19 +1500,8 @@ int pci_set_vga_state(struct pci_dev *pdev, bool decode,
>  #define PCI_IRQ_ALL_TYPES \
>  	(PCI_IRQ_LEGACY | PCI_IRQ_MSI | PCI_IRQ_MSIX)
>  
> -/* kmem_cache style wrapper around pci_alloc_consistent() */
> -
>  #include <linux/dmapool.h>
>  
> -#define	pci_pool dma_pool
> -#define pci_pool_create(name, pdev, size, align, allocation) \
> -		dma_pool_create(name, &pdev->dev, size, align, allocation)
> -#define	pci_pool_destroy(pool) dma_pool_destroy(pool)
> -#define	pci_pool_alloc(pool, flags, handle) dma_pool_alloc(pool, flags, handle)
> -#define	pci_pool_zalloc(pool, flags, handle) \
> -		dma_pool_zalloc(pool, flags, handle)
> -#define	pci_pool_free(pool, vaddr, addr) dma_pool_free(pool, vaddr, addr)
> -
>  struct msix_entry {
>  	u32	vector;	/* Kernel uses to write allocated vector */
>  	u16	entry;	/* Driver uses to specify entry, OS writes */
> -- 
> 2.25.1
> 
