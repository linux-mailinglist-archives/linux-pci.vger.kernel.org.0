Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B144D8F9B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Mar 2022 23:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbiCNWig (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Mar 2022 18:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiCNWig (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Mar 2022 18:38:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE4D3190F;
        Mon, 14 Mar 2022 15:37:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 220391F42EB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647297443;
        bh=37HqJIADNDFxEX7f0Jj15DasWG1X3E9xpO/v1d5HBYg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=korwGU82J8xdn/qphZyic6sWdux4h8s/wjulnsl1agfd38QjorL6GtmRZesVRMCRV
         HPUbEk8fAqSvI6vU9wIsiXagb72DMBQNwoislz97dUcYqBCi9oEWMObML/u2eLpkmC
         /TS8XW+VPPo9crN8pCGD3P2qj0M3oeGuds1K/kL+8y/Gamv+2mD0iKLDI5Ndh8NIny
         YjsYtNOPSZoN7Uaj+ixh6zlXJmCobdxxv1IvPTkcrPBKrcefwUtz7Mnf3FuBYQKeUs
         bIwenSbDztOrtQE/CBUivrHjQZ9K6BnTauZqbNbr/XLcG8mJmnre84DsixFkl2osOt
         N5jEfd7F8l0ZQ==
Message-ID: <a2791312-2957-27e6-43af-c805bbb90266@collabora.com>
Date:   Tue, 15 Mar 2022 01:37:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 2/4] x86/PCI: Add $IRT PIRQ routing table support
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Nikolai Zhubr <zhubr.2@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Michal Necasek <mnecasek@yahoo.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2201021821480.56863@angie.orcam.me.uk>
 <alpine.DEB.2.21.2201022058050.56863@angie.orcam.me.uk>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <alpine.DEB.2.21.2201022058050.56863@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/6/22 14:24, Maciej W. Rozycki wrote:
> Handle the $IRT PCI IRQ Routing Table format used by AMI for its BCP 
> (BIOS Configuration Program) external tool meant for tweaking BIOS 
> structures without the need to rebuild it from sources[1].
> 
> The $IRT format has been invented by AMI before Microsoft has come up 
> with its $PIR format and a $IRT table is therefore there in some systems 
> that lack a $PIR table, such as the DataExpert EXP8449 mainboard based 
> on the ALi FinALi 486 chipset (M1489/M1487), which predates DMI 2.0 and 
> cannot therefore be easily identified at run time.
> 
> Unlike with the $PIR format there is no alignment guarantee as to the 
> placement of the $IRT table, so scan the whole BIOS area bytewise.
> 
> Credit to Michal Necasek for helping me chase documentation for the 
> format.
> 
> References:
> 
> [1] "What is BCP? - AMI", <https://www.ami.com/what-is-bcp/>
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Cc: Michal Necasek <mnecasek@yahoo.com>
> ---
> New change in v3.
> ---
>  arch/x86/include/asm/pci_x86.h |    9 +++++
>  arch/x86/pci/irq.c             |   71 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+)
> 
> linux-x86-pirq-irt.diff
> Index: linux-macro/arch/x86/include/asm/pci_x86.h
> ===================================================================
> --- linux-macro.orig/arch/x86/include/asm/pci_x86.h
> +++ linux-macro/arch/x86/include/asm/pci_x86.h
> @@ -90,6 +90,15 @@ struct irq_routing_table {
>  	struct irq_info slots[0];
>  } __attribute__((packed));
>  
> +struct irt_routing_table {
> +	u32 signature;			/* IRT_SIGNATURE should be here */
> +	u8 size;			/* Number of entries provided */
> +	u8 used;			/* Number of entries actually used */
> +	u16 exclusive_irqs;		/* IRQs devoted exclusively to
> +					   PCI usage */
> +	struct irq_info slots[0];
> +} __attribute__((packed));
> +
>  extern unsigned int pcibios_irq_mask;
>  
>  extern raw_spinlock_t pci_config_lock;
> Index: linux-macro/arch/x86/pci/irq.c
> ===================================================================
> --- linux-macro.orig/arch/x86/pci/irq.c
> +++ linux-macro/arch/x86/pci/irq.c
> @@ -25,6 +25,8 @@
>  #define PIRQ_SIGNATURE	(('$' << 0) + ('P' << 8) + ('I' << 16) + ('R' << 24))
>  #define PIRQ_VERSION 0x0100
>  
> +#define IRT_SIGNATURE	(('$' << 0) + ('I' << 8) + ('R' << 16) + ('T' << 24))
> +
>  static int broken_hp_bios_irq9;
>  static int acer_tm360_irqrouting;
>  
> @@ -91,7 +93,69 @@ static inline struct irq_routing_table *
>  	return NULL;
>  }
>  
> +/*
> + * Handle the $IRT PCI IRQ Routing Table format used by AMI for its BCP
> + * (BIOS Configuration Program) external tool meant for tweaking BIOS
> + * structures without the need to rebuild it from sources.  The $IRT
> + * format has been invented by AMI before Microsoft has come up with its
> + * $PIR format and a $IRT table is therefore there in some systems that
> + * lack a $PIR table.
> + *
> + * It uses the same PCI BIOS 2.1 format for interrupt routing entries
> + * themselves but has a different simpler header prepended instead,
> + * occupying 8 bytes, where a `$IRT' signature is followed by one byte
> + * specifying the total number of interrupt routing entries allocated in
> + * the table, then one byte specifying the actual number of entries used
> + * (which the BCP tool can take advantage of when modifying the table),
> + * and finally a 16-bit word giving the IRQs devoted exclusively to PCI.
> + * Unlike with the $PIR table there is no alignment guarantee.
> + *
> + * Given the similarity of the two formats the $IRT one is trivial to
> + * convert to the $PIR one, which we do here, except that obviously we
> + * have no information as to the router device to use, but we can handle
> + * it by matching PCI device IDs actually seen on the bus against ones
> + * that our individual routers recognise.
> + *
> + * Reportedly there is another $IRT table format where a 16-bit word
> + * follows the header instead that points to interrupt routing entries
> + * in a $PIR table provided elsewhere.  In that case this code will not
> + * be reached though as the $PIR table will have been chosen instead.
> + */
> +static inline struct irq_routing_table *pirq_convert_irt_table(u8 *addr)
> +{
> +	struct irt_routing_table *ir;
> +	struct irq_routing_table *rt;
> +	u16 size;
> +	u8 sum;
> +	int i;
> +
> +	ir = (struct irt_routing_table *)addr;
> +	if (ir->signature != IRT_SIGNATURE || !ir->used || ir->size < ir->used)
> +		return NULL;
>  
> +	DBG(KERN_DEBUG "PCI: $IRT Interrupt Routing Table found at 0x%lx\n",
> +	    __pa(ir));
> +
> +	size = sizeof(*rt) + ir->used * sizeof(rt->slots[0]);
> +	rt = kzalloc(size, GFP_KERNEL);
> +	if (!rt)
> +		return NULL;
> +
> +	rt->signature = PIRQ_SIGNATURE;
> +	rt->version = PIRQ_VERSION;
> +	rt->size = size;
> +	rt->exclusive_irqs = ir->exclusive_irqs;
> +	for (i = 0; i < ir->used; i++)
> +		rt->slots[i] = ir->slots[i];
> +
> +	addr = (u8 *)rt;
> +	sum = 0;
> +	for (i = 0; i < size; i++)
> +		sum += addr[i];
> +	rt->checksum = -sum;
> +
> +	return rt;
> +}
>  
>  /*
>   *  Search 0xf0000 -- 0xfffff for the PCI IRQ Routing Table.
> @@ -113,6 +177,13 @@ static struct irq_routing_table * __init
>  		if (rt)
>  			return rt;
>  	}
> +	for (addr = (u8 *)__va(0xf0000);
> +	     addr < (u8 *)__va(0x100000);
> +	     addr++) {
> +		rt = pirq_convert_irt_table(addr);
> +		if (rt)
> +			return rt;
> +	}
>  	return NULL;
>  }
>  

Hi,

This patch broke crosvm using recent linux-next. The "ir = (struct
irt_routing_table *)addr;" contains invalid pointer. Any ideas why?

PCI: Probing PCI hardware
BUG: unable to handle page fault for address: ffffed1000020000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 12fff4067 P4D 12fff4067 PUD 12fff3067 PMD 12fff2067 PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc7-next-20220310+ #226
Hardware name: ChromiumOS crosvm, BIOS 0
RIP: 0010:kasan_check_range+0xe6/0x1a0
Code: 00 74 ee 48 89 c2 b8 01 00 00 00 48 85 d2 75 5d 5b 41 5c 41 5d 5d
c3 48 85 d2 74 63 4c 01 e2 eb 09 48 83 c0 01 48 39 d0 74 55 <80> 38 00
74 f2 eb d2 41 bd 08 00 00 00 45 29 dd 4b 8d 54 25 00 eb
RSP: 0000:ffff8881002c7d98 EFLAGS: 00010297
RAX: ffffed1000020000 RBX: ffffed1000020001 RCX: ffffffff8440db66
RDX: ffffed1000020001 RSI: 0000000000000004 RDI: ffff8880000ffffd
RBP: ffff8881002c7db0 R08: 0000000000000000 R09: ffff888000100000
R10: ffffed1000020000 R11: 0000000000000001 R12: ffffed100001ffff
R13: ffff888000100000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88810b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed1000020000 CR3: 0000000003a29001 CR4: 0000000000170ef0
Call Trace:
 <TASK>
 __asan_loadN+0xf/0x20
 pcibios_irq_init+0xd7/0x484
 ? pci_legacy_init+0x3b/0x3b
 pci_subsys_init+0x88/0x92
 do_one_initcall+0xba/0x3e0
 ? trace_event_raw_event_initcall_level+0x140/0x140
 ? rcu_read_lock_sched_held+0x46/0x80
 kernel_init_freeable+0x33c/0x395
 ? rest_init+0x280/0x280
 kernel_init+0x1e/0x130
 ret_from_fork+0x1f/0x30
 </TASK>
Modules linked in:
CR2: ffffed1000020000
---[ end trace 0000000000000000 ]---
