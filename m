Return-Path: <linux-pci+bounces-43142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0380CCC498E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 18:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF6ED3072E21
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 17:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9F2325727;
	Tue, 16 Dec 2025 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eFO4iROr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEE2314D2C;
	Tue, 16 Dec 2025 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904695; cv=none; b=s+u7GZJYp7hP5vnHkKiT1gvw3Ho7kd6XvrpLvGxLgNIDcy8SCgbC60FdJWa9H8xYR7HQsRKhERxHcXWHegEIGF4pQPjf1R0wnNhiE4+/PM6Dx8/wYr3cr2vnaotse90PxnYfovfsxk3KLMQB0vG0Njx2+Pkv41OkBKpjd918YH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904695; c=relaxed/simple;
	bh=TNCEN9La+c9VAV7oXpPjJraBV3JMiSg1tGrqqcuXm5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AQ+U28iUjvZtsNmOfWr6LNcMO7EQZAFauuAWnI/LdGGWs+cq1m9cA7uHD6QkF1zghzidm5AAinS1U6aG/Nu7uvDrKUYDGsl3+owLTc/QALxDu+iK5LdfU0KwJo9sN1bcVE37Br4Cz/v/fvM7nKDEJqU4Q7Cv7aS1/KHDcvmoAAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eFO4iROr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BG7ufU3012702;
	Tue, 16 Dec 2025 17:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fURsAN
	FeKHQry+xcqzO1VzzWnCROACP8eg6bRsOwbYc=; b=eFO4iROrgGwrshhJm0y7Vs
	L2ux9CgztUD6XN37voH2D4igIYswSVjTeb226jne6qpRfDPGe96vfd8X3hMDPjYB
	2vhOBNS86oAx+ueasv0zlHtB1KtOnx11KekdOG9iDUToQuY80KNQwe63/BcmUzvy
	Ig0oLsw5jA+mXZCFSYS71U9wZunbOhPwV2VuLs3VM2SfY2j7fFo21PYVNEaaBgeC
	RNPaBfRunXCF8WMMIJ/s8l3kcxKptKyLm/aLczMlOq6ofEp65X9wA2BQclFTh9rP
	2YyS0W8JOxerpKcpqXerY16OJkdrc2V0ybBHb4NvxRWnZCu5Pwa8gqc9UK2EpItA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjkytsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 17:04:48 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGH4mra029655;
	Tue, 16 Dec 2025 17:04:48 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjkytsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 17:04:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGFr17M026803;
	Tue, 16 Dec 2025 17:04:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1jfsdtae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 17:04:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BGH4hVO43450674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 17:04:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD00B20040;
	Tue, 16 Dec 2025 17:04:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A66042004E;
	Tue, 16 Dec 2025 17:04:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Dec 2025 17:04:43 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Tue, 16 Dec 2025 18:04:43 +0100
Subject: [PATCH v2 2/2] PCI: AtomicOps: Fix logic in enable function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-fix_pciatops-v2-2-d013e9b7e2ee@linux.ibm.com>
References: <20251216-fix_pciatops-v2-0-d013e9b7e2ee@linux.ibm.com>
In-Reply-To: <20251216-fix_pciatops-v2-0-d013e9b7e2ee@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jay Cornwall <Jay.Cornwall@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Alexander Schmidt <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gerd Bayer <gbayer@linux.ibm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XIZgrjMmIy5IgMHp3x1QqXOEnpTQajSx
X-Authority-Analysis: v=2.4 cv=CLgnnBrD c=1 sm=1 tr=0 ts=69419130 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ud980_RLCRqylQVSWKAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: CO2Bokk8N1kGnRsN3C-TFQffGrqzY7pI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwOSBTYWx0ZWRfX7ya0nj8HlcZC
 +ZqvTPg1oFASz2bxIbspg1VqrYKXkdQ6Kglk1gIp9RcZecOqnpdYlSAtKrNZVzcLhO0gkVGyYzY
 SRU5YIc8eXGF8qjlg7VKb7IvG86J+/d6/9R/tH473AHxvj5W4E2dV3RwBAmNxh5L2L3X9egyWt7
 EP1CguCQn5DisIWlekuyE0NiNe39kI01K3/3AKVRprkQp2IyNkL9WXKvns8fqktInQRXVc4I+mP
 Mas8wp2Al0IkznwsoChTOvRxmJD9E7DVIQvYYz245GTQPa/gn5plFwQ/zNFhy/8gVQo1Fgiq5ul
 0WHXqiwkjZIQePPqbK0LL5ofw0gTIFG352JXNeVYQlFa3orhAJEsEaQuICOhqSa73gpbR+IiQyC
 E8uZR6LARlhRVea4qnDcl6Z1YYla3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130009

Move the check for root port requirements past the loop within
pci_enable_atomic_ops_to_root() that checks on potential switch
(up- and downstream) ports.

Inside the loop traversing the PCI tree upwards, prepend the switch case
to validate the routing capability on any port with a fallthrough-case
that does the additional check for Atomic Ops not being blocked on
upstream ports.

Do not enable Atomic Op Requests if nothing can be learned about how the
device is attached - e.g. if it is on an "isolated" bus, as in s390.

Reported-by: Alexander Schmidt <alexs@linux.ibm.com>
Cc: stable@vger.kernel.org
Fixes: 430a23689dea ("PCI: Add pci_enable_atomic_ops_to_root()")
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 drivers/pci/pci.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d2261ac964316f3fc3efc4d5b30cf821ac46d75d..5d25d42eece1bbaf16197068d7b6206937e9c3a0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3675,7 +3675,7 @@ void pci_acs_init(struct pci_dev *dev)
 int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 {
 	struct pci_bus *bus = dev->bus;
-	struct pci_dev *bridge;
+	struct pci_dev *bridge = NULL;
 	u32 cap, ctl2;
 
 	/*
@@ -3713,29 +3713,27 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 		switch (pci_pcie_type(bridge)) {
 		/* Ensure switch ports support AtomicOp routing */
 		case PCI_EXP_TYPE_UPSTREAM:
-		case PCI_EXP_TYPE_DOWNSTREAM:
-			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
-				return -EINVAL;
-			break;
-
-		/* Ensure root port supports all the sizes we care about */
-		case PCI_EXP_TYPE_ROOT_PORT:
-			if ((cap & cap_mask) != cap_mask)
-				return -EINVAL;
-			break;
-		}
-
-		/* Ensure upstream ports don't block AtomicOps on egress */
-		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_UPSTREAM) {
+			/* Upstream ports must not block AtomicOps on egress */
 			pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2,
 						   &ctl2);
 			if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK)
 				return -EINVAL;
+			fallthrough;
+		/* All switch ports need to route AtomicOps */
+		case PCI_EXP_TYPE_DOWNSTREAM:
+			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
+				return -EINVAL;
+			break;
 		}
-
 		bus = bus->parent;
 	}
 
+	/* Finally, last bridge must be root port and support requested sizes */
+	if ((!bridge) ||
+	    (pci_pcie_type(bridge) != PCI_EXP_TYPE_ROOT_PORT) ||
+	    ((cap & cap_mask) != cap_mask))
+		return -EINVAL;
+
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
 				 PCI_EXP_DEVCTL2_ATOMIC_REQ);
 	return 0;

-- 
2.51.0


