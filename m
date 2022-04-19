Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5D65068B6
	for <lists+linux-pci@lfdr.de>; Tue, 19 Apr 2022 12:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350663AbiDSKa5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Apr 2022 06:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242212AbiDSKa4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2022 06:30:56 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6D627FC9;
        Tue, 19 Apr 2022 03:28:13 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23J8RrNB004745;
        Tue, 19 Apr 2022 10:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Gq2oKIc1RzWTzoNaDxTmQ2QjMaScxj7ajJ62N5KdPA8=;
 b=kI3gMNQU7BweAePKs8NojIdNG3CdZZn3x7IZSo1PvbEUnpBTAL9CvZnb8piu1xVNXnNs
 ohuK6LRPobMUZKJbhrwkzsgjXdz7Q4yYrGWpffHKZ9wgsOxqlNZqfR7z4Mq3xNMffPZx
 /RGKqtZlCXp6J7wueapszCGD9fE5zLDksmEYCU5zfYNRAMFDOQiwL1D6JI2NF0GgUNwV
 Gmegi5W3/wP7xfsnOfcXF2mldTZo2kB6xZ1CP05p3M+I1Z4j4EWHYbcP7cFBlkBz+v35
 k9zRdgetCOU5kTHFcn4vrSEyi1QuxeAnImJJeRSMDctT3hWjTrjXRfGwdsUFgwom5MBS iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7ekva0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 10:28:10 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23JA9QDE006964;
        Tue, 19 Apr 2022 10:28:10 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7ekva0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 10:28:10 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23JACvwW007462;
        Tue, 19 Apr 2022 10:28:08 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3fgu6u1t4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 10:28:08 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23JAS5gb17957370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 10:28:05 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DADAB11C052;
        Tue, 19 Apr 2022 10:28:04 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4C6711C058;
        Tue, 19 Apr 2022 10:28:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Apr 2022 10:28:04 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v3 3/4] PCI: Extend isolated function probing to s390
Date:   Tue, 19 Apr 2022 12:28:02 +0200
Message-Id: <20220419102803.3430139-4-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220419102803.3430139-1-schnelle@linux.ibm.com>
References: <20220419102803.3430139-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: k2VqLELu8Q9weWumHrKuTUxMV4bR4NiC
X-Proofpoint-GUID: OCethT7X0KOLKk3tuW0XMH0rl49aOvks
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_03,2022-04-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=832 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1015
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

Like the jailhouse hypervisor s390's PCI architecture allows passing
isolated PCI functions to an OS instance. As of now this is was not
utilized even with multi-function support as the s390 PCI code makes
sure that only virtual PCI busses including a function with devfn 0 are
presented to the PCI subsystem. A subsequent change will remove this
restriction.

Allow probing such functions by replacing the existing check for
jailhouse_paravirt() with a new hypervisor_isolated_pci_functions()
helper.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/probe.c        | 8 ++++----
 include/linux/hypervisor.h | 9 +++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a1e8f1e14c3d..09b46746d48e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2602,11 +2602,11 @@ static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
 	if (dev && !dev->multifunction)
 		return -ENODEV;
 	/*
-	 * Usually a function 0 is required but the jailhouse hypervisor may
-	 * pass individual functions. For non-contiguous multifunction devices
-	 * some functions may also be missing.
+	 * Usually a function 0 is required but some hypervisors may pass
+	 * individual functions. For non-contiguous multifunction devices some
+	 * functions may also be missing.
 	 */
-	if (!fn && !dev && !jailhouse_paravirt())
+	if (!fn && !dev && !hypervisor_isolated_pci_functions())
 		return -ENODEV;
 	return (fn <= 6) ? fn + 1 : -ENODEV;
 }
diff --git a/include/linux/hypervisor.h b/include/linux/hypervisor.h
index fc08b433c856..52abd459f9a3 100644
--- a/include/linux/hypervisor.h
+++ b/include/linux/hypervisor.h
@@ -32,4 +32,13 @@ static inline bool jailhouse_paravirt(void)
 
 #endif /* !CONFIG_X86 */
 
+static inline bool hypervisor_isolated_pci_functions(void)
+{
+	if (IS_ENABLED(CONFIG_S390))
+		return true;
+	else
+		return jailhouse_paravirt();
+}
+
+
 #endif /* __LINUX_HYPEVISOR_H */
-- 
2.32.0

