Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2013F6648C9
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 19:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjAJSPH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 13:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbjAJSOi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 13:14:38 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14158E9AF;
        Tue, 10 Jan 2023 10:12:45 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 35acc9045854cbcd; Tue, 10 Jan 2023 19:12:44 +0100
Received: from kreacher.localnet (unknown [213.134.183.108])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 0C30A262495C;
        Tue, 10 Jan 2023 19:12:43 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Luck, Tony" <tony.luck@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "kernelorg@undead.fr" <kernelorg@undead.fr>,
        "kjhambrick@gmail.com" <kjhambrick@gmail.com>,
        "2lprbe78@duck.com" <2lprbe78@duck.com>,
        "nicholas.johnson-opensource@outlook.com.au" 
        <nicholas.johnson-opensource@outlook.com.au>,
        "benoitg@coeus.ca" <benoitg@coeus.ca>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "wse@tuxedocomputers.com" <wse@tuxedocomputers.com>,
        "mumblingdrunkard@protonmail.com" <mumblingdrunkard@protonmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Box, David E" <david.e.box@intel.com>,
        "Sun, Yunying" <yunying.sun@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: Bug report: the extended PCI config space is missed with 6.2-rc2
Date:   Tue, 10 Jan 2023 19:12:42 +0100
Message-ID: <2287772.ElGaqSPkdT@kreacher>
In-Reply-To: <20230106220449.GA1255065@bhelgaas>
References: <20230106220449.GA1255065@bhelgaas>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.183.108
X-CLIENT-HOSTNAME: 213.134.183.108
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrledvgdegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrddukeefrddutdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekfedruddtkedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepudelpdhrtghpthhtohepthhonhihrdhluhgtkhesihhnthgvlhdrtghomhdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnrdhjrdifihhllhhirghmshesihhnthgvlhdrtghomhdprhgtphhtthhopehkrghnrdhlihgrnhhgsehlihhnuhigrdhinhhtvghlrdgt
 ohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhgvrhhnvghlohhrghesuhhnuggvrggurdhfrhdprhgtphhtthhopehkjhhhrghmsghrihgtkhesghhmrghilhdrtghomhdprhgtphhtthhopedvlhhprhgsvgejkeesughutghkrdgtohhmpdhrtghpthhtohepnhhitghhohhlrghsrdhjohhhnhhsohhnqdhophgvnhhsohhurhgtvgesohhuthhlohhokhdrtghomhdrrghupdhrtghpthhtohepsggvnhhoihhtghestghovghushdrtggrpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeifshgvsehtuhigvgguohgtohhmphhuthgvrhhsrdgtohhmpdhrtghpthhtohepmhhumhgslhhinhhgughruhhnkhgrrhgusehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhhiugdrvgdrsghogiesihhnthgvlhdrtghomhdprhgtphhtthhopeihuhhnhihinhhgrdhsuhhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrvhgvrdhjihgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=19 Fuz1=19 Fuz2=19
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday, January 6, 2023 11:04:49 PM CET Bjorn Helgaas wrote:
> On Fri, Jan 06, 2023 at 09:37:06PM +0000, Luck, Tony wrote:
> > > Thanks, Tony!  Something is wrong with the EFI MMIO removal
> > > (obviously), but I don't see what it is.  Could you try the patch
> > > below (replacement for previous one, with more debug)?
> > 
> > Swapped out old patch for this new one. Booted with efi-debug
> > 
> > New dmesg attached.
> 
> Thanks!  Ah, off-by-one error because e820__mapped_all() expects
> "[start, end)" which means is_acpi_reserved() and is_efi_mmio() must
> use the same, and I was thinking "[start, end]" like a struct
> resource.
> 
> The below should work better.
> 
> commit 696ac9286d3d ("x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space")
> parent 1b929c02afd3
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu Jan 5 16:02:58 2023 -0600
> 
>     x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space
>     
>     Normally we reject ECAM space unless it is reported as reserved in the E820
>     table or via a PNP0C02 _CRS method (PCI Firmware, r3.3, sec 4.1.2).  This
>     means extended config space (offsets 0x100-0xfff) may not be accessible.
>     
>     Some firmware doesn't report ECAM space via PNP0C02 _CRS methods, but does
>     mention it as an EfiMemoryMappedIO region via EFI GetMemoryMap(), which is
>     normally converted to an E820 entry by a bootloader or EFI stub.
>     
>     07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map"), removes
>     E820 entries that correspond to EfiMemoryMappedIO regions because some
>     other firmware uses EfiMemoryMappedIO for PCI host bridge windows, and the
>     E820 entries prevent Linux from allocating BAR space for hot-added devices.
>     
>     Allow use of ECAM for extended config space when the region is covered by
>     an EfiMemoryMappedIO region, even if it's not included in E820 or PNP0C02
>     _CRS.
>     
>     Fixes: 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map")
>     Link: https://lore.kernel.org/r/ac2693d8-8ba3-72e0-5b66-b3ae008d539d@linux.intel.com

