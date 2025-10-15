Return-Path: <linux-pci+bounces-38196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C1CBDDFD3
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 12:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9A119C23F1
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 10:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217FC31DD86;
	Wed, 15 Oct 2025 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l81r1Uuc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EE731D399
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524073; cv=none; b=SxNZ70TrxhqvWFArHyh8VRPgiU0fy6jWdnO+Qg7NfnDus0JOJeqFAufGSydfLoYW4/ZvHPlpwuLxey5w/FSJ7uRgvcq9x7iFB+9Q9LzXKONb/I3axfbNtoRj0etrO412f2Ik3Y9MPo3hDsmWX/1z3LALUHknVPwwA/iUOFTd1BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524073; c=relaxed/simple;
	bh=oFnKNL4LlT5/93e0cQNiy8Qw+BXY3+8dDZtcph0oAzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Md4l3vJ8tCHjW5v/OvH6XlRvb9hd8+DzLffvsQ6aQv5Z3kIvUOu9+W7ZL1KKWDnnlJiafE/DCPv2EewB85iEJvkEIv+KeizXA2Gqs4wdQ0vDoebjNO24uuubtJ6jJyDRLGOleyWDd2ALjmPOEL7+JsjfcVG5nkWI8t0+NKa0pyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l81r1Uuc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sAvC009192
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 10:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UsypE5wXOc0oAjNZDpo2kWWSLxG6ciEpndDtjgOZ3Wk=; b=l81r1UucvvJX36xz
	UbRAfUvmExI9s1XVG6OwjhKOqBuk9AJABMS6ZiGFphHC8tsiANJDmhBOqeoBas+F
	zkud5uzn9nM3WmxJHRouoMmNvBPcyG9m+I7FDgOCzcdQTIhRliUIVdRO+tBhQYtq
	5uTJ2o8ITol/jbA8m5K5VpBWN0okUjOEtWmzW4nUcrI1YvrxaxI4zriXQrq/YLPn
	xhxh0nwaCg2bq3mqeAYueHqmQMsSaSJOyePg9sMwEh5G2N4GXPALwiZxMxaNiJhh
	ruoCTKkDhHsZxNFT7vm6Dt/Mh7sTJApJ2fVy43a4VnUenlJ1y4NLlG4mXHR4z49b
	BadpVw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0c404p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 10:27:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so10479950a91.3
        for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 03:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760524069; x=1761128869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsypE5wXOc0oAjNZDpo2kWWSLxG6ciEpndDtjgOZ3Wk=;
        b=j34U3pSU/wAWPOZJwXmZGu66PMxriFIxbzYxBgX8OHuZPqz4eflOFeP9oFnS7qYYKB
         5eJD0HdlwujLVpICVNfJziGQO43aTc3eRdAms5TM9zhXLYt7vN6106BeY6yxQSbehkdE
         dZ8cEjuYriLSYRD48FTPX4EPJs4Drxug7EfNK18Ib8TwKnYDVjJ7XSrJPuRIBzIPMDuT
         NQZSrhsM0NaY+RfwBP4zBqdCd1fuUAEPPSWnnYkrv6Xdx9k4iZ4ZVqhDNfVjJVOl8UBq
         QneVB2mFvnJ6gancqYqaPFR7Sr+iW4x3Yl1iTcOVY/JzzRQXYK0W+fiNrKogMeNYdwmr
         P94A==
X-Forwarded-Encrypted: i=1; AJvYcCU8sOlMwQnbVs72hJ0zue8hnGiazWKXZm5izcQoySSqFbSFjk3dFwOjLsORuFjs5VjWpY67UhAEnjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6iyM+iaQbzFKa7Ukm0FUqJG+CwFJ6t5c9P0kEsSRGzfdgvJsD
	7cTchy8SkJGo8M3CrYPHeiaX65MV1PdbVmtsgj60SPgwzUwIiO4lgVniUCq+tiaS1P0CWMolv98
	FljV1j2hEuBZAu7Y57uzLeloY0u3QUDup5g8uAD6hYr3oXbRlDXdECCnhcjiCUv0=
X-Gm-Gg: ASbGncuV6434SrANgsw1GbPQrXHgUsxTsPbP2dxrp17F1dhllonDMHI3t4gRhW9GIF5
	csOry4mHYh++WojEkDb/MuVpNcQ7nSJ8z9DwEeCFCOHSeeZV7OSj/TukvEzR4Lt9sOD1X3r0Kb9
	Rd6MD00ToHNaWQhzUMmLJbWcBojPp4pW0cdMnqAeVFxnuMOetyCu+BgCt0Zb9mz7GZRKNXdBlFw
	AgILmV39x1Ko1Suy7yKoFz9GyWwoRowoLYIe/eSy36Pyzq4ao47sN1IrKi24xWhz5sifOilv9B6
	3l07zH1Bhv8BB8K40He8ZHu8dYccJVz8SZUDoVt4mUjgK5WyyJA1uB81XeMyrTzDNHlFpEElSVo
	D4iZrys2HN7c=
