Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A9F224678
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jul 2020 00:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgGQWzn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jul 2020 18:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgGQWzn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jul 2020 18:55:43 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A2F62070E;
        Fri, 17 Jul 2020 22:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595026542;
        bh=0weQ6vGskysex0rpvIFBX+H/4pwUJ8bSIH5Pw3bN3Eo=;
        h=From:To:Cc:Subject:Date:From;
        b=bsGzYCxwM9Cei6eDpgCVIbOsPq8FkK/rZK/ZeuHxXW9z/nE8dRZBpE+ysSo0wktmV
         H4uFoS21XiQ7Bs+6N35miSh8uqyfqs7dV8pqX6BoT7AZjG7Uyo6YWOwltcEKX6RMkz
         ViDLQq6IRNBZLJOAP+fD+0Mj8ZDdgK2//EdvJD6Q=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Patrick Volkerding <volkerdi@gmail.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Sasha Levin <sashal@kernel.org>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] Revert "PCI/PM: Assume ports without DLL Link Active train links in 100 ms"
Date:   Fri, 17 Jul 2020 17:55:33 -0500
Message-Id: <20200717225533.783790-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This reverts commit ec411e02b7a2e785a4ed9ed283207cd14f48699d.

Patrick reported that this commit broke hybrid graphics on a ThinkPad X1
Extreme 2nd with Intel UHD Graphics 630 and NVIDIA GeForce GTX 1650 Mobile:

  nouveau 0000:01:00.0: fifo: PBDMA0: 01000000 [] ch 0 [00ff992000 DRM] subc 0 mthd 0008 data 00000000

Karol reported that this commit broke Nouveau firmware loading on a Lenovo
P1G2 with Intel UHD Graphics 630 and NVIDIA TU117GLM [Quadro T1000 Mobile]:

  nouveau 0000:01:00.0: acr: AHESASC binary failed

In both cases, reverting ec411e02b7a2 solved the problem.  Unfortunately,
this revert will reintroduce the "Thunderbolt bridges take long time to
resume from D3cold" problem:
https://bugzilla.kernel.org/show_bug.cgi?id=206837

Link: https://lore.kernel.org/r/CAErSpo5sTeK_my1dEhWp7aHD0xOp87+oHYWkTjbL7ALgDbXo-Q@mail.gmail.com
Link: https://lore.kernel.org/r/CACO55tsAEa5GXw5oeJPG=mcn+qxNvspXreJYWDJGZBy5v82JDA@mail.gmail.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=208597
Reported-by: Patrick Volkerding <volkerdi@gmail.com>
Reported-by: Karol Herbst <kherbst@redhat.com>
Fixes: ec411e02b7a2 ("PCI/PM: Assume ports without DLL Link Active train links in 100 ms")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce096272f52b..c9338f914a0e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4638,8 +4638,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
  * pcie_wait_for_link_delay - Wait until link is active or inactive
  * @pdev: Bridge device
  * @active: waiting for active or inactive?
- * @delay: Delay to wait after link has become active (in ms). Specify %0
- *	   for no delay.
+ * @delay: Delay to wait after link has become active (in ms)
  *
  * Use this to wait till link becomes active or inactive.
  */
@@ -4680,7 +4679,7 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
 		msleep(10);
 		timeout -= 10;
 	}
-	if (active && ret && delay)
+	if (active && ret)
 		msleep(delay);
 	else if (ret != active)
 		pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
@@ -4801,28 +4800,17 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
 	if (!pcie_downstream_port(dev))
 		return;
 
-	/*
-	 * Per PCIe r5.0, sec 6.6.1, for downstream ports that support
-	 * speeds > 5 GT/s, we must wait for link training to complete
-	 * before the mandatory delay.
-	 *
-	 * We can only tell when link training completes via DLL Link
-	 * Active, which is required for downstream ports that support
-	 * speeds > 5 GT/s (sec 7.5.3.6).  Unfortunately some common
-	 * devices do not implement Link Active reporting even when it's
-	 * required, so we'll check for that directly instead of checking
-	 * the supported link speed.  We assume devices without Link Active
-	 * reporting can train in 100 ms regardless of speed.
-	 */
-	if (dev->link_active_reporting) {
-		pci_dbg(dev, "waiting for link to train\n");
-		if (!pcie_wait_for_link_delay(dev, true, 0)) {
+	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
+		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
+		msleep(delay);
+	} else {
+		pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
+			delay);
+		if (!pcie_wait_for_link_delay(dev, true, delay)) {
 			/* Did not train, no need to wait any further */
 			return;
 		}
 	}
-	pci_dbg(child, "waiting %d ms to become accessible\n", delay);
-	msleep(delay);
 
 	if (!pci_device_is_present(child)) {
 		pci_dbg(child, "waiting additional %d ms to become accessible\n", delay);
-- 
2.25.1

