Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B66C660880
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jan 2023 21:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjAFUxP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Jan 2023 15:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjAFUwv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2023 15:52:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020ED60DB;
        Fri,  6 Jan 2023 12:52:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7801D61F7B;
        Fri,  6 Jan 2023 20:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994F3C433D2;
        Fri,  6 Jan 2023 20:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673038368;
        bh=g/RIiNB9/RFoA9UF9GYBh0qSF9aeCBwIFqFvltrJ9yE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=S/P2HsxGgwQyCezihm4mvB5ATvcsO0NiKNH6TpcE5bHVRgaN2vJ4yPkSJp6UwLUqi
         nkrouS0Z3wpfcpV4CiFy6p6oBXUBA6lr4cMnT+LAIQX5XQZHsWhVhQdzIjOWciU9XE
         A1mGKSFGNlaUEGoSLOL5NeE0kt+jr8g5tOaEGodnD+tEg42Coh0BE+PzUMSKM8xQl0
         FUjKXQbTzOJaMiw+KXw0m0xEfkaqghrS9OwSBsTkp5ksz4Ob/LAeSxdBtA+ZONMpGX
         I6NAvaljkpt7usoHZr0LG9sfi5FkY8U5xK2xgBirY7kkCXYT1UPpfTZYAyZqEh0Tb6
         P6XfczAuBBiwA==
Date:   Fri, 6 Jan 2023 14:52:46 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Luck, Tony" <tony.luck@intel.com>
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
Message-ID: <20230106205246.GA1250625@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083140CF57548745F445A56FCFB9@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 06, 2023 at 06:03:13PM +0000, Luck, Tony wrote:
> > Tony, would you mind collecting a dmesg log with "efi=debug"?  I want
> > to see the EFI_MEMORY_MAPPED_IO size and what we remove from E820.
> 
> Bjorn,
> 
> Booted the 6.2-rc1 kernel with the patch that you provided yesterday with efi=debug option.
> 
> Compressed dmesg file attached.

Thanks, Tony!  Something is wrong with the EFI MMIO removal
(obviously), but I don't see what it is.  Could you try the patch
below (replacement for previous one, with more debug)?


commit ce347c04cc2f ("x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space")
parent 1b929c02afd3
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Jan 5 16:02:58 2023 -0600

    x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space
    
    Normally we reject ECAM space unless it is reported as reserved in the E820
    table or via a PNP0C02 _CRS method (PCI Firmware, r3.3, sec 4.1.2).  This
    means extended config space (offsets 0x100-0xfff) may not be accessible.
    
    Some firmware doesn't report ECAM space via PNP0C02 _CRS methods, but does
    mention it as an EfiMemoryMappedIO region via EFI GetMemoryMap(), which is
    normally converted to an E820 entry by a bootloader or EFI stub.
    
    07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map"), removes
    E820 entries that correspond to EfiMemoryMappedIO regions because some
    other firmware uses EfiMemoryMappedIO for PCI host bridge windows, and the
    E820 entries prevent Linux from allocating BAR space for hot-added devices.
    
    Allow use of ECAM for extended config space when the region is covered by
    an EfiMemoryMappedIO region, even if it's not included in E820 or PNP0C02
    _CRS.
    
    Fixes: 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map")
    Link: https://lore.kernel.org/r/ac2693d8-8ba3-72e0-5b66-b3ae008d539d@linux.intel.com

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 758cbfe55daa..07308f403649 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/efi.h>
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/bitmap.h>
@@ -442,6 +443,33 @@ static bool is_acpi_reserved(u64 start, u64 end, enum e820_type not_used)
 	return mcfg_res.flags;
 }
 
+static bool is_efi_mmio(u64 start, u64 end, enum e820_type not_used)
+{
+	efi_memory_desc_t *md;
+	u64 size, mmio_start, mmio_end;
+
+	pr_info("is_efi_mmio %#lx-%#lx\n",
+		(unsigned long) start, (unsigned long) end);
+	for_each_efi_memory_desc(md) {
+		if (md->type == EFI_MEMORY_MAPPED_IO) {
+			size = md->num_pages << EFI_PAGE_SHIFT;
+			mmio_start = md->phys_addr;
+			mmio_end = mmio_start + size - 1;
+
+			pr_info("  efi_mmio %#lx-%#lx\n",
+				(unsigned long) mmio_start,
+				(unsigned long) mmio_end);
+			if (mmio_start <= start && end <= mmio_end) {
+				pr_info("is_efi_mmio true\n");
+				return true;
+			}
+		}
+	}
+
+	pr_info("is_efi_mmio false\n");
+	return false;
+}
+
 typedef bool (*check_reserved_t)(u64 start, u64 end, enum e820_type type);
 
 static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
@@ -452,23 +480,24 @@ static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
 	u64 size = resource_size(&cfg->res);
 	u64 old_size = size;
 	int num_buses;
-	char *method = with_e820 ? "E820" : "ACPI motherboard resources";
+	char *method = with_e820 ? "E820" : "ACPI motherboard resources or EFI";
 
