Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246CD3EA7B0
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 17:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbhHLPk0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 11:40:26 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:37570
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232854AbhHLPkZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Aug 2021 11:40:25 -0400
Received: from localhost.localdomain (1-171-221-24.dynamic-ip.hinet.net [1.171.221.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9BEE43F224;
        Thu, 12 Aug 2021 15:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628782799;
        bh=bb+D78y9t3UZu9BB80kiJI5yrTWzi5x0kq2PZ/EFOfA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=PDWKbccFqR4uVpEaqFk5I3xe1mN0/yjQ7qMfUWeL5DpkgCSPWxsrtwyssPHHKhHDR
         Y6sAx7ebFOk3wuI1cEieaPqVo+u6iLcY9Bkv93khdI2qyaxNZT+HMdO04sjv+AnK/9
         TSfoduky38TGRqKJjep2aTL/8OAjq3jIg4WOsg33yT34DyTefiCJ6uvxo8Ritgfem6
         nsqoFnCJe37ioEdznYSbScwV/EQBadKdeuilNMsMR/TbUapHwTA/PwoybERCS0o3We
         DmCoDjWLlj9pBir6rItWwzrao7FiRJfr+6Sm+X1xcFak/jnw3mR177Mz+T3T4RWzwO
         LogOlxpu+6uXg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] PCI: Check PCIe upstream port for PME support
Date:   Thu, 12 Aug 2021 23:39:44 +0800
Message-Id: <20210812153944.813949-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some platforms cannot detect ethernet hotplug once its upstream port is
runtime suspended because PME isn't granted by BIOS _OSC. The issue can
be workarounded by "pcie_ports=native".

The vendor confirmed that the PME in _OSC is disabled intentionally for
system stability issues on the other OS, so we should also honor the PME
setting here.

So before marking PME support status for the device, check
PCI_EXP_RTCTL_PMEIE bit to ensure PME interrupt is either enabled by
firmware or OS.

Cc: Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=213873
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Instead of prevent root port from runtime suspending, skip
   initializing PME status for the downstream device.

 drivers/pci/pci.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aacf575c15cf..4344dc302edd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2294,6 +2294,32 @@ void pci_pme_wakeup_bus(struct pci_bus *bus)
 		pci_walk_bus(bus, pci_pme_wakeup, (void *)true);
 }
 
+#ifdef CONFIG_PCIE_PME
+static bool pci_pcie_port_pme_enabled(struct pci_dev *dev)
+{
+	struct pci_dev *bridge = pci_upstream_bridge(dev);
+	u16 val;
+	int ret;
+
+	if (!bridge)
+		return true;
+
+	if (pci_pcie_type(bridge) != PCI_EXP_TYPE_ROOT_PORT &&
+	    pci_pcie_type(bridge) != PCI_EXP_TYPE_RC_EC)
+		return true;
+
+	ret = pcie_capability_read_word(bridge, PCI_EXP_RTCTL, &val);
+	if (ret)
+		return false;
+
+	return val & PCI_EXP_RTCTL_PMEIE;
+}
+#else
+static bool pci_pcie_port_pme_enabled(struct pci_dev *dev)
+{
+	return true;
+}
+#endif
 
 /**
  * pci_pme_capable - check the capability of PCI device to generate PME#
@@ -3095,7 +3121,7 @@ void pci_pm_init(struct pci_dev *dev)
 	}
 
 	pmc &= PCI_PM_CAP_PME_MASK;
-	if (pmc) {
+	if (pmc && pci_pcie_port_pme_enabled(dev)) {
 		pci_info(dev, "PME# supported from%s%s%s%s%s\n",
 			 (pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
 			 (pmc & PCI_PM_CAP_PME_D1) ? " D1" : "",
-- 
2.32.0

