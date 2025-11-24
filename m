Return-Path: <linux-pci+bounces-41939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C50C7FF97
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 11:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3ABA4E491D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 10:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A003A3BB5A;
	Mon, 24 Nov 2025 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LWf1/inz"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBF313B293
	for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763981152; cv=none; b=Bi8d331LjFwN4ZOsj03gII0cN5yAQYpqpeyMgXXWef4z/IiL85rwlJCEu0ppTA37ULdoWYOZZmSQB2FZFRbruroXNv9yVvkA3oAIHqruqDk88vCY2Ciqe93pTVDU8PtTq9IgPJlfV/CkuGxMpvIEzadpjft4IzHCKj06yoQE1eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763981152; c=relaxed/simple;
	bh=mGcJzXbvFAxvIaVrr+GrVCAhnZt6N+STzLh9LS334iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DNt6emHVlPM3cy8uNE+M7ObYOOOLip5VEJ66a+LAq9yL8HadTrzqSDeBU2Mkg7/9ROMY+dnrE6uwLt6LLbtLPfihxue6m3KnV00Ak0KVqiOSDeePb0FeUjOOMX5glyUD2sfzR2YttIxFiREkYcXDa++kRg7PGSC/6o33vJsjUt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LWf1/inz; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763981140; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=f7Nqovs7B25tg0kKflDnjZBtwraGNgJP+p88vtqQyuI=;
	b=LWf1/inzy3ajO6iKn2R5/XjLmYJjE2ShJxNXz/P3cAPmltrQBkWq66qj1TE9EDNt4faxiaSMb5PlRZIsfFdDttn5Xn9s7afWKMtEJ+2RN2ydIiKJsfbgcYiaD7KP17SkVn0bLNPqgOhmzUaMS7hvLdzkmcVAAL4N5PrFxvSrn+k=
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0WtEg8AN_1763981102 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 24 Nov 2025 18:45:39 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	kanie@linux.alibaba.com,
	alikernel-developer@linux.alibaba.com
Subject: [PATCH] PCI: Fix PCIe SBR dev/link wait error
Date: Mon, 24 Nov 2025 18:45:02 +0800
Message-ID: <20251124104502.777141-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
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
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/pci/pci.c | 112 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 94 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006c..9cf13fe69d94 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4788,9 +4788,74 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
 	return max(min_delay, max_delay);
 }
 
+int __pci_bridge_wait_for_secondary_bus(struct pci_dev *, unsigned long, char *);
+
+static int pci_dev_wait_child(struct pci_dev *pdev, unsigned long start_t, int timeout,
+				char *reset_type)
+{
+	struct pci_dev *child, **dev = NULL;
+	int ct = 0, i = 0, ret = 0, left = 1;
+	unsigned long dev_start_t;
+
+	down_read(&pci_bus_sem);
+
+	list_for_each_entry(child, &pdev->subordinate->devices, bus_list)
+		ct++;
+
+	if (ct) {
+		dev = kzalloc(sizeof(struct pci_dev *) * ct, GFP_KERNEL);
+
+		if(!dev) {
+			pci_err(pdev, "dev mem alloc err\n");
+			up_read(&pci_bus_sem);
+			return -ENOMEM;
+		}
+
+		list_for_each_entry(child, &pdev->subordinate->devices, bus_list)
+			dev[i++] = pci_dev_get(child);
+	}
+
+	up_read(&pci_bus_sem);
+
+	for (i = 0; i < ct; ++i) {
+		left = 1;
+
+dev_wait:
+		dev_start_t = jiffies;
+		ret = pci_dev_wait(dev[i], reset_type, left);
+		timeout -= jiffies_to_msecs(jiffies - dev_start_t);
+
+		if (ret) {
+			if (pci_dev_is_disconnected(dev[i]))
+				continue;
+
+			if (timeout <= 0)
+				goto end;
+
+			left <<= 1;
+			left = timeout > left ? left : timeout;
+			goto dev_wait;
+		}
+	}
+
+	for (i = 0; i < ct; ++i) {
+		ret = __pci_bridge_wait_for_secondary_bus(dev[i], start_t, reset_type);
+		if (ret)
+			break;
+	}
+
+end:
+	for (i = 0; i < ct; ++i)
+		pci_dev_put(dev[i]);
+
+	kfree(dev);
+	return ret;
+}
+
 /**
- * pci_bridge_wait_for_secondary_bus - Wait for secondary bus to be accessible
+ * __pci_bridge_wait_for_secondary_bus - Wait for secondary bus to be accessible
  * @dev: PCI bridge
+ * @start_t: wait start jiffies time
  * @reset_type: reset type in human-readable form
  *
  * Handle necessary delays before access to the devices on the secondary
@@ -4804,10 +4869,9 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
  * Return 0 on success or -ENOTTY if the first device on the secondary bus
  * failed to become accessible.
  */
