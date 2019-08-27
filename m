Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9FE59F65D
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 00:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfH0Wr2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 18:47:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfH0Wr2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 18:47:28 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A2FC2186A;
        Tue, 27 Aug 2019 22:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566946047;
        bh=itvqkewzveFrjSvCl9gGUtqgFDrAF1y3svpBSbEfo7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WIAZKpQjyKofyN6B53VGwPWp32/uvIpW9iPZKlBHFOQdpduhzMfn7hhGQ335f1N4J
         8nY3/eapqzcQb4pp4RHye3T3rhbqEhZCYnIcGe6jkqHO4vuXjphhPKgYHPI8iz7J1A
         ciGfJ2KnoryR08PNBoM2+MUHrlxhqHv/nM96lIRs=
Date:   Tue, 27 Aug 2019 17:47:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: Add missing log facility and move to use pr_
 macros in pcbios.c
Message-ID: <20190827224725.GD9987@google.com>
References: <20190825182557.23260-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825182557.23260-1-kw@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 25, 2019 at 08:25:57PM +0200, Krzysztof Wilczynski wrote:
> Make the log facility used to print warnings to be KERN_WARNING
> explicitly, rather than rely on the current (or default) value
> of the MESSAGE_LOGLEVEL_DEFAULT set in Kconfig.  This will make
> all the warnings in the arch/x86/pci/pcbios.c to be printed
> consistently at the same log facility.

This is slightly confusing.  There are only two messages that didn't
supply a log level, so the avoidance of MESSAGE_LOGLEVEL_DEFAULT
applies to those.

The rest already supplied a log level, so converting printk(KERN_INFO)
to pr_info() is purely simplification.

> Replace printk(KERN_<level> ...) with corresponding pr_ macros,
> while adding the missing log facility.

Might be worth doing this as well:

  #define pr_fmt(fmt) "PCI: " fmt

and removing the "PCI: " prefix from the messages.  This would change
the "bios32_service" output slightly, but I think the change would be
a good one.

> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
> ---
>  arch/x86/pci/pcbios.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/pci/pcbios.c b/arch/x86/pci/pcbios.c
> index 9c97d814125e..0c3673f50bce 100644
> --- a/arch/x86/pci/pcbios.c
> +++ b/arch/x86/pci/pcbios.c
> @@ -47,7 +47,7 @@ static inline void set_bios_x(void)
>  	pcibios_enabled = 1;
>  	set_memory_x(PAGE_OFFSET + BIOS_BEGIN, (BIOS_END - BIOS_BEGIN) >> PAGE_SHIFT);
>  	if (__supported_pte_mask & _PAGE_NX)
> -		printk(KERN_INFO "PCI: PCI BIOS area is rw and x. Use pci=nobios if you want it NX.\n");
> +		pr_info("PCI: PCI BIOS area is rw and x. Use pci=nobios if you want it NX.\n");
>  }
>  
>  /*
> @@ -111,10 +111,10 @@ static unsigned long __init bios32_service(unsigned long service)
>  		case 0:
>  			return address + entry;
>  		case 0x80:	/* Not present */
> -			printk(KERN_WARNING "bios32_service(0x%lx): not present\n", service);
> +			pr_warn("bios32_service(0x%lx): not present\n", service);
>  			return 0;
>  		default: /* Shouldn't happen */
> -			printk(KERN_WARNING "bios32_service(0x%lx): returned 0x%x -- BIOS bug!\n",
> +			pr_warn("bios32_service(0x%lx): returned 0x%x -- BIOS bug!\n",
>  				service, return_code);
>  			return 0;
>  	}
> @@ -163,11 +163,11 @@ static int __init check_pcibios(void)
>  		DBG("PCI: BIOS probe returned s=%02x hw=%02x ver=%02x.%02x l=%02x\n",
>  			status, hw_mech, major_ver, minor_ver, pcibios_last_bus);
>  		if (status || signature != PCI_SIGNATURE) {
> -			printk (KERN_ERR "PCI: BIOS BUG #%x[%08x] found\n",
> +			pr_err("PCI: BIOS BUG #%x[%08x] found\n",
>  				status, signature);
>  			return 0;
>  		}
> -		printk(KERN_INFO "PCI: PCI BIOS revision %x.%02x entry at 0x%lx, last bus=%d\n",
> +		pr_info("PCI: PCI BIOS revision %x.%02x entry at 0x%lx, last bus=%d\n",
>  			major_ver, minor_ver, pcibios_entry, pcibios_last_bus);
>  #ifdef CONFIG_PCI_DIRECT
>  		if (!(hw_mech & PCIBIOS_HW_TYPE1))
> @@ -316,13 +316,13 @@ static const struct pci_raw_ops *__init pci_find_bios(void)
>  		if (sum != 0)
>  			continue;
>  		if (check->fields.revision != 0) {
> -			printk("PCI: unsupported BIOS32 revision %d at 0x%p\n",
> +			pr_warn("PCI: unsupported BIOS32 revision %d at 0x%p\n",
>  				check->fields.revision, check);
>  			continue;
>  		}
>  		DBG("PCI: BIOS32 Service Directory structure at 0x%p\n", check);
>  		if (check->fields.entry >= 0x100000) {
> -			printk("PCI: BIOS32 entry (0x%p) in high memory, "
> +			pr_warn("PCI: BIOS32 entry (0x%p) in high memory, "
>  					"cannot use.\n", check);
>  			return NULL;
>  		} else {
> @@ -386,7 +386,7 @@ struct irq_routing_table * pcibios_get_irq_routing_table(void)
>  		: "memory");
>  	DBG("OK  ret=%d, size=%d, map=%x\n", ret, opt.size, map);
>  	if (ret & 0xff00)
> -		printk(KERN_ERR "PCI: Error %02x when fetching IRQ routing table.\n", (ret >> 8) & 0xff);
> +		pr_err("PCI: Error %02x when fetching IRQ routing table.\n", (ret >> 8) & 0xff);
>  	else if (opt.size) {
>  		rt = kmalloc(sizeof(struct irq_routing_table) + opt.size, GFP_KERNEL);
>  		if (rt) {
> @@ -394,7 +394,7 @@ struct irq_routing_table * pcibios_get_irq_routing_table(void)
>  			rt->size = opt.size + sizeof(struct irq_routing_table);
>  			rt->exclusive_irqs = map;
>  			memcpy(rt->slots, (void *) page, opt.size);
> -			printk(KERN_INFO "PCI: Using BIOS Interrupt Routing Table\n");
> +			pr_info("PCI: Using BIOS Interrupt Routing Table\n");
>  		}
>  	}
>  	free_page(page);
> -- 
> 2.22.1
> 
