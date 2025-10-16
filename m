Return-Path: <linux-pci+bounces-38392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E33BE53E2
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 21:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A35E19A8108
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 19:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EDD14F112;
	Thu, 16 Oct 2025 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="uZq9Qapi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0911C5D55
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760643066; cv=none; b=MnzePxGIa9WeaDtfS7Hujn7b0N8w4wDcKdDbNf/ffN2HE++w/mkNO5VEDYOPCgs2RkeE+GniYagYNwVQhbufd1+Fgey/JokalkvfBiMygjB6NwCLHTgA1BUK1n/piO13aKKOJxuqdsUU6dsf9get2iK5kjV0SrUAGaLhIhHRjd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760643066; c=relaxed/simple;
	bh=zH9HOlWjU+ZkV2mwOf4m5ZjDI4glIW8ggCbOZQhuAco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+gmQcp8uW7ZG/JSomGc80pMNDiMXCOaYW5k8aZVb95rUDRurJGynKPX7jVYU0TTDrtKGxc8rnSRw/5Mqz8Xtj0aS3gMucWlaD55AwE3000WZ3bwQyBP2+L/lzZ2hsEjPvjiVOJe7B4DeSlDwu4cPd8U8dJm8oMNexCehrgeN9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=uZq9Qapi; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GHJA8b2165308
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 12:31:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=GsEkmQBYIY/k4TYXak6wlAYJkZSf4/mEOJ896+tPpoQ=; b=uZq9QapiJ9N0
	USW6PwUNy1NgHwQaGIeJuSuFPAO9VHw2T2j+KmY6tgBiYFR6834SfzhWNTin5z1z
	+gNQSnwUFGpaqO9Q7xW/5hOdW/u4+dnNGbTb0hPzdBU0YQHxmseJxGW4CW9Irdvf
	tSCCYzlSuKYXbsoFKUKN5jYB1bAnRuA5AtIAzPUPg80Xcf2QCXMUrMD66U5TfL3U
	hbshZNoZlZtBPE52wguBfkv1PubfJQcrjZ+XOQbJ0WQvZaHMWAm4mbksQ53mhLS7
	At07K2mTYtiiS38LoWhmMSRT7DyzVnHakIkKgWTWGrVhMWwuhzEY8buMDCmHhK5C
	zau+RyCCwA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49u50j94pc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 12:31:02 -0700 (PDT)
Received: from twshared45213.02.ash8.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Thu, 16 Oct 2025 19:31:00 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 8A65F2C7C393; Thu, 16 Oct 2025 12:30:49 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <lukas@wunner.de>, <helgaas@kernel.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH RESEND 1/1] PCI: pciehp: fix concurrent sub-tree removal deadlock
Date: Thu, 16 Oct 2025 12:30:49 -0700
Message-ID: <20251016193049.881212-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016193049.881212-1-kbusch@meta.com>
References: <20251016193049.881212-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: aenSQiQtHVPqDCR1ocu8bJrab2c9ma7q
X-Authority-Analysis: v=2.4 cv=Xo73+FF9 c=1 sm=1 tr=0 ts=68f147f6 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=kRvNjBJkmpyK4WK12CgA:9
X-Proofpoint-ORIG-GUID: aenSQiQtHVPqDCR1ocu8bJrab2c9ma7q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDE0MyBTYWx0ZWRfX6AHhPJjyIFGv
 3uLN09UrfrAm1GhEbB7x1qu7BRltVg0tUfkWgeMvdokURmwA2dSO9jm3rD4T4mQO6wQ2oLaEbwl
 qzVe6vt5GjFaMLQwwfv40cb5Pgbo9FQmKG8vxYPhictICYb/6AxA3/1vUewgQJoCk2/ulnSN2VQ
 hy2wd7ZRVlnUKqTNyNJz5jdBhjikAYNrumE3Kx8JHL61gaGXdPMG8VaHfKCO1Wc8JaCr2onDewj
 7GrsgysarBtBoe4tnvWxUS/4ugiS8B4ZiBVGRdgUItCbxS02+N/g7YVvh2hsKwBwyZjTnVBtCRk
 fr/LeZRcC5yrfkhqi+t1IsXm2UdTrbp5aYpbRMIjODl+keXU1vJcvu1AqzBn7poG6FNv8sxvtGD
 SvQTjr3rJWqyap2wfVrsu3c7yLfKnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01

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
 drivers/pci/probe.c              | 25 +++++++++++++++++++++++++
 include/linux/pci.h              |  2 ++
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pcieh=
p_pci.c
index 65e50bee1a8c0..8ad4f8a931d0b 100644
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
@@ -97,6 +100,7 @@ void pciehp_unconfigure_device(struct controller *ctrl=
, bool presence)
 	struct pci_dev *dev, *temp;
 	struct pci_bus *parent =3D ctrl->pcie->port->subordinate;
 	u16 command;
+	int ret;
=20
 	ctrl_dbg(ctrl, "%s: domain:bus:dev =3D %04x:%02x:00\n",
 		 __func__, pci_domain_nr(parent), parent->number);
@@ -104,7 +108,9 @@ void pciehp_unconfigure_device(struct controller *ctr=
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
index 4492b809094b5..0b2f1f5f99ac7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -650,6 +650,7 @@ static inline int pci_dev_set_disconnected(struct pci=
_dev *dev, void *unused)
 {
 	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
 	pci_doe_disconnected(dev);
+	pci_notify_disconnected();
=20
 	return 0;
 }
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c83e75a0ec126..5086e23eb84d9 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3515,12 +3515,37 @@ void pci_lock_rescan_remove(void)
 }
 EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);
=20
+static DECLARE_WAIT_QUEUE_HEAD(pci_lock_wq);
+
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
index d1fdf81fbe1e4..059d99c31204f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1478,7 +1478,9 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev);
 /* Functions for PCI Hotplug drivers to use */
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
2.47.3


