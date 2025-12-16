Return-Path: <linux-pci+bounces-43153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FDCCC5721
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 00:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88C76303F2BA
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 23:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E8A33EB06;
	Tue, 16 Dec 2025 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F/DUvhCd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E04823182D;
	Tue, 16 Dec 2025 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765926551; cv=none; b=oDBC1NE64AyUfULvzH1pY+3zYgMK3Q2lm221WImonLw/zkAuq5OQKMHGnxG1RHVXNQepmLe7BvuQX15kVlqQxk+yC0BLW5/1aeD+XmCDGrQxoJUOuKC+7vaoc5sVRhz98qOQk/055vWyYNJvGEcOeBuWDFZ64W2okEJAM5kNIC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765926551; c=relaxed/simple;
	bh=Oar3+prEv8chk53CC1BDiIYdTNAGMFys/IG/o0DHLzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SfotLSumoz4jpTEdlJHcCBipx5eXJObs3l51372sAGN5mVzTw+U9xKyieBdNmqQK1q7BaUvlgSSlq694UIFSrwDB88p0ILEJHgSYylTPRhrS8x3y6tzoPy7AjNRWG+L2FuBwXwtX7RgdhvhBQ12iH2IFXffczww6kxBSG+VUWK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F/DUvhCd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGHLo4f012702;
	Tue, 16 Dec 2025 23:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=kGoMRDeZPsKM2WhCOPu9bvkOtK1R
	K07yFrOYOpSDMBg=; b=F/DUvhCduq3D6eWNP50E+2sjwbfnpNTn0zyU7DB/kfiI
	PrmrVjA+mS6f1Ss01FwXNUHhhFgmKyObZaFRVIGVel4oDyp/zzy8jqjBCkEc4xUx
	qwljnNe2Id0XKo+iH1+igA55rGrmMPiPw6a/WrwRaQjOL3Dg3VnMYHYQTsaodePR
	rorGlJS/s3pQsRldCA1lX6fYPDlSh1XESThksFRPf/W1eiU7woargXoh3Es3OKFF
	uH47kVQv+chNT3+6rXPijGv9BuwxHPx7RU6YQAk54c+jjpAyskAWAlJL3zsmC/mt
	qnpPq2dOyiPhWSave1Fakuw/5rxeM9fvlhRbyt52Lw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjm19k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 23:09:08 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGN97Ym016408;
	Tue, 16 Dec 2025 23:09:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjm19k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 23:09:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGL16cf012816;
	Tue, 16 Dec 2025 23:09:07 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1juy7cfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 23:09:07 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BGN95hU50004376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 23:09:05 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 910CA5816C;
	Tue, 16 Dec 2025 23:09:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 458EB5816B;
	Tue, 16 Dec 2025 23:09:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Dec 2025 23:09:03 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 17 Dec 2025 00:09:00 +0100
Subject: [PATCH v4] PCI: s390: Expose the UID as an arch specific PCI slot
 attribute
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-uid_slot-v4-1-559ceb59ba69@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAIvmQWkC/23NTQrCMBAF4KtI1qbklySuvIeIpNNEB7SVRkul9
 O6mRaSUbgbeMN+bgaTQYkjksBtIGzpM2NQ5qP2OwM3X10CxypkIJjRzQtI3Vpd0b140SK0dRA1
 eMpLPn22I2M9Vp3PON0yvpv3MzR2fthslHaecSqMFeAPRenm8Y/3uCywfBTSPqfeH1Aox5wNTU
 VnQZoWm7534f+SM2QUWGYcoBORhjOJbWC4w1wssM1ZKWmedBl6WazyO4xfi7PcvUwEAAA==
X-Change-ID: 20250923-uid_slot-e3559cf5ca30
To: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4959;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=Oar3+prEv8chk53CC1BDiIYdTNAGMFys/IG/o0DHLzo=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDIdn/WF8GvNVq7lMQn/HftITd48YWseo7L7j13m1xn5H
 GddfsXQUcrCIMbFICumyLKoy9lvXcEU0z1B/R0wc1iZQIYwcHEKwEQeLGVk+Pr1p1mKaNZyqdd+
 TxW69uyv3/IltzSrbUbFKb8phfN/PGH4HxcTYh3jrWwxScjTz/5mPpdc74+1Av4zXvnOYN3EenU
 eHwA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KUh4GT4ZrHe54uLLxBPSdu0xrlGEg-Uz
X-Authority-Analysis: v=2.4 cv=CLgnnBrD c=1 sm=1 tr=0 ts=6941e694 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=AQEDfA8N-JhHbHfKeYEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lzvu4dRdu5nhHu_FpAPyBdNQLx1R6fgJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwOSBTYWx0ZWRfX/VrLzUC71jWI
 +XrcVSyEIuNtLWC6pcXz77issVmHVC2d2hlILWSywS+/9NsobbgSJiqCZsPe98ApZVlsUvvdYeo
 pvqMcOrOmk0Js7pScG/ykk4DUho5JyOOLh8N1rHPjKBwX2nEv2E1JbxyzAhwG1zSDMOL2jXwh7D
 y83wwBPcqGZsAhBuy2y3JIID0kpm9GuHfznyh0RRxY/B/bkqouNc+yDkJ2OI213aPKhUeBkD0C7
 9T5ElVatQr7CqpbyVIfAlxYiLwpe7szSXJWA9PU8zhlHEx/c/R5IyjYcy18S2+rAUi5zruSGNPD
 QtMMEk7coPYpJlEQEV6Pj4bc6VPw2V8emI9nk0n4SCIUXQHyfJgPxwDRwvsE5KlSxAYcVV1QPFc
 OQUAaxtbcEWgVg9FhNKnYBnfiTOiVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130009

