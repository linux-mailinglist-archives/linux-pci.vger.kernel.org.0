Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DDA70926C
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 11:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjESJCu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 05:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjESJCt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 05:02:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D866C10D0;
        Fri, 19 May 2023 02:02:47 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34J8GIgq016895;
        Fri, 19 May 2023 09:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=12Id2iNCy+FYiHhY11gLnPTDc+lnbY+nDzvf/MNbTSg=;
 b=l8TmSq3hcvMZQJ3cTGeCppx0zhpm7OO5A32ouMM4LHqBZu62NKGQhRlt/fg1Vl8vFJ6i
 YgFq6QG2LmrGM/NP0Yei936i2mX+1BqCmVRHEjc67o/AWBvKPIPjKvn9yp64yUHpETUm
 QaCRtcjFMKkeFzweaoqOdK9cnrFgqrYONQEQPY1uQ+Zm3wPrKQ2FItaONxdfrsCCmU28
 vFLN6BuRghA25CPOM4NH3uTJd3ec8kV/bV8DYwRvDtHl/vgr2EharDR7JdLlL8GhwX+6
 y1uB9mE/YVFSJoXWHqWDdkGnGQeJrW3xfZ1/PQbU00eb/+l/QpvQoi4sx2gaTTqWtlTJ mg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp4ccr83t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 09:02:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34J92esG025427
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 09:02:40 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 19 May 2023 02:02:33 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <mani@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
Subject: [PATCH V4 0/6] Add PCIe support for IPQ9574
Date:   Fri, 19 May 2023 14:32:13 +0530
Message-ID: <20230519090219.15925-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: azFRzdq4DwccWZXm1qzlSmonLllWMMCv
X-Proofpoint-ORIG-GUID: azFRzdq4DwccWZXm1qzlSmonLllWMMCv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_05,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=744 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190076
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds support for enabling the PCIe host devices (PCIe0, PCIe1,
PCIe2, PCIe3) found on IPQ9574 platform.
The PCIe0 & PCIe1 are 1-lane Gen3 host and PCIe2 & PCIe3 
are 2-lane Gen3 host.

DTS patch is based on the below series
https://lore.kernel.org/linux-arm-msm/20230517172527.1968-1-quic_devipriy@quicinc.com/

Changes in V4:
	- Rebased on the below series
https://lore.kernel.org/linux-arm-msm/20230517172527.1968-1-quic_devipriy@quicinc.com/
	- Change logs are added to the respective patches.

[V3]
https://lore.kernel.org/linux-arm-msm/20230421124938.21974-1-quic_devipriy@quicinc.com/
	- Dropped the phy driver and binding patches as they have been 
	  posted as a separate series.
	- Dropped the pinctrl binding fix patch as it is unrelated to the series
	  dt-bindings: pinctrl: qcom: Add few missing functions.
	- Rebased on linux-next/master.
	- Detailed change logs are added to the respective patches.
	
[V2]
https://lore.kernel.org/linux-arm-msm/20230404164828.8031-1-quic_devipriy@quicinc.com/
	- Reordered the patches and splitted the board DT changes
	  into a separate patch as suggested
	- Detailed change logs are added to the respective patches

[V1]
https://lore.kernel.org/linux-arm-msm/20230214164135.17039-1-quic_devipriy@quicinc.com/

Devi Priya (6):
  dt-bindings: clock: Add PCIe pipe clock definitions
  clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
  dt-bindings: PCI: qcom: Add IPQ9574
  arm64: dts: qcom: ipq9574: Add PCIe PHYs and controller nodes
  arm64: dts: qcom: ipq9574: Enable PCIe PHYs and controllers
  PCI: qcom: Add support for IPQ9574

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  48 +++
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts   | 113 ++++++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 365 ++++++++++++++++++
 drivers/clk/qcom/gcc-ipq9574.c                |  76 ++++
 drivers/pci/controller/dwc/pcie-qcom.c        |  57 ++-
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  |   4 +
 6 files changed, 645 insertions(+), 18 deletions(-)

-- 
2.17.1

