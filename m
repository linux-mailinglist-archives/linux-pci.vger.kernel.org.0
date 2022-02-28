Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A1B4C68FD
	for <lists+linux-pci@lfdr.de>; Mon, 28 Feb 2022 11:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiB1K4K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Feb 2022 05:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbiB1Ky6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Feb 2022 05:54:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC96919C35
        for <linux-pci@vger.kernel.org>; Mon, 28 Feb 2022 02:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646045604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7GQmQW/BlbYfYtfb064IAKtH+WOfqAhIygtC6q2kp90=;
        b=NGeqhu+XYp4q3Yr0aQOJX5FhsRi680K6ShqbnNKKb1PGUPQENos6pVi5LwLGHpcD6BkOn3
        uXGJ0uLHkfeYeGxzajPL7+M8ehkd9/imR5mpEVH4NZnDYm9EXCjvVy+NPaaGFtIRGKbBHw
        BHxVGXyiQaQ+Jv+iA+vWCc6M6R8yScQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-86vaKDhnPq-Z9agzHNbIhQ-1; Mon, 28 Feb 2022 05:53:18 -0500
X-MC-Unique: 86vaKDhnPq-Z9agzHNbIhQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF5261006AA9;
        Mon, 28 Feb 2022 10:53:16 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.193.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C62066C92C;
        Mon, 28 Feb 2022 10:53:12 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        =?UTF-8?q?Benoit=20Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/PCI: Disable exclusion of E820 reserved addressed in some cases
Date:   Mon, 28 Feb 2022 11:52:59 +0100
Message-Id: <20220228105259.230903-2-hdegoede@redhat.com>
In-Reply-To: <20220228105259.230903-1-hdegoede@redhat.com>
References: <20220228105259.230903-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some fw has a bug where the PCI bridge window returned by the ACPI
resources partly overlaps with some other address range, causing issues.
To workaround this Linux excludes E820 reserved addresses when allocating
addresses from the PCI bridge window. 2 known examples of such fw bugs are:

1. The returned window contains addresses which map to system RAM,
see commit 4dc2287c1805 ("x86: avoid E820 regions when allocating
address space").

2. The Lenovo X1 carbon gen 2 BIOS has an overlap between an EFI/E820
reserved range and the ACPI provided PCI bridge window:
 efi: mem46: [MMIO] range=[0x00000000dfa00000-0x00000000dfa0ffff] (0MB)
 BIOS-e820: [mem 0x00000000dceff000-0x00000000dfa0ffff] reserved
 pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
If Linux assigns the overlapping 0xdfa00000-0xdfa0ffff range to a PCI BAR
then the system fails to resume after a suspend.

Recently (2019) some systems have shown-up with EFI memmap MMIO entries
covering the entire ACPI provided PCI bridge window. These memmap entries
get converted into e820_table entries, causing all attempts to assign
memory to PCI BARs which have not been setup by the BIOS to fail.
For example see these dmesg snippets from a Lenovo IdeaPad 3 15IIL 81WE:
 efi: mem63: [MMIO] range=[0x0000000065400000-0x00000000cfffffff] (1708MB)
 BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
 pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
 pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
 pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]

To fix this, check if the ACPI provided PCI bridge window is fully
contained within in EFI memmap MMIO region and in that case disable
the "exclude E820 reserved addresses" workaround, fixing the problem
of not being able to find free space for unassigned BARs.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=2029207
BugLink: https://bugs.launchpad.net/bugs/1878279
BugLink: https://bugs.launchpad.net/bugs/1931715
BugLink: https://bugs.launchpad.net/bugs/1932069
BugLink: https://bugs.launchpad.net/bugs/1921649
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Add a couple of missing includes to arch/x86/include/asm/pci_x86.h
  to fix i386 build errors Reported-by: kernel test robot <lkp@intel.com>
- Do not call resource_is_efi_mmio_region() on resource-list entries which
  have just been destroyed because they match resource_is_pcicfg_ioport()
  Reported-by: kernel test robot <oliver.sang@intel.com>
- Add (res->flags & IORESOURCE_MEM) check to resource_is_efi_mmio_region()
---
 arch/x86/include/asm/pci_x86.h | 10 +++++
 arch/x86/kernel/resource.c     |  4 ++
 arch/x86/pci/acpi.c            | 68 +++++++++++++++++++++++++++++++++-
 3 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 490411dba438..4ce61ab01a4f 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -5,7 +5,9 @@
  *	(c) 1999 Martin Mares <mj@ucw.cz>
  */
 
+#include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/spinlock.h>
 
 #undef DEBUG
 
@@ -64,6 +66,8 @@ void pcibios_scan_specific_bus(int busn);
 
 /* pci-irq.c */
 
