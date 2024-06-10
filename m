Return-Path: <linux-pci+bounces-8561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CF7902B4A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 00:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7181C21EC2
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 22:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581DA149C43;
	Mon, 10 Jun 2024 22:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="XGvjy9qa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7F37143
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 22:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718057032; cv=none; b=H8Ia3H4mqGSQdxqVIz65Y+4ARJ8NiA+OeqWq5YMuEYhemF1+dPicfiqhwsur+fGPIVaTkS/vcTd7tgnWhJE+qVWG9iokKGvbrGTDOE1rX9i4RTDbai35gtKk95EvFN0GkVe33Eg5BzWb5Xk2lIqLf+O4L04hfY8ePRrxwYTfTrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718057032; c=relaxed/simple;
	bh=upJWzB5y+WwBoXyBVEkDp5NU5/ekpj+NnSoaraLFK5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hojn5ysN5IYt9rMxDS3lMWGHLXUMid5nKG5x0Nptsbn2gLAbpXmlQG8eFn4Pdv5SxcSExZkCf7dku9Fq1GgDdWNQ93jlYYz3wmxMr9DsXl4Kr9X7Psx8BWJZ5ARvQotKhBedevo6yleOUl/TbnfGbDvWuO05T7ZeFUVHU4yP5Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=XGvjy9qa; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45AL1L5m032183
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 15:03:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=s2048-2021-q4;
 bh=mVgzOYxy6HjgSL+ugaATrT8DTpKtRfESGqL9N3M6AHY=;
 b=XGvjy9qaPvkLXAPXrltz1c/XYlMfCgMcma4YHg74YnE+kFaWG1+y/gKPthMgXk1WQ/7v
 xY0AviavvGaTbxa3z/YiIeROjVM4qhHnbfYoHUX0pmgnbQvN80P6sB6ULFwBojfOp2em
 bhJ/9aNYQgANHwNU5xdjsvy3hX3vfk24TGCG7oG6egY4anxTimVt+UrIIqT2FiDBEDOF
 M9HDM41D7zAysf3lRbDqZ5j/o0wQYwa9YrFlOXqNirk5UI8qYhkyE7seoJQ7ZBKXS3z7
 9VNRlD3GiMxxNoSzWCZF5rCzs1UO/zOhqFzB4qOD2fXrAa4+9p8r/XL5YrtWBoVyiVZM WQ== 
Received: from mail.thefacebook.com ([163.114.134.6])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ymn203uqm-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 15:03:49 -0700
Received: from twshared56507.03.ash8.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 10 Jun 2024 22:03:46 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id C62F0F4E2354; Mon, 10 Jun 2024 15:03:34 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <lukas@wunner.de>, <bhelgaas@google.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/2] PCI: pciehp: fix concurrent sub-tree removal deadlock
Date: Mon, 10 Jun 2024 15:03:02 -0700
Message-ID: <20240610220304.3162895-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610220304.3162895-1-kbusch@meta.com>
References: <20240610220304.3162895-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: o_IdoxEA0iuTViV1vv2sdl-SjV0M1Qms
X-Proofpoint-GUID: o_IdoxEA0iuTViV1vv2sdl-SjV0M1Qms
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_06,2024-06-10_01,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

PCIe hotplug events modify the topology in their IRQ thread once it can
acquire the global pci_rescan_remove_lock.

If a different removal event happens to acquire that lock first, and
that removal event is for the parent device of the bridge processing the
other hotplug event, then we are deadlocked: the parent removal will
wait indefinitely on the child's IRQ thread because the parent is
holding the global lock the child thread needs to make forward progress.

Introduce a new locking function that aborts if the device is being
removed. The following are stack traces of the deadlock:

Task A:

  pciehp_unconfigure_device+0x41/0x120
  pciehp_disable_slot+0x3c/0xc0
  pciehp_handle_presence_or_link_change+0x28f/0x3e0
  pciehp_ist+0xc3/0x210
  irq_thread_fn+0x19/0x40

