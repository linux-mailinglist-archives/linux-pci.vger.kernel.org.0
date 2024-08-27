Return-Path: <linux-pci+bounces-12250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B363F9601E0
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 08:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F08BB23B1A
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 06:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4FC14A4F5;
	Tue, 27 Aug 2024 06:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LNUyjfe0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AED513D638;
	Tue, 27 Aug 2024 06:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740622; cv=none; b=KF65CfPuF8Mp4632tHl7iVPwsbG8+K/o4v/a6OlpiJ1gQHm0+h+qSOopaGOwhaMfKw1Ri0cFiYWCDW/b30edqW31MZWTpzaZlJAiSLCql6aLr/ifh5Akg6uLpEnrIqwzvEGNKijBsOgsFt8dqcriF3lHFeV+JVEiej+hP8nQhW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740622; c=relaxed/simple;
	bh=F2TYTFs7NDn6ghvrnPBRw2uLAnUhRgJ28kIvxM52c4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kFzGzaeP3jss9f/N6MdalBru4QrqFfhvVmnHm9CGsmmRQMGBQJ31/zqlF/x+Z6eFI6P5/XjoTgVBwbxC30j64o/GBZPgHaQawDFWn80mVW+kElknvKPW7OT1RL/X3DniG1zI0wjytKs/tDMhFadGhi57+8WQ1FX3lYxtbk+y6u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LNUyjfe0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R1wrBv005068;
	Tue, 27 Aug 2024 06:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=STiRUIeQcRQxOq45psitmNN/9+D78+cydM8
	/r9NcrOs=; b=LNUyjfe0PZ1pS/nFOyaTYpbdHeP//vU7RMQCzxIZN7yVWbXC1Dg
	wKU+FHMNXvXZXJ5+7wd0b+rB4lvhTHPlbUwh41BfLD1GPc4LDpXHhsqDSPKS/jPm
	t8BfUxLnWgJ89cLeJPdzBaFGv5DdJpX814RtYIf/D3X5aTh0PQrlFepQB678Zlv3
	h8xam616/7i3Ks80opWj9XdmuBJvqKqpui1g1hwL+D5yDq6weWuy+1zaVlWZftPW
	JDs8AjdbXaiwNu1Q7ckhtUtqtn8Lhip2t1aFdBao/bnNjLZpFFh/0NV6nH/bmLR9
	rLPmIy4NEDT+r4navQgYYvWMz+IDEi6X4mQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4195kq8jtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:36:45 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47R6IV75000976;
	Tue, 27 Aug 2024 06:36:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 418uqwxr4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:36:44 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47R6TpR3023742;
	Tue, 27 Aug 2024 06:36:43 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-qianyu-lv.qualcomm.com [10.81.25.114])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 47R6ahKE006254
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:36:43 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4098150)
	id A1DED64E; Mon, 26 Aug 2024 23:36:43 -0700 (PDT)
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
Subject: [PATCH 0/8] Add support for PCIe3 on x1e80100
Date: Mon, 26 Aug 2024 23:36:23 -0700
Message-Id: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 4xFp7q55GvlXzYXFXY7WdbXka_FMOjgS
X-Proofpoint-GUID: 4xFp7q55GvlXzYXFXY7WdbXka_FMOjgS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_04,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 mlxlogscore=972 impostorscore=0 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408270048

This series add support for PCIe3 on x1e80100.

PCIe3 needs additional set of clocks, regulators and new set of PCIe QMP
PHY configuration compare other PCIe instances on x1e80100. Hence add
required resource configuration and usage for PCIe3.

Qiang Yu (8):
  phy: qcom-qmp: pcs-pcie: Add v6.30 register offsets
  phy: qcom-qmp: pcs: Add v6.30 register offsets
  phy: qcom: qmp: Add phy register and clk setting for x1e80100 PCIe3
  arm64: dts: qcom: x1e80100: Add support for PCIe3 on x1e80100
  dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the X1E80100
    QMP PCIe PHY Gen4 x8
  clk: qcom: gcc-x1e80100: Fix halt_check for pipediv2 clocks
  arm64: dts: qcom: x1e80100-qcp: Add power supply and sideband signal
    for pcie3
  PCI: qcom: Add support to PCIe slot power supplies

 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  18 +-
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts     | 116 +++++++++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi        | 205 +++++++++++++++-
 drivers/clk/qcom/gcc-x1e80100.c               |  10 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |  52 +++-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 222 +++++++++++++++++-
 .../qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h    |  25 ++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h |  19 ++
 8 files changed, 657 insertions(+), 10 deletions(-)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h

-- 
2.34.1


