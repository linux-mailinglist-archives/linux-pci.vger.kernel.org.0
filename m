Return-Path: <linux-pci+bounces-7393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C447F8C359A
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2024 10:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B600281491
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2024 08:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BA01C6AE;
	Sun, 12 May 2024 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gP7zyA2Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56FC14286;
	Sun, 12 May 2024 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715502565; cv=none; b=l91r4ph6aCmCMJ+x0UtQP3KJh8UuwGJNUJoo8zYjdD/dBCwWdc+OLy9yLwQ+pWI2Ahrhk9y7X+ASYap+Q1TVYu7i0/J/OmTLqieSEmkZgA0wyQS5LbiqoG7S3mRZ2Qp8UkFnRgElFanxNg/dinZKaTqMXMc4LRFm7Ggu+vdXKD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715502565; c=relaxed/simple;
	bh=eCt+jmp3JH1nBnxI8WlkNQ4HfdQWXMirGk0oOuJ8RkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EIgAJiwkBTZ+TQ+LYjFrPAONqcIn8Munxs3fcp9rdykbuwmyOcALZe1zzoWPoQtd6+y9eauCQEis96HFJkzZRFcFfBe4RYADjxVChMmkvWbgD+gLP1zD7GVJE2A+H1uU98e8IbUb/EJpeVRItO5XkXAJmj9ZdTpDZ/4Bs8mJWPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gP7zyA2Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44C7uj99025896;
	Sun, 12 May 2024 08:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=ItrMJM+
	NpPcOOkNYok0zVdExMjh/MzEygC6gaBJQYTw=; b=gP7zyA2YoCF0ZvQvwh0eypx
	G5rKRchDfG/LTYQIto3Zde8lKFhILLIBPAGfzrbMZTOzyUOR0J3TCZ2pszTAkt5Y
	8Fix2zwezSp66jyLSsdPX5/EqRkgTKENMLnjHvZDyl6xGUJLzxeYLI5N64Toe115
	a+7oE6dKSCppmnhmMl9cKa2139b5mEr6X0rXU3QuOFbvc+RLwqRH89YnWSMtXKmO
	UPGjwo1i81vqV6YeIT0DUeWYozrSsV1fWB2YCQexHEesWMV/TUz31ucVKVJ2siqg
	cOHSoKTtkY67tN5Aybj+1LfJvxKJIunjbBxTqPtzZ4ReGIq5PdkBT70qyfzFZfg=
	=
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y1yp59kg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 08:29:04 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44C8Sx5R009796;
	Sun, 12 May 2024 08:29:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3y21rkna3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 08:29:00 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44C8Sxnw009763;
	Sun, 12 May 2024 08:29:00 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-devipriy-blr.qualcomm.com [10.131.37.37])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 44C8T0wx009816
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 08:29:00 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4059087)
	id 22D794199E; Sun, 12 May 2024 13:58:58 +0530 (+0530)
From: devi priya <quic_devipriy@quicinc.com>
To: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc: quic_devipriy@quicinc.com
Subject: [PATCH V5 6/6] PCI: qcom: Add support for IPQ9574
Date: Sun, 12 May 2024 13:58:58 +0530
Message-Id: <20240512082858.1806694-7-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512082858.1806694-1-quic_devipriy@quicinc.com>
References: <20240512082858.1806694-1-quic_devipriy@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xHUAt-wAPY5e1AxWjXLJQ_L5P6vQPpFo
X-Proofpoint-ORIG-GUID: xHUAt-wAPY5e1AxWjXLJQ_L5P6vQPpFo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-12_05,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405120063

The IPQ9574 platform has 4 Gen3 PCIe controllers:
two single-lane and two dual-lane based on SNPS core 5.70a

The Qcom IP rev is 1.27.0 and Synopsys IP rev is 5.80a
Added a new compatible 'qcom,pcie-ipq9574' and 'ops_1_27_0'
which reuses all the members of 'ops_2_9_0' except for the post_init
as the SLV_ADDR_SPACE_SIZE configuration differs between 2_9_0
and 1_27_0.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: devi priya <quic_devipriy@quicinc.com>
---
 Changes in V5:
	- Rebased on top of the below series which adds support for fetching
	  clocks from the device tree
	  https://lore.kernel.org/linux-pci/20240417-pci-qcom-clk-bulk-v1-1-52ca19b3d6b2@linaro.org/

 drivers/pci/controller/dwc/pcie-qcom.c | 36 +++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 3d2eeff9a876..af36a29c092e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -106,6 +106,7 @@
 
 /* PARF_SLV_ADDR_SPACE_SIZE register value */
 #define SLV_ADDR_SPACE_SZ			0x10000000
+#define SLV_ADDR_SPACE_SZ_1_27_0		0x08000000
 
 /* PARF_MHI_CLOCK_RESET_CTRL register fields */
 #define AHB_CLK_EN				BIT(0)
@@ -1095,16 +1096,13 @@ static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
 	return clk_bulk_prepare_enable(res->num_clks, res->clks);
 }
 
-static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
+static int qcom_pcie_post_init(struct qcom_pcie *pcie)
 {
 	struct dw_pcie *pci = pcie->pci;
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
 	int i;
 
-	writel(SLV_ADDR_SPACE_SZ,
-		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
-
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
@@ -1144,6 +1142,22 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static int qcom_pcie_post_init_1_27_0(struct qcom_pcie *pcie)
+{
+	writel(SLV_ADDR_SPACE_SZ_1_27_0,
+	       pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
+
+	return qcom_pcie_post_init(pcie);
+}
+
+static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
+{
+	writel(SLV_ADDR_SPACE_SZ,
+	       pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
+
+	return qcom_pcie_post_init(pcie);
+}
+
 static int qcom_pcie_link_up(struct dw_pcie *pci)
 {
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
@@ -1297,6 +1311,15 @@ static const struct qcom_pcie_ops ops_2_9_0 = {
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
 
+/* Qcom IP rev.: 1.27.0  Synopsys IP rev.: 5.80a */
+static const struct qcom_pcie_ops ops_1_27_0 = {
+	.get_resources = qcom_pcie_get_resources_2_9_0,
+	.init = qcom_pcie_init_2_9_0,
+	.post_init = qcom_pcie_post_init_1_27_0,
+	.deinit = qcom_pcie_deinit_2_9_0,
+	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
+};
+
 static const struct qcom_pcie_cfg cfg_1_0_0 = {
 	.ops = &ops_1_0_0,
 };
@@ -1334,6 +1357,10 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
 	.no_l0s = true,
 };
 
+static const struct qcom_pcie_cfg cfg_1_27_0 = {
+	.ops = &ops_1_27_0,
+};
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
@@ -1603,6 +1630,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
 	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
+	{ .compatible = "qcom,pcie-ipq9574", .data = &cfg_1_27_0 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
 	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
-- 
2.34.1


