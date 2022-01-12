Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55B548CF1C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 00:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbiALXaN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 18:30:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:62103 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235421AbiALXaN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jan 2022 18:30:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642030213; x=1673566213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sSugffIJEewYL4C4RcIsI+OeZnQGnZ+wySzXjDvRwNg=;
  b=hGazItonrRWlUVuRDK/Ih0Fg/xlW9D7WAiO9nKWklfGadFYYhLxIuOHc
   CQO+cA0qa9/etCWbCj1QO45/1Y3jTR/jhi1/PDqc/j97L9+lrfFzLL82q
   rPrsewxO2o3FjSDkvvWR+plDNql0lFofvAdYYOnmOGB6VLtErhwSNowYY
   AGuY5dFBI0nfZEFDeXDQHGa01p0vkw+JaT55PW4f8JhIGBSVWUr5p0S82
   neqEOeRDTDoDKdeMWbEBRaO5VXVDh6oeRpp99zKmJkY56GGWStNIfiRCP
   EW1i/9uSr94G5sGTF9HhoqtVzCjM3RcyciNENDRIEb836SlXfrPcsX7D+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307224256"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="307224256"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:30:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="475094956"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:30:12 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH v4] x86/quirks: Replace QFLAG_APPLY_ONCE with static locals
Date:   Wed, 12 Jan 2022 15:30:43 -0800
Message-Id: <20220112233043.1865454-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220108025332.GA443266@bhelgaas>
References: <20220108025332.GA443266@bhelgaas>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The flags are only used to mark a quirk to be called once and nothing
else. Also, that logic may not be appropriate if the quirk wants to
do additional filtering and set quirk as applied by itself.

So replace the uses of QFLAG_APPLY_ONCE with static local variables in
the few quirks that use this logic and remove all the flags logic.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
---

v4: Fix typo in commit message

 arch/x86/kernel/early-quirks.c | 55 +++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 1ca3a56fdc2d..bab2a255b701 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -57,6 +57,13 @@ static void __init fix_hypertransport_config(int num, int slot, int func)
 static void __init via_bugs(int  num, int slot, int func)
 {
 #ifdef CONFIG_GART_IOMMU
+	static bool quirk_applied __initdata;
+
+	if (quirk_applied)
+		return;
+
+	quirk_applied = true;
+
 	if ((max_pfn > MAX_DMA32_PFN ||  force_iommu) &&
 	    !gart_iommu_aperture_allowed) {
 		printk(KERN_INFO
@@ -81,6 +88,13 @@ static void __init nvidia_bugs(int num, int slot, int func)
 {
 #ifdef CONFIG_ACPI
 #ifdef CONFIG_X86_IO_APIC
+	static bool quirk_applied __initdata;
+
+	if (quirk_applied)
+		return;
+
+	quirk_applied = true;
+
 	/*
 	 * Only applies to Nvidia root ports (bus 0) and not to
 	 * Nvidia graphics cards with PCI ports on secondary buses.
@@ -589,10 +603,16 @@ intel_graphics_stolen(int num, int slot, int func,
 
 static void __init intel_graphics_quirks(int num, int slot, int func)
 {
+	static bool quirk_applied __initdata;
 	const struct intel_early_ops *early_ops;
 	u16 device;
 	int i;
 
+	if (quirk_applied)
+		return;
+
+	quirk_applied = true;
+
 	device = read_pci_config_16(num, slot, func, PCI_DEVICE_ID);
 
 	for (i = 0; i < ARRAY_SIZE(intel_early_ids); i++) {
@@ -675,37 +695,33 @@ static void __init apple_airport_reset(int bus, int slot, int func)
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
@@ -715,9 +731,9 @@ static struct chipset early_qrk[] __initdata = {
 	 *    http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/atom-z8000-datasheet-vol-1.pdf
 	 */
 	{ PCI_VENDOR_ID_INTEL, 0x0f00,
-		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
+	  PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, force_disable_hpet},
 	{ PCI_VENDOR_ID_BROADCOM, 0x4331,
-	  PCI_CLASS_NETWORK_OTHER, PCI_ANY_ID, 0, apple_airport_reset},
+	  PCI_CLASS_NETWORK_OTHER, PCI_ANY_ID, apple_airport_reset},
 	{}
 };
 
@@ -758,12 +774,9 @@ static int __init check_dev_quirk(int num, int slot, int func)
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
-- 
2.34.1

