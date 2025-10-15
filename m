Return-Path: <linux-pci+bounces-38223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4BFBDECB3
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 15:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A47C54E8991
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 13:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1718018BC3D;
	Wed, 15 Oct 2025 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SmdzxGXe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2FA23E358;
	Wed, 15 Oct 2025 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760535747; cv=none; b=L/DAoQx5GJONkaNnDJg2OC0dWG6ynguX2H44T77h2ixRwHF+mtAsiaKuHG1mpvZ2w1SVxpOuV4PvdPjfFFC2GvLs8qRaqgYVXVdgIi1uIxUDArO2R+jg0SV4H96wybdO8UHShXxL1TR3gcpjUknYRzVH7ufy7o0a431/eW30FQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760535747; c=relaxed/simple;
	bh=fSm1UKgyjrVTgM8+oVh4wEFesG4G5AUEz8jdCj3Z8LU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MLGUPnjZN9Ig8P24569kpDysTY06xw1aeR7K3thxVlQNwaWq/6+89kdG2MbWvJ8dh3450NGMnzj6URGO0Q36hEi02q+WMAtWMTKNgyOu5NXbeqEgdvLtX3t+PShss52hzL0BH6QM2+rbkJLqmZMy95defr578piDvDdBQHih6MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SmdzxGXe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FD9FfN032280;
	Wed, 15 Oct 2025 13:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=BN0deS7WO7t/vzOAI7cZJxe7FsOx
	r1YGnQnfIMrtkms=; b=SmdzxGXeJbgnHs9R19v4uomeq7F4rPtjdt5tQbHLivQX
	dSD3TeCJI2poNn8RlivOVKrw2lDtzb2EhPil8ImTWjiM5YVjGNHzjUGJcFZjGPD/
	e3fcXLpJjpezCBbsDKaVWu5p7gHRtA4L6BnmH7LUglkOhxodif7FWxTcim2LzbAE
	6EfjoXmIEFvSkazygmCEDfcIIy36siTN7N3uDK+zmIpHUkVDMMOieYbhfpflDk02
	Ny/NEPB3fyLadL5Cn5ON7EtVOIBMfsERyEyKMY8Cm6trExpXelCVraHvBqLiMrij
	07X5wv7td/WrIltX9FFRZjHKDfm328euuOKY7KmN4g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp7yp72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 13:42:23 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59FDgNGS031398;
	Wed, 15 Oct 2025 13:42:23 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp7yp6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 13:42:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59FD1mTx015259;
	Wed, 15 Oct 2025 13:42:22 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r1js8umf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 13:42:22 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59FDgKsF50725122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 13:42:20 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FED458056;
	Wed, 15 Oct 2025 13:42:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E4E75805E;
	Wed, 15 Oct 2025 13:42:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Oct 2025 13:42:17 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 15 Oct 2025 15:42:12 +0200
Subject: [PATCH v3] PCI: s390: Expose the UID as an arch specific PCI slot
 attribute
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-uid_slot-v3-1-44389895c1bb@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIALOk72gC/22N7QqCMBiFbyX2u8k+mfar+4iINbd8QV1sOgzx3
 psSEdKfF87LeZ4zo2gD2IhOhxkFmyCC73PgxwMyje4fFkOdM2KESVIxjkeob7H1A7Zcyso4aTQ
 nKNefwTqYNtXlmnMDcfDhtZkTXb9/JIliirmSzGhlXKn5uYV+nAq4d4Xx3er9QGIHkUpbIpwoj
 VQ7aF1P7LtICSl/YJZh6xgz+Sgl6B5eluUNa/+jlBYBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4847;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=fSm1UKgyjrVTgM8+oVh4wEFesG4G5AUEz8jdCj3Z8LU=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDLeL9l5xWrxY0fOjhdtCmc3XuZcLMI5VXhu/Jx6X8noQ
 77Cexr/d5SyMIhxMciKKbIs6nL2W1cwxXRPUH8HzBxWJpAhDFycAjCRY5sZGZ4ztP4UX/bzSKPv
 6Z3rMg24Xh6PTTylIKkT3+tUEKGi5cLwT3HllIVMdc8/Wuxc0HDnno3R6uXTp8ZzW0++/EblnMj
 5SRwA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G0vbbpmx7dG846PuEkjNWzCv47Ftu5I7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfX0Hqyndm/lybr
 KPBDEvs3I4ZHDPpQcQ8W9jp5CWfy+wES93d1LJ/865b3lMh9jfgk1TTHoN670Xdl+YdexkmnrVH
 NCwFodXvfo0MAMPyOhOoITtWFGkH9AO0B2C5GlgpRv4VcmHa2g/ju2jPIVSM679pACziYWI+hy6
 RiONeeC/ShQbOkimC2Hw9T4zw9hux7V/Yr5sKqlY3caZW96nFuNg6WRzPtuwNryr3DI6/McIqoD
 EtakJnGKN0FuafCD/9v6lTl06UB6TY9J1Z1mFMM3MZ66Ua5WvsMBp+qyuNr2z1Mx0ZDe5ENeLTY
 c0Nykxp/tX9ScB3rC39hrgEf/iYg5VtD5ASxs5j7ZeWm6njzRNyC8+cbIwNeXe7sjAS4lIw0sLM
 U/s1jM77JYOl79AKBvLfyzjka4r9kg==
X-Proofpoint-GUID: 1AWpp5MTpMoIFSs2hvn6WDiJVNNlmi8O
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68efa4c0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=1abmahkF_O1uCEefIxsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084

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

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note: I considered adding the UID as a generic "index" via the hotplug
slot driver but felt like there is probably too little commonality on
format and usage patterns.

v2->v3:
- Rebase on v6.18-rc1 and resolve conflict with recent s390 PCI sysfs change
- Link to v2: https://lore.kernel.org/r/20251008-uid_slot-v2-1-ef22cef27741@linux.ibm.com
---
 arch/s390/include/asm/pci.h |  4 ++++
 arch/s390/pci/pci_sysfs.c   | 20 ++++++++++++++++++++
 drivers/pci/slot.c          | 13 ++++++++++++-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 6890925d5587b1825cc51ac7e2be2003132244da..ffe63be00484fc9b38ce2f2437cddcaced621b03 100644
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
index 12060870e2aa167c58a690d584f0268b1347fbfe..f85e297a6e6ccdc841524ca2611a361012148a0a 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -188,6 +188,17 @@ static ssize_t index_show(struct device *dev,
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
@@ -244,6 +255,15 @@ const struct attribute_group pfip_attr_group = {
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
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20250923-uid_slot-e3559cf5ca30

Best regards,
-- 
Niklas Schnelle


