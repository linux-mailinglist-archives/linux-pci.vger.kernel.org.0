Return-Path: <linux-pci+bounces-36855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C392B99FDA
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 15:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31DE43B4E3C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 13:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AD4302777;
	Wed, 24 Sep 2025 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eWuIalby"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B3502BE;
	Wed, 24 Sep 2025 13:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758719685; cv=none; b=ZyHAmQroKkRR59rL6J77aREfO7ApnHuC/UG5jVIMqFBWGNJTeXAvuNZ2Uk9iVgTD08hwC++7tXZJ+iEOzOgzVa/Sfk8T5UasMMUZ8b0BgG6i9xK66D9NABS8J2fV9DqwQCv5u4Sisy+jAS0f2vSHKHWGXBWldJPlKHdGlRF2Vxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758719685; c=relaxed/simple;
	bh=42TZfDlrBPMg0QL1U0JM4x8oQpt83ul9w5SV6JoSJug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZXSU4xRLuSXPdZXd0GTBsvmTytHMj2AC9ZSrGQYqm1vrptXB3Gt3YUkEHAL8j5AkC66F/nRqIlXtAPsVqetq/1E61IR2lNkboMSiwdtnQFt0FOcRgrKKOKcF9Dl4I3xOlBe5qsrtTVvPrPSMxiow7CX5oknFAJG5bt9/P1gkEOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eWuIalby; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O2PCkY019271;
	Wed, 24 Sep 2025 13:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=P4fQhasQ6oHM/lbHpiFD465Y89sg
	YnBTE5zZ27pgfH0=; b=eWuIalbyGfEIk0AGuBT6CRwtK+K6OxUpqKWSB5NEvSw3
	iXiq1/H4qlRMSYOqw2HIWoyt5fsraz311blL30gj9pollEGg6S/3uUb/cJtIaelQ
	kLEVSkIakqD4TPOJPoehHwHKlocXxQBa0T0zc8s5r2u2R+mg/1llRF9TCWJPU8sj
	tUnIw7u38D2BR8DjZiP8Mk8cDVe4GR7GN6AQ+xHs5/PJQK3BUfBdg8PSo6dHd6Lu
	N3MldLI896E1fJ29acmKQeK6y5ycgM+Ft3pTbeWzy2xVXbSIg3vtI4A/fiwmAUwe
	g4f7NT+JJB9nr1klJKUiZYBkLbkhSEescIMNxzxfJQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ksbyp83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 13:14:43 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58OCxPL1001737;
	Wed, 24 Sep 2025 13:14:42 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ksbyp80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 13:14:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58O99k1Q031109;
	Wed, 24 Sep 2025 13:14:41 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49b9vd9pxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 13:14:41 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58ODEeKR49086794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 13:14:40 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B819458057;
	Wed, 24 Sep 2025 13:14:40 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F5C158059;
	Wed, 24 Sep 2025 13:14:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Sep 2025 13:14:38 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 24 Sep 2025 15:14:29 +0200
Subject: [PATCH] PCI: s390: Expose the UID as an arch specific PCI slot
 attribute
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-uid_slot-v1-1-09ae04f48c57@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIALTu02gC/23MSwqDMBSF4a3IHTeSB8HaUfdRpKTXpF5QI4kGi
 2TvTR13+B8O3wHRBrIRbtUBwSaK5OcS4lIBDmZ+W0Z9aZBcat5KxTbqn3H0K7NK6xadRqM4lPs
 SrKP9pB5d6YHi6sPnlJP4rX+QJJhgqtESTYPuatR9pHnba3pNNfoJupzzF4xzLhqkAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4730;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=42TZfDlrBPMg0QL1U0JM4x8oQpt83ul9w5SV6JoSJug=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDIuv9u7zOLSoSrzEO4FBfmpk4Mmd1csz7508qDpab8fs
 3+rHm793FHKwiDGxSArpsiyqMvZb13BFNM9Qf0dMHNYmUCGMHBxCsBEpjYwMiwS107Y5OS759jr
 5796dZOty1IW9j9dlvrpKOvCH4k/399j+O831Un50hNf82xGjRfRAmX3y3om3t5X7sH55IOnq8L
 iRnYA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BnkRFtZA5WffCk2dcD9pR653rxQFQLIv
