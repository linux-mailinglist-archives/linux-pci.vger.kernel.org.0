Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D954FE3DA
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 16:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356549AbiDLOdK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 10:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356532AbiDLOdI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 10:33:08 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A304A3CB;
        Tue, 12 Apr 2022 07:30:50 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23CCxmfC015455;
        Tue, 12 Apr 2022 14:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bKoLtvLfcm82us1xoeWaze5A7p2oO/TFQNVdc38KEkM=;
 b=rVCHZHdi5yH/VyKJ+QvJiaw1imf9zf+RfN4JIPMf1X0D+6nP0yv02YwasSrMibdilZnI
 TsOy/JAgDoU2WuIBmdlTKBR9hUvnHlRPe+moIlTuRM9h7ur05DuWxm0OfDFIq8CMNkHk
 mL5OU+oZhp9WuHc0ShgotqJK/IM9ofkE4GhglwHwPVQCaZ34oAsdjodPwYE5KV5ILoi+
 pAMPoAas3YowFIn+daGIWLfkBMXbgbrRkwC/63Whnyp+SqPzxoXbNu+skm9mw4Q6J+0F
 xD8evz6ABF+COYw9UWQbq6MIknfSVrU45lHHka1WhqJvWxyXA8aFPKa/SO7rEXN/OMrp Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fd7wcn9q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 14:30:46 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23CELhPT031311;
        Tue, 12 Apr 2022 14:30:46 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fd7wcn9pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 14:30:46 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23CEEQCu008981;
        Tue, 12 Apr 2022 14:30:44 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3fb1s8m3kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 14:30:44 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23CEUfFu52036014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 14:30:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F15752051;
        Tue, 12 Apr 2022 14:30:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 07EDB52065;
        Tue, 12 Apr 2022 14:30:41 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 3/4] PCI: Extend isolated function probing to s390
Date:   Tue, 12 Apr 2022 16:30:39 +0200
Message-Id: <20220412143040.1882096-4-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220412143040.1882096-1-schnelle@linux.ibm.com>
References: <20220412143040.1882096-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eVxS2wHnRjjmdsyOGIDn5ak4sup1JIIi
X-Proofpoint-ORIG-GUID: zedmkzZ4p5NlDc0h1ehUQNT9IOvXhdjB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-12_05,2022-04-12_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=836
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
index 8100e044dfc5..a57ea0ff1470 100644
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

