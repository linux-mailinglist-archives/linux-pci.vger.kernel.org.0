Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A2C27D736
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 21:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgI2TsJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 15:48:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728723AbgI2TsJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 15:48:09 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CA0820774;
        Tue, 29 Sep 2020 19:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601408888;
        bh=GICoHa9khuYYRMn6zdxlSfQZX6PczQtkdPZXWahn1ZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PN7We8oSHI5WLB7fkbkuKP/tmWdaVqIuKvjSv6Pt6HtBKA6VdIWEjEXg0e1SpBkNe
         slM04vCHkQA+CniuSdHyTehcPhg5rR3gq68zgKKg1YMO+LIQAhTNc+QVDKh+mPTbKm
         Zmbo30yTUoS8do7ePU4z12x++yZT+a9OPZpy+XBM=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] PCI/PM: Revert "PCI/PM: Apply D2 delay as milliseconds, not microseconds"
Date:   Tue, 29 Sep 2020 14:47:48 -0500
Message-Id: <20200929194748.2566828-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200929194748.2566828-1-helgaas@kernel.org>
References: <20200929194748.2566828-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This reverts commit 7e24bc347e57992d532bc2ed700209b0fc0a4bf5.

7e24bc347e57 was based on PCIe r5.0, sec 5.9, which claims we need a 200 ms
delay when transitioning to or from D2.  However, sec 5.3.1.3 states the
delay as 200 μs (microseconds), as does the table in PCIe r4.0, sec 5.9.1.

This looks like a typo in the r5.0 spec, so revert back to a 200 μs delay
instead of a 200 ms delay.

Fixes: 7e24bc347e57 ("PCI/PM: Apply D2 delay as milliseconds, not microseconds")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 2 +-
 drivers/pci/pci.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c4a26532a447..d69578ad44a0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1065,7 +1065,7 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 	if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
 		pci_dev_d3_sleep(dev);
 	else if (state == PCI_D2 || dev->current_state == PCI_D2)
-		msleep(PCI_PM_D2_DELAY);
+		udelay(PCI_PM_D2_DELAY);
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f0a9cbe01bc7..f86cae9aa1f4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -43,9 +43,9 @@ int pci_probe_reset_function(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 
-#define PCI_PM_D2_DELAY         200
-#define PCI_PM_D3HOT_WAIT       10
-#define PCI_PM_D3COLD_WAIT      100
+#define PCI_PM_D2_DELAY         200	/* usec; see PCIe r4.0, sec 5.9.1 */
+#define PCI_PM_D3HOT_WAIT       10	/* msec */
+#define PCI_PM_D3COLD_WAIT      100	/* msec */
 
 /**
  * struct pci_platform_pm_ops - Firmware PM callbacks
-- 
2.25.1

