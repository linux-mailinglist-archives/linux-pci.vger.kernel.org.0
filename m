Return-Path: <linux-pci+bounces-33661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C117B1F3F2
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 12:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14678189BE79
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 10:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2CA262FF6;
	Sat,  9 Aug 2025 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YnoH92f3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074D3262FE6
	for <linux-pci@vger.kernel.org>; Sat,  9 Aug 2025 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754733596; cv=none; b=U/yNQCj1IguZkgyxCfGr7iEdEFwNKYtkQRGtEqePmpfi2blBKbSWOA1DYXCzkVbv/MzyRvd6KHt/zgRAIXZJWtwARhv2sSX0CUP3ppgijlkMGNOh0ulRALAvtq+Ejn36QT1Dc5tOj9fFFjVU4pC7HxqWNJ0A8gV/twc9WOC+LHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754733596; c=relaxed/simple;
	bh=1N42w3w6DH/VymcotWPDEfatBEx3romphjTi1yXqqwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=phy78Nmj0pdhZ7oOYcKZRZ6SeR5LUJ3fKn2j7pF9L9V8BX8NGJ3dGwI/NvtNLPC+In24UsnAU5hFsHzQ3eThoI8cpOo8QliOmGsq9AdXjM9eoXmMrzZkHvAgwny2f1WkM6XNt58TgnvbrcApgWPwY5bgCKMOjP9YhK03QntH8+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YnoH92f3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5793ZC9Y013381
	for <linux-pci@vger.kernel.org>; Sat, 9 Aug 2025 09:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pfdvFrrM+5jMDJwt6jwYBWVqnP+7+N88m86azEJqjh8=; b=YnoH92f3WO2xz5sq
	M2lLhaYzDSqkjvkliqEKY21uI3PrD8agmSdLTx2UCfRbKurf8WifIKkx65TsLzoy
	0T8Dcr+886WCRI57u4GTxbamoeQ00pqD6RdtAc//7oBPCI4lCBfj5JIyp2jggviI
	qkCMHlgHiajT0AlunuTj0pygiRpQmlLsJ+Xk82y8vLtknOhj13ZlQINuxtB9xOFQ
	tdAhq1nUdnNIM4qUms/fJRPfSMLCwLzT4ODAcUWF5ysuYRIzV5iCB/W5Kmn5JM1s
	saOXldg6HdJ7wWTFBDWF8OOx2sm57pzJA+Zvfb9tspQou2I/S6/q1uA1iQsXhfBJ
	2a4CCA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxj40e85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 09 Aug 2025 09:59:54 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2400a0ad246so23359485ad.2
        for <linux-pci@vger.kernel.org>; Sat, 09 Aug 2025 02:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754733593; x=1755338393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfdvFrrM+5jMDJwt6jwYBWVqnP+7+N88m86azEJqjh8=;
        b=t86Q0fTEt3Z2dCBf/+QlG0EJ8Jr5t5S/CksmKgAWNx7UIBgEBHLdhz8YAJNEZyNiIe
         YCcBRejwbJJkSKnPC4G9a2VVJXk2YGpKkWgnOjKC/bN5skR09HkSpnuphZcAn0vFcqGk
         ZYlkjyLgVjtpkal3o+d+3OegubzvSgjp8jQg4o0nT8DBG3mzugEs1dRqw+XzI+K+tTZW
         G8Wekh+GgJyvHkPGm+5WIQkq9+TBiaYxVTXbCn1E23Zan8qs8QEoWAP7/qgfvGkXE5M1
         /1TcMHsCIiS1KPtGfHvCh2McnFE5q/gIHCk5yqBoO/cnr21XlpDuleGGGumT+jw2lzdc
         PmpA==
X-Forwarded-Encrypted: i=1; AJvYcCVlazV8IRa9VfyVrXonw2hg7DWyVUJiz/Vcwww4zD7CS/P5EzvkFOz0p1SJrsAmjleYAKY2zjDcAXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+sCecJtekz6XZwS02q5lGVn23J78vOk6M+GF56SHsH5XvEb5d
	/hnNLeVaMgl4arqSZt86Z77VVIacp2boCaVI7oSRt35DrPHRSUw0CwVS1To4K2N/A6DgWiMaM5Q
	w4KiMVCQAci69VoW1diZ5RulzcxPB/UiOKLeHz6HF1HgZ3ox4yFg/h4cqtPybasU=