-int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
+int __pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, unsigned long start_t, char *reset_type)
 {
-	struct pci_dev *child __free(pci_dev_put) = NULL;
-	int delay;
+	int delay, left;
 
 	if (pci_dev_is_disconnected(dev))
 		return 0;
@@ -4835,8 +4899,6 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		return 0;
 	}
 
-	child = pci_dev_get(list_first_entry(&dev->subordinate->devices,
-					     struct pci_dev, bus_list));
 	up_read(&pci_bus_sem);
 
 	/*
@@ -4844,8 +4906,12 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 	 * accessing the device after reset (that is 1000 ms + 100 ms).
 	 */
 	if (!pci_is_pcie(dev)) {
-		pci_dbg(dev, "waiting %d ms for secondary bus\n", 1000 + delay);
-		msleep(1000 + delay);
+		left = 1000 + delay - jiffies_to_msecs(jiffies - start_t);
+		pci_dbg(dev, "waiting %d ms for secondary bus\n", left > 0 ? left : 0);
+
+		if (left > 0)
+			msleep(left);
+
 		return 0;
 	}
 
@@ -4870,10 +4936,14 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
 		u16 status;
 
-		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
-		msleep(delay);
+		left = delay - jiffies_to_msecs(jiffies - start_t);
+		pci_dbg(dev, "waiting %d ms for downstream link\n", left > 0 ? left : 0);
+
+		if (left > 0)
+			msleep(left);
 
-		if (!pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay))
+		left = PCI_RESET_WAIT - jiffies_to_msecs(jiffies - start_t);
+		if(!pci_dev_wait_child(dev, start_t, left > 0 ? left : 0, reset_type))
 			return 0;
 
 		/*
@@ -4888,20 +4958,26 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		if (!(status & PCI_EXP_LNKSTA_DLLLA))
 			return -ENOTTY;
 
-		return pci_dev_wait(child, reset_type,
-				    PCIE_RESET_READY_POLL_MS - PCI_RESET_WAIT);
+		left = PCIE_RESET_READY_POLL_MS - jiffies_to_msecs(jiffies - start_t);
+		return pci_dev_wait_child(dev, start_t, left > 0 ? left : 0, reset_type);
 	}
 
-	pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
-		delay);
-	if (!pcie_wait_for_link_delay(dev, true, delay)) {
+	left = delay - jiffies_to_msecs(jiffies - start_t);
+	pci_dbg(dev, "waiting %d ms for downstream link, after activation\n", left > 0 ? left : 0);
+
+	if (!pcie_wait_for_link_delay(dev, true, left > 0 ? left : 0)) {
 		/* Did not train, no need to wait any further */
 		pci_info(dev, "Data Link Layer Link Active not set in %d msec\n", delay);
 		return -ENOTTY;
 	}
 
-	return pci_dev_wait(child, reset_type,
-			    PCIE_RESET_READY_POLL_MS - delay);
+	left = PCIE_RESET_READY_POLL_MS - jiffies_to_msecs(jiffies - start_t);
+	return pci_dev_wait_child(dev, start_t, left > 0 ? left : 0, reset_type);
+}
+
+int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
+{
+	return __pci_bridge_wait_for_secondary_bus(dev, jiffies, reset_type);
 }
 
 void pci_reset_secondary_bus(struct pci_dev *dev)
-- 
2.32.0.3.gf3a3e56d6