This prints quite a few debug-level messages to dmesg.  I guess you'll post an
update with fewer of them?

In any case, please feel free to add

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

to it.

> 
> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index 758cbfe55daa..5c6cadd60fef 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/efi.h>
>  #include <linux/pci.h>
>  #include <linux/init.h>
>  #include <linux/bitmap.h>
> @@ -442,6 +443,34 @@ static bool is_acpi_reserved(u64 start, u64 end, enum e820_type not_used)
>  	return mcfg_res.flags;
>  }
>  
> +static bool is_efi_mmio(u64 start, u64 end, enum e820_type not_used)
> +{
> +	efi_memory_desc_t *md;
> +	u64 size, mmio_start, mmio_end;
> +
> +	end--;		/* caller supplies start, end = start + size */
> +	pr_info("is_efi_mmio %#lx-%#lx\n",
> +		(unsigned long) start, (unsigned long) end);
> +	for_each_efi_memory_desc(md) {
> +		if (md->type == EFI_MEMORY_MAPPED_IO) {
> +			size = md->num_pages << EFI_PAGE_SHIFT;
> +			mmio_start = md->phys_addr;
> +			mmio_end = mmio_start + size - 1;
> +
> +			pr_info("  efi_mmio %#lx-%#lx\n",
> +				(unsigned long) mmio_start,
> +				(unsigned long) mmio_end);
> +			if (mmio_start <= start && end <= mmio_end) {
> +				pr_info("is_efi_mmio true\n");
> +				return true;
> +			}
> +		}
> +	}
> +
> +	pr_info("is_efi_mmio false\n");
> +	return false;
> +}
> +
>  typedef bool (*check_reserved_t)(u64 start, u64 end, enum e820_type type);
>  
>  static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
> @@ -452,23 +481,24 @@ static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
>  	u64 size = resource_size(&cfg->res);
>  	u64 old_size = size;
>  	int num_buses;
> -	char *method = with_e820 ? "E820" : "ACPI motherboard resources";
> +	char *method = with_e820 ? "E820" : "ACPI motherboard resources or EFI";
>  
> +	pr_info("is_mmconf_reserved %ps [bus %02x-%02x] %pR\n",
> +		is_reserved, cfg->start_bus, cfg->end_bus, &cfg->res);
>  	while (!is_reserved(addr, addr + size, E820_TYPE_RESERVED)) {
> +		pr_info("  %#lx-%#lx (size %#lx) not reserved\n",
> +			(unsigned long) addr, (unsigned long) (addr + size - 1),
> +			(unsigned long) size);
>  		size >>= 1;
> +		pr_info("  size reduced to %#lx\n", (unsigned long) size);
>  		if (size < (16UL<<20))
>  			break;
>  	}
>  
> -	if (size < (16UL<<20) && size != old_size)
> +	if (size < (16UL<<20) && size != old_size) {
> +		pr_info("is_mmconf_reserved %ps false\n", is_reserved);
>  		return false;
> -
> -	if (dev)
> -		dev_info(dev, "MMCONFIG at %pR reserved in %s\n",
> -			 &cfg->res, method);
> -	else
> -		pr_info(PREFIX "MMCONFIG at %pR reserved in %s\n",
> -		       &cfg->res, method);
> +	}
>  
>  	if (old_size != size) {
>  		/* update end_bus */
> @@ -487,30 +517,42 @@ static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
>  				&cfg->res, (unsigned long) cfg->address);
>  		else
>  			pr_info(PREFIX
> -				"MMCONFIG for %04x [bus%02x-%02x] "
> +				"MMCONFIG for %04x [bus %02x-%02x] "
>  				"at %pR (base %#lx) (size reduced!)\n",
>  				cfg->segment, cfg->start_bus, cfg->end_bus,
>  				&cfg->res, (unsigned long) cfg->address);
>  	}
>  
> +	if (dev)
> +		dev_info(dev, "MMCONFIG at %pR reserved in %s\n",
> +			 &cfg->res, method);
> +	else
> +		pr_info(PREFIX "MMCONFIG at %pR reserved in %s\n",
> +		       &cfg->res, method);
> +
>  	return true;
>  }
>  
>  static bool __ref
>  pci_mmcfg_check_reserved(struct device *dev, struct pci_mmcfg_region *cfg, int early)
>  {
> +	pr_info("pci_mmcfg_check_reserved([bus %02x-%02x] %pR, %s)\n",
> +		cfg->start_bus, cfg->end_bus, &cfg->res,
> +		early ? "early" : "late");
>  	if (!early && !acpi_disabled) {
>  		if (is_mmconf_reserved(is_acpi_reserved, cfg, dev, 0))
>  			return true;
> +		if (is_mmconf_reserved(is_efi_mmio, cfg, dev, 0))
> +			return true;
>  
>  		if (dev)
>  			dev_info(dev, FW_INFO
> -				 "MMCONFIG at %pR not reserved in "
> +				 "MMCONFIG at %pR not reserved in EFI or "
>  				 "ACPI motherboard resources\n",
>  				 &cfg->res);
>  		else
>  			pr_info(FW_INFO PREFIX
> -			       "MMCONFIG at %pR not reserved in "
> +			       "MMCONFIG at %pR not reserved in EFI or "
>  			       "ACPI motherboard resources\n",
>  			       &cfg->res);
>  	}
> @@ -536,6 +578,7 @@ static void __init pci_mmcfg_reject_broken(int early)
>  {
>  	struct pci_mmcfg_region *cfg;
>  
> +	pr_info("pci_mmcfg_reject_broken(%s)\n", early ? "early" : "late");
>  	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
>  		if (pci_mmcfg_check_reserved(NULL, cfg, early) == 0) {
>  			pr_info(PREFIX "not using MMCONFIG\n");
> @@ -570,6 +613,7 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
>  	unsigned long i;
>  	int entries;
>  
> +	pr_info("pci_parse_mcfg\n");
>  	if (!header)
>  		return -EINVAL;
>  
> @@ -661,6 +705,7 @@ static int __initdata known_bridge;
>  
>  void __init pci_mmcfg_early_init(void)
>  {
> +	pr_info("pci_mmcfg_early_init\n");
>  	if (pci_probe & PCI_PROBE_MMCONF) {
>  		if (pci_mmcfg_check_hostbridge())
>  			known_bridge = 1;
> @@ -674,6 +719,7 @@ void __init pci_mmcfg_early_init(void)
>  
>  void __init pci_mmcfg_late_init(void)
>  {
> +	pr_info("pci_mmcfg_late_init\n");
>  	/* MMCONFIG disabled */
>  	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
>  		return;
> @@ -725,6 +771,8 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
>  	struct resource *tmp = NULL;
>  	struct pci_mmcfg_region *cfg;
>  
> +	dev_info(dev, "pci_mmconfig_insert %02x-%02x addr %#lx\n",
> +		 start, end, (unsigned long)addr);
>  	if (!(pci_probe & PCI_PROBE_MMCONF) || pci_mmcfg_arch_init_failed)
>  		return -ENODEV;
>  
> @@ -788,6 +836,7 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
>  
>  	mutex_unlock(&pci_mmcfg_lock);
>  
> +	dev_info(dev, "pci_mmconfig_insert returns %d\n", rc);
>  	return rc;
>  }
>  
> 




