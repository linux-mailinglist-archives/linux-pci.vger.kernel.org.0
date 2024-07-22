Return-Path: <linux-pci+bounces-10613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B75A9391AA
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 17:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6181C213DB
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 15:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4030916DEBC;
	Mon, 22 Jul 2024 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hfBy+mTA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7542C1428F1
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661634; cv=none; b=GkubhlD6pFzW4dlCcaFZfQDALuKrWiiH6nwMDuS0LP6HGDHQvLnDbG/6fWobM5JUxVErb0Yz95xSFzfa3RI0alOLsQ+dp9YJqHpsDT4t4Q41/5VnYtck5jZAISMJkZWB+v4Dmimo1rBeE2JvK1vBs2OFlX1LAPMJ3eLrkT5x1iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661634; c=relaxed/simple;
	bh=thY+SX2aoVOF+1cRRvpQ2CmVbCGwRSQkik90WtAWRxc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLw/o4UBhFOcUAkqPfcD0AXas3lqRott+2L49I57Vf49KXC2ORqYSjkBHn7fB6K2fDVTBWisdY3zpFtZrjs8xc5eVBBhHj0iHK1K2QsiPQt9c9McdiN3MWcHYrVoxntJE/Blu41viNc+SG/mxsxJT8FKytMV9BMD0W7Aj33cXwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hfBy+mTA; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MF5rFH016663
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 08:20:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=OmbxJUSiKZV8crw5lgkUKEcjM2FOJvIH/duIHGGDutc=; b=
	hfBy+mTAeHgs2kKDQ04c6HYV65L4zjmK3ycHdiLfu8AutOW7PXpPxdpGdcFXGGR/
	z+Hcxmtylxswrom72fIaHtblN3nj2OUTnsjAF8dlwaOVah7i8fI439oVUvTjvRMT
	uwauL0Z/omBBcQdK9ytGg++5Bv3LugXl85KHx7RwZZNyR0vo3IcL2Dq7j1iPQJwQ
	pQEEDS/4MrhtmouzDHLJJCEXpIs6z6gP9MBzviZRUcHflhMpVLg0zLe1xgxpwuM5
	H9bH/Oy7+VHL7Vc9/1dWAOOHWlNnMhrtjsChR9OVUWOSh7wU6xsBqZGbK7ZyxBXa
	XJ6c5/IJSBXNJLI0zbv87g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40garwr95w-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2024 08:20:31 -0700 (PDT)
Received: from twshared5319.37.frc1.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 22 Jul 2024 15:20:22 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 53DF610DA2DAA; Mon, 22 Jul 2024 08:20:07 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, <lukas@wunner.de>
CC: <mika.westerberg@linux.intel.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH RFC 7/8] pci: reference count subordinate
Date: Mon, 22 Jul 2024 08:19:35 -0700
Message-ID: <20240722151936.1452299-8-kbusch@meta.com>
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
X-Proofpoint-GUID: lK7daMmrW2wSdR5FkSVrLkdd_Dq--2dd
X-Proofpoint-ORIG-GUID: lK7daMmrW2wSdR5FkSVrLkdd_Dq--2dd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01

From: Keith Busch <kbusch@kernel.org>

The subordinate is accessed under the pci_bus_sem (or often times no
lock at at all), but unset under the rescan_remove_lock. Access the
subordinate buses with reference counts to guard against a concurrent
removal and use-after-free.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/bus.c                | 18 +++++++++++++++---
 drivers/pci/hotplug/pciehp_pci.c | 12 ++++++++++--
 drivers/pci/pci.c                | 28 ++++++++++++++++++++++------
 drivers/pci/pci.h                |  1 +
 drivers/pci/pcie/aspm.c          |  7 +++++--
 drivers/pci/probe.c              |  7 +++++--
 drivers/pci/remove.c             | 18 +++++++++++++-----
 7 files changed, 71 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 638e79d10bfab..3085ecaa2ba40 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -382,9 +382,11 @@ void pci_bus_add_devices(const struct pci_bus *bus)
 		/* Skip if device attach failed */
 		if (!pci_dev_is_added(dev))
 			continue;
-		child =3D dev->subordinate;
+
+		child =3D pci_dev_get_subordinate(dev);
 		if (child)
 			pci_bus_add_devices(child);
+		pci_bus_put(child);
 	}
 }
 EXPORT_SYMBOL(pci_bus_add_devices);
