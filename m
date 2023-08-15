Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97D377CC9B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 14:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjHOM2G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 08:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237119AbjHOM1p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 08:27:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C1019AD;
        Tue, 15 Aug 2023 05:27:28 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FCGwDi015058;
        Tue, 15 Aug 2023 12:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=9VcILIdlJgSnUSWdHiNzsomq2OEegMHdDkCV43rQmhU=;
 b=GgDT8Ph9MAzKNdO18sDA5zA+XS4L+LcgM9PGdxuE5n8fM2eIRE8J9rtPleIsneFXosGi
 fUousHWryxLb6Z+3rE/p1ZgFbbAPaRbTgzpUmsQXYgLpPg1k5/LuvhXmcWNrozdI+QcK
 0HZnza+gs/IAOrQfMZJQL9q/fGs4xsUpqAmwaWv3ds8SCUtuYxOlPcsAkXuJV3IO1dMq
 vTdqCgylG9Sx+95NKCsAFaK9aGTF0k1Rrx66oMIIy6t/fAeDKbux6nUIzfXoe2OhMPMT
 N0/1K2rJ1AK5AizB2toLl6cqe4fvhR8Vq6OihOicYAF3NpQb1ins2iz3dW54Ca8cW9n6 QQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sg450ggkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 12:27:24 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37FCRLSB022253;
        Tue, 15 Aug 2023 12:27:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3se35kb8py-1;
        Tue, 15 Aug 2023 12:27:21 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37FCRLDG022247;
        Tue, 15 Aug 2023 12:27:21 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 37FCRLAO022245;
        Tue, 15 Aug 2023 12:27:21 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 8A8DC4BC5; Tue, 15 Aug 2023 17:57:20 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v1 0/3] PCI: qcom: Add support for OPP
Date:   Tue, 15 Aug 2023 17:56:45 +0530
Message-Id: <1692102408-7010-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UA7UezNcVe9bUb2TQlGiKS4jDyqlNk_f
X-Proofpoint-GUID: UA7UezNcVe9bUb2TQlGiKS4jDyqlNk_f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_13,2023-08-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0 mlxlogscore=358
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150111
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

Krishna chaitanya chundru (3):
  dt-bindings: pci: qcom: Add binding for operating-points-v2
  arm64: dts: qcom: sm8450: Add opp table support to PCIe
  PCI: qcom: Add OPP suuport for speed based performance state of RPMH

 .../devicetree/bindings/pci/qcom,pcie.yaml         |  2 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi               | 47 +++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c             | 61 ++++++++++++++++++++++
 3 files changed, 110 insertions(+)

-- 
2.7.4


