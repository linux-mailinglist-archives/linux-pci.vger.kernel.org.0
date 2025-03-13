Return-Path: <linux-pci+bounces-23583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A68AA5ED89
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 09:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BCF53AE1FF
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 08:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688A723ED53;
	Thu, 13 Mar 2025 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M7kJdNii"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579FF41C6A;
	Thu, 13 Mar 2025 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741853191; cv=none; b=WrJhA6nqafFMKVs9OwXXwwRy7kWK6trsCtkKBmxf0gCmbBiC+vG1svRzLMbLy+juKW5/+CYGJQtl6vKhbRiQ5MFFgqa/wGb6WUGakEL2SlJ5OMrBaD+7cEHwRgmy1T6fh+JeRyD3Rlek7/QcyEVrIaN78tqnDsUrMdoIfCqDGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741853191; c=relaxed/simple;
	bh=LBQsk7pWbJ3plN+gKd7iBhmAq3lPnkejTkunqLmaITU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sRIcXOmpYN/VKCc0c9vUgHbbf9Ay4V0TUffV+eTY6Ianul29cy1iDvng5YkLdcNa27SxrsQOtKuohbPg5EtMf9QjDAMqtAbHHQWLr8EWHYTzR7W+dRyxbwaZdD4iE/t/YO8h/7krm/zmriD0ZjcVUN+30g+ycwzaXl7WGEwSGhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M7kJdNii; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CNWmlq014066;
	Thu, 13 Mar 2025 08:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DHEa3vwajHslAfOs07KyvX
	Y9nf3wCsme4YiTebbM/zU=; b=M7kJdNiig1qv/I2DrRjsyFFnErDRyF8BF26T6p
	A7yG4LuUcgp+fWTZYbhK8NgKwUa/5J8iQ+0b+eGKX9M/bA2Abk5BdxsjAltiT6KR
	pQYq+eNZ+0XYq62XFhQG/iIUJcpUSpICdfJtYQoYgDWSqMxGvvV19i/DcWxLFQg1
	pPdM68W1+SG/rTHBGCYgzRob4qoMMUmsYofrS8ciLBhPb5shFXKCkX3Lwir3/QTh
	pvusi1c8rRjMF/P8ddaBfuzCSh5ZQUY7FgIxo7hGLyeBabkadZeZksIY7nNoJ/1p
	JACyfKfhxDGzORazQq6jgakaguWAWXsTb4vWS6Un3yjYGeOg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2p54ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 08:06:17 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52D86Gfu006847
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 08:06:16 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Mar 2025 01:06:12 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v13 0/4] Add PCIe support for Qualcomm IPQ5332
Date: Thu, 13 Mar 2025 13:35:56 +0530
Message-ID: <20250313080600.1719505-1-quic_varada@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=ePkTjGp1 c=1 sm=1 tr=0 ts=67d291f9 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=wWAAX9LI6ptjq62IaZgA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: n-sHUT126Q74wEVAXgXdCm_6obyCCRoH
X-Proofpoint-GUID: n-sHUT126Q74wEVAXgXdCm_6obyCCRoH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130062

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

v13: * Update commit log
     * Fix ipq6018 related error
	arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: pcie@20000000: reg-names: ['dbi', 'elbi', 'atu', 'parf', 'config'] is too short
     * Remove fixes tag

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
    * Drop ipq5332 specific pcie controller bindings and reuse
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

 .../devicetree/bindings/pci/qcom,pcie.yaml    |   4 +-
 arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts   |  76 ++++++
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 252 +++++++++++++++++-
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         |  40 ++-
 4 files changed, 361 insertions(+), 11 deletions(-)


base-commit: 9fbcd7b32bf7c0a5bda0f22c25df29d00a872017
-- 
2.34.1


