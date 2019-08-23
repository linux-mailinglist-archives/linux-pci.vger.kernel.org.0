Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC959A4FC
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2019 03:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbfHWBgW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 21:36:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33631 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfHWBgW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Aug 2019 21:36:22 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0yUw-0000aO-4J; Fri, 23 Aug 2019 03:36:14 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B30F01C07E4;
        Fri, 23 Aug 2019 03:36:13 +0200 (CEST)
Date:   Fri, 23 Aug 2019 01:36:09 -0000
From:   tip-bot2 for Krzysztof Wilczynski <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/PCI: Remove superfluous returns from void
 functions
Cc:     linux-kernel@vger.kernel.org, x86-ml <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-pci@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Krzysztof Wilczynski <kw@linux.com>
In-Reply-To: <20190820065121.16594-1-kw@linux.com>
References: <20190820065121.16594-1-kw@linux.com>
MIME-Version: 1.0
Message-ID: <156652416971.10313.4179486361278391653.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     f25896ebfe0cf818ebd1adb5e6a05dc40b820e45
Gitweb:        https://git.kernel.org/tip/f25896ebfe0cf818ebd1adb5e6a05dc40b820e45
Author:        Krzysztof Wilczynski <kw@linux.com>
AuthorDate:    Tue, 20 Aug 2019 08:51:21 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 20 Aug 2019 09:54:36 +02:00

x86/PCI: Remove superfluous returns from void functions

Remove unnecessary empty return statements at the end of void functions
in arch/x86/kernel/quirks.c.

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-pci@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190820065121.16594-1-kw@linux.com
---
 arch/x86/kernel/quirks.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index 8451f38..1daf8f2 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -90,8 +90,6 @@ static void ich_force_hpet_resume(void)
 		BUG();
 	else
 		printk(KERN_DEBUG "Force enabled HPET at resume\n");
-
-	return;
 }
 
 static void ich_force_enable_hpet(struct pci_dev *dev)
@@ -448,7 +446,6 @@ static void nvidia_force_enable_hpet(struct pci_dev *dev)
 	dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at 0x%lx\n",
 		force_hpet_address);
 	cached_dev = dev;
-	return;
 }
 
 /* ISA Bridges */
@@ -513,7 +510,6 @@ static void e6xx_force_enable_hpet(struct pci_dev *dev)
 	force_hpet_resume_type = NONE_FORCE_HPET_RESUME;
 	dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
 		"0x%lx\n", force_hpet_address);
-	return;
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_E6XX_CU,
 			 e6xx_force_enable_hpet);
