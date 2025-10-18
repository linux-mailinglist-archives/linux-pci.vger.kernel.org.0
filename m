Return-Path: <linux-pci+bounces-38546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B36C6BEC3CB
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 03:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B19B4258C8
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 01:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DE3221265;
	Sat, 18 Oct 2025 01:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="It2rF1oX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2575D21A449
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 01:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760751235; cv=none; b=qM42n0D+x7Z5peYdwv0w3ecq7MR7GmrBCrjazXBmQHe5FCcIfdDHAuYqIOiq1w4W0l8uekb4BlPoziYDoGRCIyXbdEZjbbfbGWOAonxXlZfD5rwZiFV+QiGWtFXu5BKtsNG+OWUM8MUutETHDqkAqNjn+2aUySMfCnl8zirjwj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760751235; c=relaxed/simple;
	bh=dRqJWz7OIwNnKTzn33y4BQaTa8oSs2p8RyOoVIfWlw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZB0Xl7guPwnNh6FkSYxlwtNHSNTIsa77X/7pceka2ap6Y5eLEcYGoa40DBPk4dUQRUNvCyJJBMuSzhMjNMB/vbRxGRmCrouhu0Yd9DWzNnb5Ui9iYcPvubpIccci3XWmpV5Sb+bOqhAriwU40aArfGLErZbz9n80tKslnsIk2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=It2rF1oX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HJGRsX016989
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 01:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LnqwEheiYw4eMqGgagIbYYTEmFr59FG4+mnaf+XhjEI=; b=It2rF1oX3BLd+TU8
	kyLXZGWIHND7ASt9uuxNpKpZ8T1giFdsKSRKC8aurqKTNe7rwKvPZsKYi4RXVJCg
	LscNR5QKdkAq5lzGhXmy+rrKfPexXmdwuSbIIBJJwq0+0L7J+BuI53MOrsgv/+vF
	y3zHJukGY2LaAwRUxd2fBofswTT0Q+6bi4rxWqfExG0DbjoWDiJZZiD0dNWS9fhK
	pBII8wo4S4wrc4ECnmJyobe109ARn4sWQDX/927a0RXQebgzvB2ceTzDQDb+HLXl
	C+Jmff8EO/Rms7QUv5uLQv+fM2WMnDxzE2RZnnCmvMl00WG4CIW9UL3Jktgn+mpG
	TPl6ZA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdkp5gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 01:33:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b609c0f6522so4567347a12.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 18:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760751230; x=1761356030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnqwEheiYw4eMqGgagIbYYTEmFr59FG4+mnaf+XhjEI=;
        b=TL7X0fXWV3M2KRdVXT3pvKx5LuIqZcyzXxIue9R33OT6iloKE1VgpmkUaEjZhmlBVx
         uNJGu7q/XrTYqhPomHcMARWipt44qGNKt4wJct225a1j9lVUKHlX7lci8vFNz1UGZagV
         ydP32Y+XEguNmDI6NmOAjzPOsBh90b+GVdc9w/qpWa95qHcCpgTe6M5zQgUFgIjGewiK
         XL8bhLqpyIag4cMrKSaTPfYCv0ZCppvEiSLuv3p2Wr8G3RHXsf0bh8WuM63nB0QydRcs
         Pbaqlu/oMfM98qtVHu4NBeiFrThp20nri2SwkBx4Dxv/UQoFsiwO+15JaIiy5QAVS5o2
         qJbg==
X-Forwarded-Encrypted: i=1; AJvYcCV6ROSxwXjGXXwzPfA2hfjTFJ2z8mUHwsbZeezJ5QHn2nfk/6BjjIrJGu0SKljhWPRZJnVv2Y1NmQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiwDHlJEsnLUdYGn0phnQQWE3pQNk6mcaBIumDhu33iGVUWTBY
	V6uffAnc9oo7vq43k4a3s9n5oHcBTOgQ873EaFPSd949Ze5JLroNMXNQoRotarYooIW04SsPlq+
	SHfVvAGI6edCDucNeTeo5w6ZTk6mzQpDASqKprmdFdKxeTxgnPPv4QQQoDPRkNyE=
