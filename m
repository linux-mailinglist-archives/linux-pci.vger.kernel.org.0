Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9028475D08F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 19:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjGURY5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 13:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGURYz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 13:24:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C7DE47;
        Fri, 21 Jul 2023 10:24:54 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LDMaLI018765;
        Fri, 21 Jul 2023 17:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=hoGiKXN9LLHxribbSg2vDjbqkf+ni+mrm6GlYquInYE=;
 b=R8nEk/49X2oMrzMATsitOju+ZV+l+SembJIDszq5qg7ek/6Ai7fNZJeWRPsddUh3ixQ3
 htA8zjuBP+Y3ojecu0UIQW3MuZZnuyN2p5XCsNi0mnxH9IKpdTfdpECVQZwPVBwF+GCb
 Rsb4HHgnxoOs4BiW+B1DeTdBwjMuuZ6PPxyv69yPW4F/xO/HQH8R9Cp9ekqOiW+/pLL7
 I3fzXHjbntYzrRWmDaLv5SKXhB12FTUfmOw6t3lyuuQz3AB9vEOT5jzOqur7ZDExka+X
 gDrisOMAPyFfAMgpuRWxlEhUcFt/ct0Yo5AifF9MgPAc7uCKLej5kONnIzkP51vtUU9l TQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ryn5ysbk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 17:24:46 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36LHOgSN023730;
        Fri, 21 Jul 2023 17:24:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rumhknep8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 21 Jul 2023 17:24:41 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36LHOfuJ023720;
        Fri, 21 Jul 2023 17:24:41 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 36LHOfXd023702;
        Fri, 21 Jul 2023 17:24:41 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id 9C12832C9; Fri, 21 Jul 2023 22:54:40 +0530 (+0530)
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] arm64: qcom: sa8775p: add support for PCIe
Date:   Fri, 21 Jul 2023 22:54:31 +0530
Message-Id: <1689960276-29266-1-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1j3k2xGQuIK1kfYnPTFcpxhXU9O8HWIy
X-Proofpoint-GUID: 1j3k2xGQuIK1kfYnPTFcpxhXU9O8HWIy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 mlxlogscore=705
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210151
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update the relavent DT bindings for PCIe, add new config to the phy
driver add pcie and phy nodes to the .dtsi file and enable then in 
board .dts file for the sa8775p-ride platform.

v2 -> v3:
- to align with dt-bindings rectified pcie default state
- dropped PCIe PHY dt-bindings and PHY driver in this series as its
  already applied [1]
- To verify DTS against bindings for this series we required [2]

[1] https://lore.kernel.org/all/168966092968.340315.2461852657981161685.b4-ty@kernel.org/
[2] https://lore.kernel.org/all/20230719110344.19983-1-quic_shazhuss@quicinc.com/

v1 -> v2:
- correct indentationand sort compatible in qcom,pcie binding
- correct clock name entry and sort compatible in pcie-phy binding
- sort compatible and change commit message in qcom pcie driver
- change offset name and sort compatible in qmp pcie phy driver
- correct ranges property, added MSI, dma-coherent, cpu-pcie property
  removed iommus property moved pinctrl and gpio property to board dts
  and correct the allignment in pcie dtsi nodes
- added pinctrl and gpio property in board dts

Mrinmay Sarkar (4):
  dt-bindings: PCI: qcom: Add sa8775p compatible
  PCI: qcom: Add support for sa8775p SoC
  arm64: dts: qcom: sa8775p: Add pcie0 and pcie1 nodes
  arm64: dts: qcom: sa8775p-ride: enable pcie nodes

 .../devicetree/bindings/pci/qcom,pcie.yaml         |  28 +++
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts          |  80 ++++++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 204 ++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c             |   1 +
 4 files changed, 311 insertions(+), 2 deletions(-)

-- 
2.7.4

