Return-Path: <linux-pci+bounces-34274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE30B2BE14
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A4EB7B4A70
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF58321452;
	Tue, 19 Aug 2025 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QuS7t/vX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165C6320CB9
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597172; cv=none; b=uz1kzVTcBNl+L+eEfOXRBCwfXkup9bucSUQpQYeSSs8KrIC5h+WNmOY57X5vy+jsI2u5hXaHr2qiLm6p6mkj/D4zwVfINoqyfZrlBzkPi//+cRxHBkarqDfzmaIPGiSuAyTWCjXdjpzZfoWoG8WtLmuBIyu5IAVrEgM1abt8Rig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597172; c=relaxed/simple;
	bh=lBG66nnuOJFNmGnwQUg3oad4X8eRl166WJOjEf0Foug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RxKlxohZTpMSPv1/XcNgQCQbLoPL61i/6ybVUOxzX6UkhhcbmdgNOLg5qO2MtjndngUEyS/v8zq/TPsZEVQHoV3ao+x5NvHhPco7v/6mfY1+6qN+sV586v5+hh8uOrTRHlq5nWUqmH/2eyGqyra6YLeL+XciOTp4bE442zpIvTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QuS7t/vX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90fef007332
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 09:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a9i1vfAm82rgoZ9V2Oilt0uKHn0wjU3RD+NnjEoXSuk=; b=QuS7t/vXgtGLzNwE
	DC3D6MiYb8VKZiZ3wqQXlXM+AiOlFqovFF3hCZvtuuYI9z8vGisW9uKuz1kLSbrj
	uuIkHF8ux5xutPFwZ4u8z3W449QOCXXonIDM8sjvgZNHf4huUzGqjeRGV9pjrOro
	on3QJ/jrdNJAafgGPcaIkbkONhAwkxyueFqOsiw/HGCTmxUaS4bAHzYST24FAfa+
	9zdR1cEwDDfkCeEAW2Dngel2nmxx8hw9ETapMn1P6GnWejaHYiIK/taETIG4vvt7
	y3y+kUxtECy1UeghFJSKMWVYl+G7mORbmO1S3lRjINpWAwZJeRZLIFXsAs6foFbq
	mxJa7w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj7483em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 09:52:50 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2e62284dso9403985b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 02:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597169; x=1756201969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9i1vfAm82rgoZ9V2Oilt0uKHn0wjU3RD+NnjEoXSuk=;
        b=IYXdvvVp47QAm0MKiuiQcEEOearEEeVmuRUdhy5VEMjBlDZGUMDFG/9mxRh9VaHSVN
         mti4Q+qcJHlTK9V2Qa0SuDNssqYa0DzCWUYfTI9NnQg9I+jkr9/FeQM2BXU7snMxbYUk
         cSkFi1DUVo4UCCqK7jarrdlR/vqnqDlmqeNcRLAvLpTOsFRChTOWnTDy1LOcxX4o08JY
         yyd5iIVGm+h3p+XeEhufgzpVifi9W18xcMu+xxmw3e92qJxq26YwsaE3+nIOjvrDzFm2
         4YmaYzfKiWI2rCphGyb4gSn7zuiyzxdZ74lQ2gm7dAXb38Ga3uYMaYvi+ZJ5nS1q917v
         c8sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpj8Kqa1Dnylk7bFgbFBQ2WjS8rf1c4e543emyXJYEmyA77rJZY6kvypTsP2W9MT6bQpw9EUEDsd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdfvCUm9dyeL0AQOMS3SGeAONMO/bztDvqiHaZf7f7C0tI09mA
	1ucD9s68ibDvUvNMhXk0TCdY0ozuo9QCUMLcXVlmIPCW9/kFoAAr8oNpkvl0o1ZQbD6SRB/OYK4
	q4YM8D0XB7eSpB6VZdf80HcHBuWBZ2difT8xw4pXbl/wVT5NVKX7AJ0xttfCZQs67ZkgR0k5apw
	==
