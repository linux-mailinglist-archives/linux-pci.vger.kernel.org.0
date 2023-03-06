Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9EE6AC478
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 16:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjCFPKd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 10:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjCFPKb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 10:10:31 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF5222A1C;
        Mon,  6 Mar 2023 07:10:23 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326EwUsD023909;
        Mon, 6 Mar 2023 15:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nrXCAvaJjz2L30F4zB4s/xlzVnWIOeQfO3bhE2rcpwM=;
 b=fiVBcRZ+cNy6EJTI0ejxqv3csq0obX7dCNqqA/OKxFr6ijjEmHPB0z4p4Ijw4YYRljHW
 fEKMH86GXxQEpFD4IStI/PKOQoJpa6leazV3Ev+7lvA7HwH/pRybRDp8nXri9VpBChew
 PPfOOE0ZFufanZDwG2/+anP0d58jH1Z/Ra2vweNscajEpuOQWjqhomKRQEEh7xUI9IPr
 KC19CmS0zh0YCgrCp5ml/WYseDPNUfpJ09ym/bEQsAAx38E0SZY419c6oxXT3AXQ3im5
 xLPpefPDrUOf2tFWnOroQ212O0Lmm3E4wTGI+tZhPhjEDJFoZX+5eRuFBP5u3iVoL7bz OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p500dpbh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 15:10:22 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 326EuguL014491;
        Mon, 6 Mar 2023 15:10:22 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p500dpbg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 15:10:22 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3265Wnpw030346;
        Mon, 6 Mar 2023 15:10:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3p417q29ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 15:10:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326FAGKt17039772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 15:10:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0200C20040;
        Mon,  6 Mar 2023 15:10:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3FEE20049;
        Mon,  6 Mar 2023 15:10:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 15:10:15 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 2/4] s390/pci: only add specific device in zpci_bus_scan_device()
Date:   Mon,  6 Mar 2023 16:10:12 +0100
Message-Id: <20230306151014.60913-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230306151014.60913-1-schnelle@linux.ibm.com>
References: <20230306151014.60913-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K5H1T0Z0G4VSQ-gHJOwzuz_RGFiVhN7h
X-Proofpoint-GUID: 51UhDrOQm3kH5qjA4TWU4712uDItC64q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_08,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060133
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As the name suggests zpci_bus_scan_device() is used to scan a specific
device and thus pci_bus_add_device() for that device is sufficient.
Furthermore move this call inside the rescan/remove locking.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci_bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index a99926af2b69..ae46c280b35f 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -85,9 +85,8 @@ int zpci_bus_scan_device(struct zpci_dev *zdev)
 	if (!pdev)
 		return -ENODEV;
 
-	pci_bus_add_device(pdev);
 	pci_lock_rescan_remove();
-	pci_bus_add_devices(zdev->zbus->bus);
+	pci_bus_add_device(pdev);
 	pci_unlock_rescan_remove();
 
 	return 0;
-- 
2.37.2

