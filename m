Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B13277E27B
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 15:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbjHPNYy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 09:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbjHPNYk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 09:24:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7367DE52;
        Wed, 16 Aug 2023 06:24:39 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GCoEUW003362;
        Wed, 16 Aug 2023 13:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=nXu1UOlIJBj2DB2mFC39b978sSoHBtJOzsnlTqY7Mi0=;
 b=XEM4YbiXvVc1BL4OWlYi1/TR2gdRrBNXQVUkF9clcU86fAZXX8cXiaICLLc5jYMMPzzp
 OHRmpil2jCrgmdfwz4CMW9NAQ2cwx+FZuNqOVeYPWD1kuRcfRnX7dE5Y/9oEDSaUG+gM
 auGubyt1HoAIh9RPU0AgoM7rrMO7iywbrix3X9m76WlvQ4uzjVTfDUoc7wzW5r46965D
 W1hVnGlPWnWucFfg8ElGg4/eAqKWRnBC0FXg/E/iV70gzmJrfqL9igAIEi7sesqHIepX
 J/sZvNXvB5qrKqH3y8uLvOvDZyhleqCPx4pKOvtwSocioLicCvPRbUK3R/Aru+Xos2ld nA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sg66htvey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 13:24:35 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37GDOWTN014751;
        Wed, 16 Aug 2023 13:24:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3se35keufq-1;
        Wed, 16 Aug 2023 13:24:32 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37GDOWnf014744;
        Wed, 16 Aug 2023 13:24:32 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 37GDOWrp014742;
        Wed, 16 Aug 2023 13:24:32 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 6C4B54BC0; Wed, 16 Aug 2023 18:54:31 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v2 0/3] PCI: qcom: Add support for OPP
Date:   Wed, 16 Aug 2023 18:54:21 +0530
Message-Id: <1692192264-18515-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fLkRo0G9eRpYV0IeJa_d2V6FbuAd-YDR
X-Proofpoint-GUID: fLkRo0G9eRpYV0IeJa_d2V6FbuAd-YDR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_12,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxlogscore=493
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160114
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

Changes from v1:
	- Addressed comments from Krzysztof Kozlowski.
	- Added the rpmhpd_opp_xxx phandle as suggested by pavan.
	- Added dev_pm_opp_set_opp API call which was missed on previous patch.

Krishna chaitanya chundru (3):
  dt-bindings: pci: qcom: Add binding for operating-points-v2
  arm64: dts: qcom: sm8450: Add opp table support to PCIe
  PCI: qcom: Add OPP support for speed based performance state of RPMH

 .../devicetree/bindings/pci/qcom,pcie.yaml         |  4 ++
 arch/arm64/boot/dts/qcom/sm8450.dtsi               | 47 +++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c             | 67 ++++++++++++++++++++++
 3 files changed, 118 insertions(+)

-- 
2.7.4

