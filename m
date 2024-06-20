Return-Path: <linux-pci+bounces-9048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC1E9114BC
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 23:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E026DB21BE4
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 21:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175E680605;
	Thu, 20 Jun 2024 21:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S7vT9rEL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4098359148;
	Thu, 20 Jun 2024 21:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718919306; cv=none; b=mOmUnxvT2uqwrzePnfurIGZQvqZswlEeUavGR521nP1ms1j285UtOP6itEJMh8WGeoDvTXDfs/iVvoyxPqoM+E8mUW1Y+XAZHcggaqqVlsGa8NnlquP4Jyc71oxSvDJKZRrIsYfnOmoWBpWj6iJJmaooX3QR5c2snNP5Vk98vMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718919306; c=relaxed/simple;
	bh=wV8DPUsvJJy4ipiR/a39yp0SRLvuUXFnS8PXhyAKPzc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GgHA+mgVs7/2dJZDQwdnBddsHGlUZdI04EwHGHFoCZ4wRJuDA2GgtPpf0Yr38TnCIZEx2m9AiFSFdN+jCYy6s6lDpTdYPhiIV5fHgQoRnOI5MTZ33kmMIGhMltrCt4DGYk9RhCfoCLifsZcI6cGrSdg7RDuhbzwkrMXPIhDNtrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S7vT9rEL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KHBIZN013832;
	Thu, 20 Jun 2024 21:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lYZgA/xYEppuXbwtnRcWGD
	1eT/ICtCS6C6TjlTrL6BQ=; b=S7vT9rELcGexiPInx3gvqO5FB/+jkb/MTxk76M
	ekr1aWUm4p9S37BSVedSU0soka1lEc9wVC1onKxmBzVEB21OuQokCpznbTpL7CoT
	u89tgtzHUp8FOY6AgXCQ0qLYtQxs5+JlPgBsM5hWQiKo/MQrLjWeDJqX9ZLX1Ft6
	S67n/8DAC1rUq6dkIR9Eb3QlcPQgoxD41PgX1EGaCtaCTGQ/N4t9jZ926CdCan/9
	Mfn1Y/OUlySTi1IM0QYCjEwwq076yHAEgy9J36gwnAOTYeCSefnH11ArO4l27FUS
	Ic5mca1AHAARtIfjDFyXADBREBVwvTC07c5wY32vTyg0EhwA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvrkkgq5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 21:34:52 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45KLYp52009858
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 21:34:52 GMT
Received: from hu-pyarlaga-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 20 Jun 2024 14:34:51 -0700
From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
To: <manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>, <robh@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mrana@quicinc.com>,
        <quic_pyarlaga@quicinc.com>
Subject: [PATCH v1] PCI: qcom: Avoid DBI and ATU register space mirror to BAR/MMIO region
Date: Thu, 20 Jun 2024 14:34:05 -0700
Message-ID: <20240620213405.3120611-1-quic_pyarlaga@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bAZYUlEovHEF2qqrXMnt8it2DVkzrEhM
X-Proofpoint-ORIG-GUID: bAZYUlEovHEF2qqrXMnt8it2DVkzrEhM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_10,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406200158

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
			|		|
			|		|
	-------	--------|---------------|
	   |	   |	|---------------|
	   |	   |	|	DBI	|
	   |	   |	|---------------|---->DBI_BASE_ADDR
	   |	   |	|		|
	   |	   |	|		|
	   |	PCIe	|		|---->2*SLV_ADDR_SPACE_SIZE
	   |	BAR/MMIO|---------------|
	   |	Region	|	ATU	|
	   |	   |	|---------------|---->ATU_BASE_ADDR
	   |	   |	|		|
	PCIe	   |	|---------------|
	Memory	   |	|	DBI	|
	Region	   |	|---------------|---->DBI_BASE_ADDR
	   |	   |	|		|
	   |	--------|		|
	   |		|		|---->SLV_ADDR_SPACE_SIZE
	   |		|---------------|
	   |		|	ATU	|
	   |		|---------------|---->ATU_BASE_ADDR
	   |		|		|
	   |		|---------------|
	   |		|	DBI	|
	   |		|---------------|---->DBI_BASE_ADDR
	   |		|		|
	   |		|		|
	----------------|---------------|
			|		|
			|		|
			|		|
			|---------------|