+struct pci_dev;
+
 struct irq_info {
 	u8 bus, devfn;			/* Bus, device and function */
 	struct {
@@ -232,3 +236,9 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
 # define x86_default_pci_init_irq	NULL
 # define x86_default_pci_fixup_irqs	NULL
 #endif
+
+#if defined CONFIG_PCI && defined CONFIG_ACPI
+extern bool pci_use_e820;
+#else
+#define pci_use_e820 true
+#endif
diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
index 9b9fb7882c20..e8dc9bc327bd 100644
--- a/arch/x86/kernel/resource.c
+++ b/arch/x86/kernel/resource.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/ioport.h>
 #include <asm/e820/api.h>
+#include <asm/pci_x86.h>
 
 static void resource_clip(struct resource *res, resource_size_t start,
 			  resource_size_t end)
@@ -28,6 +29,9 @@ static void remove_e820_regions(struct resource *avail)
 	int i;
 	struct e820_entry *entry;
 
+	if (!pci_use_e820)
+		return;
+
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		entry = &e820_table->entries[i];
 
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 052f1d78a562..fce05e03ba9e 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/efi.h>
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/init.h>
@@ -21,6 +22,7 @@ struct pci_root_info {
 
 static bool pci_use_crs = true;
 static bool pci_ignore_seg;
+bool pci_use_e820 = true;
 
 static int __init set_use_crs(const struct dmi_system_id *id)
 {
@@ -291,6 +293,63 @@ static bool resource_is_pcicfg_ioport(struct resource *res)
 		res->start == 0xCF8 && res->end == 0xCFF;
 }
 
+/*
+ * Some fw has a bug where the PCI bridge window returned by the ACPI resources
+ * partly overlaps with some other address range, causing issues. To workaround
+ * this Linux excludes E820 reserved addresses when allocating addresses from
+ * the PCI bridge window. 2 known examples of such firmware bugs are:
+ *
+ * 1. The returned window contains addresses which map to system RAM, see
+ * commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address space").
+ *
+ * 2. The Lenovo X1 carbon gen 2 BIOS has an overlap between an EFI/E820
+ * reserved range and the ACPI provided PCI bridge window:
+ *  efi: mem46: [MMIO] range=[0x00000000dfa00000-0x00000000dfa0ffff] (0MB)
+ *  BIOS-e820: [mem 0x00000000dceff000-0x00000000dfa0ffff] reserved
+ *  pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
+ * If Linux assigns the overlapping 0xdfa00000-0xdfa0ffff range to a PCI BAR
+ * then the system fails to resume after a suspend.
+ *
+ * Recently (2019) some systems have shown-up with EFI memmap MMIO entries
+ * covering the entire ACPI provided PCI bridge window. These memmap entries
+ * get converted into e820_table entries, causing all attempts to assign
+ * memory to PCI BARs which have not been setup by the BIOS to fail.
+ * For example see these dmesg snippets from a Lenovo IdeaPad 3 15IIL 81WE:
+ *  efi: mem63: [MMIO] range=[0x0000000065400000-0x00000000cfffffff] (1708MB)
+ *  BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
+ *  pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
+ *  pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
+ *  pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
+ *
+ * To code below checks if the ACPI provided PCI bridge window is fully
+ * contained within in EFI memmap MMIO region and in that case disables
+ * the "exclude E820 reserved addresses" workaround to avoid this issue.
+ */
+static bool resource_is_efi_mmio_region(const struct resource *res)
+{
+	unsigned long long start, end;
+	efi_memory_desc_t *md;
+
+	if (!(res->flags & IORESOURCE_MEM))
+		return false;
+
+	if (!efi_enabled(EFI_MEMMAP))
+		return false;
+
+	for_each_efi_memory_desc(md) {
+		if (md->type != EFI_MEMORY_MAPPED_IO)
+			continue;
+
+		start = md->phys_addr;
+		end = start + (md->num_pages << EFI_PAGE_SHIFT) - 1;
+
+		if (res->start >= start && res->end <= end)
+			return true;
+	}
+
+	return false;
+}
+
 static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
 {
 	struct acpi_device *device = ci->bridge;
@@ -300,9 +359,16 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
 
 	status = acpi_pci_probe_root_resources(ci);
 	if (pci_use_crs) {
-		resource_list_for_each_entry_safe(entry, tmp, &ci->resources)
+		resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
 			if (resource_is_pcicfg_ioport(entry->res))
 				resource_list_destroy_entry(entry);
+			else if (resource_is_efi_mmio_region(entry->res)) {
+				dev_info(&device->dev,
+					"host bridge window %pR is marked by EFI as MMIO\n",
+					entry->res);
+				pci_use_e820 = false;
+			}
+		}
 		return status;
 	}
 
-- 
2.35.1

