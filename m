Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA1D3DC60B
	for <lists+linux-pci@lfdr.de>; Sat, 31 Jul 2021 15:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhGaNBG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 31 Jul 2021 09:01:06 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:39277 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhGaNBG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Jul 2021 09:01:06 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 50EB9280284E5;
        Sat, 31 Jul 2021 15:00:56 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 42A8F24F2F2; Sat, 31 Jul 2021 15:00:56 +0200 (CEST)
Message-Id: <98f9041151268c1c035ab64cca320ad86803f64a.1627638184.git.lukas@wunner.de>
In-Reply-To: <cover.1627638184.git.lukas@wunner.de>
References: <cover.1627638184.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 31 Jul 2021 14:39:04 +0200
Subject: [PATCH 4/4] PCI/ERR: Reduce compile time for CONFIG_PCIEAER=n
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        "Oliver OHalloran" <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The sole non-static function in err.c, pcie_do_recovery(), is only
called from:

* aer.c (if CONFIG_PCIEAER=y)
* dpc.c (if CONFIG_PCIE_DPC=y, which depends on CONFIG_PCIEAER)
* edr.c (if CONFIG_PCIE_EDR=y, which depends on CONFIG_PCIE_DPC)

Thus, err.c need not be compiled if CONFIG_PCIEAER=n.

Also, pci_uevent_ers() and pcie_clear_device_status(), which are called
from err.c, can be #ifdef'ed away unless CONFIG_PCIEAER=y.

Since x86_64_defconfig doesn't enable CONFIG_PCIEAER, this change may
slightly reduce compile time for anyone doing a test build with that
config.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci-driver.c  | 2 +-
 drivers/pci/pci.c         | 2 ++
 drivers/pci/pcie/Makefile | 4 ++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 3a72352aa5cf..bd990a4f9d53 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1529,7 +1529,7 @@ static int pci_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-#if defined(CONFIG_PCIEPORTBUS) || defined(CONFIG_EEH)
+#ifdef CONFIG_PCI_ERROR_RECOVERY
 /**
  * pci_uevent_ers - emit a uevent during recovery path of PCI device
  * @pdev: PCI device undergoing error recovery
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2f519074f0f8..ee9f86feac06 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2216,6 +2216,7 @@ int pci_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
 }
 EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
 
+#ifdef CONFIG_PCIEAER
 void pcie_clear_device_status(struct pci_dev *dev)
 {
 	u16 sta;
@@ -2223,6 +2224,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
 	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
 }
+#endif
 
 /**
  * pcie_clear_root_pme_status - Clear root port PME interrupt status.
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index b2980db88cc0..5783a2f79e6a 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -2,12 +2,12 @@
 #
 # Makefile for PCI Express features and port driver
 
-pcieportdrv-y			:= portdrv_core.o portdrv_pci.o err.o rcec.o
+pcieportdrv-y			:= portdrv_core.o portdrv_pci.o rcec.o
 
 obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
 
 obj-$(CONFIG_PCIEASPM)		+= aspm.o
-obj-$(CONFIG_PCIEAER)		+= aer.o
+obj-$(CONFIG_PCIEAER)		+= aer.o err.o
 obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
-- 
2.31.1

