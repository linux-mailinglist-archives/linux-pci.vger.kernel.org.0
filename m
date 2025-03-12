Return-Path: <linux-pci+bounces-23481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD5DA5D86D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 09:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F3C1899D27
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 08:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2361A23643A;
	Wed, 12 Mar 2025 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AFmaxjhw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5780A22E011;
	Wed, 12 Mar 2025 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741769047; cv=none; b=kYL2oyUpjat5G2aZ0FaUf2UzDiNnXbytTYn9GMupsQ1wPtS5dO2ymhNtXhKohDyUd1xVdxPZxlw+skNfwFgx/x4CWv007ixw2m7TMqVFE/LfgOO1LzKbo7bgCYX54vP46b5dR5d0B/pVNP/+rSTsJRc2Ne3pmBNiGTyiTDo/X1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741769047; c=relaxed/simple;
	bh=Ym0mi6eYJSdvIVVZLG+HIiMDAID7oIUfYdYP90BBlcI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VUsBOKnJRC03vuH8NLX7pwzSkwCUGZWEMbgXzbEqe/wdLKURAITIrY1u7gTdInoPHEBV8DXg87AGmnG1sCwBgGeGrGGsCFp48sMB9ShPWjboLgGIDSt4HxcVWvjKMFDAQOizMFmILTQbOXT4jWSXxcSS4k9R6rVTAYfCQnZ21HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AFmaxjhw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BMI7Iu013547;
	Wed, 12 Mar 2025 08:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tglwuzEeBw42QWJrjPFBAD
	bJwARaRAVKxlVwB6vi4t0=; b=AFmaxjhwGL5gpswBPRvsASQpEjuIu0OCebim+k
	TxRBQr8G0Pu6shRyQDLbTh+KtdsZNl0N6iqfU3AH6LGwACB2VDiNe18NbEsROYYV
	y4Q6QZrZyBpIr7g+ZjC/nNy67x6OZVrulCZnVm90+aHcHsIWxNdFzh/hCPN3flD2
	Z1YgcGwVo8dlkrXJri+UmUw7gc1/J/IFhiji9bMPNIpEsdUwGfEBE83js+MO6RaQ
	BbI7x0OpSpNcbb3J6bjw87aAhEbaV2Uwveh0jan2ijhZKtnmDwlUTu+ywbcdG/Pn
	kEQTHY7yHtY2NdiSK4iqncYdmu7DIgZeA53yRuXG1gCyk3tQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nhqgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 08:43:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52C8hoZE003824
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 08:43:50 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Mar 2025 01:43:45 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <quic_srichara@quicinc.com>,
        <quic_devipriy@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v12 0/4] Add PCIe support for Qualcomm IPQ5332
Date: Wed, 12 Mar 2025 14:13:26 +0530
Message-ID: <20250312084330.873994-1-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=M6hNKzws c=1 sm=1 tr=0 ts=67d14947 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=wWAAX9LI6ptjq62IaZgA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: -sehb4s4NJQZ2rZNROuJoetSPDa0RKjk
X-Proofpoint-GUID: -sehb4s4NJQZ2rZNROuJoetSPDa0RKjk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120058

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

v12: * Skipped the following (Vinod Koul has picked them)
		dt-bindings: phy: qcom,uniphy-pcie: Document PCIe uniphy
		phy: qcom: Introduce PCIe UNIPHY 28LP driver

     * Skipped this (merged)
		dt-bindings: PCI: qcom: Document the IPQ5332 PCIe controller

     * Undo combining sdx55 & ipq9574. Discard the following
		dt-bindings: PCI: qcom: Use sdx55 reg description for ipq9574
		arm64: dts: qcom: ipq9574: Reorder reg and reg-names

     * Append MHI registers to ipq9574 dt-bindings and dts
		dt-bindings: PCI: qcom: Add MHI registers for IPQ9574
		arm64: dts: qcom: ipq9574: Add MHI to pcie nodes

     * ipq5332.dtsi:
		Align reg-names order with ipq9574
		Dropped R-b tag per feedback

     * No new warnings/errors with dt_binding_check and dtbs_check

