Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41895B3223
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 10:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiIIIpl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 04:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiIIIpa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 04:45:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEA7D274B;
        Fri,  9 Sep 2022 01:45:26 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2898ZY5L009403;
        Fri, 9 Sep 2022 08:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=/6fPLHSnONAYducfQ952Xu1zQvqb4CFkXKEKfF7ASWY=;
 b=iYOxyuQYnvf1G6F7dDHF9U1iGF+wqr2NnwYThK6G2KKBDm7ThJHjurW9lF+FgSiM9b+R
 3wdMx8NvLSP6ZjA0imC0QcvKVyy5nQpoKCJdOA8fk2irrxtePLH/F1HcAhkbm+nCXGJO
 ojqP6C9cQfE7WbTFkiQdf38lhhMV75ZKI1692nbhARzVR6oH8J12Hhi14Sd/XO574AZD
 nQa9q7kDeSC5ZGGdZaBsSJesK5NyR9pPj8xdf0bJ1Qgbde3HkdbDKGPoK/ZRpi+SFdj6
 5lzHSKTZr9+GcxnRVmICZtGNAf15Il/lxeYH42x6TrVLvPmTyBoC0ce9Yyk9ajyCaCTN cQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfdc745a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 08:45:13 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2898j4E0014219;
        Fri, 9 Sep 2022 08:45:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3jc00m8vpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 09 Sep 2022 08:45:05 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2898j41J014202;
        Fri, 9 Sep 2022 08:45:04 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.37])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 2898j4nD014195;
        Fri, 09 Sep 2022 08:45:04 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 84DAC44A9; Fri,  9 Sep 2022 14:15:03 +0530 (+0530)
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
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v6 1/5] PCI: qcom: Add system suspend and resume support
Date:   Fri,  9 Sep 2022 14:14:40 +0530
Message-Id: <1662713084-8106-2-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1662713084-8106-1-git-send-email-quic_krichai@quicinc.com>
References: <1662713084-8106-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HvJGyZc59trooO64URVaJHI0ncZALaGM
X-Proofpoint-ORIG-GUID: HvJGyZc59trooO64URVaJHI0ncZALaGM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_04,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Add suspend and resume syscore ops.

When system suspends and if the link is in L1ss, disable the clocks
and power down the phy so that system enters into low power state to
save the maximum power. And when the system resumes, enable the clocks
back and power on phy if they are disabled in the suspend path.

we are doing this only when link is in l1ss but not in L2/L3 as
nowhere we are forcing link to L2/L3 by sending PME turn off.

is_suspended flag indicates if the clocks are disabled in the suspend
path or not.

There is access to Ep PCIe space to mask MSI/MSIX after pm suspend ops
(getting hit by affinity changes while making CPUs offline during suspend,
this will happen after devices are suspended (all phases of suspend ops)).
When registered with pm ops there is a crash due to un-clocked access,
as in the pm suspend op clocks are disabled. So, registering with syscore
ops which will called after making CPUs offline.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
changes since v5:
	- Rebasing the code and replaced pm ops with syscore ops as
	  we are getting acciess to pci region after pm ops. syscore ops
	  will called after disabling non boot cpus and there is no pci
	  access after that.
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
 drivers/pci/controller/dwc/pcie-qcom.c | 140 ++++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 39ca06f..6e04d0d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -27,6 +27,7 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/syscore_ops.h>
 
 #include "../../pci.h"
 #include "pcie-designware.h"
@@ -44,6 +45,9 @@
 #define PCIE20_PARF_PM_CTRL			0x20
 #define REQ_NOT_ENTR_L1				BIT(5)
 
+#define PCIE20_PARF_PM_STTS			0x24
+#define PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB	BIT(8)
+
 #define PCIE20_PARF_PHY_CTRL			0x40
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
@@ -122,6 +126,8 @@
 
 #define QCOM_PCIE_CRC8_POLYNOMIAL (BIT(2) | BIT(1) | BIT(0))
 
