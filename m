Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A979F4E740B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Mar 2022 14:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352038AbiCYNSL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Mar 2022 09:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354948AbiCYNSH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Mar 2022 09:18:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0603CBD2FB;
        Fri, 25 Mar 2022 06:16:32 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22PCgnMY007647;
        Fri, 25 Mar 2022 13:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8ZcdLk5T0IWhIrLNnnTj9Y2OwBlFiYs41brrdkBEdko=;
 b=sQK209c74tV48cciEReXvyEgGELSrQ7twjHiPG4qZVia/Zx1+849xmUHOvqVrswGfNQF
 I28adDPiaO663ZJ8VfDchCZQE5VHiOUH633dinsuCGxnz1ILWer/U2QoyQbAFFwYk1HY
 Ktp+PGd1187wx6e+kevSgmOAgQVwmDUVYZmFIW+z7kH1uO2Yys4nqCytRcjrkGLd8Q81
 C12I/B5MIL3hAvNpILnO9ITnM9zofjeoQgN2yhlfOjUJ30xth9JwGfutsdBAF4Vnw4dH
 KCUwru062QPuM9wmpIizD/ExKftRvR6vGfev2FMu5VqES6HYNxObcQYVznFxlQ/3txyY wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f0prmx4tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 13:16:29 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22PCiJsn013398;
        Fri, 25 Mar 2022 13:16:29 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f0prmx4t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 13:16:29 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22PDBSNR019024;
        Fri, 25 Mar 2022 13:16:27 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3ew6t9kb85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 13:16:27 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22PDGOaR43254168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 13:16:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E360D5204F;
        Fri, 25 Mar 2022 13:16:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id ABF555204E;
        Fri, 25 Mar 2022 13:16:23 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 1/2] PCI: Extend isolated function probing to s390
Date:   Fri, 25 Mar 2022 14:16:22 +0100
Message-Id: <20220325131623.4183566-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wc8UpLAc3XFaj7s2qD1nz5xypP3dTRhl
X-Proofpoint-GUID: W6ad6mpEwRUVKfnD-cWRmTp8kHxL2tLV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_02,2022-03-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=847 clxscore=1011 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203250073
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
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
 drivers/pci/probe.c        | 4 ++--
 include/linux/hypervisor.h | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 17a969942d37..e8fd89a1f984 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2869,11 +2869,11 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 		nr_devs = pci_scan_slot(bus, devfn);
 
 		/*
-		 * The Jailhouse hypervisor may pass individual functions of a
+		 * Some hypervisors may pass individual functions of a
 		 * multi-function device to a guest without passing function 0.
 		 * Look for them as well.
 		 */
-		if (jailhouse_paravirt() && nr_devs == 0) {
+		if (hypervisor_isolated_pci_functions() && nr_devs == 0) {
 			for (fn = 1; fn < 8; fn++) {
 				dev = pci_scan_single_device(bus, devfn + fn);
 				if (dev)
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

