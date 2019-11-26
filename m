Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77C3810A36D
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2019 18:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfKZRie (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Nov 2019 12:38:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbfKZRie (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2019 12:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aKZvvePDQW5RDqmZAeiG6BbNoPgHNagjIBh3FYogELM=; b=ciH8dOAK3EX7IC9OLRsLDW7v1
        TfobHdqmVQrxa/fj9p/gxjWD8V+zUBHxm8qA2+sBAERlhsplsQuqMIh4U56uCHSHWHtyYCG0nDVmO
        9pPGKrBYbsT23uPZdVjWH/uqgwTpNSLxO+40eKIEM/2N+0499F+t8geK4GAJBSuVijX2Hr99d9jHK
        KVlU32XRCcHidYdAnBpTLorxpBKjwD/sewe38tetWTmnus7wOv4JDxdW+4r4i6PFN9g+cpIKTm8yx
        iB/HSZzTFzfnUVREwjBNef1ex3N9aRBtr3pKmsISsnOz7EXh9+aRPRln4JAM45nQKiZEelB9WcDgH
        7+EPYFnAg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iZenJ-00070t-1h; Tue, 26 Nov 2019 17:38:33 +0000
Date:   Tue, 26 Nov 2019 09:38:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     James Sewart <jamessewart@arista.com>
Cc:     linux-pci@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2] PCI: Add DMA alias quirk for PLX PEX NTB
Message-ID: <20191126173833.GA16069@infradead.org>
References: <20191120193228.GA103670@google.com>
 <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +int _pci_add_dma_alias_range(struct pci_dev *dev, u8 devfn_from, int len)

This should be mrked static.  Also single underscore prefixes are rather
unusual in Linux.  Either use two or use a more descriptive name.


> @@ -5875,18 +5887,21 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>   */
>  void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
>  {
> -	if (!dev->dma_alias_mask)
> -		dev->dma_alias_mask = bitmap_zalloc(U8_MAX, GFP_KERNEL);
> -	if (!dev->dma_alias_mask) {
> -		pci_warn(dev, "Unable to allocate DMA alias mask\n");
> +	if (_pci_add_dma_alias_range(dev, devfn, 1) != 0)
>  		return;
> -	}
> -
> -	set_bit(devfn, dev->dma_alias_mask);
>  	pci_info(dev, "Enabling fixed DMA alias to %02x.%d\n",
>  		 PCI_SLOT(devfn), PCI_FUNC(devfn));
>  }
>  
> +void pci_add_dma_alias_range(struct pci_dev *dev, u8 devfn_from, int len)
> +{
> +	int devfn_to = devfn_from + len - 1;
> +	if (_pci_add_dma_alias_range(dev, devfn_from, len) != 0)
> +		return;
> +	pci_info(dev, "Enabling fixed DMA alias for devfn range from %02x.%d to %02x.%d\n",
> +		 PCI_SLOT(devfn_from), PCI_FUNC(devfn_from), PCI_SLOT(devfn_to), PCI_FUNC(devfn_to));
> +}

This adds a non-string constant line over 80 chars that should be fixed
up.

But can't you just add the len argument (which really should be
nr_devfns or so) to pci_add_dma_alias and switch the 8 existing
callers over?
