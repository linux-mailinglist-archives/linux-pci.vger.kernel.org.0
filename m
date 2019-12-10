Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80B7A119D6E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2019 23:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbfLJWht (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 17:37:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730355AbfLJWhr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Dec 2019 17:37:47 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6617214D8;
        Tue, 10 Dec 2019 22:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576017467;
        bh=pmltaW9LsjEuTpeKbuA3I4m6I9tXYKuy+WxPnOiBySg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GpF77bDRMYOZMzZUsc1xfZBNt0grHZ4wf9ahTXpwyB/3gWFtElsyCOKqPj3U1bJFM
         F12G87CHzuPAb/bUPdSWsiVx1FaP+i8FGPXzpLIMlG9rGYgTSbaTbyG8VW14eyc8d+
         yP9jUwAsNzCNQ3sJ/NVKANDpE4MxAYItUWmqRpYM=
Date:   Tue, 10 Dec 2019 16:37:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     James Sewart <jamessewart@arista.com>
Cc:     linux-pci@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v6 2/3] PCI: Add parameter nr_devfns to pci_add_dma_alias
Message-ID: <20191210223745.GA167002@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4C7374E-4DFE-4024-8E76-9F54BF421B62@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Joerg]

On Tue, Dec 03, 2019 at 03:43:53PM +0000, James Sewart wrote:
> pci_add_dma_alias can now be used to create a dma alias for a range of
> devfns.
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: James Sewart <jamessewart@arista.com>
> ---
>  drivers/pci/pci.c    | 22 +++++++++++++++++-----
>  drivers/pci/quirks.c | 14 +++++++-------
>  include/linux/pci.h  |  2 +-
>  3 files changed, 25 insertions(+), 13 deletions(-)

Heads up Joerg: I also updated drivers/iommu/amd_iommu.c (this is the
one reported by the kbuild test robot) and removed the printk there
that prints the same thing as the one in pci_add_dma_alias(), and I
updated a PCI quirk that was merged after this patch was posted.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d3c83248f3ce..dbb01aceafda 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5857,7 +5857,8 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>  /**
>   * pci_add_dma_alias - Add a DMA devfn alias for a device
>   * @dev: the PCI device for which alias is added
> - * @devfn: alias slot and function
> + * @devfn_from: alias slot and function
> + * @nr_devfns: Number of subsequent devfns to alias
>   *
>   * This helper encodes an 8-bit devfn as a bit number in dma_alias_mask
>   * which is used to program permissible bus-devfn source addresses for DMA
> @@ -5873,8 +5874,13 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>   * cannot be left as a userspace activity).  DMA aliases should therefore
>   * be configured via quirks, such as the PCI fixup header quirk.
>   */
> -void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
> +void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned nr_devfns)
>  {
> +	int devfn_to;
> +
> +	nr_devfns = min(nr_devfns, (unsigned)MAX_NR_DEVFNS);
> +	devfn_to = devfn_from + nr_devfns - 1;

I made this look like:

+       devfn_to = min(devfn_from + nr_devfns - 1,
+                      (unsigned) MAX_NR_DEVFNS - 1);

so devfn_from=0xf0, nr_devfns=0x20 doesn't cause devfn_to to wrap
around.

I did keep Logan's reviewed-by, so let me know if I broke something.

>  	if (!dev->dma_alias_mask)
>  		dev->dma_alias_mask = bitmap_zalloc(MAX_NR_DEVFNS, GFP_KERNEL);
>  	if (!dev->dma_alias_mask) {
> @@ -5882,9 +5888,15 @@ void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
>  		return;
>  	}
>  
> -	set_bit(devfn, dev->dma_alias_mask);
> -	pci_info(dev, "Enabling fixed DMA alias to %02x.%d\n",
> -		 PCI_SLOT(devfn), PCI_FUNC(devfn));
> +	bitmap_set(dev->dma_alias_mask, devfn_from, nr_devfns);
> +
> +	if (nr_devfns == 1)
> +		pci_info(dev, "Enabling fixed DMA alias to %02x.%d\n",
> +				PCI_SLOT(devfn_from), PCI_FUNC(devfn_from));
> +	else if(nr_devfns > 1)
> +		pci_info(dev, "Enabling fixed DMA alias for devfn range from %02x.%d to %02x.%d\n",
> +				PCI_SLOT(devfn_from), PCI_FUNC(devfn_from),
> +				PCI_SLOT(devfn_to), PCI_FUNC(devfn_to));
>  }
