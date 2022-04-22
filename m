Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B5650B880
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 15:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447989AbiDVNcE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 09:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447982AbiDVNcD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 09:32:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A33583BB;
        Fri, 22 Apr 2022 06:29:10 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MCBB8N019424;
        Fri, 22 Apr 2022 13:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VKd5vFUiEKfuRcGuSWKwzFHHhQa5vtGA/lkq5v9/Zc8=;
 b=VKjRABCqRqMlWxjvKeKhyvSnLQZvVipohrr1qwkhDvp0pQIQwq3iwkSkChFod+eqge8r
 Q2eUGErj2tJ1AJSunKrDt7bhcb5Vi4CqSfs+KjF7/k5WR8UTnKIT+uSdZbJYquZQLuxh
 IeY5RgdzETkX3HyaapSPCBpuMu0xEw07sqZGiWO+Kr1db6flT7GiH24tmRc4dL9m0Zny
 6friEUHgY4Um78+6XRZC6VfJF2maErNTwI90o/2QGirnJB+nUcG+fY1Toifd3Hkrkhvy
 +FB8oNUOvMbzCJINv3cp/uwupvluFcJDRnQd+8iobrvi+dnys8SZlNmXUz+uCx/3FrM+ 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fkdg509rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 13:29:06 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23MDPWVE022294;
        Fri, 22 Apr 2022 13:29:06 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fkdg509qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 13:29:05 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23MDMFrK023231;
        Fri, 22 Apr 2022 13:29:03 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3ffvt9f3m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 13:29:03 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23MDG76f42139972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 13:16:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AFE24203F;
        Fri, 22 Apr 2022 13:29:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9DE54204C;
        Fri, 22 Apr 2022 13:28:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Apr 2022 13:28:59 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v4 4/4] s390/pci: allow zPCI zbus without a function zero
Date:   Fri, 22 Apr 2022 15:28:58 +0200
Message-Id: <20220422132858.1213022-5-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220422132858.1213022-1-schnelle@linux.ibm.com>
References: <20220422132858.1213022-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qbutGlughJvCIRxe0Zi29ZwxbIrz679k
X-Proofpoint-GUID: YIconcNA9dbN7eDDlaHUTFr2qO5mTxLS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_03,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=918 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204220058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the zPCI code block PCI bus creation and probing of a zPCI
zbus unless there is a PCI function with devfn 0. This is always the
case for the PCI functions with hidden RID but may keep PCI functions
from a multi-function PCI device with RID information invisible until
the function 0 becomes visible. Worse as a PCI bus is necessary to even
present a PCI hotplug slot even that remains invisible.

With the probing of these so called isolated PCI functions enabled for
s390 in common code this restriction is no longer necessary. On network
cards with multiple ports and a PF per port this also allows using each
port on its own while still providing the physical PCI topology
information in the devfn needed to associate VFs with their parent PF.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci_bus.c | 82 ++++++++++-------------------------------
 1 file changed, 20 insertions(+), 62 deletions(-)

diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index 5d77acbd1c87..6a8da1b742ae 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -145,9 +145,6 @@ int zpci_bus_scan_bus(struct zpci_bus *zbus)
 	struct zpci_dev *zdev;
 	int devfn, rc, ret = 0;
 
