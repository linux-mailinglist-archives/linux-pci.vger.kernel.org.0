Return-Path: <linux-pci+bounces-7395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4788E8C35A3
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2024 10:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3DE41F21431
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2024 08:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509582233A;
	Sun, 12 May 2024 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GqtbfN2i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBEA1CAB3;
	Sun, 12 May 2024 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715502567; cv=none; b=HQrpUV0lSOpZ8/5areSRPX8z892sd92UtS4DqTRipLbrKnPTIhCRmvEjmD7G9IZQmZfGhzDAFAis0jCfFNBqzbo3NaBce40OAXtG0MRkexdvNzUPxK7hrt0hXmkdUzGI1DGtO0cPTzWKG21B3jHSk9CWMRI8CHmPP7ldWyN2zww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715502567; c=relaxed/simple;
	bh=dYUZplwverV5VTKW9I1R7h++0uoVsyyr4d/OzXami/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=duTttAE0ua36Z42Ey4RFcg2sLChnLd0Yqdxyg2iQBA5iiPhBDvNRzX+3hz0JXnhbdijtjhUINHvwmIgU2pj8s6Bef/4n5QXaTHM3qI2D4dcT02Yktz2n+oKERAAlcgH3SoeN21qwzFSUAxgX62lhObFwVq7khqXg11eaad5H3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GqtbfN2i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44C7V6a8029552;
	Sun, 12 May 2024 08:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=OrQdzK0
	RegYuAXGmuUV+d4xVb7xMWyR8W55mTERpWCU=; b=GqtbfN2idMDIAQNBN0Cy/Mm
	HfoowBhoXYzBm78lg750EDs63iW20/P7P43IJPW3LJZXmuVcb3+F4GXwb5szeixO
	Jh8HI/t3ao5p5pnDItW7fISUfxab6X2FRS9dUnwMeL0uj27ltqITkp9gDxkgIE4V
	FW00PjngOEbv91duMxXD3Jf+dcu1lxJngPyDZCIrmw9D7NqZZucWffq0OM+Zog0l
	7dUOZ4xH+zvpIYmUh59Zc4UpPI3ITScMRT+XkeVshevjMaJKfBfGY25scUJD92B7
	84RH0iRsQAgFzurR6I/rAUC6EQmPZ0emW/nat+3GSfD0s7gueAvbEUMr2tJw0Eg=
	=
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y200f9j1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 08:29:02 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44C8Sx5Q009796;
	Sun, 12 May 2024 08:28:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3y21rkna3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 08:28:59 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44C8Sxrr009760;
	Sun, 12 May 2024 08:28:59 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-devipriy-blr.qualcomm.com [10.131.37.37])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 44C8SwMw009756
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 08:28:59 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4059087)
	id 13C6C41970; Sun, 12 May 2024 13:58:58 +0530 (+0530)
From: devi priya <quic_devipriy@quicinc.com>
To: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc: quic_devipriy@quicinc.com
Subject: [PATCH V5 2/6] clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
Date: Sun, 12 May 2024 13:58:54 +0530
Message-Id: <20240512082858.1806694-3-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512082858.1806694-1-quic_devipriy@quicinc.com>
References: <20240512082858.1806694-1-quic_devipriy@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S1w_IeEndSfpfwlgC9q8MvBE8BsvTfP2
X-Proofpoint-ORIG-GUID: S1w_IeEndSfpfwlgC9q8MvBE8BsvTfP2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-12_05,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405120063

Add the PCIe pipe clocks needed for enabling PCIe in IPQ9574.

Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: devi priya <quic_devipriy@quicinc.com>
---
 Changes in V5:
	- No changes

 drivers/clk/qcom/gcc-ipq9574.c | 76 ++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index 3738f92c6f9c..7d1b9d2468e6 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -1572,6 +1572,24 @@ static struct clk_regmap_phy_mux pcie0_pipe_clk_src = {
 	},
 };
 
+static struct clk_branch gcc_pcie0_pipe_clk = {
+	.halt_reg = 0x28044,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x28044,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_pcie0_pipe_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&pcie0_pipe_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_regmap_phy_mux pcie1_pipe_clk_src = {
 	.reg = 0x29064,
 	.clkr = {
@@ -1586,6 +1604,24 @@ static struct clk_regmap_phy_mux pcie1_pipe_clk_src = {
 	},
 };
 
+static struct clk_branch gcc_pcie1_pipe_clk = {
+	.halt_reg = 0x29044,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x29044,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_pcie1_pipe_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&pcie1_pipe_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_regmap_phy_mux pcie2_pipe_clk_src = {
 	.reg = 0x2a064,
 	.clkr = {
@@ -1600,6 +1636,24 @@ static struct clk_regmap_phy_mux pcie2_pipe_clk_src = {
 	},
 };
 
+static struct clk_branch gcc_pcie2_pipe_clk = {
+	.halt_reg = 0x2a044,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x2a044,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_pcie2_pipe_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&pcie2_pipe_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_regmap_phy_mux pcie3_pipe_clk_src = {
 	.reg = 0x2b064,
 	.clkr = {
@@ -1614,6 +1668,24 @@ static struct clk_regmap_phy_mux pcie3_pipe_clk_src = {
 	},
 };
 
+static struct clk_branch gcc_pcie3_pipe_clk = {
+	.halt_reg = 0x2b044,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x2b044,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_pcie3_pipe_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&pcie3_pipe_clk_src.clkr.hw
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static const struct freq_tbl ftbl_pcie_rchng_clk_src[] = {
 	F(24000000, P_XO, 1, 0, 0),
 	F(100000000, P_GPLL0, 8, 0, 0),
@@ -4007,9 +4079,13 @@ static struct clk_regmap *gcc_ipq9574_clks[] = {
 	[GCC_PCIE3_AXI_S_BRIDGE_CLK] = &gcc_pcie3_axi_s_bridge_clk.clkr,
 	[GCC_PCIE3_AXI_S_CLK] = &gcc_pcie3_axi_s_clk.clkr,
 	[PCIE0_PIPE_CLK_SRC] = &pcie0_pipe_clk_src.clkr,
+	[GCC_PCIE0_PIPE_CLK] = &gcc_pcie0_pipe_clk.clkr,
 	[PCIE1_PIPE_CLK_SRC] = &pcie1_pipe_clk_src.clkr,
+	[GCC_PCIE1_PIPE_CLK] = &gcc_pcie1_pipe_clk.clkr,
 	[PCIE2_PIPE_CLK_SRC] = &pcie2_pipe_clk_src.clkr,
+	[GCC_PCIE2_PIPE_CLK] = &gcc_pcie2_pipe_clk.clkr,
 	[PCIE3_PIPE_CLK_SRC] = &pcie3_pipe_clk_src.clkr,
+	[GCC_PCIE3_PIPE_CLK] = &gcc_pcie3_pipe_clk.clkr,
 	[PCIE_AUX_CLK_SRC] = &pcie_aux_clk_src.clkr,
 	[GCC_PCIE0_AUX_CLK] = &gcc_pcie0_aux_clk.clkr,
 	[GCC_PCIE1_AUX_CLK] = &gcc_pcie1_aux_clk.clkr,
-- 
2.34.1


