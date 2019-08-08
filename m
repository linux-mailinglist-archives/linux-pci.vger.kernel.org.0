Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A33886CD7
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 23:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390296AbfHHV64 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Aug 2019 17:58:56 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52972 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfHHV64 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Aug 2019 17:58:56 -0400
Received: from 79.184.254.29.ipv4.supernova.orange.pl (79.184.254.29) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 2d19d8ad48c4b56a; Thu, 8 Aug 2019 23:58:53 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     linux-nvme <linux-nvme@lists.infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v3 1/2] PCI: PCIe: ASPM: Introduce pcie_aspm_enabled()
Date:   Thu, 08 Aug 2019 23:55:07 +0200
Message-ID: <1618955.HVa0YQSOW5@kreacher>
In-Reply-To: <2184247.yL3mcj2FRQ@kreacher>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM> <20190731221956.GB15795@localhost.localdomain> <2184247.yL3mcj2FRQ@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a function checking whether or not PCIe ASPM has been enabled for
a given device.

It will be used by the NVMe driver to decide how to handle the
device during system suspend.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
  * Make the new function return bool.
  * Change its name back to pcie_aspm_enabled().
  * Fix kerneldoc comment formatting.

-> v2:
  * Move the PCI/PCIe ASPM changes to a separate patch.
  * Add the _mask suffix to the new function name.
  * Add EXPORT_SYMBOL_GPL() to the new function.
  * Avoid adding an unnecessary blank line.

---
 drivers/pci/pcie/aspm.c |   20 ++++++++++++++++++++
 include/linux/pci.h     |    3 +++
 2 files changed, 23 insertions(+)

Index: linux-pm/drivers/pci/pcie/aspm.c
===================================================================
--- linux-pm.orig/drivers/pci/pcie/aspm.c
+++ linux-pm/drivers/pci/pcie/aspm.c
@@ -1170,6 +1170,26 @@ static int pcie_aspm_get_policy(char *bu
 module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
 	NULL, 0644);
 
+/**
+ * pcie_aspm_enabled - Check if PCIe ASPM has been enabled for a device.
+ * @pci_device: Target device.
+ */
+bool pcie_aspm_enabled(struct pci_dev *pci_device)
+{
+	struct pci_dev *bridge = pci_upstream_bridge(pci_device);
+	bool ret;
+
+	if (!bridge)
+		return false;
+
+	mutex_lock(&aspm_lock);
+	ret = bridge->link_state ? !!bridge->link_state->aspm_enabled : false;
+	mutex_unlock(&aspm_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pcie_aspm_enabled);
+
 #ifdef CONFIG_PCIEASPM_DEBUG
 static ssize_t link_state_show(struct device *dev,
 		struct device_attribute *attr,
Index: linux-pm/include/linux/pci.h
===================================================================
--- linux-pm.orig/include/linux/pci.h
+++ linux-pm/include/linux/pci.h
@@ -1567,8 +1567,11 @@ extern bool pcie_ports_native;
 
 #ifdef CONFIG_PCIEASPM
 bool pcie_aspm_support_enabled(void);
+bool pcie_aspm_enabled(struct pci_dev *pci_device);
 #else
 static inline bool pcie_aspm_support_enabled(void) { return false; }
+static inline bool pcie_aspm_enabled(struct pci_dev *pci_device)
+{ return false; }
 #endif
 
 #ifdef CONFIG_PCIEAER



