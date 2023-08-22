Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001E478452C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 17:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbjHVPMu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 11:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236510AbjHVPMu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 11:12:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CFFCCB;
        Tue, 22 Aug 2023 08:12:48 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MCpAXf020595;
        Tue, 22 Aug 2023 15:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=dLTK4k3xbiu3J30AjnQJBNhX1TJeIWaAc9qbb1D/cZA=;
 b=WDXx5ITw2PJNuTKA3g3K4bu3fuvorGE7Dqtgl1gf+1VOxmwizTMPw3z9EPQRj0/SDRoN
 ANY20yT/hz+72sBZ9/+C/43mGSPgeFszoBXMTQ1E9GMUxHP0QVytVs65vb1pNOLsQH4/
 jL3Sy5Pu645Y7C5FuFEtv8jC9q/FaTMNVOFbiYFNsh/uQlyXeWbJd3HuTgU0CT1BRrNK
 6B2PQwTsuhdke2lfvVYgU4Gk2kLBjNhhaLq/Qlyy2iRTXH6stB2a92GLvgNFv5xAZXg7
 4JKRULpy5pLR+cRniiQm7hD+FLHTH9Aqb3OQbOjeh4HUEnHPh+T+EUVDaeE2fBoLYOK2 Nw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sm6uuk94d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 15:12:28 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37MFCNYg032354;
        Tue, 22 Aug 2023 15:12:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sjptkwbw3-1;
        Tue, 22 Aug 2023 15:12:24 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37MFCNS5032343;
        Tue, 22 Aug 2023 15:12:24 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 37MFCO7v032362;
        Tue, 22 Aug 2023 15:12:24 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 8C02E4BA7; Tue, 22 Aug 2023 20:42:23 +0530 (+0530)
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
Subject: [PATCH v4 4/4] PCI: qcom: Add OPP support for speed based performance state of RPMH
Date:   Tue, 22 Aug 2023 20:42:21 +0530
Message-Id: <1692717141-32743-5-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1692717141-32743-1-git-send-email-quic_krichai@quicinc.com>
References: <1692717141-32743-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: t7TmZnONEiw-gg2h7DLdbrGk_qxUTZja
X-Proofpoint-GUID: t7TmZnONEiw-gg2h7DLdbrGk_qxUTZja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308220116
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
 drivers/pci/controller/dwc/pcie-qcom.c | 52 ++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 7a87a47..161fdad 100644
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
@@ -1357,6 +1358,33 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
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
+			dev_err(pci->dev, "Failed to set opp: level %d ret %d\n",
+						dev_pm_opp_get_level(opp), ret);
+		dev_pm_opp_put(opp);
+	}
+
+}
+
 static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
 {
 	struct dw_pcie *pci = pcie->pci;
@@ -1439,8 +1467,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
 	const struct qcom_pcie_cfg *pcie_cfg;
+	unsigned long max_level = INT_MAX;
 	struct device *dev = &pdev->dev;
 	struct qcom_pcie *pcie;
+	struct dev_pm_opp *opp;
 	struct dw_pcie_rp *pp;
 	struct resource *res;
 	struct dw_pcie *pci;
@@ -1511,6 +1541,23 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
+	opp = dev_pm_opp_find_level_floor(dev, &max_level);
+	if (!IS_ERR(opp)) {
+		ret = dev_pm_opp_set_opp(dev, opp);
+		if (ret)
+			dev_err(pci->dev, "Failed to set opp: level %d ret %d\n",
+						dev_pm_opp_get_level(opp), ret);
+		dev_pm_opp_put(opp);
+	}
+
 	ret = pcie->cfg->ops->get_resources(pcie);
 	if (ret)
 		goto err_pm_runtime_put;
@@ -1531,6 +1578,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	qcom_pcie_icc_update(pcie);
 
+	qcom_pcie_opp_update(pcie);
+
 	if (pcie->mhi)
 		qcom_pcie_init_debugfs(pcie);
 
@@ -1577,6 +1626,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 	 */
 	if (!dw_pcie_link_up(pcie->pci)) {
 		qcom_pcie_host_deinit(&pcie->pci->pp);
+		dev_pm_opp_set_opp(dev, NULL);
 		pcie->suspended = true;
 	}
 
@@ -1593,6 +1643,8 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 		if (ret)
 			return ret;
 
+		qcom_pcie_opp_update(pcie);
+
 		pcie->suspended = false;
 	}
 
-- 
2.7.4

