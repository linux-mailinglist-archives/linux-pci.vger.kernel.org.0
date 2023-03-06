Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA61E6AC474
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 16:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjCFPKa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 10:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCFPK2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 10:10:28 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44E121971;
        Mon,  6 Mar 2023 07:10:22 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326E7VMB001475;
        Mon, 6 Mar 2023 15:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TwW+Or2S2PLq3VbE/F7b+vYT6TztXbk2jXK5TMJEAR4=;
 b=T9cTylv2n+qzkXU8eI5bRUvfKIMWMH/aDoZlrGZj9wzXNGiTR/dDzKLX/hYxoZVJXZEL
 iMNNOtK9A6flJuI2K9q+ROHRRqmQ/vZnEO4rK6A3lp8veNTdiMUdDoT2jSaYmEkdNUNo
 yosVz8qrs4Hc8C8B1U3/8wnSFmWtOiPzfzJCjTH3Rt8IJ7f8tPaW6uHOaG/Ruhnj0Iar
 rTebyKmEj1ujxGE8B/fGdAgpQRu8nskjWWM8moMsqvU9EzuB/pMb64hHpcefkhf/4cPP
 yXjfb6m3tl2vajkD8BYCYcClFurJuFGBSkvfAfVtTH+UafYLFU8e5BruWTgcYu9DyVql Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p507ny1e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 15:10:21 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 326F621S006753;
        Mon, 6 Mar 2023 15:10:21 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p507ny1d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 15:10:21 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3265OEpj008153;
        Mon, 6 Mar 2023 15:10:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3p419ka9q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 15:10:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326FAFlA50594162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 15:10:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABF5720040;
        Mon,  6 Mar 2023 15:10:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70B822004B;
        Mon,  6 Mar 2023 15:10:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 15:10:15 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 1/4] PCI: s390: Fix use-after-free of PCI resources with per-function hotplug
Date:   Mon,  6 Mar 2023 16:10:11 +0100
Message-Id: <20230306151014.60913-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230306151014.60913-1-schnelle@linux.ibm.com>
References: <20230306151014.60913-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IZKwZl4NiPoFDH7b7oi1MVyHgfUIlKUc
X-Proofpoint-ORIG-GUID: bW0WNXHmHQrET1E7Hu05aAw3XC7y81H8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_08,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 mlxlogscore=762 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060133
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On s390 PCI functions may be hotplugged individually even when they
belong to a multi-function device. In particular on an SR-IOV device VFs
may be removed and later re-added.