+static LIST_HEAD(qcom_pcie_list);
+
 struct qcom_pcie_resources_2_1_0 {
 	struct clk_bulk_data clks[QCOM_PCIE_2_1_0_MAX_CLOCKS];
 	struct reset_control *pci_reset;
@@ -211,13 +217,21 @@ struct qcom_pcie_ops {
 	void (*post_deinit)(struct qcom_pcie *pcie);
 	void (*ltssm_enable)(struct qcom_pcie *pcie);
 	int (*config_sid)(struct qcom_pcie *pcie);
+	int (*suspend)(struct qcom_pcie *pcie);
+	int (*resume)(struct qcom_pcie *pcie);
 };
 
 struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
+	/*
+	 * Flag ensures which devices will turn off clks, phy
+	 * in system suspend.
+	 */
+	unsigned int supports_system_suspend:1;
 };
 
 struct qcom_pcie {
+	struct list_head list;	/* list to probed instances */
 	struct dw_pcie *pci;
 	void __iomem *parf;			/* DT parf */
 	void __iomem *elbi;			/* DT elbi */
@@ -225,10 +239,14 @@ struct qcom_pcie {
 	struct phy *phy;
 	struct gpio_desc *reset;
 	const struct qcom_pcie_cfg *cfg;
+	unsigned int is_suspended:1;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
 
+static int __maybe_unused qcom_pcie_syscore_op_suspend(void);
+static void __maybe_unused qcom_pcie_syscore_op_resume(void);
+
 static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
 {
 	gpiod_set_value_cansleep(pcie->reset, 1);
@@ -1301,6 +1319,28 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
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
+	return 0;
+}
+
 static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
@@ -1594,6 +1634,8 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 	.config_sid = qcom_pcie_config_sid_sm8250,
+	.suspend = qcom_pcie_suspend_2_7_0,
+	.resume = qcom_pcie_resume_2_7_0,
 };
 
 /* Qcom IP rev.: 2.9.0  Synopsys IP rev.: 5.00a */
@@ -1613,6 +1655,11 @@ static const struct qcom_pcie_cfg cfg_1_9_0 = {
 	.ops = &ops_1_9_0,
 };
 
+static const struct qcom_pcie_cfg sc7280_cfg = {
+	.ops = &ops_1_9_0,
+	.supports_system_suspend = true,
+};
+
 static const struct qcom_pcie_cfg cfg_2_1_0 = {
 	.ops = &ops_2_1_0,
 };
@@ -1642,6 +1689,23 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = qcom_pcie_start_link,
 };
 
+/*
+ * There is access to Ep PCIe space to mask MSI/MSIX after pm suspend
+ * ops.(getting hit by affinity changes while making CPUs offline during
+ * suspend, this will happen after devices are suspended
+ * (all phases of suspend ops)).
+ *
+ * When registered with pm ops there is a crash due to un-clocked access,
+ * as in the pm suspend op clocks are disabled.
+ *
+ * So, registering with syscore ops which will called after making
+ * CPU's offline.
+ */
+static struct syscore_ops qcom_pcie_syscore_ops = {
+	.suspend = qcom_pcie_syscore_op_suspend,
+	.resume = qcom_pcie_syscore_op_resume,
+};
+
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1720,6 +1784,17 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_phy_exit;
 	}
 
+	/* Register for syscore ops only when first instance probed */
+	if (list_empty(&qcom_pcie_list))
+		register_syscore_ops(&qcom_pcie_syscore_ops);
+
+	/*
+	 * Add the qcom_pcie list of each PCIe instance probed to
+	 * the global list so that we use it iterate through each PCIe
+	 * instance in the syscore ops.
+	 */
+	list_add_tail(&pcie->list, &qcom_pcie_list);
+
 	return 0;
 
 err_phy_exit:
@@ -1731,6 +1806,69 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int __maybe_unused qcom_pcie_pm_suspend(struct qcom_pcie *pcie)
+{
+	u32 val;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+
+	if (!pcie->cfg->supports_system_suspend)
+		return 0;
+
+	/* if the link is not active turn off clocks */
+	if (!dw_pcie_link_up(pci)) {
+		dev_info(dev, "Link is not active\n");
+		goto suspend;
+	}
+
+	/* if the link is not in l1ss don't turn off clocks */
+	val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
+	if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
+		dev_warn(dev, "Link is not in L1ss\n");
+		return 0;
+	}
+
+suspend:
+	if (pcie->cfg->ops->suspend)
+		pcie->cfg->ops->suspend(pcie);
+
+	pcie->is_suspended = true;
+
+	return 0;
+}
+
+static int __maybe_unused qcom_pcie_pm_resume(struct qcom_pcie *pcie)
+{
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
+static int __maybe_unused qcom_pcie_syscore_op_suspend(void)
+{
+	struct qcom_pcie *qcom_pcie;
+
+	list_for_each_entry(qcom_pcie, &qcom_pcie_list, list) {
+		qcom_pcie_pm_suspend(qcom_pcie);
+	}
+	return 0;
+}
+
+static void __maybe_unused qcom_pcie_syscore_op_resume(void)
+{
+	struct qcom_pcie *qcom_pcie;
+
+	list_for_each_entry(qcom_pcie, &qcom_pcie_list, list) {
+		qcom_pcie_pm_resume(qcom_pcie);
+	}
+}
+
 static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
@@ -1742,7 +1880,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
 	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
-	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
 	{ .compatible = "qcom,pcie-sc8180x", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sc8280xp", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sdm845", .data = &cfg_2_7_0 },
-- 
2.7.4

