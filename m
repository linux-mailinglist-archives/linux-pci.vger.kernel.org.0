Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00347530E9
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 07:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbjGNFJF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 01:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjGNFJD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 01:09:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7E32D5F;
        Thu, 13 Jul 2023 22:09:02 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E4oDBK017653;
        Fri, 14 Jul 2023 05:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=fKEU125LEYk6uyzj/27LeAvR32GMePTT+LCYf3kNxpM=;
 b=oqbjvX37IbuWomOG8iHK9nuU3mjRivn6gY7dpnWsJrWP2yMlRX+3xo3HbMMcYKEZEwEZ
 qem0o95fEuCVCgkwVyndmSh5IXGJNRY18fRd7ifRddotwh6AJB1+cep3yHFgRB4okTpI
 U8QOhNzlBfk1lCcbI3Flsm/4oNdDStdZijRE7tPkljyognZL2UYsS/28zYOMXi9CAcZT
 JpUtKCKLyRPl5qP0vzAgkrquSiB/2/BUpE55/R6kAUg8gCerBVlgV2GgM+ZiusSvgDmY
 IrGHkxoQQj13LhhOe8Eg+X4chCJ826wg0rp91CRa2dhx9Be7B8sGNWbrjKNeJwDdqE6V iA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpukrvrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 05:08:49 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36E58is9001053;
        Fri, 14 Jul 2023 05:08:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rq0vm5769-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Jul 2023 05:08:44 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36E58igh001046;
        Fri, 14 Jul 2023 05:08:44 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36E58iHc001045;
        Fri, 14 Jul 2023 05:08:44 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id 7E451333B; Fri, 14 Jul 2023 10:38:43 +0530 (+0530)
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH v2 0/6] arm64: qcom: sa8775p: add support for PCIe
Date:   Fri, 14 Jul 2023 10:38:32 +0530
Message-Id: <1689311319-22054-1-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1PHCZOoD56ClsDRvoQ1aGbAcLtx4oUpg
X-Proofpoint-GUID: 1PHCZOoD56ClsDRvoQ1aGbAcLtx4oUpg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_02,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=796 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140046
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update the relavent DT bindings for PCIe, add new config to the phy
driver add pcie and phy nodes to the .dtsi file and enable then in
board .dts file for the sa8775p-ride platform.

v1 -> v2:
- correct indentationand sort compatible in qcom,pcie binding
- correct clock name entry and sort compatible in pcie-phy binding
- sort compatible and change commit message in qcom pcie driver
- change offset name, added tx2 and rx2 offsets and sort compatible
  in qmp pcie phy driver
- correct ranges property, added MSI, dma-coherent, cpu-pcie property
  removed iommus property moved pinctrl and gpio property to board dts
  and correct the allignment in pcie dtsi nodes
- added pinctrl and gpio property in board dts

Mrinmay Sarkar (6):
  dt-bindings: PCI: qcom: Add sa8775p compatible
  dt-bindings: phy: qcom,qmp: Add sa8775p QMP PCIe PHY
  PCI: qcom: Add support for sa8775p SoC
  phy: qcom-qmp-pcie: add support for sa8775p
  arm64: dts: qcom: sa8775p: Add pcie0 and pcie1 nodes
  arm64: dts: qcom: sa8775p-ride: enable pcie nodes

 .../devicetree/bindings/pci/qcom,pcie.yaml         |  28 ++
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |  19 +-
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts          |  80 +++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 204 +++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c             |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 341 +++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h |   1 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_20.h |   2 +
 8 files changed, 673 insertions(+), 3 deletions(-)

-- 
2.7.4

