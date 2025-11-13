Return-Path: <linux-pci+bounces-41170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F91C5982E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A463B5903
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFBB314D07;
	Thu, 13 Nov 2025 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PFUW1+ab"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B87313E11;
	Thu, 13 Nov 2025 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763058926; cv=none; b=M8X/cwWCO5dVh7Mt1ErHNMkHznhr6cKGFtwq/OAafJPHYlVPwANBXgUDcnmzu2Vu12sNUDXz6Ax5y6s9GFQsHEWyqDHcUW29iuBeJtOQO6gZY956NelGcLNNzikve5x2pu1izLgCTrmCL9A7JiTOJgQ+Wg2/VEEWdP2TJHLTPuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763058926; c=relaxed/simple;
	bh=oRw8EkTcatCYrxahxAz4FniclD9q02pgqQGG9nDtEGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1ADhBD6T2AdYXG9gQKSuc2mvKhyE1Lx5sL4cMCtgVVp5cnJxRbAzCICzht4QS9ojS6kQsvcCYykMBxerkQzHHhO+an026/TRTroXER3n3m36iXFMeivhPb2Y/OuE8J3tox6OKlDOzenvEfsCgaScwaTUJpn3IMp4u/6dhcXgpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PFUW1+ab; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADFj1g4030450;
	Thu, 13 Nov 2025 18:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hbVNytTL4DYySQBQM
	3O9d0pQopaTTyISrgICBddsMZ0=; b=PFUW1+abNv5v62cUAh4qSenvhPs94gAQK
	Xzp+iIVNJB99jje+Ykpgxe0JedFhfs3iyjLXUp3aXuMr9vk2QD2RlnTHEeVHVqZJ
	aAPw8a8BAFbDyaaVBkydp1AOCP3wHvbCSGNVOQA0Y6JpmF6LjWWJBbF5ayOoShqm
	aOHOqB4S7ft2kKNb7aB3hkzivJ02eJ/MG3iUAYIJlmoRVNK3cc0+d8jj5fkQ+Gob
	QUU0kjX64PapzPoNcSZVRdm18S/7Cdc+KQ4CmEPa78rrcmoPSwcDLETcRmfD1HpR
	p7FWNQBW54DHOShFpSYu2qcQ0i+JWpJtcLIGWtslpN/Im/34bUmTQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgx7x47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 18:35:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADGKJPs011428;
	Thu, 13 Nov 2025 18:35:09 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw1q3w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 18:35:09 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADIZ8Qe21037820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 18:35:09 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9185E5805F;
	Thu, 13 Nov 2025 18:35:08 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4949558043;
	Thu, 13 Nov 2025 18:35:07 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.243.9])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 18:35:07 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
Subject: [PATCH v5 2/9] s390/pci: Add architecture specific resource/bus address translation
Date: Thu, 13 Nov 2025 10:34:55 -0800
Message-ID: <20251113183502.2388-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113183502.2388-1-alifm@linux.ibm.com>
References: <20251113183502.2388-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fyEVcZ-J_wJD_pKZFESKcnnP2BVroP96
X-Proofpoint-ORIG-GUID: fyEVcZ-J_wJD_pKZFESKcnnP2BVroP96
X-Authority-Analysis: v=2.4 cv=VMPQXtPX c=1 sm=1 tr=0 ts=691624de cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=WI2LcE4NPZyv2LzpnzYA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX91Fc94dcLGx5
 q6ABjy93Pgmcx054a0VPhtOUMNx2UpjBODmqEUmpHNzT1Fcs3PkghO+XrPbE8FKcbwPPsYowiXX
 oQUK2mVBZQlmTnd4P9i+r7kVZlIR3RuBWFymIfqE7NnclcYuwYjQHVwXRz+3cPdkQdoCXONB6uY
 IG+P5FuRALbMyNrAcWoU0zcxemFs9Pnen/aAWS7i+Lf+0vbIuIamvBBo/XBgtmk/aq899vnluPh
 owt5KS38tNqcuz7EK1Oj2jtqKs7ypnEzOjQnSU3kJSNasAOKbeRuNx2uV68swRdqcsGfK3UpeMA
 KSyZ3Z9tsI4fbph0rrAMjXSab7BNTwqnrHAFjxT+4xudrNzJiQKnG4+Nt0PIEbFVb5pNgwQrLix
 /ON5AQx1d/t2cDNsQv21YiymvtQ2gg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_03,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

