Return-Path: <linux-pci+bounces-13429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA54984357
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 12:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA361C22FC5
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 10:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE0B183CAB;
	Tue, 24 Sep 2024 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gQFuCjaq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199EE17E005;
	Tue, 24 Sep 2024 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172907; cv=none; b=FK6oTwEWE1NQkGmOopmjMzgVvLf2eljLRSFFJelRjZof6iHhhkeGgHTCnBbPuBNApDNP5RH3DKTx2fuphsy5+5lhxV/Hak06TurtAK8NQ6M1DL1KXTf97CnniENH/Pz9pdyLu2wFGvPgE9gOkkAhEny1XbopKQ3JxEUj5SK1GRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172907; c=relaxed/simple;
	bh=A8owFVfPd2K+d1TGMmG7LRyOKkKFB5nJ+ATO3QDs/CI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pd9ukUywisJwVB8/XnJ4vscOIhMMxtF8FDeSbH5FoBpMqfluQ28fjKwGOXwKpxLSu9LpEOwwuehKf8GfWXepy6PSB7qBYFqKCULmEDQTmpjZpQEBS0KjetmQs8khYH38jeD+vRKO0zQ2xU27P8W55kJq5hUupZH0S1RrHQ1qOGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gQFuCjaq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O8nXV6014609;
	Tue, 24 Sep 2024 10:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WS3TQf6T+o6
	90xS/2vtD+gjP2gpZw63WjHBy/yoGNN8=; b=gQFuCjaqdOv8+1C8fuzAE5p95rM
	YKEEOEKM8GrYur1DTq4PC0gWhV85HfLVKx3AfRVufh5Dre/u0gIO7A3p8epliyKr
	virV13rPLxemXV0sziE+n5IdSYj0mrbJgDS/mSx7X6gSFxJExnXzCtVkoUIBbjIN
	c3BdQ/opdlW+iG4OwUwTT8MCc1zHOS9ZT/4QOdl8IB0JXPsuGEEBLxZGjMiazk4/
	Jj+jUXk4HhdiLIQ3hjSE4ivcZFgOWqCwZ+iWXRURNEOawfzXKqL6Dqdg73H/s98k
	UIrI7oA9XzB6vWQJeVEa6yhozyV/UaB0ugNWZkzNe4G/9pRDCj5PmvKafQQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41snfh0cb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 10:14:51 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 48OACg8r002756;
	Tue, 24 Sep 2024 10:14:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 41urt1hx64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 10:14:49 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48OABD0X000463;
	Tue, 24 Sep 2024 10:14:49 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-qianyu-lv.qualcomm.com [10.81.25.114])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 48OAEmCv005471
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 10:14:49 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4098150)
	id D388265F; Tue, 24 Sep 2024 03:14:48 -0700 (PDT)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org,
        robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
        quic_devipriy@quicinc.com
Cc: dmitry.baryshkov@linaro.org, kw@linux.com, lpieralisi@kernel.org,
        neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v4 3/6] phy: qcom: qmp: Add phy register and clk setting for x1e80100 PCIe3
Date: Tue, 24 Sep 2024 03:14:41 -0700
Message-Id: <20240924101444.3933828-4-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
References: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: YB3HCnsr39jXjcSfSj8_x1FeqYOOl3Xp
X-Proofpoint-GUID: YB3HCnsr39jXjcSfSj8_x1FeqYOOl3Xp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409240071

Currently driver supports only x4 lane based functionality using tx/rx and
tx2/rx2 pair of register sets. To support 8 lane functionality with PCIe3,
PCIe3 related QMP PHY provides additional programming which are available
as txz and rxz based register set. Hence adds txz and rxz based registers
usage and programming sequences. Phy register setting for txz and rxz will
be applied to all 8 lanes. Some lanes may have different settings on
several registers than txz/rxz, these registers should be programmed after
txz/rxz programming sequences completing.

Besides, x1e80100 SoC uses QMP phy with version v6.30 for PCIe Gen4 x8.
Add the new register offsets in a dedicated header file.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 211 ++++++++++++++++++
 .../qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h    |  25 +++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h |  19 ++
 3 files changed, 255 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index f71787fb4d7e..d7bbd9df11d7 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -34,6 +34,8 @@
 #include "phy-qcom-qmp-pcs-pcie-v5_20.h"
 #include "phy-qcom-qmp-pcs-pcie-v6.h"
 #include "phy-qcom-qmp-pcs-pcie-v6_20.h"
