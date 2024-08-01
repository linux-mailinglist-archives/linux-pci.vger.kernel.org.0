Return-Path: <linux-pci+bounces-11100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BD89442CE
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 07:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82478283E49
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 05:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB1E13DDDB;
	Thu,  1 Aug 2024 05:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DvodYHVr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E4B13D62F;
	Thu,  1 Aug 2024 05:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722491319; cv=none; b=NkOr/PjnCE+8N4H7nD9PtbI3nm6fOoA8tW19N760mqPhjewv3NafMbRhG9gYl3Ukukz/m6QzH2CvSBSVoIc2jI3YslkntJLvs4p/we2BpsKT3lCb7qvy/+Nl/LXqY0Iei0wbkXzaCKX+BWQzuDvmPawvwg1s1AY3w07aS84x9zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722491319; c=relaxed/simple;
	bh=4Oi3TlIwbkpbXlafnRz5aqGDixiGI5TFcsOjgVMRHh4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bybQibn/cirUSY1Bzh6jLRRtLXvCpHwFQsdHPiMd87oHzQlfgTMeCJv/gLVnialvue38YuBO+GfvT9TGLpbWmDxi1irl2oq+blR/ejMg4GamXvepWTmcYCHYy7odvCMu/yOAytdvLWJ90V90oeEXf3/FN+D54SoNnW2LX27oQMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DvodYHVr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4711OmXU010039;
	Thu, 1 Aug 2024 05:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vHAaWI3Ut3AytiltVZPSLF
	fAZdB5xqKJCdLEWslzcJI=; b=DvodYHVrWBkyspXFpAyYuVq9VmkDR6at1HNwGG
	A3jtS7fhlfKvZNwjMKv3XCgxMJ5BWg8/EIQHJ274W/J/pHg7GoNR2nnN9jrdN2qA
	zq/E6nPRn6KTmHOf2+gEWvW740oB7BVet/rE3KTNNeGREPBE6BsL1Qe+JNIqKpK+
	kEeWOyHoS82qPRkTDJbyzxiMKYaXNJ6144KxIIyYWa1tkXw/+5zZxwAhty8QN/1D
	nLIGlJgFhjYb0Pv0S1x+zGhBZlPQ+RrccoRqboyisaNwstmmdCkoMoZzOU7Azav/
	P3rtzA0gzMJVUNxfIC1+BeuMtkx75xyY+WQhdblmCdauXlGQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40qnbaakr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 05:48:22 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4715mKpi019296
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 05:48:20 GMT
Received: from hu-srichara-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 31 Jul 2024 22:48:16 -0700
From: Sricharan R <quic_srichara@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_srichara@quicinc.com>
Subject: [PATCH V7 0/4] Add PCIe support for IPQ9574
Date: Thu, 1 Aug 2024 11:17:59 +0530
Message-ID: <20240801054803.3015572-1-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8uIZrj58ON7ALV60yoFkfU2Ly_lVfYQ2
X-Proofpoint-GUID: 8uIZrj58ON7ALV60yoFkfU2Ly_lVfYQ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_02,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 mlxlogscore=908 phishscore=0 mlxscore=0
 impostorscore=0 clxscore=1011 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010032

This series adds support for enabling the PCIe host devices (PCIe0, PCIe1,
PCIe2, PCIe3) found on IPQ9574 platform. The PCIe0 & PCIe1 are 1-lane Gen3
host and PCIe2 & PCIe3 are 2-lane Gen3 host.

[V7]    - Fixed review comments from Konrad, Krysztof, Manivannan and picked up review tags
          Rebased patch 4 on top of [1] for avoiding DBI/ATU mirroring
          Both dt_binding_check and dtbs_check passed and tested on ipq9574-rdp433

	  [1] - https://lore.kernel.org/linux-arm-msm/a01404d2-2f4d-4fb8-af9d-3db66d39acf7@quicinc.com/  

[V6]
        - Dropped patches [1] and [2] for clks, since its already merged.
        - Addressed all comments from Krzysztof, Manivannan, Bjorn Helgaas.
          Specifically dropped defining a new macro for SLV_ADDR_SPACE_SZ.
          Letting it at reset value is fine.

          Both dt_binding_check and dtbs_check passed and tested on ipq9574-rdp433

	[1] - https://patchwork.kernel.org/project/linux-pci/patch/20240512082858.1806694-2-quic_devipriy@quicinc.com/
	[2] - https://patchwork.kernel.org/project/linux-pci/patch/20240512082858.1806694-3-quic_devipriy@quicinc.com/

[V5]
	Change logs are added to the respective patches
	This series depends on the below series which adds support for
	Interconnect driver[1] and fetching clocks from the Device Tree[2]
	[1] - https://lore.kernel.org/linux-arm-msm/20240430064214.2030013-1-quic_varada@quicinc.com/
	[2] - https://lore.kernel.org/linux-pci/20240417-pci-qcom-clk-bulk-v1-1-52ca19b3d6b2@linaro.org/
[V4]
https://lore.kernel.org/linux-arm-msm/20230528142111.GC2814@thinkpad/

[V3]
https://lore.kernel.org/linux-arm-msm/20230421124938.21974-1-quic_devipriy@quicinc.com/
	- Dropped the phy driver and binding patches as they have been
	  posted as a separate series.
	- Dropped the pinctrl binding fix patch as it is unrelated to the series
	  dt-bindings: pinctrl: qcom: Add few missing functions.
	- Rebased on linux-next/master.
	- Detailed change logs are added to the respective patches.

[V2]
https://lore.kernel.org/linux-arm-msm/20230404164828.8031-1-quic_devipriy@quicinc.com/
	- Reordered the patches and split the board DT changes
	  into a separate patch as suggested
	- Detailed change logs are added to the respective patches
[V1]
https://lore.kernel.org/linux-arm-msm/20230214164135.17039-1-quic_devipriy@quicinc.com/

devi priya (4):
  dt-bindings: PCI: qcom: Document the IPQ9574 PCIe controller
  arm64: dts: qcom: ipq9574: Add PCIe PHYs and controller nodes
  arm64: dts: qcom: ipq9574: Enable PCIe PHYs and controllers
  PCI: qcom: Add support for IPQ9574

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  50 +++
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts   | 113 +++++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 421 +++++++++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c        |   1 +
 4 files changed, 581 insertions(+), 4 deletions(-)

-- 
2.34.1


