Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879967DD0D9
	for <lists+linux-pci@lfdr.de>; Tue, 31 Oct 2023 16:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjJaPqo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Oct 2023 11:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjJaPqn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2023 11:46:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43B58F;
        Tue, 31 Oct 2023 08:46:41 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VA9YXV024332;
        Tue, 31 Oct 2023 15:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=QFeJZo4lVoS28Eu6lyZ7a2Uw6ke/eG74rXjZ9gHcpRQ=;
 b=JtkCtwyeY8WLZEFWjmLpMSj7IyIqk3mzYbp37GGwrqTzHQt0xaEsA1GU3mphph3U3gXj
 yzVxvWJv+U1CkwaikafHzLVAodF4hyR3uI2z0yRn84SGhrlKY/VLVH7d58HnxLsPt2x3
 ZagmDqHgXArhffz0Cx0YjNmKjDG/ruo33oIJFNG8t/JFltyZTFTQFHCU6KKkhOzYGMH4
 mXSmMJGhPsEK1aG6YUH3NfRjk03UO8Em3tzVYlV48/dirvfvEhK9T9QkRUJFSvwDz8X2
 CNvO3rf0Q33lgf1Q3iynKSw1PVLQiK9lPQ+cml/aqewr6cJvuAVzdw5PE//4lDReS2cY eQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2c4ruryg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 15:46:35 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39VFkWMT006360;
        Tue, 31 Oct 2023 15:46:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3u0uckx0ua-1;
        Tue, 31 Oct 2023 15:46:32 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39VFkVwc006354;
        Tue, 31 Oct 2023 15:46:31 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 39VFkV03006352;
        Tue, 31 Oct 2023 15:46:31 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id C65C74BFB; Tue, 31 Oct 2023 21:16:30 +0530 (+0530)
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org, robh+dt@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, quic_schintav@quicinc.com,
        quic_shijjose@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v1 0/3] arm64: qcom: sa8775p: add cache coherency support for SA8775P
Date:   Tue, 31 Oct 2023 21:16:23 +0530
Message-Id: <1698767186-5046-1-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6_V4tVSHgqYjuYmH5tnZf0oiTWJJedcR
X-Proofpoint-GUID: 6_V4tVSHgqYjuYmH5tnZf0oiTWJJedcR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_02,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxlogscore=282
 malwarescore=0 mlxscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310125
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series is to enable cache snooping logic in both RC and EP
driver and add the "dma-coherent" property in dtsi to support
cache coherency in SA8775P.

To verify this series we required [1]

[1] https://lore.kernel.org/all/1698729108-27356-1-git-send-email-quic_msarkar@quicinc.com/

Mrinmay Sarkar (3):
  PCI: qcom: Enable cache coherency for SA8775P RC
  PCI: qcom-ep: Enable cache coherency for SA8775P EP
  arm64: dts: qcom: sa8775p: Mark PCIe controller as cache coherent

 arch/arm64/boot/dts/qcom/sa8775p.dtsi     |  2 ++
 drivers/pci/controller/dwc/pcie-qcom-ep.c |  8 ++++++++
 drivers/pci/controller/dwc/pcie-qcom.c    | 11 +++++++++++
 3 files changed, 21 insertions(+)

-- 
2.7.4

