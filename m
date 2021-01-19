Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D418A2FBAAB
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jan 2021 16:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbhASPAY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jan 2021 10:00:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:16839 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390362AbhASNQT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Jan 2021 08:16:19 -0500
IronPort-SDR: TR3oOsXU6wkfXoTcowsvKXUwagYwbvNbah/u/PxyuBy/61wOU+ANEzsRNcL3V5EBAvO+S4SZzC
 +KvulphsPIxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="158102170"
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; 
   d="scan'208";a="158102170"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 05:14:12 -0800
IronPort-SDR: XtUZXNd6yK/u6BfIChMsZk9oZ2A1xmGUlHLdJaQyA5zHv4wMpXcjTCVfX3dU8CesruzKGNFfbe
 7ph6/QH7eyMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; 
   d="scan'208";a="466694494"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2021 05:14:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5AA9814A; Tue, 19 Jan 2021 15:14:10 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI: Re-enable downstream port LTR if it was previously enabled
Date:   Tue, 19 Jan 2021 16:14:10 +0300
Message-Id: <20210119131410.27528-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe r5.0, sec 7.5.3.16 says that the downstream ports must reset the
LTR enable bit if the link goes down (port goes DL_Down status). Now, if
we had LTR previously enabled and the PCIe endpoint gets hot-removed and
then hot-added back the ->ltr_path of the downstream port is still set
but the port now does not have the LTR enable bit set anymore.

For this reason check if the bridge upstream had LTR enabled previously
and re-enable it before enabling LTR for the endpoint.

Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Previous version can be found here:

  https://lore.kernel.org/linux-pci/20210114134724.79511-1-mika.westerberg@linux.intel.com/

Changes from the previous version:

  * Corrected typos in the commit message
  * No need to call pcie_downstream_port()

 drivers/pci/probe.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0eb68b47354f..a4a8c0305fb9 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2153,7 +2153,7 @@ static void pci_configure_ltr(struct pci_dev *dev)
 {
 #ifdef CONFIG_PCIEASPM
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
-	struct pci_dev *bridge;
+	struct pci_dev *bridge = NULL;
 	u32 cap, ctl;
 
 	if (!pci_is_pcie(dev))
@@ -2191,6 +2191,21 @@ static void pci_configure_ltr(struct pci_dev *dev)
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
 	    ((bridge = pci_upstream_bridge(dev)) &&
 	      bridge->ltr_path)) {
+		/*
+		 * Downstream ports reset the LTR enable bit when the
+		 * link goes down (e.g on hot-remove) so re-enable the
+		 * bit here if not set anymore.
+		 * PCIe r5.0, sec 7.5.3.16.
+		 */
+		if (bridge) {
+			pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2, &ctl);
+			if (!(ctl & PCI_EXP_DEVCTL2_LTR_EN)) {
+				pci_dbg(bridge, "re-enabling LTR\n");
+				pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
+							 PCI_EXP_DEVCTL2_LTR_EN);
+			}
+		}
+		pci_dbg(dev, "enabling LTR\n");
 		pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
 					 PCI_EXP_DEVCTL2_LTR_EN);
 		dev->ltr_path = 1;
-- 
2.29.2

