Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBBC456DE5
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 12:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhKSLDZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 06:03:25 -0500
Received: from mga06.intel.com ([134.134.136.31]:41442 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232671AbhKSLDZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 06:03:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="295211091"
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="295211091"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 03:00:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="594195811"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 19 Nov 2021 03:00:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C77C2445; Fri, 19 Nov 2021 13:00:23 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] x86/quirks: Introduce hpet_dev_print_force_hpet_address() helper
Date:   Fri, 19 Nov 2021 13:00:16 +0200
Message-Id: <20211119110017.48510-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211119110017.48510-1-andriy.shevchenko@linux.intel.com>
References: <20211119110017.48510-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce hpet_dev_print_force_hpet_address() helper to unify printing
forced HPET address. No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/quirks.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index c4bc0c3a5414..7280125aed4d 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -68,6 +68,11 @@ static enum {
 	ATI_FORCE_HPET_RESUME,
 } force_hpet_resume_type;
 
+static void hpet_dev_print_force_hpet_address(struct device *dev)
+{
+	dev_printk(KERN_DEBUG, dev, "Force enabled HPET at 0x%lx\n", force_hpet_address);
+}
+
 static void __iomem *rcba_base;
 
 static void ich_force_hpet_resume(void)
@@ -125,8 +130,7 @@ static void ich_force_enable_hpet(struct pci_dev *dev)
 		/* HPET is enabled in HPTC. Just not reported by BIOS */
 		val = val & 0x3;
 		force_hpet_address = 0xFED00000 | (val << 12);
-		dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
-			"0x%lx\n", force_hpet_address);
+		hpet_dev_print_force_hpet_address(&dev->dev);
 		iounmap(rcba_base);
 		return;
 	}
@@ -149,8 +153,7 @@ static void ich_force_enable_hpet(struct pci_dev *dev)
 			"Failed to force enable HPET\n");
 	} else {
 		force_hpet_resume_type = ICH_FORCE_HPET_RESUME;
-		dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
-			"0x%lx\n", force_hpet_address);
+		hpet_dev_print_force_hpet_address(&dev->dev);
 	}
 }
 
@@ -223,8 +226,7 @@ static void old_ich_force_enable_hpet(struct pci_dev *dev)
 	if (val & 0x4) {
 		val &= 0x3;
 		force_hpet_address = 0xFED00000 | (val << 12);
-		dev_printk(KERN_DEBUG, &dev->dev, "HPET at 0x%lx\n",
-			force_hpet_address);
+		hpet_dev_print_force_hpet_address(&dev->dev);
 		return;
 	}
 
@@ -244,8 +246,7 @@ static void old_ich_force_enable_hpet(struct pci_dev *dev)
 		/* HPET is enabled in HPTC. Just not reported by BIOS */
 		val &= 0x3;
 		force_hpet_address = 0xFED00000 | (val << 12);
-		dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
-			"0x%lx\n", force_hpet_address);
+		hpet_dev_print_force_hpet_address(&dev->dev);
 		cached_dev = dev;
 		force_hpet_resume_type = OLD_ICH_FORCE_HPET_RESUME;
 		return;
@@ -316,8 +317,7 @@ static void vt8237_force_enable_hpet(struct pci_dev *dev)
 	 */
 	if (val & 0x80) {
 		force_hpet_address = (val & ~0x3ff);
-		dev_printk(KERN_DEBUG, &dev->dev, "HPET at 0x%lx\n",
-			force_hpet_address);
+		hpet_dev_print_force_hpet_address(&dev->dev);
 		return;
 	}
 
@@ -331,8 +331,7 @@ static void vt8237_force_enable_hpet(struct pci_dev *dev)
 	pci_read_config_dword(dev, 0x68, &val);
 	if (val & 0x80) {
 		force_hpet_address = (val & ~0x3ff);
-		dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
-			"0x%lx\n", force_hpet_address);
+		hpet_dev_print_force_hpet_address(&dev->dev);
 		cached_dev = dev;
 		force_hpet_resume_type = VT8237_FORCE_HPET_RESUME;
 		return;
@@ -412,8 +411,7 @@ static void ati_force_enable_hpet(struct pci_dev *dev)
 
 	force_hpet_address = val;
 	force_hpet_resume_type = ATI_FORCE_HPET_RESUME;
-	dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at 0x%lx\n",
-		   force_hpet_address);
+	hpet_dev_print_force_hpet_address(&dev->dev);
 	cached_dev = dev;
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS,
@@ -444,8 +442,7 @@ static void nvidia_force_enable_hpet(struct pci_dev *dev)
 	pci_read_config_dword(dev, 0x44, &val);
 	force_hpet_address = val & 0xfffffffe;
 	force_hpet_resume_type = NVIDIA_FORCE_HPET_RESUME;
-	dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at 0x%lx\n",
-		force_hpet_address);
+	hpet_dev_print_force_hpet_address(&dev->dev);
 	cached_dev = dev;
 }
 
@@ -509,8 +506,7 @@ static void e6xx_force_enable_hpet(struct pci_dev *dev)
 
 	force_hpet_address = 0xFED00000;
 	force_hpet_resume_type = NONE_FORCE_HPET_RESUME;
-	dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
-		"0x%lx\n", force_hpet_address);
+	hpet_dev_print_force_hpet_address(&dev->dev);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_E6XX_CU,
 			 e6xx_force_enable_hpet);
-- 
2.33.0

