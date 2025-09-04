Return-Path: <linux-pci+bounces-35429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7271B4324D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 08:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538001C22BB9
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 06:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D8D271475;
	Thu,  4 Sep 2025 06:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iScYLWIC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D193A26E70C
	for <linux-pci@vger.kernel.org>; Thu,  4 Sep 2025 06:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967003; cv=none; b=eVDsbwU+0WF5idX+roG6zUS+UzCku2qW0Bk+D4PTC87KtPvlLaEHLjBVrwUCDES3Q3spoj6XK7JX541hoXuz6T0pJFt5+ms+X2h7t4dUr7o5Q3QgZpZn4Xc+XTwIpe6af7FDsob9qkK1zCJ8uh5ewsWA5Mb3Rgdz/gQv56FapRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967003; c=relaxed/simple;
	bh=wLHX/edGylOks4bBIcp7t2+Ibr+czy8bMk8mFVTI4wY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ADcy0GahKeMb2VBVo/rr59CUMa2IUkNBFIpM4VT5SFhwsFU+vHoNR6W8CsOyKc4AoIe+jLiudpZhKo5v7BWQN31Mf6q9pYcF938PJ+51R+wghOIVeBuCYeuRybJnUeBFzAUcuATeuwK4+vJf/nQ6xco/cllcgKYmS6ttbRCCASc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iScYLWIC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5841mNws004991
	for <linux-pci@vger.kernel.org>; Thu, 4 Sep 2025 06:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EQ8qWf1BjUWyH0kwW3Y/Fg9kx15qSwsugIaZ01MX7o4=; b=iScYLWICqKylT/0k
	+Tan3MOfV0oRkU5E5JOJ77OZcfUMUN4l8MK7uW1ehAofakPzmZslyZM0oaIP9wFt
	AyE/5xnsoUH045SmB+sQ7QZuOat6g4hhNowJHnXIbEl4FndZuJr02ty5i+ZEGPNL
	1FQT1dDBS0mHHIrbraFsCeGGmR+kwycFDlL8/nGjObWVFbBJdEQ/hN4z6IgmGZ0e
	UmUxIghWEu/3GGjPnEoL/i9US5UsEFnS5/kaa4444X4GkhMYSMne9qz2qjb6E3Wr
	Edh2oZdeTZ+NhtVSl6R8VT5GclKDvdPczA3mWsVIC5Nq2VX7zuktpYxVh3x5NjOL
	8QNLQg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s6fcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 04 Sep 2025 06:23:20 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-772299b3405so1219596b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 03 Sep 2025 23:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756967000; x=1757571800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQ8qWf1BjUWyH0kwW3Y/Fg9kx15qSwsugIaZ01MX7o4=;
        b=pJq7o/9OLRuj1uboPec67HyHc2O87QWXHt2ZA1oTFztHxIwXmIMxZPwwHacHubsDKP
         hl+thSbVxiIl7iz0chIlQ+FBXQLf9k37DcUStlTQx7pq7W3F+3XV5ShcrkgHfHJQwhRN
         F5pi8x+N41S+HwM7fHV6HCn1M212cYUcSdcXwy8aIBbQR4+AqafxfXn47V8hIUK3GTl8
         BSFarvgQMCtzUlITLfFwI51M56sgWHGvhRSzFrQHiGksDu95TNl4hFGblOHo/YMM+P3+
         SjFy9NYGSZMRVu2bWkcJJpStDwftJKYtXTKYgPGfOWmOqmQk7eRmMaWFeAxnmX2aP/0G
         Qhcg==
X-Forwarded-Encrypted: i=1; AJvYcCWdbAmPCPZL6VfksAjRcRw37dq2EfhgzzlnMpEKoKtTzqKyVyua60px1haR9JyiY6slRx56VpL8N+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjtp9qpB6nffHYXu0fSKy5z2A7gytERBl4KinrV0EBdnEs7HO7
	/2KVmDYaSau1L/FdLEkpFB+Mbaa4izINfblN8q45agbN2QVXjK7/gS+FNmP7dPlvO5zbCrWE/FL
	AXJJ5EldGfZsbV37hlBzCAW7BLdMhCKYY2P3crEyx3XvM+jqqNgiTmK7PDrPgzi8=
