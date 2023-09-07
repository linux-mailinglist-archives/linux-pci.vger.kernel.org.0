Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBFD7979F0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Sep 2023 19:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243432AbjIGRZ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Sep 2023 13:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243345AbjIGRZz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Sep 2023 13:25:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B22CDE;
        Thu,  7 Sep 2023 10:25:26 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3875npUj020188;
        Thu, 7 Sep 2023 06:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=4UZ+9/d3SUM0emzxqN6v0bSiJxRg8md3/J0gazE6Jus=;
 b=gm2rQaPdYM1dMA9hG4fC18hPDDutkM2tlypr2RULNAQ58tN/diNfKohTFxTdWH+ev6SF
 i5AsQ5T0XIVvlVf5ozahoGGZO01ju4XPnX+pLqPRknpFCgGMrEcqWBmuvbCgs8WwbrU+
 Ngu9f7U5g6Eew0mF81+XPk3TY6xQO+OYOiLoPxqbTAV02xXaVMy7TclQwV4+WUYIxS0I
 oBg5dSbWQ1w1GJ/VfXe/SwM6oUVQEwveVWX/VsJLELtMEE+71S0ATT/lKju4XHAJ9EEH
 NjNsYc0VYzySmGHx2dfPsmZOn0i8/IwwfvK464nQnwEOtbQh2UcR4JewyKmeI9XVctid iQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxpt02m7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 06:00:58 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38760tdn011300;
        Thu, 7 Sep 2023 06:00:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sux4kjqum-1;
        Thu, 07 Sep 2023 06:00:55 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38760sNR011295;
        Thu, 7 Sep 2023 06:00:54 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 38760sRL011294;
        Thu, 07 Sep 2023 06:00:54 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id E6FB513A9; Thu,  7 Sep 2023 11:30:53 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, mani@kernel.org
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, quic_parass@quicinc.com,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v5 0/5] PCI: qcom: Add support for OPP
Date:   Thu,  7 Sep 2023 11:30:28 +0530
Message-Id: <1694066433-8677-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8W5aLJY1N9CQqKdZdvw0uQdbuFlbHFoH
X-Proofpoint-GUID: 8W5aLJY1N9CQqKdZdvw0uQdbuFlbHFoH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 mlxscore=0 phishscore=0 impostorscore=0 suspectscore=0 mlxlogscore=815
 adultscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070052
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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

Changes from v4:
	- Added a separate patch for returning error from the qcom_pcie_upadate
	  and moved opp update logic to icc_update and used a bool variable to 
	  update the opp.
	- Addressed comments made by pavan.
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

Krishna chaitanya chundru (5):
  dt-bindings: pci: qcom: Add opp table
  arm64: dts: qcom: sm8450: Add opp table support to PCIe
  opp: Add dev_pm_opp_find_level_floor()
  PCI: qcom: Return error from 'qcom_pcie_icc_update'
  PCI: qcom: Add OPP support to scale performance state of power domain

 .../devicetree/bindings/pci/qcom,pcie.yaml         |  4 ++
 arch/arm64/boot/dts/qcom/sm8450.dtsi               | 47 ++++++++++++++++
 drivers/opp/core.c                                 | 25 +++++++++
 drivers/pci/controller/dwc/pcie-qcom.c             | 63 ++++++++++++++++++----
 include/linux/pm_opp.h                             |  9 ++++
 5 files changed, 137 insertions(+), 11 deletions(-)

-- 
2.7.4

