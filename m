Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5D24FE3DB
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 16:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356532AbiDLOdL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 10:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356534AbiDLOdI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 10:33:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7195EDE6;
        Tue, 12 Apr 2022 07:30:50 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23CDsP4R006044;
        Tue, 12 Apr 2022 14:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=VumadtbAhg7J0oAzytt4nXBVTZSNqML19OlNy6Mzrvk=;
 b=UAlzjLP902wHOA7aS3x+nHo3l1ib7VISuOl5EVnEzXURhl58Yrflx3B76rgBuMRCrvzw
 9ng7z8C/7i6Pl06R6SCX2pyua8C+o+sQSnWkKHeRLPdF7iOIH45wwzILp99PpBZAA8FS
 X9LqvzH4dsIoueo2Z6s1mo27UIw9MDFGVlm5S4lPGs3EXhZ73CfttFHSDZt1VO7Shd3/
 myLyN+HepCtkxD0N4JMLVWm0AMOIN624dXff/9J770pZDbh8r31M+E7kHykdXa32esWa
 vODhqOoya3/1QskwN0Hthvj0IVWW8LRiq/lRR1dHMVf16JFHcy/rsi0UApS6TFvPwzio 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fdaqkrva0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 14:30:47 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23CDu87K004959;
        Tue, 12 Apr 2022 14:30:47 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fdaqkrv8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 14:30:46 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23CEE0Nj015594;
        Tue, 12 Apr 2022 14:30:44 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3fb1s8w1xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 14:30:44 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23CEUfrM52036012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 14:30:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06ED952051;
        Tue, 12 Apr 2022 14:30:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C3D825205F;
        Tue, 12 Apr 2022 14:30:40 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 2/4] PCI: Move jailhouse's isolated function handling to pci_scan_slot()
Date:   Tue, 12 Apr 2022 16:30:38 +0200
Message-Id: <20220412143040.1882096-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220412143040.1882096-1-schnelle@linux.ibm.com>
References: <20220412143040.1882096-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BS6WV4q7WWMrpPR7GJl3YwUyMJivfMZa
X-Proofpoint-ORIG-GUID: pigLOYQVWaDbOc9Z-H6EBnFArRW4jB6Q
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-12_05,2022-04-12_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204120068
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
 drivers/pci/probe.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 389aa1f9cb2c..8100e044dfc5 100644
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
@@ -2855,30 +2856,16 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 {
 	unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
 	unsigned int start = bus->busn_res.start;
-	unsigned int devfn, fn, cmax, max = start;
+	unsigned int devfn, cmax, max = start;
 	struct pci_dev *dev;
 	int nr_devs;
 
 	dev_dbg(&bus->dev, "scanning bus\n");
 
 	/* Go find them, Rover! */
-	for (devfn = 0; devfn < 256; devfn += 8) {
+	for (devfn = 0; devfn < 256; devfn += 8)
 		nr_devs = pci_scan_slot(bus, devfn);
 
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
-
 	/* Reserve buses for SR-IOV capability */
 	used_buses = pci_iov_bus_range(bus);
 	max += used_buses;
-- 
2.32.0

