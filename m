Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5A678451C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 17:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbjHVPMn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 11:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjHVPMn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 11:12:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B775B1B9;
        Tue, 22 Aug 2023 08:12:38 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MDeZUq031343;
        Tue, 22 Aug 2023 15:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=eW3RyZ4QBo5qREd9Dm/xiHKptXK3qCzHQrZPKpZK2RI=;
 b=OnUnN7jW96N68HWnAWf5npCy4FqlBSMNSr52o4oMdWnmlduTPbGY6rthyktUVEhYxsmG
 v4BXnQOO3vpdDSGyuZlMfsYHYXTRGAdrzpyUMG/xCgg2mgvSa8mnt1M2ixOTFHmwC2ba
 m1rOHIuxVcJSx8z4128d4C5x8UsRdUGrR8ObLP1YEloNyrieaS2k4c33OtTmiofVwRm1
 vL3SNtuad1okCrE40DMcOnfM62cPvCHgT0RheRJeLul4NE0KET4I+6BkggGo0SlAnK8c
 WZgpIJBtbt0thOb0/MH0C7zo7NaDR+YV7qZ+Togp6FifljThj4EHqznuKMTjS2kGRgTG iA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smx3009hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 15:12:27 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37MFCNgY032346;
        Tue, 22 Aug 2023 15:12:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sjptkwbvh-1;
        Tue, 22 Aug 2023 15:12:23 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37MFCNGw032338;
        Tue, 22 Aug 2023 15:12:23 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 37MFCNet032335;
        Tue, 22 Aug 2023 15:12:23 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 8414D4B78; Tue, 22 Aug 2023 20:42:22 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v4 0/4] PCI: qcom: Add support for OPP
Date:   Tue, 22 Aug 2023 20:42:17 +0530
Message-Id: <1692717141-32743-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qZQIbarT60QCB-nINTHD-fZsWanizyuS
X-Proofpoint-GUID: qZQIbarT60QCB-nINTHD-fZsWanizyuS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 adultscore=0 mlxlogscore=558 priorityscore=1501 impostorscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308220116
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds support for OPP to vote for the performance state of RPMH
power domain based upon GEN speed it PCIe got enumerated.

Before link up PCIe driver will vote for the maximum performance state.

Add API dev_pm_opp_find_level_floor to find To find the highest opp for a device
based on the level.

changes from v3:
	- Removing the opp vote on suspend when the link is not up and link is not
	  up and add debug prints as suggested by pavan.
	- Added dev_pm_opp_find_level_floor API to find the highest opp to vote.
changes from v2:
	- Instead of using the freq based opp search use level based as suggested
	  by Dmitry Baryshkov.
Changes from v1:
        - Addressed comments from Krzysztof Kozlowski.
        - Added the rpmhpd_opp_xxx phandle as suggested by pavan.
        - Added dev_pm_opp_set_opp API call which was missed on previous patch.

Krishna chaitanya chundru (4):
  dt-bindings: pci: qcom: Add opp table
  arm64: dts: qcom: sm8450: Add opp table support to PCIe
  OPP: Add api to retrieve opps which is at most the provided level
  PCI: qcom: Add OPP support for speed based performance state of RPMH

 .../devicetree/bindings/pci/qcom,pcie.yaml         |  4 ++
 arch/arm64/boot/dts/qcom/sm8450.dtsi               | 47 +++++++++++++++++++
 drivers/opp/core.c                                 | 26 +++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c             | 52 ++++++++++++++++++++++
 include/linux/pm_opp.h                             |  4 ++
 5 files changed, 133 insertions(+)

-- 
2.7.4

