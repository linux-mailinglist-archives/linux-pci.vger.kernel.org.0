Return-Path: <linux-pci+bounces-38547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF06BEC3CE
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 03:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B89423545F4
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 01:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E1E221544;
	Sat, 18 Oct 2025 01:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QSsKepWY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AD01F3B9E
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760751236; cv=none; b=LCtqcbSGJUEinMI6HkXBxbr7zoTJc3ONXB8x/7gr1RgbCEl1XXtQ+GkEqwG41cETKQVdWKIwklXl/OiDcabTnehiebv2cCZ5E5hjjLHQs2nYl/iLPUbuybGchIo05jUnfX2NUm+Nu/h/tIDfY/ZuF0gzliZkWc128W2kZi5k4r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760751236; c=relaxed/simple;
	bh=zt/h1GPrcku6VfCD1Z2xF2fCFX7fT2M31PCFfCnbMWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CD9mXW9E48RP5gcy51+wP0IAIVgiotmDGiymodFv4n8azuW5c+Uuc9anLB6GwR0tWtK55TydBxfbvdhVH0ageWrVlJ88z1jN6J7m3mfGwr4I5ym5Spd8sf0FHK8GwzaTuQvQHvaTgu5YSqnuin9psA5esZfOQwhI0daAOSFJyIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QSsKepWY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HJGcJ1017060
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 01:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	36rRRJsb8die6TTtLLHxpI3oG8UeacOGLRFgDPbnS9E=; b=QSsKepWYbMMQ6FAi
	g7yl1X2c65Ec5QzyGBxMjSuwnc0ZRNY0y7wcNIL9IPQxNEG2sP8jpqECljDqWvZh
	V3lTFP7a0rGBdTpuS1hfre8xYjxJUThid9TE+I7Y0MrGxAbN9GErY7NnLS/lTWGm
	LgslG9XjABVRng26uDsB/ShpXgEIxpf6629ivvfL/BOElmvxDlvwat3aVoXpMrEE
	nhpJ5EhKxH93NidQgSXON5Vx1kRaOkHYAUwSuQxHkrrW+yewo1jibH5EojICGmbG
	LhpcxwB5O/+iMV6V1yVkjY7GnBFN8pKp9KtoNL7pZ8GWD1wJHmaGTU3GjxEC9AAF
	Wq3mGw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdkp5h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 01:33:53 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so2081885a91.2
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 18:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760751232; x=1761356032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36rRRJsb8die6TTtLLHxpI3oG8UeacOGLRFgDPbnS9E=;
        b=wdlqcvpuOc0M7w10zRSIs5ZzUnp7fnIVR8q6+JNXwLzLdGv8mA1QDN75JMMuKB2hUP
         UsGxmoP0DxBJGDwB1yl7BAPVZUp0BGyTLKiL3kCs3l7SW5NcRoeABVewy7j3y4OIv2am
         8lnNBx8NWxPNbJxqgUnLAeytj6oiDH84hV8ppAD85/tD7KG4zYSTDVbZ/26jMoeRHIU9
         KsT3mJFBgMtN+h2rMO8CtNqo3q0MCZSnxQtr6b1Z0FbSoH6bs9dqM9KL2Q0g5KXrxNHg
         EVYdoLHYpAWuFp4ZajNLhitapofboN1AYwAkPnJ3x3xWRxMh27taEHaAY2FLUHpEr9QX
         CFtA==
X-Forwarded-Encrypted: i=1; AJvYcCUcQPevXKRuRf31bMIGXUfGoxHH+FvfPHOjXBlSuSaxpbFoxsTd6mpNcVLs6ICl0SWfWxQp8kQ6gLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1AvezlYij0fSjoRpnR/GyZpsaqriPkAf8lt8aPPGva6slmvlY
	jqxKgcLBVrDJNdxOlcOxNCMUlktJOd1d36weflYhwrAXrt7aJurqhDRpvhGsWf1V4vf9y4mkNZ6
	5BT7+avp9AMGVKZetz0mkEqcgl5zW0S9zSC11nNI9WKLrDxS5Gn3fjV3nwhaRy70=
X-Gm-Gg: ASbGnctSZYxcv0bDArZuKPH2rFLChJI+VKfiAdTt6Am+obgG7pyeBttNKe57gRquUoF
	xSmSHf0BD+1hoT2BLebsNs2wWKfub7XQI/4dYRBBZNwi/xtDpClIZoJQerm0Gjhpe5C4Tlm97sj
	+rgyar+Wow80cSCLG96eGZ6b6nHCBF3UNDI6gdeN3gDZNeunsNSu5WF5HjqG14SGA9J7BLHeHAQ
	7uAIfYaI+D/sEyi7DfGkytV9gJ2Yii8b76XyUSP/6fIms3W4gAgm4Ie9lK62ybUGnW90/mfBWjf
	o6V05ix0OZ8GOMnJWjtt/u1C4rlCIIouTkLhyXnZzTHYrywWhwY3kAeDWmENJb7cXeFwWMhNOAD
	yRbpMNgeVjo8JRDhFz842cU/C+Gr8M0PYMdXGccg4ECLwOw==
