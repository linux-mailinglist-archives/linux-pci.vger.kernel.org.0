Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC1C50B876
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 15:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447980AbiDVNcC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 09:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447856AbiDVNcB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 09:32:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C69583BB;
        Fri, 22 Apr 2022 06:29:08 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MDLuN2020821;
        Fri, 22 Apr 2022 13:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ygE5+1meGvcKP2/tAe38a6QKBBr1TeP2Ud+3qPbKUZE=;
 b=Us5boSzoNj8DOYivKsiSJkHENOAsi87YYP2xKrR2wot41Uq+0DMWQNq/csHKIiIvvZ8y
 GY/hfGcYaxK0ljVtqNhLUoW28eOukbZbBjtTdFDQPtMpcf8fH33L4kl4fA0J9m6M1ivX
 XRZajmvG0azWYQArsi+k9z9EjgJUp0/i954ilouYx/4J3fT6whjFabPGI/pG+8Crh0iV
 T5PpgHNNCmPszllFvuQpzUUBl7rjh2VaIxPY4+MiL/0MjhiycN3WyryrNTVrEjONGyrO
 TvshrzE/65J2Wj5cod5VuVjBvZP5O6W6XlGdIJvbl+lRvelpUHIy5+QGX+Q0yUXemQ/n 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fkrbbp6ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 13:29:04 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23MD6Wmd009075;
        Fri, 22 Apr 2022 13:29:04 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fkrbbp6br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 13:29:03 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23MDLVJc016660;
        Fri, 22 Apr 2022 13:29:02 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3ffne8yge6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 13:29:01 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23MDTAmJ61342170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 13:29:10 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09DEF42041;
        Fri, 22 Apr 2022 13:28:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B509542049;
        Fri, 22 Apr 2022 13:28:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Apr 2022 13:28:58 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v4 1/4] PCI: Clean up pci_scan_slot()
Date:   Fri, 22 Apr 2022 15:28:55 +0200
Message-Id: <20220422132858.1213022-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220422132858.1213022-1-schnelle@linux.ibm.com>
References: <20220422132858.1213022-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dnp3dCls5ZVMednp3QkN4U9N-PXrMb3n
X-Proofpoint-GUID: Grp4JBmf5BJNU_Q_4dhxkQKcUMT2FlVT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_03,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=826
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/pci/probe.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 17a969942d37..2000e9858f12 100644
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
@@ -2588,24 +2587,27 @@ static unsigned int next_fn(struct pci_bus *bus, struct pci_dev *dev,
 
 	if (pci_ari_enabled(bus)) {
 		if (!dev)
-			return 0;
+			return -ENODEV;
+
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
@@ -2643,26 +2645,25 @@ static int only_one_child(struct pci_bus *bus)
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

