Return-Path: <linux-pci+bounces-14844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3B89A3482
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 07:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEDFF284386
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 05:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECCB18990E;
	Fri, 18 Oct 2024 05:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i8RDq8sV"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF42184539
	for <linux-pci@vger.kernel.org>; Fri, 18 Oct 2024 05:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230467; cv=none; b=KnAXLzMsCBk2tmjJ4AvfQG+gSQhOvSiHOpXGL414VB8cnn5gTX6XFW9oSPjpVDbadxsLdEv8CQLNGJKoZC+3bIkrSo1SumR8wifGZAkdjzrbWdf6nSu1PWJS1qEnxBrVFbroKYv0otlOtk3EZUhZzKkCczo0ZKGUYJR8TCmAhY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230467; c=relaxed/simple;
	bh=0dSvMewFPD9jOFYK3y5c70FiHD94zbH2XswbYaVb5TU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sFz47Nr6x4O1+Zd+PvdsuO6uSaEZcwpdfi/yqGrsK4SN2mUKbWkyuHtKvPV3Czwb9yjus7MBPQvFxGnyUeDpnrJ1eC+JXSz1ynqEH3e+OxR+eSqhRHQColYJXhduNkajP4oZ5nhNO1Y9xYoKEmV8jcpGzZ8XmIw8wLLozmInvLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i8RDq8sV; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729230456; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YCRRfn64TyhiJ9BbpETpfVNxQVYNYTBCVt2ml02eqxw=;
	b=i8RDq8sVrtMQJI0uyafDpp4wibcv10uswbnZ2C9RUaObKUGpTlSSJkoRBmjrFk4zv9x0M7qgKJKG5MnikMFkaQ8cZcLdvs7z7kMXpe2H8Cm1d7Cpdz3zryfATMIOv19bQdDTc7x4/+CM8FvWsh+jz502MaZ69pyPIozFl5HrTfs=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WHN31m-_1729230448 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Oct 2024 13:47:35 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org
Subject: [PATCH] PCI: optimize proc sequential file read
Date: Fri, 18 Oct 2024 13:47:28 +0800
Message-ID: <20241018054728.116519-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI driver will traverse pci device list in pci_seq_start in every
sequential file reading, use xarry to store all pci devices to
accelerate finding the start.

Use "time cat /proc/bus/pci/devices" to test on a machine with 13k
pci devices,  get an increase of about 90%.

Without this patch:
  real 0m0.917s
  user 0m0.000s
  sys  0m0.913s
With this patch:
  real 0m0.093s
  user 0m0.000s
  sys  0m0.093s

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/pci/pci.h    |  3 +++
 drivers/pci/probe.c  |  1 +
 drivers/pci/proc.c   | 64 +++++++++++++++++++++++++++++++++++++++-----
 drivers/pci/remove.c |  1 +
 include/linux/pci.h  |  2 ++
 5 files changed, 64 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 14d00ce45bfa..1a7da91eeb80 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -962,4 +962,7 @@ void pcim_release_region(struct pci_dev *pdev, int bar);
 	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
 	 PCI_CONF1_EXT_REG(reg))
 
+void pci_seq_tree_add_dev(struct pci_dev *dev);
+void pci_seq_tree_remove_dev(struct pci_dev *dev);
+
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4f68414c3086..1fd9e9022f70 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2592,6 +2592,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	WARN_ON(ret < 0);
 
 	pci_npem_create(dev);
+	pci_seq_tree_add_dev(dev);
 }
 
 struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index f967709082d6..30ca071ccad5 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -19,6 +19,9 @@
 
 static int proc_initialized;	/* = 0 */
 
+DEFINE_XARRAY_FLAGS(pci_seq_tree, 0);
+static unsigned long pci_max_idx;
+
 static loff_t proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
 {
 	struct pci_dev *dev = pde_data(file_inode(file));
@@ -334,25 +337,72 @@ static const struct proc_ops proc_bus_pci_ops = {
 #endif /* HAVE_PCI_MMAP */
 };
 
+void pci_seq_tree_add_dev(struct pci_dev *dev)
+{
+	int ret;
+
+	if (dev) {
+		xa_lock(&pci_seq_tree);
+		pci_dev_get(dev);
+		ret = __xa_insert(&pci_seq_tree, pci_max_idx, dev, GFP_KERNEL);
+		if (!ret) {
+			dev->proc_seq_idx = pci_max_idx;
+			pci_max_idx++;
+		} else {
+			pci_dev_put(dev);
+			WARN_ON(ret);
+		}
+		xa_unlock(&pci_seq_tree);
+	}
+}
+
+void pci_seq_tree_remove_dev(struct pci_dev *dev)
+{
+	unsigned long idx = dev->proc_seq_idx;
+	struct pci_dev *latest_dev = NULL;
+	struct pci_dev *ret;
+
+	if (!dev)
+		return;
+
+	xa_lock(&pci_seq_tree);
+	__xa_erase(&pci_seq_tree, idx);
+	pci_dev_put(dev);
+	/*
+	 * Move the latest pci_dev to this idx to keep the continuity.
+	 */
+	if (idx != pci_max_idx - 1) {
+		latest_dev = __xa_erase(&pci_seq_tree, pci_max_idx - 1);
+		ret = __xa_cmpxchg(&pci_seq_tree, idx, NULL, latest_dev,
+				GFP_KERNEL);
+		if (!ret)
+			latest_dev->proc_seq_idx = idx;
+		WARN_ON(ret);
+	}
+	pci_max_idx--;
+	xa_unlock(&pci_seq_tree);
+}
+
 /* iterator */
 static void *pci_seq_start(struct seq_file *m, loff_t *pos)
 {
-	struct pci_dev *dev = NULL;
+	struct pci_dev *dev;
 	loff_t n = *pos;
 
-	for_each_pci_dev(dev) {
-		if (!n--)
-			break;
-	}
+	dev = xa_load(&pci_seq_tree, n);
+	if (dev)
+		pci_dev_get(dev);
 	return dev;
 }
 
 static void *pci_seq_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct pci_dev *dev = v;
+	struct pci_dev *dev;
 
 	(*pos)++;
-	dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev);
+	dev = xa_load(&pci_seq_tree, *pos);
+	if (dev)
+		pci_dev_get(dev);
 	return dev;
 }
 
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index e4ce1145aa3e..257ea46233a3 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -53,6 +53,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	pci_npem_remove(dev);
 
 	device_del(&dev->dev);
+	pci_seq_tree_remove_dev(dev);
 
 	down_write(&pci_bus_sem);
 	list_del(&dev->bus_list);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..aeb3d4cce06a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -534,6 +534,8 @@ struct pci_dev {
 
 	/* These methods index pci_reset_fn_methods[] */
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
+
+	unsigned long long	proc_seq_idx;
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
-- 
2.43.0


