Return-Path: <linux-pci+bounces-38197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40822BDDFDF
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 12:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887DC19C2763
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 10:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4A031DDBD;
	Wed, 15 Oct 2025 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R1F59vJ2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFE931D757
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524074; cv=none; b=H2nitq1rZ0Qhtyj0muglkd+U28k/K98yst7TooP0tHV9eDtdzBAzEB3kUWkVpD35Ce5TPceU2gdiT2K4cZnM76npK55CKp1Ej82D7mCDFt557stFRQlYpJZepHQvD4hVpYNOE2xhVWxu0IAUcM17qoGyniPKJhBaxJRiT606Znc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524074; c=relaxed/simple;
	bh=UD0+HagPVLlzWUDwZRKdbmDniVS8JgRHk8wGYNgYMM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Li3J5G3kYh+n9dtMo7ebok/S5gsr7Cywc3AYX//9QhHFg7ziCFy0k0jHGJ32xWuhGeOugzI/DURDORpVjgEnlUQNR7sYMzFZf8mjB7kpO1Cgs6f9sSwzkHIgMfSKHU9iooVbREKqFStHGJRN0jFd7ZamLyQdYRpK+UTUmuia3rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R1F59vJ2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2smoS005021
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 10:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZvqRobnVL+EM1S4yYHAfLhWvmx/XDIy9zng/ovwtFeM=; b=R1F59vJ2adb6X1Td
	qPJazQeCPv7m81HQrBL+MTJ2jz/UxQ7uIk0giZMKCf5jzQT/pHRgANjhgcgNqTcO
	fj9je+60PzD0jg6jCPae30+IivpMHFCufyzzA7EPZ8s58ndjZM0jwcloqRlG0LYu
	lVBvQw2o9UPAAGGL87yFIAAjLylnN2Fi4+Z04PydO4U/a135gVsMO7OnUc0VA2Uh
	OBYIXIHhv/OXMjexd6ukada/ZN1abCYUHPbzL1ZIEC7VCDh+B59hJXfe1PjRqpag
	S653bNJCQXxk1XBYWAj4klcKemC3AmqJ44v8ItkEaLhlndmiyjNwhjzr00ZZsDdU
	XrUg+A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdg3wwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 10:27:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eddb7e714so9127303a91.1
        for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 03:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760524071; x=1761128871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvqRobnVL+EM1S4yYHAfLhWvmx/XDIy9zng/ovwtFeM=;
        b=nu4wdadgeA4Obo3ZH3YNQuntAmatlCBd0rh4tQE2IJOU7euOdX0pB11RCRr6PS0ONi
         MwFT5HdIfZBK+pZmIenIKnKbV2JCzbVeighFabbkYIzc88gFrZ0TXjRUKkI8FbGLru4z
         WV3yRtXtdTP6/jTGhHGu5ZizQuqrlNrRX9atbFjPTSQXbQIW7RTpV8IQgYtiOJyJnfyy
         wKdaBcdPbNdHmN9CeeQ6S/Zdm6/9z5P1O/uu9ViZAxR1xLCzk7SqiRrkCUjzdPpgKv76
         Q3bb5d9ef0SdaE2avza0V3pKRccXpMkdxW12OtaxJvRoAQCBLw4soc4iN3jNVWD4G4LN
         ffFw==
X-Forwarded-Encrypted: i=1; AJvYcCV8DDJay1rtnxNI2nXQTBiiimCBlSdQYLXEpbk6EG0KQcxUfZLepbswl6+scq+gqTh4kNTXCUoyS74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzozeMNRZcUXUykANcBnNzOeEeNd5x/BtAzBo2Damg+T0GX2oxc
	3I6ImEEk6t4Et4g8yR/NzEYhXA2sU+HccwY5DJ+IO3zeddIQEBrEI2eRkefULxTd2IEcfrNBZsk
	PA6GARfDTiBisMWYqs74/FKmfkkGcmk6RfgAruDhEDBHZ3ni8CNV1/Ep+lBZvFEE=
X-Gm-Gg: ASbGncsn1m3zvi7m/8aMfkGtYF5IZyV8X35xPxV1hWu5WPrm00BO8dO1aae12kwCS1k
	W8HF9eBHcwRgT5G+JYpcjVkOVb6juuMmK9aGtCIWuH6/dJ3vXaVZdeKI6SAm6h3LZbPvDqPRmub
	fDUlYuWkUsAsUjk24n4zu049hnXQvSzduV4AeusjbRVRe12RHUzTCn1ZF6PslVMzy4c/k2HRGRU
	C3dlSu6jBcEAvJnoTvDVZvBz+q6KRF2SQBHa9QRXlvh9omJF5tG1JaOADCsoFwmJLP2BhNrJEj+
	gHd9pGpLAhYvQVakHRDH8AvCKoH0TcqsZw4MJfygmTJ2Znr9sXkdsuEKldrRf+TQFCc+Fo+/jvt
	Tp/MbT/f4egY=
X-Received: by 2002:a17:90b:33d0:b0:338:3789:2e89 with SMTP id 98e67ed59e1d1-33b51117428mr35275118a91.10.1760524070494;
        Wed, 15 Oct 2025 03:27:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEIUwt8ry8GF/UZzYIWnFH7w4xxumx865zk/mV7pQ3v9s5tfY6ECzCVX6vaoGYmfnaMbNHNQ==
