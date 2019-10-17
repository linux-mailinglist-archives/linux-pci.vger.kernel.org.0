Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21978DB9CF
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 00:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503617AbfJQWlX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 18:41:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438247AbfJQWlX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Oct 2019 18:41:23 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8238821A4C;
        Thu, 17 Oct 2019 22:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571352082;
        bh=jv5P17SWLsv+c2jzgzXgG0YKBN1xedtb+QEmQPVoKus=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NVzkVSZWi/Cur2dMIxPjE5OLL9mvjvsZnVEbiOjN9t7bHPF5QYoMuXpBl82xYo4zV
         iOQrsWOhjyiqBF7sMYChbG2EObX4V7N+e8pi3djxcgw7g+dlWM+vloP5ltQKaLoEXF
         BoFTGRpvSXZPjO0gialPJB3X5EBwNjrdUqrFFwRY=
Date:   Thu, 17 Oct 2019 17:41:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     rubini@gnudd.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        hch@infradead.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: sta2x11: use default DMA address translation ops
Message-ID: <20191017224120.GA68948@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016165138.24636-1-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nicolas,

I'm hoping Christoph will chime in and one of the x86 guys will merge
this, since I'm not a DMA expert.  Trivial comments/questions below.

On Wed, Oct 16, 2019 at 06:51:37PM +0200, Nicolas Saenz Julienne wrote:
> The devices found behind this PCIe chip have unusual DMA mapping
> constraints as there is an AMBA interconnect placed in between them and
> the different PCI endpoints. The offset between physical memory
> addresses and AMBA's view is provided by reading a PCI config register,
> which is saved and used whenever DMA mapping is needed.
> 
> It turns out that this DMA setup can be represented by properly setting
> 'dma_pfn_offset', 'dma_bus_mask' and 'dma_mask' during the PCI device
> enable fixup. And ultimately allows us to get rid of this device's
> custom DMA functions.
> 
> Aside from the code deletion and DMA setup, sta2x11_pdev_to_mapping() is
> moved to avoid warnings whenever CONFIG_PM is not enabled.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

> -	pci_read_config_dword(pdev, AHB_BASE(0), &map->amba_base);
> +
> +	pci_read_config_dword(pdev, AHB_BASE(0), &amba_base);
> +	dev->dma_pfn_offset = PFN_DOWN(-amba_base);
> +	dev->bus_dma_mask = amba_base + STA2X11_AMBA_SIZE - 1;

I think of a mask as typically being one less than a power of two, but
that's not the case here, e.g., STA2X11_AMBA_SIZE - 1 == 0x1fffffff
(512MB-1), so if amba_size is 1G, the mask will be 0x5fffffff.

Just double-checking to be sure that's what you intend.

> +	pci_set_consistent_dma_mask(pdev, amba_base + STA2X11_AMBA_SIZE - 1);
> +	pci_set_dma_mask(pdev, amba_base + STA2X11_AMBA_SIZE - 1);

Maybe add a local variable instead of repeating the "amba_base + ..."
expression three times?

>  	/* Configure AHB mapping */
>  	pci_write_config_dword(pdev, AHB_PEXLBASE(0), 0);
> @@ -252,14 +156,25 @@ static void sta2x11_map_ep(struct pci_dev *pdev)
>  		pci_write_config_dword(pdev, AHB_CRW(i), 0);
>  
>  	dev_info(&pdev->dev,
> -		 "sta2x11: Map EP %i: AMBA address %#8x-%#8x\n",
> -		 sta2x11_pdev_to_ep(pdev),  map->amba_base,
> -		 map->amba_base + STA2X11_AMBA_SIZE - 1);
> +		 "sta2x11: Map EP %i: AMBA address %#8x-%#8llx\n",
> +		 sta2x11_pdev_to_ep(pdev), amba_base, dev->bus_dma_mask);

This would read better as

  amba_base, amba_base + STA2X11_AMBA_SIZE - 1

I know that's the same dev->bus_dma_mask, but a "mask" is not the
obvious name for the end of a range.
