Return-Path: <linux-pci+bounces-44831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A16B8D20F06
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEA083013339
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5320633859A;
	Wed, 14 Jan 2026 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="N/oJavrw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E023358B5
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768417107; cv=none; b=Xim+gKjUansawAgyS0jAEdvPEmf9Z59ykD1n5dvPgYB1J8yxl9GWNzF8GwxCPdaH9Emz3AI+VcEe40xE83BqafYdeuHKZ2Sg8+sb/FUppm3dDBZCEJJQBOHRyWl6ifvl/arpLR063Crk4j7oOx7Xv8zSIUJHl16kxKrnUGVyBoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768417107; c=relaxed/simple;
	bh=39NsvpIwB7tyHsLTUImhWYg8HjUhHVP+jG7JV7c0unM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=id7ulra1LZtz9uKmRFQEymRmp2+/Guc81QyYo6j75AjJ1V52tExKzKUGIKiLq3JmeLsXNNMZO3kQKR4dsM3VL1eRPBd33CvSprwjIhdopNA1RolXoJqNk0GmyvavTbWwsLFnPYQPQbXsiElMKz7YC8xwZ9ocu4M+RFD1NTpoock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=N/oJavrw; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 60EHQAaK3748007
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 10:58:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=/viDr5fTlu6lZToBHq
	GFtP6Vc08lV6dsNwEmAVh3p7g=; b=N/oJavrwX2zOg0w982PnKCo2bfFHM9IWC9
	tO/M8H+B+d6XD71jxzRnY0Po5OmmtL7pNo7Lisz+oeJznASf0Qg4hzUmoDx03jrE
	TNtHRLwQBIPhm/9tRCdDUpigIT3BhxO1DJzvwBxYNA/lczC5QFXGeD+BV8UOeIAj
	whiaPWwbrd4Y93ZzMc8a1nvSD1/H+Y6vfia9U/pO5uynGSPJGUNxlz+NID36SU9s
	1yK760tRRRnL2P7g4vx31IeUjvMlocrQxHtB1HW2z+xz53YR7e1sDe4JXu0X6KFG
	AhLCfLOxyEzGGFbzYQ/L/DmO3Oi/3Oo+kSX8kNTGhcv45iU/XsRw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4bp12afd10-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 10:58:24 -0800 (PST)
Received: from twshared22445.03.snb1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 14 Jan 2026 18:58:23 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 2A31F63C07F3; Wed, 14 Jan 2026 10:58:22 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] pci: make reset_subordinate hotplug safe
Date: Wed, 14 Jan 2026 10:58:21 -0800
Message-ID: <20260114185821.704089-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: neymaQZ0GsptFkiW5oLOLRmwzvC0WxYl
X-Proofpoint-GUID: neymaQZ0GsptFkiW5oLOLRmwzvC0WxYl
X-Authority-Analysis: v=2.4 cv=KcjfcAYD c=1 sm=1 tr=0 ts=6967e750 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=P-T3t15S9jr7RpvDZ9AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE1NiBTYWx0ZWRfX6StKnEer1MQI
 MnolMInpoXgI3Y9lEm2tnyQykRos3B8jvsJ3dY+BIZVk5NZtya9JQgxzazSkLodoOP6EIazOOV2
 Z73G5sg/MiZtMxY98rFcxB+tjAemJpbwhcvP+8E2kWjb9yRmBFSd2kdN9IdfH/SDxBODS6pOci4
 H8dzfr4Bp92gViX2LoDHPduOfqvgpaw2lKFMT2Kv83IF7qN5mW+SFtlq7ctLTIyH+958BIwOh2+
 Zb3h6P7gZM1I+dkPmWdhylEwPbiM5kIBFIqmcM9Z3FhNLf6W1NAa6FB7KuXaV9Otxzkk1Oj0D5P
 hN/qSc1tAmN/U1uJgRkdsuqMYP7QhO83JTd9ld8HwGlsV4IQI0ap/ywgiSb8pgZYe2fRyn/Lmaw
 2TshESiH9iNDjNsHpkqI7aCQ/lzoGc71rHvOwszd/Pqowv0u89eJkKsqvXNIWB4bv1z3a6bv393
 2X/pcU4h/5e1Mf7NaKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_05,2026-01-14_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Use the slot reset method when resetting the bridge if the bus contains
hotplug slots. This fixes spurious hotplug events the secondary bus
reset triggers by utilizing slot's specific reset callback that ignores
link events.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
The new function introduced here is essentially the same as
pci_bus_error_reset, except it uses the reset functions that save and
restore the device. This is the same as before if not resetting a
hotplug slot.

 drivers/pci/pci-sysfs.c |  3 +--
 drivers/pci/pci.c       | 27 +++++++++++++++++++++++++++
 drivers/pci/pci.h       |  2 +-
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 3881359440b1a..5c7c6f0c435f3 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -553,7 +553,6 @@ static ssize_t reset_subordinate_store(struct device =
*dev,
 				const char *buf, size_t count)
 {
 	struct pci_dev *pdev =3D to_pci_dev(dev);
-	struct pci_bus *bus =3D pdev->subordinate;
 	unsigned long val;
=20
 	if (!capable(CAP_SYS_ADMIN))
@@ -563,7 +562,7 @@ static ssize_t reset_subordinate_store(struct device =
*dev,
 		return -EINVAL;
=20
 	if (val) {
-		int ret =3D __pci_reset_bus(bus);
+		int ret =3D pci_reset_bridge(pdev);
=20
 		if (ret)
 			return ret;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006cc..ca426ff68c820 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5747,6 +5747,33 @@ int __pci_reset_bus(struct pci_bus *bus)
 	return rc;
 }
=20
+int pci_reset_bridge(struct pci_dev *bridge)
+{
+	struct pci_bus *bus =3D bridge->subordinate;
+	struct pci_slot *slot;
+
+	if (!bus)
+		return -ENOTTY;
+
+	mutex_lock(&pci_slot_mutex);
+	if (list_empty(&bus->slots))
+		goto bus_reset;
+
+	list_for_each_entry(slot, &bus->slots, list)
+		if (pci_probe_reset_slot(slot))
+			goto bus_reset;
+
+	list_for_each_entry(slot, &bus->slots, list)
+		if (__pci_reset_slot(slot))
+			goto bus_reset;
+
+	mutex_unlock(&pci_slot_mutex);
+	return 0;
+bus_reset:
+	mutex_unlock(&pci_slot_mutex);
+	return __pci_reset_bus(bus);
+}
+
 /**
  * pci_reset_bus - Try to reset a PCI bus
  * @pdev: top level PCI device to reset via slot/bus
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 36f8c0985430a..f216e7a37d726 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -197,7 +197,7 @@ bool pci_reset_supported(struct pci_dev *dev);
 void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
-int __pci_reset_bus(struct pci_bus *bus);
+int pci_reset_bridge(struct pci_dev *dev);
=20
 struct pci_cap_saved_data {
 	u16		cap_nr;
--=20
2.47.3


