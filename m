Return-Path: <linux-pci+bounces-30576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE55AE771D
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 08:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D6D1756DB
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 06:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9174A20B80D;
	Wed, 25 Jun 2025 06:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k71nt6aq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB1C1FDA97;
	Wed, 25 Jun 2025 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750833165; cv=none; b=tTP32/J+7nuzW+o228HwPErXCpxXnzUjjVB2IerYdn9nZdhTu1YB9YAdaLJfVVxf/J/47cQIOGCQdS9ff2qeXUUV/JhpU2A0YfAKfXMYs+1Tn+f/TowvN+vzqJ4PVw68TOuy+nI53lwf6G2u5nO4lo1WBuMyknkh6r8wcQVVMPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750833165; c=relaxed/simple;
	bh=gtAp6WeSlStIv1V/WsppRoBiKbn5g5reDI9RXhXniBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a8L8BPhrdzzAic6o2ZWBQAICq1qSHBLiIXpw8uizEkcTvm9A+MtEhZkEDGU+ru1qPT+y7E6fZUdf6xjWfCxoh55SPc6tWsWOMxfKHoljIzlN4rCmdHWJgCvv2Hf17x1b9mDENzxuHv3hMFEy+G7G/2VtMneaH0g5jHTztz8//GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k71nt6aq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P62hLc027443;
	Wed, 25 Jun 2025 06:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=dG9LC2CqmtnoU5NuHCt5mdfIQT77L5SGJ2K
	tfgPs6a8=; b=k71nt6aqXigFX2OdYbqqNOLt9JrEZkyGkEkIqutlM6FgvZ+jHUI
	Pe5Ay1+jGcR3Xp7dpfsglCEdZ05CAQDt1gUmxl/xyyeLmKxKEFMIYR1jaTU40e5U
	yN7t8QlGy6Zbxdz2M7knoGMJ53NtstUoKfG1SlRKlK1WabYVq3Fjr23VhcCmLgpz
	+Juv64kEjyzDANkhP5KrrO3CERa7hgmJ1psdyKU6CzEJSf+/p3HSpIBgo5OWEvDf
	R9ClLC3HTeAg8+wYhltt+A1Hs+WaPfkoeU+Zv+7ycZA6B4yvUTTJeW4p3OyKFaq8
	0F7jhFCFRRMTFxD4TuXrXfAp6duWJueovog==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47esa4r03m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 06:32:30 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 55P6WSKF029374;
	Wed, 25 Jun 2025 06:32:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 47dntma48c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 06:32:28 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55P6WRIQ029359;
	Wed, 25 Jun 2025 06:32:28 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 55P6WRoA029351
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 06:32:27 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 012A4382C; Wed, 25 Jun 2025 14:32:25 +0800 (CST)
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
Subject: [PATCH v6 0/3] pci: qcom: Add QCS615 PCIe support
Date: Wed, 25 Jun 2025 14:32:10 +0800
Message-Id: <20250625063213.1416442-1-quic_ziyuzhan@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=eLYTjGp1 c=1 sm=1 tr=0 ts=685b97fe cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=FMqLFO0IG5DNS-mwCd0A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: PZoVCzt-z7FytgAaE2PujaAjWE2vknZc
X-Proofpoint-ORIG-GUID: PZoVCzt-z7FytgAaE2PujaAjWE2vknZc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA0NyBTYWx0ZWRfX/1TshN1EV7zi
 4OXxffR/hZRM//jXWIw66wbQ1c3JwzJ1JpsTEcwLi3pKTjsYrO8QgxjGI2v8AUjPOGYG97nrgHC
 XBk2PxruirJMJUXTyZ9lPli4vFeK5l03lDF9SyBW8OVv5z54KBv9fSduxsGc0C+a5zhUSkqWToa
 k8GFlja4TCOrHfeLXOJfqPC1YXT/owqAO7oINT7GvKSGCf/MwdFRUldj6f7r8d6ZaKo6JE7nJCq
 yqIoVoJ+IHrCCt7SKSjP1w4IrhlmVzDMFV6nj/eJWMWab8s9JziMd9o7xEbHiDjNkMeFtr5UdJe
 R49u8N0BEje2aCdEvUEg2+vbQYcjqmiiKICThBfOjBwGFhFQc6HQHPf5uURKOmjNGtRcY/xoI8M
 A6/6plo39lBSim0Qg5tAd+Q9v9JATg6TfDMqVO8z0w/Tw61MoxR0Qz2fXC6L54EF8V8slAgv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_01,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=643
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250047

This series adds document, phy, configs support for PCIe in QCS615.

This series depend on the dt-bindings change
https://lore.kernel.org/all/20250521-topic-8150_pcie_drop_clocks-v1-0-3d42e84f6453@oss.qualcomm.com/

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
Have following changes:
	- Add a new Document the QCS615 PCIe Controller
	- Add configurations in devicetree for PCIe, including registers, clocks, interrupts and phy setting sequence.
	- Add configurations in devicetree for PCIe, platform related gpios, PMIC regulators, etc.

Changes in v6:
- Change PCIe equalization setting to one lane
- Add reviewed by tags
- Link to v5: https://lore.kernel.org/all/t6bwkld55a2dcozxz7rxnvdgpjis6oveqzkh4s7nvxgikws4rl@fn2sd7zlabhe/

Changes in v5:
- Drop qcs615-pcie.yaml and use sm8150, as qcs615 is the downgraded
  version of sm8150, which can share the same yaml.
- Drop compatible enrty in driver and use sm8150's enrty (Krzysztof)
- Fix the DT format problem (Konrad)
- Link to v4: https://lore.kernel.org/all/20250507031559.4085159-1-quic_ziyuzhan@quicinc.com/

Changes in v4:
- Fixed compile error found by kernel test robot(Krzysztof)
- Update DT format (Konrad & Krzysztof)
- Remove QCS8550 compatible use QCS615 compatible only (Konrad)
- Update phy dt bindings to fix the dtb check errors.
- Link to v3: https://lore.kernel.org/all/20250310065613.151598-1-quic_ziyuzhan@quicinc.com/

Changes in v3:
- Update qcs615 dt-bindings to fit the qcom-soc.yaml (Krzysztof & Dmitry)
- Removed the driver patch and using fallback method (Mani)
- Update DT format, keep it same with the x1e801000.dtsi (Konrad)
- Update DT commit message (Bojor)
- Link to v2: https://lore.kernel.org/all/20241122023314.1616353-1-quic_ziyuzhan@quicinc.com/

Changes in v2:
- Update commit message for qcs615 phy
- Update qcs615 phy, using lowercase hex
- Removed redundant function
- split the soc dtsi and the platform dts into two changes
- Link to v1: https://lore.kernel.org/all/20241118082619.177201-1-quic_ziyuzhan@quicinc.com/

Krishna chaitanya chundru (2):
  arm64: dts: qcom: qcs615: enable pcie
  arm64: dts: qcom: qcs615-ride: Enable PCIe interface

Ziyue Zhang (1):
  dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
    for QCS615

 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |   2 +-
 arch/arm64/boot/dts/qcom/qcs615-ride.dts      |  42 +++++
 arch/arm64/boot/dts/qcom/qcs615.dtsi          | 145 ++++++++++++++++++
 3 files changed, 188 insertions(+), 1 deletion(-)


base-commit: 5d4809e25903ab8e74034c1f23c787fd26d52934
-- 
2.34.1


