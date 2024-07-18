Return-Path: <linux-pci+bounces-10480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D6B934776
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 07:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B517328235A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 05:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98733D552;
	Thu, 18 Jul 2024 05:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iItnTtp2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0189F4AEE6;
	Thu, 18 Jul 2024 05:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721279844; cv=none; b=H9E1lx7sdElZcHn05ut5clJF/hvSQre0BZy9sFe+Tdbj9Tu6kgQZImCiannctw38N/h6Lot+paTr2/2k4HctmmxP+Xxf0kVgY9Nz2wZbeRGdh4ujwfAv+jkK2kXzB9nQDu7aQ6WkiHbp6eNHpkEL18OgVqSuZg8qLqJi6b6d8cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721279844; c=relaxed/simple;
	bh=oYCQOhzW5lrg1j5fh4CoNyAocZaJm6UppHekj7otYKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0kiaDDMOdOf1LdwTeb0WR5L/GHR5aYiaN9q0OxgI8eCaMD2vlkx8m/YLBHiQLukkfLZwYDK6cDcgH1jrMg0TkoQ8yEwu3N7fN83YvJsu7p9PFNkxwFHvhDrafnew9mvoXgNJL+ViY+axY+Uq8m+SdclsiwNqX7AU8RRvCcUg04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iItnTtp2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I4GVxH025075;
	Thu, 18 Jul 2024 05:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	96ItovL8caGcz9Vnh4q68hd9rf2sIPQWf77PDCssXcY=; b=iItnTtp2iGWPsIni
	CezQTYZLomOoJvPgy4CGRGqJWKij06GwkHXPqrdES6YT5hFMZBdBzC1kSmXRUcv4
	ATo6gH/B01/RGi4OB3LogJsrfAhDjG70DWQPgxiQKVY8XpzaGncYNRYJUOc2Dq9Z
	IwLQalimiwcUWfQePkJpB/F+hXlR8Q8gHvCwGJ977xv0BETsFy1lhVKwTWXpKVbS
	pa9bH3jrqIWiDHRtu0+OFxOea03JCoAxBnyErqivd/T4+UQ3OuELCsxtZw9T+vXn
	5dOhYEr5GyR8F2bCdGn03hrivYplSwH3rKu4ZkOlIiSDGUSotNLYbuSXGAAaqnBP
	9wiq7Q==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfpmdr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 05:14:10 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46I5E8aO002719
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 05:14:09 GMT
Received: from hu-pyarlaga-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Jul 2024 22:14:08 -0700
From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
To: <jingoohan1@gmail.com>, <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_mrana@quicinc.com>,
        <quic_pyarlaga@quicinc.com>
Subject: [PATCH v2 2/2] PCI: qcom: Avoid DBI and ATU register space mirror to BAR/MMIO region
Date: Wed, 17 Jul 2024 22:12:58 -0700
Message-ID: <20240718051258.1115271-3-quic_pyarlaga@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240718051258.1115271-1-quic_pyarlaga@quicinc.com>
References: <20240718051258.1115271-1-quic_pyarlaga@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Anxp24JbzfT8tXhvzINdCnQBdNN3hML5
X-Proofpoint-GUID: Anxp24JbzfT8tXhvzINdCnQBdNN3hML5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_02,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407180034

PARF hardware block which is a wrapper on top of DWC PCIe controller
mirrors the DBI and ATU register space. It uses PARF_SLV_ADDR_SPACE_SIZE
register to get the size of the memory block to be mirrored and uses
PARF_DBI_BASE_ADDR, PARF_ATU_BASE_ADDR registers to determine the base
address of DBI and ATU space inside the memory block that is being
mirrored.

When a memory region which is located above the SLV_ADDR_SPACE_SIZE
boundary is used for BAR region then there could be an overlap of DBI and
ATU address space that is getting mirrored and the BAR region. This
results in DBI and ATU address space contents getting updated when a PCIe
function driver tries updating the BAR/MMIO memory region. Reference
memory map of the PCIe memory region with DBI and ATU address space
overlapping BAR region is as below.

                        |---------------|
                        |               |
                        |               |
        ------- --------|---------------|
           |       |    |---------------|
           |       |    |       DBI     |
           |       |    |---------------|---->DBI_BASE_ADDR
           |       |    |               |
           |       |    |               |
           |    PCIe    |               |---->2*SLV_ADDR_SPACE_SIZE
           |    BAR/MMIO|---------------|
           |    Region  |       ATU     |
           |       |    |---------------|---->ATU_BASE_ADDR
           |       |    |               |
        PCIe       |    |---------------|
        Memory     |    |       DBI     |
        Region     |    |---------------|---->DBI_BASE_ADDR
           |       |    |               |
           |    --------|               |
           |            |               |---->SLV_ADDR_SPACE_SIZE
           |            |---------------|
           |            |       ATU     |
           |            |---------------|---->ATU_BASE_ADDR
           |            |               |
           |            |---------------|
           |            |       DBI     |
           |            |---------------|---->DBI_BASE_ADDR
           |            |               |
           |            |               |
        ----------------|---------------|
                        |               |
                        |               |
                        |               |
                        |---------------|

Currently memory region beyond the SLV_ADDR_SPACE_SIZE boundary is not
used for BAR region which is why the above mentioned issue is not
encountered. This issue is discovered as part of internal testing when we
tried moving the BAR region beyond the SLV_ADDR_SPACE_SIZE boundary. Hence
we are trying to fix this.