+#include "phy-qcom-qmp-pcs-pcie-v6_30.h"
+#include "phy-qcom-qmp-pcs-v6_30.h"
 #include "phy-qcom-qmp-pcie-qhp.h"
 
 #define PHY_INIT_COMPLETE_TIMEOUT		10000
@@ -1344,6 +1346,155 @@ static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_G4_FOM_EQ_CONFIG5, 0x8a),
 };
 
+static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x8_pcie_txz_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_RES_CODE_LANE_OFFSET_TX, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_RES_CODE_LANE_OFFSET_RX, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_LANE_MODE_1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_LANE_MODE_2, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_LANE_MODE_3, 0x51),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_TRAN_DRVR_EMP_EN, 0x34),
+};
+
+static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x8_pcie_rxz_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_2, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_SO_GAIN_RATE_2, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_3, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_PI_CONTROLS, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_SO_ACC_DEFAULT_VAL_RATE3, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_IVCM_CAL_CTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_IVCM_POSTCAL_OFFSET, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_BKUP_CTRL1, 0x15),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_DFE_3, 0x45),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_VGA_CAL_MAN_VAL, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_VGA_CAL_CNTRL1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_GM_CAL, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_EQU_ADAPTOR_CNTRL4, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_SIGDET_ENABLES, 0x1c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_PHPRE_CTRL, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_Q_PI_INTRINSIC_BIAS_RATE32, 0x39),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B0, 0xd4),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B1, 0x23),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B2, 0x58),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B3, 0x9a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B4, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B5, 0xb6),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B6, 0xee),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B0, 0x1c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B1, 0xe4),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B2, 0x60),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B3, 0xdf),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B4, 0x69),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B5, 0x76),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B6, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_TX_ADPT_CTRL, 0x10),
+};
+
+static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x8_pcie_rx_tbl[] = {
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_20_RX_DFE_CTLE_POST_CAL_OFFSET, 0x3a, BIT(0)),
+};
+
+static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x8_pcie_ln_shrd_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RXCLK_DIV2_CTRL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_SUMMER_CAL_SPD_MODE, 0x5b),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_DFE_DAC_ENABLE1, 0x88),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_TX_ADAPT_POST_THRESH1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_TX_ADAPT_POST_THRESH2, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B0, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B1, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B2, 0xdb),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B3, 0x9a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B4, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B5, 0xb6),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B6, 0x64),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH1_RATE210, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH1_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH2_RATE210, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH2_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH3_RATE210, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH3_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH4_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH5_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH6_RATE3, 0x1f),
+};
+
+static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x8_pcie_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE1, 0x26),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE1, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORECLK_DIV_MODE1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x68),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE1, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE1, 0xaa),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE0, 0xf8),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CORE_CLK_DIV_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE0, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE0, 0xaa),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BG_TIMER, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER1, 0x62),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER2, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_POST_DIV_MUX, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_BIAS_EN_CLK_BUFLR_EN, 0x1c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CLK_ENABLE1, 0x90),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYS_CLK_CTRL, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_EN_SEL, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x46),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_CFG, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CLK_SELECT, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORE_CLK_EN, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_CONFIG_1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_MISC_1, 0x88),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_MODE, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_VCO_DC_LEVEL_CTRL, 0x0f),
+};
+
+static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x8_pcie_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V6_30_PCS_LOCK_DETECT_CONFIG2, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V6_30_PCS_G3S2_PRE_GAIN, 0x2e),
+	QMP_PHY_INIT_CFG(QPHY_V6_30_PCS_RX_SIGDET_LVL, 0x99),
+	QMP_PHY_INIT_CFG(QPHY_V6_30_PCS_ALIGN_DETECT_CONFIG7, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V6_30_PCS_EQ_CONFIG4, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V6_30_PCS_EQ_CONFIG5, 0x22),
+	QMP_PHY_INIT_CFG(QPHY_V6_30_PCS_TX_RX_CONFIG, 0x04),
+	QMP_PHY_INIT_CFG(QPHY_V6_30_PCS_TX_RX_CONFIG2, 0x02),
+};
+
+static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x8_pcie_pcs_misc_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_ENDPOINT_REFCLK_DRIVE, 0xc1),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_OSC_DTCT_ACTIONS, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_EQ_CONFIG1, 0x16),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_G4_EQ_CONFIG5, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_G4_PRE_GAIN, 0x2e),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_RX_MARGINING_CONFIG1, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_RX_MARGINING_CONFIG3, 0x28),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_RX_MARGINING_CONFIG5, 0x18),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_G3_FOM_EQ_CONFIG5, 0x7a),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_G4_FOM_EQ_CONFIG5, 0x8a),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_G3_RXEQEVAL_TIME, 0x27),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_G4_RXEQEVAL_TIME, 0x27),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_TX_RX_CONFIG, 0xc0),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_POWER_STATE_CONFIG2, 0x1d),
+
+};
+
 static const struct qmp_phy_init_tbl sm8250_qmp_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0x08),
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CLK_SELECT, 0x34),
@@ -2582,6 +2733,8 @@ struct qmp_pcie_offsets {
 	u16 rx;
 	u16 tx2;
 	u16 rx2;
+	u16 txz;
+	u16 rxz;
 	u16 ln_shrd;
 };
 
