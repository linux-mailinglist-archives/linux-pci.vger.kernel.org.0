Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E06734C330
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 23:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfFSVlp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 17:41:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:10385 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfFSVlp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 17:41:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 14:41:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,394,1557212400"; 
   d="scan'208";a="170683460"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by orsmga002.jf.intel.com with ESMTP; 19 Jun 2019 14:41:44 -0700
From:   Megha Dey <megha.dey@linux.intel.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        megha.dey@intel.com, Megha Dey <megha.dey@linux.intel.com>
Subject: [RFC V1 3/6] x86: Introduce the dynamic teardown function
Date:   Wed, 19 Jun 2019 15:03:41 -0700
Message-Id: <1560981824-3966-4-git-send-email-megha.dey@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560981824-3966-1-git-send-email-megha.dey@linux.intel.com>
References: <1560981824-3966-1-git-send-email-megha.dey@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a preparatory patch to introduce disabling of MSI-X vectors
belonging to a particular group. In this patch, we introduce a x86
specific mechanism to teardown the IRQ vectors belonging to a
particular group.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
---
 arch/x86/include/asm/x86_init.h |  1 +
 arch/x86/kernel/x86_init.c      |  6 ++++++
 drivers/pci/msi.c               | 18 ++++++++++++++++++
 include/linux/msi.h             |  2 ++
 4 files changed, 27 insertions(+)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index b85a7c5..50f26a0 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -283,6 +283,7 @@ struct pci_dev;
 struct x86_msi_ops {
 	int (*setup_msi_irqs)(struct pci_dev *dev, int nvec, int type);
 	void (*teardown_msi_irq)(unsigned int irq);
+	void (*teardown_msi_irqs_grp)(struct pci_dev *dev, int group_id);
 	void (*teardown_msi_irqs)(struct pci_dev *dev);
 	void (*restore_msi_irqs)(struct pci_dev *dev);
 };
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 50a2b49..794e7d4 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -127,6 +127,7 @@ EXPORT_SYMBOL_GPL(x86_platform);
 struct x86_msi_ops x86_msi __ro_after_init = {
 	.setup_msi_irqs		= native_setup_msi_irqs,
 	.teardown_msi_irq	= native_teardown_msi_irq,
+	.teardown_msi_irqs_grp	= default_teardown_msi_irqs_grp,
 	.teardown_msi_irqs	= default_teardown_msi_irqs,
 	.restore_msi_irqs	= default_restore_msi_irqs,
 };
@@ -142,6 +143,11 @@ void arch_teardown_msi_irqs(struct pci_dev *dev)
 	x86_msi.teardown_msi_irqs(dev);
 }
 
+void arch_teardown_msi_irqs_grp(struct pci_dev *dev, int group_id)
+{
+	x86_msi.teardown_msi_irqs_grp(dev, group_id);
+}
+
 void arch_teardown_msi_irq(unsigned int irq)
 {
 	x86_msi.teardown_msi_irq(irq);
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 73ad9bf..fd7fa6e 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -133,6 +133,24 @@ void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
 	return default_teardown_msi_irqs(dev);
 }
 
+void default_teardown_msi_irqs_grp(struct pci_dev *dev, int group_id)
+{
+	int i;
+	struct msi_desc *entry;
+
+	for_each_pci_msi_entry(entry, dev) {
+		if (entry->group_id == group_id && entry->irq) {
+			for (i = 0; i < entry->nvec_used; i++)
+				arch_teardown_msi_irq(entry->irq + i);
+		}
+	}
+}
+
+void __weak arch_teardown_msi_irqs_grp(struct pci_dev *dev, int group_id)
+{
+	return default_teardown_msi_irqs_grp(dev, group_id);
+}
+
 static void default_restore_msi_irq(struct pci_dev *dev, int irq)
 {
 	struct msi_desc *entry;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 91273cd..e61ba24 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -202,9 +202,11 @@ int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc);
 void arch_teardown_msi_irq(unsigned int irq);
 int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
 void arch_teardown_msi_irqs(struct pci_dev *dev);
+void arch_teardown_msi_irqs_grp(struct pci_dev *dev, int group_id);
 void arch_restore_msi_irqs(struct pci_dev *dev);
 
 void default_teardown_msi_irqs(struct pci_dev *dev);
+void default_teardown_msi_irqs_grp(struct pci_dev *dev, int group_id);
 void default_restore_msi_irqs(struct pci_dev *dev);
 
 struct msi_controller {
-- 
2.7.4

