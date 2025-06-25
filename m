Return-Path: <linux-pci+bounces-30587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC77AE7B20
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 10:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BAD74A0B34
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 08:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F5129A326;
	Wed, 25 Jun 2025 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BOIkopsk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0224289360;
	Wed, 25 Jun 2025 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841906; cv=none; b=nq4vCDSUniNToJwXNiExyajyyQ5syUF7vm5bvaB2tHUr1nDzUw17HdyqlAK+fccMdIJdROusAYzMdgiz2Dom6oRDtf6/nv0vBmepkeytqoBYSpr8V2Qdz1R+NkX8C2PntvsqakevXqgsDUCgs/m9DCaaZdGp6ClwXmI1A+PA8po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841906; c=relaxed/simple;
	bh=a4Ls1V5arfF//DWKewxnCPr1NUFcFwcwoh9ZFVfgtKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YbVMsCqrPEFW1qoneCvPAKkLE76vssCbVPzIW+PJJQOGK6iIVmp4Lwk3eSQkkK8ndN8U3v2dFLuppLqAhE1piXNN0u6HOTsxs1MbR4+vFAtD6WpOGNlQ0AWkxpOhll63dbgO61qTWB5Eelfhqtug9ezMM8yj8SXVzuuhPzMop1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BOIkopsk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P43vmk028706;
	Wed, 25 Jun 2025 08:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=cUFBss15vg4r/nMO0lQfI/Uj5kvxiNFdUC4
	YPlvXVIY=; b=BOIkopskfzovRVQk9V9TJGSMlJU48Idz0+NKqRTRf4R1/C9JTnG
	iuX9yj1CBVEpTF6P5tBVTEVqS5J39g9yS3vlQBVHbD5QC2SlTze32k1kGIVDFGoT
	4MXWADzte16pHu518Cb+Whr1eUNTmxAAreqz0kifuWDoMmdyufLIZ4KUgZQGbvSJ
	f9NXq+5wmCbjYx4UF0w59Tw2ex0vBVHGY8QPY1HfihGFdBJJzCGfuuAnd0oG5E5F
	TrefXMbgpS3OPPoGvFhuJwVsQ8wWsg277eEkx/9XHt0MrrT6ozo7QJ5JWsYNhopa
	OdH/dL1eu4CyTEOWkT2OUPpDny2AV4ISVaw==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47esa4re8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 08:58:07 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 55P8w5YS016611;
	Wed, 25 Jun 2025 08:58:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 47dntmarva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 08:58:05 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55P8w4SH016600;
	Wed, 25 Jun 2025 08:58:04 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 55P8w3D5016594
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 08:58:04 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id D450B382D; Wed, 25 Jun 2025 16:58:02 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
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
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: [PATCH v3 0/3] Add Equalization Settings for 8.0 GT/s and Add PCIe Lane Equalization Preset Properties for 8.0 GT/s and 16.0 GT/s
Date: Wed, 25 Jun 2025 16:57:58 +0800
Message-Id: <20250625085801.526669-1-quic_ziyuzhan@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=eLYTjGp1 c=1 sm=1 tr=0 ts=685bba1f cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=pGW_TeUqoRlRwQqC-JsA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: GS1FB1HBukO8xWgIts4naqn3Drqhjft_
X-Proofpoint-ORIG-GUID: GS1FB1HBukO8xWgIts4naqn3Drqhjft_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA2NiBTYWx0ZWRfX7Cs4P2bugsJI
 MIxzzMJgtWJ5UEdD82skJ9fpDagzAkMVE5NREJyi3Lz7fcbSsYfRl4uP3FukXj3xeagHdaHelpT
 N9LFBXkdkveowqBkoznjj3ecdAmNJqsNdsRdTFCTo1x9jLqZJyQEFZs/r6SjTSt4eiS15BYIUYK
 ySLTj2f2RCvLwmk4WL0KLS3EWj3qhr4sgP0cR4GwzPwF0f/SHmoOVkvzI1S9GKhQ4xUKlyFS9At
 YW+TTi0XX0ixnhKapLq6bb1HVwx6fB+bFJ2SXWgsNHYTWCsIaaPLcV3wCvzeDuhGcBmMcAadjxp
 1POutHzNnSOwWryefvjHnyk20hEzM2qYDjDg+XjH2Pd25ooNvgcCijAWtKsrI129icG4Y0sOp5E
 zm4mA7jqabUMdvAM0+Ae5xixyoKdbX5Epr1Ikm6xcnxYhaNaP6MhhYHsyxqcUsatv9tvpigq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=845
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250066

This series adds add equalization settings for 8.0 GT/s, and add PCIe lane equalization
preset properties for 8.0 GT/s and 16.0 GT/s for sa8775p ride platform, which fix AER
errors.

While equalization settings for 16 GT/s have already been set, this update adds the
required equalization settings for PCIe operating at 8.0 GT/s, including the
configuration of shadow registers, ensuring optimal performance and stability.

The DT change for sa8775p add PCIe lane equalization preset properties for 8 GT/s
and 16 GT/s data rates used in lane equalization procedure.

Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>

Changes in v2:
- Update code in pcie-qcom-common.c make it easier to read. (Neil)
- Fix the compile error.
- Link to v1: https://lore.kernel.org/all/20250604091946.1890602-1-quic_ziyuzhan@quicinc.com

Changes in v3:
- Delte TODO tag and warn print in pcie-qcom-common.c. (Bjorn)
- Refined the commit message for better readability. (Bjorn)
- Link to v2: https://lore.kernel.org/all/20250611100319.464803-1-quic_ziyuzhan@quicinc.com/

Ziyue Zhang (3):
  PCI: qcom: Add equalization settings for 8.0 GT/s
  PCI: qcom: fix macro typo for CURSOR
  arm64: dts: qcom: sa8775p: Add PCIe lane equalization preset
    properties

 arch/arm64/boot/dts/qcom/sa8775p.dtsi         |  6 ++
 drivers/pci/controller/dwc/pcie-designware.h  |  5 +-
 drivers/pci/controller/dwc/pcie-qcom-common.c | 55 +++++++++++--------
 drivers/pci/controller/dwc/pcie-qcom-common.h |  2 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  6 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |  6 +-
 6 files changed, 46 insertions(+), 34 deletions(-)


base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
-- 
2.34.1


