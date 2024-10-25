Return-Path: <linux-pci+bounces-15379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D06059B1290
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2024 00:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D81282E04
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 22:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317CE20F3D3;
	Fri, 25 Oct 2024 22:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jsmyN1j7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E123B217F30
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 22:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895299; cv=none; b=DDxrkUnh/UejRwPx1GpB5Rr4tAaodTxDVqhJ+9aopRBl9Co9ZIWQR+f/GtV2pX6rpUiWIsb/bAS8n8wE6Vbs8O/n+ZUdrppoqohiSsidTLYsnLBk9EYZvym0VsKfRfSB0hXAPOaneJ5Tfp9UcyvNLb1fJ13C1RzROL+Kp7BNlSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895299; c=relaxed/simple;
	bh=ANT9JFyMQUaNKcxTkG8jRNy8UrdWGE3X9oXozcvo7cg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d+wvE0tZK+yNDzJJe6YGlc/0ZC3rZWMvw+h8tcQZC4BrP6HAmoKaHky3crIs3drh8xznosfmwr3aSZmJXUtJG3ylvdQWNiLFvFq7I3lplTqtQqht44/lCFGUrYZy7QYhv5ELnZRhRAro48uV+ttMUAsWNRVa8+YAnjh+oe4t9Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jsmyN1j7; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 49PMRRxP026387
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 15:28:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=x7TimT6snpcSSteHnI
	S4KyD/UOy5nnU0+vlyz9YS5FM=; b=jsmyN1j7y+kWcuk3VXQwDESPTxF7H4+So9
	KrmEnPLnLsvK/DOgujdDstMDifLNY+sAMXpAdPCeBpMzGByRyzxjXmAwOHckECWA
	74sSE8TxOlbHKxQ9iqm1ANwadG5Dq+nehKVCBFtIDJH7cCM+oLrhOluKciIcEZYg
	fcY0NbeGqnsRojw2HwVWgbG0GVq8EEhRS3VM0Iho2TaFHLmun8fkKWKgKR26jyjO
	fiMYOwwG8wXAtiPOn7vCFSvjnRZ1dnzBRGLC4QR06YtZ9WZHFG/lvUTi+DY7WlDn
	fHyLE4KIlzbyyeqqQ6WcbR5D/bY+X1Tviu44VuDJH0gZgNv3/kjg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 42gm4x8045-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 15:28:15 -0700 (PDT)
Received: from twshared4570.02.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 25 Oct 2024 22:28:13 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 0950A147715FB; Fri, 25 Oct 2024 15:27:57 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <alex.williamson@redhat.com>
CC: <ameynarkhede03@gmail.com>, <raphael.norwitz@nutanix.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 1/2] pci: provide bus reset attribute
Date: Fri, 25 Oct 2024 15:27:54 -0700
Message-ID: <20241025222755.3756162-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: a4nqUp05hmnpQ4IgVyH7VCelxOAWNoSU
X-Proofpoint-GUID: a4nqUp05hmnpQ4IgVyH7VCelxOAWNoSU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

Resetting a bus from an end device only works if it's the only function
on or below that bus.

Provide an attribute on the pci_dev bridge device that can perform the
secondary bus reset. This makes it possible for a user to safely reset
multiple devices in a single command using the secondary bus reset
action.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Moved the attribute from the pci_bus to the bridge's pci_dev

  And renamed it to "reset_subordinate" to distinguish from other
  existing device "reset" attributes.

  Added documentation.

  Follow up patch to warn if the action was potentially harmful.

 Documentation/ABI/testing/sysfs-bus-pci | 11 +++++++++++
 drivers/pci/pci-sysfs.c                 | 23 +++++++++++++++++++++++
 drivers/pci/pci.c                       |  2 +-
 drivers/pci/pci.h                       |  1 +
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/=
testing/sysfs-bus-pci
index 7f63c7e977735..5da6a14dc326b 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -163,6 +163,17 @@ Description:
 		will be present in sysfs.  Writing 1 to this file
 		will perform reset.
=20
+What:		/sys/bus/pci/devices/.../reset_subordinate
+Date:		October 2024
+Contact:	linux-pci@vger.kernel.org
+Description:
+		This is visible only for bridge devices. If you want to reset
+		all devices attached through the subordinate bus of a specific
+		bridge device, writing 1 to this will try to do it.  This will
+		affect all devices attached to the system through this bridge
+		similiar to writing 1 to their individual "reset" file, so use
+		with caution.
+
 What:		/sys/bus/pci/devices/.../vpd
 Date:		February 2008
 Contact:	Ben Hutchings <bwh@kernel.org>
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5d0f4db1cab78..480a99e50612b 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -521,6 +521,28 @@ static ssize_t bus_rescan_store(struct device *dev,
 static struct device_attribute dev_attr_bus_rescan =3D __ATTR(rescan, 02=
00, NULL,
 							    bus_rescan_store);
=20
+static ssize_t reset_subordinate_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct pci_dev *pdev =3D to_pci_dev(dev);
+	struct pci_bus *bus =3D pdev->subordinate;
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val) {
+		int ret =3D __pci_reset_bus(bus);
+
+		if (ret)
+			return ret;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_WO(reset_subordinate);
+
 #if defined(CONFIG_PM) && defined(CONFIG_ACPI)
 static ssize_t d3cold_allowed_store(struct device *dev,
 				    struct device_attribute *attr,
@@ -625,6 +647,7 @@ static struct attribute *pci_dev_attrs[] =3D {
 static struct attribute *pci_bridge_attrs[] =3D {
 	&dev_attr_subordinate_bus_number.attr,
 	&dev_attr_secondary_bus_number.attr,
+	&dev_attr_reset_subordinate.attr,
 	NULL,
 };
=20
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7d85c04fbba2a..338dfcd983f1e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5880,7 +5880,7 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
  *
  * Same as above except return -EAGAIN if the bus cannot be locked
  */
-static int __pci_reset_bus(struct pci_bus *bus)
+int __pci_reset_bus(struct pci_bus *bus)
 {
 	int rc;
=20
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 14d00ce45bfa9..1cdc2c9547a7e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -104,6 +104,7 @@ bool pci_reset_supported(struct pci_dev *dev);
 void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
+int __pci_reset_bus(struct pci_bus *bus);
=20
 struct pci_cap_saved_data {
 	u16		cap_nr;
--=20
2.43.5


