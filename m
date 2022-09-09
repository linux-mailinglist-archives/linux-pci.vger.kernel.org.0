Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7579A5B3215
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 10:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiIIIpt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 04:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiIIIpb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 04:45:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8436A11B009;
        Fri,  9 Sep 2022 01:45:29 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2898a2jM031521;
        Fri, 9 Sep 2022 08:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=R7Lp+Vuu59p5nbAR6rdtz820PIjAxRmN7XjW4T69x8s=;
 b=ml85pa+J5kaCxMUa8yRPySCGVzZD8eITwB7kh0ID57ooeZMnxXJ4GcEh+Jhn/MClcmZg
 jteJUDO+8b/lhNFggh9zQvd5+Qu8KSJsxMYeWBMnhdO5R7C0j0bu7/MiMUWAfHPvDMyU
 QxHTdcERsKWiITsxA+q0OelqwTs4dMyQU6kBR4+D64nz3iCa4moxFg+xDSVrxLFihG2y
 CpE8JTnYDPVQHTw7zpjXh9FR1ckZsAdodksGOpWLi9O2+TPOYNmEOOnHSVbDl29RRqTt
 fNMfIh8lvskWquVNdpEDbAK+jHxuS8PjBECwa+WL7vUkavtyAoExy4JzGddXcAMWVPcc QQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jf8514u3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 08:45:14 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2898j583014253;
        Fri, 9 Sep 2022 08:45:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3jc00m8vqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 09 Sep 2022 08:45:05 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2898j4Vg014229;
        Fri, 9 Sep 2022 08:45:05 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.37])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 2898j4Wr014215;
        Fri, 09 Sep 2022 08:45:04 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 44B1644AD; Fri,  9 Sep 2022 14:15:04 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK)
Subject: [PATCH v6 4/5] phy: qcom: Add power down/up callbacks to pcie phy
Date:   Fri,  9 Sep 2022 14:14:43 +0530
Message-Id: <1662713084-8106-5-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1662713084-8106-1-git-send-email-quic_krichai@quicinc.com>
References: <1662713084-8106-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BCA4Ed_CBbbMwOml2C-4x5euSfWHWTaT
X-Proofpoint-ORIG-GUID: BCA4Ed_CBbbMwOml2C-4x5euSfWHWTaT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_04,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxlogscore=809 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090030
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add phy power down/up callbacks to pcie phy. Using these callbacks
we can release phy resources like phy specific clocks but continue
maintain pcie link in l1ss state.

This can help in parking pcie link in l1ss state during system
suspend (S3).

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c   |  6 ++--
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 50 ++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 15c2067..1d4b1b0 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1326,7 +1326,8 @@ static int qcom_pcie_resume_2_7_0(struct qcom_pcie *pcie)
 
 	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
 
-	phy_power_on(pcie->phy);
+	/* Bring back PHY from power down */
+	phy_power_up(pcie->phy);
 
 	return ret;
 }
@@ -1335,7 +1336,8 @@ static int qcom_pcie_suspend_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 
-	phy_power_off(pcie->phy);
+	/* Power down PHY to park the link state in L1ss */
+	phy_power_down(pcie->phy);
 
 	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 	return 0;
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 3ddbb8e..c6b3b82 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -2145,6 +2145,54 @@ static int qcom_qmp_phy_pcie_exit(struct phy *phy)
 	return 0;
 }
 
+static int qcom_qmp_phy_pcie_power_up(struct phy *phy)
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
+static int qcom_qmp_phy_pcie_power_down(struct phy *phy)
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
+	.power_down	= qcom_qmp_phy_pcie_power_down,
+	.power_up	= qcom_qmp_phy_pcie_power_up,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.7.4

