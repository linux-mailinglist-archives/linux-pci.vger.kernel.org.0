Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465AE2B9A83
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 19:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgKSSTR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 13:19:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbgKSSTR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 13:19:17 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D297F22248;
        Thu, 19 Nov 2020 18:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605809956;
        bh=pdN07KfFepAiIg0a4V4k+BFudMXTpaC64OLF7rj1IYU=;
        h=From:To:Cc:Subject:Date:From;
        b=bSy7fAIDgF+/P5DMTXrkR8NZOdkOphMtAYFCcJjUVdoPghWjkOU+w9K+6mvNcaoFH
         GVm3F3SX2dipFo1YVUCG7UBLsTFT1Mys9FZlAF6d/Hoj6q3CoIwLYF1nZw6KaLn9wj
         djmiD2FJFrVOXQv+XGoyYwNzMoY8rD1ABC3dTpZ0=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] x86/PCI: Convert force_disable_hpet() to standard quirk
Date:   Thu, 19 Nov 2020 12:19:04 -0600
Message-Id: <20201119181904.149129-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

62187910b0fc ("x86/intel: Add quirk to disable HPET for the Baytrail
platform") implemented force_disable_hpet() as a special early quirk.
These run before the PCI core is initialized and depend on the
x86/pci/early.c accessors that use I/O ports 0xcf8 and 0xcfc.

But force_disable_hpet() doesn't need to be one of these special early
quirks.  It merely sets "boot_hpet_disable", which is tested by
is_hpet_capable(), which is only used by hpet_enable() and hpet_disable().
hpet_enable() is an fs_initcall(), so it runs after the PCI core is
initialized.

Convert force_disable_hpet() to the standard PCI quirk mechanism.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 arch/x86/kernel/early-quirks.c | 24 ------------------------
 arch/x86/pci/fixup.c           | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index a4b5af03dcc1..674967fc1071 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -604,14 +604,6 @@ static void __init intel_graphics_quirks(int num, int slot, int func)
 	}
 }
 
-static void __init force_disable_hpet(int num, int slot, int func)
-{
-#ifdef CONFIG_HPET_TIMER
-	boot_hpet_disable = true;
-	pr_info("x86/hpet: Will disable the HPET for this platform because it's not reliable\n");
-#endif
-}
-
 #define BCM4331_MMIO_SIZE	16384
 #define BCM4331_PM_CAP		0x40
 #define bcma_aread32(reg)	ioread32(mmio + 1 * BCMA_CORE_SIZE + reg)
@@ -701,22 +693,6 @@ static struct chipset early_qrk[] __initdata = {
 	  PCI_BASE_CLASS_BRIDGE, 0, intel_remapping_check },
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA, PCI_ANY_ID,
 	  QFLAG_APPLY_ONCE, intel_graphics_quirks },
-	/*
-	 * HPET on the current version of the Baytrail platform has accuracy
-	 * problems: it will halt in deep idle state - so we disable it.
-	 *
-	 * More details can be found in section 18.10.1.3 of the datasheet:
-	 *
-	 *    http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/atom-z8000-datasheet-vol-1.pdf
-	 */
-	{ PCI_VENDOR_ID_INTEL, 0x0f00,
-		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
-	{ PCI_VENDOR_ID_INTEL, 0x3e20,
-		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
-	{ PCI_VENDOR_ID_INTEL, 0x3ec4,
-		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
-	{ PCI_VENDOR_ID_INTEL, 0x8a12,
-		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
 	{ PCI_VENDOR_ID_BROADCOM, 0x4331,
 	  PCI_CLASS_NETWORK_OTHER, PCI_ANY_ID, 0, apple_airport_reset},
 	{}
diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 0a0e168be1cb..865bc3c5188b 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -780,3 +780,28 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x15b1, pci_amd_enable_64bit_bar);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1601, pci_amd_enable_64bit_bar);
 
 #endif
+
+/*
+ * HPET on the current version of the Baytrail platform has accuracy
+ * problems: it will halt in deep idle state - so we disable it.
+ *
+ * More details can be found in section 18.10.1.3 of the datasheet
+ * (Intel Document Number 332065-003, March 2016):
+ *
+ *    http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/atom-z8000-datasheet-vol-1.pdf
+ */
+static void force_disable_hpet(struct pci_dev *dev)
+{
+#ifdef CONFIG_HPET_TIMER
+	boot_hpet_disable = true;
+	pci_info(dev, "x86/hpet: Will disable the HPET for this platform because it's not reliable\n");
+#endif
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_INTEL, 0x0f00,
+			      PCI_CLASS_BRIDGE_HOST, 8, force_disable_hpet);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_INTEL, 0x3e20,
+			      PCI_CLASS_BRIDGE_HOST, 8, force_disable_hpet);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_INTEL, 0x3ec4,
+			      PCI_CLASS_BRIDGE_HOST, 8, force_disable_hpet);
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_INTEL, 0x8a12,
+			      PCI_CLASS_BRIDGE_HOST, 8, force_disable_hpet);
-- 
2.25.1

