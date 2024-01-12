Return-Path: <linux-pci+bounces-2100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 673BF82C183
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 15:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F98A1C2215A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 14:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE46B6DCEC;
	Fri, 12 Jan 2024 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LCM7Xpej"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48253537E6;
	Fri, 12 Jan 2024 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CDGp7K005990;
	Fri, 12 Jan 2024 14:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=Qm7o6bH8UVSUpx
	L/qtsM2qZhfc8EIq6ci44HkAJiWTk=; b=LCM7Xpej1m+XX3xIhGq85Cx4YgTthg
	uh7The2GByO2NsBSFx/p9WNxuUm4hfe4YnTe1U9FkFDCALLtdRLzIJbt8vM2NKIH
	cxhR8gYrmqaOupM68RgMSaka/fX1gk1QDWb4xfgI7JjCG63+NEBBolW22qMeKdNI
	5rmY/58NNI1PKls56lB9+6Luq4bDUSz7Bhr3sKpAL0RjTNWwHqWKG3RiGfjmd292
	HM7TJEPjLsGlpSiRXPQAaihF083/jsj4aaHT4hq6m7hnaGFXcy1LkBcUwV9c6gkE
	OOX+mVEYGHf/7bdO9GSqsKZ0zZ6l36s1u8x4qHsFaU+13IH7IrWkNCFQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjrqj21pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 14:22:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40CEMK9k012100
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 14:22:20 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 12 Jan 2024 06:22:13 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v6 0/6] PCI: qcom: Add support for OPP
Date: Fri, 12 Jan 2024 19:51:59 +0530
Message-ID: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAlLoWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHQUlJIzE
 vPSU3UzU4B8JSMDIxMDQ0Mj3fyCgvji0oKC/KISXeNEQwtjy2SzRENzQyWgjoKi1LTMCrBp0bG
 1tQBPdsBfXQAAAA==
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Brian Masney <bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <vireshk@kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Krishna
 chaitanya chundru" <quic_krichai@quicinc.com>,
        <stable@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam
	<mani@kernel.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705069332; l=3741;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=9kevASbFSlCa+E9D4QNcPS8Hm0GHBKXoPdtlEYKpU/I=;
 b=TkbG+97xSskiAuMM7ujhw/fz19PSVsYk/JtTjmnxRbr7ObgM4feJbxMkSc5ZAa7JrhVEcfqzg
 edWA125UvkMCSPCd7gq1LgaZPYRHWklNm74uwlxYon8RfuUI9li5Ne5
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E_e2NKtgP26VpO_TI45SSss7BBctYDWY
X-Proofpoint-GUID: E_e2NKtgP26VpO_TI45SSss7BBctYDWY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 clxscore=1011 adultscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401120113

This patch adds support for OPP to vote for the performance state of RPMH
power domain based upon GEN speed it PCIe got enumerated.

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
same icc bw if we use freq in the opp table to represent the PCIe Gen
speed number of PCIe entries can reduced.

So going back to use freq in the opp table instead of level.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
Changes frm v5:
	- Add ICC BW voting as part of OPP, rebase the latest kernel, and only
	- either OPP or ICC BW voting will supported we removed the patch to
	- return eror for icc opp update patch.
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
Krishna chaitanya chundru (6):
      dt-bindings: PCI: qcom: Add interconnects path as required property
      arm64: dts: qcom: sm8450: Add interconnect path to PCIe node
      PCI: qcom: Add missing icc bandwidth vote for cpu to PCIe path
      dt-bindings: pci: qcom: Add opp table
      arm64: dts: qcom: sm8450: Add opp table support to PCIe
      PCI: qcom: Add OPP support to scale performance state of power domain

 .../devicetree/bindings/pci/qcom,pcie.yaml         |   6 ++
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  82 +++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c             | 114 ++++++++++++++++++---
 3 files changed, 187 insertions(+), 15 deletions(-)
---
base-commit: 70d201a40823acba23899342d62bc2644051ad2e
change-id: 20240112-opp_support-3a1839c6a171

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


