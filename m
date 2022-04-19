Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593D45068BF
	for <lists+linux-pci@lfdr.de>; Tue, 19 Apr 2022 12:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350683AbiDSKbA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Apr 2022 06:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350666AbiDSKa5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2022 06:30:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D492426562;
        Tue, 19 Apr 2022 03:28:15 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23JA9qvB026300;
        Tue, 19 Apr 2022 10:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=+4dOxYOPtwtBuZjYxuIWrW63gioildK1M39qmgldJ6Q=;
 b=EtJcqmufjstz0jdcFcN6QgMClA0INXt50tVzWt0pHa0g2sWvxa9+jX7f8vQ7SfsnxeHv
 oPhHPT9Aak+aWY3RhFDvnPc4cqZLR6W20XsNLbdDh0TgC4QyKldZWcX5EAd5iiPhsnSi
 jpGyMhHqfL6UtMbJvCZ1i8FZppJiK//NhE67Ownm9PWbkcr5ujDCYEPgsWJahoFByZns
 SiylaNSYFbTZK+3bBT3VyfOjL2T5mq3HKq53sVketqeO6RLe+f8+8ihjC3cZVt1IU1vC
 7WSSaeAbMzY4xvCqY80ZjnZJKl2QDz1wNVjssbc45KxADj463s99Se4zf/QvVK5zrzSv 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7vntw6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 10:28:11 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23JAQDGj016758;
        Tue, 19 Apr 2022 10:28:10 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7vntw5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 10:28:10 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23JADdOp020327;
        Tue, 19 Apr 2022 10:28:08 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3ffvt9ay63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 10:28:07 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23JAS4VV37224854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 10:28:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99BED11C054;
        Tue, 19 Apr 2022 10:28:04 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59CB911C052;
        Tue, 19 Apr 2022 10:28:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Apr 2022 10:28:04 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v3 2/4] PCI: Move jailhouse's isolated function handling to pci_scan_slot()
Date:   Tue, 19 Apr 2022 12:28:01 +0200
Message-Id: <20220419102803.3430139-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220419102803.3430139-1-schnelle@linux.ibm.com>
References: <20220419102803.3430139-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: M_0DY4D98XC3juVwNZx3D0se8wf5xJxh
X-Proofpoint-GUID: ImOh5p38FNgg00uQQBt7JgAEERB4B23Y
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_04,2022-04-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204190052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The special case of the jailhouse hypervisor passing through individual
PCI functions handles scanning for PCI functions even if function 0 does
not exist. Currently this is done with an extra loop duplicating the one
in pci_scan_slot(). By incorporating the check for jailhouse_paravirt()
into next_fn() we can instead do this as part of the normal
pci_scan_slot(). The only functional change is that we now call
pcie_aspm_init_link_state() for these functions but this already
happened if function 0 was passed through and should not be a problem.

Link: https://lore.kernel.org/linux-pci/20220408224514.GA353445@bhelgaas/
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/probe.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 389aa1f9cb2c..a1e8f1e14c3d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2602,10 +2602,11 @@ static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
 	if (dev && !dev->multifunction)
 		return -ENODEV;
 	/*
-	 * A function 0 is required but multifunction devices may
-	 * be non-contiguous so dev can be NULL otherwise.
+	 * Usually a function 0 is required but the jailhouse hypervisor may
+	 * pass individual functions. For non-contiguous multifunction devices
+	 * some functions may also be missing.
 	 */
-	if (!fn && !dev)
+	if (!fn && !dev && !jailhouse_paravirt())
 		return -ENODEV;
 	return (fn <= 6) ? fn + 1 : -ENODEV;
 }
@@ -2855,29 +2856,14 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 {
 	unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
 	unsigned int start = bus->busn_res.start;
-	unsigned int devfn, fn, cmax, max = start;
+	unsigned int devfn, cmax, max = start;
 	struct pci_dev *dev;
-	int nr_devs;
 
 	dev_dbg(&bus->dev, "scanning bus\n");
 
 	/* Go find them, Rover! */
-	for (devfn = 0; devfn < 256; devfn += 8) {
-		nr_devs = pci_scan_slot(bus, devfn);
-
-		/*
-		 * The Jailhouse hypervisor may pass individual functions of a
-		 * multi-function device to a guest without passing function 0.
-		 * Look for them as well.
-		 */
-		if (jailhouse_paravirt() && nr_devs == 0) {
-			for (fn = 1; fn < 8; fn++) {
-				dev = pci_scan_single_device(bus, devfn + fn);
-				if (dev)
-					dev->multifunction = 1;
-			}
-		}
-	}
+	for (devfn = 0; devfn < 256; devfn += 8)
+		pci_scan_slot(bus, devfn);
 
 	/* Reserve buses for SR-IOV capability */
 	used_buses = pci_iov_bus_range(bus);
-- 
2.32.0

