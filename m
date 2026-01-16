Return-Path: <linux-pci+bounces-45063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70857D334B3
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 16:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B31D530D2D03
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 15:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D154F33A005;
	Fri, 16 Jan 2026 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="vAlFLZKf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C40833A9E0
	for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578171; cv=none; b=HlUY4tsR+nG6r6aoN+hSLXs5GvL+CFvyJHU1SVELvO/+8i/hgAYfEvbTr4Jt4HX+6gSBF1H6LLmtk9+I5ora0WjzPQ1vD8NpASv4WONLqoMp/naQGKxnNvmDn3c12unb40o5vlAqf37p228GRXPucS9PBLKTDX8fZd48//0jqHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578171; c=relaxed/simple;
	bh=5zLlkSTuxlR9lqD0njtdfIL8hyZ6u8K6s6XugoRfMY0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l3/RIrRpDFL4dEGTvY6ku/r96L5awCxWQW0aXbhniPAvnPuYh5mPsC7v80D896my/SrF+skuW+r8sGgTOqutX38jcGP16FcdiDhpw035UcVDf0RUYEIiPU5KzD4ZapSfDDql0YwFCn6DQRtYmWwI6MBZVZ8HKAdFRYUc+FnUbWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=vAlFLZKf; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60GF689e2604067
	for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 07:42:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=l6JSzlNeeJxWeL0zWx
	2I+O4mGsb2MAxV5XQHXEZNLQw=; b=vAlFLZKf/2sn7zzNoR5zdL/yNFnKHtLe/l
	IKsSAGrzjhUMwfVKj5bjBMvTCkFG0nGfM5/wqrDLdsAD+fbMx5tQGIwZbp8Ichk/
	tjNPIsq6cF3FbeRQ0MvqSHrKTu0JpNdnxuAjc4JYfdAVyq4QKjpkyWCpTQCabTHY
	PggF0ENzrryNuUsUh2kEDqOBSwUI7vth+7Ief/1JJ5WTwmbY615u2liRnfESpjfo
	74QBjn8uGisQpcMKYLEeeKwcMVvdO7M60cbbe+RVDV3nPv6+AAgUPJGd3YS4vTfb
	WZBPSbJYDG+9++eT5Isrj0sEU7Vx0atvmdpQ93cs9HKHGld7ZJ3g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bq986nqux-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 07:42:48 -0800 (PST)
Received: from twshared25002.15.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Fri, 16 Jan 2026 15:42:46 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 20D3664EB007; Fri, 16 Jan 2026 07:42:45 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: <alex@shazbot.org>, <lukas@wunner.de>, <helgaas@kernel.org>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2] pci: make reset_subordinate hotplug safe
Date: Fri, 16 Jan 2026 07:42:44 -0800
Message-ID: <20260116154244.1452246-1-kbusch@meta.com>
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
X-Proofpoint-GUID: J0dg7Y22PjFBovOsC3goM7iLkJPTWWGw
X-Proofpoint-ORIG-GUID: J0dg7Y22PjFBovOsC3goM7iLkJPTWWGw
X-Authority-Analysis: v=2.4 cv=RprI7SmK c=1 sm=1 tr=0 ts=696a5c78 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=JHLiD0OtLAlnpiTiT9wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDExMiBTYWx0ZWRfX0i1k8mP4RfhJ
 QU1NMUriIievQp82M7BaCopmaCYoa7sm7jGOZmgamTx6zODywRLE6KAQ7X4pyf6mCZus5jcWJrn
 N46vwvMsJNw1dzGHC5xkPoR2s0xB3OTsweC8MOzPKXU/x4el+ujKkhGZMIRixRx32mDwI9iCgLb
 KlqQSYOlfiWdTmFim7FC+SXnPqM5+TUsiUqfer8PakLSu+OCNTxLNbsuZ5p9pnRkP38IwofKlMo
 poksF9l6aH3AuhJRgZ0ozii+s8imeegIWzD8PNWx9fbRmn4rdPjLb5R7tnPoL2lKBGTNkBEmiRp
 Cy/05wqG5u9upoxhSxr+wOs+Dh6tokyxaCMhkho3ixKOjopFXzDWKPkRFVz5kX46dfC2CPlHGda
 THNbw+FaRvJcDu5J/lGeXap4xW2wkC8OxhCiw9GCKdljTXUY9YVY6MMRd8qGk2h7qvk4XSNMlQm
 7Uooa0ULesTr0IEd74g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_06,2026-01-15_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Use the slot reset method when restting the bridge if the bus contains
hot plug slots. This fixes spurious hot plug events that are triggered
by the secondary bus reset that bypasses the slot's detection disabling.

Resetting a bridge's subordinate bus could be done like this:

  # echo 1 > /sys/bus/pci/devices/0000:50:01.0/reset_subordinate

Prior to this patch, an example kernel dmesg may show a message like:

  pcieport 0000:50:01.0: pciehp: Slot(40): Link Down

With this change, the pciehp driver ignores the link event during the
reset, so may show this message instead:

  pcieport 0000:50:01.0: pciehp: Slot(40): Link Down/Up ignored

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1 -> v2:

  Added static declaration to local function, fixing compiler warning.

  Added more context in the change log with expected kernel messages
  before and after this patch.

 drivers/pci/pci-sysfs.c |  3 +--
 drivers/pci/pci.c       | 29 ++++++++++++++++++++++++++++-
 drivers/pci/pci.h       |  2 +-
 3 files changed, 30 insertions(+), 4 deletions(-)

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
index b14dd064006cc..72d88ea95f3cc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5727,7 +5727,7 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
  *
  * Same as above except return -EAGAIN if the bus cannot be locked
  */
-int __pci_reset_bus(struct pci_bus *bus)
+static int __pci_reset_bus(struct pci_bus *bus)
 {
 	int rc;
=20
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


