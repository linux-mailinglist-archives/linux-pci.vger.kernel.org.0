Return-Path: <linux-pci+bounces-12234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8666A96009C
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 06:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6EB2835E3
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 04:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B9C13A260;
	Tue, 27 Aug 2024 04:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d0CtSzoh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2F05A4D5;
	Tue, 27 Aug 2024 04:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724734723; cv=none; b=bbKeyhHFNpKYvHoHzVx/+rRar6aeoM5DB5P7L8/5k3v2EVVw1XcY0Oe3/7bYNLByG8wDOevay5XialwqD4MuvYmx746o/jHI63FHjS5ve/4Q7tkRuI68b0hYltfbjRT+y+g5Nxwe/bUKlFFFeKlXPXVOoVc9I2tnIb5UPeDqMVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724734723; c=relaxed/simple;
	bh=Tlc/Zp1J2mW9lb+9c484DqKtAoUUljQBcrXjKmhOEJ8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LmGiGgMT4ZsmUexvo/SIwBgd02Rzov3Ji0p5XLVUlr1PRhaIsm9/shoIzSUkuenpw9N8yzR15awvwuZRUI5n7e0zRNZn6PMiu8BlsaQfWSA6eEo7DcGw2J/EZFQqodadOgpPmnuYpo+DjZgloG5Mz40xeX96g+angiTtLgLUAA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d0CtSzoh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QJH7b2012068;
	Tue, 27 Aug 2024 04:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=veaRPlMIi+GSn/PvdRaQgF
	Be6L4z/CIvpy/7CEnl8Os=; b=d0CtSzoh0+DJPrwO3NdxvpK3McK0Nn3+PNPLVX
	4ud5KbQHzrFXBLCBN9yP96G2mlr7ueWpd4oKvrwmMPCxS8rkosPiEtdx6zPLrW43
	OuHXY/FALFQHw85INWfdgkLT88za0WdQIQ7D3quB6j0ehcssqpLZKfzYpsfy3J9c
	akb7I1NvXBvafEdE94HrBoelNQmHXusDfxd42P6DKKhR9O9MFQUSzGIT2g2Z73AO
	vMIlf7l/zgR1NeJzCrLthhXievyBa5hIjGfRI6cHNL2LRiuwHVFrnaPaE8mlE49U
	gX8/hFKNB2D87NPx2kguVOrxuNjodY3S7B8zPGVOFJncSaLQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 417988drgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 04:58:20 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47R4wJhl001150
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 04:58:19 GMT
Received: from hu-srichara-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 26 Aug 2024 21:58:09 -0700
From: Sricharan R <quic_srichara@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <dmitry.baryshkov@linaro.org>,
        <quic_nsekar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <robimarko@gmail.com>, <quic_srichara@quicinc.com>
Subject: [PATCH V2 0/6] Enable IPQ5018 PCI support
Date: Tue, 27 Aug 2024 10:27:51 +0530
Message-ID: <20240827045757.1101194-1-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yxPEq2bZrlt9iRy2XsGtd7bYu0C3ukSI
X-Proofpoint-ORIG-GUID: yxPEq2bZrlt9iRy2XsGtd7bYu0C3ukSI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_03,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 suspectscore=0
 mlxlogscore=697 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408270032

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

This patch series adds the relevant phy and controller
DT configurations for enabling PCI gen2 support
on IPQ5018.

v2:
  Fixed all review comments from Krzysztof, Robert Marko,
  Dmitry Baryshkov, Manivannan Sadhasivam, Konrad Dybcio.
  Updated the respective patches for their changes.

v1:
 https://lore.kernel.org/lkml/32389b66-48f3-8ee8-e2f1-1613feed3cc7@gmail.com/T/

Nitheesh Sekar (5):
  dt-bindings: phy: qcom,uniphy-pcie: Document PCIe uniphy
  dt-bindings: PCI: qcom: Add IPQ5108 SoC
  phy: qcom: Introduce PCIe UNIPHY 28LP driver
  arm64: dts: qcom: ipq5018: Add PCIe related nodes
  arm64: dts: qcom: ipq5018: Enable PCIe

Sricharan R (1):
  PCI: qcom: Add support for IPQ5018

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  35 ++
 .../phy/qcom,ipq5018-uniphy-pcie.yaml         |  70 ++++
 .../arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts |   9 +
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 166 ++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c        |   1 +
 drivers/phy/qualcomm/Kconfig                  |  12 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 .../phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c  | 341 ++++++++++++++++++
 8 files changed, 633 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq5018-uniphy-pcie.yaml
 create mode 100644 drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c

-- 
2.34.1


