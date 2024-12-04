Return-Path: <linux-pci+bounces-17632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D629E38E3
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 12:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B1C1664B4
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 11:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9911B21B7;
	Wed,  4 Dec 2024 11:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ajhtGZZ/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544651AE863;
	Wed,  4 Dec 2024 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312062; cv=none; b=l9WbBZiN7+L8ZhoWBrAHFKKDJEhDc0SLHe3h6ejXlmyt+DN6A5/92tA4Sf8QyQVTz3w672E2n2YEaJWRm0Xw0cjpICJY/gwFC7bs/ZFk6mN6gS2j3Z3F42CTnSmwBvqzAjmsKFEqujO+WMsRfdsl+wu342Q/VmCCrp3rfnSgIpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312062; c=relaxed/simple;
	bh=cvwsTS1vuvkeERAv/DMzFpbBYJZuxhT0B9Q1Haruk7I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GO3BsWtTyXJWvSde+49Z88nxRlBVxLn65M1+WolwsfR5hWDrlB2WdqpbfP07bFeG63aZTxF779cIJ7vx8wpYPYdRwa9nqe93AVSfzP5I2YOaXTsuimeoGCPCe+Wgu6tvcvsZ9bo5gyvhUAisE65BAt8rSS5GB03XyOBzKqwqHwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ajhtGZZ/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4771Ne028017;
	Wed, 4 Dec 2024 11:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=n8FzvXPu/r1w5IB0fnY3Eb
	oOn0VyN99tXURnZCbiJME=; b=ajhtGZZ/ZZRd4WEU7fjXfTJqdOB8KPXZxWkbqg
	JFhslDAKYFnxkikmKChhAYdRGdqJ5y5DrJifxgTuk2gaKtYjR5OBk/Ptg+XAk83L
	Nw9CHrJqMHOOEaXXiVmutEwKNptLtmNB7iLISLlJna2y11toFy9em6G9NIkgH3hU
	IPCUUgcAkgeO7V+2bL0UYm/I+vsrnju0Y05O2j9ExyZ+KUviJxFPfaFeqQn8wb9N
	+WtepOMsI1k7jBNuyafCizRj0ZVnpSLbNQ/4PFh7V9wklRpxy/d59yYQCdEW2UfV
	fn3EzFWgotoEjpjAPtRExLd91g/JUq0Z3+QlX/HoqM7dSDxg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439vcem6p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 11:34:05 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B4BY43s025568
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Dec 2024 11:34:04 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Dec 2024 03:33:58 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <p.zabel@pengutronix.de>,
        <quic_nsekar@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: [PATCH v2 0/6] Add PCIe support for Qualcomm IPQ5332
Date: Wed, 4 Dec 2024 17:03:23 +0530
Message-ID: <20241204113329.3195627-1-quic_varada@quicinc.com>
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
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ICLesSqubqArBsr7fqycsN6rPZ2JpE2B
X-Proofpoint-ORIG-GUID: ICLesSqubqArBsr7fqycsN6rPZ2JpE2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=810 adultscore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 mlxscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412040090

Patch series adds support for enabling the PCIe controller and
UNIPHY found on Qualcomm IPQ5332 platform. PCIe0 is Gen3 X1 and
PCIe1 is Gen3 X2 are added.

v2: Combined [1] & [2]
	- take the phy driver related changes from [1]
	- drop IPQ5018 related changes
    Address review comments from [1] & [2] for the patches included in v2
    Please see individual patches for the differences between v1 and v2

    1. https://lore.kernel.org/all/20231003120846.28626-1-quic_nsekar@quicinc.com/
    2. https://lore.kernel.org/linux-arm-msm/20231214062847.2215542-1-quic_ipkumar@quicinc.com/

v1: https://lore.kernel.org/linux-arm-msm/20231214062847.2215542-1-quic_ipkumar@quicinc.com/

Nitheesh Sekar (2):
  dt-bindings: phy: qcom,uniphy-pcie: Document PCIe uniphy
  phy: qcom: Introduce PCIe UNIPHY 28LP driver

Praveenkumar I (4):
  dt-bindings: PCI: qcom: Add IPQ5332 SoC
  pci: qcom: Add support for IPQ5332
  arm64: dts: qcom: ipq5332: Add PCIe related nodes
  arm64: dts: qcom: ipq5332: Enable PCIe phys and controllers

 .../devicetree/bindings/pci/qcom,pcie.yaml    |   4 +
 .../bindings/phy/qcom,uniphy-pcie.yaml        |  82 +++++
 arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts   |  74 +++++
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 214 +++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c        |   1 +
 drivers/phy/qualcomm/Kconfig                  |  12 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 .../phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c  | 307 ++++++++++++++++++
 8 files changed, 693 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,uniphy-pcie.yaml
 create mode 100644 drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c


base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
-- 
2.34.1


