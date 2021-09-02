Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424483FF1AA
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 18:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346436AbhIBQlQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Sep 2021 12:41:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346439AbhIBQlL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Sep 2021 12:41:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01D26610A2;
        Thu,  2 Sep 2021 16:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630600813;
        bh=vVhA0D1FxuCLM+gcPg9dcutVf4j6oM8l2T75ajcYUOI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Enoq2d/lXJKhBWZeMumZGYzpLxuekbgv5ybGMt9jz+j8UnDaMOC2g9YRIpA7e+Sl6
         6vvoVy7gNlbfEBVaLRZZY01mB70jxnNIZBB6HL5CqjBlL8QxmZFiR1nx52t1LTIrYZ
         UfcK9nVY4lxu+AmwwP7VQJZTkSwsz2Us7suu1gJWMSTyM9a+QWNgJnf2rYjmIKgJnp
         vsMYYhMxyQYg7xNYlCtKazxJTvuovCfN7l2vSdwbIswCGUMAPI8idif+4b2UuotCRB
         c53+LxEfS2Xx3hSjgosuG0Vv4rZcWQHb1rn9qugqscpbm8yDoaoxkWao1aurPkr7aL
         Nmrq5/XNvMEwA==
Date:   Thu, 2 Sep 2021 11:40:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] x86/PCI: sta2x11: switch from 'pci_' to 'dma_' API
Message-ID: <20210902164011.GA340793@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99656452963ba3c63a6cb12e151279d81da365eb.1629658069.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Christoph]

On Sun, Aug 22, 2021 at 08:49:20PM +0200, Christophe JAILLET wrote:
> The wrappers in include/linux/pci-dma-compat.h should go away.
> ...

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to pci/misc for v5.15, thanks!

> ---
> If needed, see post from Christoph Hellwig on the kernel-janitors ML:
>    https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
> ---
>  arch/x86/pci/sta2x11-fixup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
> index 7d2525691854..101081ad64b6 100644
> --- a/arch/x86/pci/sta2x11-fixup.c
> +++ b/arch/x86/pci/sta2x11-fixup.c
> @@ -146,8 +146,7 @@ static void sta2x11_map_ep(struct pci_dev *pdev)
>  		dev_err(dev, "sta2x11: could not set DMA offset\n");
>  
>  	dev->bus_dma_limit = max_amba_addr;
> -	pci_set_consistent_dma_mask(pdev, max_amba_addr);
> -	pci_set_dma_mask(pdev, max_amba_addr);
> +	dma_set_mask_and_coherent(&pdev->dev, max_amba_addr);
>  
>  	/* Configure AHB mapping */
>  	pci_write_config_dword(pdev, AHB_PEXLBASE(0), 0);
> -- 
> 2.30.2
> 
