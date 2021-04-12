Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF55B35C80F
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 15:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242052AbhDLN7c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Apr 2021 09:59:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240036AbhDLN7b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Apr 2021 09:59:31 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CDXHfA046813;
        Mon, 12 Apr 2021 09:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=O4baydVhQPQYaGDwD8nWIjnD2KePthLqJGujPlUrD9c=;
 b=s1kUDYAjB8seMopz/6M+M8ayC2vZF3NIb97/D1SDOIGtuBWVoKEfTt1kMN24FewXvFnt
 Kp20dJHM/kYGjBWl4nKr3bQWDwMBlAmevAHP8JKxYRUHV/cKoQ8PrxEpXK9tcbl3m1h0
 /Ge5XLYdP2Y+KAmu2zL4saJtEgWaDjSIVJGOsVJaBaXP0oNxdeMu2NJGGS9+ggC6q+AH
 QE/gq6DetYs56AVJAbk6XEMrbRlWLjVMD9VGwIA0I7nrROyTr87KQj95EywUPw2sUj5C
 YYuenboZ+xQkg/OPZyHrEm6eJDjSTREXA8+KR6N2eqIEYppxD712JTaPwjTolEliZSc3 mQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37vpwehr97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 09:59:12 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13CDvkxM015885;
        Mon, 12 Apr 2021 13:59:09 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 37u39hhvdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 13:59:09 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13CDx6dH48169302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 13:59:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6523C4204B;
        Mon, 12 Apr 2021 13:59:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15C6E4203F;
        Mon, 12 Apr 2021 13:59:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Apr 2021 13:59:06 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Narendra K <narendra_k@dell.com>
Cc:     Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/1] s390/pci: expose a PCI device's UID as its index
Date:   Mon, 12 Apr 2021 15:59:05 +0200
Message-Id: <20210412135905.1434249-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412135905.1434249-1-schnelle@linux.ibm.com>
References: <20210412135905.1434249-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C_coBcyeucwDOldjP8Fxn4HAQYCuBkSF
X-Proofpoint-ORIG-GUID: C_coBcyeucwDOldjP8Fxn4HAQYCuBkSF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_10:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120091
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On s390 each PCI device has a user-defined ID (UID) exposed under
/sys/bus/pci/devices/<dev>/uid. This ID was designed to serve as the PCI
device's primary index and to match the device within Linux to the
device configured in the hypervisor. To serve as a primary identifier
the UID must be unique within the Linux instance, this is guaranteed by
the platform if and only if the UID Uniqueness Checking flag is set
within the CLP List PCI Functions response.

In this sense the UID serves an analogous function as the SMBIOS
instance number or ACPI index exposed as the "index" respectively
"acpi_index" device attributes and used by e.g. systemd to set interface
names. As s390 does not use and will likely never use ACPI nor SMBIOS
there is no conflict and we can just expose the UID under the "index"
attribute whenever UID Uniqueness Checking is active and get systemd's
interface naming support for free.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Acked-by: Viktor Mihajlovski <mihajlov@linux.ibm.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 11 +++++---
 arch/s390/pci/pci_sysfs.c               | 35 +++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 25c9c39770c6..1241b6d11a52 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -195,10 +195,13 @@ What:		/sys/bus/pci/devices/.../index
 Date:		July 2010
 Contact:	Narendra K <narendra_k@dell.com>, linux-bugs@dell.com
 Description:
-		Reading this attribute will provide the firmware
-		given instance (SMBIOS type 41 device type instance) of the
-		PCI device. The attribute will be created only if the firmware
-		has given an instance number to the PCI device.
+		Reading this attribute will provide the firmware given instance
+		number of the PCI device.  Depending on the platform this can
+		be for example the SMBIOS type 41 device type instance or the
+		user-defined ID (UID) on s390. The attribute will be created
+		only if the firmware has given an instance number to the PCI
+		device and that number is guaranteed to uniquely identify the
+		device in the system.
 Users:
 		Userspace applications interested in knowing the
 		firmware assigned device type instance of the PCI
diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
index e14d346dafd6..20dbb2058d51 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -138,6 +138,38 @@ static ssize_t uid_is_unique_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(uid_is_unique);
 
+#ifndef CONFIG_DMI
+/* analogous to smbios index */
+static ssize_t index_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
+	u32 index = ~0;
+
+	if (zpci_unique_uid)
+		index = zdev->uid;
+
+	return sysfs_emit(buf, "%u\n", index);
+}
+static DEVICE_ATTR_RO(index);
+
+static umode_t zpci_unique_uids(struct kobject *kobj,
+				struct attribute *attr, int n)
+{
+	return zpci_unique_uid ? attr->mode : 0;
+}
+
+static struct attribute *zpci_ident_attrs[] = {
+	&dev_attr_index.attr,
+	NULL,
+};
+
+static struct attribute_group zpci_ident_attr_group = {
+	.attrs = zpci_ident_attrs,
+	.is_visible = zpci_unique_uids,
+};
+#endif
+
 static struct bin_attribute *zpci_bin_attrs[] = {
 	&bin_attr_util_string,
 	&bin_attr_report_error,
@@ -179,5 +211,8 @@ static struct attribute_group pfip_attr_group = {
 const struct attribute_group *zpci_attr_groups[] = {
 	&zpci_attr_group,
 	&pfip_attr_group,
+#ifndef CONFIG_DMI
+	&zpci_ident_attr_group,
+#endif
 	NULL,
 };
-- 
2.25.1

