Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700FB1C85D7
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 11:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgEGJam (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 05:30:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726825AbgEGJam (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 05:30:42 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04793VJX146293;
        Thu, 7 May 2020 05:30:41 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30s4gwwca9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 05:30:41 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04793XNX146363;
        Thu, 7 May 2020 05:30:40 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30s4gwwc9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 05:30:40 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0479Pfhg025142;
        Thu, 7 May 2020 09:30:38 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 30s0g5u0n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 09:30:38 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0479TPSg55509356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 May 2020 09:29:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 353FEA4057;
        Thu,  7 May 2020 09:30:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05F15A4051;
        Thu,  7 May 2020 09:30:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 May 2020 09:30:34 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: [PATCH 2/2] s390/pci: create links between PFs and VFs
Date:   Thu,  7 May 2020 11:30:34 +0200
Message-Id: <20200507093034.56143-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507093034.56143-1-schnelle@linux.ibm.com>
References: <20200507093034.56143-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_04:2020-05-05,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070075
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On s390 PCI Virtual Functions (VFs) are scanned by firmware and are made
available to Linux via the hot-plug interface. As such the common code
path of doing the scan directly using the parent Physical Function (PF)
is not used and fenced off with the no_vf_scan attribute.

Even if the partition created the VFs itself e.g. using the sriov_numvfs
attribute of a PF, the PF/VF links thus need to be established after the
fact. To do this when a VF is plugged we scan through all functions on
the same zbus and test whether they are the parent PF in which case we
establish the necessary links.

With these links established there is now no more need to fence off
pci_iov_remove_virtfn() for pdev->no_vf_scan as the common code now
works fine.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/s390/include/asm/pci.h     |  3 +-
 arch/s390/include/asm/pci_clp.h |  3 +-
 arch/s390/pci/pci_bus.c         | 69 ++++++++++++++++++++++++++++++++-
 arch/s390/pci/pci_clp.c         |  1 +
 drivers/pci/iov.c               |  3 --
 5 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index c1558cf071b8..99b92c3e46b0 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -131,7 +131,8 @@ struct zpci_dev {
 	u8		port;
 	u8		rid_available	: 1;
 	u8		has_hp_slot	: 1;
-	u8		reserved	: 6;
+	u8		is_physfn	: 1;
+	u8		reserved	: 5;
 	unsigned int	devfn;		/* DEVFN part of the RID*/
 
 	struct mutex lock;
diff --git a/arch/s390/include/asm/pci_clp.h b/arch/s390/include/asm/pci_clp.h
index 896ee41e23e3..eb51272dd2cc 100644
--- a/arch/s390/include/asm/pci_clp.h
+++ b/arch/s390/include/asm/pci_clp.h
@@ -95,7 +95,8 @@ struct clp_rsp_query_pci {
 	u16 vfn;			/* virtual fn number */
 	u16			:  3;
 	u16 rid_avail		:  1;
-	u16			:  2;
+	u16 is_physfn		:  1;
+	u16 reserved1		:  1;
 	u16 mio_addr_avail	:  1;
 	u16 util_str_avail	:  1;	/* utility string available? */
 	u16 pfgid		:  8;	/* pci function group id */
diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index 542c6b8f56df..52d79a2f6722 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -126,6 +126,64 @@ static struct zpci_bus *zpci_bus_alloc(int pchid)
 	return zbus;
 }
 
+#ifdef CONFIG_PCI_IOV
+static int zpci_bus_link_virtfn(struct pci_dev *pdev,
+		struct pci_dev *virtfn, int vfid)
+{
+	int rc;
+
+	virtfn->physfn = pci_dev_get(pdev);
+	rc = pci_iov_sysfs_link(pdev, virtfn, vfid);
+	if (rc) {
+		pci_dev_put(pdev);
+		virtfn->physfn = NULL;
+		return rc;
+	}
+	return 0;
+}
+
+static int zpci_bus_setup_virtfn(struct zpci_bus *zbus,
+		struct pci_dev *virtfn, int vfn)
+{
+	int i, cand_devfn;
+	struct zpci_dev *zdev;
+	struct pci_dev *pdev;
+	int vfid = vfn - 1; /* Linux' vfid's start at 0 vfn at 1*/
+	int rc = 0;
+
+	virtfn->is_virtfn = 1;
+	virtfn->multifunction = 0;
+	WARN_ON(vfid < 0);
+	/* If the parent PF for the given VF is also configured in the
+	 * instance, it must be on the same zbus.
+	 * We can then identify the parent PF by checking what
+	 * devfn the VF would have if it belonged to that PF using the PF's
+	 * stride and offset. Only if this candidate devfn matches the
+	 * actual devfn will we link both functions.
+	 */
+	for (i = 0; i < ZPCI_FUNCTIONS_PER_BUS; i++) {
+		zdev = zbus->function[i];
+		if (zdev && zdev->is_physfn) {
+			pdev = pci_get_slot(zbus->bus, zdev->devfn);
+			cand_devfn = pci_iov_virtfn_devfn(pdev, vfid);
+			if (cand_devfn == virtfn->devfn) {
+				rc = zpci_bus_link_virtfn(pdev, virtfn, vfid);
+				break;
+			}
+		}
+	}
+	return rc;
+}
+#else
+static inline int zpci_bus_setup_virtfn(struct zpci_bus *zbus,
+		struct pci_dev *virtfn, int vfn)
+{
+	virtfn->is_virtfn = 1;
+	virtfn->multifunction = 0;
+	return 0;
+}
+#endif
+
 static int zpci_bus_add_device(struct zpci_bus *zbus, struct zpci_dev *zdev)
 {
 	struct pci_bus *bus;
@@ -157,11 +215,20 @@ static int zpci_bus_add_device(struct zpci_bus *zbus, struct zpci_dev *zdev)
 
 	pdev = pci_scan_single_device(bus, zdev->devfn);
 	if (pdev) {
-		pdev->multifunction = 1;
+		if (!zdev->is_physfn) {
+			rc = zpci_bus_setup_virtfn(zbus, pdev, zdev->vfn);
+			if (rc)
+				goto failed_with_pdev;
+		}
 		pci_bus_add_device(pdev);
 	}
 
 	return 0;
+
+failed_with_pdev:
+	pci_stop_and_remove_bus_device(pdev);
+	pci_dev_put(pdev);
+	return rc;
 }
 
 static void zpci_bus_add_devices(struct zpci_bus *zbus)
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 9b318824a134..d7bd3c287cf7 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -159,6 +159,7 @@ static int clp_store_query_pci_fn(struct zpci_dev *zdev,
 	zdev->uid = response->uid;
 	zdev->fmb_length = sizeof(u32) * response->fmb_len;
 	zdev->rid_available = response->rid_avail;
+	zdev->is_physfn = response->is_physfn;
 	if (!s390_pci_no_rid && zdev->rid_available)
 		zdev->devfn = response->rid & ZPCI_RID_MASK_DEVFN;
 
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ee6fbe688498..b37e08c4f9d1 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -571,9 +571,6 @@ static void sriov_del_vfs(struct pci_dev *dev)
 	struct pci_sriov *iov = dev->sriov;
 	int i;
 
-	if (dev->no_vf_scan)
-		return;
-
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
 }
-- 
2.17.1

