Return-Path: <linux-pci+bounces-6894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D528B7C5A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 17:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011371F238D8
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 15:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031EA178CE8;
	Tue, 30 Apr 2024 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GKJe7ILD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30734770F2;
	Tue, 30 Apr 2024 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492567; cv=none; b=rkhvpGKGmn4WeDCJsz8yiFPKDEXEvdIKI3lkn+EqPBAUM0paIWaXhBdpWTXi8cqGNNVufjBqCMGpZ0hwkHWbY2t3oF0/X4uo/+mtwfjG3oxExXtOiOzWOnrdE1VOiH9U9we9sBetMquGnZWBzuihaxU/0jZGB1kXckZWEXr9cj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492567; c=relaxed/simple;
	bh=+giJ4PEabS8ajSTQI0qTm4XrPZ5N5gcn10BJP3dPYW0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=rqSUNO14Tq/60aicTiS/AXEgkTbV24r98R1uZKw22hta2C584M6DHlQ2IgmOo6cvxIbbFVIVhzyYPLTU5JCECZuKg8HH2MXyuz1eteZoeLoBnIRgEQeZC/QpHOwhtov1uHIwMWa+Bw+ZDV2mowBdCorpvT3PoIGV4p5S/pwU5Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GKJe7ILD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UDTZZT026203;
	Tue, 30 Apr 2024 15:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=TidJmUryuAwF
	1U0nl7zI33oshVeYose/ovhXddTTs6w=; b=GKJe7ILD9wQpyI4fzgftgDlqq2qA
	LkeMUJF66BwBNF3BxyjroOyqAEVGSqHOk7FVDQjJIrFKFxBz1Y8AtoKgixT1HT08
	5N4mWcXuZGKo+W5FVY49kWyaAfsbPcfd+Wz4rKC265O5OjZ8WHsRN7I+L7WhDAiw
	whimx/Q7/32QXJpEPF3T2liNMCNSq+2AdIcGkG0ObgC/ev9utoXYGGazXWuvBRuB
	qO3Frhq7FbwWcqLdGPNnPVjOoDgIFGIannvmvzuA/8U4xpe6QGgLcILNKX3nl6CD
	aozW6eKPRMZeRFfOfNuiyE74PU5l99kpsaQGRjZeK320pi31cRT36N8nHA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xu1990dse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 15:55:49 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43UFtjsa032467;
	Tue, 30 Apr 2024 15:55:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3xrtem1a7a-1;
	Tue, 30 Apr 2024 15:55:45 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43UFtjW8032460;
	Tue, 30 Apr 2024 15:55:45 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 43UFtigs032457;
	Tue, 30 Apr 2024 15:55:45 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 2DA9C3BD6; Tue, 30 Apr 2024 21:25:44 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        manivannan.sadhasivam@linaro.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_schintav@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 0/3] arm64: qcom: sa8775p: add support for EP PCIe
Date: Tue, 30 Apr 2024 21:25:36 +0530
Message-Id: <1714492540-15419-1-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xuYlhqSPz_K1rxvvFQmVhOVjQXsVSaKZ
X-Proofpoint-GUID: xuYlhqSPz_K1rxvvFQmVhOVjQXsVSaKZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=991
 lowpriorityscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300111
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

This series adds the relavent DT bindings, new compatible string,
and add EP PCIe node in dtsi file for ep pcie0 controller.

v10 -> v11:
- Fixed Merged conflict on Patch 3
- Rebased on top of v6.9-rc6
- v10 link: https://lore.kernel.org/all/1711725718-6362-1-git-send-email-quic_msarkar@quicinc.com/

v9 -> v10:
- rebased on top of 6.9-rc1
- dropped MHI EPF driver patches as those are applied
- v9 link: https://lore.kernel.org/all/1701432377-16899-1-git-send-email-quic_msarkar@quicinc.com/

v8 -> v9:
- update author in "Add pci_epf_mhi_ prefix to the function" patch.
- add ack by and reviewed by tag in commit message.

v7 -> v8:
- Add new patch PCI: epf-mhi: Add "pci_epf_mhi_" prefix to the function
  names
- Update PCI: epf-mhi: Add support for SA8775P patch on top of the new
  patch and update commit message.

v6 -> v7:
- add reviewed by tag in commit message in all patches.
- update commit message in patch 2 as per comment.
- update reason for reusing PID in commit message.

v5 -> v6:
- update cover letter

v4 -> v5:
- add maxItems to the respective field to constrain io space and
  interrupt in all variants.

v3 -> v4:
- add maxItems field in dt bindings
- update comment in patch2
- dropped PHY driver patch as it is already applied [1]
- update comment in EPF driver patch
- update commect in dtsi and add iommus instead of iommu-map

[1] https://lore.kernel.org/all/169804254205.383714.18423881810869732517.b4-ty@kernel.org/

v2 -> v3:
- removed if/then schemas, added minItems for reg,
  reg-bnames, interrupt and interrupt-names instead.
- adding qcom,sa8775p-pcie-ep compitable for sa8775p
  as we have some specific change to add.
- reusing sm8450's pcs_misc num table as it is same as sa8775p.
  used appropriate namespace for pcs.
- remove const from sa8775p_header as kernel test robot
  throwing some warnings due to this.
- remove fallback compatiable as we are adding compatiable for sa8775p.

v1 -> v2:
- update description for dma
- Reusing qcom,sdx55-pcie-ep compatibe so remove compaitable
  for sa8775p
- sort the defines in phy header file and remove extra defines
- add const in return type pci_epf_header and remove MHI_EPF_USE_DMA
  flag as hdma patch is not ready
- add fallback compatiable as qcom,sdx55-pcie-ep, add iommu property

Mrinmay Sarkar (3):
  dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC
  PCI: qcom-ep: Add support for SA8775P SOC
  arm64: dts: qcom: sa8775p: Add ep pcie0 controller node

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 64 +++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 46 ++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  1 +
 3 files changed, 109 insertions(+), 2 deletions(-)

-- 
2.7.4


