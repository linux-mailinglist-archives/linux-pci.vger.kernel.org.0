Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B6F6AC477
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 16:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCFPKc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 10:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjCFPKb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 10:10:31 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9469A21A15;
        Mon,  6 Mar 2023 07:10:23 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326E4XeR018627;
        Mon, 6 Mar 2023 15:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cdeoGIcHHzCL0k2JupdvblKXHbuQ6+3cuSp2bpqbVuw=;
 b=Y8LGMwzRelHs4lavqBhBjbCUyQhn1G1aEtTSx+kbfIWvxsSiq1QySQxT4jBdjfFU3C3X
 CtTJYAimPRxD+8yuv8KBv+vimIH8Uq2RoS+5WIbD3ZBa0z83jpqRgxU+kCL+FeU84Aaf
 35pxyFC2RZt+AW9VxZBQuKgVnhFkKFrrH1mUyrsp4IZLzC5p/iKw5B/XYyoYrd46n+8F
 C5Rf1JakNTPhI0Mt6ZmPX8f57stYM3vzzbnTxfUOYf2jTxNgY2YhgsLnW5q6PBgVY13Y
 //U1meB92hYjY3NjTCxa0XXdt0a8EF9+RrVnM3FR8yD0lgbQddVx7FZAqex7qlpy3ziI fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p507ny1er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 15:10:22 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 326EtDSi016069;
        Mon, 6 Mar 2023 15:10:22 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p507ny1dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 15:10:22 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 326BsSEf007338;
        Mon, 6 Mar 2023 15:10:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3p4188avpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 15:10:20 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326FAG2516646640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 15:10:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91FA32004F;
        Mon,  6 Mar 2023 15:10:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58A012004D;
        Mon,  6 Mar 2023 15:10:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 15:10:16 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 4/4] s390/pci: clean up left over special treatment for function zero
Date:   Mon,  6 Mar 2023 16:10:14 +0100
Message-Id: <20230306151014.60913-5-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230306151014.60913-1-schnelle@linux.ibm.com>
References: <20230306151014.60913-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IcLO8TOR6pRVsDO2-ZyQJCW8KESMkqAQ
X-Proofpoint-ORIG-GUID: eJCSNeUOt5cZyM-r4XCGa6_SWrlPeyfV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_08,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060133
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Prior to commit 960ac3626487 ("s390/pci: allow zPCI zbus without
a function zero") enabling and scanning a PCI function had to
potentially be postponed until the function with devfn zero on that bus
was plugged. While the commit removed the waiting itself extra code to
scan all functions on the PCI bus once function zero appeared was
missed. Remove that code and the outdated comments about waiting for
function zero.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index e16afacc8fd1..f5709b5dae7a 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -874,32 +874,15 @@ bool zpci_is_device_configured(struct zpci_dev *zdev)
  * @fh: The general function handle supplied by the platform
  *
  * Given a device in the configuration state Configured, enables, scans and
- * adds it to the common code PCI subsystem if possible. If the PCI device is
- * parked because we can not yet create a PCI bus because we have not seen
- * function 0, it is ignored but will be scanned once function 0 appears.
- * If any failure occurs, the zpci_dev is left disabled.
+ * adds it to the common code PCI subsystem if possible.If any failure occurs,
+ * the zpci_dev is left disabled.
  *
  * Return: 0 on success, or an error code otherwise
  */
 int zpci_scan_configured_device(struct zpci_dev *zdev, u32 fh)
 {
-	int rc;
-
 	zpci_update_fh(zdev, fh);
-	/* the PCI function will be scanned once function 0 appears */
-	if (!zdev->zbus->bus)
-		return 0;
-
-	/* For function 0 on a multi-function bus scan whole bus as we might
-	 * have to pick up existing functions waiting for it to allow creating
-	 * the PCI bus
-	 */
-	if (zdev->devfn == 0 && zdev->zbus->multifunction)
-		rc = zpci_bus_scan_bus(zdev->zbus);
-	else
-		rc = zpci_bus_scan_device(zdev);
-
-	return rc;
+	return zpci_bus_scan_device(zdev);
 }
 
 /**
-- 
2.37.2

