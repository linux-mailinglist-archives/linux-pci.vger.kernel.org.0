Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D0B40D646
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 11:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbhIPJfJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 05:35:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235582AbhIPJfH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 05:35:07 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18G80eiI015912;
        Thu, 16 Sep 2021 05:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qsA7PkV5pI59qeVSVGVfVRV97WN1QFXQJwB3Icmh79U=;
 b=LLrPq+HyvYaSIELJ+eU34NtviaqXZnfP1SxkQth9vg+5a0xQ84RCkJQWl6qGUqqMmeq4
 0tGOICigXxYLBIGcUirHAYDyvbAlN2QeMamqaT5Z2ugGLgzI1JstPa3CoGYlSQgR6Bk5
 GakVH0yYh33b6QIXGJ4NQpbiu+2GWqjDqV1f6uihWPia9o4ie8YtDfR0lQJnv6nvbBpX
 MUgwDQsq4kiyzcx/C97jDb1h0wYrRs4R0qnYkbXlnXJ9a/JUaQjQBfBjfnAvg0tLX93s
 iq4KvWeuT0UAYAdjOIFkHGR82NCsYCXST8VK1iZe6jSMf4ai81/VOigl4eeomwmIXWPv /g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b421g1wgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 05:33:45 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18G9H2FC024718;
        Thu, 16 Sep 2021 05:33:44 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b421g1wg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 05:33:44 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18G9WVJi003798;
        Thu, 16 Sep 2021 09:33:42 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3b0m39xh7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 09:33:42 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18G9Xcxb30671202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 09:33:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A57414203F;
        Thu, 16 Sep 2021 09:33:38 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DEBA4204D;
        Thu, 16 Sep 2021 09:33:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Sep 2021 09:33:38 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linas Vepstas <linasvepstas@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org, Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v2 3/4] PCI: Export pci_dev_lock()
Date:   Thu, 16 Sep 2021 11:33:35 +0200
Message-Id: <20210916093336.2895602-4-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916093336.2895602-1-schnelle@linux.ibm.com>
References: <20210916093336.2895602-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xOIP_jw-lGA-LRg15PsNuYjweBj2FGW0
X-Proofpoint-ORIG-GUID: x1gHyZUIa9cX9PfQmyT1usMaEnA2vfuY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160044
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit e3a9b1212b9d ("PCI: Export pci_dev_trylock() and pci_dev_unlock()")
already exported pci_dev_trylock()/pci_dev_unlock() however in some
circumstances such as during error recovery it makes sense to block
waiting to get full access to the device so also export pci_dev_lock().

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/pci.c   | 3 ++-
 include/linux/pci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce2ab62b64cf..6fe810fdb796 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5059,12 +5059,13 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 	return pci_parent_bus_reset(dev, probe);
 }
 
-static void pci_dev_lock(struct pci_dev *dev)
+void pci_dev_lock(struct pci_dev *dev)
 {
 	pci_cfg_access_lock(dev);
 	/* block PM suspend, driver probe, etc. */
 	device_lock(&dev->dev);
 }
+EXPORT_SYMBOL_GPL(pci_dev_lock);
 
 /* Return 1 on successful lock, 0 on contention */
 int pci_dev_trylock(struct pci_dev *dev)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cd8aa6fce204..c27c8fd1d30c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1671,6 +1671,7 @@ void pci_cfg_access_lock(struct pci_dev *dev);
 bool pci_cfg_access_trylock(struct pci_dev *dev);
 void pci_cfg_access_unlock(struct pci_dev *dev);
 
+void pci_dev_lock(struct pci_dev *dev);
 int pci_dev_trylock(struct pci_dev *dev);
 void pci_dev_unlock(struct pci_dev *dev);
 
-- 
2.25.1

