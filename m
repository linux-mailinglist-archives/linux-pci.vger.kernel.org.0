Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65E16AB5FD
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 06:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCFFZY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 00:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjCFFZU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 00:25:20 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A11219697;
        Sun,  5 Mar 2023 21:25:19 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3262mAhG027576;
        Mon, 6 Mar 2023 05:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=q6dLQ1CXQqM7sPzswb4fRaqWx2y38l9H+H1gMlgvsdw=;
 b=SpmDOCAgSwkomaB249qTdv7mLxazFaxnuiOOIlUn3ro6xTR7ICE7cY6USGL4haCvrxbx
 a6a7mWNFeE0vdyJfAMDUZbIXhnAnJ8xfPKZv1o7v0tSkBOK8+VEjTGJh5+/EQOTZUo3a
 NrgR5colucgNKR/ZkwTeGadjj1GclCV30jTuyJAV2GQBkwDZAD8i19RA2nbOMdn0vS/t
 TRu9+uI2ZSNjXtywo47neR/gQmNo2m3FGwzNvCZpSjhkJMSEVa/nD9YvV4qQ4AiEN4kY
 ILgxCUI/SUBlfvRstGfHQJUkSl3GhDmmvRH9RESckSv3bYz0420k3ubhmhQAw1cbvLZ9 lA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p417d3csd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 05:25:12 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3265P5FL016074;
        Mon, 6 Mar 2023 05:25:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3p4fgk7399-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 06 Mar 2023 05:25:05 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3265P5sD016057;
        Mon, 6 Mar 2023 05:25:05 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3265P4sd016053;
        Mon, 06 Mar 2023 05:25:05 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 4B1214F8A; Mon,  6 Mar 2023 10:55:04 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/6] Add PCIe EP support for SDX65
Date:   Mon,  6 Mar 2023 10:54:56 +0530
Message-Id: <1678080302-29691-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Kl3Er85BDcGWxfOWEGt43okGd7VlsAt2
X-Proofpoint-ORIG-GUID: Kl3Er85BDcGWxfOWEGt43okGd7VlsAt2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-05_12,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 mlxlogscore=595
 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060044
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This series adds the devicetree support for PCIe PHY and PCIe EP on SDX65.
The PCIe EP is enabled on SDX65 MTP board.

Thanks,
Rohit.

Rohit Agarwal (6):
  dt-bindings: mfd: qcom,tcsr: Add compatible for sdx65
  dt-bindings: PCI: qcom: Add SDX65 SoC
  ARM: dts: qcom: sdx65: Add support for PCIe PHY
  ARM: dts: qcom: sdx65: Add support for PCIe EP
  ARM: dts: qcom: sdx65-mtp: Enable PCIE0 PHY
  ARM: dts: qcom: sdx65-mtp: Enable PCIe EP

 .../devicetree/bindings/mfd/qcom,tcsr.yaml         |  1 +
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      |  2 +
 arch/arm/boot/dts/qcom-sdx65-mtp.dts               | 53 +++++++++++++++
 arch/arm/boot/dts/qcom-sdx65.dtsi                  | 76 ++++++++++++++++++++++
 4 files changed, 132 insertions(+)

-- 
2.7.4