X-Gm-Gg: ASbGnctqqrKL2NiQlCxksnlyNu0KaoycECQRMdFxY/7vgpFzJj3CVbvesTeaRUJxMg5
	XE25rnWaU2F/uzmifDuGnm6Hn6C18c3yLU9w4kjmBO2qtF2yEEVVNGY0dFnRyaIEJyVVWN3ogHN
	/YyUaHXeQO35ok77IPqIGbjhbCOtDTeRXiKrsTpJmrDpS6iVWzTtdswSqX5cfyK/FctwuAOWK8d
	+j88OhuqVz8fBBzNk1Vm7IWAdwfwlOs+BCcbcNSbb1+9EWtzYrQv2duknKy1yGppFRivqVHKdGE
	etvvWEjeFcK/ZpjQVddRS9vID1nY5yCP8leZHnakHeji+6KdwK5zBKoDjVQxZIEXinzp4mz2gTc
	=
X-Received: by 2002:a17:902:d2c4:b0:240:c962:fc8d with SMTP id d9443c01a7336-242c2003390mr76192475ad.9.1754733593273;
        Sat, 09 Aug 2025 02:59:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0k50RXo2/XRe5WIxd97PyuNrA6Lgia/QnBxamC0wzjqJqGvgSoOb6gGDkyYDDjPA/unZg7A==
X-Received: by 2002:a17:902:d2c4:b0:240:c962:fc8d with SMTP id d9443c01a7336-242c2003390mr76192245ad.9.1754733592815;
        Sat, 09 Aug 2025 02:59:52 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b783sm225962845ad.133.2025.08.09.02.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 02:59:52 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 09 Aug 2025 15:29:17 +0530
Subject: [PATCH 2/4] phy: qcom-qmp-pcie: add dual lane PHY support for
 SM8750
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250809-pakala-v1-2-abf1c416dbaa@oss.qualcomm.com>
References: <20250809-pakala-v1-0-abf1c416dbaa@oss.qualcomm.com>
In-Reply-To: <20250809-pakala-v1-0-abf1c416dbaa@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754733575; l=11213;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=1N42w3w6DH/VymcotWPDEfatBEx3romphjTi1yXqqwA=;
 b=dIj203c04jKKdYvKKPIbduGkRR50HEENnvaYcanwg+Qax9MpH6vkZh3jUmhP/y4c+wOONTJcT
 d+osmmgrtI8AhujzEGIiYuKMv3vetOM54xEcKcd9Vmu4/B7+jt0d73x
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNyBTYWx0ZWRfX6eKigr0DoEsi
 xNtsKWBGVkqjbfdbZX4xmB/BWkkzdU3NRbeDnMYvzzQ0j1D1IFxdDkorLelYQ5cu9SY9J0JCD68
 omnkqYFqaWd3gcebUS9mOg8gp1HP9tQYyWEz5syQDs3mfmoUlK6dxYpCAd2LN0MQ8xfdMwr/NgK
 YV2pL/tssDRrh9+VS9kbA5ObC3Dop4MKw9PRyLTbmx1otrSUAI1CEd6mP9NHwwua4ZcM8JubH4S
 d3xNXkTdMx0piGCbewXFOG4BwYe8q1WNZKvvL3sEkYDJkecA5EXcOXkOBBBiI+CiPD+3vJE0u0y
 vRBUwTnOHzCmNlcEc5gJ+r1i1F/mEBR2CZxY2EXdqxnRvkTgGN9OwuFaawyaL7pYq6wsdFdqMss
 QtjCHhzv
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=68971c1a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=gYF5Rn17l6h1GS1JcBsA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 1wwQDjswcwzt3-hZLO982RkwGonRHDxN
X-Proofpoint-GUID: 1wwQDjswcwzt3-hZLO982RkwGonRHDxN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090027

The PCIe Gen3 x2 PHY for SM8750 uses new phy, add the
required registers and offsets for this phy.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 149 +++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v7.h         |   2 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v7.h    |   4 +-
 3 files changed, 154 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 95830dcfdec9b1f68fd55d1cc3c102985cfafcc1..8fdc146ef73221392371c00afb21d673dbf46d49 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -93,6 +93,13 @@ static const unsigned int pciephy_v6_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_PCS_POWER_DOWN_CONTROL,
 };
 
+static const unsigned int pciephy_v7_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_SW_RESET]			= QPHY_V7_PCS_SW_RESET,
+	[QPHY_START_CTRL]		= QPHY_V7_PCS_START_CONTROL,
+	[QPHY_PCS_STATUS]		= QPHY_V7_PCS_PCS_STATUS1,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V7_PCS_POWER_DOWN_CONTROL,
+};
+
 static const struct qmp_phy_init_tbl msm8998_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
@@ -2590,6 +2597,108 @@ static const struct qmp_phy_init_tbl sm8650_qmp_gen4x2_pcie_rx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B6, 0xff),
 };
 
