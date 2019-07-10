Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2DF641C0
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2019 09:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfGJHOC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jul 2019 03:14:02 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:40662 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfGJHOC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jul 2019 03:14:02 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id B90F625B7D5;
        Wed, 10 Jul 2019 17:13:59 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 57ED09402F1; Wed, 10 Jul 2019 09:13:57 +0200 (CEST)
Date:   Wed, 10 Jul 2019 09:13:57 +0200
From:   Simon Horman <horms@verge.net.au>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: rcar: Recalculate inbound range alignment for
 each controller entry
Message-ID: <20190710071355.x5uxc5rvnv7cq5go@verge.net.au>
References: <20190709011559.12379-1-marek.vasut@gmail.com>
 <20190709011559.12379-2-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709011559.12379-2-marek.vasut@gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 09, 2019 at 03:15:59AM +0200, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Due to hardware constraints, the size of each inbound range entry
> populated into the controller cannot be larger than the alignment
> of the entry's start address. Currently, the alignment for each
> "dma-ranges" inbound range is calculated only once for each range
> and the increment for programming the controller is also derived
> from it only once. Thus, a "dma-ranges" entry describing a memory
> at 0x48000000 and size 0x38000000 would lead to multiple controller
> entries, each 0x08000000 long.
> 
> This is inefficient, especially considering that by adding the size
> to the start address, the alignment increases. This patch moves the
> alignment calculation into the loop populating the controller entries,
> thus updating the alignment for each controller entry.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/pci/controller/pcie-rcar.c | 33 +++++++++++++++---------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index 938adff4148f..48f361b5d690 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -1029,25 +1029,26 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
>  	if (restype & IORESOURCE_PREFETCH)
>  		flags |= LAM_PREFETCH;
>  
> -	/*
> -	 * If the size of the range is larger than the alignment of the start
> -	 * address, we have to use multiple entries to perform the mapping.
> -	 */
> -	if (cpu_addr > 0) {
> -		unsigned long nr_zeros = __ffs64(cpu_addr);
> -		u64 alignment = 1ULL << nr_zeros;
> +	while (cpu_addr < cpu_end) {
> +		/*
> +		 * If the size of the range is larger than the alignment of
> +		 * the start address, we have to use multiple entries to
> +		 * perform the mapping.
> +		 */
> +		if (cpu_addr > 0) {
> +			unsigned long nr_zeros = __ffs64(cpu_addr);
> +			u64 alignment = 1ULL << nr_zeros;
>  
> -		size = min(range->size, alignment);
> -	} else {
> -		size = range->size;
> -	}
> -	/* Hardware supports max 4GiB inbound region */
> -	size = min(size, 1ULL << 32);
> +			size = min(range->size, alignment);
> +		} else {
> +			size = range->size;
> +		}
> +		/* Hardware supports max 4GiB inbound region */
> +		size = min(size, 1ULL << 32);
>  
> -	mask = roundup_pow_of_two(size) - 1;
> -	mask &= ~0xf;
> +		mask = roundup_pow_of_two(size) - 1;
> +		mask &= ~0xf;
>  
> -	while (cpu_addr < cpu_end) {
>  		/*
>  		 * Set up 64-bit inbound regions as the range parser doesn't
>  		 * distinguish between 32 and 64-bit types.
> -- 
> 2.20.1
> 
