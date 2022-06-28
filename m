Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB6D55E811
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 18:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346645AbiF1ObQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 10:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346539AbiF1ObN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 10:31:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B5531388;
        Tue, 28 Jun 2022 07:31:10 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SEH09f028940;
        Tue, 28 Jun 2022 14:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VDvAOC9IBHLsG7T0+yCHF0Na5NSX7aR9kmK/JjSN6kc=;
 b=cUoHXCfQF1UbS/e1RM3rQT6gQmQvZcQCOSKn/nyOMIKeydWfQLYOCb9tXbAqOnF9b6KJ
 +dOQOTr3ksCgkhvC3rSi2rVh/LNjFoVU4PIasJN5UM9ENWrod938EFOmRrMiomcyiRhU
 OG5HidcLvco6qbEyCbGu3EpYIVGF2wQm1X1Yhdc63TPQsArTs/4+qIGMqXe0tVceWyEI
 FzlQTxjvbMawdT4bSZf/QIXP3wIejqhNL2/LfvOggHU7FuKg/ftpB+z/FGidMkrUJJmO
 iA+WxV3+IJBTE99TrGAdnQWIBzy1QII8rJZUS2DXv5LeDHiwG4qeO6xx88ofpFTpDRGU kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h03968h2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 14:31:06 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25SEHLsI030160;
        Tue, 28 Jun 2022 14:31:06 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h03968h1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 14:31:06 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25SELdUn022017;
        Tue, 28 Jun 2022 14:31:04 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3gwsmj51fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 14:31:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25SEV16q23658950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 14:31:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61E02A4054;
        Tue, 28 Jun 2022 14:31:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2054AA4060;
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
Subject: [PATCH v6 2/5] PCI: Split out next_ari_fn() from next_fn()
Date:   Tue, 28 Jun 2022 16:30:57 +0200
Message-Id: <20220628143100.3228092-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220628143100.3228092-1-schnelle@linux.ibm.com>
References: <20220628143100.3228092-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6hHpoGfa25fy2Psn1FDo1WXDdL-Gf6ow
X-Proofpoint-GUID: SHbbB6ql_HsRo1ZRxJH3cYGcPgj0_0lr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_07,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 mlxlogscore=951
 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In commit b1bd58e448f2 ("PCI: Consolidate "next-function" functions")
the next_fn() function subsumed the traditional and ARI based next
function determination. This got rid of some needlessly complex function
pointer handling but also reduced the separation between these very
different methods of finding the next function. With the next_fn()
cleaned up a bit we can re-introduce this separation by moving out the
ARI handling while sticking with direct function calls.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/probe.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b05d0ed83a24..2c737dce757e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2579,26 +2579,30 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
 }
 EXPORT_SYMBOL(pci_scan_single_device);
 
-static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
+static int next_ari_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
 {
 	int pos;
 	u16 cap = 0;
 	unsigned int next_fn;
 
-	if (pci_ari_enabled(bus)) {
-		if (!dev)
-			return -ENODEV;
-		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI);
-		if (!pos)
-			return -ENODEV;
+	if (!dev)
+		return -ENODEV;
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI);
+	if (!pos)
+		return -ENODEV;
+
+	pci_read_config_word(dev, pos + PCI_ARI_CAP, &cap);
+	next_fn = PCI_ARI_CAP_NFN(cap);
+	if (next_fn <= fn)
+		return -ENODEV;	/* protect against malformed list */
 
-		pci_read_config_word(dev, pos + PCI_ARI_CAP, &cap);
-		next_fn = PCI_ARI_CAP_NFN(cap);
-		if (next_fn <= fn)
-			return -ENODEV;	/* protect against malformed list */
+	return next_fn;
+}
 
-		return next_fn;
-	}
+static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
+{
+	if (pci_ari_enabled(bus))
+		return next_ari_fn(bus, dev, fn);
 
 	if (fn >= 7)
 		return -ENODEV;
-- 
2.32.0