As PARF hardware block mirrors DBI and ATU register space after every
PARF_SLV_ADDR_SPACE_SIZE (default 0x1000000) boundary multiple, write
U32_MAX (all 0xFF's) to PARF_SLV_ADDR_SPACE_SIZE register to avoid
mirroring DBI and ATU to BAR/MMIO region. Write the physical base address
of DBI and ATU register blocks to PARF_DBI_BASE_ADDR (default 0x0) and
PARF_ATU_BASE_ADDR (default 0x1000) respectively to make sure DBI and ATU
blocks are at expected memory locations.

The register offsets PARF_DBI_BASE_ADDR_V2, PARF_SLV_ADDR_SPACE_SIZE_V2
and PARF_ATU_BASE_ADDR are applicable for platforms that use PARF
Qcom IP rev 1.9.0, 2.7.0 and 2.9.0. PARF_DBI_BASE_ADDR_V2 and
PARF_SLV_ADDR_SPACE_SIZE_V2 are applicable for PARF Qcom IP rev 2.3.3.
PARF_DBI_BASE_ADDR and PARF_SLV_ADDR_SPACE_SIZE are applicable for PARF
Qcom IP rev 1.0.0, 2.3.2 and 2.4.0. Updating the init()/post_init()
functions of the respective PARF versions to program applicable
PARF_DBI_BASE_ADDR, PARF_SLV_ADDR_SPACE_SIZE and PARF_ATU_BASE_ADDR
register offsets. And remove the unused SLV_ADDR_SPACE_SZ macro.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 62 +++++++++++++++++++-------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 0180edf3310e..845c7641431f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -45,6 +45,7 @@
 #define PARF_PHY_REFCLK				0x4c
 #define PARF_CONFIG_BITS			0x50
 #define PARF_DBI_BASE_ADDR			0x168
+#define PARF_SLV_ADDR_SPACE_SIZE		0x16C
 #define PARF_MHI_CLOCK_RESET_CTRL		0x174
 #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
 #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
@@ -52,8 +53,13 @@
 #define PARF_LTSSM				0x1b0
 #define PARF_SID_OFFSET				0x234
 #define PARF_BDF_TRANSLATE_CFG			0x24c
-#define PARF_SLV_ADDR_SPACE_SIZE		0x358
+#define PARF_DBI_BASE_ADDR_V2			0x350
+#define PARF_DBI_BASE_ADDR_V2_HI		0x354
+#define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
+#define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35C
 #define PARF_NO_SNOOP_OVERIDE			0x3d4
+#define PARF_ATU_BASE_ADDR			0x634
+#define PARF_ATU_BASE_ADDR_HI			0x638
 #define PARF_DEVICE_TYPE			0x1000
 #define PARF_BDF_TO_SID_TABLE_N			0x2000
 #define PARF_BDF_TO_SID_CFG			0x2c00
@@ -107,9 +113,6 @@
 /* PARF_CONFIG_BITS register fields */
 #define PHY_RX0_EQ(x)				FIELD_PREP(GENMASK(26, 24), x)
 
-/* PARF_SLV_ADDR_SPACE_SIZE register value */
-#define SLV_ADDR_SPACE_SZ			0x10000000
-
 /* PARF_MHI_CLOCK_RESET_CTRL register fields */
 #define AHB_CLK_EN				BIT(0)
 #define MSTR_AXI_CLK_EN				BIT(1)
@@ -324,6 +327,39 @@ static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
 	dw_pcie_dbi_ro_wr_dis(pci);
 }
 
+static void qcom_pcie_configure_dbi_base(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+
+	if (pci->dbi_phys_addr)
+		writel(lower_32_bits(pci->dbi_phys_addr), pcie->parf +
+							PARF_DBI_BASE_ADDR);
+
+	writel(U32_MAX, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
+}
+
+static void qcom_pcie_configure_dbi_atu_base(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+
+	if (pci->dbi_phys_addr) {
+		writel(lower_32_bits(pci->dbi_phys_addr), pcie->parf +
+							PARF_DBI_BASE_ADDR_V2);
+		writel(upper_32_bits(pci->dbi_phys_addr), pcie->parf +
+						PARF_DBI_BASE_ADDR_V2_HI);
+	}
+
+	if (pci->atu_phys_addr) {
+		writel(lower_32_bits(pci->atu_phys_addr), pcie->parf +
+							PARF_ATU_BASE_ADDR);
+		writel(upper_32_bits(pci->atu_phys_addr), pcie->parf +
+							PARF_ATU_BASE_ADDR_HI);
+	}
+
+	writel(U32_MAX, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_V2);
+	writel(U32_MAX, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_V2_HI);
+}
+
 static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
 {
 	u32 val;
@@ -540,8 +576,7 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
 
 static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 {
-	/* change DBI base address */
-	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
+	qcom_pcie_configure_dbi_base(pcie);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		u32 val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
@@ -628,8 +663,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
-	/* change DBI base address */
-	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
+	qcom_pcie_configure_dbi_base(pcie);
 
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
 	val = readl(pcie->parf + PARF_SYS_CTRL);
@@ -811,13 +845,11 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
 
-	writel(SLV_ADDR_SPACE_SZ, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
-
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
-	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
+	qcom_pcie_configure_dbi_atu_base(pcie);
 
 	writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS
 		| SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
@@ -913,8 +945,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
-	/* change DBI base address */
-	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
+	qcom_pcie_configure_dbi_atu_base(pcie);
 
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
 	val = readl(pcie->parf + PARF_SYS_CTRL);
@@ -1123,14 +1154,11 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 	u32 val;
 	int i;
 
-	writel(SLV_ADDR_SPACE_SZ,
-		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
-
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
-	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
+	qcom_pcie_configure_dbi_atu_base(pcie);
 
 	writel(DEVICE_TYPE_RC, pcie->parf + PARF_DEVICE_TYPE);
 	writel(BYPASS | MSTR_AXI_CLK_EN | AHB_CLK_EN,
-- 
2.25.1


