Return-Path: <linux-pci+bounces-21888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 236E2A3D51C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 10:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD89189EA80
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 09:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4142F1F12FF;
	Thu, 20 Feb 2025 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kqDW+D54"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782F41F0E3A;
	Thu, 20 Feb 2025 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044610; cv=none; b=L6zGfrXHrmN8ot0MjahTPP23e0E5Z9+YTNCqLx6e78DlKzVCgvm03Nx1IRTd1pEfHlZBW/P8aUde8TdlmRjs4/JcpFTirIB6p8n9fpP+QLcZcWsfUHoa7b/U6T0LaxjCxx2Kxc/i756Vs8MCi9u3skg5mydYANnjVsnAomtQe5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044610; c=relaxed/simple;
	bh=uSDLqItGD3L1FQV4mEYVTpdub/jx/56zOZ44eyIzKPk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fIHUUFrbzdLEzVwTOUretXg8TesuS4N8DKt1/WUZSEchAqm6mwlRi8IX4a6gWBaXRg3j7xCLBzs85AWcl7duz6ZONZtTKrX3iqBQpOoIdFwOS7xfEwtYu84/SijoLPcb5HJ2Wq7fvxUAq/lErnv3nJh3NwefQkn4hDrn/upuQbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kqDW+D54; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K7Yhps002702;
	Thu, 20 Feb 2025 09:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SxKnIlYHnTnDxEpKvRM+TL
	mqxd+zV1ylWA+dJawlvTA=; b=kqDW+D54AOk43EfZmVgs1gPlcBbMWJi8z29OgZ
	zaluLJXPqQL5N4UJK+cPwGnpnF+1HtGWBgf9lirmMKhkjKwJFgv79rK7anS0kjfT
	/kVOu6eLwg842DZRp6Hi8ICg9NSO6JNziLQfnVlEToyTJ86Z2R/CR/OlqYqnJlW/
	OEhz7wo0dcwldUshs7efvWCMT5LFXqMaQOXBn/lY+EK7pp9cy4G1cfSmVj5ZWsNL
	9c2HlClR6Am6GKhCht7NEolbJssGO33yNEZh0ysi6utzOi5+Aq280+iaE+P7Jge0
	lc/BcW1YQudQuvBAGi6daJqj7gYGRM9+1LeujzEobrXmmnOQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy2dnu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 09:43:09 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51K9h8xL010190
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 09:43:08 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 20 Feb 2025 01:43:02 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <quic_varada@quicinc.com>,
        <quic_nsekar@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH v11 0/7] Add PCIe support for Qualcomm IPQ5332
Date: Thu, 20 Feb 2025 15:12:44 +0530
Message-ID: <20250220094251.230936-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: l8iwqCd-7CN29UNXDXtqn1UiCxrAQI5Y
X-Proofpoint-GUID: l8iwqCd-7CN29UNXDXtqn1UiCxrAQI5Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200071

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

Nitheesh Sekar (2):
  dt-bindings: phy: qcom,uniphy-pcie: Document PCIe uniphy
  phy: qcom: Introduce PCIe UNIPHY 28LP driver

Praveenkumar I (2):
  arm64: dts: qcom: ipq5332: Add PCIe related nodes
  arm64: dts: qcom: ipq5332-rdp441: Enable PCIe phys and controllers

Varadarajan Narayanan (3):
  dt-bindings: PCI: qcom: Use sdx55 reg description for ipq9574
  arm64: dts: qcom: ipq9574: Reorder reg and reg-names
  dt-bindings: PCI: qcom: Document the IPQ5332 PCIe controller

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  10 +-
 .../phy/qcom,ipq5332-uniphy-pcie-phy.yaml     |  76 ++
 arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts   |  76 ++
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 252 +++++-
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 837 +++++++++---------
 drivers/phy/qualcomm/Kconfig                  |  12 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 .../phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c  | 286 ++++++
 8 files changed, 1134 insertions(+), 416 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml
 create mode 100644 drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c


base-commit: e5d3fd687aac5eceb1721fa92b9f49afcf4c3717
-- 
2.34.1