+	pr_info("is_mmconf_reserved %ps [bus %02x-%02x] %pR\n",
+		is_reserved, cfg->start_bus, cfg->end_bus, &cfg->res);
 	while (!is_reserved(addr, addr + size, E820_TYPE_RESERVED)) {
+		pr_info("  %#lx-%#lx (size %#lx) not reserved\n",
+			(unsigned long) addr, (unsigned long) (addr + size - 1),
+			(unsigned long) size);
 		size >>= 1;
+		pr_info("  size reduced to %#lx\n", (unsigned long) size);
 		if (size < (16UL<<20))
 			break;
 	}
 
-	if (size < (16UL<<20) && size != old_size)
+	if (size < (16UL<<20) && size != old_size) {
+		pr_info("is_mmconf_reserved %ps false\n", is_reserved);
 		return false;
-
-	if (dev)
-		dev_info(dev, "MMCONFIG at %pR reserved in %s\n",
-			 &cfg->res, method);
-	else
-		pr_info(PREFIX "MMCONFIG at %pR reserved in %s\n",
-		       &cfg->res, method);
+	}
 
 	if (old_size != size) {
 		/* update end_bus */
@@ -487,30 +516,42 @@ static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
 				&cfg->res, (unsigned long) cfg->address);
 		else
 			pr_info(PREFIX
-				"MMCONFIG for %04x [bus%02x-%02x] "
+				"MMCONFIG for %04x [bus %02x-%02x] "
 				"at %pR (base %#lx) (size reduced!)\n",
 				cfg->segment, cfg->start_bus, cfg->end_bus,
 				&cfg->res, (unsigned long) cfg->address);
 	}
 
+	if (dev)
+		dev_info(dev, "MMCONFIG at %pR reserved in %s\n",
+			 &cfg->res, method);
+	else
+		pr_info(PREFIX "MMCONFIG at %pR reserved in %s\n",
+		       &cfg->res, method);
+
 	return true;
 }
 
 static bool __ref
 pci_mmcfg_check_reserved(struct device *dev, struct pci_mmcfg_region *cfg, int early)
 {
+	pr_info("pci_mmcfg_check_reserved([bus %02x-%02x] %pR, %s)\n",
+		cfg->start_bus, cfg->end_bus, &cfg->res,
+		early ? "early" : "late");
 	if (!early && !acpi_disabled) {
 		if (is_mmconf_reserved(is_acpi_reserved, cfg, dev, 0))
 			return true;
+		if (is_mmconf_reserved(is_efi_mmio, cfg, dev, 0))
+			return true;
 
 		if (dev)
 			dev_info(dev, FW_INFO
-				 "MMCONFIG at %pR not reserved in "
+				 "MMCONFIG at %pR not reserved in EFI or "
 				 "ACPI motherboard resources\n",
 				 &cfg->res);
 		else
 			pr_info(FW_INFO PREFIX
-			       "MMCONFIG at %pR not reserved in "
+			       "MMCONFIG at %pR not reserved in EFI or "
 			       "ACPI motherboard resources\n",
 			       &cfg->res);
 	}
@@ -536,6 +577,7 @@ static void __init pci_mmcfg_reject_broken(int early)
 {
 	struct pci_mmcfg_region *cfg;
 
+	pr_info("pci_mmcfg_reject_broken(%s)\n", early ? "early" : "late");
 	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
 		if (pci_mmcfg_check_reserved(NULL, cfg, early) == 0) {
 			pr_info(PREFIX "not using MMCONFIG\n");
@@ -570,6 +612,7 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
 	unsigned long i;
 	int entries;
 
+	pr_info("pci_parse_mcfg\n");
 	if (!header)
 		return -EINVAL;
 
@@ -661,6 +704,7 @@ static int __initdata known_bridge;
 
 void __init pci_mmcfg_early_init(void)
 {
+	pr_info("pci_mmcfg_early_init\n");
 	if (pci_probe & PCI_PROBE_MMCONF) {
 		if (pci_mmcfg_check_hostbridge())
 			known_bridge = 1;
@@ -674,6 +718,7 @@ void __init pci_mmcfg_early_init(void)
 
 void __init pci_mmcfg_late_init(void)
 {
+	pr_info("pci_mmcfg_late_init\n");
 	/* MMCONFIG disabled */
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
 		return;
@@ -725,6 +770,8 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 	struct resource *tmp = NULL;
 	struct pci_mmcfg_region *cfg;
 
+	dev_info(dev, "pci_mmconfig_insert %02x-%02x addr %#lx\n",
+		 start, end, (unsigned long)addr);
 	if (!(pci_probe & PCI_PROBE_MMCONF) || pci_mmcfg_arch_init_failed)
 		return -ENODEV;
 
@@ -788,6 +835,7 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 
 	mutex_unlock(&pci_mmcfg_lock);
 
+	dev_info(dev, "pci_mmconfig_insert returns %d\n", rc);
 	return rc;
 }
 
