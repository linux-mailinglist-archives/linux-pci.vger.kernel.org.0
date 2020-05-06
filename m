Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509B91C7526
	for <lists+linux-pci@lfdr.de>; Wed,  6 May 2020 17:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgEFPlq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 11:41:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5074 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729066AbgEFPlq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2020 11:41:46 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 046FbpnH174173;
        Wed, 6 May 2020 11:41:45 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30uf8j4gae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 11:41:45 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 046Fderj182107;
        Wed, 6 May 2020 11:41:45 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30uf8j4g9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 11:41:45 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 046Ff07a027815;
        Wed, 6 May 2020 15:41:43 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 30s0g5sg8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 15:41:42 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 046FeUUu58130916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 May 2020 15:40:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 509F3A404D;
        Wed,  6 May 2020 15:41:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E203A4053;
        Wed,  6 May 2020 15:41:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 May 2020 15:41:40 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: [RFC 1/2] PCI/IOV: Introduce pci_iov_sysfs_link() function
Date:   Wed,  6 May 2020 17:41:38 +0200
Message-Id: <20200506154139.90609-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506154139.90609-1-schnelle@linux.ibm.com>
References: <20200506154139.90609-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-06_08:2020-05-05,2020-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060122
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

currently pci_iov_add_virtfn() scans the SR-IOV bars, adds the VF to the
bus and also creates the sysfs links between the newly added VF and its
parent PF.

With pdev->no_vf_scan fencing off the entire pci_iov_add_virtfn() call
s390 as the sole pdev->no_vf_scan user thus ends up missing these sysfs
links which are required for example by QEMU/libvirt.
Instead of duplicating the code introduce a new pci_iov_sysfs_link()
function for establishing sysfs links.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/iov.c   | 36 ++++++++++++++++++++++++------------
 include/linux/pci.h |  8 ++++++++
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 4d1f392b05f9..d0ddf5f5484c 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -113,7 +113,6 @@ resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
 static void pci_read_vf_config_common(struct pci_dev *virtfn)
 {
 	struct pci_dev *physfn = virtfn->physfn;
-
 	/*
 	 * Some config registers are the same across all associated VFs.
 	 * Read them once from VF0 so we can skip reading them from the
@@ -133,12 +132,34 @@ static void pci_read_vf_config_common(struct pci_dev *virtfn)
 			     &physfn->sriov->subsystem_device);
 }
 
+int pci_iov_sysfs_link(struct pci_dev *dev,
+		struct pci_dev *virtfn, int id)
+{
+	int rc;
+	char buf[VIRTFN_ID_LEN];
+
+	sprintf(buf, "virtfn%u", id);
+	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
+	if (rc)
+		goto failed;
+	rc = sysfs_create_link(&virtfn->dev.kobj, &dev->dev.kobj, "physfn");
+	if (rc)
+		goto failed1;
+
+	kobject_uevent(&virtfn->dev.kobj, KOBJ_CHANGE);
+
+	return 0;
+failed1:
+	sysfs_remove_link(&dev->dev.kobj, buf);
+failed:
+	return rc;
+}
+
 int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 {
 	int i;
 	int rc = -ENOMEM;
 	u64 size;
-	char buf[VIRTFN_ID_LEN];
 	struct pci_dev *virtfn;
 	struct resource *res;
 	struct pci_sriov *iov = dev->sriov;
@@ -182,23 +203,14 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 	}
 
 	pci_device_add(virtfn, virtfn->bus);
-
-	sprintf(buf, "virtfn%u", id);
-	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
+	rc = pci_iov_sysfs_link(dev, virtfn, id);
 	if (rc)
 		goto failed1;
-	rc = sysfs_create_link(&virtfn->dev.kobj, &dev->dev.kobj, "physfn");
-	if (rc)
-		goto failed2;
-
-	kobject_uevent(&virtfn->dev.kobj, KOBJ_CHANGE);
 
 	pci_bus_add_device(virtfn);
 
 	return 0;
 
-failed2:
-	sysfs_remove_link(&dev->dev.kobj, buf);
 failed1:
 	pci_stop_and_remove_bus_device(virtfn);
 	pci_dev_put(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 83ce1cdf5676..e97d27ac350a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2048,6 +2048,8 @@ int pci_iov_virtfn_devfn(struct pci_dev *dev, int id);
 
 int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
 void pci_disable_sriov(struct pci_dev *dev);
+
+int pci_iov_sysfs_link(struct pci_dev *dev, struct pci_dev *virtfn, int id);
 int pci_iov_add_virtfn(struct pci_dev *dev, int id);
 void pci_iov_remove_virtfn(struct pci_dev *dev, int id);
 int pci_num_vf(struct pci_dev *dev);
@@ -2073,6 +2075,12 @@ static inline int pci_iov_virtfn_devfn(struct pci_dev *dev, int id)
 }
 static inline int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
 { return -ENODEV; }
+
+static inline int pci_iov_sysfs_link(struct pci_dev *dev,
+		struct pci_dev *virtfn, int id)
+{
+	return -ENODEV;
+}
 static inline int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 {
 	return -ENOSYS;
-- 
2.17.1