@@ -396,11 +398,16 @@ static int __pci_walk_bus(struct pci_bus *top, int =
(*cb)(struct pci_dev *, void
 	int ret =3D 0;
=20
 	list_for_each_entry(dev, &top->devices, bus_list) {
+		struct pci_bus *bus;
+
 		ret =3D cb(dev, userdata);
 		if (ret)
 			break;
-		if (dev->subordinate) {
-			ret =3D __pci_walk_bus(dev->subordinate, cb, userdata);
+
+		bus =3D pci_dev_get_subordinate(dev);
+		if (bus) {
+			ret =3D __pci_walk_bus(bus, cb, userdata);
+			pci_bus_put(bus);
 			if (ret)
 				break;
 		}
@@ -448,3 +455,8 @@ void pci_bus_put(struct pci_bus *bus)
 	if (bus)
 		put_device(&bus->dev);
 }
+
+struct pci_bus *pci_dev_get_subordinate(struct pci_dev *dev)
+{
+	return pci_bus_get(READ_ONCE(dev->subordinate));
+}
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pcieh=
p_pci.c
index 65e50bee1a8c0..b15dcfd86c60a 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -33,9 +33,12 @@ int pciehp_configure_device(struct controller *ctrl)
 {
 	struct pci_dev *dev;
 	struct pci_dev *bridge =3D ctrl->pcie->port;
-	struct pci_bus *parent =3D bridge->subordinate;
+	struct pci_bus *parent =3D pci_dev_get_subordinate(bridge);
 	int num, ret =3D 0;
=20
+	if (!parent)
+		return 0;
+
 	pci_lock_rescan_remove();
=20
 	dev =3D pci_get_slot(parent, PCI_DEVFN(0, 0));
@@ -78,6 +81,7 @@ int pciehp_configure_device(struct controller *ctrl)
=20
  out:
 	pci_unlock_rescan_remove();
+	pci_bus_put(parent);
 	return ret;
 }
=20
@@ -95,9 +99,12 @@ int pciehp_configure_device(struct controller *ctrl)
 void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 {
 	struct pci_dev *dev, *temp;
-	struct pci_bus *parent =3D ctrl->pcie->port->subordinate;
+	struct pci_bus *parent =3D pci_dev_get_subordinate(ctrl->pcie->port);
 	u16 command;
=20
+	if (!parent)
+		return;
+
 	ctrl_dbg(ctrl, "%s: domain:bus:dev =3D %04x:%02x:00\n",
 		 __func__, pci_domain_nr(parent), parent->number);
=20
@@ -138,4 +145,5 @@ void pciehp_unconfigure_device(struct controller *ctr=
l, bool presence)
 	}
=20
 	pci_unlock_rescan_remove();
+	pci_bus_put(parent);
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e3a49f66982d5..0cd36b7772c8b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3113,9 +3113,14 @@ void pci_bridge_d3_update(struct pci_dev *dev)
 	 * so we need to go through all children to find out if one of them
 	 * continues to block D3.
 	 */
-	if (d3cold_ok && !bridge->bridge_d3)
-		pci_walk_bus(bridge->subordinate, pci_dev_check_d3cold,
-			     &d3cold_ok);
+	if (d3cold_ok && !bridge->bridge_d3) {
+		struct pci_bus *bus =3D pci_dev_get_subordinate(bridge);
+
+		if (bus) {
+			pci_walk_bus(bus, pci_dev_check_d3cold, &d3cold_ok);
+			pci_bus_put(bus);
+		}
+	}
=20
 	if (bridge->bridge_d3 !=3D d3cold_ok) {
 		bridge->bridge_d3 =3D d3cold_ok;
@@ -4824,6 +4829,7 @@ static int pci_bus_max_d3cold_delay(const struct pc=
i_bus *bus)
 int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_t=
ype)
 {
 	struct pci_dev *child __free(pci_dev_put) =3D NULL;
+	struct pci_bus *bus;
 	int delay;
=20
 	if (pci_dev_is_disconnected(dev))
@@ -4840,7 +4846,17 @@ int pci_bridge_wait_for_secondary_bus(struct pci_d=
ev *dev, char *reset_type)
 	 * board_added(). In case of ACPI hotplug the firmware is expected
 	 * to configure the devices before OS is notified.
 	 */
-	if (!dev->subordinate || list_empty(&dev->subordinate->devices)) {
+	bus =3D pci_dev_get_subordinate(dev);
+	if (!bus) {
+		up_read(&pci_bus_sem);
+		return 0;
+	}
+
+	child =3D pci_dev_get(list_first_entry_or_null(&bus->devices,
+						     struct pci_dev,
+						     bus_list));
+	if (!child) {
+		pci_bus_put(bus);
 		up_read(&pci_bus_sem);
 		return 0;
 	}
@@ -4848,12 +4864,12 @@ int pci_bridge_wait_for_secondary_bus(struct pci_=
dev *dev, char *reset_type)
 	/* Take d3cold_delay requirements into account */
 	delay =3D pci_bus_max_d3cold_delay(dev->subordinate);
 	if (!delay) {
+		pci_bus_put(bus);
 		up_read(&pci_bus_sem);
 		return 0;
 	}
=20
-	child =3D pci_dev_get(list_first_entry(&dev->subordinate->devices,
-					     struct pci_dev, bus_list));
+	pci_bus_put(bus);
 	up_read(&pci_bus_sem);
=20
 	/*
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 19cbf18743a96..83e449253066e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -312,6 +312,7 @@ void pci_reassigndev_resource_alignment(struct pci_de=
v *dev);
 void pci_disable_bridge_window(struct pci_dev *dev);
 struct pci_bus *pci_bus_get(struct pci_bus *bus);
 void pci_bus_put(struct pci_bus *bus);
+struct pci_bus *pci_dev_get_subordinate(struct pci_dev *dev);
=20
 /* PCIe link information from Link Capabilities 2 */
 #define PCIE_LNKCAP2_SLS2SPEED(lnkcap2) \
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index cee2365e54b8b..3c0c83d35ab86 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1212,9 +1212,11 @@ static void pcie_update_aspm_capable(struct pcie_l=
ink_state *root)
 		link->aspm_capable =3D link->aspm_support;
 	}
 	list_for_each_entry(link, &link_list, sibling) {
+		struct pci_bus *linkbus;
 		struct pci_dev *child;
-		struct pci_bus *linkbus =3D link->pdev->subordinate;
-		if (link->root !=3D root)
+
+		linkbus =3D pci_dev_get_subordinate(link->pdev);
+		if (!linkbus || link->root !=3D root)
 			continue;
 		list_for_each_entry(child, &linkbus->devices, bus_list) {
 			if ((pci_pcie_type(child) !=3D PCI_EXP_TYPE_ENDPOINT) &&
@@ -1222,6 +1224,7 @@ static void pcie_update_aspm_capable(struct pcie_li=
nk_state *root)
 				continue;
 			pcie_aspm_check_latency(child);
 		}
+		pci_bus_put(linkbus);
 	}
 }
=20
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b14b9876c0303..53522685193da 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1167,7 +1167,10 @@ static struct pci_bus *pci_alloc_child_bus(struct =
pci_bus *parent,
 		child->resource[i] =3D &bridge->resource[PCI_BRIDGE_RESOURCES+i];
 		child->resource[i]->name =3D child->name;
 	}
-	bridge->subordinate =3D child;
+
+	down_write(&pci_bus_sem);
+	WRITE_ONCE(bridge->subordinate, child);
+	up_write(&pci_bus_sem);
=20
 add_dev:
 	pci_set_bus_msi_domain(child);
@@ -3380,7 +3383,7 @@ int pci_hp_add_bridge(struct pci_dev *dev)
 	/* Scan bridges that need to be reconfigured */
 	pci_scan_bridge_extend(parent, dev, busnr, available_buses, 1);
=20
-	if (!dev->subordinate)
+	if (!READ_ONCE(dev->subordinate))
 		return -1;
=20
 	return 0;
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 288162a11ab19..646c97e41a323 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -77,10 +77,12 @@ EXPORT_SYMBOL(pci_remove_bus);
=20
 static void pci_stop_bus_device(struct pci_dev *dev)
 {
-	struct pci_bus *bus =3D dev->subordinate;
+	struct pci_bus *bus =3D pci_dev_get_subordinate(dev);
=20
-	if (bus)
+	if (bus) {
 		pci_stop_bus(bus);
+		pci_bus_put(bus);
+	}
 	pci_stop_dev(dev);
 }
=20
@@ -100,12 +102,18 @@ static void pci_stop_bus(struct pci_bus *bus)
=20
 static void pci_remove_bus_device(struct pci_dev *dev)
 {
-	struct pci_bus *bus =3D dev->subordinate;
+	struct pci_bus *bus;
=20
+	down_write(&pci_bus_sem);
+	bus =3D pci_dev_get_subordinate(dev);
 	if (bus) {
+		WRITE_ONCE(dev->subordinate, NULL);
+		up_write(&pci_bus_sem);
+
 		pci_remove_bus(bus);
-		dev->subordinate =3D NULL;
-	}
+		pci_bus_put(bus);
+	} else
+		up_write(&pci_bus_sem);
 	pci_destroy_dev(dev);
 }
=20
--=20
2.43.0


