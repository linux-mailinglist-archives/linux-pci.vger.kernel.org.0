Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89B86969F1
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 17:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjBNQmp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 11:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjBNQmo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 11:42:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CC71BC6;
        Tue, 14 Feb 2023 08:42:26 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E0fCB3012982;
        Tue, 14 Feb 2023 16:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=PZNsfcpSNgi6XSftsTxLifara0hUhG2V7agojxm3mJQ=;
 b=ZKb9LGMaqRV346KkqqLVXGQg/28E5ckR8GT1DL7gNeD36sGnImmIpLVJ7aTdsVIVp2QP
 raN/0Qh3lCi9Y+hsmo2VcB2zvDwVdNLRRvNX7/ymtE+WiCAs3PXo1tT6kHz76GJET6y4
 k6UPx7qgt/NVAvtM4Du3zvzgdiJQpgA1rAFPl2TJ2m8dGlWJhOgCuon+6wQupIVVzla+
 MZWnnRw/f84n4zcMqgdxrNDjT+tjQPNEpt+l7S7uFSdkbkLiduTO+CIgKvk5qDewU9OK
 NVHvxoZIg67o9wLrgvJk4VWDSHk2HyijkjXPeVqVkykGGx5U5JhJIYiKJpfIJoktT+gJ cg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqyygt3tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 16:42:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31EGg7tf002753
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 16:42:07 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 08:42:00 -0800
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <mani@kernel.org>, <p.zabel@pengutronix.de>,
        <svarbanov@mm-sol.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>
Subject: [PATCH 0/7] Add PCIe support for IPQ9574
Date:   Tue, 14 Feb 2023 22:11:28 +0530
Message-ID: <20230214164135.17039-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QOfNvi5NJaTEc2br4e0KXsGlWhFeT3i8
X-Proofpoint-GUID: QOfNvi5NJaTEc2br4e0KXsGlWhFeT3i8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_11,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 mlxlogscore=789 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140142
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
are found on IPQ9574 platform. The PCIe0 & PCIe1 are 1-lane
Gen3 host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.

This series adds support for enabling the same

DTS patch is based on the crashdump series
https://lore.kernel.org/linux-arm-kernel/20230214051414.10740-1-quic_poovendh@quicinc.com/

Devi Priya (7):
  dt-bindings: PCI: qcom: Add IPQ9574 specific compatible
  PCI: qcom: Add IPQ9574 PCIe support
  dt-bindings: phy: qcom,qmp-pcie: Add ipq9574 compatible
  phy: qcom-qmp-pcie: Add support for IPQ9574 platform
  dt-bindings: clock: Add PCIe pipe clock definitions
  clk: qcom: gcc-ipq9574: Add PCIe related clocks
  arm64: dts: qcom: ipq9574: Add PCIe PHYs and controller nodes

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  72 ++-
 .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        |  28 +
 arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts  |  28 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 477 +++++++++++++++++-
 drivers/clk/qcom/gcc-ipq9574.c                |  76 +++
 drivers/pci/controller/dwc/pcie-qcom.c        | 119 +++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 309 ++++++++++++
 .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  26 +-
 .../phy/qualcomm/phy-qcom-qmp-qserdes-pll.h   |   3 +
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  | 276 +++++-----
 10 files changed, 1264 insertions(+), 150 deletions(-)


base-commit: 3ebb0ac55efaf1d0fb1b106f852c114e5021f7eb
-- 
2.17.1