X-Received: by 2002:a17:90b:1651:b0:330:ba05:a799 with SMTP id 98e67ed59e1d1-33b5111708amr42052226a91.16.1760524069024;
        Wed, 15 Oct 2025 03:27:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRFkLffYhJNP7XAH/u0Aq7wHtAEYsMusMRG0+7QAyf2Gp9T9gOYvAM94GZz2D2lqHfrbQ5tQ==
X-Received: by 2002:a17:90b:1651:b0:330:ba05:a799 with SMTP id 98e67ed59e1d1-33b5111708amr42052192a91.16.1760524068469;
        Wed, 15 Oct 2025 03:27:48 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9787a1a7sm1993574a91.18.2025.10.15.03.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 03:27:47 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 03:27:33 -0700
Subject: [PATCH v2 3/6] phy: qcom-qmp: qserdes-txrx: Add complete QMP PCIe
 PHY v8 register offsets
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-kaanapali-pcie-upstream-v2-3-84fa7ea638a1@oss.qualcomm.com>
References: <20251015-kaanapali-pcie-upstream-v2-0-84fa7ea638a1@oss.qualcomm.com>
In-Reply-To: <20251015-kaanapali-pcie-upstream-v2-0-84fa7ea638a1@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760524063; l=4435;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=oFnKNL4LlT5/93e0cQNiy8Qw+BXY3+8dDZtcph0oAzE=;
 b=VxG3wO8sb5ZPOC81rpuJygWhJuojZpFxlbQ9VEBmRmzwFw9u1rCZFRghi7ePU7RjwLoflrg2+
 0PevlZaF4kfBnzV8rWHFr/OPYt/G8NqjTln4UVx+XwSULgApq1eRQ0s
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-GUID: mtUse3IwtfYs5lu_Udq5MwxldlGqOMX2
X-Proofpoint-ORIG-GUID: mtUse3IwtfYs5lu_Udq5MwxldlGqOMX2
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ef7726 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=AMX_CUzcla2ZGstc20cA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfXxKb0GzpnLKhc
 Vojh9NQ7gYe0eq1X9qQp4H5oDBkrRrTcc205F9ZmmFT83UTQIkMmdMhAU4ZvdP80SsFBX4Q9HnD
 1u4aOgL6RM7QnnitSFrCgE0SrZEre7RtR4FDiK3IF19zjp3xW41v3kNByElNfqkpD+N0k/O9HwI
 GDL2vm4Ii85tFer00Fm3IKf5GCcHXc5+GKHtcvkCReocleiIhj+UkViJ94ZlGizXV8K70kBdQLn
 eFywNdcuc/6MMH80s9sd4ALP1JVjuZvWUiMeuPu2+aQXfLUXXWOdlRkMMZgZSBn15ZgO6+fprjz
 04DaeTMB6tRp19hQ/BaBQrlZSylnk3dgWZMXS+U/ohBJ0KwqY7a/xdqhV0nn2ZOQU3iuMyLlRPq
 hrLi9UNwtqVKF4weoRW8zTmRFKmzIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

Kaanapali SoC uses QMP PHY with version v8 for PCIe Gen3 x2, but requires
a completely unique qserdes-txrx register offsets compared to existing v8
offsets.