X-Received: by 2002:a17:90b:2686:b0:32e:e18a:3691 with SMTP id 98e67ed59e1d1-33bcf919f1fmr7485194a91.35.1760751232055;
        Fri, 17 Oct 2025 18:33:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2fgPD60Q0LounxiHKhoACGn2+QP/TkZujlOtJ/Rvipc7SJrKdnnGI+eNz+ntqIEijuewJXQ==
X-Received: by 2002:a17:90b:2686:b0:32e:e18a:3691 with SMTP id 98e67ed59e1d1-33bcf919f1fmr7485161a91.35.1760751231575;
        Fri, 17 Oct 2025 18:33:51 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5ddf16bcsm791695a91.4.2025.10.17.18.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 18:33:51 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 18:33:42 -0700
Subject: [PATCH v5 5/6] phy: qcom: qmp-pcie: Add support for Glymur PCIe
 Gen5x4 PHY
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-glymur_pcie-v5-5-82d0c4bd402b@oss.qualcomm.com>
References: <20251017-glymur_pcie-v5-0-82d0c4bd402b@oss.qualcomm.com>
In-Reply-To: <20251017-glymur_pcie-v5-0-82d0c4bd402b@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
        Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760751221; l=2929;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=3I4+Hh02UK/6hCXFAJiGGjbIJsRvaSQpVywV9Q7zV1c=;
 b=dKOgcVx4w6ztqfdIQRHnQOd2o6aFzRsanH60UTNwCy92Yge+jRnAAJ0SEKuR8G3sBjmBVOMKr
 rZ9zpNrUYtpD1fRGewkb2hmXQyRE7yq4vYg0tLfkiQp72LU7mZfM/u3
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-ORIG-GUID: V4iOalH5FqI7MK2Rsu0oyZyctuEOTAx8
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68f2ee81 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=cXB1dxBGfnZZ65A63A0A:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: V4iOalH5FqI7MK2Rsu0oyZyctuEOTAx8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX2EZtUJnSMp4o
 0KaXPkdCFHEw68rhilI7xtN1oZ8XbmZTZIjvhYYwauXFQRgIkf8zZznyng1Vs3f/DhLszUV+wPq
 NJRSR4MjWMqYpd4pb8loU+4RcDW446LDRgbiS39AQ5f6mFpyIJSd+luCxGQ+tiD7ERICoqSMmoG
 TBHIrjhqqM4E86M6GvFG6tA3yeb7RNAzpNN77HbBB+njup3si1/oDm0XrM5fHVApel+LI9HixCn
 gWEzuvV3EBJPYovo36bJy//TTU0YAgv+3rvKXLFahEgW0YG1aS6b6kCjx6tYBYF/o16xEjNnEmJ
 ZWvPyF+AHX7k+3CInhYoycHRPa0Y8W8i57S2sGWRZ+WoCZbq8VQwIfkpyj59pA0IgA1eaRz7i/d
 D9ijAfKlVgRuiwdVOSaZaVYEswiwKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

Add support for Gen5 x4 PCIe QMP PHY found on Glymur platform.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 62b1c845b6275d924fa501ac64e69db5f58844aa..86b1b7e2da86a8675e3e48e90b782afb21cafd77 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -100,6 +100,12 @@ static const unsigned int pciephy_v7_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V7_PCS_POWER_DOWN_CONTROL,
 };
 
+static const unsigned int pciephy_v8_50_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_START_CTRL]		= QPHY_V8_50_PCS_START_CONTROL,
+	[QPHY_PCS_STATUS]		= QPHY_V8_50_PCS_STATUS1,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V8_50_PCS_POWER_DOWN_CONTROL,
+};
+
 static const struct qmp_phy_init_tbl msm8998_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
@@ -3072,6 +3078,7 @@ struct qmp_pcie_offsets {
 	u16 rx2;
 	u16 txz;
 	u16 rxz;
+	u16 txrxz;
 	u16 ln_shrd;
 };
 
@@ -3356,6 +3363,12 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_30 = {
 	.ln_shrd	= 0x8000,
 };
 
+static const struct qmp_pcie_offsets qmp_pcie_offsets_v8_50 = {
+	.serdes     = 0x8000,
+	.pcs        = 0x9000,
+	.txrxz      = 0xd000,
+};
+
 static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
 	.lanes			= 1,
 
@@ -4412,6 +4425,22 @@ static const struct qmp_phy_cfg qmp_v6_gen4x4_pciephy_cfg = {
 	.phy_status             = PHYSTATUS_4_20,
 };
 
+static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_cfg = {
+	.lanes = 4,
+
+	.offsets		= &qmp_pcie_offsets_v8_50,
+
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+
+	.regs			= pciephy_v8_50_regs_layout,
+
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS_4_20,
+};
+
 static void qmp_pcie_init_port_b(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -5163,6 +5192,9 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 
 static const struct of_device_id qmp_pcie_of_match_table[] = {
 	{
+		.compatible = "qcom,glymur-qmp-gen5x4-pcie-phy",
+		.data = &glymur_qmp_gen5x4_pciephy_cfg,
+	}, {
 		.compatible = "qcom,ipq6018-qmp-pcie-phy",
 		.data = &ipq6018_pciephy_cfg,
 	}, {

-- 
2.34.1


