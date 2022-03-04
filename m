Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7ABC4CCC67
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 04:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237568AbiCDDxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 22:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbiCDDxE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 22:53:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA7217FD02;
        Thu,  3 Mar 2022 19:52:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BC24B826D4;
        Fri,  4 Mar 2022 03:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC3CC340E9;
        Fri,  4 Mar 2022 03:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646365934;
        bh=CbSbR1Qb5nogbSSYnnK5tukbcwJVTkBgo2iOOiMKzRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WDZ31iVtHppWxxiM+s1Tj+jup0dQyvzdzgjEb9JnmNtYFYBKZSzLPCa0IaA+8y5b7
         qcMmn60xbaNpAXpMuCrrSJ3hLbF9ihUJ8l4o8qRZcKZDqGslw9txivGoazAWAhi3Cl
         lpYMRknAa6XrvYrILQtQQc47XPEvmnL8vnrJ4/o+tOkW2GclUDk0uLTKcEqWW9F4W4
         TQkELBk3nRUn7c9WS6SWZmF75OQlB1vtUK3xKTOEs01mJ0O72F4D4Y1q7IHJUSgJBr
         nWx6TmAupSOIoGCzH6QfwHhY6dfZYFRDqK/YPYk8hbI01Os9KdraSItJilnQDMsSxk
         1TfathMkYY/ww==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        =?UTF-8?q?Benoit=20Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/3] x86/PCI: Log host bridge window clipping for E820 regions
Date:   Thu,  3 Mar 2022 21:51:10 -0600
Message-Id: <20220304035110.988712-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220304035110.988712-1-helgaas@kernel.org>
References: <20220304035110.988712-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

ACPI firmware advertises PCI host bridge resources via PNP0A03 _CRS
methods.  Some BIOSes include non-window address space in _CRS, and if we
allocate that non-window space for PCI devices, they don't work.

4dc2287c1805 ("x86: avoid E820 regions when allocating address space")
works around this issue by clipping out any regions mentioned in the E820
table in the allocate_resource() path, but the implementation has several
issues:

  - The clipping is done for *all* allocations, not just those for PCI
    address space,

  - The clipping is done at each allocation instead of being done once when
    setting up the host bridge windows, and

  - The host bridge windows logged in dmesg do not reflect the clipping,
    and in fact there is *no* indication in dmesg, which complicates
    debugging.

Rework the implementation so we only clip PCI host bridge windows, we do it
once when setting them up, we a log message when a window is clipped, and
we reflect the clip when printing the host bridge windows.

I intend this only to improve the logging, not to fix any issues.

Example output changes:

    BIOS-e820: [mem 0x00000000b0000000-0x00000000c00fffff] reserved
  + acpi PNP0A08:00: clipped [mem 0xc0000000-0xfebfffff window] to [mem 0xc0100000-0xfebfffff window] for e820 entry [mem 0xb0000000-0xc00fffff]
  - pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
  + pci_bus 0000:00: root bus resource [mem 0xc0100000-0xfebfffff window]

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/include/asm/e820/api.h |  5 +++++
 arch/x86/kernel/resource.c      | 17 ++++++++++++-----
 arch/x86/pci/acpi.c             |  5 +++++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index e8f58ddd06d9..5a39ed59b6db 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -4,6 +4,9 @@
 
 #include <asm/e820/types.h>
 
+struct device;
+struct resource;
+
 extern struct e820_table *e820_table;
 extern struct e820_table *e820_table_kexec;
 extern struct e820_table *e820_table_firmware;
@@ -43,6 +46,8 @@ extern void e820__register_nosave_regions(unsigned long limit_pfn);
 
 extern int  e820__get_entry_type(u64 start, u64 end);
 
+extern void remove_e820_regions(struct device *dev, struct resource *avail);
+
 /*
  * Returns true iff the specified range [start,end) is completely contained inside
  * the ISA region.
diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
index 8ffe68437744..7378ea146976 100644
--- a/arch/x86/kernel/resource.c
+++ b/arch/x86/kernel/resource.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/dev_printk.h>
 #include <linux/ioport.h>
 #include <asm/e820/api.h>
 
@@ -23,18 +24,27 @@ static void resource_clip(struct resource *res, resource_size_t start,
 		res->start = end + 1;
 }
 
-static void remove_e820_regions(struct resource *avail)
+void remove_e820_regions(struct device *dev, struct resource *avail)
 {
+	struct resource orig = *avail;
 	int i;
 	struct e820_entry *entry;
 	u64 e820_start, e820_end;
 
+	if (!(avail->flags & IORESOURCE_MEM))
+		return;
+
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		entry = &e820_table->entries[i];
 		e820_start = entry->addr;
 		e820_end = entry->addr + entry->size - 1;
 
 		resource_clip(avail, e820_start, e820_end);
+		if (orig.start != avail->start || orig.end != avail->end) {
+			dev_info(dev, "clipped %pR to %pR for e820 entry [mem %#010Lx-%#010Lx]\n",
+				 &orig, avail, e820_start, e820_end);
+			orig = *avail;
+		}
 	}
 }
 
@@ -45,9 +55,6 @@ void arch_remove_reservations(struct resource *avail)
 	 * the low 1MB unconditionally, as this area is needed for some ISA
 	 * cards requiring a memory range, e.g. the i82365 PCMCIA controller.
 	 */
-	if (avail->flags & IORESOURCE_MEM) {
+	if (avail->flags & IORESOURCE_MEM)
 		resource_clip(avail, BIOS_ROM_BASE, BIOS_ROM_END);
-
-		remove_e820_regions(avail);
-	}
 }
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 052f1d78a562..562c81a51ea0 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -8,6 +8,7 @@
 #include <linux/pci-acpi.h>
 #include <asm/numa.h>
 #include <asm/pci_x86.h>
+#include <asm/e820/api.h>
 
 struct pci_root_info {
 	struct acpi_pci_root_info common;
@@ -299,6 +300,10 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
 	int status;
 
 	status = acpi_pci_probe_root_resources(ci);
+
+	resource_list_for_each_entry(entry, &ci->resources)
+		remove_e820_regions(&device->dev, entry->res);
+
 	if (pci_use_crs) {
 		resource_list_for_each_entry_safe(entry, tmp, &ci->resources)
 			if (resource_is_pcicfg_ioport(entry->res))
-- 
2.25.1