In commit a50297cf8235 ("s390/pci: separate zbus creation from
scanning") it was missed however that struct pci_bus and struct
zpci_bus's resource list retained a reference to the PCI functions MMIO
resources even though those resources are released and freed on
hot-unplug. These stale resources may subsequently be claimed when the
PCI function re-appears resulting in use-after-free.

One idea of fixing this use-after-free in s390 specific code that was
investigated was to simply keep resources around from the moment a PCI
function first appeared until the whole virtual PCI bus created for
a multi-function device disappears. The problem with this however is
that due to the requirement of artificial MMIO addreesses (address
cookies) extra logic is then needed to keep the address cookies
compatible on re-plug. At the same time the MMIO resources semantically
belong to the PCI function so tying their lifecycle to the function
seems more logical.

Instead a simpler approach is to remove the resources of an individually
hot-unplugged PCI function from the PCI bus's resource list while
keeping the resources of other PCI functions on the PCI bus untouched.

This is done by introducing pci_bus_remove_resource() to remove an
individual resource. Similarly the resource also needs to be removed
from the struct zpci_bus's resource list. It turns out however, that
there is really no need to add the MMIO resources to the struct
zpci_bus's resource list at all and instead we can simply use the
zpci_bar_struct's resource pointer directly.

Fixes: a50297cf8235 ("s390/pci: separate zbus creation from scanning")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
v1 -> v2:
- Remove return at the end of function returning void

 arch/s390/pci/pci.c     | 16 ++++++++++------
 arch/s390/pci/pci_bus.c | 12 +++++-------
 arch/s390/pci/pci_bus.h |  3 +--
 drivers/pci/bus.c       | 21 +++++++++++++++++++++
 include/linux/pci.h     |  1 +
 5 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index ef38b1514c77..e16afacc8fd1 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -544,8 +544,7 @@ static struct resource *__alloc_res(struct zpci_dev *zdev, unsigned long start,
 	return r;
 }
 
-int zpci_setup_bus_resources(struct zpci_dev *zdev,
-			     struct list_head *resources)
+int zpci_setup_bus_resources(struct zpci_dev *zdev)
 {
 	unsigned long addr, size, flags;
 	struct resource *res;
@@ -581,7 +580,6 @@ int zpci_setup_bus_resources(struct zpci_dev *zdev,
 			return -ENOMEM;
 		}
 		zdev->bars[i].res = res;
-		pci_add_resource(resources, res);
 	}
 	zdev->has_resources = 1;
 
@@ -590,17 +588,23 @@ int zpci_setup_bus_resources(struct zpci_dev *zdev,
 
 static void zpci_cleanup_bus_resources(struct zpci_dev *zdev)
 {
+	struct resource *res;
 	int i;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (!zdev->bars[i].size || !zdev->bars[i].res)
+		res = zdev->bars[i].res;
+		if (!res)
 			continue;
 
+		release_resource(res);
+		pci_bus_remove_resource(zdev->zbus->bus, res);
 		zpci_free_iomap(zdev, zdev->bars[i].map_idx);
-		release_resource(zdev->bars[i].res);
-		kfree(zdev->bars[i].res);
+		zdev->bars[i].res = NULL;
+		kfree(res);
 	}
 	zdev->has_resources = 0;
+	pci_unlock_rescan_remove();
 }
 
 int pcibios_device_add(struct pci_dev *pdev)
diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index 6a8da1b742ae..a99926af2b69 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -41,9 +41,7 @@ static int zpci_nb_devices;
  */
 static int zpci_bus_prepare_device(struct zpci_dev *zdev)
 {
-	struct resource_entry *window, *n;
-	struct resource *res;
-	int rc;
+	int rc, i;
 
 	if (!zdev_enabled(zdev)) {
 		rc = zpci_enable_device(zdev);
@@ -57,10 +55,10 @@ static int zpci_bus_prepare_device(struct zpci_dev *zdev)
 	}
 
 	if (!zdev->has_resources) {
-		zpci_setup_bus_resources(zdev, &zdev->zbus->resources);
-		resource_list_for_each_entry_safe(window, n, &zdev->zbus->resources) {
-			res = window->res;
-			pci_bus_add_resource(zdev->zbus->bus, res, 0);
+		zpci_setup_bus_resources(zdev);
+		for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+			if (zdev->bars[i].res)
+				pci_bus_add_resource(zdev->zbus->bus, zdev->bars[i].res, 0);
 		}
 	}
 
diff --git a/arch/s390/pci/pci_bus.h b/arch/s390/pci/pci_bus.h
index e96c9860e064..af9f0ac79a1b 100644
--- a/arch/s390/pci/pci_bus.h
+++ b/arch/s390/pci/pci_bus.h
@@ -30,8 +30,7 @@ static inline void zpci_zdev_get(struct zpci_dev *zdev)
 
 int zpci_alloc_domain(int domain);
 void zpci_free_domain(int domain);
-int zpci_setup_bus_resources(struct zpci_dev *zdev,
-			     struct list_head *resources);
+int zpci_setup_bus_resources(struct zpci_dev *zdev);
 
 static inline struct zpci_dev *zdev_from_bus(struct pci_bus *bus,
 					     unsigned int devfn)
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 83ae838ceb5f..549c4bd5caec 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -76,6 +76,27 @@ struct resource *pci_bus_resource_n(const struct pci_bus *bus, int n)
 }
 EXPORT_SYMBOL_GPL(pci_bus_resource_n);
 
+void pci_bus_remove_resource(struct pci_bus *bus, struct resource *res)
+{
+	struct pci_bus_resource *bus_res, *tmp;
+	int i;
+
+	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
+		if (bus->resource[i] == res) {
+			bus->resource[i] = NULL;
+			return;
+		}
+	}
+
+	list_for_each_entry_safe(bus_res, tmp, &bus->resources, list) {
+		if (bus_res->res == res) {
+			list_del(&bus_res->list);
+			kfree(bus_res);
+			return;
+		}
+	}
+}
+
 void pci_bus_remove_resources(struct pci_bus *bus)
 {
 	int i;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index fafd8020c6d7..b50e5c79f7e3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1438,6 +1438,7 @@ void pci_bus_add_resource(struct pci_bus *bus, struct resource *res,
 			  unsigned int flags);
 struct resource *pci_bus_resource_n(const struct pci_bus *bus, int n);
 void pci_bus_remove_resources(struct pci_bus *bus);
+void pci_bus_remove_resource(struct pci_bus *bus, struct resource *res);
 int devm_request_pci_bus_resources(struct device *dev,
 				   struct list_head *resources);
 
-- 
2.37.2

