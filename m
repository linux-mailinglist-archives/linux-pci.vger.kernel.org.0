Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046FE5BE2FF
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 12:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiITKW4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 06:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiITKWz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 06:22:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186FA6C105;
        Tue, 20 Sep 2022 03:22:54 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K806Q0015789;
        Tue, 20 Sep 2022 10:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=N/kqJ6hM+MKZcKVcVJSn5RZWT45C+Ed1GuSP75wY0sc=;
 b=pMm79fqCw+8FgHk2eoJVCNq2kgiQETN/YFZ++WDGwFDe9q/xo+6+i1TvIZTBCozuOZdh
 ZwX1476iWmOHn37Zl3Nq9TU7FQPqc69n2TB6e9QY2TQYnvEjcSjpsme5HCs654rXMPNg
 LPVynA1z+kIQHqa030yXcyPXmInkU1Dj2jkhNLl1nUcUhmpMNQRpXWEHtqsn0HPf1cjt
 SlF3LznCIbOnN5gutiyxeTpALZxc0YO3U8/v+7OpQ4ESBCtzH6wmkcx7WFpHNcsBPEM+
 OBVZlW1kp17keoYFQX8kp+G25+7zG1MaRmHpJip4cPdMkVRFDf9mdlXxw+qP0+MFIUW5 rw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jq4r09dbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 10:22:34 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28KAMUpv016172;
        Tue, 20 Sep 2022 10:22:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3jnqrbnbqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Sep 2022 10:22:31 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28KAMUgh016182;
        Tue, 20 Sep 2022 10:22:30 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.37])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 28KAMUL2016169;
        Tue, 20 Sep 2022 10:22:30 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id DDF7E1A07; Tue, 20 Sep 2022 15:52:29 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        svarbanov@mm-sol.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-phy@lists.infradead.org, vkoul@kernel.org, kishon@ti.com,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v7 4/5] phy: qcom: Add power suspend & resume callbacks to PCIe phy
Date:   Tue, 20 Sep 2022 15:52:26 +0530
Message-Id: <1663669347-29308-5-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1663669347-29308-1-git-send-email-quic_krichai@quicinc.com>
References: <1663669347-29308-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Sjn5LIsd3PAAGUkv95Ma8gS-WHXmhmjc
X-Proofpoint-GUID: Sjn5LIsd3PAAGUkv95Ma8gS-WHXmhmjc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=693
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200062
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add phy power suspend & resume callbacks to PCIe phy. Using these
callbacks we can release phy resources like phy specific clocks
but continue maintain PCIe link in l1ss state.

This can help in parking PCIe link in l1ss state during system
suspend (S3).

Instead of this if we add suspend & resume pm ops, phy will suspend
first instead of PCIe driver, it will cause link down as phy will
be down before controller goes down.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
changes since v6:
	- Change names from phy_power_down and phy_power_up to
	  phy_pm_suspend and phy_pm_resume respectively.
---
 drivers/pci/controller/dwc/pcie-qcom.c   |  4 +--
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 50 ++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 7a6f69e..672a9be 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1326,7 +1326,7 @@ static int qcom_pcie_resume_2_7_0(struct qcom_pcie *pcie)
 
 	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
 
-	phy_power_on(pcie->phy);
+	phy_pm_resume(pcie->phy);
 
 	return ret;
 }
@@ -1335,7 +1335,7 @@ static int qcom_pcie_suspend_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 
-	phy_power_off(pcie->phy);
+	phy_pm_suspend(pcie->phy);
 
 	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 	return 0;
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 2d65e1f..69220dd 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -2145,6 +2145,54 @@ static int qcom_qmp_phy_pcie_exit(struct phy *phy)
 	return 0;
 }
 
+static int qcom_qmp_phy_pcie_resume(struct phy *phy)
+{
+	struct qmp_phy *qphy = phy_get_drvdata(phy);
+	struct qcom_qmp *qmp = qphy->qmp;
+	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(cfg->num_clks, qmp->clks);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(qphy->pipe_clk);
+	if (ret)
+		return ret;
+
+	/* Pull out PHY from POWER DOWN state */
+	if (cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL]) {
+		qphy_setbits(qphy->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
+			     cfg->pwrdn_ctrl);
+	} else {
+		qphy_setbits(qphy->pcs, QPHY_V2_PCS_POWER_DOWN_CONTROL,
+				cfg->pwrdn_ctrl);
+	}
+
+	return 0;
+}
+
+static int qcom_qmp_phy_pcie_suspend(struct phy *phy)
+{
+	struct qmp_phy *qphy = phy_get_drvdata(phy);
+	struct qcom_qmp *qmp = qphy->qmp;
+	const struct qmp_phy_cfg *cfg = qphy->cfg;
+
+	clk_disable_unprepare(qphy->pipe_clk);
+	clk_bulk_disable_unprepare(cfg->num_clks, qmp->clks);
+
+	/* Put PHY into POWER DOWN state: active low */
+	if (cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL]) {
+		qphy_clrbits(qphy->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
+			     cfg->pwrdn_ctrl);
+	} else {
+		qphy_clrbits(qphy->pcs, QPHY_V2_PCS_POWER_DOWN_CONTROL,
+				cfg->pwrdn_ctrl);
+	}
+
+	return 0;
+}
+
 static int qcom_qmp_phy_pcie_enable(struct phy *phy)
 {
 	int ret;
@@ -2304,6 +2352,8 @@ static const struct phy_ops qcom_qmp_phy_pcie_ops = {
 	.power_on	= qcom_qmp_phy_pcie_enable,
 	.power_off	= qcom_qmp_phy_pcie_disable,
 	.set_mode	= qcom_qmp_phy_pcie_set_mode,
+	.suspend	= qcom_qmp_phy_pcie_suspend,
+	.resume		= qcom_qmp_phy_pcie_resume,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.7.4

