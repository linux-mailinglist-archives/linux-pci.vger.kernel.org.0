Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FDC7E883E
	for <lists+linux-pci@lfdr.de>; Sat, 11 Nov 2023 03:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjKKCd1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Nov 2023 21:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKKCd0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2023 21:33:26 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0F83C0E;
        Fri, 10 Nov 2023 18:33:23 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AB2Q6sa028405;
        Sat, 11 Nov 2023 02:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=oMgRjePFUFpCELXWxhyPu5TQ/N5d4vEagtnVOU9S6M8=;
 b=CTmsXXHp2s3OgPnP0lHovhg8H1LEO2QdGiuoj/h2MElqF5J8ZmMN4Ggk5RoKofl5QxKP
 xYxyAAPWCrOud8xtJxVTViBJfA4ODbxa5eBC2+GFZnhKCN0/OWm1uBSQSVjWbg5YhbMe
 ocRbtZTPDKfKYNBEtxSv93FsvF0Cvw8c3Gu3IjzlYMt+Q4PFi23Mffz7kaoDfm8r7KAZ
 7UqOyioXjThsdHCGWWrAkFlCJdkZ8pvjpcQt11zbVGSg5FmzDjgWDx/dUdy/mgF7qTnl
 gsGY4aVyiDM9w5ohMPkWAPy7N5hRX8dwSK/nyld6ImGlWkMsMXdKipCJ8qmAP3eK1f38 aQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u99e93491-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Nov 2023 02:33:11 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3AB2X7GD021687;
        Sat, 11 Nov 2023 02:33:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3u5f1mjp3k-1;
        Sat, 11 Nov 2023 02:33:07 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AB2X7uN021677;
        Sat, 11 Nov 2023 02:33:07 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3AB2X6NK021675;
        Sat, 11 Nov 2023 02:33:07 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id BAAF82C83; Sat, 11 Nov 2023 08:03:05 +0530 (+0530)
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
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev
Subject: [PATCH v8 0/5] arm64: qcom: sa8775p: add support for EP PCIe
Date:   Sat, 11 Nov 2023 08:02:56 +0530
Message-Id: <1699669982-7691-1-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QvzFF8Sn6VKTla8Nso4RCQB3zyPOxREg
X-Proofpoint-ORIG-GUID: QvzFF8Sn6VKTla8Nso4RCQB3zyPOxREg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_21,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=597 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311110018
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds the relavent DT bindings, new compatible string,
add support to EPF driver and add EP PCIe node in dtsi file for
ep pcie0 controller.

v7 -> v8:
- Add new patch PCI: epf-mhi: Add "pci_epf_mhi_" prefix to the function
  names
- Update PCI: epf-mhi: Add support for SA8775P patch on top of the new
  patch and update commit message.

v6 -> v7:
- add reviewed by tag in commit message in all patches.
- update commit message in patch 2 as per comment.
- update reason for reusing PID in commit message.

v5 -> v6:
- update cover letter.

v4 -> v5:
- add maxItems to the respective field to constrain io space and
  interrupt in all variants.

v3 -> v4:
- add maxItems field in dt bindings
- update comment in patch2
- dropped PHY driver patch as it is already applied [1]
- update comment in EPF driver patch
- update commect in dtsi and add iommus instead of iommu-map

[1] https://lore.kernel.org/all/169804254205.383714.18423881810869732517.b4-ty@kernel.org/

v2 -> v3:
- removed if/then schemas, added minItems for reg,
  reg-bnames, interrupt and interrupt-names instead.
- adding qcom,sa8775p-pcie-ep compitable for sa8775p
  as we have some specific change to add.
- reusing sm8450's pcs_misc num table as it is same as sa8775p.
  used appropriate namespace for pcs.
- remove const from sa8775p_header as kernel test robot
  throwing some warnings due to this.
- remove fallback compatiable as we are adding compatiable for sa8775p.

v1 -> v2:
- update description for dma
- Reusing qcom,sdx55-pcie-ep compatibe so remove compaitable
  for sa8775p
- sort the defines in phy header file and remove extra defines
- add const in return type pci_epf_header and remove MHI_EPF_USE_DMA
  flag as hdma patch is not ready
- add fallback compatiable as qcom,sdx55-pcie-ep, add iommu property


Mrinmay Sarkar (5):
  dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC
  PCI: qcom-ep: Add support for SA8775P SOC
  PCI: epf-mhi: Add "pci_epf_mhi_" prefix to the function names
  PCI: epf-mhi: Add support for SA8775P
  arm64: dts: qcom: sa8775p: Add ep pcie0 controller node

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 64 +++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 46 ++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  1 +
 drivers/pci/endpoint/functions/pci-epf-mhi.c       | 21 ++++++-
 4 files changed, 128 insertions(+), 4 deletions(-)

-- 
2.7.4

