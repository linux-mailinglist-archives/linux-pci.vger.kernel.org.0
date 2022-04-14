Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD316501B04
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 20:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344537AbiDNSZi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 14:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiDNSZ3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 14:25:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5EFEA742;
        Thu, 14 Apr 2022 11:23:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B141F617BA;
        Thu, 14 Apr 2022 18:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A27C385A8;
        Thu, 14 Apr 2022 18:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649960583;
        bh=Yb83EN+sDLgzqvgweWLW49J1Fc/NtV05Qrk0Xa6Lqoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ADx2a5KuaQKlxYnF/wamQ+z5LP9F2h0tZILHySNKoSEs8rdeYyzXrGpq76jAFD0MD
         +TlXK2OiZLp2Ln5h/Cl5Gp316v3ANnT6xFmA4R/uW/k+WoYKySJru26BDwY3yPUZ5m
         fcd9of7tr1VQTZcJPSY9HDNui+86VQGDE4GjN4wWt3ScTSTMGVVVZ+PgliI35BwzTq
         hy7LAsn4fqIS+Dl9ONKwrj3Q69JrJrVWBK1HSTRk3uV40bjh88hTnAacpld4VxpOY6
         V8Kb7At6BhjDxF4vf7xyFzRb8HwUWCQfrZcFNQfqTa3eyRAFBqpqiUq441R88gHpDq
         kEq7sqtZlhiJw==
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
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 3/3] x86/PCI: Clip only host bridge windows for E820 regions
Date:   Thu, 14 Apr 2022 13:22:52 -0500
Message-Id: <20220414182252.758742-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414182252.758742-1-helgaas@kernel.org>
References: <20220414182252.758742-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
table in the allocate_resource() path, but the implementation has a couple
issues:

  - The clipping is done for *all* allocations, not just those for PCI
    address space, and

  - The clipping is done at each allocation instead of being done once when
    setting up the host bridge windows.

Rework the implementation so we only clip PCI host bridge windows, and we
do it once when setting them up.

Example output changes:

    BIOS-e820: [mem 0x00000000b0000000-0x00000000c00fffff] reserved
  + acpi PNP0A08:00: clipped [mem 0xc0000000-0xfebfffff window] to [mem 0xc0100000-0xfebfffff window] for e820 entry [mem 0xb0000000-0xc00fffff]
  - pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
  + pci_bus 0000:00: root bus resource [mem 0xc0100000-0xfebfffff window]

Link: https://lore.kernel.org/r/20220304035110.988712-3-helgaas@kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/include/asm/e820/api.h |  5 +++++
 arch/x86/kernel/resource.c      | 14 +++++++-------
 arch/x86/pci/acpi.c             |  5 +++++
 3 files changed, 17 insertions(+), 7 deletions(-)

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
index 30d524adb012..db2b350a37b7 100644
--- a/arch/x86/kernel/resource.c
+++ b/arch/x86/kernel/resource.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/dev_printk.h>
 #include <linux/ioport.h>
-#include <linux/printk.h>
 #include <asm/e820/api.h>
 
 static void resource_clip(struct resource *res, resource_size_t start,
@@ -24,13 +24,16 @@ static void resource_clip(struct resource *res, resource_size_t start,
 		res->start = end + 1;
 }
 
-static void remove_e820_regions(struct resource *avail)
+void remove_e820_regions(struct device *dev, struct resource *avail)
 {
 	int i;
 	struct e820_entry *entry;
 	u64 e820_start, e820_end;
 	struct resource orig = *avail;
 
+	if (!(avail->flags & IORESOURCE_MEM))
+		return;
+
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		entry = &e820_table->entries[i];
 		e820_start = entry->addr;
@@ -38,7 +41,7 @@ static void remove_e820_regions(struct resource *avail)
 
 		resource_clip(avail, e820_start, e820_end);
 		if (orig.start != avail->start || orig.end != avail->end) {
-			pr_info("clipped %pR to %pR for e820 entry [mem %#010Lx-%#010Lx]\n",
+			dev_info(dev, "clipped %pR to %pR for e820 entry [mem %#010Lx-%#010Lx]\n",
 				 &orig, avail, e820_start, e820_end);
 			orig = *avail;
 		}
@@ -52,9 +55,6 @@ void arch_remove_reservations(struct resource *avail)
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

