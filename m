Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662D624EA10
	for <lists+linux-pci@lfdr.de>; Sun, 23 Aug 2020 00:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgHVWUe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Aug 2020 18:20:34 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:35332 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726535AbgHVWUe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Aug 2020 18:20:34 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 351DB30C025;
        Sat, 22 Aug 2020 15:17:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 351DB30C025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1598134669;
        bh=UE3OyB8A4aT6f2xa9aoBVeB/WeSuw2wDk5Slp6DChN4=;
        h=From:To:Cc:Subject:Date:From;
        b=QjOSkyFx/Bo5SsYRp4S8KdoovPrvxELm0640AcgBnECK21w8sMfWvt7av7IIWpakr
         3QNNFu3pUjwpjQ8hdkuzMF1kHP93U8PQJfBwAIUbc6vdWiRn5fbAh9wQ4plkT1NfbD
         AeLy4IEm9Xbu+IX3WcnzmN4qgHQgPZr4JrNgLKnk=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 8ACAF14008E;
        Sat, 22 Aug 2020 15:20:30 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        james.quinlan@broadcom.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1] PCI: pcie_bus_config can be set at build time
Date:   Sat, 22 Aug 2020 18:20:20 -0400
Message-Id: <20200822222021.37166-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Kconfig is modified so that the pcie_bus_config setting can be done at
build time in the same manner as the CONFIG_PCIEASPM_XXXX choice.  The
pci_bus_config setting may still be overridden by the bootline param.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/Kconfig | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c   | 12 ++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 4bef5c2bae9f..efe69b0d9f7f 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -187,6 +187,46 @@ config PCI_HYPERV
 	  The PCI device frontend driver allows the kernel to import arbitrary
 	  PCI devices from a PCI backend to support PCI driver domains.
 
+choice
+	prompt "PCIE default bus config setting"
+	default PCIE_BUS_DEFAULT
+	depends on PCI
+	help
+	  One of the following choices will set the pci_bus_config at
+	  compile time.  This will still be overridden by the appropriate
+	  pci bootline parameter.
+
+config PCIE_BUS_TUNE_OFF
+	bool "Tune Off"
+	depends on PCI
+	help
+	  Use the BIOS defaults; doesn't touch MPS at all.
+
+config PCIE_BUS_DEFAULT
+	bool "Default"
+	depends on PCI
+	help
+	  Ensure MPS matches upstream bridge.
+
+config PCIE_BUS_SAFE
+	bool "Safe"
+	depends on PCI
+	help
+	  Use largest MPS boot-time devices support.
+
+config PCIE_BUS_PERFORMANCE
+	bool "Performance"
+	depends on PCI
+	help
+	  Use MPS and MRRS for best performance.
+
+config PCIE_BUS_PEER2PEER
+	bool "Peer2peer"
+	depends on PCI
+	help
+	  Set MPS = 128 for all devices.
+endchoice
+
 source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/controller/Kconfig"
 source "drivers/pci/endpoint/Kconfig"
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a458c46d7e39..49b66ba7c874 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -101,7 +101,19 @@ unsigned long pci_hotplug_mmio_pref_size = DEFAULT_HOTPLUG_MMIO_PREF_SIZE;
 #define DEFAULT_HOTPLUG_BUS_SIZE	1
 unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
 
+
+/* PCIE bus config, can be overridden by bootline param */
+#ifdef CONFIG_PCIE_BUS_TUNE_OFF
+enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_TUNE_OFF;
+#elif defined CONFIG_PCIE_BUS_SAFE
+enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_SAFE;
+#elif defined CONFIG_PCIE_BUS_PERFORMANCE
+enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PERFORMANCE;
+#elif defined CONFIG_PCIE_BUS_PEER2PEER
+enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PEER2PEER;
+#else
 enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
+#endif
 
 /*
  * The default CLS is used if arch didn't set CLS explicitly and not
-- 
2.17.1

