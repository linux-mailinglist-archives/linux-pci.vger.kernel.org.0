Return-Path: <linux-pci+bounces-939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6379812808
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 07:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B731C210C7
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 06:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC21D26A;
	Thu, 14 Dec 2023 06:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Og9FCSyt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CD619D;
	Wed, 13 Dec 2023 22:29:48 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE5rhmo013695;
	Thu, 14 Dec 2023 06:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=+bJsIiFNHY5aU+4zRAegfGTvThqxKaxMtSO0RkFserM=; b=Og
	9FCSytvlaJqSJJoTEu1qxntQcJUVcxqPyXqefBw2KV3hA3DFCKxlFU7WoFvM8IhI
	/rgYeQEypJci0XKp1aVCCMdXejLSIajBKcfU+V0SwZ+8RdELhrCjKCqQO0khk4IV
	97m43qhZhpdnISu0Xfju5UUg2wZmSXkrghuBuI/rnvD/AEFtRvoEsYdFkwaVoBMk
	uh9WtEspaiLBgV4nvttj8UoPWPsynCyj2noIeHKxTyfsT6xRLEul/0JAKLQKRcY8
	CU/gAyqYKAuRP0/ttmJ0ycNTRTiH70MTM0dCm/R1zNx/5VuN1HEtNcL/vdvHg8yG
	4pA5bfBuqsmalnrnam7w==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyp4xgqfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 06:29:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE6TcpH021107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 06:29:38 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 22:29:31 -0800
From: Praveenkumar I <quic_ipkumar@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <mani@kernel.org>,
        <quic_nsekar@quicinc.com>, <quic_srichara@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-phy@lists.infradead.org>
CC: <quic_varada@quicinc.com>, <quic_devipriy@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>
Subject: [PATCH 04/10] phy: qcom: Add support for Pipe clock rate from device data
Date: Thu, 14 Dec 2023 11:58:41 +0530
Message-ID: <20231214062847.2215542-5-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214062847.2215542-1-quic_ipkumar@quicinc.com>
References: <20231214062847.2215542-1-quic_ipkumar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WPCDI7RAtvN8Ovli654D4dpVh1Nz__FM
X-Proofpoint-ORIG-GUID: WPCDI7RAtvN8Ovli654D4dpVh1Nz__FM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312140039

Qualcomm IPQ5332 has the same PCIe UNIPHY PHY with different pipe
clock rate. Add support to define the pipe clock rate in device
data.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
This patch depends on the below series which adds PCIe support in
Qualcomm IPQ5018
https://lore.kernel.org/all/20231003120846.28626-1-quic_nsekar@quicinc.com/

 drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c b/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
index 5ef6ae7276cf..9f9a03faf6fa 100644
--- a/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
+++ b/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
@@ -54,6 +54,7 @@ struct uniphy_pcie_data {
 	unsigned int phy_type;
 	const struct uniphy_regs *init_seq;
 	unsigned int init_seq_num;
+	unsigned int pipe_clk_rate;
 };
 
 struct qcom_uniphy_pcie {
@@ -117,6 +118,7 @@ static const struct uniphy_pcie_data ipq5018_2x2_data = {
 	.phy_type	= PHY_TYPE_PCIE_GEN2,
 	.init_seq	= ipq5018_regs,
 	.init_seq_num	= ARRAY_SIZE(ipq5018_regs),
+	.pipe_clk_rate	= 125000000,
 };
 
 static void qcom_uniphy_pcie_init(struct qcom_uniphy_pcie *phy)
@@ -232,6 +234,7 @@ static int qcom_uniphy_pcie_get_resources(struct platform_device *pdev,
 static int phy_pipe_clk_register(struct qcom_uniphy_pcie  *phy,
 				 struct device_node *np)
 {
+	const struct uniphy_pcie_data *data = phy->data;
 	struct clk_fixed_rate *fixed;
 	struct clk_init_data init = { };
 	int ret;
@@ -247,7 +250,7 @@ static int phy_pipe_clk_register(struct qcom_uniphy_pcie  *phy,
 		return -ENOMEM;
 
 	init.ops = &clk_fixed_rate_ops;
-	fixed->fixed_rate = 125000000;
+	fixed->fixed_rate = data->pipe_clk_rate;
 	fixed->hw.init = &init;
 
 	ret = devm_clk_hw_register(phy->dev, &fixed->hw);
-- 
2.34.1


