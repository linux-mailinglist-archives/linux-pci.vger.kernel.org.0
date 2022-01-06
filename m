Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493DC485D43
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 01:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343874AbiAFAhF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 19:37:05 -0500
Received: from mga12.intel.com ([192.55.52.136]:60126 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343912AbiAFAga (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Jan 2022 19:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641429389; x=1672965389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vsB+UUSbYGE6IGGmS+OVTpmDI/KXeHawvh+BYKKC8JE=;
  b=NZqn8R0fX2X6cXw8U14Walz+1jlRgZ/3WtpwZts31y77LbSEr24Amiph
   62AewOMP0AIHooqAM1OjMJn/VSS+W8t4CYyTUhKttG3Y2xYcDMz4WH963
   BnisiAzbtm932szEfSg8a1CA25+SFDnK/K5Z0SMWQqHPdrRXjN9OWI/tZ
   LRPmsRobbUR+/dzoH5wFt2hBt86c2X5s8r9I1JOMs1vVfkITu5cth0N+s
   w7IrDrerxZoWKDEAa+QrIuDQj63OT+OAIPKWAtKg67X/6evcjS8z19ttl
   BktF8iKcSKtZ+AE+FRK9tg/HPTKh9i/tUSh1a/iGg1sgzGFcmJtfw7B7e
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="222558161"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="222558161"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 16:36:28 -0800
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="526766009"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 16:36:27 -0800
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
Subject: [PATCH v2 1/2] x86/quirks: Fix logic to apply quirk once
Date:   Wed,  5 Jan 2022 16:36:53 -0800
Message-Id: <20220106003654.770316-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When using QFLAG_APPLY_ONCE we make sure the quirk is called only once.
This is useful when it's enough one device to trigger a certain
condition or when the resource in each that applies is global to the
system rather than local to the device.

However we call the quirk handler based on vendor, class, and device,
allowing the specific handler to do additional filtering. In that case
check_dev_quirk() may incorrectly mark the quirk as applied when it's
not: the quirk was called, but may not have been applied due to the
additional filter.

This is particularly bad for intel_graphics_quirks() that uses
PCI_ANY_ID and then compares with a long list of devices. This hasn't
been problematic so far because those devices are integrated GPUs and
there can only be one in the system.  However as Intel starts to
release discrete cards, this condition is no longer true and we fail to
reserve the stolen memory (for the integrated GPU) depending on the bus
topology: if the traversal finds the discrete card first, for which
there is no system stolen memory, we will fail to reserve it for the
integrated card.

This fixes the stolen memory reservation for an Alderlake-P system with
one additional Intel discrete GPU (DG2 in this case, but applies for
any of them). In this system we have:

	- 00:01.0 Bridge
	  `- 03:00.0 DG2
	- 00:02.0 Alderlake-P's integrated GPU

Since we do a depth-first traversal, when we call the handler because of
DG2 we were marking it as already being applied and never reserving the
stolen memory for Alderlake-P.

Since there are just a few quirks using the QFLAG_APPLY_ONCE logic and
that is even the only flag, just use a static local variable in the
quirk function itself. This allows to mark the quirk as applied only
when it really is. As pointed out by Bjorn Helgaas, this is also more in
line with the PCI fixups as done by pci_do_fixups().

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---

v2: instead of changing all quirks to return if it was successfully
applied, remove the flag infra and use a static local variable to mark
quirks already applied (suggested by Bjorn Helgaas).

 arch/x86/kernel/early-quirks.c | 60 ++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 391a4e2b8604..102ecd0a910e 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -57,12 +57,18 @@ static void __init fix_hypertransport_config(int num, int slot, int func)
 static void __init via_bugs(int  num, int slot, int func)
 {
 #ifdef CONFIG_GART_IOMMU
+	static bool quirk_applied __initdata;
+
+	if (quirk_applied)
+		return;
+
 	if ((max_pfn > MAX_DMA32_PFN ||  force_iommu) &&
 	    !gart_iommu_aperture_allowed) {
 		printk(KERN_INFO
 		       "Looks like a VIA chipset. Disabling IOMMU."
 		       " Override with iommu=allowed\n");
 		gart_iommu_aperture_disabled = 1;
+		quirk_applied = true;
 	}
 #endif
 }
@@ -81,6 +87,11 @@ static void __init nvidia_bugs(int num, int slot, int func)
 {
 #ifdef CONFIG_ACPI
 #ifdef CONFIG_X86_IO_APIC
+	static bool quirk_applied __initdata;
+
+	if (quirk_applied)
+		return;
+
 	/*
 	 * Only applies to Nvidia root ports (bus 0) and not to
 	 * Nvidia graphics cards with PCI ports on secondary buses.
@@ -105,6 +116,7 @@ static void __init nvidia_bugs(int num, int slot, int func)
 		       "timer override.\n");
 		printk(KERN_INFO "If you got timer trouble "
 			"try acpi_use_timer_override\n");
+		quirk_applied = true;
 	}
 #endif
 #endif
@@ -559,7 +571,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
 struct resource intel_graphics_stolen_res __ro_after_init = DEFINE_RES_MEM(0, 0);
 EXPORT_SYMBOL(intel_graphics_stolen_res);
 
-static void __init
+static bool __init
 intel_graphics_stolen(int num, int slot, int func,
 		      const struct intel_early_ops *early_ops)
 {
@@ -570,7 +582,7 @@ intel_graphics_stolen(int num, int slot, int func,
 	base = early_ops->stolen_base(num, slot, func, size);
 
 	if (!size || !base)
-		return;
+		return false;
 
 	end = base + size - 1;
 
@@ -583,14 +595,20 @@ intel_graphics_stolen(int num, int slot, int func,
 	/* Mark this space as reserved */
 	e820__range_add(base, size, E820_TYPE_RESERVED);
 	e820__update_table(e820_table);
+
+	return true;
 }
 
 static void __init intel_graphics_quirks(int num, int slot, int func)
 {
+	static bool quirk_applied __initdata;
 	const struct intel_early_ops *early_ops;
 	u16 device;
 	int i;
 
+	if (quirk_applied)
+		return;
+
 	device = read_pci_config_16(num, slot, func, PCI_DEVICE_ID);
 
 	for (i = 0; i < ARRAY_SIZE(intel_early_ids); i++) {
@@ -601,7 +619,8 @@ static void __init intel_graphics_quirks(int num, int slot, int func)
 
 		early_ops = (typeof(early_ops))driver_data;
 
-		intel_graphics_stolen(num, slot, func, early_ops);
+		quirk_applied = intel_graphics_stolen(num, slot, func,
+						      early_ops);
 
 		return;
 	}
@@ -673,37 +692,33 @@ static void __init apple_airport_reset(int bus, int slot, int func)
 	early_iounmap(mmio, BCM4331_MMIO_SIZE);
 }
 
-#define QFLAG_APPLY_ONCE 	0x1
-#define QFLAG_APPLIED		0x2
-#define QFLAG_DONE		(QFLAG_APPLY_ONCE|QFLAG_APPLIED)
 struct chipset {
 	u32 vendor;
 	u32 device;
 	u32 class;
 	u32 class_mask;
-	u32 flags;
 	void (*f)(int num, int slot, int func);
 };
 
 static struct chipset early_qrk[] __initdata = {
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
-	  PCI_CLASS_BRIDGE_PCI, PCI_ANY_ID, QFLAG_APPLY_ONCE, nvidia_bugs },
+	  PCI_CLASS_BRIDGE_PCI, PCI_ANY_ID, nvidia_bugs },
 	{ PCI_VENDOR_ID_VIA, PCI_ANY_ID,
-	  PCI_CLASS_BRIDGE_PCI, PCI_ANY_ID, QFLAG_APPLY_ONCE, via_bugs },
+	  PCI_CLASS_BRIDGE_PCI, PCI_ANY_ID, via_bugs },
 	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB,
-	  PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, fix_hypertransport_config },
+	  PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, fix_hypertransport_config },
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS,
-	  PCI_CLASS_SERIAL_SMBUS, PCI_ANY_ID, 0, ati_bugs },
+	  PCI_CLASS_SERIAL_SMBUS, PCI_ANY_ID, ati_bugs },
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS,
-	  PCI_CLASS_SERIAL_SMBUS, PCI_ANY_ID, 0, ati_bugs_contd },
+	  PCI_CLASS_SERIAL_SMBUS, PCI_ANY_ID, ati_bugs_contd },
 	{ PCI_VENDOR_ID_INTEL, 0x3403, PCI_CLASS_BRIDGE_HOST,
-	  PCI_BASE_CLASS_BRIDGE, 0, intel_remapping_check },
+	  PCI_BASE_CLASS_BRIDGE, intel_remapping_check },
 	{ PCI_VENDOR_ID_INTEL, 0x3405, PCI_CLASS_BRIDGE_HOST,
-	  PCI_BASE_CLASS_BRIDGE, 0, intel_remapping_check },
+	  PCI_BASE_CLASS_BRIDGE, intel_remapping_check },
 	{ PCI_VENDOR_ID_INTEL, 0x3406, PCI_CLASS_BRIDGE_HOST,
-	  PCI_BASE_CLASS_BRIDGE, 0, intel_remapping_check },
+	  PCI_BASE_CLASS_BRIDGE, intel_remapping_check },
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA, PCI_ANY_ID,
-	  QFLAG_APPLY_ONCE, intel_graphics_quirks },
+	  intel_graphics_quirks },
 	/*
 	 * HPET on the current version of the Baytrail platform has accuracy
 	 * problems: it will halt in deep idle state - so we disable it.
@@ -713,9 +728,9 @@ static struct chipset early_qrk[] __initdata = {
 	 *    http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/atom-z8000-datasheet-vol-1.pdf
 	 */
 	{ PCI_VENDOR_ID_INTEL, 0x0f00,
-		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
+		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, force_disable_hpet},
 	{ PCI_VENDOR_ID_BROADCOM, 0x4331,
-	  PCI_CLASS_NETWORK_OTHER, PCI_ANY_ID, 0, apple_airport_reset},
+	  PCI_CLASS_NETWORK_OTHER, PCI_ANY_ID, apple_airport_reset},
 	{}
 };
 
@@ -756,12 +771,9 @@ static int __init check_dev_quirk(int num, int slot, int func)
 			((early_qrk[i].device == PCI_ANY_ID) ||
 			(early_qrk[i].device == device)) &&
 			(!((early_qrk[i].class ^ class) &
-			    early_qrk[i].class_mask))) {
-				if ((early_qrk[i].flags &
-				     QFLAG_DONE) != QFLAG_DONE)
-					early_qrk[i].f(num, slot, func);
-				early_qrk[i].flags |= QFLAG_APPLIED;
-			}
+			    early_qrk[i].class_mask)))
+				early_qrk[i].f(num, slot, func);
+
 	}
 
 	type = read_pci_config_byte(num, slot, func,

base-commit: c9e6606c7fe92b50a02ce51dda82586ebdf99b48
-- 
2.34.1

