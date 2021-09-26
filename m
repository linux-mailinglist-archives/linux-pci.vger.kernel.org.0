Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB3B4185BA
	for <lists+linux-pci@lfdr.de>; Sun, 26 Sep 2021 04:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhIZCmw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Sep 2021 22:42:52 -0400
Received: from mx24.baidu.com ([111.206.215.185]:50224 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230302AbhIZCmw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 25 Sep 2021 22:42:52 -0400
Received: from BC-Mail-Ex12.internal.baidu.com (unknown [172.31.51.52])
        by Forcepoint Email with ESMTPS id BE390249169A788A4135;
        Sun, 26 Sep 2021 10:41:07 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex12.internal.baidu.com (172.31.51.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Sun, 26 Sep 2021 10:41:07 +0800
Received: from localhost (172.31.63.8) by BJHW-MAIL-EX27.internal.baidu.com
 (10.127.64.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sun, 26
 Sep 2021 10:41:07 +0800
Date:   Sun, 26 Sep 2021 10:41:06 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Remove the unused pci wrappers
Message-ID: <20210926024106.GA88@LAPTOP-UKSR4ENP.internal.baidu.com>
References: <20210925135255.328-1-caihuoqing@baidu.com>
 <3bf6cee5-a55b-5a6e-26d5-35002b36a2d2@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3bf6cee5-a55b-5a6e-26d5-35002b36a2d2@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex11.internal.baidu.com (10.127.64.34) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25 9月 21 17:14:05, Christophe JAILLET wrote:
> Le 25/09/2021 à 15:52, Cai Huoqing a écrit :
> > The wrappers in include/linux/pci-dma-compat.h should go away,
> > so remove the unused pci wrappers.
> > Prefer using dma_xxx() instead of the pci wrappers pci_xxx().
> > 
> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> > ---
> >   include/linux/pci-dma-compat.h | 27 ---------------------------
> >   1 file changed, 27 deletions(-)
> > 
> > diff --git a/include/linux/pci-dma-compat.h b/include/linux/pci-dma-compat.h
> > index 249d4d7fbf18..33b316f38e1d 100644
> > --- a/include/linux/pci-dma-compat.h
> > +++ b/include/linux/pci-dma-compat.h
> > @@ -20,13 +20,6 @@ pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
> >   	return dma_alloc_coherent(&hwdev->dev, size, dma_handle, GFP_ATOMIC);
> >   }
> > -static inline void *
> > -pci_zalloc_consistent(struct pci_dev *hwdev, size_t size,
> > -		      dma_addr_t *dma_handle)
> > -{
> > -	return dma_alloc_coherent(&hwdev->dev, size, dma_handle, GFP_ATOMIC);
> > -}
> > -
> >   static inline void
> >   pci_free_consistent(struct pci_dev *hwdev, size_t size,
> >   		    void *vaddr, dma_addr_t dma_handle)
> > @@ -89,26 +82,6 @@ pci_dma_sync_single_for_device(struct pci_dev *hwdev, dma_addr_t dma_handle,
> >   	dma_sync_single_for_device(&hwdev->dev, dma_handle, size, (enum dma_data_direction)direction);
> >   }
> > -static inline void
> > -pci_dma_sync_sg_for_cpu(struct pci_dev *hwdev, struct scatterlist *sg,
> > -		int nelems, int direction)
> > -{
> > -	dma_sync_sg_for_cpu(&hwdev->dev, sg, nelems, (enum dma_data_direction)direction);
> > -}
> > -
> > -static inline void
> > -pci_dma_sync_sg_for_device(struct pci_dev *hwdev, struct scatterlist *sg,
> > -		int nelems, int direction)
> > -{
> > -	dma_sync_sg_for_device(&hwdev->dev, sg, nelems, (enum dma_data_direction)direction);
> > -}
> > -
> > -static inline int
> > -pci_dma_mapping_error(struct pci_dev *pdev, dma_addr_t dma_addr)
> > -{
> > -	return dma_mapping_error(&pdev->dev, dma_addr);
> > -}
> > -
> >   #ifdef CONFIG_PCI
> >   static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask)
> >   {
> > 
> 
> Hi,
> 
> I'm not sure that this step is needed.
> The whole pci-dma-compat.h is close to be obsolete. So axing just a part of
> it now is not that really useful.
Thanks for your feedback.

If someone reuse these wrappers, that will not be checked by checkpatch.pl.
And I also will not add check condition to checkpatch.pl, because the wrappers
in include/linux/pci-dma-compat.h will go away soon.

Removing these API helps driver owner to avoid reusing these obsolete wrappers
without reviwing it manually, only works before pci-dma-compat.h is droped.

Thanks
Cai

> 
> After many patches, there is now just a few users of this deprecated API.
> All steps to finalize the job have already been posted [1] and a plan has
> been proposed by Arnd Bergmann to have the remaining ones merged in the tree
> [2]
it maybe cost serval weeks before all subtrees merge to linux-next.
> 
> Some of the message/fusion patches have been re-sent yesterday and today to
> the scsi maintainer in order to have them merged.
> 
> BTW, Cai Huoqing, thanks a lot for taking care and proposing the needed
> clean-ups in comments and log messages.
> Looking at it was the next item of my to-do list, but I'm really pleased to
> get some help here to finalize the job once and for all.
> 
> CJ
> 
> [1]: https://lore.kernel.org/kernel-janitors/4cb6f731-7f4d-21d0-c88d-37664ea35002@wanadoo.fr/
> 
> [2]: https://lore.kernel.org/kernel-janitors/CAK8P3a2CBvw_GP372R+p8f4_pa82sMuQ5iHk4Nb2dJCzm_Fivw@mail.gmail.com/
> 