Currently memory region beyond the SLV_ADDR_SPACE_SIZE boundary is not
used for BAR region which is why the above mentioned issue is not
encountered. This issue is discovered as part of internal testing when we
tried moving the BAR region beyond the SLV_ADDR_SPACE_SIZE boundary. Hence
we are trying to fix this.

As PARF hardware block mirrors DBI and ATU register space after every
PARF_SLV_ADDR_SPACE_SIZE (default 0x1000000) boundary multiple, write
U64_MAX to PARF_SLV_ADDR_SPACE_SIZE register to avoid mirroring DBI and
ATU to BAR/MMIO region. Write the physical base address of DBI and ATU
register blocks to PARF_DBI_BASE_ADDR (default 0x0) and PARF_ATU_BASE_ADDR
(default 0x1000) respectively to make sure DBI and ATU blocks are at
expected memory locations.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 40 ++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 5 deletions(-)

Tested:
- Validated NVME functionality with PCIe6a on x1e80100 platform.
- Validated WiFi functionality with PCIe4 on x1e80100 platform.
- Validated NVME functionality with PCIe0 and PCIe1 on SA8775p platform.

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 5f9f0ff19baa..864548657551 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -49,7 +49,12 @@
 #define PARF_LTSSM				0x1b0
 #define PARF_SID_OFFSET				0x234
 #define PARF_BDF_TRANSLATE_CFG			0x24c
+#define PARF_DBI_BASE_ADDR_V2			0x350
+#define PARF_DBI_BASE_ADDR_V2_HI		0x354
 #define PARF_SLV_ADDR_SPACE_SIZE		0x358
+#define PARF_SLV_ADDR_SPACE_SIZE_HI		0x35C
+#define PARF_ATU_BASE_ADDR			0x634
+#define PARF_ATU_BASE_ADDR_HI			0x638
 #define PARF_NO_SNOOP_OVERIDE			0x3d4
 #define PARF_DEVICE_TYPE			0x1000
 #define PARF_BDF_TO_SID_TABLE_N			0x2000
@@ -319,6 +324,33 @@ static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
 	dw_pcie_dbi_ro_wr_dis(pci);
 }
 
+static void qcom_pcie_avoid_dbi_atu_mirroring(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	struct platform_device *pdev;
+	struct resource *atu_res;
+	struct resource *dbi_res;
+
+	pdev = to_platform_device(pci->dev);
+	if (!pdev)
+		return;
+
+	dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
+	if (dbi_res) {
+		writel(lower_32_bits(dbi_res->start), pcie->parf + PARF_DBI_BASE_ADDR_V2);
+		writel(upper_32_bits(dbi_res->start), pcie->parf + PARF_DBI_BASE_ADDR_V2_HI);
+	}
+
+	atu_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
+	if (atu_res) {
+		writel(lower_32_bits(atu_res->start), pcie->parf + PARF_ATU_BASE_ADDR);
+		writel(upper_32_bits(atu_res->start), pcie->parf + PARF_ATU_BASE_ADDR_HI);
+	}
+
+	writel(lower_32_bits(U64_MAX), pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
+	writel(upper_32_bits(U64_MAX), pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_HI);
+}
+
 static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
 {
 	u32 val;
@@ -623,8 +655,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
-	/* change DBI base address */
-	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
+	qcom_pcie_avoid_dbi_atu_mirroring(pcie);
 
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
 	val = readl(pcie->parf + PARF_SYS_CTRL);
@@ -900,6 +931,8 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	/* Wait for reset to complete, required on SM8450 */
 	usleep_range(1000, 1500);
 
+	qcom_pcie_avoid_dbi_atu_mirroring(pcie);
+
 	/* configure PCIe to RC mode */
 	writel(DEVICE_TYPE_RC, pcie->parf + PARF_DEVICE_TYPE);
 
@@ -908,9 +941,6 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
-	/* change DBI base address */
-	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
-
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
 	val = readl(pcie->parf + PARF_SYS_CTRL);
 	val &= ~MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN;
-- 
2.25.1