Hence, add a dedicated header file containing the FULL SET of qserdes-txrx
register definitions required for Kaanapali's PCIe PHY operation.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 .../qualcomm/phy-qcom-qmp-qserdes-txrx-pcie-v8.h   | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-pcie-v8.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-pcie-v8.h
new file mode 100644
index 0000000000000000000000000000000000000000..181846e08c0f053c5cc7dbaa39a1d407ffdcbcdc
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-pcie-v8.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_PCIE_V8_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_PCIE_V8_H_
+
+#define QSERDES_V8_PCIE_TX_RES_CODE_LANE_OFFSET_TX		0x030
+#define QSERDES_V8_PCIE_TX_RES_CODE_LANE_OFFSET_RX		0x034
+#define QSERDES_V8_PCIE_TX_LANE_MODE_1		0x07c
+#define QSERDES_V8_PCIE_TX_LANE_MODE_2		0x080
+#define QSERDES_V8_PCIE_TX_LANE_MODE_3		0x084
+#define QSERDES_V8_PCIE_TX_TRAN_DRVR_EMP_EN		0x0b4
+#define QSERDES_V8_PCIE_TX_TX_BAND0		0x0e0
+#define QSERDES_V8_PCIE_TX_TX_BAND1		0x0e4
+#define QSERDES_V8_PCIE_TX_SEL_10B_8B		0x0f4
+#define QSERDES_V8_PCIE_TX_SEL_20B_10B		0x0f8
+#define QSERDES_V8_PCIE_TX_PARRATE_REC_DETECT_IDLE_EN		0x058
+#define QSERDES_V8_PCIE_TX_TX_ADAPT_POST_THRESH1		0x118
+#define QSERDES_V8_PCIE_TX_TX_ADAPT_POST_THRESH2		0x11c
+#define QSERDES_V8_PCIE_TX_PHPRE_CTRL		0x128
+#define QSERDES_V8_PCIE_TX_EQ_RCF_CTRL_RATE3		0x148
+#define QSERDES_V8_PCIE_TX_EQ_RCF_CTRL_RATE4		0x14c
+
+#define QSERDES_V8_PCIE_RX_UCDR_FO_GAIN_RATE4		0x0dc
+#define QSERDES_V8_PCIE_RX_UCDR_SO_GAIN_RATE3		0x0ec
+#define QSERDES_V8_PCIE_RX_UCDR_SO_GAIN_RATE4		0x0f0
+#define QSERDES_V8_PCIE_RX_UCDR_PI_CONTROLS		0x0f4
+#define QSERDES_V8_PCIE_RX_VGA_CAL_CNTRL1		0x170
+#define QSERDES_V8_PCIE_RX_VGA_CAL_MAN_VAL		0x178
+#define QSERDES_V8_PCIE_RX_RX_EQU_ADAPTOR_CNTRL4		0x1b4
+#define QSERDES_V8_PCIE_RX_SIGDET_ENABLES			0x1d8
+#define QSERDES_V8_PCIE_RX_SIGDET_LVL			0x1e0
+#define QSERDES_V8_PCIE_RX_RXCLK_DIV2_CTRL			0x0b8
+#define QSERDES_V8_PCIE_RX_RX_BAND_CTRL0			0x0bc
+#define QSERDES_V8_PCIE_RX_RX_TERM_BW_CTRL0			0x0c4
+#define QSERDES_V8_PCIE_RX_RX_TERM_BW_CTRL1			0x0c8
+#define QSERDES_V8_PCIE_RX_SVS_MODE_CTRL			0x0b4
+#define QSERDES_V8_PCIE_RX_UCDR_PI_CTRL1			0x058
+#define QSERDES_V8_PCIE_RX_UCDR_PI_CTRL2			0x05c
+#define QSERDES_V8_PCIE_RX_UCDR_SB2_THRESH2_RATE3			0x084
+#define QSERDES_V8_PCIE_RX_UCDR_SB2_GAIN1_RATE3			0x098
+#define QSERDES_V8_PCIE_RX_UCDR_SB2_GAIN2_RATE3			0x0ac
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE_0_1_B0			0x218
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE_0_1_B1			0x21c
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE_0_1_B2			0x220
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE_0_1_B4			0x228
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE_0_1_B7			0x234
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE3_B0			0x260
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE3_B1			0x264
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE3_B2			0x268
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE3_B3			0x26c
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE3_B4			0x270
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B0			0x284
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B1			0x288
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B2			0x28c
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B3			0x290
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B4			0x294
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B5			0x298
+#define QSERDES_V8_PCIE_RX_Q_PI_INTRINSIC_BIAS_RATE32			0x31c
+#define QSERDES_V8_PCIE_RX_Q_PI_INTRINSIC_BIAS_RATE4			0x320
+#define QSERDES_V8_PCIE_RX_EOM_MAX_ERR_LIMIT_LSB			0x11c
+#define QSERDES_V8_PCIE_RX_EOM_MAX_ERR_LIMIT_MSB			0x120
+#define QSERDES_V8_PCIE_RX_AUXDATA_BIN_RATE23			0x108
+#define QSERDES_V8_PCIE_RX_AUXDATA_BIN_RATE4			0x10c
+#define QSERDES_V8_PCIE_RX_VTHRESH_CAL_MAN_VAL_RATE3			0x198
+#define QSERDES_V8_PCIE_RX_VTHRESH_CAL_MAN_VAL_RATE4			0x19c
+#define QSERDES_V8_PCIE_RX_GM_CAL			0x1a0
+
+#endif

-- 
2.34.1


