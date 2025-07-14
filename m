Return-Path: <linux-pci+bounces-32056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A50B0393E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 10:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7EA5171F71
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 08:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC1E23AE96;
	Mon, 14 Jul 2025 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SZ8qf0WM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC3A23AE9B;
	Mon, 14 Jul 2025 08:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481297; cv=none; b=FBSlHHMOA4IOG6Z2NDsEldrorIdkzssEee5IGeoai8hBT/wAOzm0gqSP/xsCCtb5ZSF1oCU5X7SPjnSxVGyLbmfygvdApmT2tlciYKN8UN+4xGaADCNVahUeiTw2DMGJ0BcGuPEZ5hq9JdbGIbDCmlVvEL/Ue9dAA3F1murfk3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481297; c=relaxed/simple;
	bh=1VkO7xULK+N/nYMn+wLvdMFjsHzrdSBE2DniZetY2KI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MaJ93kXR5LUTOOPDYNkl/y8nxktvpPu8c4jMk8tNMnAs2ZjTSbuWeeP54i4JcySTSXDQmYsmTjl3Dc2/SeU7A8aeVsYgRsn3xjczTaAxoQw5A9Hq6sSArmDeUyr6t4ko0FoftYQCLT8Akq71K+ArNrQ4O7fmrtnWeH1g01m6M3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SZ8qf0WM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E0T1sZ025829;
	Mon, 14 Jul 2025 08:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ADf5pVrjdirG7EUXMFRiUUummBBH2qyXZTf
	Cps0NxDQ=; b=SZ8qf0WMP4VXz4rWql3F6p9NJKe+NX9X5xtDmQbda0/2w9WNtLP
	93EL7spO782b66kJJosZQHI3dzXzCwmvxs9/iMCUFF0RLPs6rJPRccsLjuFi/oeW
	eLciVSy1bEwpTcCE6SxtEV52ZHoP4RxG7kCcNfNDArJnNEzfvik0qHTUy8NKH8QZ
	pWorENI4id2uMJEnSC+hMdVDCQyIWGHZjPoTIAQpNpQqGSDWdBRqiRT1fjmCbGZW
	M0NcRXm3CtS1KrB//xEgIvH6RfghDgX70PokfhYFQ/GTLpeb35f537tCNmT2fT0t
	wg+JmblgF8NDeRi1uGVD191MOz4lJ5JtXAQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47v56a2cj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 08:21:16 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56E8Itfu023997;
	Mon, 14 Jul 2025 08:21:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 47ugsm5ydr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 08:21:13 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56E8LDLu027022;
	Mon, 14 Jul 2025 08:21:13 GMT
Received: from cse-cd01-lnx.ap.qualcomm.com (cse-cd01-lnx.qualcomm.com [10.64.75.209])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 56E8LC5f027015
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 08:21:13 +0000
Received: by cse-cd01-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id BC89A20F21; Mon, 14 Jul 2025 16:21:11 +0800 (CST)
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
Subject: [PATCH v4 0/3] Add Equalization Settings for 8.0 GT/s and Add PCIe Lane Equalization Preset Properties for 8.0 GT/s and 16.0 GT/s
Date: Mon, 14 Jul 2025 16:21:07 +0800
Message-Id: <20250714082110.3890821-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: rHKcPduB8Nr6Ynv9CfJ5xsdHnuECvwM-
X-Authority-Analysis: v=2.4 cv=X7BSKHTe c=1 sm=1 tr=0 ts=6874bdfc cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=pGW_TeUqoRlRwQqC-JsA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: rHKcPduB8Nr6Ynv9CfJ5xsdHnuECvwM-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA0OCBTYWx0ZWRfXyXTo0weM1VYX
 x9b6q8jsTg/LdItvKagy32NNy030EPFTAz7dPcWZc/BrK6/RTFrMi9h3+Xa5Kh7ubaA2Qmydtzr
 iUFCt1VtmoudOYIHszqF+7qWRdkPDC82ywwjnMajSx44c8XAzu01IWcR57H+yND2gHe7fG5XXDL
 B8XEX59TTIi87wM03+p54iGcvaJvHYHTjq7GjunVnBSu6L5Y3P/qd8cvmHAksU5DHoIfLmQCAXy
 YGK+CBDgfu8nGOKGPAQA/bY5flbdwgZKuflzFrAtSb8Ufc+bUpBzTCU6AYu4QVgVaadDznZwwDm
 NUyMkf4NH8mBKrcHWK63GOcNGUU9pLb16+b4RaOYimkwZWzFjx7d4yprlEFLHoROuET2XsLG6bJ
 H0NgCQxlsEhVXxEKfB1ZNhVqz1201fmisJ5bc0Y5LRZHZiU1+s74Mu9ZrksFqfIPY4XQd5lS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 mlxlogscore=801 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140048

This series adds add equalization settings for 8.0 GT/s, and add PCIe lane equalization
preset properties for 8.0 GT/s and 16.0 GT/s for sa8775p ride platform, which fix AER
errors.

While equalization settings for 16 GT/s have already been set, this update adds the
required equalization settings for PCIe operating at 8.0 GT/s, including the
configuration of shadow registers, ensuring optimal performance and stability.

The DT change for sa8775p add PCIe lane equalization preset properties for 8 GT/s
and 16 GT/s data rates used in lane equalization procedure.

Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>

Changes in v4:
- Bail out early if the link speed > 16 GT/s and use pci->max_link_speed directly (Mani)
- Fix the build warning. (Bjorn)
- Link to v3: https://lore.kernel.org/all/8ccd3731-8dbc-4972-a79a-ba78e90ec4a8@quicinc.com/

Changes in v3:
- Delte TODO tag and warn print in pcie-qcom-common.c. (Bjorn)
- Refined the commit message for better readability. (Bjorn)
- Link to v2: https://lore.kernel.org/all/20250611100319.464803-1-quic_ziyuzhan@quicinc.com/

Changes in v2:
- Update code in pcie-qcom-common.c make it easier to read. (Neil)
- Fix the compile error.
- Link to v1: https://lore.kernel.org/all/20250604091946.1890602-1-quic_ziyuzhan@quicinc.com


Ziyue Zhang (3):
  PCI: qcom: Add equalization settings for 8.0 GT/s
  PCI: qcom: fix macro typo for CURSOR
  arm64: dts: qcom: sa8775p: Add PCIe lane equalization preset
    properties

 arch/arm64/boot/dts/qcom/sa8775p.dtsi         |  6 +++
 drivers/pci/controller/dwc/pcie-designware.h  |  5 +-
 drivers/pci/controller/dwc/pcie-qcom-common.c | 54 ++++++++++---------
 drivers/pci/controller/dwc/pcie-qcom-common.h |  2 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  6 +--
 drivers/pci/controller/dwc/pcie-qcom.c        |  6 +--
 6 files changed, 45 insertions(+), 34 deletions(-)


base-commit: 58ba80c4740212c29a1cf9b48f588e60a7612209
-- 
2.34.1


