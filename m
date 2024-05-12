Return-Path: <linux-pci+bounces-7392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C97FC8C3595
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2024 10:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2A71F21419
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2024 08:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F901804E;
	Sun, 12 May 2024 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ieup6WLR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E04811CA9;
	Sun, 12 May 2024 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715502564; cv=none; b=Wy5+rcRnZYJ+iM/OqSsrW0hFT/Rxup/TekjXmbZXBEKzs6C3qBmXgd+Cipvl52SAS31LOZi6RwVeF28puCRx/T0m6IGs7OcL6et7WbTc9M/c2SyyNjhJ+0n5/ap804yuWXnQwDyGfU/tCoq8QTInVco7gjmCp2Kldarez2CsSM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715502564; c=relaxed/simple;
	bh=Kg01KdPM1e604RU24WAAEYArfBdHXPpUpF4ernTV5U0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ecHrRkOdjM4DL+Du8ZNtDbVhgEgDBT1wVqbCjjVeI7a+kmgg64+iVzCJy8tXU8Qprodr/3y/z8OQul1hDO0zhVU1h2hQZaaScMafn4r6aZZgZq73YpzVw0Q6G1cD4guY86jMfBrlhE+doNSe0HvL69V3uni6VQGjXoe83Xc4PXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ieup6WLR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44C6xx70020127;
	Sun, 12 May 2024 08:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=J+GayALGJfu1ccCEpCMK
	6ZJKk9MHE6tTPJPRbvZ81rU=; b=Ieup6WLRiVMoxnYNpFYbpY1B4sCGelAAabG3
	HEjJYvmwLZdAn5dxtJHKxvdCZ4ewuZVh8VYqlQFVxyzlvR8imEodG1SBZpOX4Fpc
	JGJzC30CSE8mRX1QL7ppmcjVaDxrWVRz4sOJxlgDkhRbYMMMirm7plnuhq8PILFi
	VASEBfeZrU04uZ0utDoWZS32Cv81TJrPkOkQShkmZP4tjX3BnhRQnmY+Gm/tirW5
	aCgZObVaN3f/5i1ZF9akexyTpjzjt371iHrkS9BUjqQ3plKnkEkzZiVzuOInIvb7
	V9WKUVRqJr/nOrPeMDRcwNlUHndyUPIF54a7P0E0xP+M9gtv7A==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y208vshdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 08:29:02 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44C8Sxmx009791;
	Sun, 12 May 2024 08:28:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3y21rkna3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 08:28:59 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44C8Sxnu009763;
	Sun, 12 May 2024 08:28:59 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-devipriy-blr.qualcomm.com [10.131.37.37])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 44C8SwNx009759
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 08:28:59 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4059087)
	id 0E30F41039; Sun, 12 May 2024 13:58:58 +0530 (+0530)
From: devi priya <quic_devipriy@quicinc.com>
To: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc: quic_devipriy@quicinc.com
Subject: [PATCH V5 0/6] Add PCIe support for IPQ9574
Date: Sun, 12 May 2024 13:58:52 +0530
Message-Id: <20240512082858.1806694-1-quic_devipriy@quicinc.com>
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
X-Proofpoint-ORIG-GUID: rvUKZQXWnNLhP4dyc3Il_mVrN8C1d-0c
X-Proofpoint-GUID: rvUKZQXWnNLhP4dyc3Il_mVrN8C1d-0c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-12_05,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxlogscore=925
 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405120061

This series adds support for enabling the PCIe host devices (PCIe0, PCIe1,
PCIe2, PCIe3) found on IPQ9574 platform.
The PCIe0 & PCIe1 are 1-lane Gen3 host and PCIe2 & PCIe3 
are 2-lane Gen3 host.

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

devi priya (6):
  Add PCIe pipe clock definitions for IPQ9574 SoC.
  clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
  dt-bindings: PCI: qcom: Document the IPQ9574 PCIe controller.
  arm64: dts: qcom: ipq9574: Add PCIe PHYs and controller nodes
  arm64: dts: qcom: ipq9574: Enable PCIe PHYs and controllers
  PCI: qcom: Add support for IPQ9574

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  37 ++
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts   | 113 ++++++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 365 +++++++++++++++++-
 drivers/clk/qcom/gcc-ipq9574.c                |  76 ++++
 drivers/pci/controller/dwc/pcie-qcom.c        |  36 +-
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  |   4 +
 6 files changed, 623 insertions(+), 8 deletions(-)


base-commit: e7b4ef8fffaca247809337bb78daceb406659f2d
prerequisite-patch-id: 513cb089a74b49996b46345595d1aacf60dcda64
prerequisite-patch-id: ce7a8e9bac53fd5f02921bff6bc54149fb92f996
prerequisite-patch-id: c26478e61e583eb879385598f26b42b8271036f5
prerequisite-patch-id: a5c15da6a968e673737dc5aa962f31576903f8aa
prerequisite-patch-id: 353eb53cd192489d5b0c4654a0b922f23e1f7217
prerequisite-patch-id: d282ba7948460ae4d2f541c8c25ff5089ff6507e
prerequisite-patch-id: 5141131d46f7789b50ac806f10b63869d15d709f
prerequisite-patch-id: f9d936541ba730ad6383b4ccab85964b853eb241
prerequisite-patch-id: 7382bed435a31877deb5d02dd105cc4b9cf31abc
-- 
2.34.1


