Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FD6547A8B
	for <lists+linux-pci@lfdr.de>; Sun, 12 Jun 2022 16:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiFLOoD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Jun 2022 10:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbiFLOnn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Jun 2022 10:43:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84A4B1C902
        for <linux-pci@vger.kernel.org>; Sun, 12 Jun 2022 07:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655045020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Uacl4Gu2f17K+DWtcbsCPLU5Mxk2A2DFPC9sh1m+0eE=;
        b=a18zZUkIc8JGKe7eEuCZ4Niwhvo+kuaTwkImFn+PTJI0KCPtarawHbhn4xDFwX5ICCCfPD
        3dlBmLMH+xHHXjtQ27L1nV7H9Efm5ZWIiFCq4UIB6/02V2VUIrddSpE5PtLdTKg5u8k1ZN
        lri6Vy4iTd86FOZ3EBTPopUQN/M1Qz4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-7V3xAowiMsWTw1V71knW3Q-1; Sun, 12 Jun 2022 10:43:37 -0400
X-MC-Unique: 7V3xAowiMsWTw1V71knW3Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66707802E5B;
        Sun, 12 Jun 2022 14:43:36 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F34E1121314;
        Sun, 12 Jun 2022 14:43:33 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Benoit=20Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH] x86/PCI: Revert: "Clip only host bridge windows for E820 regions"
Date:   Sun, 12 Jun 2022 16:43:25 +0200
Message-Id: <20220612144325.85366-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Clipping the bridge windows directly from pci_acpi_root_prepare_resources()
instead of clipping from arch_remove_reservations(), has a number of
unforseen consequences.

If there is an e820 reservation in the middle of a bridge window, then
the smallest of the 2 remaining parts of the window will be also clipped
off. Where as the previous code would clip regions requested by devices,
rather then the entire window, leaving regions which were either entirely
above or below a reservation in the middle of the window alone.

E.g. on the Steam Deck this leads to this log message:

acpi PNP0A08:00: clipped [mem 0x80000000-0xf7ffffff window] to [mem 0xa0100000-0xf7ffffff window]

which then gets followed by these log messages:

pci 0000:00:01.2: can't claim BAR 14 [mem 0x80600000-0x806fffff]: no compatible bridge window
pci 0000:00:01.3: can't claim BAR 14 [mem 0x80500000-0x805fffff]: no compatible bridge window

and many more of these. Ultimately this leads to the Steam Deck
no longer booting properly, so revert the change.

Note this is not a clean revert, this revert keeps the later change
to make the clipping dependent on a new pci_use_e820 bool, moving
the checking of this bool to arch_remove_reservations().

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=216109
Fixes: 4c5e242d3e93 ("x86/PCI: Clip only host bridge windows for E820 regions")
Reported-and-tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/include/asm/e820/api.h |  5 -----
 arch/x86/include/asm/pci_x86.h  |  8 ++++++++
 arch/x86/kernel/resource.c      | 14 +++++++++-----
 arch/x86/pci/acpi.c             |  8 +-------
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index 5a39ed59b6db..e8f58ddd06d9 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -4,9 +4,6 @@
 
 #include <asm/e820/types.h>
 
-struct device;
-struct resource;
-
 extern struct e820_table *e820_table;
 extern struct e820_table *e820_table_kexec;
 extern struct e820_table *e820_table_firmware;
@@ -46,8 +43,6 @@ extern void e820__register_nosave_regions(unsigned long limit_pfn);
 
 extern int  e820__get_entry_type(u64 start, u64 end);
 
-extern void remove_e820_regions(struct device *dev, struct resource *avail);
-
 /*
  * Returns true iff the specified range [start,end) is completely contained inside
  * the ISA region.
diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index f52a886d35cf..70533fdcbf02 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -69,6 +69,8 @@ void pcibios_scan_specific_bus(int busn);
 
 /* pci-irq.c */
 
+struct pci_dev;
+
 struct irq_info {
 	u8 bus, devfn;			/* Bus, device and function */
 	struct {
@@ -246,3 +248,9 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
 # define x86_default_pci_init_irq	NULL
 # define x86_default_pci_fixup_irqs	NULL
 #endif
+
+#if defined(CONFIG_PCI) && defined(CONFIG_ACPI)
+extern bool pci_use_e820;
+#else
+#define pci_use_e820 false
+#endif
diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
index db2b350a37b7..bba1abd05bfe 100644
--- a/arch/x86/kernel/resource.c
+++ b/arch/x86/kernel/resource.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/dev_printk.h>
 #include <linux/ioport.h>
+#include <linux/printk.h>
 #include <asm/e820/api.h>
+#include <asm/pci_x86.h>
 
 static void resource_clip(struct resource *res, resource_size_t start,
 			  resource_size_t end)
@@ -24,14 +25,14 @@ static void resource_clip(struct resource *res, resource_size_t start,
 		res->start = end + 1;
 }
 
-void remove_e820_regions(struct device *dev, struct resource *avail)
+static void remove_e820_regions(struct resource *avail)
 {
 	int i;
 	struct e820_entry *entry;
 	u64 e820_start, e820_end;
 	struct resource orig = *avail;
 
-	if (!(avail->flags & IORESOURCE_MEM))
+	if (!pci_use_e820)
 		return;
 
 	for (i = 0; i < e820_table->nr_entries; i++) {
@@ -41,7 +42,7 @@ void remove_e820_regions(struct device *dev, struct resource *avail)
 
 		resource_clip(avail, e820_start, e820_end);
 		if (orig.start != avail->start || orig.end != avail->end) {
-			dev_info(dev, "clipped %pR to %pR for e820 entry [mem %#010Lx-%#010Lx]\n",
+			pr_info("clipped %pR to %pR for e820 entry [mem %#010Lx-%#010Lx]\n",
 				 &orig, avail, e820_start, e820_end);
 			orig = *avail;
 		}
@@ -55,6 +56,9 @@ void arch_remove_reservations(struct resource *avail)
 	 * the low 1MB unconditionally, as this area is needed for some ISA
 	 * cards requiring a memory range, e.g. the i82365 PCMCIA controller.
 	 */
-	if (avail->flags & IORESOURCE_MEM)
+	if (avail->flags & IORESOURCE_MEM) {
 		resource_clip(avail, BIOS_ROM_BASE, BIOS_ROM_END);
+
+		remove_e820_regions(avail);
+	}
 }
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index a4f43054bc79..2f82480fd430 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -8,7 +8,6 @@
 #include <linux/pci-acpi.h>
 #include <asm/numa.h>
 #include <asm/pci_x86.h>
-#include <asm/e820/api.h>
 
 struct pci_root_info {
 	struct acpi_pci_root_info common;
@@ -20,7 +19,7 @@ struct pci_root_info {
 #endif
 };
 
-static bool pci_use_e820 = true;
+bool pci_use_e820 = true;
 static bool pci_use_crs = true;
 static bool pci_ignore_seg;
 
@@ -387,11 +386,6 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
 
 	status = acpi_pci_probe_root_resources(ci);
 
-	if (pci_use_e820) {
-		resource_list_for_each_entry(entry, &ci->resources)
-			remove_e820_regions(&device->dev, entry->res);
-	}
-
 	if (pci_use_crs) {
 		resource_list_for_each_entry_safe(entry, tmp, &ci->resources)
 			if (resource_is_pcicfg_ioport(entry->res))
-- 
2.36.0

