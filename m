Return-Path: <linux-pci+bounces-8988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A56E90F1C1
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 17:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB3C1C228EA
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 15:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0744880BF2;
	Wed, 19 Jun 2024 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mVDnB1OM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443B03FB8B;
	Wed, 19 Jun 2024 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809895; cv=none; b=l74UfkFyhh79ElAxX7BmL/ls7A8mFzEuTpYfweZ6wQ0l73K0AZTX3Prvfiu2eXGcKRy/o8qiwPn0ltItr1bfB+P4Y+/M7SIDua0fxVxcsvoV7PJLU9pjtlqrNth8tG1KUA+YTcqZfdWEXeDsGLAHKnDAaTLhZ8pj3qALEUWLZ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809895; c=relaxed/simple;
	bh=DcgdnxN/g6m/zZ3fnYMpQWzSialTIdVMv1WoOeSbk0g=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=HTKMX+nrrS7EWfdLxpv590VClpvSNANChWUzaGTDpP2LJySKgaZcMjAI6MlpJeB+5/stS8yxZSijY2sWFK9jq0PF2OzzDDbJFW+YQuU36iY1x/+oqg6wo474fBHA8pAIjVTQdYPaNamarSqUx5uF0K2hQMc+6vXRjGZMpM/5wzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mVDnB1OM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JAFnRm026811;
	Wed, 19 Jun 2024 15:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xn6mSaR3tBzZRlgTf1Pjpr
	nPwP6+zuC7aJT77deoiJ4=; b=mVDnB1OMYhUg6OczakWbVZumw2pHPwhUCYsNAR
	0GcPICWMpaUUWV9UxW9tUxyHso4+HvEUiZCnyq7+reh9Ttz6NmNcXX7pukkLBfjQ
	URnJ4pGMJoadhCuZLRIb6NXcvrtFoZ31kzDYo8CYFnfu3seSg4vdkdbi7Uv8/p88
	iZ2eOcRgSuvJwzBeCyiHdVAMruHkxUgO9KhMk8njlYUqEC4KqMNTdqaogdyfc0pF
	nabgrzN8RD7XmsDlK8nDzYSYm8fKN5HIMKt1h4xDxmXrLxTzRfX4yiZs+ebYb2Wy
	PUJhmhvWCFoHRcp77gLbkA+6w/LmiHcQgtQsOuck2aZX8M5w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuj9yt3sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 15:11:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45JFBOet001556
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 15:11:24 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Jun 2024 08:11:19 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v15 0/4] PCI: qcom: Add support for OPP
Date: Wed, 19 Jun 2024 20:41:09 +0530
Message-ID: <20240619-opp_support-v15-0-aa769a2173a3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAA31cmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDE11FJSSM
 xLz0lN1M1OAAkpGBkYmBmaGFrr5BQXxxaUFBflFJbpGieZmycZmpsmGKUZKQB0FRalpmRVg46J
 ja2sBPaQmnl4AAAA=
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC: <quic_vbadigan@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718809879; l=6672;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=DcgdnxN/g6m/zZ3fnYMpQWzSialTIdVMv1WoOeSbk0g=;
 b=2/w9NTRZW/9YZNC+KSz4PlFQFKHF55J7j3XdkcgQ4922ug9foKlkZ4hjjS9w7EAwoI6oVNM7T
 jayO2Vq2GWiD8ltsG/0uhUHqZVGkx4HHoLBgl69AXSmD0gfyX2QJLwE
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b6nI8Xs5c8Fa8mKqQysNTpDFmrA7-vBc
X-Proofpoint-GUID: b6nI8Xs5c8Fa8mKqQysNTpDFmrA7-vBc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190114

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

In PCIe certain gen speeds like 2.5GT/s x2 & 5.0 GT/s X1 or 8.0 GT/s x2 &
16GT/s x1 use same ICC bw if we use freq in the OPP table to represent the
PCIe speed number of PCIe entries can reduced.

So going back to use freq in the OPP table instead of level.

To access PCIe registers of the host controller and endpoint PCIe
BAR space, config space the CPU-PCIe ICC (interconnect) path should
be voted otherwise it may lead to NoC (Network on chip) timeout.
We are surviving because of other driver voting for this path.

As there is less access on this path compared to PCIe to mem path
add minimum vote i.e 1KBps bandwidth always which is sufficient enough
to keep the path active and is recommended by HW team.

In suspend to ram case there can be some DBI access. Except in suspend
to ram case disable CPU-PCIe ICC path after register space access
is done.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
Changes from v14:
	- Couple of nits suggested by Ilpo Järvinen
	- Link to v14: https://lore.kernel.org/linux-arm-msm/20240609-opp_support-v14-0-801cff862b5a@quicinc.com/T/
Changes from v13:
	- Rebased the patch series on top of pci next.
	- Link to v13: https://lore.kernel.org/linux-arm-msm/20240518-opp_support-v13-0-78c73edf50de@quicinc.com/
Changes from v12:
	- removed icc bw of the memory path as suggested by mayank
	- Added check for icc_set_bw in the suspend path as suggested by mani.
	- Link to v12: https://lore.kernel.org/r/20240427-opp_support-v12-0-f6beb0a1f2fc@quicinc.com
Changes from v11:
	- added nicpicks suggested by mani.
	- Link to v11: https://lore.kernel.org/r/20240423-opp_support-v11-0-15fdd40b0f95@quicinc.com
Changes from v10:
	- Updated comments and logs as suggested by mani.
	- Link to v10: https://lore.kernel.org/r/20240409-opp_support-v10-0-1956e6be343f@quicinc.com
Changes from v9:
	- Disable interconnect CPU-PCIe path only system is not suspend to ram case.
	- If opp find freq fails in the probe fail the probe as suggested by mani.
	- Modify comments as suggested by mani
	- Link to v9: https://lore.kernel.org/r/20240407-opp_support-v9-0-496184dc45d7@quicinc.com
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
Krishna chaitanya chundru (4):
      PCI: qcom: Add ICC bandwidth vote for CPU to PCIe path
      dt-bindings: pci: qcom: Add OPP table
      PCI: Bring the PCIe speed to MBps logic to new pcie_dev_speed_mbps()
      PCI: qcom: Add OPP support to scale performance

 .../devicetree/bindings/pci/qcom,pcie-sm8450.yaml  |   4 +
 drivers/pci/controller/dwc/pcie-qcom.c             | 138 +++++++++++++++++----
 drivers/pci/pci.c                                  |  19 +--
 drivers/pci/pci.h                                  |  22 ++++
 4 files changed, 144 insertions(+), 39 deletions(-)
---
base-commit: 3bf9044d466637eaa28b87c4d6491dbfbe1b14ea
change-id: 20240618-opp_support-2a76c365c1d2

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


