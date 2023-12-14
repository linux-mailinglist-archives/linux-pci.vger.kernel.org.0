Return-Path: <linux-pci+bounces-937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0DC812800
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 07:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0946A1C208F4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 06:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502D9D262;
	Thu, 14 Dec 2023 06:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WFEH4GWX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496E3124;
	Wed, 13 Dec 2023 22:29:34 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE4xHAQ021012;
	Thu, 14 Dec 2023 06:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=rl4RrSic2RPILQgcuXsxGN828QIT4dj5tIrRbc9tKS0=; b=WF
	EH4GWXGiOuNM0mEpfhxiynfU9f5S8SEofPRXzrsaigcX6gFD0TqugbZssv7n8xj9
	3BIq3XRXAPjRBRPhW1Wa9OkI5aUInU3quFnoWV+j/EVAo3UdUB+BxCXPrlCvQGLG
	ebzx5HGAlvbqd7+7vZnfNAvXB8WSTPuWzVcv8xjbThrFfXP45G5eAMYXwtx2ijsI
	lRK0g4SrM3TKKXQR5e18CecRIuUY+L6wQVbgE9cRceiHPlETLVNIs4yxD4lPQYBj
	b4QXC5Ewi4dtpX0aU5PXKMCPA4e4TuwcRCQOBUj2PouJw8uE0/Vape8gw7y0XRnf
	oqO0C9T8/rWe4+s+Cw6w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyq9t0k72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 06:29:24 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE6TNPj007129
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 06:29:23 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 22:29:16 -0800
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
Subject: [PATCH 02/10] clk: qcom: ipq5332: Add separate clocks for PCIe and USB for Combo PHY
Date: Thu, 14 Dec 2023 11:58:39 +0530
Message-ID: <20231214062847.2215542-3-quic_ipkumar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: syGSRi-2WLNyPPqr15UhKBZuG0EGVtIQ
X-Proofpoint-GUID: syGSRi-2WLNyPPqr15UhKBZuG0EGVtIQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=953 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312140039

Qualcomm IPQ5332 has a combo PHY for PCIe and USB. Either one of the
interface (PCIe/USB) can use this combo PHY and the PHY drivers are
different for PCIe and USB. Hence separate the PCIe and USB pipe clock
source from DT, and individual driver node can be used as a clock source
separately in the gcc. Add separate enum for PCIe and USB pipe clock and
change the parent in corresponding structures.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq5332.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index f98591148a97..aa0f616c3b1b 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -25,7 +25,8 @@ enum {
 	DT_SLEEP_CLK,
 	DT_PCIE_2LANE_PHY_PIPE_CLK,
 	DT_PCIE_2LANE_PHY_PIPE_CLK_X1,
-	DT_USB_PCIE_WRAPPER_PIPE_CLK,
+	DT_PCIE_WRAPPER_PIPE_CLK,
+	DT_USB_WRAPPER_PIPE_CLK,
 };
 
 enum {
@@ -728,7 +729,7 @@ static struct clk_regmap_phy_mux gcc_pcie3x1_0_pipe_clk_src = {
 		.hw.init = &(struct clk_init_data) {
 			.name = "gcc_pcie3x1_0_pipe_clk_src",
 			.parent_data = &(const struct clk_parent_data) {
-				.index = DT_USB_PCIE_WRAPPER_PIPE_CLK,
+				.index = DT_PCIE_WRAPPER_PIPE_CLK,
 			},
 			.num_parents = 1,
 			.ops = &clk_regmap_phy_mux_ops,
@@ -1072,7 +1073,7 @@ static struct clk_regmap_phy_mux gcc_usb0_pipe_clk_src = {
 		.hw.init = &(struct clk_init_data) {
 			.name = "gcc_usb0_pipe_clk_src",
 			.parent_data = &(const struct clk_parent_data) {
-				.index = DT_USB_PCIE_WRAPPER_PIPE_CLK,
+				.index = DT_USB_WRAPPER_PIPE_CLK,
 			},
 			.num_parents = 1,
 			.ops = &clk_regmap_phy_mux_ops,
-- 
2.34.1


