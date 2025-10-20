Return-Path: <linux-pci+bounces-38799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40197BF316B
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 21:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D68384EC96F
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 19:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CAA2C3745;
	Mon, 20 Oct 2025 19:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oFU0rGqJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94750261B9E;
	Mon, 20 Oct 2025 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986933; cv=none; b=PC7oXVvSmHltsyHDtB8grVeKjmzgIfjhlgtg4tlyNBU5KlFfV622Xatvc//5tjvxP98i4KAe0KGxdbnla5OUYua7x1s7CcsKu0oBpLJLVYQ76yCOAr/hW2SsskA+VxVdN3lfarVMFr+p/8lliS+vbjHPTtaJFbZQgdn+XnUIXJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986933; c=relaxed/simple;
	bh=BTaf2JeikokcnZN/DcMJvPwDGGebUQjBL9CjUvtWROY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+VOdOqwv7Yv8w6RzsynQqvv4uieOm9VP0YzMspxhZ0CbLcViXsymHRYYSCtblbECijm0AVOubR8JlBHbjuWe7Y/q+PpGVxYaHoNraQpu2e8C86EqXutIYs4gI0m8Rod66Y1o9jDS+8heaOp32UcCehzX3i0slKY5qzgEHLe2fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oFU0rGqJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KGYVTs027635;
	Mon, 20 Oct 2025 19:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EnCSOFCChDHKwtLNy
	shGpOKoUJ0zJMwgZ3OIo6E5RHk=; b=oFU0rGqJ9aHpYCPFLvxuNCwvSG5xRvmUM
	NprsChdCwajWMZNjMXOytw1kGQDzL5EWLFAZAG9TAx2AyEqwORWweIkErXryk/wh
	/x23GswmGK1ONB5ji0BU1a5BBfe8gAJ3ULVbqImE++csghNNdL8qCyrELYA83Gej
	SOBKqECtrVQojBsTv47UsssxyN/CGyXfiyibzHpAV66ClWernl68nq1jqBalf/qN
	kpRVe1J4qSzR1X2Y9Y1Jjed1dmP09Ui4IROSxnYzFPSyfvt0M/11sJPR8EPOhWXP
	XE/ZifPGGSEDmmT69Zmgk4xGvNw/dz2ZjhSo7WSRhspqqh7LSYGmQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33f36gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 19:02:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KIbsn7024677;
	Mon, 20 Oct 2025 19:02:07 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqjq4jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 19:02:07 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59KJ263x7209564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 19:02:06 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29A5858060;
	Mon, 20 Oct 2025 19:02:06 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80EA858068;
	Mon, 20 Oct 2025 19:02:05 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.240.93])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Oct 2025 19:02:05 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, stable@vger.kernel.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v1 2/3] s390/pci: Add architecture specific resource/bus address translation
Date: Mon, 20 Oct 2025 12:01:59 -0700
Message-ID: <20251020190200.1365-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020190200.1365-1-alifm@linux.ibm.com>
References: <20251020190200.1365-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68f68730 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=yYx7OUe3D3zVL1aRsq0A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 3d5M2-QNCCegtw7o-pFeuM4h8SOyvYl9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX/qVGm0fpqf7j
 A/bi3XRz6dcWrCyZu2DGvUbH4ok5wKQRF27rKgL6nO+WtAxAwwd1IijZ5dWiHkbzzfAcsSBsrw2
 Chj0g4FA2J0r+/cEKBQSgxaUAttRjhMPqLHi3LBEwbVZKwS610+o5dUY/7McQKbLeBFPle3IPxw
 YO4dNfWGICIkc/mzYdmutLSDpZB0+WPLK2j3DPWAUMUGoUWjRcxUZ3N2rzzAkNFEFuj+rbiJq/G
 46F4aVpKVO9a8n4AeDVikItvhvDvp84DhE2YNP+WtEt2Q2XrlC09eVjof/KdTc6UYjwesXT1D+Q
 kzaFkL3yGAOO2OJ7cK3xJTj2ABunEZZKHrpLJ/ro8bKy8aCDzMXjdvQvEvEINcNfz5O+lYgROUI
 LsZcuTra6D9ny72iPTPHRRPxHtxvVw==
X-Proofpoint-ORIG-GUID: 3d5M2-QNCCegtw7o-pFeuM4h8SOyvYl9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On s390 today we overwrite the PCI BAR resource address to either an
artificial cookie address or MIO address. However this address is different
from the bus address of the BARs programmed by firmware. The artificial
cookie address was created to index into an array of function handles
(zpci_iomap_start). The MIO (mapped I/O) addresses are provided by firmware
but maybe different from the bus address. This creates an issue when trying
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


