Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BB14FE3D5
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 16:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356543AbiDLOdJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 10:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355090AbiDLOdH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 10:33:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B315EDD1;
        Tue, 12 Apr 2022 07:30:49 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23CCpI0K024862;
        Tue, 12 Apr 2022 14:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QnPfcT3aQm4wRRbd1y2TwgeqmbD666U2uW+Vxfg7yaQ=;
 b=k5HmvYUzNEKLjgpmjyAHxkR4xWbizrqwQW44riS0FXVCUVowrMMKv+KF0SHYM+D+RTXi
 JjS/W2lUISFjhu2QRjmSVCoQhcjFYf26A9Wt5a3jYjhLOhMQXVtSPfWtV80plLhCK2I8
 pTxlWsunZ9SlRH11Mcyjj22jTxPijeTnqkSogdIpXRvg2OIOnVovyd/yvvSFkWKXIMMw
 ct86DxHd6VTDWQo2gvlGc59+zZUwYVzM6ae26rA2zz3KaTy7aDP20w8V5LZh3DfyULAI
 A1OxFIYvBngod6hPxGl/xuriDn0b24vLLEkW0osYPXNoIDtiaJ22bQP+6NW+qJqSmgA6 UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fd9t0adfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 14:30:46 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23CDe5Mi024231;
        Tue, 12 Apr 2022 14:30:46 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fd9t0adeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 14:30:46 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23CEEVvp008989;
        Tue, 12 Apr 2022 14:30:43 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3fb1s8m3kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 14:30:43 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23CEUea939780772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 14:30:40 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2E7E52051;
        Tue, 12 Apr 2022 14:30:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8BB3752065;
        Tue, 12 Apr 2022 14:30:40 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 1/4] PCI: Clean up pci_scan_slot()
Date:   Tue, 12 Apr 2022 16:30:37 +0200
Message-Id: <20220412143040.1882096-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220412143040.1882096-1-schnelle@linux.ibm.com>
References: <20220412143040.1882096-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Nq8p9b8seVNkcfbCNa8WR1XbX6X0953G
X-Proofpoint-GUID: VPosIRNNQ3HJB8YY6OpN-PR4IN6ZWAoA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-12_05,2022-04-12_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204120068
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

