Return-Path: <linux-pci+bounces-13427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F77984354
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 12:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0968BB23DEC
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 10:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F245717B50F;
	Tue, 24 Sep 2024 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XrxY4gID"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3041B173345;
	Tue, 24 Sep 2024 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172902; cv=none; b=RMmG1nEl7yjRmACCbIx4qkFKyXcEOg3qKqASrrEP37VH+YI1prdSEYxzvQuNUWOmdMZHE/VNG1T9ad+UyIum4TXVCpH9tOtqwgFMljDgjvh3n/PxQ3O4doH6Rkx5lY513cnS+0utq4/nJLpBiodZUtWhu+UsYmGCENBjdrHT060=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172902; c=relaxed/simple;
	bh=0+JMYHLjqMSWMXQODc8SVvbB3V6T7yMYk+jgcOYz8lc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ivgODNcDsJHvOg7gcg2oImMyqdMQnAuBEm4JawaPkfyWWoK6YTqUlKKzP+xAf+9BjwgFa+ZEvn394V1hCECE+UU8vvHGannQMs83iufKj95sgom7hqTU8qZO5S+gu5IBfE7PIl8J70rG8hLj7xXkxIXI1PVPMUoAQaKex8li/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XrxY4gID; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O9eqeD024446;
	Tue, 24 Sep 2024 10:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=MjRA6AtoYGwZ3W/55TtpIAasOhCK4CvxBpB
	r1anyjSE=; b=XrxY4gID5YdMiBy9YRx3/2SMHF4IOtNak7TI+hsNAeoLC1H1LX6
	oi2BZZg1M/8oEInN4dtL0E11tMin0kRhlDkyUwUCPk+wSYsarnT71C4c/h0WiHKD
	J8Aesgt25qpUlHuOlPj+POjCyi4pGRLF7xUhFibZOA74vKl/n34OR75x6pz6Ur1a
	gKKIO5Sa6YoS4A5w6T0uYH5+H/EXIw/73gBLI7hBk8dL1sogajDIucNW6ldLI/N3
	tW4l4IVnguq51w5yC6w6lKb2huj0QkVKeN6ndtGau3oPqWiK/hgnhYmqLok/7BeS
	LtCvkVwkeXpEyO6KPtkN2Y7CumD/ZNmUf1w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sph6ra4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 10:14:48 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 48OAE86a019117;
	Tue, 24 Sep 2024 10:14:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 41udjhy295-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 10:14:47 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48OAE7qj019106;
	Tue, 24 Sep 2024 10:14:47 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-qianyu-lv.qualcomm.com [10.81.25.114])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 48OAEk03020059
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 10:14:47 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4098150)
	id 7B8D665F; Tue, 24 Sep 2024 03:14:46 -0700 (PDT)
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
Subject: [PATCH v4 0/6] Add support for PCIe3 on x1e80100
Date: Tue, 24 Sep 2024 03:14:38 -0700
Message-Id: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
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
X-Proofpoint-GUID: lUspAZtLss2zMG1AsDl5nTszgcmO5MmN
X-Proofpoint-ORIG-GUID: lUspAZtLss2zMG1AsDl5nTszgcmO5MmN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=792
 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409240071

This series add support for PCIe3 on x1e80100.

PCIe3 needs additional set of clocks, regulators and new set of PCIe QMP
PHY configuration compare other PCIe instances on x1e80100. Hence add
required resource configuration and usage for PCIe3.

v3->v4:
1. Reword commit msg of [PATCH v3 5/6]
2. Drop opp-table property from qcom,pcie-sm8450.yaml
3. Add Reviewed-by tag

v2->v3:
1. Use 'Gen 4 x8' in commit msg
2. Move opp-table property to qcom,pcie-common.yaml
3. Add Reviewed-by tag
4. Add global interrupt and use GIC_SPI for the parent interrupt specifier
5. Use 0x0 in reg property and use pcie@ for pcie3 device node
6. Show different IP version v6.30 in commit msg
7. Add logic in controller driver to have new ops for x1e80100

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

Qiang Yu (6):
  dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the X1E80100
    QMP PCIe PHY Gen4 x8
  dt-bindings: PCI: qcom: Move OPP table to qcom,pcie-common.yaml
  phy: qcom: qmp: Add phy register and clk setting for x1e80100 PCIe3
  clk: qcom: gcc-x1e80100: Fix halt_check for pipediv2 clocks
  PCI: qcom: Add support for X1E80100 SoC
  arm64: dts: qcom: x1e80100: Add support for PCIe3 on x1e80100

 .../bindings/pci/qcom,pcie-common.yaml        |   4 +
 .../bindings/pci/qcom,pcie-sm8450.yaml        |   4 -
 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |   3 +
 arch/arm64/boot/dts/qcom/x1e80100.dtsi        | 204 ++++++++++++++++-
 drivers/clk/qcom/gcc-x1e80100.c               |  10 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |  16 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 211 ++++++++++++++++++
 .../qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h    |  25 +++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h |  19 ++
 9 files changed, 485 insertions(+), 11 deletions(-)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h

-- 
2.34.1


