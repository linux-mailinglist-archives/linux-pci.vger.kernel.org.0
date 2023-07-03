Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA932745DE0
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jul 2023 15:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjGCNxg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jul 2023 09:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjGCNxe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jul 2023 09:53:34 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884B1173D;
        Mon,  3 Jul 2023 06:53:03 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363DnIBt028914;
        Mon, 3 Jul 2023 13:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kOVkRocUNzoCE3Ax5Q0vzHkYAKeyWtHflf+V2JFhZf0=;
 b=WSqkNri2m9NCeihrVBP6yvMLLxokRAhAPwE5nq8IHC11BIj6hBy4kM/cLhGUPJ0Aws+L
 IaAOSJPcLoSi5mt6qdJ2cpRENfqcPgpkrqJeUWhx53xYIpQjYDeS8gk5ArkQS8Qtln0+
 SmKrS3h6HipdWrqsb2yLg48vImYgVHGsw9LhTWBpGxjqaeN7bcH5TOd9Bxc4VjJFi9Sg
 /MDDJldL7sPoKpfq/cyP+J0ZfvcqayENH03fQU/tpkD9x0xJlhqCir6jP2oJy80ZWx52
 XQ64MlU819bKKvphteaiy/V2AcuppDdgHvzs9E/x0xMHp2oVUR2+ck34S89nJXR1KZy3 hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rkyj20345-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 13:53:00 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 363Do6g2032231;
        Mon, 3 Jul 2023 13:53:00 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rkyj2033k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 13:53:00 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3639lk2o015520;
        Mon, 3 Jul 2023 13:52:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3rjbdds0dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 13:52:58 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 363DquFh20775468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Jul 2023 13:52:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DF3920043;
        Mon,  3 Jul 2023 13:52:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 156D52004B;
        Mon,  3 Jul 2023 13:52:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  3 Jul 2023 13:52:56 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] PCI/sysfs: Make I/O resource depend on HAS_IOPORT
Date:   Mon,  3 Jul 2023 15:52:55 +0200
Message-Id: <20230703135255.2202721-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703135255.2202721-1-schnelle@linux.ibm.com>
References: <20230703135255.2202721-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OYsUJTNEEXc8g8Xp-t235-NITmdmGW0i
X-Proofpoint-GUID: AiZlJ6jjpZ_9lAPf1U_VHBVqIkV4mYdl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030122
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If legacy I/O spaces are not supported simply return an error when
trying to access them via pci_resource_io(). This allows inb() and
friends to become undefined when they are known at compile time to be
non-functional in a later patch.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/pci-sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index ab32a91f287b..d9eede2dbc0e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1083,6 +1083,7 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 			       struct bin_attribute *attr, char *buf,
 			       loff_t off, size_t count, bool write)
 {
+#ifdef CONFIG_HAS_IOPORT
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 	int bar = (unsigned long)attr->private;
 	unsigned long port = off;
@@ -1116,6 +1117,9 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 		return 4;
 	}
 	return -EINVAL;
+#else
+	return -ENXIO;
+#endif
 }
 
 static ssize_t pci_read_resource_io(struct file *filp, struct kobject *kobj,
-- 
2.39.2

