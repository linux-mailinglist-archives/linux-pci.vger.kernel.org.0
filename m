Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA8E2F6261
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 14:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbhANNtP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 08:49:15 -0500
Received: from mga17.intel.com ([192.55.52.151]:22386 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbhANNtO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Jan 2021 08:49:14 -0500
IronPort-SDR: LzPWEVuT50SP04t7enOnkuIidt2O0qgUozEanjByaX1NkAQksk/gcfTLUBuGCMXs8ck9tRm0Yd
 4nDginsWgHLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="158140424"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="158140424"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 05:47:27 -0800
IronPort-SDR: NsMFlKJNhjYzvqwzWxhzENgdilu76hXWIfx+gXUxg+zX3uxAYCynCPcCvCdSBvZllbQ85EZga9
 q7m2bEA1thNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="349164135"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 14 Jan 2021 05:47:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 08D17189; Thu, 14 Jan 2021 15:47:24 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Re-enable downstream port LTR if it was previously enabled
Date:   Thu, 14 Jan 2021 16:47:24 +0300
Message-Id: <20210114134724.79511-1-mika.westerberg@linux.intel.com>
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

For this reason check if the bridge upstrea had LTR enabled set
previously and re-enable it before enabling LTR for the endpoint.

Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/probe.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0eb68b47354f..cd174e06f46f 100644
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
+		if (bridge && pcie_downstream_port(bridge)) {
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

