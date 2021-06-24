Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970873B2BDA
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 11:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhFXJ4A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 05:56:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60082 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhFXJ4A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jun 2021 05:56:00 -0400
Received: from 61-220-137-34.hinet-ip.hinet.net ([61.220.137.34] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <hui.wang@canonical.com>)
        id 1lwM3D-0004No-Ml; Thu, 24 Jun 2021 09:53:36 +0000
From:   Hui Wang <hui.wang@canonical.com>
To:     bhelgaas@google.com
Cc:     yinghai@kernel.org, mingo@redhat.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com,
        hui.wang@canonical.com
Subject: [PATCH] x86/PCI: Conditionally add a non-e820 mapped window to root bridge
Date:   Thu, 24 Jun 2021 17:53:24 +0800
Message-Id: <20210624095324.34906-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The touchpad can't work on many Lenovo Ideapad S145/BS145 laptops.
But it works well under Windows.

On those machines, the touchpad is an I2C device, while the I2C host
controllers fail to initialize as below shown:
 pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
 pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
 pci 0000:00:15.1: BAR 0: no space for [mem size 0x00001000 64bit]
 pci 0000:00:15.1: BAR 0: failed to assign [mem size 0x00001000 64bit]

The BIOS assigns iomem space to host bridge and I2C host controller
like this:
 pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
 pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]

 pci 0000:00:15.0: [8086:34e8] type 00 class 0x0c8000
 pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
 pci 0000:00:15.1: [8086:34e9] type 00 class 0x0c8000
 pci 0000:00:15.1: reg 0x10: [mem 0x00000000-0x00000fff 64bit]

The I2C host controllers need to allocate iomem space from root
bridge, but all iomem window of the root bridge are overlapped with
BIOS-e820 mapped region, that makes the allocate_resource() fail:
 BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
 BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reserved
 ...
 BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved

We could add "pci=nocrs" to make the touchpad work, but users expect
the touchpad to work out-of-box under Linux distro as under Windows.

Here design a generic solution for x86 machines, if host bridge uses
crs, we will check if all root bridge iomem windows are overlapped
with BIOS-e820 mapped region, if yes, we try to build a non-e820
mapped window according to the biggest gap in the e820 mapped region,
and we need to clip this window with MMCONFIG region if this region
is not mapped by BIOS-e820, then insert this window to the tail of
the root bridge.

After this change, the I2C host controller could allocate the iomem
region from host bridge successfully and the touchpad could work
out-of-box.

BugLink: http://bugs.launchpad.net/bugs/1931715
BugLink: http://bugs.launchpad.net/bugs/1932069
BugLink: http://bugs.launchpad.net/bugs/1921649
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 arch/x86/include/asm/e820/api.h |  1 +
 arch/x86/include/asm/pci.h      |  2 ++
 arch/x86/include/asm/pci_x86.h  |  1 +
 arch/x86/kernel/e820.c          |  2 ++
 arch/x86/pci/acpi.c             | 46 ++++++++++++++++++++++++++++++++-
 arch/x86/pci/mmconfig-shared.c  | 28 ++++++++++++++++++++
 6 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index e8f58ddd06d9..46c76201dc28 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -9,6 +9,7 @@ extern struct e820_table *e820_table_kexec;
 extern struct e820_table *e820_table_firmware;
 
 extern unsigned long pci_mem_start;
+extern unsigned long pci_mem_gap_size;
 
 extern bool e820__mapped_raw_any(u64 start, u64 end, enum e820_type type);
 extern bool e820__mapped_any(u64 start, u64 end, enum e820_type type);
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index d2c76c8d8cfd..a940a792ef7b 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -81,6 +81,8 @@ static inline int pcibios_assign_all_busses(void) { return 0; }
 #endif
 
 extern unsigned long pci_mem_start;
+extern unsigned long pci_mem_gap_size;
+
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		(pci_mem_start)
 
diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 490411dba438..3ea30aed9100 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -171,6 +171,7 @@ extern int pci_mmconfig_delete(u16 seg, u8 start, u8 end);
 extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
 extern struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int start,
 							int end, u64 addr);