X-Gm-Gg: ASbGncvacX//fSkZe7fLjQ84boX66oTlFYlathPLg79fVPWt906do5IYHyBvb6j0/Wk
	TbBGziuPxC0/d/qLZDKkurpEs+0NYfT0eHvgXTdG6RRcFYoa8G0Ipkw/4DukKAtLcB43EQaTJwE
	MFvCquP5fUX/1b4Md5Gstu06otCCl6vjVBNiYbHs/XUhqexsn8/1BGNnzObT82C9jwhas53DSGR
	K3O+7s2dBzmZ8yUysXui5Ydrd2vRnAbn0LU32rS8HtcphVyozrOUNIMgEWsySRZqlT0OVdzMN9b
	21n1q6knJbSAi9jbGST2y7BdilBXAqArtjGwS+nFHxeWGi8l7Vu+KTNkWXo3TefN4sRekixcYYU
	ewPfY5P50zMhYdf4=
X-Received: by 2002:a05:6a00:23c1:b0:772:750f:4e2a with SMTP id d2e1a72fcca58-772750f515cmr9977005b3a.31.1756966999911;
        Wed, 03 Sep 2025 23:23:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBEhddvj2BAWEvjtlsg3CzBDQV3zetF21ks8UWuz0syC1AhGFrMTlPaUQXPTXeoVafLZdKSg==
X-Received: by 2002:a05:6a00:23c1:b0:772:750f:4e2a with SMTP id d2e1a72fcca58-772750f515cmr9976967b3a.31.1756966999306;
        Wed, 03 Sep 2025 23:23:19 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723427c127sm17120911b3a.62.2025.09.03.23.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 23:23:18 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 23:22:04 -0700
Subject: [PATCH v4 3/4] phy: qcom-qmp: pcs: Add v8.50 register offsets
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-glymur_pcie5-v4-3-c187c2d9d3bd@oss.qualcomm.com>
References: <20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com>
In-Reply-To: <20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com>
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
        linux-pci@vger.kernel.org, Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756966993; l=1620;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=xFfJjLvYqUF/UNP8tW/CbteYsphSvzn4abnhCjQHkoU=;
 b=JrgkscigcxP6Od78ufkTo6BeM+OoND0K0nfSNw0w+4/Ge9W17jsil6lRlN7bwDb9l8LBABFGF
 T1Ai0Scegt4CK5AtW/A/B5CNmuS1e8wKqh4v58XzE3zELiuJcb/+W85
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX5rMBhRDd8mXN
 8gYUAUtO29RNnijcF5ghpc62RoZRF/vbyOtNXE9eL7/bz78RVxUwDq7zAEX8g0HUDQXiMxMMA+E
 Ukx6KC9DW5Yqt24UI6l2hPTkARRRyW+Z6htkqvf+SgcnAScaTcVfHswdphqeYrTwgbqyzMV41Rq
 gqY+EaU/GCMiImAswFaC4GaWHvMMAdKKmEdRXC1xvUHaYTBg3yHrOsVocg2Y+/43K8YydY8NwQ2
 XqpVOBkxfxHHG61ho4ue3IF028tqtzaQlEfY37fB3Yfb8qjdjwvMHM3Q5+wS9tfOPjIkgGm9Y/C
 hYTDjbNzWOMR/WqYstKDzunnKjce//qyeOqPrVRXChXwb8JSVsX0zMhcFI95VPYhVsrWygPYTrf
 PH+ykSco
X-Proofpoint-GUID: Ktx8DKByDP88y_i8HGD32-Ti__5Ed2AY
X-Proofpoint-ORIG-GUID: Ktx8DKByDP88y_i8HGD32-Ti__5Ed2AY
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b93058 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=MyfKwbsdfMS_-thd9JUA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

The new Glymur SoC bumps up the HW version of QMP phy to v8.50 for PCIE
g5x4. Add the new PCS offsets in a dedicated header file.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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


