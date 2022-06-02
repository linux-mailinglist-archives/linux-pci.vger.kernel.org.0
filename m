Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C330F53B744
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 12:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbiFBKau (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 06:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbiFBKal (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 06:30:41 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244EA6D383;
        Thu,  2 Jun 2022 03:30:31 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252A3bSs007605;
        Thu, 2 Jun 2022 10:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VKd5vFUiEKfuRcGuSWKwzFHHhQa5vtGA/lkq5v9/Zc8=;
 b=cyscfWEuEF5gJTMeZZ+ZRhSXHb3YXeB3Cht4rRf2Ka0vt9uin73Hdql+mENqx0MWlmof
 gFsI7eeVHIb8zoigEZM0V+VCOjPsQzWA1Yq0F7tfVu8A7KgChLR4VA7CJVF5Wwwpka6/
 vz7EgxNB5KcTuoJCMJdADV7mtJBX1FC4o2qS2xEmBIBSPYmx35vEmzGUniTdYRrsCCXW
 m8ij0jFn+9OZgN+XItuN4Q67sv/nXKtWdOLvGWn2kP4CxhysGQzmg4ozfbPsExaxaX8C
 BIAbjRoQgjv8qm3lMUpZHMQX4elMO32Vrsk+n/tJHgpbUWULnW3yZ/KeNWauNSX3TKPX 1w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3geu4age4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 10:30:23 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 252APtCS009521;
        Thu, 2 Jun 2022 10:30:22 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3geu4age3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 10:30:22 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 252AL1lq024733;
        Thu, 2 Jun 2022 10:30:20 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3gbc7h6w3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 10:30:20 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 252AUIOs24314162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Jun 2022 10:30:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 914ECA4055;
        Thu,  2 Jun 2022 10:30:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5658DA404D;
        Thu,  2 Jun 2022 10:30:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  2 Jun 2022 10:30:17 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v5 4/4] s390/pci: allow zPCI zbus without a function zero
Date:   Thu,  2 Jun 2022 12:30:16 +0200
Message-Id: <20220602103016.1499031-5-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220602103016.1499031-1-schnelle@linux.ibm.com>
References: <20220602103016.1499031-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wiDIw29KI5PkWw4vLdyrsc9XqM5Sl1Ia
X-Proofpoint-ORIG-GUID: 5XmRFYMu6qdf2n5WPMgQdspeHsM-b81Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-02_01,2022-06-01_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 mlxlogscore=952 suspectscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206020042
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

