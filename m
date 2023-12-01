Return-Path: <linux-pci+bounces-331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ECA800A66
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 13:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B4D1C20C69
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 12:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008CA24B33;
	Fri,  1 Dec 2023 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jw5TRQCA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AA2171C;
	Fri,  1 Dec 2023 04:06:36 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B17dVRO022501;
	Fri, 1 Dec 2023 12:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=rVEpqfq7a4wLZc0qYwymebX7KLCz/XpeFGNGTmJrPTU=;
 b=Jw5TRQCAbkNuKJ8ADQBLQGtj97nIm/BGR0TxC6lHL06PHL4h2cvM702FMLibNKrWBdCG
 KE0Gdn96U3C3A0CQ7YJN3GNAkuzQyRwHAaij8lw+Ij1k1DbFw0/jf7bau/xTp+e4WA4o
 gFXyzptCKPaq1a/KPwcWJFCKlwkBoTn1KXNcpMuBE1+aPn2/K5+cFb4xPCJXaF1URLvU
 7qsrkd7RgZD3r01Y8Fsq04xMJwhTdOlWgaFLr73Eh+u0nRbnEUhv4GqYgvh2nW2OCCqg
 U9C3YSreNgL3vq6151UDSbIFu7CXXkGGw1EqmmL6GLhFdftTSNnsFHyDUNesWFhOuyxn qA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uq2kp9jn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Dec 2023 12:06:26 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3B1C6LHV020110;
	Fri, 1 Dec 2023 12:06:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3unmf08shw-1;
	Fri, 01 Dec 2023 12:06:21 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B1C6LOc020105;
	Fri, 1 Dec 2023 12:06:21 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3B1C6L5B020104;
	Fri, 01 Dec 2023 12:06:21 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 11C5B3064; Fri,  1 Dec 2023 17:36:20 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: agross@kernel.org, andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org, mani@kernel.org,
        robh+dt@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        quic_schintav@quicinc.com, quic_shijjose@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev
Subject: [PATCH v9 0/5] arm64: qcom: sa8775p: add support for EP PCIe
Date: Fri,  1 Dec 2023 17:36:11 +0530
Message-Id: <1701432377-16899-1-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VZXBe7aYoFsbXtDXK1Qe83WOImAMIUqw
X-Proofpoint-GUID: VZXBe7aYoFsbXtDXK1Qe83WOImAMIUqw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_09,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 spamscore=0 mlxlogscore=703 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312010080
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

This series adds the relavent DT bindings, new compatible string,
add support to EPF driver and add EP PCIe node in dtsi file for
ep pcie0 controller.

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
- update cover letter.

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


Manivannan Sadhasivam (1):
  PCI: epf-mhi: Add "pci_epf_mhi_" prefix to the function names

Mrinmay Sarkar (4):
  dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC
  PCI: qcom-ep: Add support for SA8775P SOC
  PCI: epf-mhi: Add support for SA8775P
  arm64: dts: qcom: sa8775p: Add ep pcie0 controller node

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 64 +++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 46 ++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  1 +
 drivers/pci/endpoint/functions/pci-epf-mhi.c       | 21 ++++++-
 4 files changed, 128 insertions(+), 4 deletions(-)

-- 
2.7.4


