Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16E6588B33
	for <lists+linux-pci@lfdr.de>; Wed,  3 Aug 2022 13:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbiHCL3U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Aug 2022 07:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbiHCL3T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Aug 2022 07:29:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BF73A488;
        Wed,  3 Aug 2022 04:29:18 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273BKVAA026966;
        Wed, 3 Aug 2022 11:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=hXO0hiq2hCjA+t5pC7fQX0O6hI1gT1EXPAns4xvzggk=;
 b=PqN3w9Wge1PHsjJ8snBkFAm5XrISlQNOeNf3oxQ0QUuAihPGBpM7rFy20B1HKID8dmmC
 Y+/o1Xqn01aCURiEpBXxvdy56PfnGbXoJru5yVD9LJtPydhy/WJABQrOxbV/1blr/DKJ
 8hNLNEXDx173LmRBbWi3JSxuXhSn3X3zyilsFx77qNoIEMN7HIchDChjttIZis6vfr17
 iIgIwT0HCXPnamMAxcyuhELpBCUcS5T4hcVgkFLct6tX/C3ajbT7qAMoYz9IJ2peg46/
 ud4xAAC3Jlx1sZ/ZomZC2+I3YPgdlN6Og2DPOn+Fb+E2XgY6/oTS53wOpQDI68+TA9Yt 1w== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hpt8t3hmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Aug 2022 11:29:03 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 273BSwBB023585;
        Wed, 3 Aug 2022 11:28:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3hmwqkd7d9-1;
        Wed, 03 Aug 2022 11:28:58 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 273BSwYB023565;
        Wed, 3 Aug 2022 11:28:58 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.37])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 273BSwhd023560;
        Wed, 03 Aug 2022 11:28:58 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id A04D041C6; Wed,  3 Aug 2022 16:58:57 +0530 (+0530)
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
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v5 1/3] PCI: qcom: Add system PM support
Date:   Wed,  3 Aug 2022 16:58:52 +0530
Message-Id: <1659526134-22978-2-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1659526134-22978-1-git-send-email-quic_krichai@quicinc.com>
References: <1659526134-22978-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XRjuueMIAzASsfdM7H6eMGPmASKhSiRZ
X-Proofpoint-GUID: XRjuueMIAzASsfdM7H6eMGPmASKhSiRZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_03,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 clxscore=1011 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208030050
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add suspend and resume pm callbacks.

When system suspends, and if the link is in L1ss, disable the clocks
and power down the phy so that system enters into low power state to
save the maximum power. And when the system resumes, enable the clocks
back and power on phy if they are disabled in the suspend path.

we are doing this only when link is in l1ss but not in L2/L3 as
no where we are forcing link to L2/L3 by sending PME turn off.

is_suspended flag indicates if the clocks are disabled in the suspend
path or not. And this flag is being used to restrict the access to
config space, dbi etc when clock are turned-off.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
Changes since v4:
	- Rebasing the code and removed the supports_system_suspend flag
	- in the resume path as is_suspended will serve its purpose.
Changes since v3:
	- Powering down the phy in suspend and powering it on resume to
	  acheive maximum power savings.
Changes since v2:
	- Replaced the enable, disable clks ops with suspend and resume
	- Renamed support_pm_opsi flag  with supports_system_suspend.
Changes since v1:
	- Fixed compilation errors.
---
---
 drivers/pci/controller/dwc/pcie-qcom.c | 76 ++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ccf6953..9dd50fc0 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -44,6 +44,9 @@
 #define PCIE20_PARF_PM_CTRL			0x20
 #define REQ_NOT_ENTR_L1				BIT(5)
 
+#define PCIE20_PARF_PM_STTS			0x24
+#define PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB	BIT(8)
+
 #define PCIE20_PARF_PHY_CTRL			0x40
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
@@ -211,6 +214,8 @@ struct qcom_pcie_ops {
 	void (*post_deinit)(struct qcom_pcie *pcie);
 	void (*ltssm_enable)(struct qcom_pcie *pcie);
 	int (*config_sid)(struct qcom_pcie *pcie);
+	int (*suspend)(struct qcom_pcie *pcie);
+	int (*resume)(struct qcom_pcie *pcie);
 };
 
 struct qcom_pcie_cfg {
@@ -219,6 +224,7 @@ struct qcom_pcie_cfg {
 	unsigned int has_ddrss_sf_tbu_clk:1;
 	unsigned int has_aggre0_clk:1;
 	unsigned int has_aggre1_clk:1;
+	unsigned int supports_system_suspend:1;
 };
 
 struct qcom_pcie {
@@ -229,6 +235,7 @@ struct qcom_pcie {
 	struct phy *phy;
 	struct gpio_desc *reset;
 	const struct qcom_pcie_cfg *cfg;
+	unsigned int is_suspended:1;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -1297,6 +1304,29 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 }
 
+static int qcom_pcie_resume_2_7_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
+
+	phy_power_on(pcie->phy);
+
+	return ret;
+}
+
+static int qcom_pcie_suspend_2_7_0(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
+
+	phy_power_off(pcie->phy);
+
+	clk_bulk_disable_unprepare(res->num_clks, res->clks);
+
+	return 0;
+}
+
 static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
@@ -1590,6 +1620,8 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 	.config_sid = qcom_pcie_config_sid_sm8250,
+	.suspend = qcom_pcie_suspend_2_7_0,
+	.resume = qcom_pcie_resume_2_7_0,
 };
 
 /* Qcom IP rev.: 2.9.0  Synopsys IP rev.: 5.00a */
@@ -1655,6 +1687,7 @@ static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
 static const struct qcom_pcie_cfg sc7280_cfg = {
 	.ops = &ops_1_9_0,
 	.has_tbu_clk = true,
+	.supports_system_suspend = true,
 };
 
 static const struct qcom_pcie_cfg sc8180x_cfg = {
@@ -1760,6 +1793,48 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int __maybe_unused qcom_pcie_pm_suspend(struct device *dev)
+{
+	struct qcom_pcie *pcie = dev_get_drvdata(dev);
+	u32 val;
+
+	if (!pcie->cfg->supports_system_suspend)
+		return 0;
+
+	/* if the link is not in l1ss don't turn off clocks */
+	val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
+	if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
+		dev_warn(dev, "Link is not in L1ss\n");
+		return 0;
+	}
+
+	if (pcie->cfg->ops->suspend)
+		pcie->cfg->ops->suspend(pcie);
+
+	pcie->is_suspended = true;
+
+	return 0;
+}
+
+static int __maybe_unused qcom_pcie_pm_resume(struct device *dev)
+{
+	struct qcom_pcie *pcie = dev_get_drvdata(dev);
+
+	if (!pcie->is_suspended)
+		return 0;
+
+	if (pcie->cfg->ops->resume)
+		pcie->cfg->ops->resume(pcie);
+
+	pcie->is_suspended = false;
+
+	return 0;
+}
+
+static const struct dev_pm_ops qcom_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_pm_suspend, qcom_pcie_pm_resume)
+};
+
 static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
 	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
@@ -1796,6 +1871,7 @@ static struct platform_driver qcom_pcie_driver = {
 	.probe = qcom_pcie_probe,
 	.driver = {
 		.name = "qcom-pcie",
+		.pm = pm_sleep_ptr(&qcom_pcie_pm_ops),
 		.suppress_bind_attrs = true,
 		.of_match_table = qcom_pcie_match,
 	},
-- 
2.7.4

