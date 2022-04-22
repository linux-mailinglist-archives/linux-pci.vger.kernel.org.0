Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE76650B883
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 15:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448003AbiDVNcJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 09:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447993AbiDVNcF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 09:32:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30382583BD;
        Fri, 22 Apr 2022 06:29:11 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MBiYYQ028312;
        Fri, 22 Apr 2022 13:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=9RJixS4WeRJM0mGb+47v6hlLi3zfcIYx/lFEH2QI33c=;
 b=LQK4L9nqxBCNrkjJXoKarB1mFqKz8zGlMUH+fgKWlteI9gfWSvv6M07uaTl6ts6udq/W
 CUh4WYt6787UFnMQCzR+b/kcVe+oYcEU4caDATa9NBUVbYMU46BznVtolWJOOOTrFryZ
 nn7+8FW4mO38R9AoYcHxT2g0f/SxslfU27bj3iAGkpSKTaoN2KYKaTMMgIXDjwuOSKzF
 uRlMXSEae/LCHAT1R4oUUTx94fYborRU66+QztP6KdM5KC/Hogs+HjMxfD1tcIJbILlf
 z/3tkkkPBs2pIDYgO9nFaioXfBNC+e2HHfHJBgxfcF70BSFxXZzd/QJuLUYJNCeRYTuy Og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjff4cpcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 13:29:05 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23MD0q00024469;
        Fri, 22 Apr 2022 13:29:05 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjff4cpbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 13:29:04 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23MDJM9p011085;
        Fri, 22 Apr 2022 13:29:02 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3ffne97g9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 13:29:02 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23MDTB1h55837132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 13:29:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C2654203F;
        Fri, 22 Apr 2022 13:28:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15DC042042;
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
Subject: [PATCH v4 2/4] PCI: Move jailhouse's isolated function handling to pci_scan_slot()
Date:   Fri, 22 Apr 2022 15:28:56 +0200
Message-Id: <20220422132858.1213022-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220422132858.1213022-1-schnelle@linux.ibm.com>
References: <20220422132858.1213022-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p2W33-X5_R8Fb5CTEgxtN1SQoDrwbEpH
X-Proofpoint-ORIG-GUID: fydxqy7U7KgU1xA-vjVb6FI3l_X-5X1C
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_03,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
into pci_scan_slot() we can instead do this as part of the normal
slot scan. Note that with the assignment of dev->multifunction gated by
fn > 0 we set dev->multifunction unconditionally for all functions if
function 0 is missing just as in the existing jailhouse loop.

The only functional change is that we now call
pcie_aspm_init_link_state() for these functions but this already
happened if function 0 was passed through and should not be a problem.

Cc: Jan Kiszka <jan.kiszka@siemens.com>
Link: https://lore.kernel.org/linux-pci/20220408224514.GA353445@bhelgaas/
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/probe.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2000e9858f12..ce4e41a7d358 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2659,8 +2659,13 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
 			if (fn > 0)
 				dev->multifunction = 1;
 		} else if (fn == 0) {
-			/* function 0 is required */
-			break;
+			/*
+			 * function 0 is required unless we are running on
+			 * a hypervisor which passes through individual PCI
+			 * functions.
+			 */
+			if (!jailhouse_paravirt())
+				break;
 		}
 		fn = next_fn(bus, dev, fn);
 	} while (fn >= 0);
@@ -2859,29 +2864,14 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
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

