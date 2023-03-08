Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113BE6B06D3
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 13:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjCHMUV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 07:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCHMUU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 07:20:20 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77DA9E05D;
        Wed,  8 Mar 2023 04:20:15 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3286gFbL031891;
        Wed, 8 Mar 2023 12:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=pY4Xq6Yq5zErRw5UQf3nP9HIt4Fc1cQLytOP9DkxLE4=;
 b=g4bBQN6ubD23FoqgxALB0wQWHcIv4IZwFrdAsA40zxgUlLDkG33RkyZGeID54kVNoiKS
 uYxKUzGq45CU3LPy+0dbZ/iIVtvwLKrpkjk+Ic1bmzIs72k/6IpoPeCkQJYHvZ/a6IFI
 n0kFWIqpYCBMfE9QShTaVhXJ0GVNt6wvSAVSCEbxO0WfH+VOAolT2wwdO4+uhLtL6/PG
 olours7vbwFA/Qg7uBX6oTWBDZEqkLdkHP7C7LjUmeu8V+oJQJXH7kBy4vmBNePrxH4j
 cBqR51cO1uD9f/e1QLJNKg0Snsq7vCORlgHMbpSzAGM1M0tQtJHEdM+6oFQE570LntX5 pA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6fgh1js7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 12:20:09 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 328CK4An031392;
        Wed, 8 Mar 2023 12:20:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3p4fgkn0bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 08 Mar 2023 12:20:04 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 328CK4cD031377;
        Wed, 8 Mar 2023 12:20:04 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 328CK44d031372;
        Wed, 08 Mar 2023 12:20:04 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 89DC24F94; Wed,  8 Mar 2023 17:50:03 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 0/6] Add PCIe EP support for SDX65
Date:   Wed,  8 Mar 2023 17:49:47 +0530
Message-Id: <1678277993-18836-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BLsBo_XMRaS5fL07OuVS3a1nZZW-j_9V
X-Proofpoint-GUID: BLsBo_XMRaS5fL07OuVS3a1nZZW-j_9V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_07,2023-03-08_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=701 spamscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080106
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Changes in v2:
 - Addressing comments from Konrad and Dmitry.
 - Rebased on top of 6.3-rc1.

This series adds the devicetree support for PCIe PHY and PCIe EP on SDX65.
The PCIe EP is enabled on SDX65 MTP board.

Thanks,
Rohit.

Rohit Agarwal (6):
  dt-bindings: mfd: qcom,tcsr: Add compatible for sdx65
  dt-bindings: PCI: qcom: Add SDX65 SoC
  ARM: dts: qcom: sdx65: Add support for PCIe PHY
  ARM: dts: qcom: sdx65: Add support for PCIe EP
  ARM: dts: qcom: sdx65-mtp: Enable PCIe PHY
  ARM: dts: qcom: sdx65-mtp: Enable PCIe EP

 .../devicetree/bindings/mfd/qcom,tcsr.yaml         |  1 +
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      |  2 +
 arch/arm/boot/dts/qcom-sdx65-mtp.dts               | 50 ++++++++++--
 arch/arm/boot/dts/qcom-sdx65.dtsi                  | 92 ++++++++++++++++++++++
 4 files changed, 140 insertions(+), 5 deletions(-)

-- 
2.7.4

