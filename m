Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AA076C464
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 06:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjHBE7j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 00:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjHBE7i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 00:59:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBF31BFA;
        Tue,  1 Aug 2023 21:59:37 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3723OI3F020182;
        Wed, 2 Aug 2023 04:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=kMErFIqWFbN25KqkFKK6YzYOatQw6VWpghdd42BrtU0=;
 b=NXz2w4ld+JJtaEJApD+HC/9MdctewbyB1Pq7q6aleIeWJMJRqNG6BVI4qHnevMhih0CK
 wvYSavsYKSFGoWb4NPCuo/jYPR6r4TdHq11x6P7BAb4dOx6q+am+DGb+gvfoRARDrWhy
 lABjlDxuFRqzWTnc6j2waJFy8vagg3htakG46VGUhh3lNUNIt4ndsoHBzGgWblAqgoq9
 s9Z4s2Jv3ag/77b3uj3UWuv0UVRJQA1k1DC+xylmhm2emw1qwu+ltQCpdiRD9pVVcqJM
 aiCHmMazBwPhsVCw8M93t4Bzh6vyH+IIGrprvwOTg6mSMxhkemRCm7GuiJyfApL5JTA+ uQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7adk8jfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 04:59:31 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3724xR1H022302;
        Wed, 2 Aug 2023 04:59:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3s4uukd91t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 02 Aug 2023 04:59:27 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3724xQFJ022282;
        Wed, 2 Aug 2023 04:59:26 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3724xQ3r022279;
        Wed, 02 Aug 2023 04:59:26 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 4890D4B59; Wed,  2 Aug 2023 10:29:25 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v5 0/5]  PCI: EPC: Add support to wake up host from D3 states
Date:   Wed,  2 Aug 2023 10:29:14 +0530
Message-Id: <1690952359-8625-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vr2OErjd5gURnCDKGDRMbywFvrypQxSK
X-Proofpoint-GUID: vr2OErjd5gURnCDKGDRMbywFvrypQxSK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_03,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=622 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020044
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Here we propose this patch series to add support in PCI endpoint
driver to wake up host from D3 states.

As endpoint cannot send any data/MSI when the D-state is in
D3cold or D3hot. Endpoint needs to bring the device back to D0
to send any kind of data.

For this endpoint needs to send inband PME the device is in D3 state or
toggle wake when the device is D3 cold and vaux is not supplied.

Based on the D-state the EPF driver decides to wake host either by
toggling wake or by sending PME.

When the MHI state is in M3 MHI driver will wakeup the host using the
wakeup op.

This change is dependent on this series PCI: endpoint: add D-state change notifier
support

https://lore.kernel.org/linux-pci/1690948281-2143-1-git-send-email-quic_krichai@quicinc.com/

---
Changes from v4:
	- removed the enum to select to send PME or toggle wake and use bool variable in 
	  the api itself as suggested by mani.
Changes from v3:
	- changed the bool return type to int for waking the host in mhi ep driver
	 as suggested by dan and bjorn.
	- Changed commit logs as suggested by bjorn.
Changes from v2:
        - Addressed review comments made by mani.
Changes from v1:
        - Moved from RFC patch to regular patch
        - Inclueded EPF patch and added a new op patch to notify D-state change.
---

Krishna chaitanya chundru (5):
  PCI: endpoint: Add wakeup host API to EPC core
  PCI: dwc: Add wakeup host op to pci_epc_ops
  PCI: qcom-ep: Add wake up host op to dw_pcie_ep_ops
  PCI: epf-mhi: Add wakeup host op
  bus: mhi: ep: wake up host if the MHI state is in M3

 Documentation/PCI/endpoint/pci-endpoint.rst     |  6 +++++
 drivers/bus/mhi/ep/main.c                       | 28 +++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware-ep.c | 12 ++++++++++
 drivers/pci/controller/dwc/pcie-designware.h    |  2 ++
 drivers/pci/controller/dwc/pcie-qcom-ep.c       | 26 +++++++++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-mhi.c    | 12 ++++++++++
 drivers/pci/endpoint/pci-epc-core.c             | 30 +++++++++++++++++++++++++
 include/linux/mhi_ep.h                          |  1 +
 include/linux/pci-epc.h                         |  5 +++++
 9 files changed, 122 insertions(+)

-- 
2.7.4

