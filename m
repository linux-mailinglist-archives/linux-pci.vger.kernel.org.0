Return-Path: <linux-pci+bounces-57-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5057F3614
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 19:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BFD51C20C9E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 18:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F239A5101D;
	Tue, 21 Nov 2023 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cenByNCB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18F52209C
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 18:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D99EC433CA;
	Tue, 21 Nov 2023 18:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700591817;
	bh=vo3MZDqW+Z3xew+bZ0yVaVgoQ/ZSfXW64VxgJtdChKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cenByNCBwKHrvz+iinowjOOjdRGjIHajEmb7Nj5WgFVAiS43K7P4MpCbVAcxFwe9A
	 f4brBXwCCZ98rErjjq8oFPBg+ESciok/x4I0trA9blXfXG4PPCLLHPFV18G+9/DF/D
	 D1d59X1zoxE5JVQrbf5MUS2twG7qAuq7o/f6weDKP0sCCzPOxg1yNgJ+3pcz3bf4xB
	 9HCmoUQi+A76gsnvYfbgPXahXp8X3SbbozZE+vbEPWzmJu47ZXa+vgkvHNmLVlkmwD
	 9dP5eHYbXy0Jy3Hca55FSLykt2i0ogukTURtptbmn2kVyi2KYIqHRDjOE7aBjaEjeM
	 grM8SkQz04iEA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Yunying Sun <yunying.sun@intel.com>,
	Tomasz Pala <gotar@polanet.pl>,
	Sebastian Manciulea <manciuleas@protonmail.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4/9] x86/pci: Rename 'MMCONFIG' to 'ECAM', use pr_fmt
Date: Tue, 21 Nov 2023 12:36:38 -0600
Message-Id: <20231121183643.249006-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121183643.249006-1-helgaas@kernel.org>
References: <20231121183643.249006-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

The "MMCONFIG" term is not used in PCI/PCIe specs.  Replace it with "ECAM",
the term used in PCIe r6.0, sec 7.2.2.

Define pr_fmt() instead of repeating PREFIX in every log message.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/mmconfig-shared.c | 111 ++++++++++++++-------------------
 arch/x86/pci/mmconfig_32.c     |   2 +-
 arch/x86/pci/mmconfig_64.c     |   6 +-
 3 files changed, 52 insertions(+), 67 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index bc1312d920da..896cc11013bd 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * mmconfig-shared.c - Low-level direct PCI config space access via
- *                     MMCONFIG - common code between i386 and x86-64.
+ * Low-level direct PCI config space access via ECAM - common code between
+ * i386 and x86-64.
  *
  * This code does:
  * - known chipset handling
@@ -11,6 +11,8 @@
  * themselves.
  */
 
+#define pr_fmt(fmt) "PCI: " fmt
+
 #include <linux/acpi.h>
 #include <linux/efi.h>
 #include <linux/pci.h>
@@ -24,9 +26,7 @@
 #include <asm/pci_x86.h>
 #include <asm/acpi.h>
 
-#define PREFIX "PCI: "
-
-/* Indicate if the mmcfg resources have been placed into the resource table. */
+/* Indicate if the ECAM resources have been placed into the resource table */
 static bool pci_mmcfg_running_state;
 static bool pci_mmcfg_arch_init_failed;
 static DEFINE_MUTEX(pci_mmcfg_lock);
@@ -90,7 +90,7 @@ static struct pci_mmcfg_region *pci_mmconfig_alloc(int segment, int start,
 	res->end = addr + PCI_MMCFG_BUS_OFFSET(end + 1) - 1;
 	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 	snprintf(new->name, PCI_MMCFG_RESOURCE_NAME_LEN,
-		 "PCI MMCONFIG %04x [bus %02x-%02x]", segment, start, end);
+		 "PCI ECAM %04x [bus %02x-%02x]", segment, start, end);
 	res->name = new->name;
 
 	return new;
@@ -107,10 +107,8 @@ struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int start,
 		list_add_sorted(new);
 		mutex_unlock(&pci_mmcfg_lock);
 
-		pr_info(PREFIX
-		       "MMCONFIG for domain %04x [bus %02x-%02x] at %pR "
-		       "(base %#lx)\n",
-		       segment, start, end, &new->res, (unsigned long)addr);
+		pr_info("ECAM %pR (base %#lx) for domain %04x [bus %02x-%02x]\n",
+			&new->res, (unsigned long)addr, segment, start, end);
 	}
 
 	return new;
@@ -205,7 +203,7 @@ static const char *__init pci_mmcfg_amd_fam10h(void)
 	msr <<= 32;
 	msr |= low;
 
