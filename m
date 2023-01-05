Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4A365F6DA
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 23:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbjAEWdl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 17:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236154AbjAEWdE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 17:33:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E801F1AD9F;
        Thu,  5 Jan 2023 14:33:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CAC661C39;
        Thu,  5 Jan 2023 22:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF87EC433D2;
        Thu,  5 Jan 2023 22:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672957979;
        bh=HcR7gX7Z25zEr4pomkEsYZ1F9HP2NRLj7CFnIeJEr08=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FPcO3gpWWfNAolLDBQvveUWU/aEbChbW95onX9goElI/kS8t1hTOgE90PxVbCEWeo
         Lnzo/RUbiZtj1coHzP7Byq7mexbXYfLLQzfdexGFh304EuZNFjf5cOrYx9q1yJGTRa
         RWGTMzE0sJayz/GqXwJ8csqs4LOo9/gu4ILcPspDnj71HlEpIT9po1cfccExQuuWYM
         3jrloQWuzGW1W6zh5hdjU/TPZMSO0KHTp2+9/xgVMDoi/Uc0EFXW+MqNciHbaYHMae
         VmURx0gdcGVxlh2/m095jZ9fBKgQQr0j8wVyqzrvPKGaXRbkLa4fsYOQwAZNTzdS37
         fLkZ7Mdi/XRPA==
Date:   Thu, 5 Jan 2023 16:32:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     bhelgaas@google.com, hdegoede@redhat.com, kernelorg@undead.fr,
        kjhambrick@gmail.com, 2lprbe78@duck.com,
        nicholas.johnson-opensource@outlook.com.au, benoitg@coeus.ca,
        mika.westerberg@linux.intel.com, wse@tuxedocomputers.com,
        mumblingdrunkard@protonmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, david.e.box@intel.com,
        yunying.sun@intel.com, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: Bug report: the extended PCI config space is missed with 6.2-rc2
Message-ID: <20230105223257.GA1177387@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac2693d8-8ba3-72e0-5b66-b3ae008d539d@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Tony, Dan]

On Wed, Jan 04, 2023 at 09:39:56AM -0500, Liang, Kan wrote:
> Hi Bjorn,
> 
> Happy new year!
> 
> We found some PCI issues with the latest 6.2-rc2.
> 
> - Using the lspci -xxxx, the extended PCI config space of all PCI
> devices are missed with the latest 6.2-rc2. The system we used had 932
> PCI devices, at least 800 which have extended space as seen when booted
> into a 5.15 kernel. But none of them appeared in 6.2-rc2.
> - The drivers which rely on the information in the extended PCI config
> space don't work anymore. We have confirmed that the perf uncore driver
> (uncore performance monitoring) and Intel VSEC driver (telemetry) don't
> work in 6.2-rc2. There could be more drivers which are impacted.
> 
> After a bisect, we found the regression is caused by the below commit
> 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map").
> After reverting the commit, the issues are gone.

Can you try this patch (based on v6.2-rc1):


commit 89a0067217b0 ("x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space")
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
index 758cbfe55daa..4adc587a4c94 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/efi.h>
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/bitmap.h>
@@ -442,6 +443,25 @@ static bool is_acpi_reserved(u64 start, u64 end, enum e820_type not_used)
 	return mcfg_res.flags;
 }
 
+static bool is_efi_reserved(u64 start, u64 end, enum e820_type not_used)
+{
+	efi_memory_desc_t *md;
+	u64 size, mmio_start, mmio_end;
+
+	for_each_efi_memory_desc(md) {
+		if (md->type == EFI_MEMORY_MAPPED_IO) {
+			size = md->num_pages << EFI_PAGE_SHIFT;
+			mmio_start = md->phys_addr;
+			mmio_end = mmio_start + size - 1;
+
+			if (mmio_start <= start && end <= mmio_end)
+				return true;
+		}
+	}
+
+	return false;
+}
+
 typedef bool (*check_reserved_t)(u64 start, u64 end, enum e820_type type);
 
 static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
@@ -452,7 +472,7 @@ static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
 	u64 size = resource_size(&cfg->res);
 	u64 old_size = size;
 	int num_buses;
-	char *method = with_e820 ? "E820" : "ACPI motherboard resources";
+	char *method = with_e820 ? "E820" : "ACPI motherboard resources or EFI";
 
 	while (!is_reserved(addr, addr + size, E820_TYPE_RESERVED)) {
 		size >>= 1;
@@ -502,15 +522,17 @@ pci_mmcfg_check_reserved(struct device *dev, struct pci_mmcfg_region *cfg, int e
 	if (!early && !acpi_disabled) {
 		if (is_mmconf_reserved(is_acpi_reserved, cfg, dev, 0))
 			return true;
+		if (is_mmconf_reserved(is_efi_reserved, cfg, dev, 0))
+			return true;
 
 		if (dev)
 			dev_info(dev, FW_INFO
-				 "MMCONFIG at %pR not reserved in "
+				 "MMCONFIG at %pR not reserved in EFI "
 				 "ACPI motherboard resources\n",
 				 &cfg->res);
 		else
 			pr_info(FW_INFO PREFIX
-			       "MMCONFIG at %pR not reserved in "
+			       "MMCONFIG at %pR not reserved in EFI or "
 			       "ACPI motherboard resources\n",
 			       &cfg->res);
 	}
