Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1308E32C278
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 01:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhCCUyY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Mar 2021 15:54:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232698AbhCCK0c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Mar 2021 05:26:32 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1239iKST177489;
        Wed, 3 Mar 2021 04:53:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GiMYhcqP64MDO+8UvWA5bM2tZfeXB9Mta2yfwV7bUNg=;
 b=i6vW56P1CPxvzztV4BveFIb5helupK9zwDNl6sCy4u+egFFZuIT9jipBrgCgIlgJqVpf
 z/JWgzR1G2RWsgMlHKznkEGICIiwQGFyvoc3rgeEo7tjgPtzwU51sqcrzGfBgUzJP/vb
 yrzxvdidJC3rqq1Wo9C3Of6O6OSJZgS1tIyRymEPko+IG1cakmMMtjoNGPEHNapuurc5
 H05qO7opXczkEPZnGdDXydyo4XMaK6LZwf+X6D+lENFnoBXjAZQ4WE40v5AYMlUEE+kc
 5mhWxrhCn1PxZosyXzmGB6eP71jH+NZznXUWpicMe8APGYn4/yRIV//I2oBah7fgedjR 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3728390cer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 04:53:51 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1239l5ex183414;
        Wed, 3 Mar 2021 04:53:02 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3728390c99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 04:53:02 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1239iIxx009812;
        Wed, 3 Mar 2021 09:52:54 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 371a8erpwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 09:52:54 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1239qbh533948068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Mar 2021 09:52:37 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20FBB42045;
        Wed,  3 Mar 2021 09:52:51 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4F4542047;
        Wed,  3 Mar 2021 09:52:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Mar 2021 09:52:50 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Narendra K <narendra_k@dell.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [RFC 1/1] s390/pci: expose a PCI device's UID as its index
Date:   Wed,  3 Mar 2021 10:52:50 +0100
Message-Id: <20210303095250.1360007-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303095250.1360007-1-schnelle@linux.ibm.com>
References: <20210303095250.1360007-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_08:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 phishscore=0 impostorscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030072
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

In this the UID serves an analogous function as the SMBIOS instance
number or ACPI index exposed as the "index" respectively "acpi_index"
device attributes and used by e.g. systemd to set interface names. As
s390 does not use and will likely never use ACPI nor SMBIOS there is no
conflict and we can just expose the UID under the "index" attribute
whenever UID Uniqueness Checking is active and get systemd's interface
naming support for free.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Acked-by: Viktor Mihajlovski <mihajlov@linux.ibm.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 11 +++++---
 arch/s390/pci/pci_sysfs.c               | 36 +++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 4 deletions(-)

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
index 5c028bee91b9..30f48e8a1156 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -131,6 +131,38 @@ static ssize_t report_error_write(struct file *filp, struct kobject *kobj,
 }
 static BIN_ATTR(report_error, S_IWUSR, NULL, report_error_write, PAGE_SIZE);
 
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
+	return sprintf(buf, "%u\n", index);
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
@@ -150,6 +182,7 @@ static struct attribute *zpci_dev_attrs[] = {
 	&dev_attr_mio_enabled.attr,
 	NULL,
 };
+
 static struct attribute_group zpci_attr_group = {
 	.attrs = zpci_dev_attrs,
 	.bin_attrs = zpci_bin_attrs,
@@ -170,5 +203,8 @@ static struct attribute_group pfip_attr_group = {
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

