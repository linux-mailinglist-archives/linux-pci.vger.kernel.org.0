Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6178A54A27B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 01:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbiFMXPq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 19:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiFMXPp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 19:15:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DB52AE14;
        Mon, 13 Jun 2022 16:15:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B728EB810F1;
        Mon, 13 Jun 2022 23:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46925C34114;
        Mon, 13 Jun 2022 23:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655162141;
        bh=J2zul2usK5OFM2RXAL8FIgAidSHHGWctOtTje8vhn10=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=M1xocRXFpoXUjYI+e7wLUEzPG3PcrYJMYZ+21A+y78dXdwkRbe12JT2pP/iHLNtBo
         +oWJQyUjQHCwIcox+8gsRZMxb0vmR1f+/H8PASh1FH2eaLrrVecq9xeERNOOJV9vGe
         aNMAuzI/wOYvjgIVhthA4wxEt2+TTzvMHhIv6+703apE7vEIlK7x2pifNOA523q5NO
         o1gHdpinBjbCYDsSRHxxc6qB+lOzPc1mUfb6ZxA2I42KzySwXYxRM3GOO/+N/I7F1y
         pJqwaQN6jNlKkhldEsD5miOAY6hT9GeBx6LMTByzOn5Qp7BtxaJRrv3SRX0k4pDQ8x
         CfIVgdXEoyIuQ==
Date:   Mon, 13 Jun 2022 18:15:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH] x86/PCI: Revert: "Clip only host bridge windows for E820
 regions"
Message-ID: <20220613231539.GA722481@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612144325.85366-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 12, 2022 at 04:43:25PM +0200, Hans de Goede wrote:
> Clipping the bridge windows directly from pci_acpi_root_prepare_resources()
> instead of clipping from arch_remove_reservations(), has a number of
> unforseen consequences.
> 
> If there is an e820 reservation in the middle of a bridge window, then
> the smallest of the 2 remaining parts of the window will be also clipped
> off. Where as the previous code would clip regions requested by devices,
> rather then the entire window, leaving regions which were either entirely
> above or below a reservation in the middle of the window alone.
> 
> E.g. on the Steam Deck this leads to this log message:
> 
> acpi PNP0A08:00: clipped [mem 0x80000000-0xf7ffffff window] to [mem 0xa0100000-0xf7ffffff window]
> 
> which then gets followed by these log messages:
> 
> pci 0000:00:01.2: can't claim BAR 14 [mem 0x80600000-0x806fffff]: no compatible bridge window
> pci 0000:00:01.3: can't claim BAR 14 [mem 0x80500000-0x805fffff]: no compatible bridge window
> 
> and many more of these. Ultimately this leads to the Steam Deck
> no longer booting properly, so revert the change.
> 
> Note this is not a clean revert, this revert keeps the later change
> to make the clipping dependent on a new pci_use_e820 bool, moving
> the checking of this bool to arch_remove_reservations().

4c5e242d3e93 was definitely a mistake (my fault).  My intent was to
mainly to improve logging of the clipping, but I didn't implement it
well.

That said, I'd like to understand the connection between the messages
you mention and the failure.  There are four bridges whose MMIO
windows were in the [mem 0x80000000-0x9fffffff] area that we clipped
out.  The log shows that we moved all those windows and the devices in
them to the [mem 0xa0100000-0xf7ffffff] area that remained after
clipping.

So I think this *should* have worked even though we moved things
around unnecessarily.  What am I missing?

The E820 map reports [mem 0xa0000000-0xa00fffff] in the middle of the
_CRS, and we currently trim that out.  We think this is a firmware
defect, so it's likely to break in 2023 if we stop clipping by
default.  I'm concerned that there may be other things in _CRS that we
need to avoid, but firmware isn't telling us about them.

Or there's some dependency in the devices that we moved on their
original addresses, e.g., firmware on the device latched the address
and didn't notice the reassignment.

[1] https://bugzilla.kernel.org/attachment.cgi?id=301154

> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=216109
> Fixes: 4c5e242d3e93 ("x86/PCI: Clip only host bridge windows for E820 regions")
> Reported-and-tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/x86/include/asm/e820/api.h |  5 -----
>  arch/x86/include/asm/pci_x86.h  |  8 ++++++++
>  arch/x86/kernel/resource.c      | 14 +++++++++-----
>  arch/x86/pci/acpi.c             |  8 +-------
>  4 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
> index 5a39ed59b6db..e8f58ddd06d9 100644
> --- a/arch/x86/include/asm/e820/api.h
> +++ b/arch/x86/include/asm/e820/api.h
> @@ -4,9 +4,6 @@
>  
>  #include <asm/e820/types.h>
>  
> -struct device;
> -struct resource;
> -
>  extern struct e820_table *e820_table;
>  extern struct e820_table *e820_table_kexec;
>  extern struct e820_table *e820_table_firmware;
> @@ -46,8 +43,6 @@ extern void e820__register_nosave_regions(unsigned long limit_pfn);
>  
>  extern int  e820__get_entry_type(u64 start, u64 end);
>  
> -extern void remove_e820_regions(struct device *dev, struct resource *avail);
> -
>  /*
>   * Returns true iff the specified range [start,end) is completely contained inside
>   * the ISA region.
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> index f52a886d35cf..70533fdcbf02 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -69,6 +69,8 @@ void pcibios_scan_specific_bus(int busn);
>  
>  /* pci-irq.c */
>  
> +struct pci_dev;
> +
>  struct irq_info {
>  	u8 bus, devfn;			/* Bus, device and function */
>  	struct {
> @@ -246,3 +248,9 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
>  # define x86_default_pci_init_irq	NULL
>  # define x86_default_pci_fixup_irqs	NULL
>  #endif
> +
> +#if defined(CONFIG_PCI) && defined(CONFIG_ACPI)
> +extern bool pci_use_e820;
> +#else
> +#define pci_use_e820 false
> +#endif
> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
> index db2b350a37b7..bba1abd05bfe 100644
> --- a/arch/x86/kernel/resource.c
> +++ b/arch/x86/kernel/resource.c
> @@ -1,7 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <linux/dev_printk.h>
>  #include <linux/ioport.h>
> +#include <linux/printk.h>
>  #include <asm/e820/api.h>
> +#include <asm/pci_x86.h>
>  
>  static void resource_clip(struct resource *res, resource_size_t start,
>  			  resource_size_t end)
> @@ -24,14 +25,14 @@ static void resource_clip(struct resource *res, resource_size_t start,
>  		res->start = end + 1;
>  }
>  
> -void remove_e820_regions(struct device *dev, struct resource *avail)
> +static void remove_e820_regions(struct resource *avail)
>  {
>  	int i;
>  	struct e820_entry *entry;
>  	u64 e820_start, e820_end;
>  	struct resource orig = *avail;
>  
> -	if (!(avail->flags & IORESOURCE_MEM))
> +	if (!pci_use_e820)
>  		return;
>  
>  	for (i = 0; i < e820_table->nr_entries; i++) {
> @@ -41,7 +42,7 @@ void remove_e820_regions(struct device *dev, struct resource *avail)
>  
>  		resource_clip(avail, e820_start, e820_end);
>  		if (orig.start != avail->start || orig.end != avail->end) {
> -			dev_info(dev, "clipped %pR to %pR for e820 entry [mem %#010Lx-%#010Lx]\n",
> +			pr_info("clipped %pR to %pR for e820 entry [mem %#010Lx-%#010Lx]\n",
>  				 &orig, avail, e820_start, e820_end);
>  			orig = *avail;
>  		}
> @@ -55,6 +56,9 @@ void arch_remove_reservations(struct resource *avail)
>  	 * the low 1MB unconditionally, as this area is needed for some ISA
>  	 * cards requiring a memory range, e.g. the i82365 PCMCIA controller.
>  	 */
> -	if (avail->flags & IORESOURCE_MEM)
> +	if (avail->flags & IORESOURCE_MEM) {
>  		resource_clip(avail, BIOS_ROM_BASE, BIOS_ROM_END);
> +
> +		remove_e820_regions(avail);
> +	}
>  }
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index a4f43054bc79..2f82480fd430 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -8,7 +8,6 @@
>  #include <linux/pci-acpi.h>
>  #include <asm/numa.h>
>  #include <asm/pci_x86.h>
> -#include <asm/e820/api.h>
>  
>  struct pci_root_info {
>  	struct acpi_pci_root_info common;
> @@ -20,7 +19,7 @@ struct pci_root_info {
>  #endif
>  };
>  
> -static bool pci_use_e820 = true;
> +bool pci_use_e820 = true;
>  static bool pci_use_crs = true;
>  static bool pci_ignore_seg;
>  
> @@ -387,11 +386,6 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
>  
>  	status = acpi_pci_probe_root_resources(ci);
>  
> -	if (pci_use_e820) {
> -		resource_list_for_each_entry(entry, &ci->resources)
> -			remove_e820_regions(&device->dev, entry->res);
> -	}
> -
>  	if (pci_use_crs) {
>  		resource_list_for_each_entry_safe(entry, tmp, &ci->resources)
>  			if (resource_is_pcicfg_ioport(entry->res))
> -- 
> 2.36.0
> 
