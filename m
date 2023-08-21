Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E79782B51
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 16:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbjHUOPz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 10:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbjHUOPy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 10:15:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A795FA;
        Mon, 21 Aug 2023 07:15:51 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LDarDX009618;
        Mon, 21 Aug 2023 14:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=m1u70u61gLTo70AR3r6Jj+sm6TQg8PhXTIvui3IQJcI=;
 b=aSvshNbG+bFb1ScsGp4x5O5DD65qcLGYsE3QRYTQzfFDp1vGeNqf6ntjVoPkFGFhnfiE
 Dj5rcQqJIDwroqxwym93aH4kBvwjxnbb+ynXu9p9+Wocl1i44G/TjiJrdREBSxJhAaDX
 5nNzzh6UuLENGiAK7xJrBpAEZsWrdxvFvXvIz5bxkCMgrzLoBj0U9pYhqGNNAA1rJ3DV
 lN/eAaqgoUxW1sb8WTcCLxHUAhUj0g08DBmg9rlDr17oq2BdMpczToKEfcQudYP9rZpo
 w20E2pj44R7+sEZeVW+vRwml2NY+SAArg/vKrPZ+QgvPo8DUGrBehkI8ZiKK0hsHo/jw lg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sjk3tky7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 14:15:48 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37LEFj6O009997;
        Mon, 21 Aug 2023 14:15:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sjptkpqf1-1;
        Mon, 21 Aug 2023 14:15:45 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37LEFj7U009989;
        Mon, 21 Aug 2023 14:15:45 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 37LEFiCb009988;
        Mon, 21 Aug 2023 14:15:45 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 3B98C4C12; Mon, 21 Aug 2023 19:45:44 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v3 0/3] PCI: qcom: Add support for OPP
Date:   Mon, 21 Aug 2023 19:45:40 +0530
Message-Id: <1692627343-4380-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2jURpxmrZzkds84plSqG8UVqMSeBx3N2
X-Proofpoint-ORIG-GUID: 2jURpxmrZzkds84plSqG8UVqMSeBx3N2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 spamscore=0
 mlxlogscore=602 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308210131
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds support for OPP to vote for the performance state of RPMH
power domain based upon GEN speed it PCIe got enumerated.

Before link up PCIe driver will vote for the maximum performance state.

changes from v3:
	- Instead of using the freq based opp search use level based as suggested
	  by Dmitry Baryshkov.
Changes from v1:
        - Addressed comments from Krzysztof Kozlowski.
        - Added the rpmhpd_opp_xxx phandle as suggested by pavan.
        - Added dev_pm_opp_set_opp API call which was missed on previous patch.

Krishna chaitanya chundru (3):
  dt-bindings: pci: qcom: Add binding for operating-points-v2
  arm64: dts: qcom: sm8450: Add opp table support to PCIe
  PCI: qcom: Add OPP support for speed based performance state of RPMH

 .../devicetree/bindings/pci/qcom,pcie.yaml         |  4 ++
 arch/arm64/boot/dts/qcom/sm8450.dtsi               | 47 ++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c             | 47 ++++++++++++++++++++++
 3 files changed, 98 insertions(+)

-- 
2.7.4

