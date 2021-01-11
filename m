Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2DC2F0F44
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jan 2021 10:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbhAKJjq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jan 2021 04:39:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36954 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727915AbhAKJjp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jan 2021 04:39:45 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10B9WNXe035651;
        Mon, 11 Jan 2021 04:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=yTfOc+eDKqFMMFf7FN0ReIS9NkA9YfK5RVQTgUQghIA=;
 b=SnLxhwVXqwVQHxF2/HFMvs66/MbX2j3YS++EP8NemDOX1GJuAfbUpub+GXEpiCpbqCtG
 AX/hQw+GYMelMQ5i8dFdCGPvQq3s+XMFL+0c5Fb9cbkJe2FfTPOAbhLFVGv2nGBd4lMV
 6RKSs3OkZLuuA301qdL95GVDLVZ3bu5SHMBoCLemzUcN5FJm8QUH+vtsiDCKG/C9N0HI
 5lVqiiF+MRpwWDFppee+TQmfQnCbcSdc7mQDIsCRdWirtWoiTXuKtXtcgIloPWti+gfV
 Kw8QSxT9z8p/gem5oG5COX4r0eRFlqBrwtBF22cNzw2zkIyRIN/KVR6SQctlkKlbMnX5 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 360jyc2c1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jan 2021 04:39:03 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10B9X4Am038468;
        Mon, 11 Jan 2021 04:39:03 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 360jyc2c0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jan 2021 04:39:03 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10B9WrRW025114;
        Mon, 11 Jan 2021 09:39:01 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3604h98cpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jan 2021 09:39:01 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10B9cw0d29622654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jan 2021 09:38:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD7B2AE057;
        Mon, 11 Jan 2021 09:38:58 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F566AE056;
        Mon, 11 Jan 2021 09:38:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Jan 2021 09:38:58 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
Subject: [RFC 1/1] s390/pci: expose UID checking state in sysfs
Date:   Mon, 11 Jan 2021 10:38:57 +0100
Message-Id: <20210111093857.24070-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210111093857.24070-1-schnelle@linux.ibm.com>
References: <20210111093857.24070-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-09_13:2021-01-07,2021-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1011 mlxscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101110055
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We use the UID of a zPCI adapter, or the UID of the function zero if
there are multiple functions in an adapter, as PCI domain if and only if
UID Checking is turned on.
Otherwise we automatically generate domains as devices appear.

The state of UID Checking is thus essential to know if the PCI domain
will be stable, yet currently there is no way to access this information
from userspace.
So let's solve this by showing the state of UID checking as a sysfs
attribute in /sys/bus/pci/uid_checking

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 11 ++++++++
 arch/s390/include/asm/pci.h             |  3 +++
 arch/s390/pci/pci.c                     |  4 +++
 arch/s390/pci/pci_sysfs.c               | 34 +++++++++++++++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 25c9c39770c6..a174aac0ebb0 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -375,3 +375,14 @@ Description:
 		The value comes from the PCI kernel device state and can be one
 		of: "unknown", "error", "D0", D1", "D2", "D3hot", "D3cold".
 		The file is read only.
+What:		/sys/bus/pci/zpci/uid_checking
+Date:		December 2020
+Contact:	Niklas Schnelle <schnelle@linux.ibm.com>
+Description:
+		This attribute exposes the global state of UID Checking on
+		an s390 Linux system. If UID Checking is on this file
+		contains '1' otherwise '0'. If UID Checking is on the UID of
+		a zPCI device, or the UID of function zero for a multi-function
+		device will be used as its PCI Domain number. If UID Checking
+		is off PCI Domain numbers are generated automatically and
+		are not stable across reboots.
diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 212628932ddc..3cfa6cc701ba 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -285,6 +285,9 @@ void zpci_debug_exit_device(struct zpci_dev *);
 /* Error reporting */
 int zpci_report_error(struct pci_dev *, struct zpci_report_error_header *);
 
+/* Sysfs Entries */
+int zpci_sysfs_init(void);
+
 #ifdef CONFIG_NUMA
 
 /* Returns the node based on PCI bus */
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 41df8fcfddde..c16c93e5f9af 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -881,6 +881,10 @@ static int __init pci_base_init(void)
 	if (rc)
 		goto out_find;
 
+	rc = zpci_sysfs_init();
+	if (rc)
+		goto out_find;
+
 	s390_pci_initialized = 1;
 	return 0;
 
diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
index 5c028bee91b9..d00690f73539 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -172,3 +172,37 @@ const struct attribute_group *zpci_attr_groups[] = {
 	&pfip_attr_group,
 	NULL,
 };
+
+/* Global zPCI attributes */
+static ssize_t uid_checking_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%i\n", zpci_unique_uid);
+}
+
+static struct kobj_attribute sys_zpci_uid_checking_attr =
+	__ATTR(uid_checking, 0444, uid_checking_show, NULL);
+
+static struct kset *zpci_global_kset;
+
+static struct attribute *zpci_attrs_global[] = {
+	&sys_zpci_uid_checking_attr.attr,
+	NULL,
+};
+
+static struct attribute_group zpci_attr_group_global = {
+	.attrs = zpci_attrs_global,
+};
+
+int __init zpci_sysfs_init(void)
+{
+	struct kset *pci_bus_kset;
+
+	pci_bus_kset = bus_get_kset(&pci_bus_type);
+
+	zpci_global_kset = kset_create_and_add("zpci", NULL, &pci_bus_kset->kobj);
+	if (!zpci_global_kset)
+		return -ENOMEM;
+
+	return sysfs_create_group(&zpci_global_kset->kobj, &zpci_attr_group_global);
+}
-- 
2.17.1

