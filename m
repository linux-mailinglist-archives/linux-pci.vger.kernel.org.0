Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C71456DE6
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 12:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbhKSLD0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 06:03:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:65295 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232004AbhKSLDZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 06:03:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="234344450"
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="234344450"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 03:00:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="506410953"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 19 Nov 2021 03:00:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D645A5B2; Fri, 19 Nov 2021 13:00:23 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] x86/quirks: Join string literals back
Date:   Fri, 19 Nov 2021 13:00:17 +0200
Message-Id: <20211119110017.48510-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211119110017.48510-1-andriy.shevchenko@linux.intel.com>
References: <20211119110017.48510-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is no need to split string literals. Moreover, it would be simpler
to grep for an actual code line, when debugging, by using almost any
part of the string literal in question.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/quirks.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index 7280125aed4d..9db1702d493d 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -36,8 +36,7 @@ static void quirk_intel_irqbalance(struct pci_dev *dev)
 	pci_bus_read_config_word(dev->bus, PCI_DEVFN(8, 0), 0x4c, &word);
 
 	if (!(word & (1 << 13))) {
-		dev_info(&dev->dev, "Intel E7520/7320/7525 detected; "
-			"disabling irq balancing and affinity\n");
+		dev_info(&dev->dev, "Intel E7520/7320/7525 detected; disabling irq balancing and affinity\n");
 		noirqdebug_setup("");
 #ifdef CONFIG_PROC_FS
 		no_irq_affinity = 1;
@@ -110,16 +109,14 @@ static void ich_force_enable_hpet(struct pci_dev *dev)
 	pci_read_config_dword(dev, 0xF0, &rcba);
 	rcba &= 0xFFFFC000;
 	if (rcba == 0) {
-		dev_printk(KERN_DEBUG, &dev->dev, "RCBA disabled; "
-			"cannot force enable HPET\n");
+		dev_printk(KERN_DEBUG, &dev->dev, "RCBA disabled; cannot force enable HPET\n");
 		return;
 	}
 
 	/* use bits 31:14, 16 kB aligned */
 	rcba_base = ioremap(rcba, 0x4000);
 	if (rcba_base == NULL) {
-		dev_printk(KERN_DEBUG, &dev->dev, "ioremap failed; "
-			"cannot force enable HPET\n");
+		dev_printk(KERN_DEBUG, &dev->dev, "ioremap failed; cannot force enable HPET\n");
 		return;
 	}
 
@@ -149,8 +146,7 @@ static void ich_force_enable_hpet(struct pci_dev *dev)
 	if (err) {
 		force_hpet_address = 0;
 		iounmap(rcba_base);
-		dev_printk(KERN_DEBUG, &dev->dev,
-			"Failed to force enable HPET\n");
+		dev_printk(KERN_DEBUG, &dev->dev, "Failed to force enable HPET\n");
 	} else {
 		force_hpet_resume_type = ICH_FORCE_HPET_RESUME;
 		hpet_dev_print_force_hpet_address(&dev->dev);
@@ -182,8 +178,7 @@ static struct pci_dev *cached_dev;
 
 static void hpet_print_force_info(void)
 {
-	printk(KERN_INFO "HPET not enabled in BIOS. "
-	       "You might try hpet=force boot option\n");
+	printk(KERN_INFO "HPET not enabled in BIOS. You might try hpet=force boot option\n");
 }
 
 static void old_ich_force_hpet_resume(void)
-- 
2.33.0

