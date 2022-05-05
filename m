Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DEF51BAB4
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 10:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349741AbiEEIma (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 04:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346179AbiEEIm3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 04:42:29 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A449B49C80;
        Thu,  5 May 2022 01:38:50 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2458E8Vh003693;
        Thu, 5 May 2022 08:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=M1zvcLMG92FcPS3g1DuhwhZILf+zrGpIaNaaLno10YU=;
 b=rzQQIlyG9QLWACBzo0S5tel4b9OaKNqPSFSNk0mlIp5hfZk8b6RrGCTZLPMaxTpDnyqC
 qXeNYp+kr5HUOG7DGEK3iLIuuOaCnd8noyqZC1KP1CpoUdqH6xDb/Z2mvSB6rHZVLu7M
 Ehiy7SOUDafIRQvq+US98tywR1VZ+/zUaPWe8+xKlOFo/ZGlgFU3V3Wy1EbB53bYDWve
 9ujceayJHbZIZXg5zYh38gLoy5b8vXb+02eRG+GAQccBTLp9lbQ0YkF42oyrax4pKa9e
 8OBa4LyCHK93NFiMqyK/9clKopDVFSi6+Op2BAq0fgjzw/QlMbIol98BdqjGfqcFLEUv bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fvavw8c8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 08:38:46 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2458Ltni013170;
        Thu, 5 May 2022 08:38:45 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fvavw8c8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 08:38:45 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2458ZARJ015579;
        Thu, 5 May 2022 08:38:43 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3fuxwkrnna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 08:38:43 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2458cecG48038174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 May 2022 08:38:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FF5211C04A;
        Thu,  5 May 2022 08:38:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C01011C050;
        Thu,  5 May 2022 08:38:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 May 2022 08:38:40 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH RESEND v5 3/4] PCI: Extend isolated function probing to s390
Date:   Thu,  5 May 2022 10:38:38 +0200
Message-Id: <20220505083839.1315705-4-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505083839.1315705-1-schnelle@linux.ibm.com>
References: <20220505083839.1315705-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NneUbkkqHQCD1bqXHyEtMSnl21YNPwNm
X-Proofpoint-ORIG-GUID: yM2KTLT7oIWxQms6Ex6487p6gnFJ_iHR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_02,2022-05-04_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 mlxscore=0 mlxlogscore=725
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205050055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

