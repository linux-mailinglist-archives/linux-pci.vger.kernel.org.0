Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4076C708743
	for <lists+linux-pci@lfdr.de>; Thu, 18 May 2023 19:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjERRst (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 May 2023 13:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjERRsR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2023 13:48:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF53410E7;
        Thu, 18 May 2023 10:48:12 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IHUqY1022452;
        Thu, 18 May 2023 17:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=WTKPEmwPBDbgN8kOTUBGCIrNhFkwyckDQpiQl/014S0=;
 b=CNsoqVQGdTcncDhqrnyt0yofSP5/RdGRjTBnoy89LdcZUn2xghsy5ABaphDDPJxM8EsI
 QPbeIVAebnMG5Z6Ap5c9uK2fBi33LtoFHGbssh2aEkVs5cS2srHsG3SfRAXL3pl4CDRI
 aNZa3tatMESD3l1dwYSqLfnd/DDneoYi0faXbmF1QT7xIQyhpFIM6uCB+H9jqfzI81YE
 MV5yeRxgqZWpHtmgz2URJRYjEUKNxV1ysCD8LYWYhb0WhFeXJrmbQijRdvAHPvBK3B2L
 awpALY6///10fCnzXxkmP3IolQpvFaZNMEzMj1qk/TSZb6YzgQy1oTxNKmdKQMlEGIPx /g== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmxyp3fx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 17:48:06 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34IHm26u012082;
        Thu, 18 May 2023 17:48:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3qj3mkakxa-1;
        Thu, 18 May 2023 17:48:02 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34IHm1pU011968;
        Thu, 18 May 2023 17:48:01 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34IHm1Ow011966;
        Thu, 18 May 2023 17:48:01 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id C2E835EBF; Thu, 18 May 2023 23:18:00 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mani@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v6 0/5] Add PCIe EP support for SDX65
Date:   Thu, 18 May 2023 23:17:48 +0530
Message-Id: <1684432073-28490-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uHrNGR3ewPzzqUUESDrxn03tkERqLjKS
X-Proofpoint-GUID: uHrNGR3ewPzzqUUESDrxn03tkERqLjKS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_13,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=719
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180144
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Changes in v6:
 - Rebased on top of 6.4-rc2.

Changes in v5:
 - Addressed some minor comments from Konrad
 - Rebased on top of 6.3-rc5.

Changes in v4:
 - Addressed comment from Dmitry to move the gpios to the board file.

Changes in v3:
 - Removing the applied patch.
 - Addressing some of the compile time issues missed in v2.

Changes in v2:
 - Addressing comments from Konrad and Dmitry.
 - Rebased on top of 6.3-rc1.

This series adds the devicetree support for PCIe PHY and PCIe EP on SDX65.
The PCIe EP is enabled on SDX65 MTP board.

Thanks,
Rohit.

Rohit Agarwal (5):
  dt-bindings: PCI: qcom: Add SDX65 SoC
  ARM: dts: qcom: sdx65: Add support for PCIe PHY
  ARM: dts: qcom: sdx65: Add support for PCIe EP
  ARM: dts: qcom: sdx65-mtp: Enable PCIe PHY
  ARM: dts: qcom: sdx65-mtp: Enable PCIe EP

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      |  2 +
 arch/arm/boot/dts/qcom-sdx65-mtp.dts               | 42 +++++++++++
 arch/arm/boot/dts/qcom-sdx65.dtsi                  | 87 ++++++++++++++++++++++
 3 files changed, 131 insertions(+)

-- 
2.7.4

