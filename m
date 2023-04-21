Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503C26EAAF1
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 14:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjDUMvX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 08:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjDUMvH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 08:51:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A71118E4;
        Fri, 21 Apr 2023 05:50:48 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33LCogbj032506;
        Fri, 21 Apr 2023 12:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=SWeXwCj9NOd3M1MtT5aHsg8+bcM5Cm5QfZcHqb6R+jE=;
 b=S5TS1ihUis06sBSoKBNJriMfx/QmqdVtlJB/F/Z63J31QTloN9cJSaD8FVXl7QQ2+21a
 H3YbBAxuGQxo29xUM467+CNkSkVuhQMdiN0NCXBAb51M/2Od2/nnFsUywOi/1R10wEtD
 M2flqCj9phMelZK3UI8KxsndIyaIodM/A/rH4KD9695w0rujsmyNR/RJ8YqmShUWCUSo
 VSl2xbLlcKMknjPsS4jdXrBj06XPyaUFYunRjkjTvNwaF40bpWMX2Alx4DE2vGWX/Jna
 NKUv5hCe0YDq4HXAWcKBu19ScqEE1mY3aQ3BmbVOz3EbutE99+gfN0zlBtz35WZ/RZdR zQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q3cpysndr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 12:50:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33LCofM7022935
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 12:50:41 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 21 Apr 2023 05:50:34 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <mani@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
Subject: [PATCH V3 6/6] PCI: qcom: Add support for IPQ9574
Date:   Fri, 21 Apr 2023 18:19:38 +0530
Message-ID: <20230421124938.21974-7-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230421124938.21974-1-quic_devipriy@quicinc.com>
References: <20230421124938.21974-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: n2GUN3USlJHFBzHd_qo206tQhn3FccU5
X-Proofpoint-ORIG-GUID: n2GUN3USlJHFBzHd_qo206tQhn3FccU5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_05,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304210111
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The IPQ9574 platform has 4 Gen3 PCIe controllers: two single-lane
and two dual-lane based on SNPS core 5.70a
The Qcom IP rev is 1.27.0 and Synopsys IP rev is 5.80a
Added a new compatible 'qcom,pcie-ipq9574' and 'ops_1_27_0'
which reuses all the members of 'ops_2_9_0' except for the post_init
as the SLV_ADDR_SPACE_SIZE configuration differs between 2_9_0
and 1_27_0.
Also, modified get_resources of 'ops 2_9_0' to get the clocks
from the device tree and modelled the post init sequence as
a common function to avoid code redundancy.

Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V3:
	- Rebased on top of linux-next/master

 drivers/pci/controller/dwc/pcie-qcom.c | 61 ++++++++++++++++++--------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 4ab30892f6ef..3682ecdead1f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -107,6 +107,7 @@
 
 /* PARF_SLV_ADDR_SPACE_SIZE register value */
 #define SLV_ADDR_SPACE_SZ			0x10000000
+#define SLV_ADDR_SPACE_SZ_1_27_0		0x08000000
 
 /* PARF_MHI_CLOCK_RESET_CTRL register fields */
 #define AHB_CLK_EN				BIT(0)
@@ -202,10 +203,10 @@ struct qcom_pcie_resources_2_7_0 {
 	struct reset_control *rst;
 };
 
-#define QCOM_PCIE_2_9_0_MAX_CLOCKS		5
 struct qcom_pcie_resources_2_9_0 {
-	struct clk_bulk_data clks[QCOM_PCIE_2_9_0_MAX_CLOCKS];
+	struct clk_bulk_data *clks;
 	struct reset_control *rst;
+	int num_clks;
 };
 
 union qcom_pcie_resources {
@@ -1050,17 +1051,10 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	int ret;
 
-	res->clks[0].id = "iface";
-	res->clks[1].id = "axi_m";
-	res->clks[2].id = "axi_s";
-	res->clks[3].id = "axi_bridge";
-	res->clks[4].id = "rchng";
-
-	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
-	if (ret < 0)
-		return ret;
+	res->num_clks = devm_clk_bulk_get_all(dev, &res->clks);
+	if (res->clks < 0)
+		return res->num_clks;
 
 	res->rst = devm_reset_control_array_get_exclusive(dev);
 	if (IS_ERR(res->rst))
@@ -1073,7 +1067,7 @@ static void qcom_pcie_deinit_2_9_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
+	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 }
 
 static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
@@ -1102,19 +1096,16 @@ static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
 
 	usleep_range(2000, 2500);
 
-	return clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
+	return clk_bulk_prepare_enable(res->num_clks, res->clks);
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
@@ -1151,6 +1142,26 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static int qcom_pcie_post_init_1_27_0(struct qcom_pcie *pcie)
+{
+	writel(SLV_ADDR_SPACE_SZ_1_27_0,
+	       pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
+
+	qcom_pcie_post_init(pcie);
+
+	return 0;
+}
+
+static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
+{
+	writel(SLV_ADDR_SPACE_SZ,
+	       pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
+
+	qcom_pcie_post_init(pcie);
+
+	return 0;
+}
+
 static int qcom_pcie_link_up(struct dw_pcie *pci)
 {
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
@@ -1291,6 +1302,15 @@ static const struct qcom_pcie_ops ops_2_9_0 = {
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
@@ -1323,6 +1343,10 @@ static const struct qcom_pcie_cfg cfg_2_9_0 = {
 	.ops = &ops_2_9_0,
 };
 
+static const struct qcom_pcie_cfg cfg_1_27_0 = {
+	.ops = &ops_1_27_0,
+};
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
@@ -1607,6 +1631,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
 	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
+	{ .compatible = "qcom,pcie-ipq9574", .data = &cfg_1_27_0 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
 	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
-- 
2.17.1

