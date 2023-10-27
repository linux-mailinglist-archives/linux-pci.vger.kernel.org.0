Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229D67D99E5
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 15:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345892AbjJ0Ne1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 09:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjJ0Ne0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 09:34:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E8BD6;
        Fri, 27 Oct 2023 06:34:23 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RCqAA3001415;
        Fri, 27 Oct 2023 13:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=RZRsq6NSc8v50RtGhhXOa3FDVL7OuBZ8+GKl30Gtyzs=;
 b=RWvLfLJ0NXzGH4T0xui4L0WE54PDTrv0sTrKvQJrdrmA3rKcJ7S8pJ9k1zp8V3P+dQ7B
 ADH/w3Jue6FHzQeP14WXKrS40653cCZXTExbUdM2ho0OdZ44QVnpInTaFMio2u6ujb+Q
 UCZ4m2hRhxZGuU9hlm0RHVPsQ5KcjyHPv0Z4UbgFrICw6P/KPIFz58xS/vUg6rGgsPet
 oOZHcfWQ3lz27MExDOBOCBDLwumuM22DEjczR77hBHbzlVj+utOXH3Edh6FY6q+NcF0j
 ju/yeTQqCjQviVp3HtOqChgsK3CY+Sd/elwD+Yo+RI4amoZLfFC6HtDyglyPyLeh49qK NA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyws9a8tj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 13:33:20 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39RDXHN1026021;
        Fri, 27 Oct 2023 13:33:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3tv7qmaape-1;
        Fri, 27 Oct 2023 13:33:17 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39RDXGhL026015;
        Fri, 27 Oct 2023 13:33:16 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 39RDXFSJ026014;
        Fri, 27 Oct 2023 13:33:16 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id 31BE4481E; Fri, 27 Oct 2023 19:03:15 +0530 (+0530)
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, quic_schintav@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev
Subject: [PATCH v4 0/4] arm64: qcom: sa8775p: add support for EP PCIe
Date:   Fri, 27 Oct 2023 19:03:08 +0530
Message-Id: <1698413592-26523-1-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gGNF1ox1zsnyPE4Hp4jLZNIU78BBbxQh
X-Proofpoint-GUID: gGNF1ox1zsnyPE4Hp4jLZNIU78BBbxQh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_11,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=347 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270117
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds the relavent DT bindings, new compatible string,
add support to EPF driver and add EP PCIe node in dtsi file for
ep pcie0 controller.

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


Mrinmay Sarkar (4):
  dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC
  PCI: qcom-ep: Add support for SA8775P SOC
  PCI: epf-mhi: Add support for SA8775P
  arm64: dts: qcom: sa8775p: Add ep pcie0 controller node

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 48 +++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 46 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  1 +
 drivers/pci/endpoint/functions/pci-epf-mhi.c       | 17 ++++++++
 4 files changed, 110 insertions(+), 2 deletions(-)

-- 
2.7.4

