Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA06B6D6935
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 18:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjDDQtN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 12:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjDDQtJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 12:49:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684EFE7B;
        Tue,  4 Apr 2023 09:49:08 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334E5hE9000809;
        Tue, 4 Apr 2023 16:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=xq5sbhEZFEE7jSOavNjgMoKUDELZyorIuW0tEx2/Ho8=;
 b=bNi5vFsRqC1WGWHdGg4HKnWEo5RsDAQCLAE8AfKBhUY49vY/DaxOPczRzpj0DZYhlKP6
 +McpLUAXTsKC4KCq1eiv/NzO+iYgV6EPI20Dkc9+6zpLKUhhVyraJqPfubEM430qEh+l
 qhPcJ8GHXy2ADCzA4YmgddIk5L0HrVNgJEFx5jcTwmspIaNG8WHZJ8EbioiwHlaDtK1n
 LCMfUwz7SU3b+Hg+sgQ75NstKAn2EBJJ7S0KbsR5jp/AodL53iebetv/LBVeIKqtYFzf
 fdkMteobzUg94OerAWphLQEiqMlBJwSlFekt+Zzs55HUHQI5ZHrZXBSXN1HQMhB4+aU3 +Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prnbt0fh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 16:48:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 334GmqML005062
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Apr 2023 16:48:52 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 4 Apr 2023 09:48:43 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <mani@kernel.org>, <p.zabel@pengutronix.de>,
        <linus.walleij@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_ipkumar@quicinc.com>
Subject: [PATCH V2 0/9] Add PCIe support for IPQ9574
Date:   Tue, 4 Apr 2023 22:18:19 +0530
Message-ID: <20230404164828.8031-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Wy0ULt0xuLpRLu0KwbayI96Plg9KvEmW
X-Proofpoint-GUID: Wy0ULt0xuLpRLu0KwbayI96Plg9KvEmW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_08,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=628
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1011 adultscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040155
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
are found on IPQ9574 platform. The PCIe0 & PCIe1 are 1-lane
Gen3 host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.

This series adds support for enabling the same

DTS patch is based on the below series
https://lore.kernel.org/linux-arm-msm/20230329053726.14860-1-quic_kathirav@quicinc.com/

Changes in V2:
	- Reordered the patches and splitted the board DT changes
	  into a separate patch as suggested
	- Detailed change logs are added to the respective patches

Devi Priya (9):
  dt-bindings: clock: Add PCIe pipe clock definitions
  clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
  dt-bindings: phy: qcom,qmp-pcie: Add ipq9574 bindings
  phy: qcom-qmp-pcie: Add support for IPQ9574 g3x1 and g3x2 PCIEs
  dt-bindings: PCI: qcom: Add IPQ9574
  dt-bindings: pinctrl: qcom: Add few missing functions
  arm64: dts: qcom: ipq9574: Add PCIe PHYs and controller nodes
  arm64: dts: qcom: ipq9574: Enable PCIe PHYs and controllers
  PCI: qcom: Add support for IPQ9574

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  48 +++
 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       | 103 ++++-
 .../bindings/pinctrl/qcom,ipq9574-tlmm.yaml   |   6 +-
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts   |  62 +++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 375 +++++++++++++++++-
 drivers/clk/qcom/gcc-ipq9574.c                |  76 ++++
 drivers/pci/controller/dwc/pcie-qcom.c        |  62 ++-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 332 ++++++++++++++++
 .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  26 +-
 .../phy/qualcomm/phy-qcom-qmp-qserdes-pll.h   |   3 +
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  |   4 +
 11 files changed, 1046 insertions(+), 51 deletions(-)


base-commit: 31bd35b66249699343d2416658f57e97314a433a
-- 
2.17.1

