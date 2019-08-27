Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D00C9E4FD
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 11:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfH0J40 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 05:56:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33289 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfH0J40 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 05:56:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so18150179wrr.0;
        Tue, 27 Aug 2019 02:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OiTD+C0jKmBXLHpY3VxZvB1F+ChWta1qB/CxkBMhNkY=;
        b=KHHzIlhlrei4kgkQpJgwcvxAE2lvUNDbzTRg0UctPEZu1zDp5FKnsDtBBm/xOebDnY
         M70svbqMMtavSuc3/H31VBfXV/ZBMD+mU5Xmas4sTfYrR/ry7/mlmOTlkP9sMa2HKILw
         x83vfoxLjbDWfPEyo2FHEs1M1XVVIdYr156/H8sYw10kCparHt703mrs3dKZBCj4pMGV
         4ITkgZmuUY3Q/inUWcFqYq9rMy4UXm/7TBdB7ycIu3uehDbWrFT0Ppkmb44WvP+cYl7L
         VrglzMQWXqdMHlklytaTSz6WJ35EyeMtoF8ZFcECPmdHbn3gI3bMF6P03p37RKsD3EFr
         6L3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=OiTD+C0jKmBXLHpY3VxZvB1F+ChWta1qB/CxkBMhNkY=;
        b=RpmGdA6ABDyoSoXYvfkLM9bQU3HPTRn3Sg8VJVLNk3x8Xe9uMdLdD2sO5vHGvMnnSu
         DK5twrbODkxckdDRU3pc7qatxRs9j0FCtl1E9CoG6ZNSefu7wIhvjTqZp5h6znrKRMs9
         6EFj+RhvM0XceLSpP1boxSUnICcGutMJQ/7QgRNMym8jMyY9QIfFovpW4pPvcxtZ6nOv
         UNaVg0qCqd2mXwkwAbV04+Ixl6vZSI4zAnynG3RnESPYKwjOOJsI2QRivAJJcP+CPOR8
         kss1W7d7ngRaz0QCW/zAeXpy1r1EwfcTfy0FK1W/NLl+1otSeKyuk2+SnwkXOArO7Ha9
         MAxg==
X-Gm-Message-State: APjAAAUDzuNWW27mmVeLkxf+1bFft4wD7r/k73H3ADBVy3l4JfipQez7
        6hJbDVhpT3SiPd/sNOmiclo=
X-Google-Smtp-Source: APXvYqwIEeQo0gHLA94adXJnQ1AUpN6TWQpVTentcQdM01vpoobXFJXNXZK/mc59hq8WkLoHQOYyrA==
X-Received: by 2002:a5d:4950:: with SMTP id r16mr27576584wrs.347.1566899781916;
        Tue, 27 Aug 2019 02:56:21 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id v12sm15713723wrr.87.2019.08.27.02.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 02:56:21 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Move PCI Express ASPM function prototypes and definitions to pci.h
Date:   Tue, 27 Aug 2019 11:56:20 +0200
Message-Id: <20190827095620.11213-1-kw@linux.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Merge PCI Express ASPM function prototypes and definitions
from include/linux/pci-aspm.h into include/linux/pci.h.

Function prototypes to move are pci_disable_link_state(),
pci_disable_link_state_locked(), pcie_no_aspm() and
pcie_aspm_support_enabled(), and definitions to move
are PCIE_LINK_STATE_L0S, PCIE_LINK_STATE_L1 and
PCIE_LINK_STATE_CLKPM.

There are no functional changes.

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 drivers/acpi/pci_root.c                       |  1 -
 drivers/char/xillybus/xillybus_pcie.c         |  1 -
 drivers/net/ethernet/intel/e1000e/e1000.h     |  1 -
 drivers/net/ethernet/jme.c                    |  1 -
 drivers/net/ethernet/realtek/r8169_main.c     |  1 -
 drivers/net/wireless/ath/ath5k/pci.c          |  1 -
 .../net/wireless/intel/iwlegacy/3945-mac.c    |  1 -
 .../net/wireless/intel/iwlegacy/4965-mac.c    |  1 -
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  1 -
 drivers/pci/pci-acpi.c                        |  1 -
 drivers/pci/pcie/aspm.c                       |  1 -
 drivers/pci/quirks.c                          |  1 -
 drivers/scsi/aacraid/linit.c                  |  1 -
 drivers/scsi/hpsa.c                           |  1 -
 drivers/scsi/mpt3sas/mpt3sas_scsih.c          |  1 -
 include/linux/pci-aspm.h                      | 36 -------------------
 include/linux/pci.h                           | 18 ++++++++++
 17 files changed, 18 insertions(+), 51 deletions(-)
 delete mode 100644 include/linux/pci-aspm.h

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 314a187ed572..d1e666ef3fcc 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -15,7 +15,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
-#include <linux/pci-aspm.h>
 #include <linux/dmar.h>
 #include <linux/acpi.h>
 #include <linux/slab.h>
diff --git a/drivers/char/xillybus/xillybus_pcie.c b/drivers/char/xillybus/xillybus_pcie.c
index 02c15952b103..18b0c392bc93 100644
--- a/drivers/char/xillybus/xillybus_pcie.c
+++ b/drivers/char/xillybus/xillybus_pcie.c
@@ -9,7 +9,6 @@
 
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/slab.h>
 #include "xillybus.h"
 
diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index 34cd67951aec..6c51b1bad8c4 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -13,7 +13,6 @@
 #include <linux/io.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/crc32.h>
 #include <linux/if_vlan.h>
 #include <linux/timecounter.h>
diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index 0b668357db4d..57e8aea98969 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index e1dd6ea60d67..a8f373e49505 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -28,7 +28,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
 #include <linux/prefetch.h>
-#include <linux/pci-aspm.h>
 #include <linux/ipv6.h>
 #include <net/ip6_checksum.h>
 
diff --git a/drivers/net/wireless/ath/ath5k/pci.c b/drivers/net/wireless/ath/ath5k/pci.c
index c6156cc38940..d5ee32ce9eb3 100644
--- a/drivers/net/wireless/ath/ath5k/pci.c
+++ b/drivers/net/wireless/ath/ath5k/pci.c
@@ -18,7 +18,6 @@
 
 #include <linux/nl80211.h>
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/etherdevice.h>
 #include <linux/module.h>
 #include "../ath.h"
diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index b82da75a9ae3..4fbcc7fba3cc 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -18,7 +18,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index fa2c02881939..ffb705b18fb1 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -18,7 +18,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index f5df5b370d78..4c308e33ee21 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -62,7 +62,6 @@
  *
  *****************************************************************************/
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/interrupt.h>
 #include <linux/debugfs.h>
 #include <linux/sched.h>
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 45049f558860..dd520fe927db 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -14,7 +14,6 @@
 #include <linux/msi.h>
 #include <linux/pci_hotplug.h>
 #include <linux/module.h>
-#include <linux/pci-aspm.h>
 #include <linux/pci-acpi.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index e44af7f4d37f..ad6259ec51a6 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -18,7 +18,6 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/delay.h>
-#include <linux/pci-aspm.h>
 #include "../pci.h"
 
 #ifdef MODULE_PARAM_PREFIX
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 208aacf39329..9ac1a7564c9e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -20,7 +20,6 @@
 #include <linux/delay.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
-#include <linux/pci-aspm.h>
 #include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/ktime.h>
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 644f7f5c61a2..4a858789e6c5 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -27,7 +27,6 @@
 #include <linux/moduleparam.h>
 #include <linux/pci.h>
 #include <linux/aer.h>
-#include <linux/pci-aspm.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 1bb6aada93fa..ac39ed79ccaa 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -21,7 +21,6 @@
 #include <linux/interrupt.h>
 #include <linux/types.h>
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 717ba0845a2a..27fdbc165446 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -51,7 +51,6 @@
 #include <linux/workqueue.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
-#include <linux/pci-aspm.h>
 #include <linux/interrupt.h>
 #include <linux/aer.h>
 #include <linux/raid_class.h>
diff --git a/include/linux/pci-aspm.h b/include/linux/pci-aspm.h
deleted file mode 100644
index 67064145d76e..000000000000
--- a/include/linux/pci-aspm.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *	aspm.h
- *
- *	PCI Express ASPM defines and function prototypes
- *
- *	Copyright (C) 2007 Intel Corp.
- *		Zhang Yanmin (yanmin.zhang@intel.com)
- *		Shaohua Li (shaohua.li@intel.com)
- *
- *	For more information, please consult the following manuals (look at
- *	http://www.pcisig.com/ for how to get them):
- *
- *	PCI Express Specification
- */
-
-#ifndef LINUX_ASPM_H
-#define LINUX_ASPM_H
-
-#include <linux/pci.h>
-
-#define PCIE_LINK_STATE_L0S	1
-#define PCIE_LINK_STATE_L1	2
-#define PCIE_LINK_STATE_CLKPM	4
-
-#ifdef CONFIG_PCIEASPM
-int pci_disable_link_state(struct pci_dev *pdev, int state);
-int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
-void pcie_no_aspm(void);
-#else
-static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
-{ return 0; }
-static inline void pcie_no_aspm(void) { }
-#endif
-
-#endif /* LINUX_ASPM_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9e700d9f9f28..f07f52175606 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -6,12 +6,18 @@
  *	Copyright 1994, Drew Eckhardt
  *	Copyright 1997--1999 Martin Mares <mj@ucw.cz>
  *
+ *      PCI Express ASPM defines and function prototypes
+ *      Copyright (c) 2007 Intel Corp.
+ *              Zhang Yanmin (yanmin.zhang@intel.com)
+ *              Shaohua Li (shaohua.li@intel.com)
+ *
  *	For more information, please consult the following manuals (look at
  *	http://www.pcisig.com/ for how to get them):
  *
  *	PCI BIOS Specification
  *	PCI Local Bus Specification
  *	PCI to PCI Bridge Specification
+ *	PCI Express Specification
  *	PCI System Design Guide
  */
 #ifndef LINUX_PCI_H
@@ -1565,9 +1571,21 @@ extern bool pcie_ports_native;
 #define pcie_ports_native	false
 #endif
 
+#define PCIE_LINK_STATE_L0S	1
+#define PCIE_LINK_STATE_L1	2
+#define PCIE_LINK_STATE_CLKPM	4
+
 #ifdef CONFIG_PCIEASPM
+int pci_disable_link_state(struct pci_dev *pdev, int state);
+int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
+void pcie_no_aspm(void);
 bool pcie_aspm_support_enabled(void);
 #else
+static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
+{ return 0; }
+static inline int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
+{ return 0; }
+static inline void pcie_no_aspm(void) { }
 static inline bool pcie_aspm_support_enabled(void) { return false; }
 #endif
 
-- 
2.22.1

