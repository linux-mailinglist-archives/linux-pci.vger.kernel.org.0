Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17133418315
	for <lists+linux-pci@lfdr.de>; Sat, 25 Sep 2021 17:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343802AbhIYPPo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Sep 2021 11:15:44 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:20947 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343799AbhIYPPo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Sep 2021 11:15:44 -0400
Received: from [192.168.1.18] ([90.126.248.220])
        by mwinf5d25 with ME
        id yFE52500P4m3Hzu03FE6GX; Sat, 25 Sep 2021 17:14:07 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 25 Sep 2021 17:14:07 +0200
X-ME-IP: 90.126.248.220
Subject: Re: [PATCH] PCI: Remove the unused pci wrappers
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210925135255.328-1-caihuoqing@baidu.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <3bf6cee5-a55b-5a6e-26d5-35002b36a2d2@wanadoo.fr>
Date:   Sat, 25 Sep 2021 17:14:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210925135255.328-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 25/09/2021 à 15:52, Cai Huoqing a écrit :
> The wrappers in include/linux/pci-dma-compat.h should go away,
> so remove the unused pci wrappers.
> Prefer using dma_xxx() instead of the pci wrappers pci_xxx().
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>   include/linux/pci-dma-compat.h | 27 ---------------------------
>   1 file changed, 27 deletions(-)
> 
> diff --git a/include/linux/pci-dma-compat.h b/include/linux/pci-dma-compat.h
> index 249d4d7fbf18..33b316f38e1d 100644
> --- a/include/linux/pci-dma-compat.h
> +++ b/include/linux/pci-dma-compat.h
> @@ -20,13 +20,6 @@ pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
>   	return dma_alloc_coherent(&hwdev->dev, size, dma_handle, GFP_ATOMIC);
>   }
>   
> -static inline void *
> -pci_zalloc_consistent(struct pci_dev *hwdev, size_t size,
> -		      dma_addr_t *dma_handle)
> -{
> -	return dma_alloc_coherent(&hwdev->dev, size, dma_handle, GFP_ATOMIC);
> -}
> -
>   static inline void
>   pci_free_consistent(struct pci_dev *hwdev, size_t size,
>   		    void *vaddr, dma_addr_t dma_handle)
> @@ -89,26 +82,6 @@ pci_dma_sync_single_for_device(struct pci_dev *hwdev, dma_addr_t dma_handle,
>   	dma_sync_single_for_device(&hwdev->dev, dma_handle, size, (enum dma_data_direction)direction);
>   }
>   
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
>   #ifdef CONFIG_PCI
>   static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask)
>   {
> 

Hi,

I'm not sure that this step is needed.
The whole pci-dma-compat.h is close to be obsolete. So axing just a part 
of it now is not that really useful.

After many patches, there is now just a few users of this deprecated 
API. All steps to finalize the job have already been posted [1] and a 
plan has been proposed by Arnd Bergmann to have the remaining ones 
merged in the tree [2].

Some of the message/fusion patches have been re-sent yesterday and today 
to the scsi maintainer in order to have them merged.

BTW, Cai Huoqing, thanks a lot for taking care and proposing the needed 
clean-ups in comments and log messages.
Looking at it was the next item of my to-do list, but I'm really pleased 
to get some help here to finalize the job once and for all.

CJ

[1]: 
https://lore.kernel.org/kernel-janitors/4cb6f731-7f4d-21d0-c88d-37664ea35002@wanadoo.fr/

[2]: 
https://lore.kernel.org/kernel-janitors/CAK8P3a2CBvw_GP372R+p8f4_pa82sMuQ5iHk4Nb2dJCzm_Fivw@mail.gmail.com/ 