@@ -2592,6 +2745,10 @@ struct qmp_phy_cfg_tbls {
 	int tx_num;
 	const struct qmp_phy_init_tbl *rx;
 	int rx_num;
+	const struct qmp_phy_init_tbl *txz;
+	int txz_num;
+	const struct qmp_phy_init_tbl *rxz;
+	int rxz_num;
 	const struct qmp_phy_init_tbl *pcs;
 	int pcs_num;
 	const struct qmp_phy_init_tbl *pcs_misc;
@@ -2659,6 +2816,8 @@ struct qmp_pcie {
 	void __iomem *rx;
 	void __iomem *tx2;
 	void __iomem *rx2;
+	void __iomem *txz;
+	void __iomem *rxz;
 	void __iomem *ln_shrd;
 
 	void __iomem *port_b;
@@ -2826,6 +2985,17 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_20 = {
 	.ln_shrd	= 0x0e00,
 };
 
+static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_30 = {
+	.serdes		= 0x8800,
+	.pcs		= 0x9000,
+	.pcs_misc	= 0x9800,
+	.tx		= 0x0000,
+	.rx		= 0x0200,
+	.txz		= 0xe000,
+	.rxz		= 0xe200,
+	.ln_shrd	= 0x8000,
+};
+
 static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
 	.lanes			= 1,
 
@@ -3704,6 +3874,38 @@ static const struct qmp_phy_cfg x1e80100_qmp_gen4x4_pciephy_cfg = {
 	.has_nocsr_reset	= true,
 };
 
+static const struct qmp_phy_cfg x1e80100_qmp_gen4x8_pciephy_cfg = {
+	.lanes = 8,
+
+	.offsets		= &qmp_pcie_offsets_v6_30,
+	.tbls = {
+		.serdes			= x1e80100_qmp_gen4x8_pcie_serdes_tbl,
+		.serdes_num		= ARRAY_SIZE(x1e80100_qmp_gen4x8_pcie_serdes_tbl),
+		.rx			= x1e80100_qmp_gen4x8_pcie_rx_tbl,
+		.rx_num			= ARRAY_SIZE(x1e80100_qmp_gen4x8_pcie_rx_tbl),
+		.pcs			= x1e80100_qmp_gen4x8_pcie_pcs_tbl,
+		.pcs_num		= ARRAY_SIZE(x1e80100_qmp_gen4x8_pcie_pcs_tbl),
+		.pcs_misc		= x1e80100_qmp_gen4x8_pcie_pcs_misc_tbl,
+		.pcs_misc_num		= ARRAY_SIZE(x1e80100_qmp_gen4x8_pcie_pcs_misc_tbl),
+		.ln_shrd		= x1e80100_qmp_gen4x8_pcie_ln_shrd_tbl,
+		.ln_shrd_num		= ARRAY_SIZE(x1e80100_qmp_gen4x8_pcie_ln_shrd_tbl),
+		.txz			= x1e80100_qmp_gen4x8_pcie_txz_tbl,
+		.txz_num		= ARRAY_SIZE(x1e80100_qmp_gen4x8_pcie_txz_tbl),
+		.rxz			= x1e80100_qmp_gen4x8_pcie_rxz_tbl,
+		.rxz_num		= ARRAY_SIZE(x1e80100_qmp_gen4x8_pcie_rxz_tbl),
+	},
+
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= sm8550_qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(sm8550_qmp_phy_vreg_l),
+	.regs			= pciephy_v6_regs_layout,
+
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS_4_20,
+	.has_nocsr_reset	= true,
+};
+
 static void qmp_pcie_init_port_b(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -3751,6 +3953,9 @@ static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_c
 
 	qmp_configure(qmp->dev, serdes, tbls->serdes, tbls->serdes_num);
 
+	qmp_configure(qmp->dev, qmp->txz, tbls->txz, tbls->txz_num);
+	qmp_configure(qmp->dev, qmp->rxz, tbls->rxz, tbls->rxz_num);
+
 	qmp_configure_lane(qmp->dev, tx, tbls->tx, tbls->tx_num, 1);
 	qmp_configure_lane(qmp->dev, rx, tbls->rx, tbls->rx_num, 1);
 
@@ -4293,6 +4498,9 @@ static int qmp_pcie_parse_dt(struct qmp_pcie *qmp)
 			return PTR_ERR(qmp->port_b);
 	}
 
+	qmp->txz = base + offs->txz;
+	qmp->rxz = base + offs->rxz;
+
 	if (cfg->tbls.ln_shrd)
 		qmp->ln_shrd = base + offs->ln_shrd;
 
@@ -4478,6 +4686,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
 	}, {
 		.compatible = "qcom,x1e80100-qmp-gen4x4-pcie-phy",
 		.data = &x1e80100_qmp_gen4x4_pciephy_cfg,
+	}, {
+		.compatible = "qcom,x1e80100-qmp-gen4x8-pcie-phy",
+		.data = &x1e80100_qmp_gen4x8_pciephy_cfg,
 	},
 	{ },
 };
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h
new file mode 100644
index 000000000000..5a58ff197e6e
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_PCIE_V6_30_H_
+#define QCOM_PHY_QMP_PCS_PCIE_V6_30_H_
+
+/* Only for QMP V6_30 PHY - PCIE have different offsets than V6 */
+#define QPHY_PCIE_V6_30_PCS_POWER_STATE_CONFIG2		0x014
+#define QPHY_PCIE_V6_30_PCS_TX_RX_CONFIG		0x020
+#define QPHY_PCIE_V6_30_PCS_ENDPOINT_REFCLK_DRIVE	0x024
+#define QPHY_PCIE_V6_30_PCS_OSC_DTCT_ACTIONS		0x098
+#define QPHY_PCIE_V6_30_PCS_EQ_CONFIG1			0x0a8
+#define QPHY_PCIE_V6_30_PCS_G3_RXEQEVAL_TIME		0x0f8
+#define QPHY_PCIE_V6_30_PCS_G4_RXEQEVAL_TIME		0x0fc
+#define QPHY_PCIE_V6_30_PCS_G4_EQ_CONFIG5		0x110
+#define QPHY_PCIE_V6_30_PCS_G4_PRE_GAIN			0x164
+#define QPHY_PCIE_V6_30_PCS_RX_MARGINING_CONFIG1	0x184
+#define QPHY_PCIE_V6_30_PCS_RX_MARGINING_CONFIG3	0x18c
+#define QPHY_PCIE_V6_30_PCS_RX_MARGINING_CONFIG5	0x194
+#define QPHY_PCIE_V6_30_PCS_G3_FOM_EQ_CONFIG5		0x1b4
+#define QPHY_PCIE_V6_30_PCS_G4_FOM_EQ_CONFIG5		0x1c8
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h
new file mode 100644
index 000000000000..369120d88bc2
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V6_30_H_
+#define QCOM_PHY_QMP_PCS_V6_30_H_
+
+/* Only for QMP V6_30 PHY - PCIe PCS registers */
+#define QPHY_V6_30_PCS_LOCK_DETECT_CONFIG2		0x0cc
+#define QPHY_V6_30_PCS_G3S2_PRE_GAIN			0x17c
+#define QPHY_V6_30_PCS_RX_SIGDET_LVL			0x194
+#define QPHY_V6_30_PCS_ALIGN_DETECT_CONFIG7		0x1dc
+#define QPHY_V6_30_PCS_TX_RX_CONFIG			0x1e0
+#define QPHY_V6_30_PCS_TX_RX_CONFIG2			0x1e4
+#define QPHY_V6_30_PCS_EQ_CONFIG4			0x1fc
+#define QPHY_V6_30_PCS_EQ_CONFIG5			0x200
+
+#endif
-- 
2.34.1


