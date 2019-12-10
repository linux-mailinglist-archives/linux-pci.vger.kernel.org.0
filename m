Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 390EA119DF0
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2019 23:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfLJWlR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 17:41:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728904AbfLJWbu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Dec 2019 17:31:50 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EDE5206EC;
        Tue, 10 Dec 2019 22:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576017110;
        bh=OWeDD1ggaI7KtD7dXyfUWEhw8ibkokJLLFnshu+t8Bs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jx/aoNNd4yeJQOJni2d8Jm2bVglXRvoz4EFeLcuMkv+4rwBBQgDPc8e0091THiWqv
         ByDPON5LbCRk5pfsGKnre0V6A3u0AVAS3HCh4SvEgK46AtHn1Lj4VDYvmleLkrwvjW
         e7Rs9VJEMWlZSW72/q1C36bfYYi7lcjJcJDvAF2c=
Date:   Tue, 10 Dec 2019 16:31:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     James Sewart <jamessewart@arista.com>
Cc:     linux-pci@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v6 1/3] PCI: Fix off by one in dma_alias_mask allocation
 size
Message-ID: <20191210223148.GA166696@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <910070E3-7964-4549-B77F-EC7FC6144503@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Joerg]

On Tue, Dec 03, 2019 at 03:43:22PM +0000, James Sewart wrote:
> The number of possible devfns is 256, add def and correct uses.
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: James Sewart <jamessewart@arista.com>

I applied these three patches to pci/virtualization for v5.6, thanks!

I moved the MAX_NR_DEVFNS from include/linux/pci.h to
drivers/pci/pci.h since nobody outside drivers/pci needs it.

> ---
>  drivers/pci/pci.c    | 2 +-
>  drivers/pci/search.c | 2 +-
>  include/linux/pci.h  | 2 ++
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a97e2571a527..d3c83248f3ce 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5876,7 +5876,7 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>  void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
>  {
>  	if (!dev->dma_alias_mask)
> -		dev->dma_alias_mask = bitmap_zalloc(U8_MAX, GFP_KERNEL);
> +		dev->dma_alias_mask = bitmap_zalloc(MAX_NR_DEVFNS, GFP_KERNEL);
>  	if (!dev->dma_alias_mask) {
>  		pci_warn(dev, "Unable to allocate DMA alias mask\n");
>  		return;
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index bade14002fd8..9e4dfae47252 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -43,7 +43,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
>  	if (unlikely(pdev->dma_alias_mask)) {
>  		u8 devfn;
>  
> -		for_each_set_bit(devfn, pdev->dma_alias_mask, U8_MAX) {
> +		for_each_set_bit(devfn, pdev->dma_alias_mask, MAX_NR_DEVFNS) {
>  			ret = fn(pdev, PCI_DEVID(pdev->bus->number, devfn),
>  				 data);
>  			if (ret)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1a6cf19eac2d..6481da29d667 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -57,6 +57,8 @@
>  #define PCI_DEVID(bus, devfn)	((((u16)(bus)) << 8) | (devfn))
>  /* return bus from PCI devid = ((u16)bus_number) << 8) | devfn */
>  #define PCI_BUS_NUM(x) (((x) >> 8) & 0xff)
> +/* Number of possible devfns. devfns can be from 0.0 to 1f.7 inclusive */
> +#define MAX_NR_DEVFNS 256
>  
>  /* pci_slot represents a physical slot */
>  struct pci_slot {
> -- 
> 2.24.0
> 
> 