+static const struct qmp_phy_init_tbl sm8750_qmp_gen3x2_pcie_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_EN_CENTER, 0x1),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_PER1, 0x62),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_PER2, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_STEP_SIZE1_MODE0, 0xf8),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_STEP_SIZE2_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_STEP_SIZE1_MODE1, 0x93),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_STEP_SIZE2_MODE1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_CLK_ENABLE1, 0x90),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SYS_CLK_CTRL, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_PLL_IVCO, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_CP_CTRL_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_CP_CTRL_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SYSCLK_EN_SEL, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_BG_TIMER, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_LOCK_CMP_EN, 0x42),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_LOCK_CMP1_MODE0, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_LOCK_CMP2_MODE0, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_LOCK_CMP1_MODE1, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_LOCK_CMP2_MODE1, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DEC_START_MODE0, 0x41),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DEC_START_MODE1, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START1_MODE0, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START2_MODE0, 0xaa),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START3_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START1_MODE1, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START2_MODE1, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START3_MODE1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_VCO_TUNE_MAP, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_CLK_SELECT, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_HSCLK_SEL_1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_CORECLK_DIV_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_CMN_CONFIG_1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_ADDITIONAL_MISC_3,	0x0F),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_CORE_CLK_EN, 0xA0),
+};
+
+static const struct qmp_phy_init_tbl sm8750_qmp_gen3x2_pcie_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_GM_CAL, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_00_HIGH,	0xBF),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_00_HIGH2, 0xBF),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_00_HIGH3, 0xB7),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_00_HIGH4, 0xEA),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_00_LOW, 0x3F),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_01_HIGH, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_01_HIGH2, 0x49),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_01_HIGH3, 0x1B),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_01_HIGH4, 0x9C),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_01_LOW, 0xD1),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_10_HIGH, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_10_HIGH2, 0x49),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_10_HIGH3, 0x1B),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_10_HIGH4, 0x9C),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_10_LOW, 0xD1),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_TX_ADAPT_PRE_THRESH1, 0x3E),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_TX_ADAPT_PRE_THRESH2, 0x1E),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_TX_ADAPT_POST_THRESH, 0xD2),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_FO_GAIN, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_SO_GAIN, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_SB2_THRESH1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_SB2_THRESH2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_VGA_CAL_CNTRL2, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_SIGDET_ENABLES, 0x1C),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_SIGDET_CNTRL, 0x60),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_IDAC_TSETTLE_LOW, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_SIGDET_CAL_TRIM, 0x08),
+};
+
+static const struct qmp_phy_init_tbl sm8750_qmp_gen3x2_pcie_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V7_TX_LANE_MODE_1,	0x35),
+	QMP_PHY_INIT_CFG(QSERDES_V7_TX_LANE_MODE_3,	0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V7_TX_LANE_MODE_4,	0x31),
+	QMP_PHY_INIT_CFG(QSERDES_V7_TX_LANE_MODE_5,	0x7F),
+	QMP_PHY_INIT_CFG(QSERDES_V7_TX_PI_QEC_CTRL,	0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V7_TX_RES_CODE_LANE_OFFSET_RX, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V7_TX_RES_CODE_LANE_OFFSET_TX, 0x14),
+};
+
+static const struct qmp_phy_init_tbl sm8750_qmp_gen3x2_pcie_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_REFGEN_REQ_CONFIG1, 0x05),
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_RX_SIGDET_LVL, 0x77),
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_RATE_SLEW_CNTRL1, 0x0B),
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_EQ_CONFIG2, 0x0F),
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_PCS_TX_RX_CONFIG, 0x8C),
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_G12S1_TXDEEMPH_M6DB, 0x17),
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_G3S2_PRE_GAIN,	0x2E),
+};
+
+static const struct qmp_phy_init_tbl sm8750_qmp_gen3x2_pcie_pcs_misc_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_PCS_PCIE_EQ_CONFIG1, 0x1E),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_PCS_PCIE_RXEQEVAL_TIME, 0x27),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_PCS_PCIE_POWER_STATE_CONFIG2, 0x1D),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_PCS_PCIE_POWER_STATE_CONFIG4, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xC1),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
+};
+
 static const struct qmp_phy_init_tbl sa8775p_qmp_gen4x2_pcie_serdes_alt_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_IVCO, 0x0f),
@@ -3207,6 +3316,16 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v5_30 = {
 	.rx2		= 0x3a00,
 };
 
