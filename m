Return-Path: <linux-pci+bounces-39783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A805C1F2A2
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 10:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135411A21339
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 08:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3221A2C21DD;
	Thu, 30 Oct 2025 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n658eDyt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6096531E0F7;
	Thu, 30 Oct 2025 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814408; cv=none; b=NGlpgh8snqPub5XGY+Zru80QOlkIo9fcm9gEeT4D2iCsrtP7PQ3c19vx5CEnXbipVpmKnlzhGq8EVoyUM4QS/eGZGXtEcjO2TqUZXBk6F+jH4K/KiZL8MCvFYFpBFKnt5P6bdIeqT9lsdU4b18VIl1cP2LDBXUw2IAgFnqv2eGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814408; c=relaxed/simple;
	bh=6j5vgNwBIXH6gvDl5iq2317NlBXDxKTvEoExIEpwNlA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FGveI6LG1NflDVTUXWbu1bkv3+qa0RbCEPp3rK/871CtYaYwIYlIKDtULgojPbAaH7kliBKbPLfvIZcouejLQaumyPTCdXmjerB8nt2sdr3SHo7q4+BG89UOpN6XtP//aiZZx3J845oxsIYBkuPoiK0/hUAjfqLKyqjtuAXDbis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n658eDyt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7Yjkj1598878;
	Thu, 30 Oct 2025 08:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=6t+6uWhyy591iuiYgwhisW/rL2lpx2ayTva
	AMRuLfGQ=; b=n658eDytvOrCoDSW6MnyEvIJzRN+uXMsTsuh5oNSW3EO25wS3dx
	gWiEofUmVWV1PSQFjj2IJ378kviy+joJ+EHTH2XW0+J+O+08RjqwTkJ0CZrDYDbK
	tU0pi57EDAizxJSJj0LJxReeTwVTH8s0mgI/xCj91YGtC9W5I8FwnphHzH60BCFT
	7qRmcIxmnPntS7hXzO+oxIwKDM3PVw68adB8g6lQJkiA9ICh2wr/S7YgO74IqCJl
	5w+cnk/2AwnFmzJ2fJez9ppR5RgFijW0ZAluWHYGf396VvWTBxbzqAqEon8djhzJ
	3p3a0POkj64UvORHsIdBrC3GOQ6kgBH13ZQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3ta7ss5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 08:53:15 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U8m8Mq027982;
	Thu, 30 Oct 2025 08:48:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a0qmmec4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 08:48:08 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59U8m8wP027967;
	Thu, 30 Oct 2025 08:48:08 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 59U8m7Ie027964
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 08:48:07 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 10F42780; Thu, 30 Oct 2025 16:48:06 +0800 (CST)
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Subject: [PATCH v2 0/4] Add PCIe3 and PCIe5 support for HAMOA-IOT-EVK board
Date: Thu, 30 Oct 2025 16:48:00 +0800
Message-Id: <20251030084804.1682744-1-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
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
X-Authority-Analysis: v=2.4 cv=aaVsXBot c=1 sm=1 tr=0 ts=6903277b cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=QeMu0tCiC60fgC08giYA:9 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: tBEy9dmEZO1fn0qvzrmEOK2lB2d4RNi3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA3MiBTYWx0ZWRfXzGkp6NWNom4O
 nvtiEmS3Ngw3+ASEh1F9sPh1InDUYpdXEIB9xBT6jOLVSfmbYVgY/k8K3fQXZ/1GA/k5eZN9a8z
 V70bLwJnsM5U5t5kuXQmtVgiiduizkCWVrqfqL5TE5yuasMtvGOqJ+VN1tekISc2Kx35OaJuVwZ
 +o48vRx7rMXhi2bKStoo1IXm/DFGwAZsJw8QnETL7FgIim9LJiVwumWLttNZR6qZc4h+k0j3FUL
 W14uR0BEeUhCZUc9UFYRm782r6MzwLmprd9N+/MISbtkh/OS5jUIhhLYBnBvOw838T1vlJ4p0L3
 8SGg7ER3IDpG02iDRL26Cqs5k7wt3T+OzMyA7OPElkxL8ausfOwV3KVeXVBmyzNdM4yZ+n6ZkA9
 n9Louvn3xK7HveEM1svXIs0Hgh3UOQ==
X-Proofpoint-GUID: tBEy9dmEZO1fn0qvzrmEOK2lB2d4RNi3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300072

This patch series adds support for PCIe3 and PCIe5 on the HAMOA-IOT-EVK
board.

PCIe3 is a Gen4 x8 slot intended for external GPU.
PCIe5 is a Gen3 x2 slot designed for external modem connectivity.

To enable these interfaces, the series introduces the necessary device
tree nodes and associated regulator definitions to ensure proper power
sequencing and functionality.

---
Changes in v2:
- Move PMIC gpio pins to patch set 4 (Krishna)
- Link to v1: https://lore.kernel.org/all/20250922075509.3288419-1-ziyue.zhang@oss.qualcomm.com/

Ziyue Zhang (4):
  arm64: dts: qcom: Add PCIe 5 support for HAMOA-IOT-SOM platform
  arm64: dts: qcom: Add PCIe 5 wwan regulator for HAMOA-IOT-EVK board
  arm64: dts: qcom: Add PCIe 3 support for HAMOA-IOT-SOM platform
  arm64: dts: qcom: Add PCIe 3 regulators for HAMOA-IOT-EVK board

 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts  | 83 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 79 ++++++++++++++++++++
 2 files changed, 162 insertions(+)


base-commit: 131f3d9446a6075192cdd91f197989d98302faa6
-- 
2.34.1


