Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5C055E64B
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 18:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiF1ObR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 10:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346605AbiF1ObN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 10:31:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275EC31501;
        Tue, 28 Jun 2022 07:31:11 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SENWcR015279;
        Tue, 28 Jun 2022 14:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XZAX0nLebx6+CKexydBMA2psgxPUnxx+7ASCiTl4hWs=;
 b=iGHt6F7azqj4ok9ATgVC1IUn1pKzsjNWwAYIU0zCqQ7X2oQrkcqZoowfgVWmQ3PJVYbo
 CC7FTIBy/vMTY7NjjMnUO2RQNC4GEg2Uhp+UAqr3tH4Bf0g5rXkA1oBKeBVIFIHhKvDE
 UcjnBUi3GVbInfUgTEYVyIH5t7Zg/rRnYBGZLFCSiPzZbfVw2tRNduo2PWIlrCefC4wQ
 FaqWLyJVeyT5112j+nM3ThAcIrIYoCyXU8sKOxvR0HPybvlbjsWKBvsI6M9nkYQoyND/
 5WOUzkboQBfD08O+cyi9CjUUUXzj8+pPsrl+6AbfY/89onq+yXjuaQMaWoAIrc+FLvIi MA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h03c7r7wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 14:31:07 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25SENlY1016769;
        Tue, 28 Jun 2022 14:31:07 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h03c7r7uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 14:31:07 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25SEKcKT003901;
        Tue, 28 Jun 2022 14:31:05 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3gwt08w0hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 14:31:05 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25SEV8BZ29557102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 14:31:09 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0052EA4060;
        Tue, 28 Jun 2022 14:31:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B79BBA4054;
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
Subject: [PATCH v6 4/5] PCI: Extend isolated function probing to s390
Date:   Tue, 28 Jun 2022 16:30:59 +0200
Message-Id: <20220628143100.3228092-5-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220628143100.3228092-1-schnelle@linux.ibm.com>
References: <20220628143100.3228092-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MqtqOHXCOc92SdoQkLbhdP9K3kVS-4fv
X-Proofpoint-ORIG-GUID: 3-TAKdI6o1oQDxqAxW0awKlKxuS-Gzxx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_07,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxlogscore=674 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280059
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
index a18e07e6a7df..156dd13594b8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2667,7 +2667,7 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
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

