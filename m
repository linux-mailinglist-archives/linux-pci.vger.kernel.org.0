Return-Path: <linux-pci+bounces-38801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C1EBF31A4
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 21:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8EF4814D3
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 19:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C972D63E8;
	Mon, 20 Oct 2025 19:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NqnUGszh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26312C11C5;
	Mon, 20 Oct 2025 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986934; cv=none; b=QJVDuAJ1zoj5Jm6KEgVeCkdxoSp0eLPPrZGTt+psxQkt2Jt/jHak5mCB7ogdNi9vmruSKic0/Z3spvRyuZbKSCKWgCyc++H2VDhnKCeTXEwuDm32iSh5QOrxNM8ZO8D60dAaKfFxLDUMaokoNHktzVOGQXlYKji1JotoN/ehFwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986934; c=relaxed/simple;
	bh=cnc5hRkXUmMzOETcq1VMwyak2D+gw4yevf64NgjFnn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRNC5a+NeFhXdcX7mboUL9ZgORKt/XEy31eG1givK3lgTW7R291TUQho2drtod+K8hvuYPbCG+eKbUIPFO4SMsvx2o+85U6fjYcpjvAc8TzWAqkDoiKOtTe21GhXJu2MQgq6grRuBY5H6pbiI7bI/1C4qiymrYsyP7XBKLX3z2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NqnUGszh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KDOeYY004702;
	Mon, 20 Oct 2025 19:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FYUBZ9TiUvXt0GRbI
	snbFOUxr8hsRX5GriV4e+8yR8k=; b=NqnUGszhNXoCYov30yeRrIhXQwmPNASS0
	oK/zaOdRNMv3L5wMTl/dEfy9fPdRrzt+KaHnhvIb0/iJ53VHLx5Rae0d5uyXoqju
	36FpS84wP6G/TO52QbShe5x3ECabAql4REb9pwKTB3NZSCXBTCGzydaUkjZfESsW
	RkqLHMXCb0QTG7zhHssZDUzdEEOaOkOn50CmTxOYndRfl69PgrI6OzP2ttqBt0a+
	R/0rPr+zaSfmA/4ghN4E160VtMXR+Ih7fMlGvNI5TITHfAVeCl+yOPSaGpchvYKp
	i6Ssrky5Syrq3EH5UnHxbS1sfe8P6Gu17TvdfCnD7LFOqHaY8Dy1Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31c239q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 19:02:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KFZ9i8011053;
	Mon, 20 Oct 2025 19:02:07 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx0xwk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 19:02:07 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59KJ25Dv48365944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 19:02:05 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6456F5805A;
	Mon, 20 Oct 2025 19:02:05 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3BDF58060;
	Mon, 20 Oct 2025 19:02:04 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.240.93])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Oct 2025 19:02:04 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, stable@vger.kernel.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v1 1/3] PCI: Allow per function PCI slots
Date: Mon, 20 Oct 2025 12:01:58 -0700
Message-ID: <20251020190200.1365-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020190200.1365-1-alifm@linux.ibm.com>
References: <20251020190200.1365-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ixeYz5UtFFuc_ou0jAQQH7_FsCDay-eP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXyOlRsn5S5Kgj
 Qpa4DNX1ufcEw/BlnkvWOs094bgAdIWLNol8Y2BtmWsjupi8j62EzB+sloKw2X5U9e87273lVhV
 lydDn44v3akAoCRKXFpvMYvK3l1KPkBN1E2iFlhtmg1fmy1iwgesrJ8ZJzcE1jH0Toxj8MOZJBe
 TnuAiXv/O7JlaF2lk2mXZ07YTIRsAWfdAj31lDRD+z6yvZaTEpKay+kXcWSkWuuV4pAB7erca/C
 bSxE1G3+DbRSDgbtS8WcB83gY1GmMOWtPk/Lve0D7LPKuWhvM5h5Y9V2GPzg3MrXhhe4fCOcYmV
 kn2jsoe0DgTvIgnlHPjXuuDkHAJ9BhyF6PB1n4gpZi8WxFjv6HzqsGl5NNFJtgan0qEnP7whQG9
 699ma9VVDEFctoztkksW19RLOdummg==
X-Proofpoint-GUID: ixeYz5UtFFuc_ou0jAQQH7_FsCDay-eP
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f68730 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=K-1LnuYzVcpd1HOvht4A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On s390 systems, which use a machine level hypervisor, PCI devices are
always accessed through a form of PCI pass-through which fundamentally
operates on a per PCI function granularity. This is also reflected in the
s390 PCI hotplug driver which creates hotplug slots for individual PCI
functions. Its reset_slot() function, which is a wrapper for
zpci_hot_reset_device(), thus also resets individual functions.

