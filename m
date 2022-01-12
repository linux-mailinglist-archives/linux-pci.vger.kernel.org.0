Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5D748CCE6
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 21:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357224AbiALULY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 15:11:24 -0500
Received: from elvis.franken.de ([193.175.24.41]:45124 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357519AbiALULV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jan 2022 15:11:21 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1n7jxj-0007Ba-00; Wed, 12 Jan 2022 21:11:15 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 60F5FC0F38; Wed, 12 Jan 2022 21:10:56 +0100 (CET)
Date:   Wed, 12 Jan 2022 21:10:56 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] MIPS: ralink: implement
 'pcibios_root_bridge_prepare()'
Message-ID: <20220112201056.GA5653@alpha.franken.de>
References: <20211207104924.21327-1-sergio.paracuellos@gmail.com>
 <20211207104924.21327-3-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207104924.21327-3-sergio.paracuellos@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 07, 2021 at 11:49:21AM +0100, Sergio Paracuellos wrote:
> PCI core code call 'pcibios_root_bridge_prepare()' function inside function
> 'pci_register_host_bridge()'. This point is very good way to properly enter
> into this MIPS ralink specific code to properly setup I/O coherency units
> with PCI memory addresses.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  arch/mips/ralink/mt7621.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
> index bd71f5b14238..d6efffd4dd20 100644
> --- a/arch/mips/ralink/mt7621.c
> +++ b/arch/mips/ralink/mt7621.c
> @@ -10,6 +10,8 @@
>  #include <linux/slab.h>
>  #include <linux/sys_soc.h>
>  #include <linux/memblock.h>
> +#include <linux/pci.h>
> +#include <linux/bug.h>
>  
>  #include <asm/bootinfo.h>
>  #include <asm/mipsregs.h>
> @@ -22,6 +24,35 @@
>  
>  static void *detect_magic __initdata = detect_memory_region;
>  
> +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> +{
> +	struct resource_entry *entry;
> +	resource_size_t mask;
> +
> +	entry = resource_list_first_type(&bridge->windows, IORESOURCE_MEM);
> +	if (!entry) {
> +		pr_err("Cannot get memory resource\n");
> +		return -EINVAL;
> +	}
> +
> +	if (mips_cps_numiocu(0)) {
> +		/*
> +		 * Hardware doesn't accept mask values with 1s after
> +		 * 0s (e.g. 0xffef), so warn if that's happen
> +		 */
> +		mask = ~(entry->res->end - entry->res->start) & CM_GCR_REGn_MASK_ADDRMASK;
> +		WARN_ON(mask && BIT(ffz(~mask)) - 1 != ~mask);
> +
> +		write_gcr_reg1_base(entry->res->start);
> +		write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
> +		pr_info("PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
> +			(unsigned long long)read_gcr_reg1_base(),
> +			(unsigned long long)read_gcr_reg1_mask());
> +	}
> +
> +	return 0;
> +}
> +
>  phys_addr_t mips_cpc_default_phys_base(void)
>  {
>  	panic("Cannot detect cpc address");
> -- 
> 2.33.0

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
