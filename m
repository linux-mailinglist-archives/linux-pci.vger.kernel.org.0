Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806AE74AF6C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 13:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjGGLFJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 07:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjGGLFF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 07:05:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583B1211B;
        Fri,  7 Jul 2023 04:04:39 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3677o8Sg015784;
        Fri, 7 Jul 2023 11:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=UDSsmoUraudRLaPRoWFOilDSae5+4QzsU69CFMk/BIM=;
 b=QxKG5WDklxomedfas8VET2E1J/44kbR+Vl0473/pcvagnQxmozDDnekTrzcKDYzNXvKD
 yRPhu29m4J2FdqfpBCuuAahEXJYaTP+OXUYYnEqQTMS050hvchP0ek/OAa4cQ1Tn91Cu
 G12GWXr7IuxZnD2BzzI85IBhOx1eGJkDN75GpuYpvQ0y6CttQC/R2Du8bJOfkp6q+sEL
 ghzoGNCuXbuCM7VyTxbEVBoDncBqaMJa8ALtjcEEw8Yx9RrJ0lVnhVEcPUyzletU/ovX
 clyJKrGKaRtnE04hfkfa8u4nt8WNRV2debx48PUTSCQrmFTQ/IrZefx2eTx/2ymv7bTA MQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpenqrhqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 11:04:30 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 367B40F0022731;
        Fri, 7 Jul 2023 11:04:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rjd7kq58x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 07 Jul 2023 11:04:02 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 367B42LP022771;
        Fri, 7 Jul 2023 11:04:02 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 367B41A3022769;
        Fri, 07 Jul 2023 11:04:02 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 69AB946E0; Fri,  7 Jul 2023 16:34:01 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        mhi@lists.linux.dev (open list:MHI BUS)
Subject: [PATCH v3 4/9] PCI: epf-mhi: Add support for handling D-state notify from EPC
Date:   Fri,  7 Jul 2023 16:33:51 +0530
Message-Id: <1688727836-11141-5-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688727836-11141-1-git-send-email-quic_krichai@quicinc.com>
References: <1688727836-11141-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dM2gPJm6J2XJxH530ruQ9I_LXzf6Ci5T
X-Proofpoint-GUID: dM2gPJm6J2XJxH530ruQ9I_LXzf6Ci5T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=774 phishscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070103
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for handling D-state notify for MHI EPF.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 11 +++++++++++
 include/linux/mhi_ep.h                       |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 9c1f5a1..631eb2f7 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -339,6 +339,16 @@ static int pci_epf_mhi_bme(struct pci_epf *epf)
 	return 0;
 }
 
+static int pci_epf_mhi_dstate_notify(struct pci_epf *epf, pci_power_t state)
+{
+	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
+	struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
+
+	mhi_cntrl->dstate = state;
+
+	return 0;
+}
+
 static int pci_epf_mhi_bind(struct pci_epf *epf)
 {
 	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
@@ -394,6 +404,7 @@ static struct pci_epc_event_ops pci_epf_mhi_event_ops = {
 	.link_up = pci_epf_mhi_link_up,
 	.link_down = pci_epf_mhi_link_down,
 	.bme = pci_epf_mhi_bme,
+	.dstate_notify = pci_epf_mhi_dstate_notify,
 };
 
 static int pci_epf_mhi_probe(struct pci_epf *epf,
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index f198a8a..c3a0685 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -8,6 +8,7 @@
 
 #include <linux/dma-direction.h>
 #include <linux/mhi.h>
+#include <linux/pci.h>
 
 #define MHI_EP_DEFAULT_MTU 0x8000
 
@@ -139,6 +140,8 @@ struct mhi_ep_cntrl {
 
 	enum mhi_state mhi_state;
 
+	pci_power_t dstate;
+
 	u32 max_chan;
 	u32 mru;
 	u32 event_rings;
-- 
2.7.4

