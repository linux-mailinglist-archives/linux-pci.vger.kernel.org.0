Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD2A751968
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 09:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjGMHKd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 03:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjGMHKb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 03:10:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0EA119;
        Thu, 13 Jul 2023 00:10:29 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D61Otg013396;
        Thu, 13 Jul 2023 07:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=DE5Ui7Pw5qDglMLW1EMA7/HYCBRaPwY9cFGB1D8V3EE=;
 b=By0ur8OJO5SgFYh6ApoNzudBc5ULBxwk862fLrZJYVz05OposiNZYfhauXsddmJTjhDM
 6iCmHSr0YenH4eKv0byvNPhwBnPEyom46Yytvp8oOx2BHMlAl6cUNH1HHLaAnk5qu+Bt
 neNuUMv5XFmq7Fu/VujICLUp/oxlDTBefNMLxXb26HUde9vG5lKn60XVesTh2ftlq7EF
 bOH/2BsMJLK6BJnzqIjIVi/+959hDCArc7eViidieCy3z+QdgD2W0c2HEa5SSH97+hht
 0Mnxu6IZqeamZjju7rTl3FFF5ChsWjb09u6BqJdQxVAWRVV0EIcAaX0JraOBGLaTKHcg 3g== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtbmur3hx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 07:10:25 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36D7AMdo030162;
        Thu, 13 Jul 2023 07:10:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rq0vkymgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 13 Jul 2023 07:10:22 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36D7ALUB030146;
        Thu, 13 Jul 2023 07:10:21 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36D7ALNK030144;
        Thu, 13 Jul 2023 07:10:21 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id C5F5447AD; Thu, 13 Jul 2023 12:40:20 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v4 0/9] PCI: EPC: Add support to wake up host from D3 states
Date:   Thu, 13 Jul 2023 12:40:09 +0530
Message-Id: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nVnAlYQ2ebnUAzvlwW-vG-JKWsWCWYE6
X-Proofpoint-ORIG-GUID: nVnAlYQ2ebnUAzvlwW-vG-JKWsWCWYE6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=463 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130061
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

---
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

Krishna chaitanya chundru (9):
  PCI: endpoint: Add D-state change notifier support
  PCI: qcom-ep: Add support for D-state change notification
  PCI: epf-mhi: Add support for handling D-state notify from EPC
  PCI: qcom-ep: Update the D-state log
  PCI: endpoint: Add wakeup host API to EPC core
  PCI: dwc: Add wakeup host op to pci_epc_ops
  PCI: qcom-ep: Add wake up host op to dw_pcie_ep_ops
  PCI: epf-mhi: Add wakeup host op
  bus: mhi: ep: wake up host if the MHI state is in M3

 Documentation/PCI/endpoint/pci-endpoint.rst     | 11 +++++
 drivers/bus/mhi/ep/main.c                       | 27 ++++++++++++
 drivers/pci/controller/dwc/pcie-designware-ep.c | 12 +++++
 drivers/pci/controller/dwc/pcie-designware.h    |  3 ++
 drivers/pci/controller/dwc/pcie-qcom-ep.c       | 36 ++++++++++++++-
 drivers/pci/endpoint/functions/pci-epf-mhi.c    | 27 ++++++++++++
 drivers/pci/endpoint/pci-epc-core.c             | 58 +++++++++++++++++++++++++
 include/linux/mhi_ep.h                          |  4 ++
 include/linux/pci-epc.h                         | 12 +++++
 include/linux/pci-epf.h                         |  1 +
 10 files changed, 190 insertions(+), 1 deletion(-)

-- 
2.7.4

