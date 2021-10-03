Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6B9420295
	for <lists+linux-pci@lfdr.de>; Sun,  3 Oct 2021 18:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhJCQLY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 Oct 2021 12:11:24 -0400
Received: from elvis.franken.de ([193.175.24.41]:57378 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230495AbhJCQLX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 3 Oct 2021 12:11:23 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mX43M-0005aq-02; Sun, 03 Oct 2021 18:09:28 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 0704DC1D2B; Sun,  3 Oct 2021 18:08:04 +0200 (CEST)
Date:   Sun, 3 Oct 2021 18:08:03 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     robh@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        Liviu.Dudau@arm.com, bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] MIPS: implement architecture-specific
 'pci_remap_iospace()'
Message-ID: <20211003160803.GC4984@alpha.franken.de>
References: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
 <20210925203224.10419-6-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925203224.10419-6-sergio.paracuellos@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 25, 2021 at 10:32:23PM +0200, Sergio Paracuellos wrote:
> To make PCI IO work we need to properly virtually map IO cpu physical address
> and set this virtual address as the address of the first PCI IO port which
> is set using function 'set_io_port_base()'.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  arch/mips/include/asm/pci.h |  2 ++
>  arch/mips/pci/pci-generic.c | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
> index 9ffc8192adae..35270984a5f0 100644
> --- a/arch/mips/include/asm/pci.h
> +++ b/arch/mips/include/asm/pci.h
> @@ -20,6 +20,8 @@
>  #include <linux/list.h>
>  #include <linux/of.h>
>  
> +#define pci_remap_iospace pci_remap_iospace
> +
>  #ifdef CONFIG_PCI_DRIVERS_LEGACY
>  
>  /*
> diff --git a/arch/mips/pci/pci-generic.c b/arch/mips/pci/pci-generic.c
> index 95b00017886c..18eb8a453a86 100644
> --- a/arch/mips/pci/pci-generic.c
> +++ b/arch/mips/pci/pci-generic.c
> @@ -46,3 +46,17 @@ void pcibios_fixup_bus(struct pci_bus *bus)
>  {
>  	pci_read_bridge_bases(bus);
>  }
> +
> +int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
> +{
> +	unsigned long vaddr;
> +
> +	if (res->start != 0) {
> +		WARN_ONCE(1, "resource start address is not zero\n");
> +		return -ENODEV;
> +	}
> +
> +	vaddr = (unsigned long)ioremap(phys_addr, resource_size(res));
> +	set_io_port_base(vaddr);
> +	return 0;
> +}

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