X-Gm-Gg: ASbGncstIjoRwjIWzowdDVJqcmxOWTQuLSEehRD5kW3AEslUq5bIWjf+YFnmKVeL+fg
	5MwCRCX4ai8JhULXmB5bJULC92WuJmQJ4jXceu2+JD6ZyX/WV7Kze+A1vUAA9AHdbMO/on96BOl
	SBDbKgGzVyZb3sFkON/TyxVXfCZWY2xBTLhA/fUtBwDwkj3WCtO9vKpMLJ2tVH4AGNxF9RjMFR9
	wGwrteAm65uM+GTUe9xP+ElfW0xaMa3Z+WOoAUY41uBvbd2nv7to9AVc75W75FdlnLdinsDJxde
	BHRF/dbYyEdDXkAJ2zrzfvgAieHzuaJpqvJ+8dI0mo3TW4UHlWS81cpxNp/GG/WdfUTVktO2qvU
	h5uIDwN4i0GgzJIo=
X-Received: by 2002:a05:6a00:2d92:b0:749:464a:a77b with SMTP id d2e1a72fcca58-76e8110b9a7mr2657195b3a.18.1755597169337;
        Tue, 19 Aug 2025 02:52:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC4tqs7L+4L2W8YZBIEHDFL+2B641+2LTpEDdlxuZ6UcLQFj7EEmT07mPHXGjmZaa2PlaE2Q==
X-Received: by 2002:a05:6a00:2d92:b0:749:464a:a77b with SMTP id d2e1a72fcca58-76e8110b9a7mr2657160b3a.18.1755597168884;
        Tue, 19 Aug 2025 02:52:48 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f7cf7sm1998291b3a.69.2025.08.19.02.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:52:48 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 02:52:07 -0700
Subject: [PATCH 3/4] phy: qcom-qmp: pcs: Add v8.50 register offsets
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-glymur_pcie5-v1-3-2ea09f83cbb0@oss.qualcomm.com>
References: <20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com>
In-Reply-To: <20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755597163; l=1553;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=CEsoc9Uw7D+NpayVYJqV9+VSyLeR0jKm+hdfLxCWqno=;
 b=cCP3EM2K81GKxTUoliZ2LwnKerOSxnF87MByEs1GnCJZiu7AxmbgjaEIbem8nmuYLGzSaArOY
 cQ8AvnwDpmNBgHxgLQRNSvm9/K1VegVkkJVvVVeDJfraMzIcpS0nFam
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Proofpoint-GUID: J3ViiCAoSgD2gloIe4dnSADUr8wFP-0p
X-Proofpoint-ORIG-GUID: J3ViiCAoSgD2gloIe4dnSADUr8wFP-0p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfX1WhTzLKcRKFy
 zO6GXXpTuZylvbqF4nRwJFFfbIGVwW33AYGyXdoARrWGORVZ9t7PSQkaz3FtAgi2nGK9kW02JLf
 S+W/7BXXkDWPdX2N9SBo5zYnRA6lDmPts3lwtZvtiegTf18pz74Bi5ZONnAjz6m8FMed7chsZyH
 Yp9D2pMgEguBd9EtDKPy8Jhxpq0jwPggabvcbFIhHh9syC643AZn91KhXEIPvu/2J2OLNUaENB8
 PljzO+msq/J2ChQHAvsNnD1LcXHr+o/urUjKS+BUaRVwA8apYs2kB+KlCZ9bq4po/lheE91v5NL
 1ch/EGr9pfEG0ebok/T3De86K6tjgNlXyERUx0snli2KjInUWYk+pAD/oXIt/9JccvURpU1ca4+
 O6yLKInr
X-Authority-Analysis: v=2.4 cv=MJtgmNZl c=1 sm=1 tr=0 ts=68a44972 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=MyfKwbsdfMS_-thd9JUA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160033

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

The new Glymur SoC bumps up the HW version of QMP phy to v8.50 for PCIE
g5x4. Add the new PCS offsets in a dedicated header file.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
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


