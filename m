Return-Path: <linux-pci+bounces-10611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303C29391A8
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 17:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5400B1C21796
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 15:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B56E16DEDE;
	Mon, 22 Jul 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="X46N9wrm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3790D16DEBC
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661628; cv=none; b=OtQNkpQm1AYncE9BtIcnBd+eUROwQHNkY2QQzskYmHSNGbYNcsTbJy0hkGJ+02fWw4PbVTEwqv3Zgsib3h+0en05GNINXO4xu88otQ2kO9uTCESTR41CtMprDPy/eIgm5Is27I5cisU564WHktOW86Puubw1QGWQ/35n+VSjSzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661628; c=relaxed/simple;
	bh=CbIC3Ep1eJsFwJsMoISVLSfKq4jtt2YjK21sP/fF6Yk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=csn8cxMxkn9mH6c+dBxiRMc3irmZj7kV9vcvX+V2xiabUTYKkntCFI2zYQEbdL1sUmuIcOmYJfLGH8P23rQAUs+kFiq3xVrE34FMysUqVzJnQ9ZJHwaiFG6f6MdbYalKc70cK1zU5vJYMKJVZQtzyz36cZTNBKAszG2JgDQcShI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=X46N9wrm; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MF5rF5016663
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 08:20:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=R5rA4qIyVXkrdYPh9Ahh2EG2hClhHv6Ye9qjswMa/Sk=; b=
	X46N9wrmLYtJE35gLFU0mbTYHMNa39hNxjpM2TUFE7cmO6jIXOyRCKLpHJCre+qX
	2C/ZKle3vnV0QSh4CcLCr3g88Vrn78aihIfTtHTAPLEVZse1q8bkcBgnz7iXbwiR
	8OEaZ5KUX3Lu7lGHCGFhrmPQ/RMMpbwShVnAd/S6M1wbfdRs+gjlEg48E01U3MsL
	Z8TsVPqlpZ7uCqClXxIgT7nGg4z5QSypbEZjTvBqE6WyfydB3NCgI+2RHYu2Gh2t
	nY2Os7hJvn3XexUeI/YRtvXNJR7ryCMcuH2P8sVjNE5pmvnPTcusuzLK/+6feqaE
	I9TSzbr+KSVLIjvbMk4fJw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40garwr95w-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 08:20:23 -0700 (PDT)
Received: from twshared5319.37.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 22 Jul 2024 15:20:21 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 5A06710DA2DAC; Mon, 22 Jul 2024 08:20:07 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, <lukas@wunner.de>
CC: <mika.westerberg@linux.intel.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH RFC 8/8] pci: use finer grain locking for bus protection
Date: Mon, 22 Jul 2024 08:19:36 -0700
Message-ID: <20240722151936.1452299-9-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240722151936.1452299-1-kbusch@meta.com>
References: <20240722151936.1452299-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Lau465Mgo1yZ_1eNJgmcsXl3-aBOjkWD
X-Proofpoint-ORIG-GUID: Lau465Mgo1yZ_1eNJgmcsXl3-aBOjkWD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

The global rescan_remove lock has deadlocks during concurrent removals
because it is used within interrupt handlers. Use a bus specific lock
instead.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/bus.c                | 11 ++++++++---
 drivers/pci/hotplug/pciehp_pci.c | 11 ++++++-----
 drivers/pci/pci-sysfs.c          |  2 ++
 drivers/pci/pci.c                |  5 ++++-
 drivers/pci/probe.c              |  9 +++++++++
 drivers/pci/remove.c             | 10 ++++++++++
 include/linux/pci.h              | 11 +++++++++++
 7 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 3085ecaa2ba40..d80a9e4f39d38 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -384,8 +384,11 @@ void pci_bus_add_devices(const struct pci_bus *bus)
 			continue;
=20
 		child =3D pci_dev_get_subordinate(dev);
-		if (child)
+		if (child) {
+			pci_lock_bus(child);
 			pci_bus_add_devices(child);
+			pci_unlock_bus(child);
+		}
 		pci_bus_put(child);
 	}
 }
