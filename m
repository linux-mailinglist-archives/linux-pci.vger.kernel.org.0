Return-Path: <linux-pci+bounces-13156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01E7977B3F
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 10:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F9B7B23626
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 08:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAA51D6DBE;
	Fri, 13 Sep 2024 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lld+Rusj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A3E1D6C4C;
	Fri, 13 Sep 2024 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216674; cv=none; b=qkSh48X/k255PNIAhSso8/VsheCpj8ZzK/hYFDBdJmCTJtuqb2vqTpWYNP+Hu1KA51AKZJWDbz23QdP8D/TBtKuZmC8FqkPryADQENAinz8BSVcK06a5JKxpceFeTF5HEEDiuswlh7k7BALj9bMLZiC1Kc8aL33Ltdm5s5+QGfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216674; c=relaxed/simple;
	bh=LhqzbbeJPDFDX1us0PqKZch9ACqhnfXgoQdeEpyIkeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A3ViWobc/W2v0dkeCY9ek9wlCCTUFVi1Lh+kSsy0IODO5eXz1ULc+UIHMlkshHzvvgmJ/78JcCRpDBWDhfdLVuudmfklcKK0zcJYvdF2jCw3fhp5qei9v7UHTif70kfrxpWk9MI5r5AG0OKlyRbhgf3gcbPkFdBuVSR5Db+pHgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Lld+Rusj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CMBb7v018913;
	Fri, 13 Sep 2024 08:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Pds7CggsUh1Rn6FKGi339ydI1uZXqwenFix
	dciKo4T4=; b=Lld+RusjUiG9krtmKEH5WPHJkLGULVSh59rk3FmZ+Q3a1PX0b7s
	7a7hZPRgLu4zGwtuSloUVMkCcpVJGA2VQ0g/n/x2xciHG5RbOjVfb1UaWlhFcyxC
	56oNfZNefSpzxs8DsftteHCbBzm2KVS/PeHbwAdbsiaDsN/a86PAfbT2YBECCsUH
	7G4CpLr4PjeN/rW2BuJyTCFq2r6bTvMUak3FKXo4RWAvshUj2foB5/1K+xI9SRqW
	tCkutiI9ZYTHPaablSDzoBXYPOtWYteQRuhcjCbCbvPDHEjwTQsqeaOTpYCOyewm
	Wjxd3WMpUfYGNJUKLbXDTZ21gPNOopVFWzQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41j6gn4b9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 08:37:27 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 48D7n725006336;
	Fri, 13 Sep 2024 08:37:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 41kwufrfe7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 08:37:26 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48D8Y5eu005428;
	Fri, 13 Sep 2024 08:37:26 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-qianyu-lv.qualcomm.com [10.81.25.114])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 48D8bPng010338
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 08:37:26 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4098150)
	id 9FB6954F; Fri, 13 Sep 2024 01:37:25 -0700 (PDT)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org,
        robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
        quic_devipriy@quicinc.com
Cc: dmitry.baryshkov@linaro.org, kw@linux.com, lpieralisi@kernel.org,
        neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v2 0/5] Add support for PCIe3 on x1e80100
Date: Fri, 13 Sep 2024 01:37:19 -0700
Message-Id: <20240913083724.1217691-1-quic_qianyu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: btvZkKFNgB4xeuw285RWP8WZ9UwYZqrk
X-Proofpoint-GUID: btvZkKFNgB4xeuw285RWP8WZ9UwYZqrk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1015 phishscore=0 mlxlogscore=932 lowpriorityscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130059

This series add support for PCIe3 on x1e80100.

PCIe3 needs additional set of clocks, regulators and new set of PCIe QMP
PHY configuration compare other PCIe instances on x1e80100. Hence add
required resource configuration and usage for PCIe3.

v2->v1:
1. Squash [PATCH 1/8], [PATCH 2/8],[PATCH 3/8] into one patch and make the
   indentation consistent.
2. Put dts patch at the end of the patchset.
3. Put dt-binding patch at the first of the patchset.
4. Add a new patch where opp-table is added in dt-binding to avoid dtbs
   checking error.
5. Remove GCC_PCIE_3_AUX_CLK, RPMH_CXO_CLK, put in TCSR_PCIE_8L_CLKREF_EN
   as ref.
6. Remove lane_broadcasting.
7. Add 64 bit bar, Remove GCC_PCIE_3_PIPE_CLK_SRC, 
   GCC_CFG_NOC_PCIE_ANOC_SOUTH_AHB_CLK is changed to
   GCC_CFG_NOC_PCIE_ANOC_NORTH_AHB_CLK.
8. Add Reviewed-by tag.
9. Remove [PATCH 7/8], [PATCH 8/8].

Qiang Yu (5):
  dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the X1E80100
    QMP PCIe PHY Gen4 x8
  dt-bindings: PCI: qcom: Add OPP table for X1E80100
  phy: qcom: qmp: Add phy register and clk setting for x1e80100 PCIe3
  clk: qcom: gcc-x1e80100: Fix halt_check for pipediv2 clocks
  arm64: dts: qcom: x1e80100: Add support for PCIe3 on x1e80100

 .../bindings/pci/qcom,pcie-x1e80100.yaml      |   4 +
 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |   3 +
 arch/arm64/boot/dts/qcom/x1e80100.dtsi        | 202 ++++++++++++++++-
 drivers/clk/qcom/gcc-x1e80100.c               |  10 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 211 ++++++++++++++++++
 .../qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h    |  25 +++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h |  19 ++
 7 files changed, 468 insertions(+), 6 deletions(-)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h

-- 
2.34.1


