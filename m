Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C926203C4C
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jun 2020 18:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgFVQMv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 12:12:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:39729 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729275AbgFVQMv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jun 2020 12:12:51 -0400
IronPort-SDR: RPf/WDezMyZPclDOOogKwUXzbjMx8ETkk9rdigbpLp60XFueWoy77pPEwfLqbvjFvHfZg+gqsb
 UhvwcdeXmX2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="208998216"
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="scan'208";a="208998216"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 09:12:51 -0700
IronPort-SDR: MURvGteXMO4/GePV3Z5yoPHMUS1qzc1JUmAEvd+0whap3kbDVOETMqd9k503ivvW53epS04v0q
 Cy1uTzqT8dQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="scan'208";a="292896534"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 22 Jun 2020 09:12:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C2F5711C; Mon, 22 Jun 2020 19:12:48 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Make pcie_find_root_port() work for PCIe root ports as well
Date:   Mon, 22 Jun 2020 19:12:48 +0300
Message-Id: <20200622161248.51099-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 6ae72bfa656e ("PCI: Unify pcie_find_root_port() and
pci_find_pcie_root_port()") unified the root port finding functionality
into a single function but missed the fact that the passed in device may
already be a root port. This causes the kernel to block power management
of PCIe hierarchies in recent systems because ->bridge_d3 started to
return false for such ports after the commit in question.

Fixes: 6ae72bfa656e ("PCI: Unify pcie_find_root_port() and pci_find_pcie_root_port()")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: stable@vger.kernel.org
---
 include/linux/pci.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index c79d83304e52..c17c24f5eeed 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2169,8 +2169,13 @@ static inline int pci_pcie_type(const struct pci_dev *dev)
  */
 static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
 {
-	struct pci_dev *bridge = pci_upstream_bridge(dev);
+	struct pci_dev *bridge;
 
+	/* If dev is already root port */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+		return dev;
+
+	bridge = pci_upstream_bridge(dev);
 	while (bridge) {
 		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT)
 			return bridge;
-- 
2.27.0