@@ -406,7 +409,9 @@ static int __pci_walk_bus(struct pci_bus *top, int (*=
cb)(struct pci_dev *, void
=20
 		bus =3D pci_dev_get_subordinate(dev);
 		if (bus) {
+			pci_lock_bus(bus);
 			ret =3D __pci_walk_bus(bus, cb, userdata);
+			pci_unlock_bus(bus);
 			pci_bus_put(bus);
 			if (ret)
 				break;
@@ -430,9 +435,9 @@ static int __pci_walk_bus(struct pci_bus *top, int (*=
cb)(struct pci_dev *, void
  */
 void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void =
*), void *userdata)
 {
-	down_read(&pci_bus_sem);
+	pci_lock_bus(top);
 	__pci_walk_bus(top, cb, userdata);
-	up_read(&pci_bus_sem);
+	pci_unlock_bus(top);
 }
 EXPORT_SYMBOL_GPL(pci_walk_bus);
=20
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pcieh=
p_pci.c
index b15dcfd86c60a..f6260f1085d81 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -39,8 +39,7 @@ int pciehp_configure_device(struct controller *ctrl)
 	if (!parent)
 		return 0;
=20
-	pci_lock_rescan_remove();
-
+	pci_lock_bus(parent);
 	dev =3D pci_get_slot(parent, PCI_DEVFN(0, 0));
 	if (dev) {
 		/*
@@ -63,6 +62,7 @@ int pciehp_configure_device(struct controller *ctrl)
=20
 	for_each_pci_bridge(dev, parent)
 		pci_hp_add_bridge(dev);
+	pci_unlock_bus(parent);
=20
 	pci_assign_unassigned_bridge_resources(bridge);
 	pcie_bus_configure_settings(parent);
@@ -72,6 +72,7 @@ int pciehp_configure_device(struct controller *ctrl)
 	 * to avoid AB-BA deadlock with device_lock.
 	 */
 	up_read(&ctrl->reset_lock);
+	pci_lock_bus(parent);
 	pci_bus_add_devices(parent);
 	down_read_nested(&ctrl->reset_lock, ctrl->depth);
=20
@@ -80,7 +81,7 @@ int pciehp_configure_device(struct controller *ctrl)
 	pci_dev_put(dev);
=20
  out:
-	pci_unlock_rescan_remove();
+	pci_unlock_bus(parent);
 	pci_bus_put(parent);
 	return ret;
 }
@@ -111,7 +112,7 @@ void pciehp_unconfigure_device(struct controller *ctr=
l, bool presence)
 	if (!presence)
 		pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
=20
-	pci_lock_rescan_remove();
+	pci_lock_bus(parent);
=20
 	/*
 	 * Stopping an SR-IOV PF device removes all the associated VFs,
@@ -144,6 +145,6 @@ void pciehp_unconfigure_device(struct controller *ctr=
l, bool presence)
 		pci_dev_put(dev);
 	}
=20
-	pci_unlock_rescan_remove();
+	pci_unlock_bus(parent);
 	pci_bus_put(parent);
 }
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 40cfa716392fb..0853c931b3c7d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -487,8 +487,10 @@ static ssize_t remove_store(struct device *dev, stru=
ct device_attribute *attr,
 	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
=20
+	get_device(dev);
 	if (val && device_remove_file_self(dev, attr))
 		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
+	put_device(dev);
 	return count;
 }
 static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL,
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0cd36b7772c8b..7e5f05b155658 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3117,7 +3117,10 @@ void pci_bridge_d3_update(struct pci_dev *dev)
 		struct pci_bus *bus =3D pci_dev_get_subordinate(bridge);
=20
 		if (bus) {
-			pci_walk_bus(bus, pci_dev_check_d3cold, &d3cold_ok);
+			down_read(&pci_bus_sem);
+			pci_walk_bus_locked(bus, pci_dev_check_d3cold,
+					    &d3cold_ok);
+			up_read(&pci_bus_sem);
 			pci_bus_put(bus);
 		}
 	}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 53522685193da..9c1589be9c390 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -563,6 +563,7 @@ static struct pci_bus *pci_alloc_bus(struct pci_bus *=
parent)
 	if (!b)
 		return NULL;
=20
+	mutex_init(&b->lock);
 	INIT_LIST_HEAD(&b->node);
 	INIT_LIST_HEAD(&b->children);
 	INIT_LIST_HEAD(&b->devices);
@@ -1359,7 +1360,9 @@ static int pci_scan_bridge_extend(struct pci_bus *b=
us, struct pci_dev *dev,
 		}
=20
 		buses =3D subordinate - secondary;
+		pci_lock_bus(child);
 		cmax =3D pci_scan_child_bus_extend(child, buses);
+		pci_unlock_bus(child);
 		if (cmax > subordinate)
 			pci_warn(dev, "bridge has subordinate %02x but max busn %02x\n",
 				 subordinate, cmax);
@@ -3109,7 +3112,9 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 	list_for_each_entry(child, &bus->children, node)
 		pcie_bus_configure_settings(child);
=20
+	pci_lock_bus(bus);
 	pci_bus_add_devices(bus);
+	pci_unlock_bus(bus);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_host_probe);
@@ -3284,11 +3289,13 @@ unsigned int pci_rescan_bus_bridge_resize(struct =
pci_dev *bridge)
 	unsigned int max;
 	struct pci_bus *bus =3D bridge->subordinate;
=20
+	pci_lock_bus(bus);
 	max =3D pci_scan_child_bus(bus);
=20
 	pci_assign_unassigned_bridge_resources(bridge);
=20
 	pci_bus_add_devices(bus);
+	pci_unlock_bus(bus);
=20
 	return max;
 }
@@ -3306,9 +3313,11 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 {
 	unsigned int max;
=20
+	pci_lock_bus(bus);
 	max =3D pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
 	pci_bus_add_devices(bus);
+	pci_unlock_bus(bus);
=20
 	return max;
 }
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 646c97e41a323..cf641a80a7f21 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -52,8 +52,10 @@ static void pci_clear_bus(struct pci_bus *bus)
 {
 	struct pci_dev *dev, *next;
=20
+	pci_lock_bus(bus);
 	list_for_each_entry_safe(dev, next, &bus->devices, bus_list)
 		pci_remove_bus_device(dev);
+	pci_unlock_bus(bus);
 }
=20
 void pci_remove_bus(struct pci_bus *bus)
@@ -96,8 +98,10 @@ static void pci_stop_bus(struct pci_bus *bus)
 	 * iterator.  Therefore, iterate in reverse so we remove the VFs
 	 * first, then the PF.
 	 */
+	pci_lock_bus(bus);
 	list_for_each_entry_safe_reverse(dev, next, &bus->devices, bus_list)
 		pci_stop_bus_device(dev);
+	pci_unlock_bus(bus);
 }
=20
 static void pci_remove_bus_device(struct pci_dev *dev)
@@ -138,9 +142,15 @@ EXPORT_SYMBOL(pci_stop_and_remove_bus_device);
=20
 void pci_stop_and_remove_bus_device_locked(struct pci_dev *dev)
 {
+	struct pci_bus *bus =3D pci_bus_get(dev->bus);
+
 	pci_lock_rescan_remove();
+	pci_lock_bus(bus);
 	pci_stop_and_remove_bus_device(dev);
+	pci_unlock_bus(bus);
 	pci_unlock_rescan_remove();
+
+	pci_bus_put(bus);
 }
 EXPORT_SYMBOL_GPL(pci_stop_and_remove_bus_device_locked);
=20
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9e36b6c1810ea..6b37373b831ec 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -649,6 +649,7 @@ struct pci_bus {
 	struct list_head node;		/* Node in list of buses */
 	struct pci_bus	*parent;	/* Parent bus this bridge is on */
 	struct list_head children;	/* List of child buses */
+	struct mutex	lock;		/* Lock for devices */
 	struct list_head devices;	/* List of devices on this bus */
 	struct pci_dev	*self;		/* Bridge device as seen by parent */
 	struct list_head slots;		/* List of slots on this bus;
@@ -681,6 +682,16 @@ struct pci_bus {
 	unsigned int		unsafe_warn:1;	/* warned about RW1C config write */
 };
=20
+static inline void pci_lock_bus(struct pci_bus *bus)
+{
+	mutex_lock_nested(&bus->lock, bus->number);
+}
+
+static inline void pci_unlock_bus(struct pci_bus *bus)
+{
+	mutex_unlock(&bus->lock);
+}
+
 #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
=20
 static inline u16 pci_dev_id(struct pci_dev *dev)
--=20
2.43.0


