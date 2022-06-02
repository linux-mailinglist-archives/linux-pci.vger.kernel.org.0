Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C9253B73A
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 12:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbiFBKao (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 06:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbiFBKak (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 06:30:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB99869CEA;
        Thu,  2 Jun 2022 03:30:26 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2528huZ8026615;
        Thu, 2 Jun 2022 10:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=M1zvcLMG92FcPS3g1DuhwhZILf+zrGpIaNaaLno10YU=;
 b=RpWABqtmkAwy6aJG7fJiNfz9QkUXMbXPy3nO2JZPFuMmK00FDtGufUPJDaV6/0QH27iU
 N27tLffnNup/uRTSsrmc9ElqTHiOA+OErYIzfPr7mEvJEZMHzx8b2VBa1DNjSgkYDXaQ
 zqJKgJfuaKhQm6Tvxq+qrFh7q5mKXjFvP1Cp5OpVotvrTFgRhaTbwKfxotTp9D+vKfS1
 qfij27IM2N50wmGo5rB26sOeyxfSDbJD5x1YcYkjHAs4tWipdAG6s2nnG2wdfFZjBfUk
 2vn7zwVRBxWoT0GMvLgVOZ/uDu2zGOKIB4J8oiaYl6gUAeUyKgkVAW7MSneIwh3b0SGj BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gesxvhsk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 10:30:22 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 252A01v8000403;
        Thu, 2 Jun 2022 10:30:22 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gesxvhsjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 10:30:22 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 252AK6Ge030075;
        Thu, 2 Jun 2022 10:30:20 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3gdnetthcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 10:30:20 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 252AUHKo17432940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Jun 2022 10:30:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 417CFA4040;
        Thu,  2 Jun 2022 10:30:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 106F6A405F;
        Thu,  2 Jun 2022 10:30:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  2 Jun 2022 10:30:17 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v5 3/4] PCI: Extend isolated function probing to s390
Date:   Thu,  2 Jun 2022 12:30:15 +0200
Message-Id: <20220602103016.1499031-4-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220602103016.1499031-1-schnelle@linux.ibm.com>
References: <20220602103016.1499031-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y5wpetDq_XbSXnADrqy6PhD8fyf54e2L
X-Proofpoint-GUID: KYx-51UsDP7VI9oWe4WZ3X-XImq6BBGs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-02_01,2022-06-01_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 mlxlogscore=712 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206020042
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Cc: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/probe.c        | 2 +-
 include/linux/hypervisor.h | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3029edc68ff7..4e27cc929095 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2663,7 +2663,7 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
 			 * a hypervisor which passes through individual PCI
 			 * functions.
 			 */
-			if (!jailhouse_paravirt())
+			if (!hypervisor_isolated_pci_functions())
 				break;
 		}
 		fn = next_fn(bus, dev, fn);
diff --git a/include/linux/hypervisor.h b/include/linux/hypervisor.h
index fc08b433c856..33b1c0482aac 100644
--- a/include/linux/hypervisor.h
+++ b/include/linux/hypervisor.h
@@ -32,4 +32,12 @@ static inline bool jailhouse_paravirt(void)
 
 #endif /* !CONFIG_X86 */
 
+static inline bool hypervisor_isolated_pci_functions(void)
+{
+	if (IS_ENABLED(CONFIG_S390))
+		return true;
+	else
+		return jailhouse_paravirt();
+}
+
 #endif /* __LINUX_HYPEVISOR_H */
-- 
2.32.0

