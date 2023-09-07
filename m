Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BF27977B3
	for <lists+linux-pci@lfdr.de>; Thu,  7 Sep 2023 18:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjIGQbe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Sep 2023 12:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238169AbjIGQbK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Sep 2023 12:31:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6F61FF6;
        Thu,  7 Sep 2023 09:18:12 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3874sYcr024320;
        Thu, 7 Sep 2023 06:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=E2/rZXApw2tHGMvkwZrvHBMnvXncapvh3R4u/7IfL5M=;
 b=l8lNDfzchWOulH200UbVDRyFg5XkgHs7N3LL4IdlupJ0XRRzlWgX7oWLg7JvvdjEVgqU
 xLiM5Jx08I72TfBr0CGQQiTnt/GCi1wA7DW67zq860p46cYoPdm4fvNkuR4PlN0+QwxY
 5b3tP73Q/CwxBIPKeW2lk/ge75WYW730eMjwztpn57DVTUFU/N3BEUIBmJq+xThrctKp
 L+NcEsbAej795br3/C0G1RJC6qy0vg0hSDkX4OIW8m4lUN7/ooyDAQtsxljo+eSm+4j+
 qy6tpiU4EbB8TFtIaaIcrvzdl+v+0JXvomgHKalZx2BAeR5mbh9LXeVm9CoQ3zOugYZB rw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sy50d8ck7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 06:01:04 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38760wID011319;
        Thu, 7 Sep 2023 06:01:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sux4kjqvc-1;
        Thu, 07 Sep 2023 06:01:01 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38760sNT011295;
        Thu, 7 Sep 2023 06:01:01 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3876109W011363;
        Thu, 07 Sep 2023 06:01:01 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 52D3B13BA; Thu,  7 Sep 2023 11:31:00 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, mani@kernel.org
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, quic_parass@quicinc.com,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v5 5/5] PCI: qcom: Add OPP support to scale performance state of power domain
Date:   Thu,  7 Sep 2023 11:30:33 +0530
Message-Id: <1694066433-8677-6-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694066433-8677-1-git-send-email-quic_krichai@quicinc.com>
References: <1694066433-8677-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Scwlq_BSajw-yOZNptPblDV7DZL5y0fm
X-Proofpoint-GUID: Scwlq_BSajw-yOZNptPblDV7DZL5y0fm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070052
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

While scaling the interconnect clocks based on PCIe link speed, it is also
mandatory to scale the power domain performance state so that the SoC can
run under optimum power conditions.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 58 ++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ca6350b..1817e96 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -22,6 +22,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/pci.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 #include <linux/phy/pcie.h>
@@ -240,6 +241,7 @@ struct qcom_pcie {
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
 	bool suspended;
+	bool opp_supported;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -1357,14 +1359,13 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
 	return 0;
 }
 
-static int qcom_pcie_icc_update(struct qcom_pcie *pcie)
+static int qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 {
 	struct dw_pcie *pci = pcie->pci;
+	struct dev_pm_opp *opp;
 	u32 offset, status, bw;
 	int speed, width;
-
-	if (!pcie->icc_mem)
-		return 0;
+	int ret;
 
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
@@ -1391,7 +1392,21 @@ static int qcom_pcie_icc_update(struct qcom_pcie *pcie)
 		break;
 	}
 
-	return icc_set_bw(pcie->icc_mem, 0, width * bw);
+	if (pcie->opp_supported) {
+		opp = dev_pm_opp_find_level_exact(pci->dev, speed);
+		if (!IS_ERR(opp)) {
+			ret = dev_pm_opp_set_opp(pci->dev, opp);
+			if (ret)
+				dev_err(pci->dev, "Failed to set opp: level %d ret %d\n",
+					dev_pm_opp_get_level(opp), ret);
+			dev_pm_opp_put(opp);
+		}
+	}
+
+	if (pcie->icc_mem)
+		ret = icc_set_bw(pcie->icc_mem, 0, width * bw);
+
+	return ret;
 }
 
 static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
@@ -1434,8 +1449,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
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
@@ -1506,6 +1523,27 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_pm_runtime_put;
 
+	/* OPP table is optional */
+	ret = devm_pm_opp_of_add_table(dev);
+	if (ret && ret != -ENODEV) {
+		dev_err_probe(dev, ret, "Failed to add OPP table\n");
+		goto err_pm_runtime_put;
+	}
+
+	/* vote for max level in the opp table if opp table is present */
+	if (ret != -ENODEV) {
+		opp = dev_pm_opp_find_level_floor(dev, &max_level);
+		if (!IS_ERR(opp)) {
+			ret = dev_pm_opp_set_opp(dev, opp);
+			if (ret)
+				dev_err_probe(pci->dev, ret,
+					      "Failed to set opp: level %d\n",
+					      dev_pm_opp_get_level(opp));
+			dev_pm_opp_put(opp);
+		}
+		pcie->opp_supported = true;
+	}
+
 	ret = pcie->cfg->ops->get_resources(pcie);
 	if (ret)
 		goto err_pm_runtime_put;
@@ -1524,9 +1562,9 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_phy_exit;
 	}
 
-	ret = qcom_pcie_icc_update(pcie);
+	ret = qcom_pcie_icc_opp_update(pcie);
 	if (ret)
-		dev_err(dev, "failed to update interconnect bandwidth: %d\n",
+		dev_err(dev, "failed to update interconnect bandwidth/opp: %d\n",
 			ret);
 
 	if (pcie->mhi)
@@ -1575,6 +1613,8 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 	 */
 	if (!dw_pcie_link_up(pcie->pci)) {
 		qcom_pcie_host_deinit(&pcie->pci->pp);
+		if (pcie->opp_supported)
+			dev_pm_opp_set_opp(dev, NULL);
 		pcie->suspended = true;
 	}
 
@@ -1594,9 +1634,9 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 		pcie->suspended = false;
 	}
 
-	ret = qcom_pcie_icc_update(pcie);
+	ret = qcom_pcie_icc_opp_update(pcie);
 	if (ret)
-		dev_err(dev, "failed to update interconnect bandwidth: %d\n",
+		dev_err(dev, "failed to update interconnect bandwidth/opp: %d\n",
 			ret);
 
 	return 0;
-- 
2.7.4