Currently, the kernel's PCI_SLOT() macro assigns the same pci_slot object
to multifunction devices. This approach worked fine on s390 systems that
only exposed virtual functions as individual PCI domains to the operating
system.  Since commit 44510d6fa0c0 ("s390/pci: Handling multifunctions")
s390 supports exposing the topology of multifunction PCI devices by
grouping them in a shared PCI domain. When attempting to reset a function
through the hotplug driver, the shared slot assignment causes the wrong
function to be reset instead of the intended one. It also leaks memory as
we do create a pci_slot object for the function, but don't correctly free
it in pci_slot_release().

Add a flag for struct pci_slot to allow per function PCI slots for
functions managed through a hypervisor, which exposes individual PCI
functions while retaining the topology.

Fixes: 44510d6fa0c0 ("s390/pci: Handling multifunctions")
Cc: stable@vger.kernel.org
Suggested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/hotplug/s390_pci_hpc.c | 10 ++++++++--
 drivers/pci/pci.c                  |  5 +++--
 drivers/pci/slot.c                 | 14 +++++++++++---
 include/linux/pci.h                |  1 +
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/s390_pci_hpc.c b/drivers/pci/hotplug/s390_pci_hpc.c
index d9996516f49e..8b547de464bf 100644
--- a/drivers/pci/hotplug/s390_pci_hpc.c
+++ b/drivers/pci/hotplug/s390_pci_hpc.c
@@ -126,14 +126,20 @@ static const struct hotplug_slot_ops s390_hotplug_slot_ops = {
 
 int zpci_init_slot(struct zpci_dev *zdev)
 {
+	int ret;
 	char name[SLOT_NAME_SIZE];
 	struct zpci_bus *zbus = zdev->zbus;
 
 	zdev->hotplug_slot.ops = &s390_hotplug_slot_ops;
 
 	snprintf(name, SLOT_NAME_SIZE, "%08x", zdev->fid);
-	return pci_hp_register(&zdev->hotplug_slot, zbus->bus,
-			       zdev->devfn, name);
+	ret = pci_hp_register(&zdev->hotplug_slot, zbus->bus,
+				zdev->devfn, name);
+	if (ret)
+		return ret;
+
+	zdev->hotplug_slot.pci_slot->per_func_slot = 1;
+	return 0;
 }
 
 void zpci_exit_slot(struct zpci_dev *zdev)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006c..36ee38e0d817 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4980,8 +4980,9 @@ static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, bool probe)
 
 static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
 {
-	if (dev->multifunction || dev->subordinate || !dev->slot ||
-	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
+	if (dev->subordinate || !dev->slot ||
+	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
+	    (dev->multifunction && !dev->slot->per_func_slot))
 		return -ENOTTY;
 
 	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 50fb3eb595fe..51ee59e14393 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -63,6 +63,14 @@ static ssize_t cur_speed_read_file(struct pci_slot *slot, char *buf)
 	return bus_speed_read(slot->bus->cur_bus_speed, buf);
 }
 
+static bool pci_dev_matches_slot(struct pci_dev *dev, struct pci_slot *slot)
+{
+	if (slot->per_func_slot)
+		return dev->devfn == slot->number;
+
+	return PCI_SLOT(dev->devfn) == slot->number;
+}
+
 static void pci_slot_release(struct kobject *kobj)
 {
 	struct pci_dev *dev;
@@ -73,7 +81,7 @@ static void pci_slot_release(struct kobject *kobj)
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &slot->bus->devices, bus_list)
-		if (PCI_SLOT(dev->devfn) == slot->number)
+		if (pci_dev_matches_slot(dev, slot))
 			dev->slot = NULL;
 	up_read(&pci_bus_sem);
 
@@ -166,7 +174,7 @@ void pci_dev_assign_slot(struct pci_dev *dev)
 
 	mutex_lock(&pci_slot_mutex);
 	list_for_each_entry(slot, &dev->bus->slots, list)
-		if (PCI_SLOT(dev->devfn) == slot->number)
+		if (pci_dev_matches_slot(dev, slot))
 			dev->slot = slot;
 	mutex_unlock(&pci_slot_mutex);
 }
@@ -285,7 +293,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &parent->devices, bus_list)
-		if (PCI_SLOT(dev->devfn) == slot_nr)
+		if (pci_dev_matches_slot(dev, slot))
 			dev->slot = slot;
 	up_read(&pci_bus_sem);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1fdf81fbe1e..6ad194597ab5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -78,6 +78,7 @@ struct pci_slot {
 	struct list_head	list;		/* Node in list of slots */
 	struct hotplug_slot	*hotplug;	/* Hotplug info (move here) */
 	unsigned char		number;		/* PCI_SLOT(pci_dev->devfn) */
+	unsigned int		per_func_slot:1; /* Allow per function slot */
 	struct kobject		kobj;
 };
 
-- 
2.43.0