-	if (!zbus->function[0])
-		return 0;
-
 	for (devfn = 0; devfn < ZPCI_FUNCTIONS_PER_BUS; devfn++) {
 		zdev = zbus->function[devfn];
 		if (zdev && zdev->state == ZPCI_FN_STATE_CONFIGURED) {
@@ -184,26 +181,26 @@ void zpci_bus_scan_busses(void)
 
 /* zpci_bus_create_pci_bus - Create the PCI bus associated with this zbus
  * @zbus: the zbus holding the zdevices
- * @f0: function 0 of the bus
+ * @fr: PCI root function that will determine the bus's domain, and bus speeed
  * @ops: the pci operations
  *
- * Function zero is taken as a parameter as this is used to determine the
- * domain, multifunction property and maximum bus speed of the entire bus.
+ * The PCI function @fr determines the domain (its UID), multifunction property
+ * and maximum bus speed of the entire bus.
  *
  * Return: 0 on success, an error code otherwise
  */
-static int zpci_bus_create_pci_bus(struct zpci_bus *zbus, struct zpci_dev *f0, struct pci_ops *ops)
+static int zpci_bus_create_pci_bus(struct zpci_bus *zbus, struct zpci_dev *fr, struct pci_ops *ops)
 {
 	struct pci_bus *bus;
 	int domain;
 
-	domain = zpci_alloc_domain((u16)f0->uid);
+	domain = zpci_alloc_domain((u16)fr->uid);
 	if (domain < 0)
 		return domain;
 
 	zbus->domain_nr = domain;
-	zbus->multifunction = f0->rid_available;
-	zbus->max_bus_speed = f0->max_bus_speed;
+	zbus->multifunction = fr->rid_available;
+	zbus->max_bus_speed = fr->max_bus_speed;
 
 	/*
 	 * Note that the zbus->resources are taken over and zbus->resources
@@ -303,47 +300,6 @@ void pcibios_bus_add_device(struct pci_dev *pdev)
 	}
 }
 
-/* zpci_bus_create_hotplug_slots - Add hotplug slot(s) for device added to bus
- * @zdev: the zPCI device that was newly added
- *
- * Add the hotplug slot(s) for the newly added PCI function. Normally this is
- * simply the slot for the function itself. If however we are adding the
- * function 0 on a zbus, it might be that we already registered functions on
- * that zbus but could not create their hotplug slots yet so add those now too.
- *
- * Return: 0 on success, an error code otherwise
- */
-static int zpci_bus_create_hotplug_slots(struct zpci_dev *zdev)
-{
-	struct zpci_bus *zbus = zdev->zbus;
-	int devfn, rc = 0;
-
-	rc = zpci_init_slot(zdev);
-	if (rc)
-		return rc;
-	zdev->has_hp_slot = 1;
-
-	if (zdev->devfn == 0 && zbus->multifunction) {
-		/* Now that function 0 is there we can finally create the
-		 * hotplug slots for those functions with devfn != 0 that have
-		 * been parked in zbus->function[] waiting for us to be able to
-		 * create the PCI bus.
-		 */
-		for  (devfn = 1; devfn < ZPCI_FUNCTIONS_PER_BUS; devfn++) {
-			zdev = zbus->function[devfn];
-			if (zdev && !zdev->has_hp_slot) {
-				rc = zpci_init_slot(zdev);
-				if (rc)
-					return rc;
-				zdev->has_hp_slot = 1;
-			}
-		}
-
-	}
-
-	return rc;
-}
-
 static int zpci_bus_add_device(struct zpci_bus *zbus, struct zpci_dev *zdev)
 {
 	int rc = -EINVAL;
@@ -352,21 +308,19 @@ static int zpci_bus_add_device(struct zpci_bus *zbus, struct zpci_dev *zdev)
 		pr_err("devfn %04x is already assigned\n", zdev->devfn);
 		return rc;
 	}
+
 	zdev->zbus = zbus;
 	zbus->function[zdev->devfn] = zdev;
 	zpci_nb_devices++;
 
-	if (zbus->bus) {
-		if (zbus->multifunction && !zdev->rid_available) {
-			WARN_ONCE(1, "rid_available not set for multifunction\n");
-			goto error;
-		}
-
-		zpci_bus_create_hotplug_slots(zdev);
-	} else {
-		/* Hotplug slot will be created once function 0 appears */
-		zbus->multifunction = 1;
+	if (zbus->multifunction && !zdev->rid_available) {
+		WARN_ONCE(1, "rid_available not set for multifunction\n");
+		goto error;
 	}
+	rc = zpci_init_slot(zdev);
+	if (rc)
+		goto error;
+	zdev->has_hp_slot = 1;
 
 	return 0;
 
@@ -400,7 +354,11 @@ int zpci_bus_device_register(struct zpci_dev *zdev, struct pci_ops *ops)
 			return -ENOMEM;
 	}
 
-	if (zdev->devfn == 0) {
+	if (!zbus->bus) {
+		/* The UID of the first PCI function registered with a zpci_bus
+		 * is used as the domain number for that bus. Currently there
+		 * is exactly one zpci_bus per domain.
+		 */
 		rc = zpci_bus_create_pci_bus(zbus, zdev, ops);
 		if (rc)
 			goto error;
-- 
2.32.0

