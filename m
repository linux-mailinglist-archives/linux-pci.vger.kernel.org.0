Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE5DED7924
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 16:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732960AbfJOOvC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 10:51:02 -0400
Received: from foss.arm.com ([217.140.110.172]:40224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732979AbfJOOvC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 10:51:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F30C91000;
        Tue, 15 Oct 2019 07:51:01 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF9583F718;
        Tue, 15 Oct 2019 07:51:00 -0700 (PDT)
Date:   Tue, 15 Oct 2019 15:50:58 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        kishon@ti.com, bhelgaas@google.com, palmer@sifive.com,
        paul.walmsley@sifive.com
Subject: Re: [PATCH v2] PCI: endpoint: Cast the page number to phys_addr_t
Message-ID: <20191015145058.GB22698@e121166-lin.cambridge.arm.com>
References: <1570640816-5390-1-git-send-email-alan.mikhak@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570640816-5390-1-git-send-email-alan.mikhak@sifive.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 09, 2019 at 10:06:56AM -0700, Alan Mikhak wrote:
> From: Alan Mikhak <alan.mikhak@sifive.com>
> 
> Modify pci_epc_mem_alloc_addr() to cast the variable 'pageno'
> from type 'int' to 'phys_addr_t' before shifting left. This
> cast is needed to avoid treating bit 31 of 'pageno' as the
> sign bit which would otherwise get sign-extended to produce
> a negative value. When added to the base address of PCI memory
> space, the negative value would produce an invalid physical
> address which falls before the start of the PCI memory space.
> 
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/pci-epc-mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/endpoint, thanks.

Lorenzo

> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> index 2bf8bd1f0563..d2b174ce15de 100644
> --- a/drivers/pci/endpoint/pci-epc-mem.c
> +++ b/drivers/pci/endpoint/pci-epc-mem.c
> @@ -134,7 +134,7 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>  	if (pageno < 0)
>  		return NULL;
>  
> -	*phys_addr = mem->phys_base + (pageno << page_shift);
> +	*phys_addr = mem->phys_base + ((phys_addr_t)pageno << page_shift);
>  	virt_addr = ioremap(*phys_addr, size);
>  	if (!virt_addr)
>  		bitmap_release_region(mem->bitmap, pageno, order);
> -- 
> 2.7.4
> 
