Return-Path: <linux-pci+bounces-6711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F28528B439B
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 03:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C411F22950
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 01:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB33383AC;
	Sat, 27 Apr 2024 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UdYVLNYY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990714C63;
	Sat, 27 Apr 2024 01:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714182841; cv=none; b=DEVyr8BcQgxJgBQ317bobof3HiluglkAqu8Q6Zuz1XZzgqbtXWsji5v83JbfihAA98+1qvjOj2A4mr+dwrOZ96eqQ9/6Rmve9Z3zFvcLqTd5xgjraQqR+oNimvTPEUQ4wy+Apt9JtR+0NRwih15zLp8slOY7KuedPiRI6ZxzYxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714182841; c=relaxed/simple;
	bh=ws9kDSCXhP/j0zDNe5K30ull+cRQqEqRkm3CaRmK7Kk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=FEg0eJcpr4tf5Q6HwSreOcr8oCcrc59kWqDesN/gR4i5NVDa8fXOfPj6Jxpvm0c7DPwK01398G9q+WGPvwHNkXRIsTz47zazSk5mm1Ihb8/1JMJzdryx9mtxaAl4CqQU1dzozPupb2gqu1VB8uih+6u0qUUWGAoAW8ZLC9usTUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UdYVLNYY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43R1o27n019390;
	Sat, 27 Apr 2024 01:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=6qVY2QHU4ftEp7
	G936IjsFXoiOAitJv527DRnnUNNPk=; b=UdYVLNYYWYVDF7YbF4j8rsZMUaLH0H
	HbmfkKvPJau/zNw6omNLK2UgoKTuuvF69XK7GkPKVXuh8aMY/0qD9/T0juJ/zsrG
	+41PCHDoLNI5L6BkhV2DcoGwSHuNaWNry4e2s3EzKHwZ2B/P75DGnDxwItWCAMWS
	PXC416KuEiUNwmuF1Lbe7pOo/KqONA8TTXHDJfoa3vNYdyIUhzjekF+dpRpFcu9u
	Ugwr7GcXhsdiKJA9l/HrIbF7GXMS/gWS97kX2EL/GVLF+ycBwmhE4E44odQnvSf4
	xjDEJHYHm/AkoIzfltMuJlp7zKipLuNyrwtVUGQwTN2fDYedwXCSpRfw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xranmhn7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Apr 2024 01:53:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43R1rjwF003269
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Apr 2024 01:53:45 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 26 Apr 2024 18:53:38 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v12 0/6] PCI: qcom: Add support for OPP
Date: Sat, 27 Apr 2024 07:22:33 +0530
Message-ID: <20240427-opp_support-v12-0-f6beb0a1f2fc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGNaLGYC/23M3wqCMByG4VuJHbf4bW7aOuo+IsL9yx3k1qZSi
 PfeFAKNDr8PnndEyURnEjrtRhTN4JLzbR6E7ndINXV7N9jpfCAKlAGDEvsQbqkPwccOqxoENxI
 KKhnKIkRj3WvJXa55Ny51Pr6X+iDm99upNp1BYMBMlOTItGJcV+dn75Rr1UH5B5pLA4E1F1tOI
 HsieGlKaQpW2D+erDwtfjyZPbdaM5BgBd/6aZo+/FXBaikBAAA=
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
	<bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714182817; l=6284;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=ws9kDSCXhP/j0zDNe5K30ull+cRQqEqRkm3CaRmK7Kk=;
 b=0jbUKvsz9762zw1R5lJ59W1j9trPMpYTMfIzxhcclPG3sXO3cYE1jK2YWUay9QjaiC2xsiWwe
 qdJ7NosM9HHB4Bn2mfuTea5gijifYag2eWTq/+9n+dvdLwICJkVv4Ka
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8qLpTmi0wxEL0opbpuFOQ2sv5XLOhrYa
X-Proofpoint-ORIG-GUID: 8qLpTmi0wxEL0opbpuFOQ2sv5XLOhrYa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_22,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404270012

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
Krishna chaitanya chundru (6):
      arm64: dts: qcom: sm8450: Add interconnect path to PCIe node
      PCI: qcom: Add ICC bandwidth vote for CPU to PCIe path
      dt-bindings: pci: qcom: Add OPP table
      arm64: dts: qcom: sm8450: Add OPP table support to PCIe
      PCI: Bring the PCIe speed to MBps logic to new pcie_link_speed_to_mbps()
      PCI: qcom: Add OPP support to scale performance

 .../devicetree/bindings/pci/qcom,pcie-sm8450.yaml  |   4 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  89 +++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c             | 123 ++++++++++++++++++---
 drivers/pci/pci.c                                  |  19 +---
 drivers/pci/pci.h                                  |  22 ++++
 5 files changed, 222 insertions(+), 35 deletions(-)
---
base-commit: 6c6e47d69d821047097909288b6d7f1aafb3b9b1
change-id: 20240406-opp_support-ca095eb032b4

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


