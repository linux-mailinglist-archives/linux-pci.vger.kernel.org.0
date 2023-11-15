Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654A67EC272
	for <lists+linux-pci@lfdr.de>; Wed, 15 Nov 2023 13:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343786AbjKOMhX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 07:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343800AbjKOMhV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 07:37:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FB213D;
        Wed, 15 Nov 2023 04:37:15 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF9N762007341;
        Wed, 15 Nov 2023 12:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=KvodZO9eoqV32uKWQ61uQ7iwGxYX5CUztBy+4JB5HDw=;
 b=pr+fbBY41dywegmYLMfDyVpbOwRYpxPfT19lyRXPfuzqgVh1/EERlbUoO9uW7xraTK9L
 gGIyDtul4HfTJgK+W+Ocb/2hrKjzdAjAPcyiUxdf0itoMV86KMjZemR87fyqOHx4AupU
 AerV2WHpNvwfBvDeL83dRsfB8jbay2CCMMnZ4g1YWM2jUZ2DFjRiQM6QPXNbUlurcxEU
 n2hmmleCjV/NaDJYnBBq9N4l/vgVD9CLTx/0e2qzbhayBgUN5ey5t9pUkeGmExlCrdk5
 sgcLlzyRFjWlnR/sJHSeYiA1Uj2VPNwIEjs/BG5oMdwVVJ+UQFzjDJf9u/d0nLjDGrd1 cQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucba6tqq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 12:37:08 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3AFCb5v6022061;
        Wed, 15 Nov 2023 12:37:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3ua2pmatv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 15 Nov 2023 12:37:05 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFCb4w1022050;
        Wed, 15 Nov 2023 12:37:04 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3AFCb45I022047;
        Wed, 15 Nov 2023 12:37:04 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id 0FAA84BD5; Wed, 15 Nov 2023 18:07:03 +0530 (+0530)
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
Subject: [PATCH v3 0/3] arm64: qcom: sa8775p: add cache coherency support for SA8775P
Date:   Wed, 15 Nov 2023 18:06:58 +0530
Message-Id: <1700051821-1087-1-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wJlz0OUE_wLnzPJFFoeEOdiU36uWdJW4
X-Proofpoint-ORIG-GUID: wJlz0OUE_wLnzPJFFoeEOdiU36uWdJW4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_11,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 mlxlogscore=288 phishscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150097
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In a multiprocessor system cache snooping maintains the consistency
of caches. Snooping logic is disabled from HW on this platform.
Cache coherency doesn’t work without enabling this logic.

This series is to enable cache snooping logic in both RC and EP
driver and add the "dma-coherent" property in dtsi to support
cache coherency in 8775 platform.

To verify this series we required [1]

[1] https://lore.kernel.org/all/1699669982-7691-1-git-send-email-quic_msarkar@quicinc.com/

v2 -> v3:
- update commit message(8755 -> 8775).

v1 -> v2:
- update cover letter with explanation.
- define each of these bits and ORing at usage time rather than
  directly writing value in register.

Mrinmay Sarkar (3):
  PCI: qcom: Enable cache coherency for SA8775P RC
  PCI: qcom-ep: Enable cache coherency for SA8775P EP
  arm64: dts: qcom: sa8775p: Mark PCIe controller as cache coherent

 arch/arm64/boot/dts/qcom/sa8775p.dtsi     |  1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 10 ++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c    | 13 +++++++++++++
 3 files changed, 24 insertions(+)

-- 
2.7.4

