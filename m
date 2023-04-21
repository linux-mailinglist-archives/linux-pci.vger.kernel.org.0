Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB5F6EAACF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 14:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjDUMuI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 08:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjDUMuH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 08:50:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56725FE6;
        Fri, 21 Apr 2023 05:50:06 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33LCa4vt006338;
        Fri, 21 Apr 2023 12:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=j+anIc/zyqM8GYYlJwcDN4VcfAgHFFiFBkybSsnzCBA=;
 b=TDMZYm2spLuV56SeohQXCWq4A83uoYO7V0omSDiw4RCxhCzNQjPAxZEHMF1S/E55r2jK
 2/IcmXifqbepdTVsh41w+A1CqbFNeNytA4E/MeUJp5/UjnFWV43EAJDGEizwDLntTqZf
 ZszuzvW/nYVGqdJplaPwUezrnwpLEModjuG86gBAcwYjs8+SGR+iAk+JTc5OakAKbDrX
 TUOR5laXIb3sZXgu0Vd6A7trEsiuamSW0aYln1D1l7n+QiVIE19Ib8XtT12pvncVSyuI
 1zbSPzocBAy8iFODFAvd6vWIbR4+k5VEz3+j4QGphh+6ajpfpmGhDr4TEfckj6cRWJw0 dw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q3tmer0yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 12:50:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33LCnx2R004241
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 12:49:59 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 21 Apr 2023 05:49:52 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <mani@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
Subject: [PATCH V3 0/6] Add PCIe support for IPQ9574
Date:   Fri, 21 Apr 2023 18:19:32 +0530
Message-ID: <20230421124938.21974-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7GVp4J9scmF8d4gF01OcTlwtyLnjRiWT
X-Proofpoint-ORIG-GUID: 7GVp4J9scmF8d4gF01OcTlwtyLnjRiWT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_06,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=683 phishscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304210112
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
https://lore.kernel.org/linux-arm-msm/20230329053726.14860-1-quic_kathirav@quicinc.com/

Changes in V3:
	- Dropped the phy driver and binding patches as they have been 
	  posted as a separate series.
	- Dropped the pinctrl binding fix patch as it is unrelated to the series
	  dt-bindings: pinctrl: qcom: Add few missing functions.
	- Rebased on linux-next/master.
	- Detailed change logs are added to the respective patches.
	
Changes in V2:
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

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  40 ++
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts   |  62 +++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 375 +++++++++++++++++-
 drivers/clk/qcom/gcc-ipq9574.c                |  76 ++++
 drivers/pci/controller/dwc/pcie-qcom.c        |  61 ++-
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  |   4 +
 6 files changed, 595 insertions(+), 23 deletions(-)


base-commit: 44bf136283e567b2b62653be7630e7511da41da2
-- 
2.17.1

