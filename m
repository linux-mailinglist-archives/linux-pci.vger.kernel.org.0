Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F865DB8F9
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 23:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503601AbfJQV3C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 17:29:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727683AbfJQV3B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Oct 2019 17:29:01 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B03B321A49;
        Thu, 17 Oct 2019 21:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571347740;
        bh=Bc3HCFc6y6+gN2QfwO1d6iGBdnhOT8r7h4mEEpAH98U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=THiR1MPGnsFaVzoHvGizfzyBLLJZUGaZuUbK7m/D0TvLSZTgJbE8XcPNtsJn3sQTh
         PLxMkKAGwTY4SlhtSOLkwtRUcwcWFTwxtbDifp4SpZyDhr07+yjnIIHvozWgFjKl9k
         PKC9EO2rnZBJG6LPnYLB3GlhWpU30QgmZxWq7z4Q=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] PCI/PM: Use PCI dev_printk() wrappers for consistency
Date:   Thu, 17 Oct 2019 16:28:50 -0500
Message-Id: <20191017212851.54237-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191017212851.54237-1-helgaas@kernel.org>
References: <20191017212851.54237-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use the PCI dev_printk() wrappers for consistency with the rest of the PCI
core.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-driver.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index dd70ab2519c9..407b1df5ea7c 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -315,7 +315,8 @@ static long local_pci_probe(void *_ddi)
 	 * Probe function should return < 0 for failure, 0 for success
 	 * Treat values > 0 as success, but warn.
 	 */
-	dev_warn(dev, "Driver probe function unexpectedly returned %d\n", rc);
+	pci_warn(pci_dev, "Driver probe function unexpectedly returned %d\n",
+		 rc);
 	return 0;
 }
 
@@ -865,7 +866,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
 			pci_prepare_to_sleep(pci_dev);
 	}
 
-	dev_dbg(dev, "PCI PM: Suspend power state: %s\n",
+	pci_dbg(pci_dev, "PCI PM: Suspend power state: %s\n",
 		pci_power_name(pci_dev->current_state));
 
 	if (pci_dev->current_state == PCI_D0) {
@@ -880,7 +881,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
 	}
 
 	if (pci_dev->skip_bus_pm && pm_suspend_no_platform()) {
-		dev_dbg(dev, "PCI PM: Skipped\n");
+		pci_dbg(pci_dev, "PCI PM: Skipped\n");
 		goto Fixup;
 	}
 
@@ -1295,11 +1296,11 @@ static int pci_pm_runtime_suspend(struct device *dev)
 		 * log level.
 		 */
 		if (error == -EBUSY || error == -EAGAIN) {
-			dev_dbg(dev, "can't suspend now (%ps returned %d)\n",
+			pci_dbg(pci_dev, "can't suspend now (%ps returned %d)\n",
 				pm->runtime_suspend, error);
 			return error;
 		} else if (error) {
-			dev_err(dev, "can't suspend (%ps returned %d)\n",
+			pci_err(pci_dev, "can't suspend (%ps returned %d)\n",
 				pm->runtime_suspend, error);
 			return error;
 		}
-- 
2.23.0.866.gb869b98d4c-goog

