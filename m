Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343916D1736
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 08:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCaGSo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Mar 2023 02:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCaGSm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2023 02:18:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8E31FE7;
        Thu, 30 Mar 2023 23:18:41 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32V4PXkh004442;
        Fri, 31 Mar 2023 06:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=3zFoe+/ZG714jTMqvD6TMaQRtyoAtwec8AKt3TSFZKo=;
 b=OP7NFloIO7XOX73v+xrvwrMMSXDqmwLSOJi6+zPgEQe881Nwl7sGj+IBnilJbsQG7ebY
 mldU7pKubvK3bcvZSduKYLywZxbWW+3TwlHJuwJoTH+ie48hPDZaeL+Rf0rLid2P1mOn
 Y15Hi3xdY0TICfaKWmaPSpl5qxD/0va1N1iV5m4YMB8vsLxFg7xaFcdgKva4Ala3F044
 L+zHKdYkERaHBATA7HvxhNTSInKWmb3e1URkhEjTtRLL+LOwIbkbeLZi2EBd/gD9zYCg
 xZTxuh3BN76MaTBMfKFf27qgolm5dXIQJb7ipGvaeh2+gS5oeSXJKA4cxlFQrd7cORjP ng== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pmq95debm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 06:18:35 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32V6IV6w013884;
        Fri, 31 Mar 2023 06:18:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3pht1knm21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 31 Mar 2023 06:18:31 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32V6IVhB013873;
        Fri, 31 Mar 2023 06:18:31 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 32V6IVRN013870;
        Fri, 31 Mar 2023 06:18:31 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 8A2DC4EE8; Fri, 31 Mar 2023 11:48:30 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mani@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v5 0/5] Add PCIe EP support for SDX65
Date:   Fri, 31 Mar 2023 11:48:17 +0530
Message-Id: <1680243502-23744-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KUUgbUpRuyiNz1KUWhcFPXO_H6YYOVBF
X-Proofpoint-ORIG-GUID: KUUgbUpRuyiNz1KUWhcFPXO_H6YYOVBF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_02,2023-03-30_04,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=715 adultscore=0 spamscore=0
 impostorscore=0 phishscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303310050
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

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
 arch/arm/boot/dts/qcom-sdx65-mtp.dts               | 51 ++++++++++++-
 arch/arm/boot/dts/qcom-sdx65.dtsi                  | 87 ++++++++++++++++++++++
 3 files changed, 137 insertions(+), 3 deletions(-)

-- 
2.7.4

