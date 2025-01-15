Return-Path: <linux-pci+bounces-19822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796E6A119FB
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177783A8406
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 06:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9912B1D5ACF;
	Wed, 15 Jan 2025 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nNKfy+Gv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179E95223;
	Wed, 15 Jan 2025 06:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736923692; cv=none; b=ugz+wgI+Zwst+9xJbrj8zEA/Xrqzu1GlmiRawhSKjuQ8JHb98g+yypBJV7uS3q0j06Jmlb+fxIYywuEdNkWM/xZwa6PcSHoUOPbpprbftN4HgGANl07THRf4k+dxX6l4K3FG8Bqf4mm4Z4LBqlp75P7/7QDaKk2X5l8PrHxdvA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736923692; c=relaxed/simple;
	bh=HmgPSZfpOtzPRo4FG6rn2dnPs1lZpaBIEyjFvD1xXeo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sYd42Kz1lX0bcwNeMUhWEE3iKuUzOzeAuUVnUe5X8GBiAx+1FvZNW+3+KLOKhyxyQvPyIIddEIWOIlrPDtifoLrDmYaNeahzxrC9jpRqXWANelCBKG3aM1KJ4PYyu7LmlcOls+KbXEQN2Ld0rg4eStw+SsnVyUQbYk0acyM9ID4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nNKfy+Gv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F2ipQI011392;
	Wed, 15 Jan 2025 06:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5AUhtyYam9P61nGzKWQsi+
	ywey8S2d1NmsmWNCGAGEY=; b=nNKfy+GvNgNEkuJx7KH2DQiV8tI94YLzrHwdA/
	F7HmtnCQQBMuNB0r/Yi549Jp46HAkHM49s+UCzperErxPHR6sBDNUWv+WvUFuFRg
	sp7kXtZTVlvlBHYT4BmkFkvL6K4R9eREFt42CxLIFR2arnOQqj0osa1AeDfzIBW/
	HUNRiotPw8mLYK9XXyrPMD073e4eBAAp1vP06+ZeJ8Q4V0Vi0nlkliNMjEyXpFx8
	vdxKzGLutML4nxYVbwjbw3m71SrTtoKTw5AXI3CTFu2cZWehxrvwZMceK5Ez5kAV
	MQaUfAMtQmUquj3FISLSAPyZM2i62y7+KM2qKKSeQErkDryg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4464gp8fwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 06:48:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50F6m2P4005031
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 06:48:02 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 14 Jan 2025 22:47:57 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v2 0/3] Add PCIe support for IPQ5424
Date: Wed, 15 Jan 2025 12:17:44 +0530
Message-ID: <20250115064747.3302912-1-quic_mmanikan@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lp-Fu1Q14FmkJoH2cjoE1DErnL_YrPK3
X-Proofpoint-ORIG-GUID: lp-Fu1Q14FmkJoH2cjoE1DErnL_YrPK3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_02,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=634 adultscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150049

This series adds support for enabling the PCIe host devices (PCIe0,
PCIe1, PCIe2, PCIe3) found on IPQ5424 platform. The PCIe0 & PCIe1
are 1-lane Gen3 host and PCIe2 & PCIe3 are 2-lane Gen3 host.

Changes in V2:
	- Fixed all review comments from Konrad, Varada.
	- Patches #3 and #4 from V1 have been renumbered
	  to #2 and #3 in V2 because patch #2 from V1 was
	  merged into linux-next.
	- Detailed change logs are added to the respective
	  patches.

V1 can be found at:
https://lore.kernel.org/linux-arm-msm/20241213134950.234946-1-quic_mmanikan@quicinc.com/

Manikanta Mylavarapu (3):
  dt-bindings: PCI: qcom: Document the IPQ5424 PCIe controller
  arm64: dts: qcom: ipq5424: Add PCIe PHYs and controller nodes
  arm64: dts: qcom: ipq5424: Enable PCIe PHYs and controllers

 .../devicetree/bindings/pci/qcom,pcie.yaml    |   4 +
 arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts   |  41 +-
 arch/arm64/boot/dts/qcom/ipq5424.dtsi         | 500 +++++++++++++++++-
 3 files changed, 540 insertions(+), 5 deletions(-)


base-commit: 2b88851f583d3c4e40bcd40cfe1965241ec229dd
-- 
2.34.1