v11: * phy-qcom-uniphy-pcie-28lp.c
	 * Remove unused #define
	 * Use "250 * MEGA" instead of 250000000

v10: * ipq5332.dtsi: Trim down the list of assigned clocks

     * ipq9574 and ipq5332 DT
	 * Fix 'simple-bus unit address format error' in ipq9574 and
	   ipq5332 DTS
         * Rearrange nodes w.r.t. address sort order

     * Have spoken with 'Manikanta Mylavarapu' [1] for omitting similar
       changes in qcom,pcie.yaml that are handled in this series.

     * Reformat commit messages to 75 character limit

     * controller bindings:
       Fix maxItems for interrupts constraint of sdm845

     1 - https://lore.kernel.org/linux-arm-msm/20250125035920.2651972-2-quic_mmanikan@quicinc.com/

v9: Dont have fallback for num-lanes in driver and return error
    Remove superfluous ipq5332 constraint as the fallback is present

v8: Add reviewed by
    Remove duplication in bindings due to ipq5424 code getting merged

v7: phy bindings:
    * Include data type definition to 'num-lanes'

    controller bindings:
    * Split the ipq9574 and ipq5332 changes into separate patches

    dtsi:
    * Add root port definitions

v6: phy bindings:
    * Fix num-lanes definition

    phy driver:
    * Fix num-lanes handling in probe to use generally followed pattern

    controller bindings:
    * Give more info in commit log

    dtsi:
    * Add assigned-clocks & assigned-clock-rates to controller nodes
    * Add num-lanes to pcie0_phy

v5: phy bindings:
    * Drop '3x1' & '3x2' from compatible string
    * Use 'num-lanes' to differentiate instead of '3x1' or '3x2'
      in compatible string
    * Describe clocks and resets instead of just maxItems

    phy driver:
    * Get num-lanes from DTS
    * Drop compatible specific init data as there is only one
      compatible string

    controller bindings:
    * Re-arrange 5332 and 9574 compatibles to handle fallback usage in dts

    dtsi:
    * Add 'num-lanes' to "pcie1_phy: phy@4b1000"
    * Make ipq5332 as main and ipq9574 as fallback compatible
    * Sort controller nodes per address

    misc:
    Add R-B tag from Konrad to dts and dtsi patches

v4: * phy bindings - Create ipq5332 compatible instead of reusing ipq9574 for bindings
    * phy bindings - Remove reset-names as the resets are handled with bulk APIs
    * phy bindings - Fix order in the 'required' section
    * phy bindings - Remove clock-output-names
    * dtsi - Add missing reset for pcie1_phy
    * dtsi - Convert 'reg-names' to a vertical list
    * dts - Fix nodes sort order
    * dts - Use property-n followed by property-names

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


Praveenkumar I (2):
  arm64: dts: qcom: ipq5332: Add PCIe related nodes
  arm64: dts: qcom: ipq5332-rdp441: Enable PCIe phys and controllers

Varadarajan Narayanan (2):
  dt-bindings: PCI: qcom: Add MHI registers for IPQ9574
  arm64: dts: qcom: ipq9574: Add MHI to pcie nodes

 .../devicetree/bindings/pci/qcom,pcie.yaml    |   3 +-
 arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts   |  76 ++++++
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 252 +++++++++++++++++-
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         |  40 ++-
 4 files changed, 360 insertions(+), 11 deletions(-)


base-commit: eea255893718268e1ab852fb52f70c613d109b99
prerequisite-patch-id: 56fe29d9207ac31ab08ca54712adc2a865b7be89
prerequisite-patch-id: f50f4b13ea072aea4beae5d5ecaf62336d9d2a31
-- 
2.34.1


