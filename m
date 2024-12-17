Return-Path: <linux-pci+bounces-18591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49F39F4859
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 11:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8FA188C31E
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 10:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29331DF257;
	Tue, 17 Dec 2024 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SXfdwbHW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CC4EEB2;
	Tue, 17 Dec 2024 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429874; cv=none; b=luOERKw6r8GLHZUnoHf9siBk4nxo6w2NThmPHc55VOTxRZMml64bX6J/UjGSuUSU8qWB/8qMgDLqwQ/crcszo+4kdl2vnx8ZtqBccii6qruhLRrwO613LmVvS75DzNyWhWnXNbjIERcsPdUMe+8pW1Y1OSG0ji3L63IrFeWwatQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429874; c=relaxed/simple;
	bh=3G5JJATa59YDLEzh+IqENJgeA+1sekT7Pjj60VnZ+QM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qPBU8VKcLCnZRac/8zZirbMWFz1EiaAj3yZxmjLVZLQJERloznlkPLthvrRUcCW4bI6q8WF0r5YrBVNb76GrE5A3VtB5X8lD4kgxhXbiaaZdCqhlm0Zsa1Hj4TAeZtwQkk3chjLxlY/n81VpDeIr6R2srExkBCZUwRyp8UedMkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SXfdwbHW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH95gOF023920;
	Tue, 17 Dec 2024 10:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=s7DTvSoDkIfbRE4DRtCin3
	O0lmr0jMBQi4+Bx2qNPNw=; b=SXfdwbHWXsDVCrEB1A2ar1bojQa7rOE3IDtgLW
	n6dL4Y8KNGoqkg1UsrX1/tj0Jk/VCfKIBGG4OSFSvFhSTpiwIwkPuZgOQVGdHyr2
	Ka29HuZnf+YnZ/fhRjsKlICW5FG3Q8kEN75XS2jh5/+jsuqcsgyB9+PnFLLAtwkl
	XWIF5Yjcwi9DPxnnBapCCcsqXIa4ViQCmg2nruWLKMc7K+JpNJfoYpmoSCMapMFW
	Udvtig4GzaScZi6oMl3SplINnCZeRv0mi7rxyeb1ZUio2mcwcbC08TtWt9KbtXux
	A1XfTIsLpDmjQ68WmK4VxKSTjgkFCUR2CUv7gUhsUCMvvLGA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43k6c8g5wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 10:04:18 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BHA4H56014049
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 10:04:17 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Dec 2024 02:04:11 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <quic_varada@quicinc.com>,
        <quic_nsekar@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <quic_srichara@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: [PATCH v3 0/5] Add PCIe support for Qualcomm IPQ5332
Date: Tue, 17 Dec 2024 15:33:54 +0530
Message-ID: <20241217100359.4017214-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: 4rqaUzPSDiBrSVjhnF5XgkBbo0pQqOgV
X-Proofpoint-ORIG-GUID: 4rqaUzPSDiBrSVjhnF5XgkBbo0pQqOgV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412170082

Patch series adds support for enabling the PCIe controller and
UNIPHY found on Qualcomm IPQ5332 platform. PCIe0 is Gen3 X1 and
PCIe1 is Gen3 X2 are added.

This series combines [1] and [2]. [1] introduces IPQ5018 PCIe
support and [2] depends on [1] to introduce IPQ5332 PCIe support.
Since the community was interested in [2] (please see [3]), tried
to revive IPQ5332's PCIe support with v2 of this patch series.

v2 of this series pulled in the phy driver from [1] tried to
address comments/feedback given in both [1] and [2].

1. Enable IPQ5018 PCI support (Nitheesh Sekar) - https://lore.kernel.org/all/20231003120846.28626-1-quic_nsekar@quicinc.com/
2. Add PCIe support for Qualcomm IPQ5332 (Praveenkumar I) - https://lore.kernel.org/linux-arm-msm/20231214062847.2215542-1-quic_ipkumar@quicinc.com/
3. Community interest - https://lore.kernel.org/linux-arm-msm/20240310132915.GE3390@thinkpad/

v3: * Update the cover letter with the sources of the patches
    * Rename the dt-bindings yaml file similar to other phys
    * Drop ipq5332 specific pcie controllor bindings and reuse
      ipq9574 pcie controller bindings for ipq5332
    * Please see patches for specific changes
    * Set GPL license for phy-qcom-uniphy-pcie-28lp.c

v2: Address review comments from V1
    Drop the 'required clocks' change that would break ABI (in dt-binding, dts, gcc-ipq5332.c)
    Include phy driver from the dependent series

v1: https://lore.kernel.org/linux-arm-msm/20231214062847.2215542-1-quic_ipkumar@quicinc.com/

Nitheesh Sekar (2):
  dt-bindings: phy: qcom,uniphy-pcie: Document PCIe uniphy
  phy: qcom: Introduce PCIe UNIPHY 28LP driver

Praveenkumar I (2):
  arm64: dts: qcom: ipq5332: Add PCIe related nodes
  arm64: dts: qcom: ipq5332-rdp441: Enable PCIe phys and controllers

Varadarajan Narayanan (1):
  dt-bindings: PCI: qcom: Reuse 'pcie-sdx55' reg bindings for ipq9574

 .../devicetree/bindings/pci/qcom,pcie.yaml    |   2 +-
 .../phy/qcom,ipq5332-uniphy-pcie-phy.yaml     |  82 +++++
 arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts   |  74 +++++
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 212 +++++++++++-
 drivers/phy/qualcomm/Kconfig                  |  12 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 .../phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c  | 302 ++++++++++++++++++
 7 files changed, 682 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml
 create mode 100644 drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c


base-commit: d93148783aea8864ff0a4812324e1657e8e8a686
-- 
2.34.1


