Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463E54EB3CA
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 21:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240265AbiC2TDe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 15:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbiC2TDb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 15:03:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDF3E099C;
        Tue, 29 Mar 2022 12:01:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECBE46162C;
        Tue, 29 Mar 2022 19:01:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2B4C340F2;
        Tue, 29 Mar 2022 19:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648580507;
        bh=zmRc1Th/j5QwOkMG4yVilp9T1uLHvXOHgL2MG5CYuXg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=M5/QgDbDxisDUTOkhuJ4a+8RS8JMz0zuBLWCisqA28vVKgt2XWKPwjlsFgpwtFSC7
         C8BypYvqtD9BPZORGMJG8JdyuPzoCoQp0JPOC7y6SO4C+opEgzWesjiaDlf/l0b/6d
         +V7Vd1YCQ52g9QZNekqV11o355+jV8DfqzN5PLqbox4bNeVqmLi6sQChxSDC44Nj+8
         ikhcJ2X+cKNFoPnBS3H5JOJr2/T+PaZI6WOm7hEXwwTgBHFo96AJA+p6rS4B+2W7KV
         T8zo1Cw+qqz+LotyL0/bARGnWaHgM6I2Yh1fkaNLQqmcw/0HWhywDfjV/DhpyvX+TI
         LZa0rgbSQY/Ag==
Date:   Tue, 29 Mar 2022 14:01:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     bhelgaas@google.com, arnd@arndb.de, hch@infradead.org,
        akpm@linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: Remove the deprecated "pci-dma-compat.h" API
Message-ID: <20220329190145.GA1622303@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25d93797bd5a5bae5c7613ec42c01ecd7c69cd17.1646855282.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 09, 2022 at 08:50:39PM +0100, Christophe JAILLET wrote:
> Now that all usages of the functions defined in "pci-dma-compat.h" have
> been removed, it is time to remove this file as well.
> 
> In order not to break builds, move the "#include <linux/dma-mapping.h>"
> that was in "pci-dma-compat.h" into "include/linux/pci.h"
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Please also update the Documentation/PCI/pci.rst references to
pci_set_dma_mask() and friends.

> ---
>  include/linux/pci-dma-compat.h | 129 ---------------------------------
>  include/linux/pci.h            |   3 +-
>  2 files changed, 1 insertion(+), 131 deletions(-)
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
> index 60d423d8f0c4..7f924b5edd1d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2472,8 +2472,7 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
>  void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
>  #endif
>  
> -/* Provide the legacy pci_dma_* API */
> -#include <linux/pci-dma-compat.h>
> +#include <linux/dma-mapping.h>
>  
>  #define pci_printk(level, pdev, fmt, arg...) \
>  	dev_printk(level, &(pdev)->dev, fmt, ##arg)
> -- 
> 2.32.0
> 