X-Proofpoint-GUID: msnirYatFbxhJwT7Xomj6jd_UmW6k-KT
X-Authority-Analysis: v=2.4 cv=SdH3duRu c=1 sm=1 tr=0 ts=68d3eec3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=AQEDfA8N-JhHbHfKeYEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfXz7Lf0B432/U/
 geqV6Bfml7nvzpRo3hpo3IXKO8rM1r06tNi8nMTQrJF1Lw3TU4SBXctKWAb5F19wMtsN1Voq/QM
 KURN3kgD6ZlMzQEfC96U+AF+ZYt6JqGjA7iMWRVUPo7FdRaUt/PI4zxush1HJTv1uG9SWIJfynI
 BPAKAPrM6C1vCSTi8N+qn63k6pwYzOeanQz5aZhS123vI9kbhLL9B/d6mlrzqrpTasISyz6sJ/9
 S2O5XT2G0feCyd7fn508FSmpTWFLqyNbGGzan4puNt6Y2+4Kpl4i3UdTVnk5krKEhHE5KqMEJo+
 eklsT6bbygusa1pEjuo/tqHe3EHeXCuCCVH37dFG2WgPUE3l0+FmjNJqbphbIKP+shiHIyjwWNy
 +EY7f0F4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020

On s390, an individual PCI function can generally be identified by two
IDs, depending on the scope and the platform configuration.

The first ID is the so-called FID, which is always available and
identifies a PCI device uniquely within a machine. The FID may be
virtualized by hypervisors, but on the LPAR level, the machine scope
makes it impossible to reuse the same configuration based on FIDs on two
different LPARs.

Such matching LPAR configurations are useful, though, allowing
standardized setups and booting a Linux installation on different
machines. To allow this, a second user-defined identifier called UID was
introduced. It is only guaranteed to be unique within an LPAR and only
if the platform indicates so via the UID Checking flag.

On s390, which uses a machine hypervisor, a per PCI function hotplug
model is used. The shortcoming with the UID then is, that it is not
visible to the user without first attaching the PCI function and
accessing the "uid" device attribute. The FID, on the other hand, is
used as slot number and is thus known even with the PCI function in
standby.

Remedy this shortcoming by providing the UID as an attribute on the slot
allowing the user to identify a PCI function based on the UID without
having to first attach it. Do this via a macro mechanism analogous to
what was introduced by commit 265baca69a07 ("s390/pci: Stop usurping
pdev->dev.groups") for the PCI device attributes.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note: I considered adding the UID as a generic "index" via the hotplug
slot driver but opted for a minimal solution to open the discussion. In
particular my concern with a generic attribute is that it would be hard
to find a format that fits everyone. For example on PCI devices we also
use the "index" attribute for UIDs analogous to SMBIOS but having it in
decimal is odd on s390 where these are usual in hexadecimal.
---
 arch/s390/include/asm/pci.h |  4 ++++
 arch/s390/pci/pci_sysfs.c   | 20 ++++++++++++++++++++
 drivers/pci/slot.c          | 13 ++++++++++++-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 41f900f693d92522ff729829e446b581977ef3ff..23eed78d9dce72ef466679f31c78aca52ba00f99 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -207,6 +207,10 @@ extern const struct attribute_group zpci_ident_attr_group;
 			    &pfip_attr_group,		 \
 			    &zpci_ident_attr_group,
 
+extern const struct attribute_group zpci_slot_attr_group;
+
+#define ARCH_PCI_SLOT_GROUPS (&zpci_slot_attr_group)
+
 extern unsigned int s390_pci_force_floating __initdata;
 extern unsigned int s390_pci_no_rid;
 
diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
index 0ee0924cfab7e5d22468fb197ee78cac679d8c13..997dff3796094680d9a3f0b6eb27a89fa1ed30b2 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -178,6 +178,17 @@ static ssize_t index_show(struct device *dev,
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
@@ -233,3 +244,12 @@ const struct attribute_group pfip_attr_group = {
 	.name = "pfip",
 	.attrs = pfip_attrs,
 };
+
+static struct attribute *zpci_slot_attrs[] = {
+	&zpci_slot_attr_uid.attr,
+	NULL,
+};
+
+const struct attribute_group zpci_slot_attr_group = {
+	.attrs = zpci_slot_attrs,
+};
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 50fb3eb595fe65e271b6b339d43c9677c61b1e45..7430c7df44e1beef7bcf0531491612734e0dd60c 100644
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
+const struct attribute_group *pci_slot_default_groups[] = {
+	&pci_slot_default_group,
+#ifdef ARCH_PCI_SLOT_GROUPS
+	ARCH_PCI_SLOT_GROUPS,
+#endif
+	NULL,
+};
 
 static const struct kobj_type pci_slot_ktype = {
 	.sysfs_ops = &pci_slot_sysfs_ops,

---
base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
change-id: 20250923-uid_slot-e3559cf5ca30

Best regards,
-- 
Niklas Schnelle