On s390 today we overwrite the PCI BAR resource address to either an
artificial cookie address or MIO address. However this address is different
from the bus address of the BARs programmed by firmware. The artificial
cookie address was created to index into an array of function handles
(zpci_iomap_start). The MIO (mapped I/O) addresses are provided by firmware
but maybe different from the bus addresses. This creates an issue when trying
to convert the BAR resource address to bus address using the generic
pcibios_resource_to_bus().

Implement an architecture specific pcibios_resource_to_bus() function to
correctly translate PCI BAR resource addresses to bus addresses for s390.
Similarly add architecture specific pcibios_bus_to_resource function to do
the reverse translation.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/pci/pci.c       | 74 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/host-bridge.c |  4 +--
 2 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index c82c577db2bc..cacad02b2b7f 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -264,6 +264,80 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	return 0;
 }
 
+void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
+			     struct resource *res)
+{
+	struct zpci_bus *zbus = bus->sysdata;
+	struct zpci_bar_struct *zbar;
+	struct zpci_dev *zdev;
+
+	region->start = res->start;
+	region->end = res->end;
+
+	for (int i = 0; i < ZPCI_FUNCTIONS_PER_BUS; i++) {
+		int j = 0;
+
+		zbar = NULL;
+		zdev = zbus->function[i];
+		if (!zdev)
+			continue;
+
+		for (j = 0; j < PCI_STD_NUM_BARS; j++) {
+			if (zdev->bars[j].res->start == res->start &&
+			    zdev->bars[j].res->end == res->end &&
+			    res->flags & IORESOURCE_MEM) {
+				zbar = &zdev->bars[j];
+				break;
+			}
+		}
+
+		if (zbar) {
+			/* only MMIO is supported */
+			region->start = zbar->val & PCI_BASE_ADDRESS_MEM_MASK;
+			if (zbar->val & PCI_BASE_ADDRESS_MEM_TYPE_64)
+				region->start |= (u64)zdev->bars[j + 1].val << 32;
+
+			region->end = region->start + (1UL << zbar->size) - 1;
+			return;
+		}
+	}
+}
+
+void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
+			     struct pci_bus_region *region)
+{
+	struct zpci_bus *zbus = bus->sysdata;
+	struct zpci_dev *zdev;
+	resource_size_t start, end;
+
+	res->start = region->start;
+	res->end = region->end;
+
+	for (int i = 0; i < ZPCI_FUNCTIONS_PER_BUS; i++) {
+		zdev = zbus->function[i];
+		if (!zdev || !zdev->has_resources)
+			continue;
+
+		for (int j = 0; j < PCI_STD_NUM_BARS; j++) {
+			if (!zdev->bars[j].size)
+				continue;
+
+			/* only MMIO is supported */
+			start = zdev->bars[j].val & PCI_BASE_ADDRESS_MEM_MASK;
+			if (zdev->bars[j].val & PCI_BASE_ADDRESS_MEM_TYPE_64)
+				start |= (u64)zdev->bars[j + 1].val << 32;
+
+			end = start + (1UL << zdev->bars[j].size) - 1;
+
+			if (start == region->start && end == region->end) {
+				res->start = zdev->bars[j].res->start;
+				res->end = zdev->bars[j].res->end;
+				return;
+			}
+		}
+	}
+}
+
 void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 			   pgprot_t prot)
 {
diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index afa50b446567..56d62afb3afe 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -48,7 +48,7 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 }
 EXPORT_SYMBOL_GPL(pci_set_host_bridge_release);
 
-void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
+void __weak pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
 			     struct resource *res)
 {
 	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
@@ -73,7 +73,7 @@ static bool region_contains(struct pci_bus_region *region1,
 	return region1->start <= region2->start && region1->end >= region2->end;
 }
 
-void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
+void __weak pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
 			     struct pci_bus_region *region)
 {
 	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
-- 
2.43.0


