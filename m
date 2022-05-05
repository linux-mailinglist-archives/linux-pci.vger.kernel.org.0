Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169C851BABA
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 10:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349794AbiEEImc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 04:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349784AbiEEImb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 04:42:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A3249C8B;
        Thu,  5 May 2022 01:38:52 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2457xWJq019540;
        Thu, 5 May 2022 08:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=eQMrxDwS4o5AY3NeYTPbXuHkF5e1oKNwRgLoIiLPsKE=;
 b=EMmk08qo0me1lfMvCA+nFjtST0Cj78zlgM4iM1eUuxiFzIa2gvHSu6DXsOPJODaBhLsn
 r7XLHzw4a1R6UQQa53ddiiA3FEHhFwvoPlaiuaoqtly8gv23kK2PrrcnnjdsY3ZlkSpL
 tnsu6JsGJqWbbTm0PXq0NtMcGp69HfooazWLFIFraF3je5ksXRdXV8fDwxL/L2BnYp+p
 ey1z3nWI5QR8xe/qy2ggAZjIXLpCD9Vg9bKvAuJVFA495hYqgjmO+L0vBHrnDmJOGlPn
 WpQVm2Khl92pbML3mTYNx2d8obysj/qEcSrYoOF0k8Y+DKdeJdy03ehIiSEvnuA5GzsQ +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fv7w5betn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 08:38:46 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2458KvMw017230;
        Thu, 5 May 2022 08:38:45 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fv7w5bet0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 08:38:45 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2458YW0F028380;
        Thu, 5 May 2022 08:38:43 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3frvcj6w5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 08:38:43 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2458cels50790688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 May 2022 08:38:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00C6E11C04A;
        Thu,  5 May 2022 08:38:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0B8411C050;
        Thu,  5 May 2022 08:38:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 May 2022 08:38:39 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH RESEND v5 1/4] PCI: Clean up pci_scan_slot()
Date:   Thu,  5 May 2022 10:38:36 +0200
Message-Id: <20220505083839.1315705-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505083839.1315705-1-schnelle@linux.ibm.com>
References: <20220505083839.1315705-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H3T2bmtFXG4-hx5o3DsuI46mqvzrRfVL
X-Proofpoint-ORIG-GUID: MhCCQx5Kko8KoCD-vcw7CGz62AaUiKAO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_02,2022-05-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxlogscore=812 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205050059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

While determining the next PCI function is factored out of
pci_scan_slot() into next_fn() the former still handles the first
function as a special case. This duplicates the code from the scan loop.

Furthermore the non ARI branch of next_fn() is generally hard to
understand and especially the check for multifunction devices is hidden
in the handling of NULL devices for non-contiguous multifunction. It
also signals that no further functions need to be scanned by returning
0 via wraparound and this is a valid function number.

Improve upon this by transforming the conditions in next_fn() to be
easier to understand.

By changing next_fn() to return -ENODEV instead of 0 when there is no
next function we can then handle the initial function inside the loop
and deduplicate the shared handling. This also makes it more explicit
that only function 0 must exist.

No functional change is intended.

Cc: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/probe.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 17a969942d37..78aa1bccab2f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2579,8 +2579,7 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
 }
 EXPORT_SYMBOL(pci_scan_single_device);
 
-static unsigned int next_fn(struct pci_bus *bus, struct pci_dev *dev,
-			    unsigned int fn)
+static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
 {
 	int pos;
 	u16 cap = 0;
@@ -2588,24 +2587,26 @@ static unsigned int next_fn(struct pci_bus *bus, struct pci_dev *dev,
 
 	if (pci_ari_enabled(bus)) {
 		if (!dev)
-			return 0;
+			return -ENODEV;
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
+	if (fn >= 7)
+		return -ENODEV;
 
-	/* dev may be NULL for non-contiguous multifunction devices */
-	if (!dev || dev->multifunction)
-		return (fn + 1) % 8;
+	/* only multifunction devices may have more functions */
+	if (dev && !dev->multifunction)
+		return -ENODEV;
 
-	return 0;
+	return fn + 1;
 }
 
 static int only_one_child(struct pci_bus *bus)
@@ -2643,26 +2644,25 @@ static int only_one_child(struct pci_bus *bus)
  */
 int pci_scan_slot(struct pci_bus *bus, int devfn)
 {
-	unsigned int fn, nr = 0;
 	struct pci_dev *dev;
+	int fn = 0, nr = 0;
 
 	if (only_one_child(bus) && (devfn > 0))
 		return 0; /* Already scanned the entire slot */
 
-	dev = pci_scan_single_device(bus, devfn);
-	if (!dev)
-		return 0;
-	if (!pci_dev_is_added(dev))
-		nr++;
-
-	for (fn = next_fn(bus, dev, 0); fn > 0; fn = next_fn(bus, dev, fn)) {
+	do {
 		dev = pci_scan_single_device(bus, devfn + fn);
 		if (dev) {
 			if (!pci_dev_is_added(dev))
 				nr++;
-			dev->multifunction = 1;
+			if (fn > 0)
+				dev->multifunction = 1;
+		} else if (fn == 0) {
+			/* function 0 is required */
+			break;
 		}
-	}
+		fn = next_fn(bus, dev, fn);
+	} while (fn >= 0);
 
 	/* Only one slot has PCIe device */
 	if (bus->self && nr)
-- 
2.32.0

