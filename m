Return-Path: <linux-pci+bounces-40710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC6EC46E13
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 14:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CFE81891A7B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 13:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAB13126A2;
	Mon, 10 Nov 2025 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ks/VcF6e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652563115B0;
	Mon, 10 Nov 2025 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781140; cv=none; b=qT6DlyxTHwSHL6KaCgBuWvDCyFuxxi7TPXNd+uGlGurpyLJMOt5Sdg9gCh/lzDi4bFhVkK/oE69A7QBRWNiaICOpa+idjlvEFW1b+DY0TSxHP78p+xuYPugmQfY1YKsN31EDBqtvPpCAFOLO1qvWeDsU6qIgv2azjJblTaSmgxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781140; c=relaxed/simple;
	bh=jcAHCEUHT9yst86SBkzAojU5urnpIcVyy0d24XwustU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d+ovOokBxOc4PQUaO/hVNjmh+Uj40hy1HikCqWNxAUIz/LLmb4IUFDN2e+2c7fLl/RN5/cizkV9LsppXewrBjFqdXP73CJhgL4zRSK7y5oKH8MHoCIuUV2A1QdFNHH1x0FZtFQMqlpiXjT6cLYs/9IXjpJIsqVaD20k7Gu/8l8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ks/VcF6e; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAAVSZN031579;
	Mon, 10 Nov 2025 13:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/acSXP
	te+AuOKB+6uxLyjUxP88lsIVuVztPJbWyi/UI=; b=ks/VcF6evnrgzHEmLPyJe1
	CTCEkbQ6Qj8b5K3uqKbON6bkqjtCJIpAL1OlBfdeXpbi6+goN8obV5TaS1IHDatb
	6XkwbIFblct6irNOOE5f50gmIo2/TAxyae4PK2k5zM8byWqrNm1QCrs1KMzC3WWR
	8oQosTHmxozgBAYkOqNwkNT3a2F+KwKkf/ybBzUL/1RWXkrcps8uULaJVB/Y6Ra8
	KW2UmZnMaUebJ9jEO4jNofEnre0YFKvTNmmGBskt/0CVegw/XDtbFqJCywR2wqdQ
	yp1awd/3RIjs4WXoLkJRFCCO1PQYywY1xRKFES1NKAVo20UABtFWUXN8PfVpRLyg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m7xk11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 13:25:28 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AAD91Or012742;
	Mon, 10 Nov 2025 13:25:27 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m7xk0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 13:25:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAD57hk007368;
	Mon, 10 Nov 2025 13:25:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdj5hx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 13:25:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AADPMFx54395344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 13:25:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E016920040;
	Mon, 10 Nov 2025 13:25:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA9DC2004E;
	Mon, 10 Nov 2025 13:25:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Nov 2025 13:25:22 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Mon, 10 Nov 2025 14:25:05 +0100
Subject: [PATCH 1/2] PCI: AtomicOps: Define valid root port capabilities
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-fix_pciatops-v1-1-edc58a57b62e@linux.ibm.com>
References: <20251110-fix_pciatops-v1-0-edc58a57b62e@linux.ibm.com>
In-Reply-To: <20251110-fix_pciatops-v1-0-edc58a57b62e@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jay Cornwall <Jay.Cornwall@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Alexander Schmidt <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gerd Bayer <gbayer@linux.ibm.com>, Leon Romanovsky <leon@kernel.org>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MtZfKmae c=1 sm=1 tr=0 ts=6911e7c8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=8GgRulezAQhDBDp5LV8A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: UNJVx7QPg1d4KuVyWWtCLmBM82ySq0p-
X-Proofpoint-ORIG-GUID: wPOG6K1kOOqsIZdLhuiJaHG0Q-ZmrVVh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3OSBTYWx0ZWRfX3d3R/WWF0XMt
 07JS1WFKfDZdUh7ELJ3mv2WQx5FcFWfCBZFj//vu1EhZ+SdMljrRgAAg6Wh+jLuGFSneasF+Gl3
 BScSQcqbizs4s8shjs6ogDhEaG+312dDdxZzL9D4PAZ4HT2PC9hD6r2EazuHM2mNvtt8ySwW4CX
 k79xQPNefEdIbNm6P1gD5oXlG+aFpc1WFici3faRImNFI8dJYgQiRQFf6iQJHK2JNq1QXvOUIV/
 2mZh3mVZwKrCC6fjvF5xKUYUsQW58w+siHqCWr044h9XYMWVdDoorIp38G/w/a2gbVyhCEv7237
 R/QKxa2yIaOCjOHXVRVENdCFdXofLmsjNF59vGXfX6rQqXw1SP5740NiMxiDNLkhBXyU1ns8Ohi
 m48h/aRPRfUFKLZ5/snq59+nuaxLOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080079

