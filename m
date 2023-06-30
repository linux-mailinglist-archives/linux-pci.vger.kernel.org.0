Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D16F7439E1
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 12:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjF3KwZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 06:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjF3KwX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 06:52:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1A635AF;
        Fri, 30 Jun 2023 03:52:22 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U9IqOe011436;
        Fri, 30 Jun 2023 10:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=lDAMfguN/Oi65s75t9Fww/pWagtN3YyKDqCIn+q6vwM=;
 b=d4Z9vANmdQXbzJii6b6A3+24cMa0OhWTIJHqVD8I3WLiL5pFzl1nyEUasXrGvWBZe/2z
 /aGJq6Xgn+yDxHjt/5NSDazKpkqGyiZQmmRRwVXcWMsHLyG/ZCemZKpfAbyYqziqCFxj
 aQ0lV+LI4Lsr/p67ZkKyXla+hqoNKreK0waLbu28zj1gx9wz+6fwqa5qiPKYh4dFDsXR
 ZHpr2932XFOjw+4twe2lbY179+s7SfCLRECRp8afKji+4jC/Wlo0XlJMAgirrkCMnTXb
 +Ie1wPBZnPuF4Lly13fvDQx0cxc9ZscwPgc/cBapA67/+Z6GHzmEDHV2Qyz33xLcxPIY Gw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rhfew9nvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 10:52:17 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35UAqDJx004625;
        Fri, 30 Jun 2023 10:52:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rdsjkpf1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Jun 2023 10:52:13 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UAqCcJ004610;
        Fri, 30 Jun 2023 10:52:13 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 35UAqC8o004605;
        Fri, 30 Jun 2023 10:52:12 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 082174ABD; Fri, 30 Jun 2023 16:22:12 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v2 0/8] PCCI: EPC: Add support to wake up host from D3 states
Date:   Fri, 30 Jun 2023 16:22:03 +0530
Message-Id: <1688122331-25478-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VDcv7iTz9CrIxszYA5AUHww6jagh1-wg
X-Proofpoint-GUID: VDcv7iTz9CrIxszYA5AUHww6jagh1-wg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 spamscore=0 mlxlogscore=352 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300092
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

Changes from v1:
	- Moved from RFC patch to regular patch
	- Inclueded EPF patch and added a new op patch to notify dstate change
Krishna chaitanya chundru (8):
  PCI: endpoint: Add dstate change notifier support
  PCI: qcom-ep: Add support for D-state change notification
  PCI: epf-mhi: Add dtate change op
  PCI: endpoint: Add wakeup host API to EPC core
  pci: dwc: Add wakeup host op to pci_epc_ops
  PCI: qcom: ep: Add wake up host op to dw_pcie_ep_ops
  PCI: epf-mhi: Add wakeup host op
  bus: mhi: ep: wake up host is the MHI state is in M3

 Documentation/PCI/endpoint/pci-endpoint.rst     | 11 +++++
 drivers/bus/mhi/ep/main.c                       | 16 ++++++-
 drivers/pci/controller/dwc/pcie-designware-ep.c | 12 +++++
 drivers/pci/controller/dwc/pcie-designware.h    |  3 ++
 drivers/pci/controller/dwc/pcie-qcom-ep.c       | 37 ++++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-mhi.c    | 32 ++++++++++++++
 drivers/pci/endpoint/pci-epc-core.c             | 58 +++++++++++++++++++++++++
 include/linux/mhi_ep.h                          |  4 ++
 include/linux/pci-epc.h                         | 12 +++++
 include/linux/pci-epf.h                         |  1 +
 10 files changed, 185 insertions(+), 1 deletion(-)

-- 
2.7.4