Task B:

  __synchronize_irq+0x5b/0x90
  free_irq+0x192/0x2e0
  pcie_shutdown_notification+0x3b/0x40
  pciehp_remove+0x23/0x50
  pcie_port_remove_service+0x2c/0x40
  device_release_driver_internal+0x11f/0x180
  bus_remove_device+0xc5/0x110
  device_del+0x126/0x340
  device_unregister+0x13/0x50
  remove_iter+0x17/0x20
  device_for_each_child+0x4a/0x70
  pcie_portdrv_remove+0x23/0x40
  pci_device_remove+0x24/0x60
  device_release_driver_internal+0x11f/0x180
  pci_stop_bus_device+0x57/0x80
  pci_stop_bus_device+0x2c/0x80
  pci_stop_and_remove_bus_device+0xe/0x20
  pciehp_unconfigure_device+0x76/0x120
  pciehp_disable_slot+0x3c/0xc0
  pciehp_handle_presence_or_link_change+0x28f/0x3e0
  pciehp_ist+0xc3/0x210
  irq_thread_fn+0x19/0x40

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/hotplug/pciehp_pci.c | 12 +++++++++---
 drivers/pci/pci.h                |  1 +
 drivers/pci/probe.c              | 24 ++++++++++++++++++++++++
 include/linux/pci.h              |  2 ++
 4 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pcieh=
p_pci.c
index ad12515a4a121..ca6237b0732c8 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -34,9 +34,12 @@ int pciehp_configure_device(struct controller *ctrl)
 	struct pci_dev *dev;
 	struct pci_dev *bridge =3D ctrl->pcie->port;
 	struct pci_bus *parent =3D bridge->subordinate;
-	int num, ret =3D 0;
+	int num, ret;
=20
-	pci_lock_rescan_remove();
+	ret =3D pci_trylock_rescan_remove(bridge);
+	if (!ret)
+		return -ENODEV;
+	ret =3D 0;
=20
 	dev =3D pci_get_slot(parent, PCI_DEVFN(0, 0));
 	if (dev) {
@@ -93,6 +96,7 @@ void pciehp_unconfigure_device(struct controller *ctrl,=
 bool presence)
 	struct pci_dev *dev, *temp;
 	struct pci_bus *parent =3D ctrl->pcie->port->subordinate;
 	u16 command;
+	int ret;
=20
 	ctrl_dbg(ctrl, "%s: domain:bus:dev =3D %04x:%02x:00\n",
 		 __func__, pci_domain_nr(parent), parent->number);
@@ -100,7 +104,9 @@ void pciehp_unconfigure_device(struct controller *ctr=
l, bool presence)
 	if (!presence)
 		pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
=20
-	pci_lock_rescan_remove();
+	ret =3D pci_trylock_rescan_remove(parent->self);
+	if (!ret)
+		return;
=20
 	/*
 	 * Stopping an SR-IOV PF device removes all the associated VFs,
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fd44565c47562..f525490a02122 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -370,6 +370,7 @@ static inline int pci_dev_set_disconnected(struct pci=
_dev *dev, void *unused)
 {
 	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
 	pci_doe_disconnected(dev);
+	pci_notify_disconnected();
=20
 	return 0;
 }
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5fbabb4e3425f..d2e19a1d1a45b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3302,6 +3302,7 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
  * routines should always be executed under this mutex.
  */
 static DEFINE_MUTEX(pci_rescan_remove_lock);
+static DECLARE_WAIT_QUEUE_HEAD(pci_lock_wq);
=20
 void pci_lock_rescan_remove(void)
 {
@@ -3309,12 +3310,35 @@ void pci_lock_rescan_remove(void)
 }
 EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);
=20
+/*
+ * pci_trylock_rescan_remove() - keep trying to take the lock until succ=
essful
+ *				 or notified the device is disconnected
+ *
+ * Returns 1 if the lock was successfully taken, 0 otherwise.
+ */
+bool pci_trylock_rescan_remove(struct pci_dev *dev)
+{
+	int ret;
+
+	wait_event(pci_lock_wq,
+		   (ret =3D mutex_trylock(&pci_rescan_remove_lock)) =3D=3D 1 ||
+		   pci_dev_is_disconnected(dev));
+
+	return ret;
+}
+
 void pci_unlock_rescan_remove(void)
 {
 	mutex_unlock(&pci_rescan_remove_lock);
+	wake_up_all(&pci_lock_wq);
 }
 EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove);
=20
+void pci_notify_disconnected(void)
+{
+	wake_up_all(&pci_lock_wq);
+}
+
 static int __init pci_sort_bf_cmp(const struct device *d_a,
 				  const struct device *d_b)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cafc5ab1cbcb4..b05aaf9aac6c8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1442,7 +1442,9 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev);
 unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge);
 unsigned int pci_rescan_bus(struct pci_bus *bus);
 void pci_lock_rescan_remove(void);
+bool pci_trylock_rescan_remove(struct pci_dev *dev);
 void pci_unlock_rescan_remove(void);
+void pci_notify_disconnected(void);
=20
 /* Vital Product Data routines */
 ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void=
 *buf);
--=20
2.43.0


