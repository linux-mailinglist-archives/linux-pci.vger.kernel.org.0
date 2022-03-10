Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17944D4FDD
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 18:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243509AbiCJRFx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 12:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238115AbiCJRFx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 12:05:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E702514CC90;
        Thu, 10 Mar 2022 09:04:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3193B82663;
        Thu, 10 Mar 2022 17:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB68C340E8;
        Thu, 10 Mar 2022 17:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646931887;
        bh=8mz7SJOvO9ILlkAo2lQX6lQ8PtHaY5yoaUCXExSLZOc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AUKhOpc7XaL8Bg9JPja3EQdUjEGre1tVxspOloh9beJ74U7HtPmOfOyWIOeiNlALF
         8PjubTGELAeiryOaT6KxY8q2JAzr+pqeoNw7+nesGLtoWgPjs6p0cDNozUXiA3W1/0
         Eg9Jxt2GdNxmXoBWnQWX4dDealkLYXusrtPZ37DakCe/HUcK6Wsf/TiYtW/BQ4qqQU
         khw5FZQOYQCsb21a+8Bg6agP6Jn9VsMdpkOFG8OOyzpcPXMbdjIsvH+5RT2zG52DX2
         hkLoGedQNYhVCpj9okmuY8+ab9dtXcHje1CT4VKRoN7xkRg1Ri0tY0ZT4ec/Ia5mu8
         BUSB1sbpkgLlQ==
Date:   Thu, 10 Mar 2022 11:04:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     bhelgaas@google.com, arnd@arndb.de, hch@infradead.org,
        akpm@linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: Remove the deprecated "pci-dma-compat.h" API
Message-ID: <20220310170445.GA163749@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25d93797bd5a5bae5c7613ec42c01ecd7c69cd17.1646855282.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

As of 1db333d9a51f ("Merge tag 'spi-fix-v5.17-rc7' of
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi"), all the
following still appear to be used:

  git grep -E "\<PCI_DMA_(BIDIRECTIONAL|TODEVICE|FROMDEVICE|NONE)"
  git grep -E "pci_(alloc|zalloc|free)_consistent"
  git grep -E "pci_(map|unmap)_single"
  git grep -E "\<pci_(map|unmap)_page"
  git grep -E "pci_(map|unmap)_sg"
  git grep -E "pci_dma_sync_"
  git grep pci_dma_mapping_error
  git grep -E "pci_set_.*dma_mask"

> In order not to break builds, move the "#include <linux/dma-mapping.h>"
> that was in "pci-dma-compat.h" into "include/linux/pci.h"
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>
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
