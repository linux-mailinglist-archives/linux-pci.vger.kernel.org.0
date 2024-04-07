Return-Path: <linux-pci+bounces-5826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91DD89AE78
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 06:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC5CB2288D
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 04:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7F617F0;
	Sun,  7 Apr 2024 04:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ndotrAVp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0857517C9;
	Sun,  7 Apr 2024 04:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712464687; cv=none; b=j3GlOIIi4ZqkS+q/rIrmOPQ/aS+pvmSp7xeE+p5SXQm9PA71gmeGZzRCKZo6JzFds9roNCi50iROhd0hSKcOt4od31qaiLjl65pIdzV2sArypHoV0M2q+UZfnt+Hm//9GpD3FVH5MTLKBYk8qIytHpkTQjlIiN2b8aYlUpBloLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712464687; c=relaxed/simple;
	bh=bW2DldrWcxnrtDpGxMoBi3oMLXtAofTqINPsoIfyOV8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=YSAWDVZoaIgrP3lvJCHnnpV0B09HJqY3K/m18rhLr+i3uJJ8oT8jpfRUXoh5nJiBEjSON/gy2pDxE5VgIe2eqk4iA20jz9QpQ/rIl8PDRgeBKMeDtO5qHnwgrieyLLnaJ1mOKNVoero7kDhacCAoDIi21ssryOl7587NDmxPKM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ndotrAVp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4374HpNY012224;
	Sun, 7 Apr 2024 04:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=g2hXgSZqX4BDcK
	uampvuHZWhwFERz8RNDfGV4yazUjg=; b=ndotrAVpVVu69ljPA36rcYpmkKXtkg
	q+l5lGM7T1rZ/HrTXz2IMrBL85b2lXyaWjzJxbAnmI47hhbiq+audLUSQ1Bg+uGU
	k/QDX1g4COE0AHVulFQVYiQMsB1bLYJxS8KWee0e0WkCCJQjBRD2kbDazPxdjO1I
	hra0WY5iIjC/7cGryll54Ht+HeA8iOHXseQrtEpxrpKVGvUVMlC4AHavfnvvctQT
	+lxT9MXU8v+5qNBeZ1F7XLg1EEkZse5/ZXNDY0hjZLHDCsTBBhjnxTo/4FIr9U9W
	v4AOwjdQSVgLoVofjNMcQ9LGdjKiWqiNr4NfvsZM0UBDpWqDajLmM6Iw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xayjys9sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Apr 2024 04:37:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4374bs7W031060
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 7 Apr 2024 04:37:54 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 6 Apr 2024 21:37:47 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v9 0/6] PCI: qcom: Add support for OPP
Date: Sun, 7 Apr 2024 10:07:33 +0530
Message-ID: <20240407-opp_support-v9-0-496184dc45d7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA8jEmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyLHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEwMz3fyCgvji0oKC/KIS3eREA0vT1CQDY6MkEyWgjoKi1LTMCrBp0bG
 1tQA0hc1+XQAAAA==
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <johan+linaro@kernel.org>,
        <bmasney@redhat.com>, <djakov@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>, <quic_krichai@quicinc.com>,
        <krzysztof.kozlowski@linaro.org>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712464666; l=5054;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=bW2DldrWcxnrtDpGxMoBi3oMLXtAofTqINPsoIfyOV8=;
 b=IpQPfb1iGSojYULpmuF7XhM3oq//iEb6eF1QHFakvUul7cq3JMElGEpinjmSwzxMoO/eynNE7
 FsDJWpdVBMgDnODPHQEROYvjuf7ebSrhFXv57mNjhW4q62Z6+nhl7B5
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yIkEH4GDwGoZhYeehb0iVLUb5VfkGHXk
X-Proofpoint-GUID: yIkEH4GDwGoZhYeehb0iVLUb5VfkGHXk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-07_01,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 clxscore=1011
 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404070032

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
Changes from v8:
	- Removed the ack-by and reviewed by on dt-bindings as dt-bindings moved to new files.
	- Removed dt-binding patch for interconnects as it is added in the common file.
	- Added tags for interconnect as suggested by konrad
	- Added the comments as suggested by mani
	- In ICC BW vote for CPU to PCIe path if icc_disable() fails log error and return instead of re-init.
	- Link to v8: https://lore.kernel.org/linux-arm-msm/20240302-opp_support-v8-0-158285b86b10@quicinc.com/
Changes from v7:
	- Fix the compilation issue in patch3
	- Change the commit text and wrap the comments to 80 columns as suggested by bjorn
	- remove PCIE_MBS2FREQ macro as this is being used by only qcom drivers.
	- Link to v7: https://lore.kernel.org/r/20240223-opp_support-v7-0-10b4363d7e71@quicinc.com
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
Krishna chaitanya chundru (6):
      arm64: dts: qcom: sm8450: Add interconnect path to PCIe node
      PCI: qcom: Add ICC bandwidth vote for CPU to PCIe path
      dt-bindings: pci: qcom: Add opp table
      arm64: dts: qcom: sm8450: Add opp table support to PCIe
      PCI: Bring the PCIe speed to MBps logic to new pcie_link_speed_to_mbps()
      PCI: qcom: Add OPP support to scale performance state of power domain

 .../devicetree/bindings/pci/qcom,pcie-sm8450.yaml  |   4 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  89 +++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c             | 108 +++++++++++++++++----
 drivers/pci/pci.c                                  |  19 +---
 drivers/pci/pci.h                                  |  22 +++++
 5 files changed, 207 insertions(+), 35 deletions(-)
---
base-commit: 6c6e47d69d821047097909288b6d7f1aafb3b9b1
change-id: 20240406-opp_support-ca095eb032b4

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


