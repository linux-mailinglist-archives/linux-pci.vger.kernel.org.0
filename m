Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069E1747F38
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 10:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjGEIRk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 04:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjGEIRi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 04:17:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0771712;
        Wed,  5 Jul 2023 01:17:37 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3657gUTd014845;
        Wed, 5 Jul 2023 08:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=jEMroPtyab7N7k1VyfV7EnLbnWLHEFpQNzbLH5Q4dWI=;
 b=O97gWdEvwuX3NyuhLfl3KA9OF1sVCuHtOCGsqv0WPCiz7TLBoWHD9THQrC9421k/lI17
 qqajXEeD+yR6S+4lvIv5/ppp/76jhF9Kf2UfZToH2gVF9fzNGQSNt6OSLzZA8TSTCMCa
 sl8F2304P+Rg3WmRUbRCJqRuLUQ+civ2tMOaPpizSvL+mtdofSAVvlIRpfWO9yVGQrb6
 ZxPuKECIth4hJGvzKtkIYeYUjF9OiVF0EQNe9GZYPQv7hr+z6S2K7sxEGUD5X0kR+tNg
 96fYI2oy8M8NKJwMeEI1imjCB0ZK4kvF538hxsRIuQRe1LsmgB8whYbjFLcIW17zzuhQ KA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rmhf12b8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 08:17:26 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3658HMBk021496;
        Wed, 5 Jul 2023 08:17:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rjd7krn7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 05 Jul 2023 08:17:22 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3658HLrN021317;
        Wed, 5 Jul 2023 08:17:21 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3658HLnB021124;
        Wed, 05 Jul 2023 08:17:21 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id A91B2244; Wed,  5 Jul 2023 13:47:20 +0530 (+0530)
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH v1 0/6] arm64: qcom: sa8775p: add support for PCIe
Date:   Wed,  5 Jul 2023 13:47:05 +0530
Message-Id: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AGJWfIQj5D-zGmWo8QHT4087WjAWWIyN
X-Proofpoint-ORIG-GUID: AGJWfIQj5D-zGmWo8QHT4087WjAWWIyN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_16,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=673 spamscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307050075
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update the relavent DT bindings for PCIe, add new config to the phy
driver add pcie and phy nodes to the .dtsi file and enable then in 
board .dts file for the sa8775p-ride platform.

Mrinmay Sarkar (6):
  dt-bindings: PCI: qcom: Add sa8775p compatible
  dt-bindings: phy: qcom,qmp: Add sa8775p QMP PCIe PHY
  PCI: qcom: Add support for sa8775p SoC
  phy: qcom-qmp-pcie: add support for sa8775p
  arm64: dts: qcom: sa8775p: Add pcie0 and pcie1 nodes
  arm64: dts: qcom: sa8775p-ride: enable pcie nodes

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  28 ++
 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  19 +-
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts     |  68 ++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 201 ++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c        |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 328 ++++++++++++++++++
 .../qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h    |   1 +
 .../phy-qcom-qmp-qserdes-txrx-v5_20.h         |   2 +
 8 files changed, 645 insertions(+), 3 deletions(-)

-- 
2.39.2

