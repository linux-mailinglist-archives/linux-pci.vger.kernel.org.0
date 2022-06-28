Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7D055E9A5
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 18:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346621AbiF1ObP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 10:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346588AbiF1ObN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 10:31:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9DD3138A;
        Tue, 28 Jun 2022 07:31:10 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SDlUmV019297;
        Tue, 28 Jun 2022 14:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=R+BseDFs09Ja9H71wowHmFUqTDEh3Fs4AyTzsPrycMk=;
 b=ZSGm1xxos/fe5PFXgWObeKH3pbbhQFod8bozSET1uT40SO5W57MxQ9h9C0o68PJa71tR
 fEBvPJYUdXvHVkdhiDHCJO3jw89VE1AYdWh6IyWMx9oMgerj3a1pfqZYxrGE3NgP+FMX
 J1uATGYOOGOC9PbKSoLUEQ6YYxseRo5hB27KYIC++ISIkP++VPqGWMUUiXZ3R39SJDXN
 TQDX17gY2W0SCrD/0jbNfYJbn9Yf9KCcwvheFmbANFlwuviwdoDTHvX/zKLYOgOLWiCR
 3M8bG44k5CkyOdsDjmFk28cVR0U9KXFzgX8sgOeoCDIhGGuEcr6GikNSj8QlDP0xfkPY hA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h02u21r0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 14:31:07 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25SEOX2m013915;
        Tue, 28 Jun 2022 14:31:07 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h02u21qxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 14:31:07 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25SEL4d3007246;
        Tue, 28 Jun 2022 14:31:04 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3gwt08w09a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 14:31:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25SEV1RM23724348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 14:31:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC186A4060;
        Tue, 28 Jun 2022 14:31:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D818A405B;
        Tue, 28 Jun 2022 14:31:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jun 2022 14:31:01 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/5] PCI: Move jailhouse's isolated function handling to pci_scan_slot()
Date:   Tue, 28 Jun 2022 16:30:58 +0200
Message-Id: <20220628143100.3228092-4-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220628143100.3228092-1-schnelle@linux.ibm.com>
References: <20220628143100.3228092-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cunDo7g8OqfAsU5sdE-G2lDDrY3fxuS6
X-Proofpoint-ORIG-GUID: kSVxSToXv8ZBR96nMz7h14Wg3BNQIVm0
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_07,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280059
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
index 2c737dce757e..a18e07e6a7df 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2662,8 +2662,13 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
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
@@ -2862,29 +2867,14 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
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

