Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D984097BE
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 17:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344418AbhIMPsl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 11:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344280AbhIMPsh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Sep 2021 11:48:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D95C096555;
        Mon, 13 Sep 2021 08:27:27 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k23so6618115pji.0;
        Mon, 13 Sep 2021 08:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/tK5hxsL9MKG9mZXvZLPwX/0laXRMWVr+vDqTQ0On9o=;
        b=iEd1ch44ADvzc7AnSXEjexg63fNl59NQecaaBa7kfUyi1h02BdQhzwcYN+6iOd8chn
         9dgRf9MHYUvc1s484FH+SSqSqKZatgQwWf3Jgc5oJZfA1F2BQxXc+JO7zNWD0cirggxM
         Y5R1LvVJZPZGdeRXa1ClwM7Lh4A7NyYB8I3JEfXmZncIz1RBrq2A/t/0ASSRuqrEEunJ
         42rYEjeaUuaP962e1+M0wknqwHkctOePV8yJdk2alrbwl0hjNQ0WKJOI0AJY9C8nuhPS
         4dUqYTpZ4mN0Ig2t4FTU8pqRo+S8DzrzU6z0lF1SDUiigSVIOxr+zo0PvVc/8hBxxGIA
         vt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/tK5hxsL9MKG9mZXvZLPwX/0laXRMWVr+vDqTQ0On9o=;
        b=tbfgF2vluTTTOQ+JtAiRm4KoaF8SX/e8My7uykZ+c+caJ/JOqj0syXHneVIPoUkXN2
         khIFc2YzbBH44W7R2Um1++U3/kE7N31pg3U+7oGHIggDvSVN1ddtIQ2ZrmPe+Q0WEa4g
         6JBoKvS8FEiITX84ED463XBPY4YIbPjiEaI+t1v2t8f62OAg8o5ANjCR7yM2TGOr1M8g
         Me25zQXwTcEJfqV1uyNKKZYWnoDzOTeYwa6uNARrHevE2/PiqkPAIALTzTCSEpn7dCjf
         nUsp9uOn6v0KxEe2K1RsYBc/Ga+kwKKgb2Mes+4UOhaqbzCk7ioc6W/0fR1Fr3C5rlu7
         evcg==
X-Gm-Message-State: AOAM5326nXXKcj0uHaWtQJQuO3LlMa/N4yh2oeDuJ+EuBRitmTM9LDL1
        5WQf02HdHbpaRnPl8lMh04o=
X-Google-Smtp-Source: ABdhPJxKLqjOhkuORNZ3Up/yYXp3q7+GN3+gwvIWOUw2ecMs6Sg+9n/SUtp6aa6IAYZEAQhfuXcoRQ==
X-Received: by 2002:a17:90b:3b84:: with SMTP id pc4mr54776pjb.220.1631546846505;
        Mon, 13 Sep 2021 08:27:26 -0700 (PDT)
Received: from localhost.localdomain (14-200-52-220.static.tpgi.com.au. [14.200.52.220])
        by smtp.gmail.com with ESMTPSA id k127sm7597875pfd.1.2021.09.13.08.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 08:27:26 -0700 (PDT)
From:   Oliver O'Halloran <oohall@gmail.com>
To:     Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Oliver O'Halloran <oohall@gmail.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH] pci: Rename pcibios_add_device to match
Date:   Tue, 14 Sep 2021 01:27:08 +1000
Message-Id: <20210913152709.48013-1-oohall@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The general convention for pcibios_* hooks is that they're named after
the corresponding pci_* function they provide a hook for. The exception
is pcibios_add_device() which provides a hook for pci_device_add(). This
has been irritating me for years so rename it.

Also, remove the export of the microblaze version. The only caller
must be compiled as a built-in so there's no reason for the export.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/microblaze/pci/pci-common.c           | 3 +--
 arch/powerpc/kernel/pci-common.c           | 2 +-
 arch/powerpc/platforms/powernv/pci-sriov.c | 2 +-
 arch/s390/pci/pci.c                        | 2 +-
 arch/sparc/kernel/pci.c                    | 2 +-
 arch/x86/pci/common.c                      | 2 +-
 drivers/pci/pci.c                          | 4 ++--
 drivers/pci/probe.c                        | 4 ++--
 include/linux/pci.h                        | 2 +-
 9 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 557585f1be41..622a4867f9e9 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -587,13 +587,12 @@ static void pcibios_fixup_resources(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pcibios_fixup_resources);
 
