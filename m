Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07536B0980
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 14:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjCHNi4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 08:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjCHNiO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 08:38:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F12BF38D;
        Wed,  8 Mar 2023 05:36:29 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328Cm8rq013590;
        Wed, 8 Mar 2023 13:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=w0vsOsjk5O2np8Tu4l+4ogLxH7P0R+ba99o7h7cf8e8=;
 b=aYqtprk/iHAKZZMVUkNcYiuF5LkQkja+yUy3YuJRLkWOjW7681qAFR+DVtHXOKr0Bn2N
 CJLOr4/dLvNAMmY71fA19Lakp8yMiluHLAZmuy5u9o0lormeHmdiVSGku6KGYPF38U/9
 32AJhJYH9CvCbHOyr3CSPDxODJt77Rv7agIbpClaa3emY6RjrCZ+nYUmqNupA6cDvpWE
 B489shze39AyZw/3N6kubLCpiQh3n/Ax3otW1u4AGCO19kVFYJhySGyt8CYHBHVm0zsm
 wbyFh7Pk9+9u+ih0VraQjlakKOT7WSlE0H97G5L44n5lSVe+v6+kVkG0Ucj1D4icYtoU 7Q== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6fga1rjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 13:36:21 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 328DZgqt020580;
        Wed, 8 Mar 2023 13:35:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3p4fftbxx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 08 Mar 2023 13:35:42 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 328DZgbM020567;
        Wed, 8 Mar 2023 13:35:42 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 328DZgWO020566;
        Wed, 08 Mar 2023 13:35:42 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 745C14FB4; Wed,  8 Mar 2023 19:05:41 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 0/5] Add PCIe EP support for SDX65
Date:   Wed,  8 Mar 2023 19:05:27 +0530
Message-Id: <1678282532-16635-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: filnOAoPk92BQj6Yabp5PPPXws0gHO9h
X-Proofpoint-ORIG-GUID: filnOAoPk92BQj6Yabp5PPPXws0gHO9h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 spamscore=0 mlxscore=0 clxscore=1015 mlxlogscore=678 impostorscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080116
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

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
 arch/arm/boot/dts/qcom-sdx65-mtp.dts               | 47 ++++++++++-
 arch/arm/boot/dts/qcom-sdx65.dtsi                  | 90 ++++++++++++++++++++++
 3 files changed, 136 insertions(+), 3 deletions(-)

-- 
2.7.4

