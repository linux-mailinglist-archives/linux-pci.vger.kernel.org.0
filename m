Return-Path: <linux-pci+bounces-42433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08E4C9A02E
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 05:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2703A52F8
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 04:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE3D1D618E;
	Tue,  2 Dec 2025 04:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ixj5P9C6"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446C11A23A6
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 04:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764649946; cv=none; b=j7PSdfhjv39VD87NXFfZFYX4SC0j/QhLZkIJgYXE5CU3pkBzyWI8MAlzKRRv0vmnXN1J74P8G1rHZTRUcJGW1hbbeddl2KPsMJ8n1MkUepmRJG+gfWYAhzh42jt+KKMMCxj7MK2NxCyuqi7mHWy/hIv7a1PTivZHgUfvN8b2VBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764649946; c=relaxed/simple;
	bh=Kj7hWsdAis1KwIFgGWjWH6We7WMDDLF4AY4+G8fzcNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhwnBi8/rPizRejRzomQ3TWx8cg4kerpyoyXBYtdRD+eTwqJvAfk9yeISRS7CQ3Wk/QwJ660EXJbZsCBm4pTv+1trAGi/Am78IKYTHlHj5o0jla7x8BdsOs4Z63J/Oc914CD8dBoJ3dkhsN9Wfr6mRVVJaU+pqLDpFYzylvjLRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ixj5P9C6; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764649940; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wluPgiVNcPw138dWo0O3QKrhq1dSsVltZX1fH9uX2m4=;
	b=ixj5P9C6SI8YKRbJn6UOvOOWVo+qF7fLrVnRl8ejkMs8cXTAUXfmsyR4yRwZ1yAy1iF38sEBpUhP5k1ZFNtmM7LDPpQNPmQo9sBVmey/kwvPHtU2csAlfzSzc4TUnT6ieKbGGmZeywfbrBur+++okRGncAg5mBGjpqNLfd0h86M=
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0WtuzBGr_1764649940 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Dec 2025 12:32:20 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-pci@vger.kernel.org,
	alikernel-developer@linux.alibaba.com
Subject: [PATCH v4 v4 1/1] PCI: Fix PCIe SBR dev/link wait error
Date: Tue,  2 Dec 2025 12:32:07 +0800
Message-ID: <20251202043207.3924714-2-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251202043207.3924714-1-guanghuifeng@linux.alibaba.com>
References: <d285f1b6-8758-efd3-da0e-6448033519fc@linux.intel.com>
 <20251202043207.3924714-1-guanghuifeng@linux.alibaba.com>
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
 drivers/pci/pci.c | 143 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 103 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006c..9cf0e58ef23f 100644
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
 
@@ -4867,41 +4926,47 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
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
+		if (ret == 0 && child->subordinate) {
+			pci_restore_config_space(child);
+			ret = __pci_bridge_wait_for_secondary_bus(child, start_t, reset_type);
+		}
 
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
@@ -5542,10 +5607,8 @@ static void pci_bus_restore_locked(struct pci_bus *bus)
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		pci_dev_restore(dev);
-		if (dev->subordinate) {
-			pci_bridge_wait_for_secondary_bus(dev, "bus reset");
+		if (dev->subordinate)
 			pci_bus_restore_locked(dev->subordinate);
-		}
 	}
 }
 
@@ -5575,14 +5638,14 @@ static void pci_slot_restore_locked(struct pci_slot *slot)
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


