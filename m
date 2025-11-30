Return-Path: <linux-pci+bounces-42323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 57321C94B83
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 06:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 991B43456FE
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 05:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E0F15278E;
	Sun, 30 Nov 2025 05:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LmCWh2hO"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37C3FBF0
	for <linux-pci@vger.kernel.org>; Sun, 30 Nov 2025 05:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764479917; cv=none; b=BzwgelOf6YVDUtqke9NyQryrtpvr7jW5ufjkSYfslh1+1nrthJWjKZUfijB/t7tsn2w6oNztnxLJQRTRGRuz3u9lc3olbrSBik0XHi+LdRkAACY6dBAxe1JiGKQkqitGDLXwnRHEvOh5+06Vnq/og1ZR24rDqoN3lw+H5bUd6e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764479917; c=relaxed/simple;
	bh=rfaOSoXPJO7dIxDZ+xyBCmxR33mZiupnEDYUcJ24UBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4KhX3C0oJBNDLAqIaWfxJ2ByOwmKhq5S5hpDpnLfMkK5/fKVZfLjr2kN6RJDTpMX6VMyPwVEGpPO8A5VWyw9Ecuq1vwDjZIDlMyuDo09wJ5Cz2thhp8ubIuzHiXaEZW1RO9H9arYkNUR8DaXJ1B97RTAbt19YWm9XGUpznwLm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LmCWh2hO; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764479905; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ilg+05vtypGXzbZpN5SECujiytFL93Wjq9qWpS6a2pA=;
	b=LmCWh2hOcrCnkjLA9wuQ9otrveshwqEaENQ11tAaOjfUsyh8S2y7oVhpM2so8MIZmizxG9KOe4LC/mAeei+nEEmtgHPF/q9iByarCjnYecvCVUAJneGkhnCmaPb+Is8PQ/LGRrbvA4X5OnKiY4onIfehdzDlt1US+/TC+NwDyvI=
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0WthhjzZ_1764479855 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 30 Nov 2025 13:18:24 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-pci@vger.kernel.org,
	alikernel-developer@linux.alibaba.com
Subject: [PATCH v3] PCI: Fix PCIe SBR dev/link wait error
Date: Sun, 30 Nov 2025 13:17:35 +0800
Message-ID: <20251130051735.3123755-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <2e3a1e6b-40ae-3878-e237-fb9032796af8@linux.intel.com>
References: <2e3a1e6b-40ae-3878-e237-fb9032796af8@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When executing a PCIe secondary bus reset, all downstream switches and
endpoints will generate reset events. Simultaneously, all PCIe links
will undergo retraining, and each link will independently re-execute the
LTSSM state machine training. Therefore, after executing the SBR, it is
necessary to wait for all downstream links and devices to complete
recovery. Otherwise, after the SBR returns, accessing devices with some
links or endpoints not yet fully recovered may result in driver errors,
or even trigger device offline issues.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/pci/pci.c | 141 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 101 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006c..d91c65145739 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4788,6 +4788,63 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
 	return max(min_delay, max_delay);
 }
 
+static int pci_readiness_check(struct pci_dev *pdev, struct pci_dev *child,
+		unsigned long start_t, char *reset_type)
+{
+	int elapsed = jiffies_to_msecs(jiffies - start_t);
+
+	if (pci_dev_is_disconnected(pdev) || pci_dev_is_disconnected(child))
+		return 0;
+
+	if (pcie_get_speed_cap(pdev) <= PCIE_SPEED_5_0GT) {
+		u16 status;
+
+		pci_dbg(pdev, "waiting %d ms for downstream link\n", elapsed);
+
+		if (!pci_dev_wait(child, reset_type, 0))
+			return 0;
+
+		if (PCI_RESET_WAIT > elapsed)
+			return PCI_RESET_WAIT - elapsed;
+
+		/*
+		 * If the port supports active link reporting we now check
+		 * whether the link is active and if not bail out early with
+		 * the assumption that the device is not present anymore.
+		 */
+		if (!pdev->link_active_reporting)
+			return -ENOTTY;
+
+		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &status);
+		if (!(status & PCI_EXP_LNKSTA_DLLLA))
+			return -ENOTTY;
+
+		if (!pci_dev_wait(child, reset_type, 0))
+			return 0;
+
+		if (PCIE_RESET_READY_POLL_MS > elapsed)
+			return PCIE_RESET_READY_POLL_MS - elapsed;
+
+		return -ENOTTY;
+	}
+
+	pci_dbg(pdev, "waiting %d ms for downstream link, after activation\n",
+		elapsed);
+	if (!pcie_wait_for_link_delay(pdev, true, 0)) {
+		/* Did not train, no need to wait any further */
+		pci_info(pdev, "Data Link Layer Link Active not set in %d msec\n", elapsed);
+		return -ENOTTY;
+	}
+
+	if (!pci_dev_wait(child, reset_type, 0))
+		return 0;
+
+	if (PCIE_RESET_READY_POLL_MS > elapsed)
+		return PCIE_RESET_READY_POLL_MS - elapsed;
+
+	return -ENOTTY;
+}
+
 /**
  * pci_bridge_wait_for_secondary_bus - Wait for secondary bus to be accessible
  * @dev: PCI bridge
@@ -4802,12 +4859,14 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
  * 4.3.2.
  *
  * Return 0 on success or -ENOTTY if the first device on the secondary bus
- * failed to become accessible.
+ * failed to become accessible or a value greater than 0 indicates the
+ * left required waiting time..
  */