X-Received: by 2002:a17:90b:33d0:b0:338:3789:2e89 with SMTP id 98e67ed59e1d1-33b51117428mr35275076a91.10.1760524069888;
        Wed, 15 Oct 2025 03:27:49 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9787a1a7sm1993574a91.18.2025.10.15.03.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 03:27:49 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 03:27:34 -0700
Subject: [PATCH v2 4/6] phy: qcom-qmp: pcs-pcie: Add v8 register offsets
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-kaanapali-pcie-upstream-v2-4-84fa7ea638a1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760524063; l=2155;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=UD0+HagPVLlzWUDwZRKdbmDniVS8JgRHk8wGYNgYMM0=;
 b=zp9TyVP+mYZ8RnVJBIQUAjkqkL7P6Wvku8xYCpBilrwdujS6A+eY1whdjPrBE7kFCAVI2deRd
 j/7ASHrJSfDB0Q3Njyvu57A2Xlht6V3Ls2IWCvQaiM8wfavjZFfAY35
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfX1qXZdKGkt+S/
 HGKToVppYF06jNvi1anDMKCDTUUKxT2nYrjEWztcro7Pl+ibCubG0zHYIH+qzv4wF0WFfonQhj+
 aVYFfXgRBwePDAzkLUg6OvjfyvvbNegWnJo2UMzyrV+J00SV/st6IJVXBipJmZv8Txs+xZcqrfm
 o+YqOQhZteBn9VeKYa9SqePxyRB4j3jVxQmRWB7sED8iZV9lgfRAQJJTkFSCM/c918/lJNYncwS
 cWRpSuBLtW+3SDHrrWeROromfZL9pCw63hRAbY3C9FhRgrivK5tTPcPmxSu+kxV/MpxnUcOyV81
 EY/I8+ewYbceinEH0avEcK3sY2vCcUsbpIrFNjwhyrMH/1XCZLVLHPqOvihZvLXs4xcKrBftLvK
 Asa0zP9Dj+8AsQUb99z3AundtzQOjw==
X-Proofpoint-GUID: OiG13inlXOU9EA56aElo8PAxFsGvOzCl
X-Proofpoint-ORIG-GUID: OiG13inlXOU9EA56aElo8PAxFsGvOzCl
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68ef7727 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=GjIj-kmtzo1uPuhiLq4A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025

Kaanapali SoC uses QMP phy with version v8 for PCIe Gen3 x2. Add the new
PCS PCIE specific offsets in a dedicated header file.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v8.h | 34 +++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v8.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v8.h
new file mode 100644
index 0000000000000000000000000000000000000000..1e06aa9d73d588aacc86fc1b87fb17396de700b8
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v8.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_PCIE_V8_H_
+#define QCOM_PHY_QMP_PCS_PCIE_V8_H_
+
+/* Only for QMP V8 PHY - PCIE PCS registers */
+
+#define QPHY_PCIE_V8_PCS_POWER_STATE_CONFIG2		0x00c
+#define QPHY_PCIE_V8_PCS_TX_RX_CONFIG		0x018
+#define QPHY_PCIE_V8_PCS_ENDPOINT_REFCLK_DRIVE	0x01c
+#define QPHY_PCIE_V8_PCS_OSC_DTCT_ACTIONS		0x090
+#define QPHY_PCIE_V8_PCS_EQ_CONFIG1			0x0a0
+#define QPHY_PCIE_V8_PCS_G3_RXEQEVAL_TIME		0x0f0
+#define QPHY_PCIE_V8_PCS_G4_RXEQEVAL_TIME		0x0f4
+#define QPHY_PCIE_V8_PCS_G4_EQ_CONFIG5		0x108
+#define QPHY_PCIE_V8_PCS_G4_PRE_GAIN			0x15c
+#define QPHY_PCIE_V8_PCS_G12S1_TXDEEMPH_M6DB			0x170
+#define QPHY_PCIE_V8_PCS_G3S2_PRE_GAIN			0x178
+#define QPHY_PCIE_V8_PCS_RX_MARGINING_CONFIG1	0x17c
+#define QPHY_PCIE_V8_PCS_RX_MARGINING_CONFIG3	0x184
+#define QPHY_PCIE_V8_PCS_RX_MARGINING_CONFIG5	0x18c
+#define QPHY_PCIE_V8_PCS_RX_SIGDET_LVL			0x190
+#define QPHY_PCIE_V8_PCS_G3_FOM_EQ_CONFIG5		0x1ac
+#define QPHY_PCIE_V8_PCS_ELECIDLE_DLY_SEL			0x1b8
+#define QPHY_PCIE_V8_PCS_G4_FOM_EQ_CONFIG5		0x1c0
+#define QPHY_PCIE_V8_PCS_POWER_STATE_CONFIG6			0x1d0
+#define QPHY_PCIE_V8_PCS_PCS_TX_RX_CONFIG1			0x1dc
+#define QPHY_PCIE_V8_PCS_PCS_TX_RX_CONFIG2			0x1e0
+#define QPHY_PCIE_V8_PCS_EQ_CONFIG4			0x1f8
+#define QPHY_PCIE_V8_PCS_EQ_CONFIG5			0x1fc
+#endif

-- 
2.34.1


