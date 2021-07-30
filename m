Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D803DC00E
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 22:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhG3Uxq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 16:53:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:12936 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230217AbhG3Uxq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Jul 2021 16:53:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="276943441"
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="276943441"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 13:53:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="582294574"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jul 2021 13:53:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A5EB0D7; Fri, 30 Jul 2021 23:54:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 1/1] x86/PCI: Introduce pcibios_is_irq_managed() helper
Date:   Fri, 30 Jul 2021 23:53:55 +0300
Message-Id: <20210730205355.26504-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The check for irq_managed flag along with non-zero irq is an idiom
for x86 PCI implementation. Introduce helper and switch users over
using it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/pci.h   | 4 ++++
 arch/x86/pci/intel_mid_pci.c | 5 ++---
 arch/x86/pci/irq.c           | 4 ++--
 drivers/acpi/pci_irq.c       | 4 ++--
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index d2c76c8d8cfd..ac25470c9558 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -92,6 +92,10 @@ void pcibios_scan_root(int bus);
 struct irq_routing_table *pcibios_get_irq_routing_table(void);
 int pcibios_set_irq_routing(struct pci_dev *dev, int pin, int irq);
 
+static inline bool pcibios_irq_is_managed(struct pci_dev *dev)
+{
+	return dev->irq_managed && dev->irq > 0;
+}
 
 #define HAVE_PCI_MMAP
 #define arch_can_pci_mmap_wc()	pat_enabled()
diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index f04742caf62b..0da287bcabf5 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -230,7 +230,7 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 	int ret;
 	u8 gsi;
 
-	if (dev->irq_managed && dev->irq > 0)
+	if (pcibios_irq_is_managed(dev))
 		return 0;
 
 	ret = pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &gsi);
@@ -290,8 +290,7 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 
 static void intel_mid_pci_irq_disable(struct pci_dev *dev)
 {
-	if (!mp_should_keep_irq(&dev->dev) && dev->irq_managed &&
-	    dev->irq > 0) {
+	if (pcibios_irq_is_managed(dev) && !mp_should_keep_irq(&dev->dev)) {
 		mp_unmap_irq(dev->irq);
 		dev->irq_managed = 0;
 	}
diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index d3a73f9335e1..ce3927b68f9e 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1210,7 +1210,7 @@ static int pirq_enable_irq(struct pci_dev *dev)
 			struct pci_dev *temp_dev;
 			int irq;
 
-			if (dev->irq_managed && dev->irq > 0)
+			if (pcibios_irq_is_managed(dev))
 				return 0;
 
 			irq = IO_APIC_get_PCI_irq_vector(dev->bus->number,
@@ -1280,7 +1280,7 @@ bool mp_should_keep_irq(struct device *dev)
 static void pirq_disable_irq(struct pci_dev *dev)
 {
 	if (io_apic_assign_pci_irqs && !mp_should_keep_irq(&dev->dev) &&
-	    dev->irq_managed && dev->irq) {
+	    pcibios_irq_is_managed(dev)) {
 		mp_unmap_irq(dev->irq);
 		dev->irq = 0;
 		dev->irq_managed = 0;
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index b63954c36e86..b463bdd2dbb5 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -397,7 +397,7 @@ int __acpi_pci_irq_enable(struct pci_dev *dev, int polarity)
 		return 0;
 	}
 
-	if (dev->irq_managed && dev->irq > 0)
+	if (pcibios_irq_is_managed(dev))
 		return 0;
 
 	entry = acpi_pci_irq_lookup(dev, pin);
@@ -486,7 +486,7 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	u8 pin;
 
 	pin = dev->pin;
-	if (!pin || !dev->irq_managed || dev->irq <= 0)
+	if (!pin || !pcibios_irq_is_managed(dev))
 		return;
 
 	/* Keep IOAPIC pin configuration when suspending */
-- 
2.30.2

