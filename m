Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC82D29F8
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 14:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387880AbfJJMsB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Oct 2019 08:48:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733288AbfJJMsA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Oct 2019 08:48:00 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDE66206B6;
        Thu, 10 Oct 2019 12:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570711680;
        bh=OcutfbH2J4Mrok55YXxQjXQOL7Vow7GNs62fKAtdayw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ACGbf5WV9FgMZWWHlRDKH+X3xK5rYuizRPwXQReJAkUn1VC9XxSGgBBFZLhyw2Pee
         htQMV0v/XpiuMKE6r0ZvUpkxAH4YVgA+CrgGtA7IO4oOS66UhYRcARylrcNteIa/nC
         /eniu9haa7GStSNv0P3F4mKKBcA3E3sWfG9UDKw0=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Keith Busch <keith.busch@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajat Jain <rajatja@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/1] PCI/ASPM: Remove pcie_aspm_enabled() unnecessary locking
Date:   Thu, 10 Oct 2019 07:47:46 -0500
Message-Id: <20191010124746.2882-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191010124746.2882-1-helgaas@kernel.org>
References: <20191010124746.2882-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The lifetime of the link_state structure (bridge->link_state) is not the
same as the lifetime of "bridge" itself.  The link_state is allocated by
pcie_aspm_init_link_state() after children of the bridge have been
enumerated, and it is deallocated by pcie_aspm_exit_link_state() after all
children of the bridge (but not the bridge itself) have been removed.

Previously pcie_aspm_enabled() acquired aspm_lock to ensure that
link_state was not deallocated while we're looking at it.  But the fact
that the caller of pcie_aspm_enabled() holds a reference to @pdev means
there's always at least one child of the bridge, which means link_state
can't be deallocated.

Remove the unnecessary locking in pcie_aspm_enabled().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 652ef23bba35..f5c7138a34aa 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1172,20 +1172,20 @@ module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
 /**
  * pcie_aspm_enabled - Check if PCIe ASPM has been enabled for a device.
  * @pdev: Target device.
+ *
+ * Relies on the upstream bridge's link_state being valid.  The link_state
+ * is deallocated only when the last child of the bridge (i.e., @pdev or a
+ * sibling) is removed, and the caller should be holding a reference to
+ * @pdev, so this should be safe.
  */
 bool pcie_aspm_enabled(struct pci_dev *pdev)
 {
 	struct pci_dev *bridge = pci_upstream_bridge(pdev);
-	bool ret;
 
 	if (!bridge)
 		return false;
 
-	mutex_lock(&aspm_lock);
-	ret = bridge->link_state ? !!bridge->link_state->aspm_enabled : false;
-	mutex_unlock(&aspm_lock);
-
-	return ret;
+	return bridge->link_state ? !!bridge->link_state->aspm_enabled : false;
 }
 EXPORT_SYMBOL_GPL(pcie_aspm_enabled);
 
-- 
2.23.0.581.g78d2f28ef7-goog

