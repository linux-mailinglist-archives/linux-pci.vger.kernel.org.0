Return-Path: <linux-pci+bounces-40709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A138C46E31
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 14:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26253A7917
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 13:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E943115B8;
	Mon, 10 Nov 2025 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lB7I03t3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2F8310779;
	Mon, 10 Nov 2025 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781138; cv=none; b=L8kuyhaqzOsoeO+wyk1pSw7KxW3LHwXWNigR41XQLOUKevN5CXjiOwCBEg14EbN8IYA+LXmv76tAFL+Zpc9bEum79HhhS0EcEuOyoSbcJl0zdP2KsSsa+bNvh3jeDzz+/R2ctTrf0hW5fwR7pv3hGlxyWKO0b4j4PPyVzDuNvjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781138; c=relaxed/simple;
	bh=buCQpEO2NNmWTUOFyhFhZmBVaAUqa8QS4fFecvMK6ZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MFK7RB3g46jr/fA6OWjb/62AJQYuVt0lQtLGKe6N0U25cFILvHWDqRK5A2xomlS81PkSQb4dmbIl72ouWZ4yGUwBVP0k4AGGTvnJBonZkh7CoHyo563elpYNbPOUS8f2AWvl8CoRnTw6Z2ohJ1ZJQdA4/KI5FY7/VN21N6YSL50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lB7I03t3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A9Jt3PD015833;
	Mon, 10 Nov 2025 13:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1e6Cs4
	nDenanGEYowVzx/aUetXHV0nHaCcSJvLKIxgQ=; b=lB7I03t3IMMgVTGNiSltdW
	jgVPc4JDSTJXHiRkEwrEjcrgMvsnZl6kHIQ0T0qmb/lSgFKs4PIJl13l3csClvmk
	mowUztby4GWk7wQ7whhf3QqSTca8GjBPAHAACzMSwPNX/43Hcphs84V78C5U/SCs
	onGfu1AG/2XLUbodeenXzGy7L5GWFPDK4Kgsk9bKm5aq3UTsOwkHEKMu30xc/Mbf
	l9oti86ZaRTO6V1LtCcKbWYmExlTfgxAziUzVXwcj7olXj6BArxbf12gZeZFcbG1
	EVmSHXk1LH4K8qPgihbH12wcgYrL67HtkuqzEA3Xbsyywh+VevcUpEIVJMv9RI5w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m7xk13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 13:25:28 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AADJ6Fn004570;
	Mon, 10 Nov 2025 13:25:27 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m7xk0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 13:25:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAD5Rh1011600;
	Mon, 10 Nov 2025 13:25:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw15fnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 13:25:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AADPNK925166380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 13:25:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15F512004B;
	Mon, 10 Nov 2025 13:25:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4E9120043;
	Mon, 10 Nov 2025 13:25:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Nov 2025 13:25:22 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Mon, 10 Nov 2025 14:25:06 +0100
Subject: [PATCH 2/2] PCI: AtomicOps: Fix logic in enable function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-fix_pciatops-v1-2-edc58a57b62e@linux.ibm.com>
References: <20251110-fix_pciatops-v1-0-edc58a57b62e@linux.ibm.com>
In-Reply-To: <20251110-fix_pciatops-v1-0-edc58a57b62e@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jay Cornwall <Jay.Cornwall@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Alexander Schmidt <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gerd Bayer <gbayer@linux.ibm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MtZfKmae c=1 sm=1 tr=0 ts=6911e7c8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ud980_RLCRqylQVSWKAA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 5rk5i6UE4fy0sTbxzVXFbAhpWiKfgyqt
X-Proofpoint-ORIG-GUID: tzQ8cJIvoEU-h7xw_d8Qjuu2k8LU-t_c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3OSBTYWx0ZWRfX9MtzRoJieOPK
 0rkmm0DJoCWIpqpcu6gpaWwfutv/Bv/hv0zfCuD9lUbodiygx26R1jKlpcJPW9xK1cXItwbX/+7
 Hlb9yVp6zSZkdOOBsMEAIp9/3qcWIg1RuxXpakIKCdkv9XaCDsiIpt7c77eBj1OyWnQHn8X48vl
 VyXIDoOLtW1KYgu57qFO/sF6j99wNTqJtie048MYWzLstlaePy/+vOfgJxSGzGuYj1ftPqaLhhF
 q16i9rF2QnNTKEFqg+3QyhWGH8CO70nJejBff+MI9a+iQMgIZ86mnCYBBkVpAVEYv/LAAktY6Hd
 EP8gNTtiQ3Xq7yIRr5sRlTAcy03NU6z3pmhkngy80iywTcL5dQ1BKCuyaCs87zL3NfpDkaVM9wF
 TwuF9uhNqDWxWFVvdxR6EUtXwJsiWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080079

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
index 597bf419c3a6867f8df7ebdc14fc8ca47d0958a6..9a188fe8639d8a3d05e73e65114ce241d0f88bbf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3823,7 +3823,7 @@ int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size)
 int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 {
 	struct pci_bus *bus = dev->bus;
-	struct pci_dev *bridge;
+	struct pci_dev *bridge = NULL;
 	u32 cap, ctl2;
 
 	/*
@@ -3861,29 +3861,27 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
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
2.48.1