+static const struct qmp_pcie_offsets qmp_pcie_offsets_v7 = {
+	.serdes		= 0x0,
+	.pcs		= 0x400,
+	.pcs_misc	= 0x800,
+	.tx		= 0x1000,
+	.rx		= 0x1200,
+	.tx2		= 0x1800,
+	.rx2		= 0x1a00,
+};
+
 static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_20 = {
 	.serdes		= 0x1000,
 	.pcs		= 0x1200,
@@ -3996,6 +4115,33 @@ static const struct qmp_phy_cfg sm8550_qmp_gen3x2_pciephy_cfg = {
 	.phy_status		= PHYSTATUS,
 };
 
+static const struct qmp_phy_cfg sm8750_qmp_gen3x2_pciephy_cfg = {
+	.lanes = 2,
+
+	.offsets		= &qmp_pcie_offsets_v7,
+
+	.tbls = {
+		.serdes		= sm8750_qmp_gen3x2_pcie_serdes_tbl,
+		.serdes_num	= ARRAY_SIZE(sm8750_qmp_gen3x2_pcie_serdes_tbl),
+		.tx		= sm8750_qmp_gen3x2_pcie_tx_tbl,
+		.tx_num		= ARRAY_SIZE(sm8750_qmp_gen3x2_pcie_tx_tbl),
+		.rx		= sm8750_qmp_gen3x2_pcie_rx_tbl,
+		.rx_num		= ARRAY_SIZE(sm8750_qmp_gen3x2_pcie_rx_tbl),
+		.pcs		= sm8750_qmp_gen3x2_pcie_pcs_tbl,
+		.pcs_num	= ARRAY_SIZE(sm8750_qmp_gen3x2_pcie_pcs_tbl),
+		.pcs_misc	= sm8750_qmp_gen3x2_pcie_pcs_misc_tbl,
+		.pcs_misc_num	= ARRAY_SIZE(sm8750_qmp_gen3x2_pcie_pcs_misc_tbl),
+	},
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= pciephy_v7_regs_layout,
+
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS,
+};
+
 static const struct qmp_phy_cfg sm8550_qmp_gen4x2_pciephy_cfg = {
 	.lanes = 2,
 
@@ -5099,6 +5245,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sm8650-qmp-gen4x2-pcie-phy",
 		.data = &sm8650_qmp_gen4x2_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sm8750-qmp-gen3x2-pcie-phy",
+		.data = &sm8750_qmp_gen3x2_pciephy_cfg,
 	}, {
 		.compatible = "qcom,x1e80100-qmp-gen3x2-pcie-phy",
 		.data = &sm8550_qmp_gen3x2_pciephy_cfg,
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v7.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v7.h
index c7759892ed2ea046b372ffac23c3ab75c8015a2b..4b7fcaa6a37458647d03e451ec22dae6337326d1 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v7.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v7.h
@@ -17,6 +17,8 @@
 #define QPHY_V7_PCS_LOCK_DETECT_CONFIG3		0x0cc
 #define QPHY_V7_PCS_LOCK_DETECT_CONFIG6		0x0d8
 #define QPHY_V7_PCS_REFGEN_REQ_CONFIG1		0x0dc
+#define QPHY_V7_PCS_G12S1_TXDEEMPH_M6DB		0x168
+#define QPHY_V7_PCS_G3S2_PRE_GAIN		0x170
 #define QPHY_V7_PCS_RX_SIGDET_LVL		0x188
 #define QPHY_V7_PCS_RCVR_DTCT_DLY_P1U2_L	0x190
 #define QPHY_V7_PCS_RCVR_DTCT_DLY_P1U2_H	0x194
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v7.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v7.h
index 91f865b11347af82c38a33e08bcae7b67a7bec26..6ab943ff57ff666e4f23f4ad0b4eff211c6dbfd0 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v7.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v7.h
@@ -40,6 +40,8 @@
 #define QSERDES_V7_RX_UCDR_SB2_GAIN1				0x54
 #define QSERDES_V7_RX_UCDR_SB2_GAIN2				0x58
 #define QSERDES_V7_RX_AUX_DATA_TCOARSE_TFINE			0x60
+#define QSERDES_V7_RX_TX_ADAPT_PRE_THRESH1			0xc4
+#define QSERDES_V7_RX_TX_ADAPT_PRE_THRESH2			0xc8
 #define QSERDES_V7_RX_TX_ADAPT_POST_THRESH			0xcc
 #define QSERDES_V7_RX_VGA_CAL_CNTRL1				0xd4
 #define QSERDES_V7_RX_VGA_CAL_CNTRL2				0xd8
@@ -50,7 +52,7 @@
 #define QSERDES_V7_RX_RX_IDAC_TSETTLE_LOW			0xf8
 #define QSERDES_V7_RX_RX_IDAC_TSETTLE_HIGH			0xfc
 #define QSERDES_V7_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1		0x110
-#define QSERDES_V7_RX_SIDGET_ENABLES				0x118
+#define QSERDES_V7_RX_SIGDET_ENABLES				0x118
 #define QSERDES_V7_RX_SIGDET_CNTRL				0x11c
 #define QSERDES_V7_RX_SIGDET_DEGLITCH_CNTRL			0x124
 #define QSERDES_V7_RX_RX_MODE_00_LOW				0x15c

-- 
2.34.1


