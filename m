Return-Path: <linux-pci+bounces-34163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DD0B297A4
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 06:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF95E196152B
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 04:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D61214228;
	Mon, 18 Aug 2025 04:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RftjdtLK"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108632066DE
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 04:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490034; cv=none; b=SAFCVhJqoG8J1bzs5T0qyodOSNJrzl7nZZrWpVm5LhuhtRLZP3HShXBdCE6fV9e6dbXTQnQ+jAG584NArEH2iEN33Q7ZRd3JOXsoYS7jemArzMHxvk3nuU7oUPwmq446eSAxvIFgCMDismynqBrdkIv+sw6wQBTXBUTSgyogzaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490034; c=relaxed/simple;
	bh=UhK3/h7zjxpWLOG+ZUmKO7GSfph+AtWarSJZHEm6tSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vy6MNDV/svGysgkDNjYyrMiVdm9BOd4gWHlIUMhyy2mlH+bPs5KcXXC4MWvtMTIBCbL9CcRa25vllaThvyho2pY40TPPlx0GzjJzz1fROedGdaQ2Jg//vVAamitBT88AJj5yw/HTRhqU08aPTrn9lqxSMW6HKcyS1Wd5/LtVt44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RftjdtLK; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755490021; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jyE5TcjJDv7rrpurDbRa3duhU7P1XhjP7PJm2SP9BaQ=;
	b=RftjdtLKczbIV//H30JR9hLiaNkHBH+6tCWh+bufk5QI61mUWATDBavIPP/vDp7xSMurwvUyq+6Rco1OliuZe2RET6SfFA/CJz2fjMb+WpTT65rdpMkfymQTtXG5Pvtyrwqk4v6dSOtzPmv6QgNEsjFRGYGdqMFwkyrtLX97fBY=
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0WlvFQK8_1755490001 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 Aug 2025 12:07:01 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: bhelgaas@google.com
Cc: alikernel-developer@linux.alibaba.com,
	linux-pci@vger.kernel.org
Subject: [PATCH] [RFC] PCI: fix pcie secondary bus reset readiness check
Date: Mon, 18 Aug 2025 12:06:40 +0800
Message-ID: <20250818040641.3848174-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When executing a secondary bus reset on a bridge downstream port, all
downstream devices and switches will be reseted. Before
pci_bridge_secondary_bus_reset returns, ensure that all available
devices have completed reset and initialization. Otherwise, using a
device before initialization completed will result in errors or even
device offline.

Note: If this modification is resonable, I will modify
the patch to address issues such as the long-term lock
occupation of pci_walk_bus.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/pci/pci.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b0f4d98036cd..c1544f650719 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4839,6 +4839,18 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
 	return max(min_delay, max_delay);
 }
 
+struct pci_bridge_rst {
+	int ret;
+	int timeout;
+	char *reset_type;
+};
+
+static int pci_bridge_rst_wait_dev(struct pci_dev *dev, void *data)
+{
+	struct pci_bridge_rst *d = data;
+	return d->ret = pci_dev_wait(dev, d->reset_type, d->timeout);
+}
+
 /**
  * pci_bridge_wait_for_secondary_bus - Wait for secondary bus to be accessible
  * @dev: PCI bridge
@@ -4857,8 +4869,8 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
  */
 int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 {
-	struct pci_dev *child __free(pci_dev_put) = NULL;
 	int delay;
+	struct pci_bridge_rst data = {.reset_type = reset_type};
 
 	if (pci_dev_is_disconnected(dev))
 		return 0;
@@ -4885,9 +4897,6 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		up_read(&pci_bus_sem);
 		return 0;
 	}
-
-	child = pci_dev_get(list_first_entry(&dev->subordinate->devices,
-					     struct pci_dev, bus_list));
 	up_read(&pci_bus_sem);
 
 	/*
@@ -4924,7 +4933,9 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
 		msleep(delay);
 
-		if (!pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay))
+		data.timeout = PCI_RESET_WAIT - delay;
+		pci_walk_bus(dev->subordinate, pci_bridge_rst_wait_dev, &data);
+		if (!data.ret)
 			return 0;
 
 		/*
@@ -4939,8 +4950,9 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		if (!(status & PCI_EXP_LNKSTA_DLLLA))
 			return -ENOTTY;
 
-		return pci_dev_wait(child, reset_type,
-				    PCIE_RESET_READY_POLL_MS - PCI_RESET_WAIT);
+		data.timeout = PCIE_RESET_READY_POLL_MS - PCI_RESET_WAIT;
+		pci_walk_bus(dev->subordinate, pci_bridge_rst_wait_dev, &data);
+		return data.ret;
 	}
 
 	pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
@@ -4951,8 +4963,9 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		return -ENOTTY;
 	}
 
-	return pci_dev_wait(child, reset_type,
-			    PCIE_RESET_READY_POLL_MS - delay);
+	data.timeout = PCIE_RESET_READY_POLL_MS - delay;
+	pci_walk_bus(dev->subordinate, pci_bridge_rst_wait_dev, &data);
+	return data.ret;
 }
 
 void pci_reset_secondary_bus(struct pci_dev *dev)
-- 
2.32.0.3.gf3a3e56d6


