Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B05753B745
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 12:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbiFBKaq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 06:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbiFBKaj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 06:30:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C62169B7F;
        Thu,  2 Jun 2022 03:30:26 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2529WtMb028009;
        Thu, 2 Jun 2022 10:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=BUKnHMMtJlhw8wLxcVR6t/uKudxySSsONcFK+URS3a0=;
 b=Zmg0djj8O8yQECdE2+rjeaykMhO0XDhQFKM5aN3fxGPfSUYVhIHqjldPYyQf45dUJBxl
 JhKshElqUxNQbP5D/lo6JHft2MCwF9C3pU4soziw3AQLrYFGG+5YDpNlrlWyL/SKXX3e
 w8cat/l20Ig0N8VBO59uySaPKRYvPp5ZmsvoM2mmnd5IqGlquOZKq6wZAhia/81dHFs0
 mb+PRpioE5+ZGprQZdtgyYv/befHmzRQ9ORLGwtBodQOzKI/VTyShy1YbgQFMqmJFeAe
 mTzhx6/Do1fpxVykryj6EYLMywRx/YDkjcfQKrokTHeusTuv8E5XZGfQ5Hv7GJscp//b Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3geqwsvax9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 10:30:23 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 252AFOPT010517;
        Thu, 2 Jun 2022 10:30:22 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3geqwsvawn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 10:30:22 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 252AJqhf029426;
        Thu, 2 Jun 2022 10:30:20 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3gbc97w84k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 10:30:20 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 252AUH9O17432932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Jun 2022 10:30:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 050BDA405D;
        Thu,  2 Jun 2022 10:30:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE553A4053;
        Thu,  2 Jun 2022 10:30:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  2 Jun 2022 10:30:16 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v5 2/4] PCI: Move jailhouse's isolated function handling to pci_scan_slot()
Date:   Thu,  2 Jun 2022 12:30:14 +0200
Message-Id: <20220602103016.1499031-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220602103016.1499031-1-schnelle@linux.ibm.com>
References: <20220602103016.1499031-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FvagVA2LuZ1xH6ZuhmlkBYZ5D9SxGscl
X-Proofpoint-GUID: 6A6geVftTe1w0FdnyjwjybMb0eG2zT6A
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-02_01,2022-06-02_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206020042
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 78aa1bccab2f..3029edc68ff7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2658,8 +2658,13 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
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
@@ -2858,29 +2863,14 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
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

