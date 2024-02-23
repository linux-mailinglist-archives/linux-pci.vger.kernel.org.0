Return-Path: <linux-pci+bounces-3919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A11286148B
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 15:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DDBCB21C91
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4045481AAD;
	Fri, 23 Feb 2024 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AECitTCG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F91781ABE;
	Fri, 23 Feb 2024 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699713; cv=none; b=i2m31C2TQRq0nx29X8n1GvmZQt0/3o9wGPIcR7tRBcySpC+GplnkUFUdynwkJzfWUTWwmBH0D0eOFthHFYYPKRij7HGw/qSErhvHr1tc+WpJzgYyYnpQysOd7FWX+F9AnZsXuTb5dRej6ldYNkkIPcXiF4D5HLYX3LLYYqT6Fuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699713; c=relaxed/simple;
	bh=haKR2PiRK3gLMnEX7sMNAB/zUotyP4ntW+xdSXrXZb0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=iTFXYHmF5z9OqwUd+PGJjrMWIfGMKFkrNp2TYJS2/6ua5LAu3EyT1wO6Ust7VRSwSPkMBOX7+RP/nQQ9GU6krri76cCBwg0g+5qjGlUEsc96LTYxjEoTsylhoTmNKQDLAkZTgP86qOlE5rzm012c1gB3WHJzriUF+mt5p62MkVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AECitTCG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NCVG0v022251;
	Fri, 23 Feb 2024 14:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=HhT0IwY1E8QVOT
	a/gU1QFx/QbzcW3wm8gTm1Q8NCR94=; b=AECitTCGyeXUxCiPyA3GUAfvXUVUKe
	k/LnrkeEKsn+OjO1wWN11wPf+0LonQ2uEoM7VqKRYmYVtTwfCkhF0puMm/Mo77yg
	ksI0cw8/Rx4G9L3gH3gcmT2kXFH/e7EpGad5ig/1smtuBvA+NJJ9vSuMomYei1te
	ks6HTTbabP8VmYk//SeEPtcjd6g5cnrcGN6kyrBQMRWyIAFR9y2NpitIrbqga1Xm
	NOg6ryEdpNbOwi0OsDjbbIGRfd/+EuyfhmK9Hs8HC7HwkfuiMW3yBTn2KSIWF92H
	R42AayR7KKRtyH++4XP9h2HUKsnu9O7+An748xCvva6jgwUKTJW5akXw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we3233ee0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:48:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NEmKkX016777
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:48:20 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 06:48:13 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v7 0/7] PCI: qcom: Add support for OPP
Date: Fri, 23 Feb 2024 20:17:57 +0530
Message-ID: <20240223-opp_support-v7-0-10b4363d7e71@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB+w2GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyMj3fyCgvji0oKC/KISXUPLRINkU+OkVMM0EyWgjoKi1LTMCrBp0bG
 1tQCWVL5aXQAAAA==
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Brian Masney
	<bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708699692; l=4313;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=haKR2PiRK3gLMnEX7sMNAB/zUotyP4ntW+xdSXrXZb0=;
 b=eKRTPissHKWC9t/nPZpBx75wxNYefmbrHKZ99XAW8VlvlMXTq5gyAdHhssH7biBZvAXHVdjli
 OOKvSocSHj4As0pFD1SzbkAqh4MnEAdj0FEtxy9RCgNL64l6wUg2PhX
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: R10j8rv04QEYObypA7RCJyODBAtZSJIS
X-Proofpoint-GUID: R10j8rv04QEYObypA7RCJyODBAtZSJIS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230108

This patch adds support for OPP to vote for the performance state of RPMH
power domain based upon PCIe speed it got enumerated.

QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
maintains hardware state of a regulator by performing max aggregation of
the requests made by all of the processors.

PCIe controller can operate on different RPMh performance state of power
domain based up on the speed of the link. And this performance state varies
from target to target.

It is manadate to scale the performance state based up on the PCIe speed
link operates so that SoC can run under optimum power conditions.

Add Operating Performance Points(OPP) support to vote for RPMh state based
upon GEN speed link is operating.

Before link up PCIe driver will vote for the maximum performance state.

As now we are adding ICC BW vote in OPP, the ICC BW voting depends both
GEN speed and link width using opp-level to indicate the opp entry table
will be difficult.

In PCIe certain gen speeds like GEN1x2 & GEN2X1 or GEN3x2 & GEN4x1 use
same icc bw if we use freq in the OPP table to represent the PCIe Gen
speed number of PCIe entries can reduced.

So going back to use freq in the OPP table instead of level.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
Changes from v6:
	- change CPU-PCIe bandwidth to 1KBps as suggested by HW team.
	- Create a new API to get frequency based upon PCIe speed as suggested
	  by mani.
	- Updated few commit texts and comments.
	- Setting opp to NULL in suspend to remove any votes.
	- Link for v6: https://lore.kernel.org/linux-arm-msm/20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com/
Changes from v5:
	- Add ICC BW voting as part of OPP, rebase the latest kernel, and only
	- either OPP or ICC BW voting will supported we removed the patch to
	- return error for icc opp update patch.
	- As we added the icc bw voting in opp table I am not including reviewed
	- by tags given in previous patch.
	- Use opp freq to find opp entries as now we need to include pcie link
	- also in to considerations.
	- Add CPU-PCIe BW voting which is not present till now.
	- Drop  PCI: qcom: Return error from 'qcom_pcie_icc_update' as either opp or icc bw
	- only one executes and there is no need to fail if opp or icc update fails.
	- Link for v5: https://lore.kernel.org/linux-arm-msm/20231101063323.GH2897@thinkpad/T/
Changes from v4:
	- Added a separate patch for returning error from the qcom_pcie_upadate
	  and moved opp update logic to icc_update and used a bool variable to 
	  update the opp.
	- Addressed comments made by pavan.
changes from v3:
	- Removing the opp vote on suspend when the link is not up and link is not
	  up and add debug prints as suggested by pavan.
	- Added dev_pm_opp_find_level_floor API to find the highest opp to vote.
changes from v2:
	- Instead of using the freq based opp search use level based as suggested
	  by Dmitry Baryshkov.
Changes from v1:
        - Addressed comments from Krzysztof Kozlowski.
        - Added the rpmhpd_opp_xxx phandle as suggested by pavan.
        - Added dev_pm_opp_set_opp API call which was missed on previous patch.

---

---
Krishna chaitanya chundru (7):
      dt-bindings: PCI: qcom: Add interconnects path as required property
      arm64: dts: qcom: sm8450: Add interconnect path to PCIe node
      PCI: qcom: Add ICC bandwidth vote for CPU to PCIe path
      dt-bindings: pci: qcom: Add opp table
      arm64: dts: qcom: sm8450: Add opp table support to PCIe
      PCI: Bring out the pcie link speed to MBps logic to new function
      PCI: qcom: Add OPP support to scale performance state of power domain

 .../devicetree/bindings/pci/qcom,pcie.yaml         |   6 ++
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  82 +++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c             | 110 ++++++++++++++++++---
 drivers/pci/pci.c                                  |  19 +---
 drivers/pci/pci.h                                  |  24 +++++
 5 files changed, 208 insertions(+), 33 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240222-opp_support-19a0c53be1f4

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


