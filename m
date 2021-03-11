Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E6F3373B4
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 14:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhCKNXb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 08:23:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4260 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233523AbhCKNXY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 08:23:24 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12BDLYOY177910;
        Thu, 11 Mar 2021 08:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=HoI1Hk2ZBlzD7gj6q9asIOXi6AplmwxWdhOXCjCm0cY=;
 b=noVj3cpoohNaKk7zUikaMzBCbWOiBvFUmooIMuLkW1Z2UJD1J+4yMqpzXD524EBjR4lW
 me7A9Eyg5S8WADobj8AKZBKhCxo6WWAIaJSGhYE2WMTNSPC0YHETKMozcMoUbpwMVmJS
 OX2320iqfwGw/VgHRs0XKVURf90KPxCTS6CKfK9jkQonVlSuvP6wplsNxARAvfrjACNS
 61/XlWUWLmZladf++B+/A80Gmxc6jwgpqj1P778NhjYT9nNel206ubUqFfh8Te5D+uBO
 F1WALwNAavZtzdKrETSBybsh0hY3mc+SDhAX5cFXpSfbvDaitwAvXwiFETRyeB4VikPr Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774m073vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 08:23:22 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12BDMGjS184778;
        Thu, 11 Mar 2021 08:23:22 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774m073s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 08:23:21 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12BDMEeP020474;
        Thu, 11 Mar 2021 13:23:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 376mb0scu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 13:23:14 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12BDNCT844564988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 13:23:12 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89AC4A404D;
        Thu, 11 Mar 2021 13:23:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63793A4040;
        Thu, 11 Mar 2021 13:23:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Mar 2021 13:23:12 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Print a debug message on PCI device release
Date:   Thu, 11 Mar 2021 14:23:12 +0100
Message-Id: <20210311132312.2882425-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-11_04:2021-03-10,2021-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103110070
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 62795041418d ("PCI: enhance physical slot debug information")
added a debug print on releasing the PCI slot and another message on
destroying it. There is however no debug print on releasing the PCI
device structure itself and even with closely looking at the kernel log
during hotplug testing, I overlooked several missing pci_dev_put() calls
for way too long. So let's add a debug print in pci_release_dev() making
it much easier to spot when the PCI device structure is not released
when it is supposed to.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/probe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 953f15abc850..3e3669a00a2f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2226,6 +2226,7 @@ static void pci_release_dev(struct device *dev)
 	pci_bus_put(pci_dev->bus);
 	kfree(pci_dev->driver_override);
 	bitmap_free(pci_dev->dma_alias_mask);
+	dev_dbg(dev, "device released\n");
 	kfree(pci_dev);
 }
 
-- 
2.25.1

