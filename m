Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E378ADE9DA
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 12:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfJUKjf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 06:39:35 -0400
Received: from [217.140.110.172] ([217.140.110.172]:48644 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbfJUKjf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 06:39:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C9FCCA3;
        Mon, 21 Oct 2019 03:39:02 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA3163F718;
        Mon, 21 Oct 2019 03:39:01 -0700 (PDT)
Date:   Mon, 21 Oct 2019 11:39:00 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [PATCH V3 3/3] PCI: rcar: Recalculate inbound range alignment
 for each controller entry
Message-ID: <20191021103859.GN47056@e119886-lin.cambridge.arm.com>
References: <20190809175741.7066-1-marek.vasut@gmail.com>
 <20190809175741.7066-3-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809175741.7066-3-marek.vasut@gmail.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 09, 2019 at 07:57:41PM +0200, marek.vasut@gmail.com wrote:
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
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> V2: Update on top of 1/3
> V3: No change
> ---
>  drivers/pci/controller/pcie-rcar.c | 37 +++++++++++++++---------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index e2735005ffd3..d820aa64d0b7 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -1029,30 +1029,31 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
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
> -
> -		size = min(range->size, alignment);
> -	} else {
> -		size = range->size;
> -	}
> -	/* Hardware supports max 4GiB inbound region */
> -	size = min(size, 1ULL << 32);
> -
> -	mask = roundup_pow_of_two(size) - 1;
> -	mask &= ~0xf;
> -
>  	while (cpu_addr < cpu_end) {
>  		if (idx >= MAX_NR_INBOUND_MAPS - 1) {
>  			dev_warn(pcie->dev,
>  				 "Too many inbound regions, not all are mapped.\n");
>  			break;
>  		}
> +		/*
> +		 * If the size of the range is larger than the alignment of
> +		 * the start address, we have to use multiple entries to
> +		 * perform the mapping.
> +		 */
> +		if (cpu_addr > 0) {
> +			unsigned long nr_zeros = __ffs64(cpu_addr);
> +			u64 alignment = 1ULL << nr_zeros;
> +
> +			size = min(range->size, alignment);
> +		} else {
> +			size = range->size;
> +		}
> +		/* Hardware supports max 4GiB inbound region */
> +		size = min(size, 1ULL << 32);
> +
> +		mask = roundup_pow_of_two(size) - 1;
> +		mask &= ~0xf;
> +

Indeed, as the cpu address increases so does the size you can fit in each
window.

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

(Though you'll have to rebase this without patch 2).

>  		/*
>  		 * Set up 64-bit inbound regions as the range parser doesn't
>  		 * distinguish between 32 and 64-bit types.
> -- 
> 2.20.1
> 
