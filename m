Return-Path: <linux-pci+bounces-5416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A23892125
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 17:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F626B2EF18
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E1113342F;
	Fri, 29 Mar 2024 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NkzReF09"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F0612F360;
	Fri, 29 Mar 2024 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711725741; cv=none; b=R2LivTPoBaKm2lIY2cCvboqHKk5BfSFTW9flTHBwu3tilQ0vzNMbpSCRD6wz7fz0bCFTz8b88YkIsqSrM2MgssZ8UMjBRc9U7AX+kK8cH3yW6s323127uVuPhnT+pZ5K01x/sozGG/ZnrHBNtX1hEVBHkVIi+gwHsbVdh7A53iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711725741; c=relaxed/simple;
	bh=p4SC+yLHywyykUuYxg28bcI+hsgPIYZoGLrhHMYDnbE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=R6teVEPlei7GUZ+P+gAM73gdZm9HeAPUOcYm2+oSlQNULHmfJRd8Y7HbBgizwIwkR0esBz8lCAjgddhjyw1Da0zQLfIaLPfBlZ67nEyhLSqtZoPyjy88tbK+5kxTFl58YLs4yMUCXIEFzQ+t864ZVL4p/hdSFJiFW2NWqq7oNo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NkzReF09; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TEMgn3026490;
	Fri, 29 Mar 2024 15:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=qxGHDRjFIxkj
	5jK4q+FlrKCaEaBm6xCwTmJoQeSAiek=; b=NkzReF09GR9GMKgYyhQMf+Y86we5
	/y9x38w+PWz6QDaCEL1Q3hD+ortotpNCCA3Vry/F7LG3zwBXw5KqyFRMkln3WMY+
	ssA+BMflpmzEIO1JaNCX/MGzCkevpAuz6kV5y+SVu9V8IZc1Rud5B4hMmWuwAoWx
	7tjut/ckePQPbK9YWCcDQ8Vv9rJEgmo8Y/qxdpaCiLbDy9zlLKvyET4Q8hVcA6uT
	DXNtm3BYPZLcRLF8c3b6dnlbVUGxgFxUKOtXdMf3DZ4QOzdVZb3/6Sao5EOJf3jz
	B5vXsKG1cB/6FPh8NrDo2BYWR6cOFZYEn7ZK2qMvb3Kg6iEbAyI/FuK9cg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5ybmr429-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 15:22:06 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 42TFM2l5008871;
	Fri, 29 Mar 2024 15:22:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3x1r5mk6gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 29 Mar 2024 15:22:02 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42TFM2LR008857;
	Fri, 29 Mar 2024 15:22:02 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 42TFM2xH008852;
	Fri, 29 Mar 2024 15:22:02 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 22DDC3C2F; Fri, 29 Mar 2024 20:52:01 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        manivannan.sadhasivam@linaro.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_schintav@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/3] arm64: qcom: sa8775p: add support for EP PCIe 
Date: Fri, 29 Mar 2024 20:51:54 +0530
Message-Id: <1711725718-6362-1-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tc3UI3T2t_Ume-cBLrsJNHnF_XkmOLRD
X-Proofpoint-GUID: tc3UI3T2t_Ume-cBLrsJNHnF_XkmOLRD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290135
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

This series adds the relavent DT bindings, new compatible string,
and add EP PCIe node in dtsi file for ep pcie0 controller.

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


