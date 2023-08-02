Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B026976C3B7
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 05:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjHBDvc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 23:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjHBDvb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 23:51:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DADD1BC7;
        Tue,  1 Aug 2023 20:51:30 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3723mvn7005089;
        Wed, 2 Aug 2023 03:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=z5WVRoUiQGe7xbMn4R8L3vQYDcJNjQ+FIqx35pYCUMg=;
 b=DuFZIrDK5OZQAHoI2Et8Z8SKYlj/Ij0aUrgYnJ1LlF8eR0bpFmpEaDFfiZ/C5jeywucs
 2KpxWH/YdaBabKwZ420+jlY3OkNLpHTNU+TyyQbAwMGEks8WcJR4rJYbYfce/hzpxKek
 NH7uI8AICLpNhBlxe2KwzhQN0PtSHj6tkO4hntvpS690fWVFffFxx87txgupFK94Ni+Q
 3n2QaNrDA9U0QX/ss3gulIBh6rIL1lVJ+rxcBpd3YS56YUBAppV/wKt26zqE0BYPaz6U
 CHjlMMvkRb/0Ldv8eG4MkSmrOXHvYc33TOHJ98dBGZfJgleySLDF29LlwxRYaqBX5PUH sw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6j4euj4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 03:51:27 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3723pORS022458;
        Wed, 2 Aug 2023 03:51:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3s4uukryx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 02 Aug 2023 03:51:24 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3723pNse022449;
        Wed, 2 Aug 2023 03:51:23 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3723pNqh022445;
        Wed, 02 Aug 2023 03:51:23 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id AA6CF4B59; Wed,  2 Aug 2023 09:21:22 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v5 0/4] PCI: endpoint: add D-state change notifier support
Date:   Wed,  2 Aug 2023 09:21:17 +0530
Message-Id: <1690948281-2143-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KlmJVvzf5xpDX3ORmaXINlRIrHDMYY-j
X-Proofpoint-ORIG-GUID: KlmJVvzf5xpDX3ORmaXINlRIrHDMYY-j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_22,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=353 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020033
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In this series we added support to nofity the EPF driver whenever there
is change in the D-state if the EPF driver registered for it.

Krishna chaitanya chundru (4):
  PCI: endpoint: Add D-state change notifier support
  PCI: qcom-ep: Add support for D-state change notification
  PCI: qcom-ep: Update the D-state log
  PCI: epf-mhi: Add support for handling D-state notify from EPC

 Documentation/PCI/endpoint/pci-endpoint.rst  |  4 ++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c    |  9 ++++++++-
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 11 +++++++++++
 drivers/pci/endpoint/pci-epc-core.c          | 27 +++++++++++++++++++++++++++
 include/linux/mhi_ep.h                       |  3 +++
 include/linux/pci-epc.h                      |  1 +
 include/linux/pci-epf.h                      |  1 +
 7 files changed, 55 insertions(+), 1 deletion(-)

-- 
2.7.4

