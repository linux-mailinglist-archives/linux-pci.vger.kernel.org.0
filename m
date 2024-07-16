Return-Path: <linux-pci+bounces-10364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E559322C6
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 11:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504911F225D3
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 09:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D151991C6;
	Tue, 16 Jul 2024 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lofwExXw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF47619755B;
	Tue, 16 Jul 2024 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121895; cv=none; b=AwtQ7CEZ16aQSTr8e6+vvuEZThRCo9Ucnio9Vb1X8MS7V6QfVJ/XmTx1aQusZvhYu8P+PC7sF+ZJZkxYxOQSglb5p9XShFu2Wk6kmdE1vKa62xqNx2XaPRpVOdGcuvfsSsdqJvKI4G1iUZzNYflul30SGW4xLtzmUD4YMZvhw74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121895; c=relaxed/simple;
	bh=rcokNA6tRK/q0PVbebMPqEhkSskhnHgviY5zxmP2MQg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hh2QPJNxL00uSvTRTqB6YharlPUz7pEYDQJYkEaWwhLmXLy47JAA9pzvV3N4V7Ci2J6Frnp/Epy/T1S5RqCs2rDzpCsNkfL3RRnB3pgNohfgrAeIkM/6sSp4wFyia/HrjGAqN4PJkdeShNQm/0KzVnSW2NAUwPgM0wVoL4SOuJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lofwExXw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46G4X2Vw001297;
	Tue, 16 Jul 2024 09:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WpZ/z5HPss1VQyE/J7rNj/n8s8SnkeSPfry5IAh4DF0=; b=lofwExXwQGSUnAbq
	/oIEfS4I0dxQXbaFHrdxex4743YrdrcwT4Cz0Sac0SKN7KzSFoXO9BmubXpj6hJV
	NuIOv+gQYR0RahSdKc/rmTvBN7cXu2VtM2K1iZhETcDI9GfYBOtG/1nn+hfVgTCM
	81b3XdHmL/Ly3pXwunegqeDXOGuV0c2ivoTqOAzWEL+Zykb/7Z/u6TEPMR3HnvXf
	AR2DzKdHU4VBnatxSD2BHlztmsxGoGiwAHEiQAXE+9f2uE/tzp5wfLKAA3cFNpw6
	GRjD73ui/cIycrQvXu0R58jfdzZne3dRWc1K8D/Y52FWXn/znTYcg7V7AwBVogB7
	UxHGog==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bhnupjxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 09:24:45 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46G9OiEt022137
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 09:24:44 GMT
Received: from hu-srichara-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 16 Jul 2024 02:24:38 -0700
From: Sricharan R <quic_srichara@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
CC: devi priya <quic_devipriy@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>
Subject: [PATCH V6 4/4] PCI: qcom: Add support for IPQ9574
Date: Tue, 16 Jul 2024 14:53:47 +0530
Message-ID: <20240716092347.2177153-5-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716092347.2177153-1-quic_srichara@quicinc.com>
References: <20240716092347.2177153-1-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: J0aC2uIDpAadMhmhUEtMXr7p2tSw6mWU
X-Proofpoint-GUID: J0aC2uIDpAadMhmhUEtMXr7p2tSw6mWU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 clxscore=1011 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407160067

From: devi priya <quic_devipriy@quicinc.com>

The IPQ9574 platform has four Gen3 PCIe controllers:
two single-lane and two dual-lane based on SNPS core 5.70a.

QCOM IP rev is 1.27.0 and Synopsys IP rev is 5.80a.
Add a new compatible 'qcom,pcie-ipq9574' and 'ops_1_27_0'
which reuses all the members of 'ops_2_9_0' except for the
post_init as the SLV_ADDR_SPACE_SIZE configuration differs
between 2_9_0 and 1_27_0.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: devi priya <quic_devipriy@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 [V6] Fixed all Manivannan's and Bjorn Helgaas comments.
      Removed the SLV_ADDR_SPACE_SZ_1_27_0 macro to have default value.

 drivers/pci/controller/dwc/pcie-qcom.c | 31 ++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 0180edf3310e..26acd9f5385e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1116,16 +1116,13 @@ static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
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
@@ -1165,6 +1162,18 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static int qcom_pcie_post_init_1_27_0(struct qcom_pcie *pcie)
+{
+	return qcom_pcie_post_init(pcie);
+}
+
+static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
+{
+	writel(SLV_ADDR_SPACE_SZ, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
+
+	return qcom_pcie_post_init(pcie);
+}
+
 static int qcom_pcie_link_up(struct dw_pcie *pci)
 {
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
@@ -1318,6 +1327,15 @@ static const struct qcom_pcie_ops ops_2_9_0 = {
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
@@ -1360,6 +1378,10 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
 	.no_l0s = true,
 };
 
+static const struct qcom_pcie_cfg cfg_1_27_0 = {
+	.ops = &ops_1_27_0,
+};
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
@@ -1724,6 +1746,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
 	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
+	{ .compatible = "qcom,pcie-ipq9574", .data = &cfg_1_27_0 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
 	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
-- 
2.34.1