-int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
+static int __pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, unsigned long start_t,
+		char *reset_type)
 {
-	struct pci_dev *child __free(pci_dev_put) = NULL;
-	int delay;
+	struct pci_dev *child;
+	int delay, ret, elapsed = jiffies_to_msecs(jiffies - start_t);
 
 	if (pci_dev_is_disconnected(dev))
 		return 0;
@@ -4835,8 +4894,6 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		return 0;
 	}
 
-	child = pci_dev_get(list_first_entry(&dev->subordinate->devices,
-					     struct pci_dev, bus_list));
 	up_read(&pci_bus_sem);
 
 	/*
@@ -4844,8 +4901,10 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 	 * accessing the device after reset (that is 1000 ms + 100 ms).
 	 */
 	if (!pci_is_pcie(dev)) {
-		pci_dbg(dev, "waiting %d ms for secondary bus\n", 1000 + delay);
-		msleep(1000 + delay);
+		if (1000 + delay > elapsed)
+			return 1000 + delay - elapsed;
+
+		pci_dbg(dev, "waiting %d ms for secondary bus\n", elapsed);
 		return 0;
 	}
 
@@ -4867,41 +4926,45 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 	if (!pcie_downstream_port(dev))
 		return 0;
 
-	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
-		u16 status;
-
-		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
-		msleep(delay);
-
-		if (!pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay))
-			return 0;
+	if (delay > elapsed)
+		return delay - elapsed;
 
+	down_read(&pci_bus_sem);
+	list_for_each_entry(child, &dev->subordinate->devices, bus_list) {
 		/*
-		 * If the port supports active link reporting we now check
-		 * whether the link is active and if not bail out early with
-		 * the assumption that the device is not present anymore.
+		 * Check if all devices under the same bus have completed
+		 * the reset process, including multifunction devices in
+		 * the same bus.
 		 */
-		if (!dev->link_active_reporting)
-			return -ENOTTY;
+		ret = pci_readiness_check(dev, child, start_t, reset_type);
 
-		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
-		if (!(status & PCI_EXP_LNKSTA_DLLLA))
-			return -ENOTTY;
+		if (ret == 0 && child->subordinate)
+			ret = __pci_bridge_wait_for_secondary_bus(child, start_t, reset_type);
 
-		return pci_dev_wait(child, reset_type,
-				    PCIE_RESET_READY_POLL_MS - PCI_RESET_WAIT);
+		if(ret)
+			break;
 	}
+	up_read(&pci_bus_sem);
 
-	pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
-		delay);
-	if (!pcie_wait_for_link_delay(dev, true, delay)) {
-		/* Did not train, no need to wait any further */
-		pci_info(dev, "Data Link Layer Link Active not set in %d msec\n", delay);
-		return -ENOTTY;
+	return ret;
+}
+
+int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
+{
+	int res, gap = 1;
+	unsigned long start_t = jiffies;
+
+	res = __pci_bridge_wait_for_secondary_bus(dev, start_t, reset_type);
+
+	while (res > 0) {
+		gap = gap < res ? gap : res;
+		msleep(gap);
+		gap <<= 1;
+
+		res = __pci_bridge_wait_for_secondary_bus(dev, start_t, reset_type);
 	}
 
-	return pci_dev_wait(child, reset_type,
-			    PCIE_RESET_READY_POLL_MS - delay);
+	return res;
 }
 
 void pci_reset_secondary_bus(struct pci_dev *dev)
@@ -5542,10 +5605,8 @@ static void pci_bus_restore_locked(struct pci_bus *bus)
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		pci_dev_restore(dev);
-		if (dev->subordinate) {
-			pci_bridge_wait_for_secondary_bus(dev, "bus reset");
+		if (dev->subordinate)
 			pci_bus_restore_locked(dev->subordinate);
-		}
 	}
 }
 
@@ -5575,14 +5636,14 @@ static void pci_slot_restore_locked(struct pci_slot *slot)
 {
 	struct pci_dev *dev;
 
+	pci_bridge_wait_for_secondary_bus(slot->bus->self, "slot reset");
+
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
 		pci_dev_restore(dev);
-		if (dev->subordinate) {
-			pci_bridge_wait_for_secondary_bus(dev, "slot reset");
+		if (dev->subordinate)
 			pci_bus_restore_locked(dev->subordinate);
-		}
 	}
 }
 
-- 
2.32.0.3.gf3a3e56d6


