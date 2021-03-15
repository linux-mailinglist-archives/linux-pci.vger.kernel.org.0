Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01D633BF84
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 16:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhCOPNz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 11:13:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63143 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232518AbhCOPNn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Mar 2021 11:13:43 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12FF4dC2170990;
        Mon, 15 Mar 2021 11:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=B5cWiCah1WTZhvLrevuetHghTSK2P2SVWdhapXHvan0=;
 b=cDPDZE/wkNPfg19MWshZ2QNJ1anCLR4ahqspUhAqP/8Vfay8IUdMjs2G6xaCfFvDzyzU
 9rmuggxR6XIEE5MImZYsDCIdZwO2Sz+MwDvnezGNn9eqd8195kWAZkyB6KTHhHCMmtRO
 un+4oANFgPXynBR3EeC0i5wZU3D2Xuka1DieSMQyjHdp/iuqekH3IRA5+UEJEgSsYBtf
 wS/JwEziI2lhAhE9oIIFklWqCJgC4ZE06KzBc8T8qajM1U1V8arJ4BTY8Xl7DEQ5c66P
 Mezx+rSqL7HGZcoIN96ik1Lfi9B6VKl/DXjj9yDOhLOA9tsCethwXnx4ayi7raALqSvR qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37a95da7uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Mar 2021 11:13:40 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12FF5Zui175994;
        Mon, 15 Mar 2021 11:13:39 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37a95da7t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Mar 2021 11:13:39 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12FFCPNE025440;
        Mon, 15 Mar 2021 15:13:37 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 378n1891sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Mar 2021 15:13:37 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12FFDYlm38928716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 15:13:34 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5EB74C04A;
        Mon, 15 Mar 2021 15:13:34 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66E764C04E;
        Mon, 15 Mar 2021 15:13:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Mar 2021 15:13:34 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Narendra K <narendra_k@dell.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH] s390/pci: expose a PCI device's UID as its index
Date:   Mon, 15 Mar 2021 16:13:34 +0100
Message-Id: <20210315151334.174802-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_08:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 clxscore=1015 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103150109
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
Changes from RFC patch:
- Use sysfs_emit() instead of sprintf() (Thanks Krzysztof Wilczyński!)

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
index 5c028bee91b9..c7107bd9dd93 100644
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