X-Gm-Gg: ASbGnctxXayGkETsw65jsFQBg4SclpbzaXEfrvNq3nDmtoSP+gR1Hk2dVzioKurbjWA
	CKoD9JzUE+hIS5X3xNpBEjTxNw5NdMbhWD6+s5vxGqOaS9ULxYpcMACEV8M1cGT0WDVZCBHurpV
	BE+x7dnJrdrZTeKXsYsgWyIYdwJefcNk5IUHLGLe3JtQi3dYbF1pAvpB5c00WHEcMBIj74pumQm
	jpwHWtUzOdJ6lVq/4aTS4ITmc1e3H48p5UNlkCWW70if1qth1S1bFCiNd+vwCVjcVDkgWYC6Kaz
	wSIqWsjuk+wC31Y8sZL8rXhE159EuKcsJ+SxHomljeYfYLPepySrHMPFTlQsqXKQyFLDP7vg3rW
	xPuQZj2VGzKpbc5iRRpzhEUvCxzu2ns/zI4lfk9a6SW28dA==
X-Received: by 2002:a17:902:ce12:b0:26b:da03:60db with SMTP id d9443c01a7336-290c9ca6b1cmr72784735ad.13.1760751230573;
        Fri, 17 Oct 2025 18:33:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyqTnRrVLfri2rPa2KLlfbixfUhrUK3J0pAbGviBCAqZVoD1KHQxtnhlTVe79JwMAh+DNsIQ==
X-Received: by 2002:a17:902:ce12:b0:26b:da03:60db with SMTP id d9443c01a7336-290c9ca6b1cmr72784485ad.13.1760751230159;
        Fri, 17 Oct 2025 18:33:50 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5ddf16bcsm791695a91.4.2025.10.17.18.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 18:33:48 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 18:33:41 -0700
Subject: [PATCH v5 4/6] phy: qcom-qmp: pcs: Add v8.50 register offsets
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-glymur_pcie-v5-4-82d0c4bd402b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760751221; l=1673;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=229Z+uA9EBUjxLvNJs5f/sN8K/iZsIa19KeM+KZknsc=;
 b=FMk3XJnpt5L5oYFyTSeIgwj4netRzGwWjSHT7VYRPORe2EsVKTIv45z1fdtp+YHxJZXiYEfIt
 o7Izq7Q8MQVA3O4tO25fm5D025He4SOrT2R0UiSf7mQ4ss04x+4OsSF
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-ORIG-GUID: QDRMlSZNQzCkqrFxMV03bKfvt1YxcsuK
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68f2ee7f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=MyfKwbsdfMS_-thd9JUA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: QDRMlSZNQzCkqrFxMV03bKfvt1YxcsuK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX3LjNXvAg/Qim
 9hoAZr5hqotsbyex3DzoYOMaZQ6InWQ6arvL3ifCCEgAx1zZgVxafmrCjDN2n6c6yQOEh8ioov+
 Kh/vCQuAculuUt30UwPpKfpBxXVz6yvxrjr3PdeewfFRsgHHeiLmU8q3bG62AxF7WqZU05m17jU
 05p9qK96C2unhF/Vt5oVWJM4x4TVatZuNVlixSZCYPILuqYINDpIBjnWDE5iN8xEgoirC8YNkxh
 +OdpAC/nHPkW7coV6cUxMvfzE7e+1LoAOGIzmbxjaEI7Gkx8RIoPF1TTr0a3NBcfK3K8OSgP9gB
 yPo3rIp032IpPWNjDIvbk5WKKRaY2YesbWk7ZT6FGhVOwWgEqiDoftLGQCIkcENHTeh1u73Vf+v
 LbpZoF0LjLK9X4YxVnAg1GOMVHR3xw==
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

The new Glymur SoC bumps up the HW version of QMP phy to v8.50 for PCIE
g5x4. Add the new PCS offsets in a dedicated header file.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8_50.h | 13 +++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8_50.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8_50.h
new file mode 100644
index 0000000000000000000000000000000000000000..325c127e8eb7ad842018dce51d09a6ee54ed86ff
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8_50.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V8_50_H_
+#define QCOM_PHY_QMP_PCS_V8_50_H_
+
+#define QPHY_V8_50_PCS_STATUS1			0x010
+#define QPHY_V8_50_PCS_START_CONTROL			0x05c
+#define QPHY_V8_50_PCS_POWER_DOWN_CONTROL			0x64
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index f58c82b2dd23e1bda616d67ab7993794b997063b..da2a7ad2cdccef1308a2b7aa71a2e5cf8bd7c1d7 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -58,6 +58,8 @@
 
 #include "phy-qcom-qmp-pcs-v8.h"
 
+#include "phy-qcom-qmp-pcs-v8_50.h"
+
 /* QPHY_SW_RESET bit */
 #define SW_RESET				BIT(0)
 /* QPHY_POWER_DOWN_CONTROL */

-- 
2.34.1


