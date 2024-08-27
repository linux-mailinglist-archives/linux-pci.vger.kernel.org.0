Return-Path: <linux-pci+bounces-12252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645969601EB
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 08:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA609B2307D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 06:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10E2158D79;
	Tue, 27 Aug 2024 06:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pVN0ORfH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20681155303;
	Tue, 27 Aug 2024 06:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740624; cv=none; b=eoCBhXnumuIqozlrlvYHMHJtxkqslqos36wGFaHS+0TfGkoJpuySxLoUkS4joJpx2jDo6JHmw1eUeJDZDR2fBT42G+l1r/kVP2bPR7tbso472rIP2zerp50/+nWLAXbQcCRc0zHv30Wogge91E6+rIfbPVVTjUMW41zf+nnHE2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740624; c=relaxed/simple;
	bh=9L9M2yZqzc5xLvPves2tKFCMnMSRG+agF/XJau1Hna8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EtUv8Vk7ypIsYyxWoTEmtgXRs81kxOsykJel5tbH3irKiVqj0HtwdJcQrJzhqBrlHL+nziyzbH/JZ7R9TOQLhgy3jKqkaWQ2iAY4Hz1mH6tInRpFIWxkMn1GeUTLREykS+hI4YCNnHyTdejdDUTUoC2dJnB5N6T2Bzf31Yr2eJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pVN0ORfH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QJGSko028158;
	Tue, 27 Aug 2024 06:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QDEMLhiG+OJ
	uyuKMY5EIrlLdihz623LVdNQWa8fMfdw=; b=pVN0ORfHo6cFGks2a6k5ca3MVol
	71pYjnbW4M2RAV+0JVIxeSdxgDy4VWwXra7Gh3+TQ0Tv4CvAo3S3NdbkupTLN5Ji
	BeKVQm5ngYr267BdpiQO6PM+1Nk2QvGy8WOPJluZ3XF61ndqz2lMg+e5BLCxA7Km
	7TWyFFkzNHP5o+5BpNOUxj1lxvEgpDDt0+6ngC3D7Df5WbV/s70+EpZz1I4KD+L5
	tPTNIWMuW/MBXaiNaYjgYyJj2ojJntQ8epXVtcC0ftWbti5ivHmmhWf1IaYbQuTb
	CvgEGqTKkJBzruzG+pKorxju1lIuG0lUquXyeY8KcB4R2+gbfBbwfLkm9CA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 417973nyt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:36:54 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47R6Xq44019749;
	Tue, 27 Aug 2024 06:36:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 4198va8jks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:36:52 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47R6aq0x026429;
	Tue, 27 Aug 2024 06:36:52 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-qianyu-lv.qualcomm.com [10.81.25.114])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 47R6aq4r026424
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:36:52 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4098150)
	id 7C38764E; Mon, 26 Aug 2024 23:36:52 -0700 (PDT)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org,
        robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
        quic_devipriy@quicinc.com
Cc: dmitry.baryshkov@linaro.org, kw@linux.com, lpieralisi@kernel.org,
        neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH 8/8] PCI: qcom: Add support to PCIe slot power supplies
Date: Mon, 26 Aug 2024 23:36:31 -0700
Message-Id: <20240827063631.3932971-9-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: WMzAFl9W03rEZh-ulVVLpjuIjCPk6IKm
X-Proofpoint-GUID: WMzAFl9W03rEZh-ulVVLpjuIjCPk6IKm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_04,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408270048

On platform x1e80100 QCP, PCIe3 is a standard x8 form factor. Hence, add
support to use 3.3v, 3.3v aux and 12v regulators.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 52 +++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6f953e32d990..59fb415dfeeb 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -248,6 +248,8 @@ struct qcom_pcie_cfg {
 	bool no_l0s;
 };
 
+#define QCOM_PCIE_SLOT_MAX_SUPPLIES			3
+
 struct qcom_pcie {
 	struct dw_pcie *pci;
 	void __iomem *parf;			/* DT parf */
@@ -260,6 +262,7 @@ struct qcom_pcie {
 	struct icc_path *icc_cpu;
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
+	struct regulator_bulk_data slot_supplies[QCOM_PCIE_SLOT_MAX_SUPPLIES];
 	bool suspended;
 	bool use_pm_opp;
 };
@@ -1174,6 +1177,41 @@ static int qcom_pcie_link_up(struct dw_pcie *pci)
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
 }
 
+static int qcom_pcie_enable_slot_supplies(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(pcie->slot_supplies),
+				    pcie->slot_supplies);
+	if (ret < 0)
+		dev_err(pci->dev, "Failed to enable slot regulators\n");
+
+	return ret;
+}
+
+static void qcom_pcie_disable_slot_supplies(struct qcom_pcie *pcie)
+{
+	regulator_bulk_disable(ARRAY_SIZE(pcie->slot_supplies),
+			       pcie->slot_supplies);
+}
+
+static int qcom_pcie_get_slot_supplies(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	int ret;
+
+	pcie->slot_supplies[0].supply = "vpcie12v";
+	pcie->slot_supplies[1].supply = "vpcie3v3";
+	pcie->slot_supplies[2].supply = "vpcie3v3aux";
+	ret = devm_regulator_bulk_get(pci->dev, ARRAY_SIZE(pcie->slot_supplies),
+				      pcie->slot_supplies);
+	if (ret < 0)
+		dev_err(pci->dev, "Failed to get slot regulators\n");
+
+	return ret;
+}
+
 static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1182,10 +1220,14 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 
 	qcom_ep_reset_assert(pcie);
 
-	ret = pcie->cfg->ops->init(pcie);
+	ret = qcom_pcie_enable_slot_supplies(pcie);
 	if (ret)
 		return ret;
 
+	ret = pcie->cfg->ops->init(pcie);
+	if (ret)
+		goto err_disable_slot;
+
 	ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
 	if (ret)
 		goto err_deinit;
@@ -1216,7 +1258,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	phy_power_off(pcie->phy);
 err_deinit:
 	pcie->cfg->ops->deinit(pcie);
-
+err_disable_slot:
+	qcom_pcie_disable_slot_supplies(pcie);
 	return ret;
 }
 
@@ -1228,6 +1271,7 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
 	qcom_ep_reset_assert(pcie);
 	phy_power_off(pcie->phy);
 	pcie->cfg->ops->deinit(pcie);
+	qcom_pcie_disable_slot_supplies(pcie);
 }
 
 static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
@@ -1602,6 +1646,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 			goto err_pm_runtime_put;
 	}
 
+	ret = qcom_pcie_get_slot_supplies(pcie);
+	if (ret)
+		goto err_pm_runtime_put;
+
 	ret = pcie->cfg->ops->get_resources(pcie);
 	if (ret)
 		goto err_pm_runtime_put;
-- 
2.34.1