On s390, an individual PCI function can generally be identified by two
identifiers, the FID and the UID. Which identifier is used depends on
the scope and the platform configuration.

The first identifier, the FID, is always available and identifies a PCI
device uniquely within a machine. The FID may be virtualized by
hypervisors, but on the LPAR level, the machine scope makes it
impossible to create the same configuration based on FIDs on two
different LPARs of the same machine, and difficult to reuse across
machines.

Such matching LPAR configurations are useful, though, allowing
standardized setups and booting a Linux installation on different LPARs.
To this end the UID, or user-defined identifier, was introduced. While
it is only guaranteed to be unique within an LPAR and only if indicated
by firmware, it allows users to replicate PCI device setups.

On s390, which uses a machine hypervisor, a per PCI function hotplug
model is used. The shortcoming with the UID then is, that it is not
visible to the user without first attaching the PCI function and
accessing the "uid" device attribute. The FID, on the other hand, is
used as the slot name and is thus known even with the PCI function in
standby.

Remedy this shortcoming by providing the UID as an attribute on the slot
allowing the user to identify a PCI function based on the UID without
having to first attach it. Do this via a macro mechanism analogous to
what was introduced by commit 265baca69a07 ("s390/pci: Stop usurping
pdev->dev.groups") for the PCI device attributes.

Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note: I considered adding the UID as a generic index attribute analogous
to the PCI device index attribute (SMBIOS index / s390 UID)  but felt
like there is probably too little commonality on format and usage
patterns.

v3->v4:
- Rebase on v6.19-rc1
- Collect R-bs
- Link to v3: https://lore.kernel.org/r/20251015-uid_slot-v3-1-44389895c1bb@linux.ibm.com
---
 arch/s390/include/asm/pci.h |  4 ++++
 arch/s390/pci/pci_sysfs.c   | 20 ++++++++++++++++++++
 drivers/pci/slot.c          | 13 ++++++++++++-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index c0ff19dab5807c7e1aabb48a0e9436aac45ec97d..5dcf35f0f325f5f44b28109a1c8d9aef18401035 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -208,6 +208,10 @@ extern const struct attribute_group zpci_ident_attr_group;
 			    &pfip_attr_group,		 \
 			    &zpci_ident_attr_group,
 
+extern const struct attribute_group zpci_slot_attr_group;
+
+#define ARCH_PCI_SLOT_GROUPS (&zpci_slot_attr_group)
+
 extern unsigned int s390_pci_force_floating __initdata;
 extern unsigned int s390_pci_no_rid;
 
diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
index c2444a23e26c4218832bb91930b5f0ffd498d28f..d98d97df792adb3c7e415a8d374cc2f3a65fbb52 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -187,6 +187,17 @@ static ssize_t index_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(index);
 
+static ssize_t zpci_uid_slot_show(struct pci_slot *slot, char *buf)
+{
+	struct zpci_dev *zdev = container_of(slot->hotplug, struct zpci_dev,
+					     hotplug_slot);
+
+	return sysfs_emit(buf, "0x%x\n", zdev->uid);
+}
+
+static struct pci_slot_attribute zpci_slot_attr_uid =
+	__ATTR(uid, 0444, zpci_uid_slot_show, NULL);
+
 static umode_t zpci_index_is_visible(struct kobject *kobj,
 				     struct attribute *attr, int n)
 {
@@ -243,6 +254,15 @@ const struct attribute_group pfip_attr_group = {
 	.attrs = pfip_attrs,
 };
 
+static struct attribute *zpci_slot_attrs[] = {
+	&zpci_slot_attr_uid.attr,
+	NULL,
+};
+
+const struct attribute_group zpci_slot_attr_group = {
+	.attrs = zpci_slot_attrs,
+};
+
 static struct attribute *clp_fw_attrs[] = {
 	&uid_checking_attr.attr,
 	NULL,
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 50fb3eb595fe65e271b6b339d43c9677c61b1e45..b09e7852c33ed4957432ac73b36d181ecd8283a1 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -96,7 +96,18 @@ static struct attribute *pci_slot_default_attrs[] = {
 	&pci_slot_attr_cur_speed.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(pci_slot_default);
+
+static const struct attribute_group pci_slot_default_group = {
+	.attrs = pci_slot_default_attrs,
+};
+
+static const struct attribute_group *pci_slot_default_groups[] = {
+	&pci_slot_default_group,
+#ifdef ARCH_PCI_SLOT_GROUPS
+	ARCH_PCI_SLOT_GROUPS,
+#endif
+	NULL,
+};
 
 static const struct kobj_type pci_slot_ktype = {
 	.sysfs_ops = &pci_slot_sysfs_ops,

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20250923-uid_slot-e3559cf5ca30

Best regards,
-- 
Niklas Schnelle


