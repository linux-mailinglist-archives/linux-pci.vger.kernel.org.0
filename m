Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A2B74AF60
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 13:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjGGLEi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 07:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjGGLEg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 07:04:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A8A212B;
        Fri,  7 Jul 2023 04:04:28 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3679G1Qx020337;
        Fri, 7 Jul 2023 11:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=l15t62Tr53wbsga4FHT8TE6qtVXyNR0Rgnu51XUnGAo=;
 b=n6OY4zIsI9uuzK05J1zTvl7Bki7CphGlM3JDMzGaMtzd35xpmrhDPI0eS2XLAtsDqC+u
 COW0oh/tM9JKm/3/wVn/wbulzWBJBEsCM80vITxoI7K0q5/zx3xMvreNU0dpMApiGRpT
 bu3dHYovTSOoSxMaH7liJVTJr31kPLZzzY5dsjh7/TNm/A/ozKLPIeLR4xBYUiB6il+K
 pHcd8bfAdsHa67T7n5wdf8ebJBXK8aoIBjCKkg7R/g+t5GW2+ib+JIubdAsXzE68qwLh
 R5lnsbW/qC+zfzdHKJNkskdjpof6o5NoeVh7L9F5IP8hO/Cdk4So8xBaqoYD2uOhdtpo cw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rp96vs8pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 11:04:25 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 367B3xAf022730;
        Fri, 7 Jul 2023 11:03:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rjd7kq588-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 07 Jul 2023 11:03:59 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 367B3xNS022714;
        Fri, 7 Jul 2023 11:03:59 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 367B3xP7022711;
        Fri, 07 Jul 2023 11:03:59 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 765A846E0; Fri,  7 Jul 2023 16:33:58 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v3 0/9] PCI: EPC: Add support to wake up host from D3 states
Date:   Fri,  7 Jul 2023 16:33:47 +0530
Message-Id: <1688727836-11141-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tNbf--oTcO6NG3RNoLw-_HyZUwB-31ME
X-Proofpoint-GUID: tNbf--oTcO6NG3RNoLw-_HyZUwB-31ME
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=385
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070103
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

As EPF doestn't know the D-state of the PCI, added a notify op whenever
device state changes.

Based on the D-state the EPF driver decides to wake host either by
toggling wake or by sending PME.

When the MHI state is in M3 MHI driver will wakeup the host using the
wakeup op.

Changes from v2:
	- Addressed review comments made by mani.
Changes from v1:
        - Moved from RFC patch to regular patch
        - Inclueded EPF patch and added a new op patch to notify D-state change

*** BLURB HERE ***

Krishna chaitanya chundru (9):
  PCI: endpoint: Add dstate change notifier support
  PCI: qcom-ep: Add support for D-state change notification
  PCI: qcom-ep: Update the D-state log
  PCI: epf-mhi: Add support for handling D-state notify from EPC
  PCI: endpoint: Add wakeup host API to EPC core
  pci: dwc: Add wakeup host op to pci_epc_ops
  PCI: qcom-ep: Add wake up host op to dw_pcie_ep_ops
  PCI: epf-mhi: Add wakeup host op
  bus: mhi: ep: wake up host is the MHI state is in M3

 Documentation/PCI/endpoint/pci-endpoint.rst     | 11 +++++
 drivers/bus/mhi/ep/main.c                       | 28 ++++++++++++
 drivers/pci/controller/dwc/pcie-designware-ep.c | 12 +++++
 drivers/pci/controller/dwc/pcie-designware.h    |  3 ++
 drivers/pci/controller/dwc/pcie-qcom-ep.c       | 36 ++++++++++++++-
 drivers/pci/endpoint/functions/pci-epf-mhi.c    | 28 ++++++++++++
 drivers/pci/endpoint/pci-epc-core.c             | 58 +++++++++++++++++++++++++
 include/linux/mhi_ep.h                          |  4 ++
 include/linux/pci-epc.h                         | 12 +++++
 include/linux/pci-epf.h                         |  1 +
 10 files changed, 192 insertions(+), 1 deletion(-)

-- 
2.7.4

