Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F465486D32
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 23:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245075AbiAFW2K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 17:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245066AbiAFW2J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 17:28:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCA7C061245;
        Thu,  6 Jan 2022 14:28:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BE01B8238B;
        Thu,  6 Jan 2022 22:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E646EC36AE5;
        Thu,  6 Jan 2022 22:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641508086;
        bh=gKZ9uIwSdNuZH5C6HWnebUa0lLQlAO3jYGmiE36lrYQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Lzt6GUJEvlZDm6pykPtS2nGPKa45LwuUmO3oH6HYqtVOZMFlCSeaFDCBe/WcBlT83
         G0vT4vxW2FIXeaulodFEGpLVwNlclRlm0oZbVLk3D5jnwCzoJS9qug3vdY+rlE6AKB
         dNUjIPYyPbBay5KJnlehTf7P4SMnqdNN6LIws6GelL53Dn6C6Z1tKQTVA+x2artUbi
         /jwdAS6R0fgT7vQMvLSdwaGyNDhF2g6yaImjDNMg0RLRrQ5j5vPg2ObJJa5i43PC1n
         1hFT56KQAiAq9usT7+nBMjoeLswLzY5z+lu805RVrvT+BtQBpF0n9oS2zEbDvpgCHo
         t4Grht5Zb/gJg==
Date:   Thu, 6 Jan 2022 16:28:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 16/16] PCI: Remove usage of the deprecated
 "pci-dma-compat.h" API
Message-ID: <20220106222804.GA330366@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e965573211f8c81c8ba978cfbc21925810a662b1.1641500561.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 06, 2022 at 10:55:33PM +0100, Christophe JAILLET wrote:
> Final step, remove pci-dma-compat.h
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Obviously this has to be applied after all the others, so I assume
somebody else will take this.

> ---
>  include/linux/pci-dma-compat.h | 129 ---------------------------------
>  include/linux/pci.h            |   3 -
>  2 files changed, 132 deletions(-)
>  delete mode 100644 include/linux/pci-dma-compat.h
> 
> diff --git a/include/linux/pci-dma-compat.h b/include/linux/pci-dma-compat.h
> deleted file mode 100644
> index 249d4d7fbf18..000000000000
> --- a/include/linux/pci-dma-compat.h
> +++ /dev/null
> @@ -1,129 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/* include this file if the platform implements the dma_ DMA Mapping API
> - * and wants to provide the pci_ DMA Mapping API in terms of it */
> -
> -#ifndef _ASM_GENERIC_PCI_DMA_COMPAT_H
> -#define _ASM_GENERIC_PCI_DMA_COMPAT_H
> -
> -#include <linux/dma-mapping.h>
> -
> -/* This defines the direction arg to the DMA mapping routines. */
> -#define PCI_DMA_BIDIRECTIONAL	DMA_BIDIRECTIONAL
> -#define PCI_DMA_TODEVICE	DMA_TO_DEVICE
> -#define PCI_DMA_FROMDEVICE	DMA_FROM_DEVICE
> -#define PCI_DMA_NONE		DMA_NONE
> -
> -static inline void *
> -pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
> -		     dma_addr_t *dma_handle)
> -{
> -	return dma_alloc_coherent(&hwdev->dev, size, dma_handle, GFP_ATOMIC);
> -}
> -
> -static inline void *
> -pci_zalloc_consistent(struct pci_dev *hwdev, size_t size,
> -		      dma_addr_t *dma_handle)
> -{
> -	return dma_alloc_coherent(&hwdev->dev, size, dma_handle, GFP_ATOMIC);
> -}
> -
> -static inline void
> -pci_free_consistent(struct pci_dev *hwdev, size_t size,
> -		    void *vaddr, dma_addr_t dma_handle)
> -{
> -	dma_free_coherent(&hwdev->dev, size, vaddr, dma_handle);
> -}
> -
> -static inline dma_addr_t
> -pci_map_single(struct pci_dev *hwdev, void *ptr, size_t size, int direction)
> -{
> -	return dma_map_single(&hwdev->dev, ptr, size, (enum dma_data_direction)direction);
> -}
> -
> -static inline void
> -pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
> -		 size_t size, int direction)
> -{
> -	dma_unmap_single(&hwdev->dev, dma_addr, size, (enum dma_data_direction)direction);
> -}
> -
> -static inline dma_addr_t
> -pci_map_page(struct pci_dev *hwdev, struct page *page,
> -	     unsigned long offset, size_t size, int direction)
> -{
> -	return dma_map_page(&hwdev->dev, page, offset, size, (enum dma_data_direction)direction);
> -}
> -
> -static inline void
> -pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
> -	       size_t size, int direction)
> -{
> -	dma_unmap_page(&hwdev->dev, dma_address, size, (enum dma_data_direction)direction);
> -}
> -
> -static inline int
> -pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
> -	   int nents, int direction)
> -{
> -	return dma_map_sg(&hwdev->dev, sg, nents, (enum dma_data_direction)direction);
> -}
> -
> -static inline void
> -pci_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg,
> -	     int nents, int direction)
> -{
> -	dma_unmap_sg(&hwdev->dev, sg, nents, (enum dma_data_direction)direction);
> -}
> -
> -static inline void
> -pci_dma_sync_single_for_cpu(struct pci_dev *hwdev, dma_addr_t dma_handle,
> -		    size_t size, int direction)
> -{
> -	dma_sync_single_for_cpu(&hwdev->dev, dma_handle, size, (enum dma_data_direction)direction);
> -}
> -
> -static inline void
> -pci_dma_sync_single_for_device(struct pci_dev *hwdev, dma_addr_t dma_handle,
> -		    size_t size, int direction)
> -{
> -	dma_sync_single_for_device(&hwdev->dev, dma_handle, size, (enum dma_data_direction)direction);
> -}
> -
> -static inline void
> -pci_dma_sync_sg_for_cpu(struct pci_dev *hwdev, struct scatterlist *sg,
> -		int nelems, int direction)
> -{
> -	dma_sync_sg_for_cpu(&hwdev->dev, sg, nelems, (enum dma_data_direction)direction);
> -}
> -
> -static inline void
> -pci_dma_sync_sg_for_device(struct pci_dev *hwdev, struct scatterlist *sg,
> -		int nelems, int direction)
> -{
> -	dma_sync_sg_for_device(&hwdev->dev, sg, nelems, (enum dma_data_direction)direction);
> -}
> -
> -static inline int
> -pci_dma_mapping_error(struct pci_dev *pdev, dma_addr_t dma_addr)
> -{
> -	return dma_mapping_error(&pdev->dev, dma_addr);
> -}
> -
> -#ifdef CONFIG_PCI
> -static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask)
> -{
> -	return dma_set_mask(&dev->dev, mask);
> -}
> -
> -static inline int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
> -{
> -	return dma_set_coherent_mask(&dev->dev, mask);
> -}
> -#else
> -static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask)
> -{ return -EIO; }
> -static inline int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
> -{ return -EIO; }
> -#endif
> -
> -#endif
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d4308f847e58..ba8771eaf380 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2455,9 +2455,6 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
>  void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
>  #endif
>  
> -/* Provide the legacy pci_dma_* API */
> -#include <linux/pci-dma-compat.h>
> -
>  #define pci_printk(level, pdev, fmt, arg...) \
>  	dev_printk(level, &(pdev)->dev, fmt, ##arg)
>  
> -- 
> 2.32.0
> 
