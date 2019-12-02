Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C088910EDBB
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2019 18:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfLBRD7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Dec 2019 12:03:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41746 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfLBRD7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Dec 2019 12:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=raL1+4V5E2+QW+HFVTt4GSePQ92W/jLVrBwyPI09wsc=; b=ODQMWZrxM3Ei91kafr/GGAwsm
        Vaful+p5elqfnvM/sfwpwKe+crzQfQaye6TkkVGA5JgPugc7BaXzAbguFtZ+NwB1IvDOWEGnUSM5P
        YiXwfDUsC+aHfe6gL86lsgHrBcIjiZBb0LAZnlHCLWXa2ehn9x38l1hcjs/wJPwXXCNV68SCA0WRu
        9WhBoK77Mxc79Sp2vAATF0H+ZXHIIXb7cQRJ7BA9L5+wzu1qLAD96nekj6ivFZs1cH8TQXGuuTMFN
        o+/jbkVAUVjjocir/PweEsTz9y0foZw1grxr76NcqC3ZyhjLc0uhtF2bYJlSzd8WpjRUo1lRebLOM
        cAk26netg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ibp78-0001EG-SQ; Mon, 02 Dec 2019 17:03:58 +0000
Date:   Mon, 2 Dec 2019 09:03:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     James Sewart <jamessewart@arista.com>
Cc:     linux-pci@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v5 2/3] PCI: Add parameter nr_devfns to pci_add_dma_alias
Message-ID: <20191202170358.GB4174@infradead.org>
References: <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
 <20191126173833.GA16069@infradead.org>
 <547214A9-9FD0-4DD5-80E1-1F5A467A0913@arista.com>
 <9c54c5dd-702c-a19b-38ba-55ab73b24729@deltatee.com>
 <435064D4-00F0-47F5-94D2-2C354F6B1206@arista.com>
 <058383d9-69fe-65e3-e410-eebd99840261@deltatee.com>
 <F26CC19F-66C2-466B-AE30-D65E10BA3022@arista.com>
 <d811576e-0f89-2303-a554-2701af5c5647@deltatee.com>
 <9DD82D05-6B9E-4AF5-9A3C-D459B75C0089@arista.com>
 <07D724A1-308F-44C3-8937-EE0C21EF3170@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07D724A1-308F-44C3-8937-EE0C21EF3170@arista.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 29, 2019 at 05:56:55PM +0000, James Sewart wrote:
> pci_add_dma_alias can now be used to create a dma alias for a range of
> devfns.
> 
> Signed-off-by: James Sewart <jamessewart@arista.com>
> ---
>  drivers/pci/pci.c    | 23 ++++++++++++++++++-----
>  drivers/pci/quirks.c | 14 +++++++-------
>  include/linux/pci.h  |  2 +-
>  3 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 0a4449a30ace..f9800a610ca1 100644
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
> @@ -5873,8 +5874,14 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>   * cannot be left as a userspace activity).  DMA aliases should therefore
>   * be configured via quirks, such as the PCI fixup header quirk.
>   */
> -void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
> +void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned nr_devfns)
>  {
> +	int devfn_to;
> +
> +	if (nr_devfns > U8_MAX+1)
> +		nr_devfns = U8_MAX+1;

Missing whitespaces here as well.  Also this could use max() and I
think you want a documented constants for MAX_NR_DEVFNS that documents
this "not off by one".
