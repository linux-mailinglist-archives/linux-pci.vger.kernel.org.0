Return-Path: <linux-pci+bounces-20346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF447A1C0CC
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jan 2025 04:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B589918866F8
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jan 2025 03:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3751206F01;
	Sat, 25 Jan 2025 03:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZsLnGCqF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153EA126C05;
	Sat, 25 Jan 2025 03:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737777589; cv=none; b=dLthkfR1kFkO8NxYTqgLEvJInDv2N4+7ZrNb8L91PgNG13HBw2G4W5pOFSmjb7eKraYPgkrE+IePL3CQiJd1CDxVBzaY4NgeRNoioq3g33bLfnAP5ylS0c7uUV+mjImlnsTyTf3opVdaiG1qDwj9BlEOwaYpid/gcv4HL6ftM3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737777589; c=relaxed/simple;
	bh=0w+WWn2/mpE5ZUumsoqePkIoNzfklDsXGz/y4k5sRks=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=snTh+Ua7AVCnaoFspp7pVXiNiPqUVKFlL61BnxI0gb1deh1pUZLqhp0lGqdlvuzQAV5s2vF81dKRHsqdJhfqYfx5X6P6hC2wkkpDmmKyA7tFhL94GQpStRgA0KHqr8IahPd4LQEgREWT2xVKMH1VQYbSuYM5nGsACvN64htaWDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZsLnGCqF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50P0KVpc011981;
	Sat, 25 Jan 2025 03:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eMDTFppBnMMyUAyCZfj1/m
	TBcerbLE+rwXG7yaAg0JM=; b=ZsLnGCqFZgTsPiqwPz0EiOzfyXy2AisZrF2lPa
	culMGybj8zIEKROBokLJvJjO7F+D8FuHk3tov17NMzSu07MaftVdSNHW4smwHrOt
	hj8DujpJ/3pORBjRJbNUjIH+HV3VkpmtjVV+FSA5lcrudGV+20NTwmgdNXxT6Tpl
	odRhx45smCZ8HGiKuQ/vUrhVfGVNLCpTcwYnqwOADiMkxHmO2OfJJVwNnGFulmZn
	cXpoKWWZhlLbbjQDTEdjypohF+QnhS7LkNkZYcDuw4DZAgy/OCi7IwROfIdcEYD+
	IbW/dbaXWV4fJoaJLncx5Y1xLiNUL0FgD3OWrdpo9cD3XQUw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cnakr90d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jan 2025 03:59:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50P3xch1018070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jan 2025 03:59:38 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 24 Jan 2025 19:59:32 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <bhelgaas@google.com>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v3 0/4] Add PCIe support for IPQ5424
Date: Sat, 25 Jan 2025 09:29:16 +0530
Message-ID: <20250125035920.2651972-1-quic_mmanikan@quicinc.com>
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
X-Proofpoint-GUID: iA2GixjSNBdNiwjtVuvLv3RbQEQsSa4O
X-Proofpoint-ORIG-GUID: iA2GixjSNBdNiwjtVuvLv3RbQEQsSa4O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_01,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=736
 suspectscore=0 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501250024

This series adds support for enabling the PCIe host devices (PCIe0,
PCIe1, PCIe2, PCIe3) found on IPQ5424 platform. The PCIe0 & PCIe1
are 1-lane Gen3 host and PCIe2 & PCIe3 are 2-lane Gen3 host.

Changes in V3:
	- Fixed all review comments from Manivannan.
	- Patch #1 and #2 are newly added.
	- Detailed change logs are added to the respective
	  patches.

V2 can be found at:
https://lore.kernel.org/linux-arm-msm/20250115064747.3302912-1-quic_mmanikan@quicinc.com/

V1 can be found at:
https://lore.kernel.org/linux-arm-msm/20241213134950.234946-1-quic_mmanikan@quicinc.com/

Manikanta Mylavarapu (4):
  dt-bindings: PCI: qcom: add global interrupt for ipq5424
  dt-bindings: clock: update interconnect cells for ipq5424
  arm64: dts: qcom: ipq5424: Add PCIe PHYs and controller nodes
  arm64: dts: qcom: ipq5424: Enable PCIe PHYs and controllers

 .../bindings/clock/qcom,ipq5332-gcc.yaml      |   8 +-
 .../devicetree/bindings/pci/qcom,pcie.yaml    |   6 +-
 arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts   |  41 +-
 arch/arm64/boot/dts/qcom/ipq5424.dtsi         | 516 +++++++++++++++++-
 4 files changed, 561 insertions(+), 10 deletions(-)


base-commit: 5ffa57f6eecefababb8cbe327222ef171943b183
-- 
2.34.1


