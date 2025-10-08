Return-Path: <linux-pci+bounces-37708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8F0BC4BF6
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 14:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D293E1F76
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 12:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B65A1F5433;
	Wed,  8 Oct 2025 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PJ6QysbO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2831C84A2;
	Wed,  8 Oct 2025 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759925819; cv=none; b=XzbWmSMEt7k/Swgt1LHM/tkV6RRmyAVGr5Qryp0pABvpdNGRfH1Lq8krH/lKTtWQDmRpMvbkmw//BfjUAwoyeCCvhNAfub1/J2l3ga9NBCWoi2MW0eOwA08BDg8fzadVTIMXCm/rrXMZBk0mg3xqT92lGJySElx2LTEfIZuap2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759925819; c=relaxed/simple;
	bh=eAHdmLR4oZyEKurr43V+oHcALn75l8FScvxfru0CUNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cFJBGeZFjpnISMC5nGW9uT853DJfvNRJFGnKOmbvh0udSIXpyfjWEIt6y6ArBan1FAxHDwFenRtWDKh+LpQTtSukDmX72pjStOAdz6wYIiOm/CU+K+gw9dlkpQk5T6yM3PbFk0wAPPVJCJmIHYXN3nhscxMgPhwsJbh5tXsfyHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PJ6QysbO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5984Jqw4026964;
	Wed, 8 Oct 2025 12:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=FNfuJA8ilq797+M+ztA15mYq/rke
	H12cgl1x87R6vvc=; b=PJ6QysbO6s0e/Y+nL3m7IK5DSfjzEPxQwPzeVKHdww9p
	ENbyw+3I8W/hXHs0zXlxavrTPvlQ1MySaqFFrDsy0QjfjxhnY1CpaIjKCnaE+MkE
	ptr/ymssh3MYmp+Fuyhz4RCJOQ5P/liV1+N6sXmIJKvJKi+bcR8HSTrk0/EcBD+b
	3+lispbOxL18rgle3zAsf6I30iwJm88pPIIZD5At66VR4LHng8Zwq+bghxAsGbH8
	x3xXUGdHO0Bm69uSuQK4HiNrDTBd5JRTL9oeTE8tFLo0hRaKnr73kGXi2KULInVt
	k0x6G+V8By3+XNvOmUx/VmHrhNFJp17T5Dc47uv7gg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju3h4y92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 12:16:56 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 598CCl6f028121;
	Wed, 8 Oct 2025 12:16:55 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju3h4y8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 12:16:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 598BNJC4013317;
	Wed, 8 Oct 2025 12:16:54 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49kg4jr4wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 12:16:54 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 598CGqUk31982080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Oct 2025 12:16:52 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 963A25805A;
	Wed,  8 Oct 2025 12:16:52 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB53358054;
	Wed,  8 Oct 2025 12:16:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Oct 2025 12:16:49 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 08 Oct 2025 14:16:36 +0200
Subject: [PATCH v2] PCI: s390: Expose the UID as an arch specific PCI slot
 attribute
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-uid_slot-v2-1-ef22cef27741@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIACNW5mgC/22MwQqDMBAFf0VybiQmBrWn/keRkq6buqCmJCoW8
 d8bpSfpcR5vZmUBPWFg12RlHmcK5IYI8pIwaM3wQk5NZCaF1KKSik/UPELnRo5K6wqsBqMEi/e
 3R0vLkbrXkVsKo/Ofozxn+/onMmc846rQEkwBtjTq1tEwLSk9+xRcv3d/Un6SRGVQ5DYvQRcnq
 d627QuTQ6Mu2QAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5082;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=eAHdmLR4oZyEKurr43V+oHcALn75l8FScvxfru0CUNA=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDKehRmeORfodiWsIO3A2eoGPt/FFXpzrYrOVocLX+vtc
 u99sKu9o5SFQYyLQVZMkWVRl7PfuoIppnuC+jtg5rAygQxh4OIUgIkcsmNkmPbg1ZpFP12bd2mq
 l71b1jDF+V7sqh2z1zEuvRt0fvMV11iGP1zNHMvs4vbb7pnhHcFg2T5TifN/5sG/00vPHLp/JdX
 yJwsA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOCBTYWx0ZWRfXxrVif7M3Y0Ez
 euDjQrgyJ7XICXbeYVciNJBl/w79BODWZaiNPCVDD44Yg6ckIuRjgao1A8YPE8P3g85GjkzIKc7
 a0lggd1Q5hs9VB4UStyArinJ1GsrMMMvibVU3ec2wDZS9BLbYEgpEm4LgCabWb9JZjIDIkMpEHR
 D/VPTE+tDnzEW3lqhZ1f5l3+nXtpr+PFZ+73hewyzfJQ6b5sre4EaljA+vT8uOZV5jXMXBccr6G
 f0QVI3NskrDUgOV+9oXb9OKWvIlQwijSMmUdTM68JtGEiV9KzO3V6GoKtQK/wZjlN5IxvD51qFZ
 inKJKvnu8eDltXNE6DCpTfP7JfdjAx7/jq7LYAsfdme4Z+bU2p5VvQh4rq28qwCrEonP0Tqppix
 ysa1c3VT5edY/SfcLMW2eCvr9FqEzg==
X-Authority-Analysis: v=2.4 cv=I4dohdgg c=1 sm=1 tr=0 ts=68e65638 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=AQEDfA8N-JhHbHfKeYEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YnXi2Uqsa7jkn_xVOXrGLL9pKpmilfJm
X-Proofpoint-ORIG-GUID: wgN4ZSqhxIfhlISj3yDjzA4ul7AMNDaG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040018

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
slot driver but opted for a minimal solution to open the discussion. In
particular my concern with a generic attribute is that it would be hard
to find a format that fits everyone. For example on PCI devices we also
use the "index" attribute for UIDs analogous to SMBIOS but having it in
decimal is odd on s390 where these are usual in hexadecimal.
---
Changes in v2:
- Reword commit message (Ramesh, Gerd, Benjamin)
- Add "static" on pci_slot_default_groups() (kernel test robot)
- Link to v1: https://lore.kernel.org/r/20250924-uid_slot-v1-1-09ae04f48c57@linux.ibm.com
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
base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
change-id: 20250923-uid_slot-e3559cf5ca30

Best regards,
-- 
Niklas Schnelle