Provide the two combinations of Atomic Op Completion size attributes
that a root port may support per PCIe Spec 7.0 section 6.15.3.1. -
besides the trivial "No support" - as two new defines.

Change documentation of pci_enable_atomic_ops_to_root() that these are
the only ones that should be used. Also, spell out that all requested
capabilities need to be supported at the root port for enable to
succeed. Also emphasize that on success, this sets AtomicOpsCtl:ReqEn to
1, and leaves it untouched in case of failure.

Suggested-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 drivers/pci/pci.c             | 13 +++++++------
 include/uapi/linux/pci_regs.h |  8 ++++++++
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006cca80ec5275e45a35d6dc2b4d0bbc..597bf419c3a6867f8df7ebdc14fc8ca47d0958a6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3809,15 +3809,16 @@ int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size)
 /**
  * pci_enable_atomic_ops_to_root - enable AtomicOp requests to root port
  * @dev: the PCI device
- * @cap_mask: mask of desired AtomicOp sizes, including one or more of:
- *	PCI_EXP_DEVCAP2_ATOMIC_COMP32
- *	PCI_EXP_DEVCAP2_ATOMIC_COMP64
- *	PCI_EXP_DEVCAP2_ATOMIC_COMP128
+ * @cap_mask: root port must support combinations of AtomicOp sizes
+ *	PCI_EXP_ROOT_PORT_ATOMIC_BASE
+ *	PCI_EXP_ROOT_PORT_ATOMIC_FULL
  *
  * Return 0 if all upstream bridges support AtomicOp routing, egress
  * blocking is disabled on all upstream ports, and the root port supports
- * the requested completion capabilities (32-bit, 64-bit and/or 128-bit
- * AtomicOp completion), or negative otherwise.
+ * all the requested completion capabilities (BASE: 32-bit, 64-bit or
+ * FULL: 32/64- and 128-bit AtomicOp completion). In that case enable the
+ * device to send AtomicOp requests. Otherwise, return negative and leave
+ * the enablement in the PCI config space untouched.
  */
 int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 {
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 07e06aafec502af7c12379f7207e2e3321dc2ff1..0435306b4d26dc4caf27ae0391a5e6b930538213 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -663,6 +663,14 @@
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP32	0x00000080 /* 32b AtomicOp completion */
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP64	0x00000100 /* 64b AtomicOp completion */
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP128	0x00000200 /* 128b AtomicOp completion */
+/* PCIe spec 7.0 6.15.3.1: Root ports may support one of 2 sets of Atomic Ops */
+#define  PCI_EXP_ROOT_PORT_ATOMIC_BASE		\
+	(PCI_EXP_DEVCAP2_ATOMIC_COMP32 |	\
+	 PCI_EXP_DEVCAP2_ATOMIC_COMP64)
+#define  PCI_EXP_ROOT_PORT_ATOMIC_FULL		\
+	(PCI_EXP_DEVCAP2_ATOMIC_COMP32 |	\
+	 PCI_EXP_DEVCAP2_ATOMIC_COMP64 |	\
+	 PCI_EXP_DEVCAP2_ATOMIC_COMP128)
 #define  PCI_EXP_DEVCAP2_LTR		0x00000800 /* Latency tolerance reporting */
 #define  PCI_EXP_DEVCAP2_TPH_COMP_MASK	0x00003000 /* TPH completer support */
 #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */

-- 
2.48.1