-	/* mmconfig is not enable */
+	/* ECAM is not enabled */
 	if (!(msr & FAM10H_MMIO_CONF_ENABLE))
 		return NULL;
 
@@ -367,7 +365,7 @@ static int __init pci_mmcfg_check_hostbridge(void)
 			name = pci_mmcfg_probes[i].probe();
 
 		if (name)
-			pr_info(PREFIX "%s with MMCONFIG support\n", name);
+			pr_info("%s with ECAM support\n", name);
 	}
 
 	/* some end_bus_number is crazy, fix it */
@@ -487,11 +485,10 @@ static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
 		return false;
 
 	if (dev)
-		dev_info(dev, "MMCONFIG at %pR reserved as %s\n",
+		dev_info(dev, "ECAM %pR reserved as %s\n",
 			 &cfg->res, method);
 	else
-		pr_info(PREFIX "MMCONFIG at %pR reserved as %s\n",
-		       &cfg->res, method);
+		pr_info("ECAM %pR reserved as %s\n", &cfg->res, method);
 
 	if (old_size != size) {
 		/* update end_bus */
@@ -500,20 +497,16 @@ static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
 		cfg->res.end = cfg->res.start +
 		    PCI_MMCFG_BUS_OFFSET(num_buses) - 1;
 		snprintf(cfg->name, PCI_MMCFG_RESOURCE_NAME_LEN,
-			 "PCI MMCONFIG %04x [bus %02x-%02x]",
+			 "PCI ECAM %04x [bus %02x-%02x]",
 			 cfg->segment, cfg->start_bus, cfg->end_bus);
 
 		if (dev)
-			dev_info(dev,
-				"MMCONFIG "
-				"at %pR (base %#lx) (size reduced!)\n",
-				&cfg->res, (unsigned long) cfg->address);
+			dev_info(dev, "ECAM %pR (base %#lx) (size reduced!)\n",
+				 &cfg->res, (unsigned long) cfg->address);
 		else
-			pr_info(PREFIX
-				"MMCONFIG for %04x [bus%02x-%02x] "
-				"at %pR (base %#lx) (size reduced!)\n",
-				cfg->segment, cfg->start_bus, cfg->end_bus,
-				&cfg->res, (unsigned long) cfg->address);
+			pr_info("ECAM %pR (base %#lx) for %04x [bus%02x-%02x] (size reduced!)\n",
+				&cfg->res, (unsigned long) cfg->address,
+				cfg->segment, cfg->start_bus, cfg->end_bus);
 	}
 
 	return true;
@@ -530,15 +523,11 @@ pci_mmcfg_check_reserved(struct device *dev, struct pci_mmcfg_region *cfg, int e
 			return true;
 
 		if (dev)
-			dev_info(dev, FW_INFO
-				 "MMCONFIG at %pR not reserved in "
-				 "ACPI motherboard resources\n",
+			dev_info(dev, FW_INFO "ECAM %pR not reserved in ACPI motherboard resources\n",
 				 &cfg->res);
 		else
-			pr_info(FW_INFO PREFIX
-			       "MMCONFIG at %pR not reserved in "
-			       "ACPI motherboard resources\n",
-			       &cfg->res);
+			pr_info(FW_INFO "ECAM %pR not reserved in ACPI motherboard resources\n",
+			        &cfg->res);
 
 		if (is_efi_mmio(&cfg->res)) {
 			pr_info("ECAM %pR is EfiMemoryMappedIO; assuming valid\n",
@@ -546,10 +535,10 @@ pci_mmcfg_check_reserved(struct device *dev, struct pci_mmcfg_region *cfg, int e
 			conflict = insert_resource_conflict(&iomem_resource,
 							    &cfg->res);
 			if (conflict)
-				pr_warn("MMCONFIG %pR conflicts with %s %pR\n",
+				pr_warn("ECAM %pR conflicts with %s %pR\n",
 					&cfg->res, conflict->name, conflict);
 			else
-				pr_info("MMCONFIG %pR reserved to work around lack of ACPI motherboard _CRS\n",
+				pr_info("ECAM %pR reserved to work around lack of ACPI motherboard _CRS\n",
 					&cfg->res);
 			return true;
 		}
@@ -579,7 +568,7 @@ static void __init pci_mmcfg_reject_broken(int early)
 
 	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
 		if (pci_mmcfg_check_reserved(NULL, cfg, early) == 0) {
-			pr_info(PREFIX "not using MMCONFIG (%pR not reserved)\n",
+			pr_info("not using ECAM (%pR not reserved)\n",
 				&cfg->res);
 			free_all_mmcfg();
 			return;
@@ -599,9 +588,9 @@ static int __init acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg,
 	if ((mcfg->header.revision >= 1) && (dmi_get_bios_year() >= 2010))
 		return 0;
 
-	pr_err(PREFIX "MCFG region for %04x [bus %02x-%02x] at %#llx "
-	       "is above 4GB, ignored\n", cfg->pci_segment,
-	       cfg->start_bus_number, cfg->end_bus_number, cfg->address);
+	pr_err("ECAM at %#llx for %04x [bus %02x-%02x] is above 4GB, ignored\n",
+	       cfg->address, cfg->pci_segment, cfg->start_bus_number,
+	       cfg->end_bus_number);
 	return -EINVAL;
 }
 
@@ -626,7 +615,7 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
 		i -= sizeof(struct acpi_mcfg_allocation);
 	}
 	if (entries == 0) {
-		pr_err(PREFIX "MMCONFIG has no entries\n");
+		pr_err("MCFG has no entries\n");
 		return -ENODEV;
 	}
 
@@ -640,7 +629,7 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
 
 		if (pci_mmconfig_add(cfg->pci_segment, cfg->start_bus_number,
 				   cfg->end_bus_number, cfg->address) == NULL) {
-			pr_warn(PREFIX "no memory for MCFG entries\n");
+			pr_warn("no memory for MCFG entries\n");
 			free_all_mmcfg();
 			return -ENOMEM;
 		}
@@ -677,7 +666,7 @@ static int pci_mmcfg_for_each_region(int (*func)(__u64 start, __u64 size,
 
 static void __init __pci_mmcfg_init(int early)
 {
-	pr_debug(PREFIX "%s(%s)\n", __func__, early ? "early" : "late");
+	pr_debug("%s(%s)\n", __func__, early ? "early" : "late");
 
 	pci_mmcfg_reject_broken(early);
 	if (list_empty(&pci_mmcfg_list))
@@ -705,7 +694,7 @@ static int __initdata known_bridge;
 
 void __init pci_mmcfg_early_init(void)
 {
-	pr_debug(PREFIX "%s() pci_probe %#x\n", __func__, pci_probe);
+	pr_debug("%s() pci_probe %#x\n", __func__, pci_probe);
 
 	if (pci_probe & PCI_PROBE_MMCONF) {
 		if (pci_mmcfg_check_hostbridge())
@@ -720,16 +709,16 @@ void __init pci_mmcfg_early_init(void)
 
 void __init pci_mmcfg_late_init(void)
 {
-	pr_debug(PREFIX "%s() pci_probe %#x\n", __func__, pci_probe);
+	pr_debug("%s() pci_probe %#x\n", __func__, pci_probe);
 
-	/* MMCONFIG disabled */
+	/* ECAM disabled */
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
 		return;
 
 	if (known_bridge)
 		return;
 
-	/* MMCONFIG hasn't been enabled yet, try again */
+	/* ECAM hasn't been enabled yet, try again */
 	if (pci_probe & PCI_PROBE_MASK & ~PCI_PROBE_MMCONF) {
 		acpi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
 		__pci_mmcfg_init(0);
@@ -742,9 +731,9 @@ static int __init pci_mmcfg_late_insert_resources(void)
 
 	pci_mmcfg_running_state = true;
 
-	pr_debug(PREFIX "%s() pci_probe %#x\n", __func__, pci_probe);
+	pr_debug("%s() pci_probe %#x\n", __func__, pci_probe);
 
-	/* If we are not using MMCONFIG, don't insert the resources. */
+	/* If we are not using ECAM, don't insert the resources. */
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
 		return 1;
 
@@ -755,7 +744,7 @@ static int __init pci_mmcfg_late_insert_resources(void)
 	 */
 	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
 		if (!cfg->res.parent) {
-			pr_debug(PREFIX "%s() insert %pR\n", __func__, &cfg->res);
+			pr_debug("%s() insert %pR\n", __func__, &cfg->res);
 			insert_resource(&iomem_resource, &cfg->res);
 		}
 	}
@@ -764,13 +753,13 @@ static int __init pci_mmcfg_late_insert_resources(void)
 }
 
 /*
- * Perform MMCONFIG resource insertion after PCI initialization to allow for
+ * Perform ECAM resource insertion after PCI initialization to allow for
  * misprogrammed MCFG tables that state larger sizes but actually conflict
  * with other system resources.
  */
 late_initcall(pci_mmcfg_late_insert_resources);
 
-/* Add MMCFG information for host bridges */
+/* Add ECAM information for host bridges */
 int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 			phys_addr_t addr)
 {
@@ -790,11 +779,9 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 	cfg = pci_mmconfig_lookup(seg, start);
 	if (cfg) {
 		if (cfg->end_bus < end)
-			dev_info(dev, FW_INFO
-				 "MMCONFIG for "
-				 "domain %04x [bus %02x-%02x] "
-				 "only partially covers this bridge\n",
-				  cfg->segment, cfg->start_bus, cfg->end_bus);
+			dev_info(dev, FW_INFO "ECAM %pR for domain %04x [bus %02x-%02x] only partially covers this bridge\n",
+				 &cfg->res, cfg->segment, cfg->start_bus,
+				 cfg->end_bus);
 		mutex_unlock(&pci_mmcfg_lock);
 		return -EEXIST;
 	}
@@ -807,10 +794,10 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 	rc = -EBUSY;
 	cfg = pci_mmconfig_alloc(seg, start, end, addr);
 	if (cfg == NULL) {
-		dev_warn(dev, "fail to add MMCONFIG (out of memory)\n");
+		dev_warn(dev, "fail to add ECAM (out of memory)\n");
 		rc = -ENOMEM;
 	} else if (!pci_mmcfg_check_reserved(dev, cfg, 0)) {
-		dev_warn(dev, FW_BUG "MMCONFIG %pR isn't reserved\n",
+		dev_warn(dev, FW_BUG "ECAM %pR isn't reserved\n",
 			 &cfg->res);
 	} else {
 		/* Insert resource if it's not in boot stage */
@@ -819,15 +806,13 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 						       &cfg->res);
 
 		if (tmp) {
-			dev_warn(dev,
-				 "MMCONFIG %pR conflicts with "
-				 "%s %pR\n",
+			dev_warn(dev, "ECAM %pR conflicts with %s %pR\n",
 				 &cfg->res, tmp->name, tmp);
 		} else if (pci_mmcfg_arch_map(cfg)) {
-			dev_warn(dev, "fail to map MMCONFIG %pR\n", &cfg->res);
+			dev_warn(dev, "fail to map ECAM %pR\n", &cfg->res);
 		} else {
 			list_add_sorted(cfg);
-			dev_info(dev, "MMCONFIG at %pR (base %#lx)\n",
+			dev_info(dev, "ECAM %pR (base %#lx)\n",
 				 &cfg->res, (unsigned long)addr);
 			cfg = NULL;
 			rc = 0;
@@ -845,7 +830,7 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 	return rc;
 }
 
-/* Delete MMCFG information for host bridges */
+/* Delete ECAM information for host bridges */
 int pci_mmconfig_delete(u16 seg, u8 start, u8 end)
 {
 	struct pci_mmcfg_region *cfg;
diff --git a/arch/x86/pci/mmconfig_32.c b/arch/x86/pci/mmconfig_32.c
index bfa789875322..f9ef97c593cf 100644
--- a/arch/x86/pci/mmconfig_32.c
+++ b/arch/x86/pci/mmconfig_32.c
@@ -131,7 +131,7 @@ const struct pci_raw_ops pci_mmcfg = {
 
 int __init pci_mmcfg_arch_init(void)
 {
-	printk(KERN_INFO "PCI: Using MMCONFIG for extended config space\n");
+	printk(KERN_INFO "PCI: Using ECAM for extended config space\n");
 	raw_pci_ext_ops = &pci_mmcfg;
 	return 1;
 }
diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
index 0c7b6e66c644..dfdeac0a7571 100644
--- a/arch/x86/pci/mmconfig_64.c
+++ b/arch/x86/pci/mmconfig_64.c
@@ -6,6 +6,8 @@
  * space mapped. This allows lockless config space operation.
  */
 
+#define pr_fmt(fmt) "PCI: " fmt
+
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
@@ -14,8 +16,6 @@
 #include <asm/e820/api.h>
 #include <asm/pci_x86.h>
 
-#define PREFIX "PCI: "
-
 static char __iomem *pci_dev_base(unsigned int seg, unsigned int bus, unsigned int devfn)
 {
 	struct pci_mmcfg_region *cfg = pci_mmconfig_lookup(seg, bus);
@@ -138,7 +138,7 @@ int pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg)
 {
 	cfg->virt = mcfg_ioremap(cfg);
 	if (!cfg->virt) {
-		pr_err(PREFIX "can't map MMCONFIG at %pR\n", &cfg->res);
+		pr_err("can't map ECAM at %pR\n", &cfg->res);
 		return -ENOMEM;
 	}
 
-- 
2.34.1


