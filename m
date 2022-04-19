Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8365068B5
	for <lists+linux-pci@lfdr.de>; Tue, 19 Apr 2022 12:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbiDSKa4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Apr 2022 06:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242200AbiDSKaz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2022 06:30:55 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85263275F6;
        Tue, 19 Apr 2022 03:28:13 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23J9Aexp004777;
        Tue, 19 Apr 2022 10:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QnPfcT3aQm4wRRbd1y2TwgeqmbD666U2uW+Vxfg7yaQ=;
 b=glv/vOuT58kVk8IeD+SxAWgb5AZgUx1RNZyO1Pvbog+G7M1iNrMqS4fDdLFI0N9xxTOA
 gVsv/R7aSAY3kn+Pz3bfdLxyocumpeAAOzFObd4D6Rb/A8Nhht6eHg9do7A+sZtlzGhc
 TKXpssa4f73Pl744ZwpTEq0Psp8n5001SBtj00Y/NNiH3NGmBzfWmO75IJlr8gcD5++c
 WmH36Yb3bYz3RqZbsCvCgXlD0F+v0IMAZftc4c4ke4N/DjWMZZeU6fxLNE5BaEiAmr1R
 SenPYh2ugq4Dz6bxeL+I36/8iYoBs5DhDr+vh+7chUFlLKtYGgs56tQ+6wXYtAy7sQsB Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7ekva0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 10:28:09 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23J9vo4v023136;
        Tue, 19 Apr 2022 10:28:09 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7ekv9yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 10:28:09 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23JACxiA026438;
        Tue, 19 Apr 2022 10:28:07 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3ffne945vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 10:28:07 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23JAS4CB37224850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 10:28:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F05811C04C;
        Tue, 19 Apr 2022 10:28:04 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F27911C050;
        Tue, 19 Apr 2022 10:28:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Apr 2022 10:28:03 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v3 1/4] PCI: Clean up pci_scan_slot()
Date:   Tue, 19 Apr 2022 12:28:00 +0200
Message-Id: <20220419102803.3430139-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220419102803.3430139-1-schnelle@linux.ibm.com>
References: <20220419102803.3430139-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t8czAsQle4o1PotRlKGhmVkxOf1_Dlo3
X-Proofpoint-GUID: MB_ON1VMkQx_KoETrl42A61be9hStEkS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_03,2022-04-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204190052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

While determining the next PCI function is factored out of
pci_scan_slot() into next_fn() the former still handles the first
function as a special case duplicating the code from the scan loop and
splitting the condition that the first function exits from it being
multifunction which is tested in next_fn().

Furthermore the non ARI branch of next_fn() mixes the case that
multifunction devices may have non-contiguous function ranges and dev
may thus be NULL with the multifunction requirement. It also signals
that no further functions need to be scanned by returning 0 which is
a valid function number.

Improve upon this by moving all conditions for having to scan for more
functions into next_fn() and make them obvious and commented.

By changing next_fn() to return -ENODEV instead of 0 when there is no
next function we can then handle the initial function inside the loop
and deduplicate the shared handling.

No functional change is intended.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/probe.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 17a969942d37..389aa1f9cb2c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2579,33 +2579,35 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
 }
 EXPORT_SYMBOL(pci_scan_single_device);
 
-static unsigned int next_fn(struct pci_bus *bus, struct pci_dev *dev,
-			    unsigned int fn)
+static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
 {
 	int pos;
 	u16 cap = 0;
 	unsigned int next_fn;
 
-	if (pci_ari_enabled(bus)) {
-		if (!dev)
-			return 0;
+	if (dev && pci_ari_enabled(bus)) {
 		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI);
 		if (!pos)
-			return 0;
+			return -ENODEV;
 
 		pci_read_config_word(dev, pos + PCI_ARI_CAP, &cap);
 		next_fn = PCI_ARI_CAP_NFN(cap);
 		if (next_fn <= fn)
-			return 0;	/* protect against malformed list */
+			return -ENODEV;	/* protect against malformed list */
 
 		return next_fn;
 	}
 
-	/* dev may be NULL for non-contiguous multifunction devices */
-	if (!dev || dev->multifunction)
-		return (fn + 1) % 8;
-
-	return 0;
+	/* only multifunction devices may have more functions */
+	if (dev && !dev->multifunction)
+		return -ENODEV;
+	/*
+	 * A function 0 is required but multifunction devices may
+	 * be non-contiguous so dev can be NULL otherwise.
+	 */
+	if (!fn && !dev)
+		return -ENODEV;
+	return (fn <= 6) ? fn + 1 : -ENODEV;
 }
 
 static int only_one_child(struct pci_bus *bus)
@@ -2643,24 +2645,19 @@ static int only_one_child(struct pci_bus *bus)
  */
 int pci_scan_slot(struct pci_bus *bus, int devfn)
 {
-	unsigned int fn, nr = 0;
-	struct pci_dev *dev;
+	int fn, nr = 0;
+	struct pci_dev *dev = NULL;
 
 	if (only_one_child(bus) && (devfn > 0))
 		return 0; /* Already scanned the entire slot */
 
-	dev = pci_scan_single_device(bus, devfn);
-	if (!dev)
-		return 0;
-	if (!pci_dev_is_added(dev))
-		nr++;
-
-	for (fn = next_fn(bus, dev, 0); fn > 0; fn = next_fn(bus, dev, fn)) {
+	for (fn = 0; fn >= 0; fn = next_fn(bus, dev, fn)) {
 		dev = pci_scan_single_device(bus, devfn + fn);
 		if (dev) {
 			if (!pci_dev_is_added(dev))
 				nr++;
-			dev->multifunction = 1;
+			if (nr > 1)
+				dev->multifunction = 1;
 		}
 	}
 
-- 
2.32.0

