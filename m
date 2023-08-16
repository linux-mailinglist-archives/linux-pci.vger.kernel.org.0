Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7896D77E278
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 15:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245502AbjHPNYz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 09:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245491AbjHPNYp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 09:24:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843EA212F;
        Wed, 16 Aug 2023 06:24:44 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GCGOvt027372;
        Wed, 16 Aug 2023 13:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=Vq8+rXML6CohwZ173l4XaVc9uDG5lCKVU8T78UfunHk=;
 b=SodoLPcKS4FcFbbKR5jbVJgxpFSy5+SucrVe4Qy3AC/T+ceq0M0TKPNsT43Wqcoi3zcS
 vIfrFgCDNPTpFFYEt4LUDN00Cjl1pnufxR8Dy8u8uEeicD+X6tiRqvDTTzqxexjdz0bA
 z7Wy3/oldV0wwP3VtMidda2Zu5s6b9INR6PtK/xOx/H1MCiUm0q9bqyOXd27lckdjsAx
 WMSLAT3O2rWNJ0g67uKTLMf8wZfgjKlR42lMtIahDzBDybMwiy/uwuAu/Mp56VjfaGg2
 fNtoeeXEviq2UQwaUFIuBRaOdbgPA2lCurCZS5DSBMKGMooaIqwSgmS/Y1Q4fltrju+E Vg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sfxqruh4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 13:24:36 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37GDOXBl014788;
        Wed, 16 Aug 2023 13:24:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3se35keug7-1;
        Wed, 16 Aug 2023 13:24:33 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37GDJYkP009327;
        Wed, 16 Aug 2023 13:24:33 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 37GDOWEJ014767;
        Wed, 16 Aug 2023 13:24:33 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 393A14BCD; Wed, 16 Aug 2023 18:54:32 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 3/3] PCI: qcom: Add OPP support for speed based performance state of RPMH
Date:   Wed, 16 Aug 2023 18:54:24 +0530
Message-Id: <1692192264-18515-4-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1692192264-18515-1-git-send-email-quic_krichai@quicinc.com>
References: <1692192264-18515-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k2yA6XZtadl0kweeuc_dwznLlJryWlQa
X-Proofpoint-ORIG-GUID: k2yA6XZtadl0kweeuc_dwznLlJryWlQa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_12,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160114
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/pci/controller/dwc/pcie-qcom.c | 65 ++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 7a87a47..831d158 100644
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
@@ -1357,6 +1358,51 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static void qcom_pcie_opp_update(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	struct dev_pm_opp *opp;
+	u32 offset, status;
+	int speed, ret = 0;
+	uint32_t freq;
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
+	switch (speed) {
+	case 1:
+		freq = 2500000;
+		break;
+	case 2:
+		freq = 5000000;
+		break;
+	case 3:
+		freq = 8000000;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		fallthrough;
+	case 4:
+		freq = 16000000;
+		break;
+	}
+
+	opp = dev_pm_opp_find_freq_exact(pci->dev, freq, true);
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
@@ -1439,8 +1485,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
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
@@ -1511,6 +1559,21 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_pm_runtime_put;
 
+	/* OPP table is optional */
+	ret = devm_pm_opp_of_add_table(dev);
+	if (ret && ret != -ENODEV) {
+		dev_err(dev, "Invalid OPP table in Device tree\n");
+		goto err_pm_runtime_put;
+	}
+
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
@@ -1531,6 +1594,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	qcom_pcie_icc_update(pcie);
 
+	qcom_pcie_opp_update(pcie);
+
 	if (pcie->mhi)
 		qcom_pcie_init_debugfs(pcie);
 
-- 
2.7.4