+extern void pci_mmconfig_clip_resource(struct resource *res);
 
 extern struct list_head pci_mmcfg_list;
 
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index bc0657f0deed..2933745b19b7 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -66,6 +66,7 @@ struct e820_table *e820_table_firmware __refdata	= &e820_table_firmware_init;
 
 /* For PCI or other memory-mapped resources */
 unsigned long pci_mem_start = 0xaeedbabe;
+unsigned long pci_mem_gap_size;
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL(pci_mem_start);
 #endif
@@ -677,6 +678,7 @@ __init void e820__setup_pci_gap(void)
 	 * e820__reserve_resources_late() protects stolen RAM already:
 	 */
 	pci_mem_start = gapstart;
+	pci_mem_gap_size = gapsize;
 
 	pr_info("[mem %#010lx-%#010lx] available for PCI devices\n",
 		gapstart, gapstart + gapsize - 1);
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 948656069cdd..e3a691024683 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -231,6 +231,11 @@ static void teardown_mcfg_map(struct acpi_pci_root_info *ci)
 		info->mcfg_added = false;
 	}
 }
+
+static void clip_resource_from_mmcfg(struct resource *res)
+{
+	return pci_mmconfig_clip_resource(res);
+}
 #else
 static int setup_mcfg_map(struct acpi_pci_root_info *ci)
 {
@@ -240,6 +245,10 @@ static int setup_mcfg_map(struct acpi_pci_root_info *ci)
 static void teardown_mcfg_map(struct acpi_pci_root_info *ci)
 {
 }
+
+static void clip_resource_from_mmcfg(struct resource *res)
+{
+}
 #endif
 
 static int pci_acpi_root_get_node(struct acpi_pci_root *root)
@@ -296,13 +305,48 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
 	struct acpi_device *device = ci->bridge;
 	int busnum = ci->root->secondary.start;
 	struct resource_entry *entry, *tmp;
+	bool has_non_e820_region = false;
 	int status;
 
 	status = acpi_pci_probe_root_resources(ci);
 	if (pci_use_crs) {
-		resource_list_for_each_entry_safe(entry, tmp, &ci->resources)
+		resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
+			struct resource avail = *entry->res;
+
 			if (resource_is_pcicfg_ioport(entry->res))
 				resource_list_destroy_entry(entry);
+
+			if (avail.flags & IORESOURCE_MEM) {
+				arch_remove_reservations(&avail);
+				if (avail.end > avail.start)
+					has_non_e820_region = true;
+			}
+		}
+
+		/* all bridge windows are in the BIOS-e820 mapped region, this
+		 * will make allocate_resource() fail when PCI devices request
+		 * iomem address from bridge. To fix it, we try to build a non
+		 * e820 mapped iomem resource and clip it with MMCONFIG region,
+		 * then add it to the bridge window list.
+		 */
+		if (!has_non_e820_region) {
+			struct resource_entry *rentry;
+			struct resource avail;
+
+			avail.start = pci_mem_start;
+			avail.end = pci_mem_start + pci_mem_gap_size - 1;
+			avail.flags = IORESOURCE_MEM | IORESOURCE_WINDOW;
+			avail.name = ci->name;
+			clip_resource_from_mmcfg(&avail);
+			if (avail.end > avail.start) {
+				rentry = resource_list_create_entry(NULL, 0);
+				if (rentry) {
+					*rentry->res = avail;
+					resource_list_add_tail(rentry, &ci->resources);
+				}
+			}
+		}
+
 		return status;
 	}
 
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index de6bf0e7e8f8..1f3ffb1bcdc8 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -813,3 +813,31 @@ int pci_mmconfig_delete(u16 seg, u8 start, u8 end)
 
 	return -ENOENT;
 }
+
+void pci_mmconfig_clip_resource(struct resource *res)
+{
+	struct pci_mmcfg_region *cfg;
+	resource_size_t start, end;
+	resource_size_t low = 0, high = 0;
+
+	/* Refers to the resource_clip() in the x86/kernel/resource.c */
+	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list) {
+		start = cfg->res.start;
+		end = cfg->res.end;
+
+		if (res->end < start || res->start > end)
+			continue;	/* no conflict */
+
+		if (res->start < start)
+			low = start - res->start;
+
+		if (res->end > end)
+			high = res->end - end;
+
+		/* Keep the area above or below the conflict, whichever is larger */
+		if (low > high)
+			res->end = start - 1;
+		else
+			res->start = end + 1;
+	}
+}
-- 
2.25.1

