Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E03647991E
	for <lists+linux-pci@lfdr.de>; Sat, 18 Dec 2021 07:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhLRGMp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Dec 2021 01:12:45 -0500
Received: from mga18.intel.com ([134.134.136.126]:2428 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhLRGMp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Dec 2021 01:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639807965; x=1671343965;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+qY29Aa5fpKVWVd758EOdzJdefoXSO5T7h0oK810ga0=;
  b=VVQ/WAb4vSCSoCAv5ylpODrddQtyUGmW5lb+uRblJsUNMqNYGLbYR/zc
   q6+2q+VaCQBzf2HwBcR9QtRbf1P5AJJXJBHbsqMYAghpDygkCeNOswyRF
   qdquTV+k1F98YFEGEPZLSdN4WxKMNc8KJezzU/3b5Z7CffBWqqSN/whQq
   e+cWXA1cG2QUbT4OjiWcWPuB05yAv4usBG5uInyBuuN24KdB5PXm3abh7
   judAxA2A9ds3YqJzdPtDtk4pVu+Z+EjiR4aM7eCUZKsIXE+Ox2vfZlbrT
   07YK82WAJdXyaP4eUnBvUT2Fap8GYNkjKpccR3i7rmYkm96mf8MlTxPRb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="226750539"
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="226750539"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 22:12:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="683639505"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 22:12:44 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Matt Roper <matthew.d.roper@intel.com>
Subject: [PATCH] x86/quirks: Fix logic to apply quirk once
Date:   Fri, 17 Dec 2021 22:13:13 -0800
Message-Id: <20211218061313.100571-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When using QFLAG_APPLY_ONCE we make sure the quirk is applied only once.
This is useful when it's enough one device to trigger a certain
condition or when the resource in each that applies is global to the
system rather than local to the device.

However we call the quirk handler based on vendor, class, and device,
allowing the specific handler to do additional filtering. In that case
check_dev_quirk() may incorrectly mark the quirk as applied when it's
not. This is particularly bad for intel_graphics_quirks() that uses
PCI_ANY_ID and then compares with a long list of devices. This hasn't
been problematic so far because those devices are integrated GPUs and
there can only be one in the system.  However as Intel starts to
release discrete cards, this condition is no longer true and we fail to
reserve the stolen memory (for the integrated gpu) depending on the bus
topology: if the traversal finds the discrete card first, for which
there is no system stolen memory, we will fail to reserve it for the
integrated card.

This fixes the stolen memory reservation for an Alderlake-P system with
one additional DG2. In this system we have:

	- 00:01.0 Bridge
	  `- 03:00.0 DG2
	- Alderklake-P's integrated graphics

Since we do a depth-first traversal, when we call the handler because of
DG2 we were marking it as already being applied and never reserving the
stolen memory for Alderlake-P.

Here we change the quirk fucntions to return bool in case it applied a
quirk so we only flag it as applied when that really happened. This only
makes a difference for quirks using QFLAG_APPLY_ONCE, so all the others
simply returns true in order to avoid unnecessary complication.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 arch/x86/kernel/early-quirks.c | 75 ++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 391a4e2b8604..5d235fe2a07a 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -28,7 +28,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/early_ioremap.h>
 
-static void __init fix_hypertransport_config(int num, int slot, int func)
+static bool __init fix_hypertransport_config(int num, int slot, int func)
 {
 	u32 htcfg;
 	/*
@@ -51,10 +51,10 @@ static void __init fix_hypertransport_config(int num, int slot, int func)
 		}
 	}
 
-
+	return true;
 }
 
-static void __init via_bugs(int  num, int slot, int func)
+static bool __init via_bugs(int  num, int slot, int func)
 {
 #ifdef CONFIG_GART_IOMMU
 	if ((max_pfn > MAX_DMA32_PFN ||  force_iommu) &&
@@ -63,8 +63,12 @@ static void __init via_bugs(int  num, int slot, int func)
 		       "Looks like a VIA chipset. Disabling IOMMU."
 		       " Override with iommu=allowed\n");
 		gart_iommu_aperture_disabled = 1;
+
+		return true;
 	}
 #endif
+
+	return false;
 }
 
 #ifdef CONFIG_ACPI
@@ -77,7 +81,7 @@ static int __init nvidia_hpet_check(struct acpi_table_header *header)
 #endif /* CONFIG_X86_IO_APIC */
 #endif /* CONFIG_ACPI */
 
-static void __init nvidia_bugs(int num, int slot, int func)
+static bool __init nvidia_bugs(int num, int slot, int func)
 {
 #ifdef CONFIG_ACPI
 #ifdef CONFIG_X86_IO_APIC
@@ -86,7 +90,7 @@ static void __init nvidia_bugs(int num, int slot, int func)
 	 * Nvidia graphics cards with PCI ports on secondary buses.
 	 */
 	if (num)
-		return;
+		return false;
 
 	/*
 	 * All timer overrides on Nvidia are
@@ -96,7 +100,7 @@ static void __init nvidia_bugs(int num, int slot, int func)
 	 * at least allow a command line override.
 	 */
 	if (acpi_use_timer_override)
-		return;
+		return false;
 
 	if (acpi_table_parse(ACPI_SIG_HPET, nvidia_hpet_check)) {
 		acpi_skip_timer_override = 1;
@@ -105,11 +109,14 @@ static void __init nvidia_bugs(int num, int slot, int func)
 		       "timer override.\n");
 		printk(KERN_INFO "If you got timer trouble "
 			"try acpi_use_timer_override\n");
+
+		return true;
 	}
 #endif
 #endif
 	/* RED-PEN skip them on mptables too? */
 
+	return false;
 }
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_X86_IO_APIC)
@@ -131,13 +138,13 @@ static u32 __init ati_ixp4x0_rev(int num, int slot, int func)
 	return d;
 }
 
-static void __init ati_bugs(int num, int slot, int func)
+static bool __init ati_bugs(int num, int slot, int func)
 {
 	u32 d;
 	u8  b;
 
 	if (acpi_use_timer_override)
-		return;
+		return true;
 
 	d = ati_ixp4x0_rev(num, slot, func);
 	if (d  < 0x82)
@@ -155,6 +162,8 @@ static void __init ati_bugs(int num, int slot, int func)
 		printk(KERN_INFO "If you got timer trouble "
 		       "try acpi_use_timer_override\n");
 	}
+
+	return true;
 }
 
 static u32 __init ati_sbx00_rev(int num, int slot, int func)
@@ -167,7 +176,7 @@ static u32 __init ati_sbx00_rev(int num, int slot, int func)
 	return d;
 }
 
-static void __init ati_bugs_contd(int num, int slot, int func)
+static bool __init ati_bugs_contd(int num, int slot, int func)
 {
 	u32 d, rev;
 
@@ -181,10 +190,10 @@ static void __init ati_bugs_contd(int num, int slot, int func)
 	 * SB800: revisions 0x40, 0x41, ...
 	 */
 	if (rev >= 0x39)
-		return;
+		return true;
 
 	if (acpi_use_timer_override)
-		return;
+		return true;
 
 	/* check for IRQ0 interrupt swap */
 	d = read_pci_config(num, slot, func, 0x64);
@@ -197,18 +206,22 @@ static void __init ati_bugs_contd(int num, int slot, int func)
 		printk(KERN_INFO "If you got timer trouble "
 		       "try acpi_use_timer_override\n");
 	}
+
+	return true;
 }
 #else
-static void __init ati_bugs(int num, int slot, int func)
+static bool __init ati_bugs(int num, int slot, int func)
 {
+	return true;
 }
 
-static void __init ati_bugs_contd(int num, int slot, int func)
+static bool __init ati_bugs_contd(int num, int slot, int func)
 {
+	return true;
 }
 #endif
 
-static void __init intel_remapping_check(int num, int slot, int func)
+static bool __init intel_remapping_check(int num, int slot, int func)
 {
 	u8 revision;
 	u16 device;
@@ -226,6 +239,8 @@ static void __init intel_remapping_check(int num, int slot, int func)
 		set_irq_remapping_broken();
 	else if (device == 0x3405 && revision == 0x22)
 		set_irq_remapping_broken();
+
+	return true;
 }
 
 /*
@@ -585,7 +600,7 @@ intel_graphics_stolen(int num, int slot, int func,
 	e820__update_table(e820_table);
 }
 
-static void __init intel_graphics_quirks(int num, int slot, int func)
+static bool __init intel_graphics_quirks(int num, int slot, int func)
 {
 	const struct intel_early_ops *early_ops;
 	u16 device;
@@ -603,16 +618,20 @@ static void __init intel_graphics_quirks(int num, int slot, int func)
 
 		intel_graphics_stolen(num, slot, func, early_ops);
 
-		return;
+		return true;
 	}
+
+	return false;
 }
 
-static void __init force_disable_hpet(int num, int slot, int func)
+static bool __init force_disable_hpet(int num, int slot, int func)
 {
 #ifdef CONFIG_HPET_TIMER
 	boot_hpet_disable = true;
 	pr_info("x86/hpet: Will disable the HPET for this platform because it's not reliable\n");
 #endif
+
+	return true;
 }
 
 #define BCM4331_MMIO_SIZE	16384
@@ -620,7 +639,7 @@ static void __init force_disable_hpet(int num, int slot, int func)
 #define bcma_aread32(reg)	ioread32(mmio + 1 * BCMA_CORE_SIZE + reg)
 #define bcma_awrite32(reg, val)	iowrite32(val, mmio + 1 * BCMA_CORE_SIZE + reg)
 
-static void __init apple_airport_reset(int bus, int slot, int func)
+static bool __init apple_airport_reset(int bus, int slot, int func)
 {
 	void __iomem *mmio;
 	u16 pmcsr;
@@ -628,7 +647,7 @@ static void __init apple_airport_reset(int bus, int slot, int func)
 	int i;
 
 	if (!x86_apple_machine)
-		return;
+		return true;
 
 	/* Card may have been put into PCI_D3hot by grub quirk */
 	pmcsr = read_pci_config_16(bus, slot, func, BCM4331_PM_CAP + PCI_PM_CTRL);
@@ -642,7 +661,7 @@ static void __init apple_airport_reset(int bus, int slot, int func)
 		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) != PCI_D0) {
 			pr_err("pci 0000:%02x:%02x.%d: Cannot power up Apple AirPort card\n",
 			       bus, slot, func);
-			return;
+			return true;
 		}
 	}
 
@@ -654,7 +673,7 @@ static void __init apple_airport_reset(int bus, int slot, int func)
 	if (!mmio) {
 		pr_err("pci 0000:%02x:%02x.%d: Cannot iomap Apple AirPort card\n",
 		       bus, slot, func);
-		return;
+		return true;
 	}
 
 	pr_info("Resetting Apple AirPort card (left enabled by EFI)\n");
@@ -671,6 +690,8 @@ static void __init apple_airport_reset(int bus, int slot, int func)
 	udelay(10);
 
 	early_iounmap(mmio, BCM4331_MMIO_SIZE);
+
+	return true;
 }
 
 #define QFLAG_APPLY_ONCE 	0x1
@@ -682,7 +703,7 @@ struct chipset {
 	u32 class;
 	u32 class_mask;
 	u32 flags;
-	void (*f)(int num, int slot, int func);
+	bool (*f)(int num, int slot, int func);
 };
 
 static struct chipset early_qrk[] __initdata = {
@@ -757,11 +778,13 @@ static int __init check_dev_quirk(int num, int slot, int func)
 			(early_qrk[i].device == device)) &&
 			(!((early_qrk[i].class ^ class) &
 			    early_qrk[i].class_mask))) {
-				if ((early_qrk[i].flags &
-				     QFLAG_DONE) != QFLAG_DONE)
-					early_qrk[i].f(num, slot, func);
-				early_qrk[i].flags |= QFLAG_APPLIED;
+			if ((early_qrk[i].flags & QFLAG_DONE) != QFLAG_DONE) {
+				bool applied = early_qrk[i].f(num, slot, func);
+
+				if (applied)
+					early_qrk[i].flags |= QFLAG_APPLIED;
 			}
+		}
 	}
 
 	type = read_pci_config_byte(num, slot, func,
-- 
2.34.1

