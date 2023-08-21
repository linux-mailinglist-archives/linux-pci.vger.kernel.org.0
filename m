Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CEB782B5F
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 16:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbjHUOQJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 10:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbjHUOP5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 10:15:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB890F1;
        Mon, 21 Aug 2023 07:15:55 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LBrJ7v011825;
        Mon, 21 Aug 2023 14:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=CEscM31QPbJj4xxdgQzQilxtvtR0eecbT3LIAc3boMs=;
 b=o5LXU3Jl7LVCoDIvOI8Mf8lfWyDZbcgL1M8KYRfvNl1ZTCGuarPbZYGte+2L3Ra27yRE
 b19kPNHxfhoX1PWum0+3pGYd1zzFjlA93T10h2efF+hIzOKbWT3ZoVQkgOeUyZAEDeU8
 7mr+wPaQ29NbiZsNuNjYMqiKjQLYhde3c5SY+D/zdlru15mvfvWhVY75VMNYrtDldQrW
 otmY6MmSJPlREyHQS8GGlYZ8jMAXwFP6+EldyCBqQ8wMw6i809G/Yq0pDEnrXUwJvQg5
 CZGg5wGRfKsJgP3gqJM2iikY7vgoCX1pVhNqPJ+n0op05nk/V8EOCqhDBe3Vm1jS2RFc Eg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sjk3tky7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 14:15:49 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37LEFklX010028;
        Mon, 21 Aug 2023 14:15:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sjptkpqfg-1;
        Mon, 21 Aug 2023 14:15:46 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37LEFjrb010021;
        Mon, 21 Aug 2023 14:15:45 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 37LEFjq0010006;
        Mon, 21 Aug 2023 14:15:45 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id F11FA4C17; Mon, 21 Aug 2023 19:45:44 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 3/3] PCI: qcom: Add OPP support for speed based performance state of RPMH
Date:   Mon, 21 Aug 2023 19:45:43 +0530
Message-Id: <1692627343-4380-4-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1692627343-4380-1-git-send-email-quic_krichai@quicinc.com>
References: <1692627343-4380-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b5I7jqd5g6SCxl_e19hrmF97Mt7wO-VV
X-Proofpoint-ORIG-GUID: b5I7jqd5g6SCxl_e19hrmF97Mt7wO-VV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308210131
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Before link training vote for the maximum performance state of RPMH
and once link is up, vote for the performance state based upon the link
speed.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 47 ++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 7a87a47..c57ca1a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -22,6 +22,7 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pci.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 #include <linux/phy/pcie.h>
@@ -1357,6 +1358,32 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static void qcom_pcie_opp_update(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	struct dev_pm_opp *opp;
+	u32 offset, status;
+	int speed, ret = 0;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
+
+	/* Only update constraints if link is up. */
+	if (!(status & PCI_EXP_LNKSTA_DLLLA))
+		return;
+
+	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
+
+	opp = dev_pm_opp_find_level_exact(pci->dev, speed);
+	if (!IS_ERR(opp)) {
+		ret = dev_pm_opp_set_opp(pci->dev, opp);
+		if (ret)
+			dev_err(pci->dev, "Failed to set opp: %d\n", ret);
+		dev_pm_opp_put(opp);
+	}
+
+}
+
 static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
 {
 	struct dw_pcie *pci = pcie->pci;
@@ -1439,8 +1466,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
 	const struct qcom_pcie_cfg *pcie_cfg;
+	unsigned long max_freq = INT_MAX;
 	struct device *dev = &pdev->dev;
 	struct qcom_pcie *pcie;
+	struct dev_pm_opp *opp;
 	struct dw_pcie_rp *pp;
 	struct resource *res;
 	struct dw_pcie *pci;
@@ -1511,6 +1540,22 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_pm_runtime_put;
 
+	/* OPP table is optional */
+	ret = devm_pm_opp_of_add_table(dev);
+	if (ret && ret != -ENODEV) {
+		dev_err(dev, "Invalid OPP table in Device tree\n");
+		goto err_pm_runtime_put;
+	}
+
+	/* vote for max level in the opp table */
+	opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
+	if (!IS_ERR(opp)) {
+		ret = dev_pm_opp_set_opp(dev, opp);
+		if (ret)
+			dev_err(pci->dev, "Failed to set opp: %d\n", ret);
+		dev_pm_opp_put(opp);
+	}
+
 	ret = pcie->cfg->ops->get_resources(pcie);
 	if (ret)
 		goto err_pm_runtime_put;
@@ -1531,6 +1576,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	qcom_pcie_icc_update(pcie);
 
+	qcom_pcie_opp_update(pcie);
+
 	if (pcie->mhi)
 		qcom_pcie_init_debugfs(pcie);
 
-- 
2.7.4

