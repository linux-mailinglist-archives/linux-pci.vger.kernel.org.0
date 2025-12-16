Return-Path: <linux-pci+bounces-43143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 125C5CC48A1
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 18:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D2333023EB0
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 17:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43C6328629;
	Tue, 16 Dec 2025 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L9vkzCij"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF91B2C21DD;
	Tue, 16 Dec 2025 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904695; cv=none; b=YjSg7zDMdsVxETAPJcs0RUQ5Y5wltLvm5WHp7qtGp7YcyEphP5yfB4WpPTSifj9lnOCrfkAVgiQKE19LdhoBJtqdbfq+QloFKWQ6tm6e/wIQDJyDKp1ji11cETjTzonjNX8JDLDtB+T86bwnihRsBbOm2PKyc0f3IovBNOQfv6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904695; c=relaxed/simple;
	bh=gCHp0jTfQEdBWNMjar6RJS2kXC3jTCjg3lpri144j6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AMNUz7NxVT++0NOHp60WHWLnRExj//IhDNF0QxTN9DagMm8hVQyjE9LmTwA91QtxcsSb5QpdMJuzwCGPZ9IYWmuRbsPKK4eq92KylZVoWQu7UZQpF/vW1VA8lDyahYLLYtcxDmv2rY+pNWHtzB1hizN2HSfufZeBy9+pB5Yyjtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L9vkzCij; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGAJWIE012044;
	Tue, 16 Dec 2025 17:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1+9JAh
	1r3rQcS4F4RDLvRmgLg6uu5EqiYyCPx9mkBIU=; b=L9vkzCijdWJsi/0HUsRvKo
	tpxNr80Du6u4iZd14WyCjYGwZap0s4GZbShSdtm1red+QaRBTOL35MWbNYn42CuD
	1ktuIJvtYFFDT82fU5gaDxpQVnwZYye6YWudZQbRn7z7N0U4XtM0Q68xXgjXVmrg
	xg6p4ZXgqlzKloSHUvDlwbi0rgDPOnIO8OphluZ+zFuDf7lkmruxlsdI0cTwRjPw
	PdSXdxDkLbPxTgImmzcnYMHcUvOHRl/aQTSy/SJi445KRmz5mltvGRySH0OhTdRH
	iP9M9fXXoFeDPfI2yra3zp0fVldFVfBMkeo+hIeLjZeiuPaEmH/NVaX+bX10F4Zg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0wjq02y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 17:04:48 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGGjIrh006320;
	Tue, 16 Dec 2025 17:04:48 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0wjq02y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 17:04:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGFXYK1026786;
	Tue, 16 Dec 2025 17:04:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1jfsdtab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 17:04:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BGH4h7Y43581746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 17:04:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1FA120040;
	Tue, 16 Dec 2025 17:04:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C4272004D;
	Tue, 16 Dec 2025 17:04:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Dec 2025 17:04:43 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Tue, 16 Dec 2025 18:04:42 +0100
Subject: [PATCH v2 1/2] PCI: AtomicOps: Define valid root port capabilities
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-fix_pciatops-v2-1-d013e9b7e2ee@linux.ibm.com>
References: <20251216-fix_pciatops-v2-0-d013e9b7e2ee@linux.ibm.com>
In-Reply-To: <20251216-fix_pciatops-v2-0-d013e9b7e2ee@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jay Cornwall <Jay.Cornwall@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Alexander Schmidt <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gerd Bayer <gbayer@linux.ibm.com>, Leon Romanovsky <leon@kernel.org>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwMSBTYWx0ZWRfX1px1MSWgyMav
 nITTAW9pCiGaebfZyXa8jSDmasH+tEHPsBhFYDj2iwlRij53yvn9BgA07+yE0s4ni5if1jjIEzw
 XxgwLyGQ12sZ/cH5RSoac76xSO6aYs6cXaeJ0FZGpwq0kW7ac0+Lj3D+X35ldR5Plr1X98rl+Tz
 mDjghx9whuTDAftqr4hPidNAUn7lLBfkW+cFf0Bhp4+fQE0ey6X05paJHTATZDoyAc7BWUz4cJs
 UhKO4nuvTYhx0jbO6xnHNFiZDA3x2Ih2peHrWe0/cBQnMnRMNoZT3aBVmbqwUzWcxOD+WNuItQ+
 YJuvBYQyrwccrrY9mo5El870ewukFEuE21JNSFEwUyyqCRAa4PWomspqeuTdQKvwJNnm4KeLur5
 1z5JyhY+AoTyDSoQynzpkVDk5+H9GQ==
X-Proofpoint-GUID: SPRw0oCoki-lCv9OchZmtUf4GfT4qr0h
X-Proofpoint-ORIG-GUID: E39EOfgEmE-bMG2ENPsvqJ4p72mqzusm
X-Authority-Analysis: v=2.4 cv=Kq5AGGWN c=1 sm=1 tr=0 ts=69419130 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=8GgRulezAQhDBDp5LV8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130001

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
index 13dbb405dc31f8054afa090a2d14acf16845f587..d2261ac964316f3fc3efc4d5b30cf821ac46d75d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3661,15 +3661,16 @@ void pci_acs_init(struct pci_dev *dev)
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
index 3add74ae259483bab76e7552cb28bd9c9ef0b30c..e4d91c379416841fcf2090043b2b4784d69538a0 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -664,6 +664,14 @@
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
2.51.0