-int pcibios_add_device(struct pci_dev *dev)
+int pcibios_device_add(struct pci_dev *dev)
 {
 	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
 
 	return 0;
 }
-EXPORT_SYMBOL(pcibios_add_device);
 
 /*
  * Reparent resource children of pr that conflict with res
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index c3573430919d..6749905932f4 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1059,7 +1059,7 @@ void pcibios_bus_add_device(struct pci_dev *dev)
 		ppc_md.pcibios_bus_add_device(dev);
 }
 
-int pcibios_add_device(struct pci_dev *dev)
+int pcibios_device_add(struct pci_dev *dev)
 {
 	struct irq_domain *d;
 
diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
index 28aac933a439..486c2937b159 100644
--- a/arch/powerpc/platforms/powernv/pci-sriov.c
+++ b/arch/powerpc/platforms/powernv/pci-sriov.c
@@ -54,7 +54,7 @@
  * to "new_size", calculated above. Implementing this is a convoluted process
  * which requires several hooks in the PCI core:
  *
- * 1. In pcibios_add_device() we call pnv_pci_ioda_fixup_iov().
+ * 1. In pcibios_device_add() we call pnv_pci_ioda_fixup_iov().
  *
  *    At this point the device has been probed and the device's BARs are sized,
  *    but no resource allocations have been done. The SR-IOV BARs are sized
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index e7e6788d75a8..ded3321b7208 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -561,7 +561,7 @@ static void zpci_cleanup_bus_resources(struct zpci_dev *zdev)
 	zdev->has_resources = 0;
 }
 
-int pcibios_add_device(struct pci_dev *pdev)
+int pcibios_device_add(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
 	struct resource *res;
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 9c2b720bfd20..31b0c1983286 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -1010,7 +1010,7 @@ void pcibios_set_master(struct pci_dev *dev)
 }
 
 #ifdef CONFIG_PCI_IOV
-int pcibios_add_device(struct pci_dev *dev)
+int pcibios_device_add(struct pci_dev *dev)
 {
 	struct pci_dev *pdev;
 
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 3507f456fcd0..9e1e6b8d8876 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -632,7 +632,7 @@ static void set_dev_domain_options(struct pci_dev *pdev)
 		pdev->hotplug_user_indicators = 1;
 }
 
-int pcibios_add_device(struct pci_dev *dev)
+int pcibios_device_add(struct pci_dev *dev)
 {
 	struct pci_setup_rom *rom;
 	struct irq_domain *msidom;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce2ab62b64cf..c63598c1cdd8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2091,14 +2091,14 @@ void pcim_pin_device(struct pci_dev *pdev)
 EXPORT_SYMBOL(pcim_pin_device);
 
 /*
- * pcibios_add_device - provide arch specific hooks when adding device dev
+ * pcibios_device_add - provide arch specific hooks when adding device dev
  * @dev: the PCI device being added
  *
  * Permits the platform to provide architecture specific functionality when
  * devices are added. This is the default implementation. Architecture
  * implementations can override this.
  */
-int __weak pcibios_add_device(struct pci_dev *dev)
+int __weak pcibios_device_add(struct pci_dev *dev)
 {
 	return 0;
 }
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d9fc02a71baa..2ba43b6adf31 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2450,7 +2450,7 @@ static struct irq_domain *pci_dev_msi_domain(struct pci_dev *dev)
 	struct irq_domain *d;
 
 	/*
-	 * If a domain has been set through the pcibios_add_device()
+	 * If a domain has been set through the pcibios_device_add()
 	 * callback, then this is the one (platform code knows best).
 	 */
 	d = dev_get_msi_domain(&dev->dev);
@@ -2518,7 +2518,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	list_add_tail(&dev->bus_list, &bus->devices);
 	up_write(&pci_bus_sem);
 
-	ret = pcibios_add_device(dev);
+	ret = pcibios_device_add(dev);
 	WARN_ON(ret < 0);
 
 	/* Set up MSI IRQ domain */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cd8aa6fce204..7e0ce3a4d5a1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2126,7 +2126,7 @@ void pcibios_disable_device(struct pci_dev *dev);
 void pcibios_set_master(struct pci_dev *dev);
 int pcibios_set_pcie_reset_state(struct pci_dev *dev,
 				 enum pcie_reset_state state);
-int pcibios_add_device(struct pci_dev *dev);
+int pcibios_device_add(struct pci_dev *dev);
 void pcibios_release_device(struct pci_dev *dev);
 #ifdef CONFIG_PCI
 void pcibios_penalize_isa_irq(int irq, int active);
-- 
2.31.1

