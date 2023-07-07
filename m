Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9230074AF6E
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 13:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjGGLFN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 07:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjGGLFJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 07:05:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3081BD2;
        Fri,  7 Jul 2023 04:04:41 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3676dDgF013979;
        Fri, 7 Jul 2023 11:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=QXmy030ikNWnWChHa47/KnRaCnnbff7PjI6Sc/FI0cI=;
 b=hq/6HBnWMvmC6vcC+VFXCmYJyRAbxWtOz+3+mBXseUJZHzpwFN/I09kKm6xq5O1WIjjK
 KxqkupNYHPhaZ5iu17naJ5YqmzGdinsqdoriiLUwYDRswk4OSjFHXgi1VGJ5Zs8LX74U
 Yl74t7wFbq4KzcjJYl+IBLAUaz7gNxRpaOBkxCQ7P3tAyDRxEYP+5QqPD/i+cy4pxXrJ
 6Aqui0WJBIhTUVijjEnJc3YNd4sUhkHDtYlLWaCFI2WPYXfTWNJaRQUubyqeCCfKdnAy
 Gn/Y+6moaUbjJCiV3Q4YJV8WaSEfSkotmacMpw7HwzT1Ngne1gilSM/LUfEPy/qcw6nN cQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rnx4x2m9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 11:04:33 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 367B41WZ022752;
        Fri, 7 Jul 2023 11:04:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rjd7kq59m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 07 Jul 2023 11:04:05 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 367B45jI022834;
        Fri, 7 Jul 2023 11:04:05 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 367B45q4022832;
        Fri, 07 Jul 2023 11:04:05 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 6001A46E0; Fri,  7 Jul 2023 16:34:04 +0530 (+0530)
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
Subject: [PATCH v3 8/9] PCI: epf-mhi: Add wakeup host op
Date:   Fri,  7 Jul 2023 16:33:55 +0530
Message-Id: <1688727836-11141-9-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688727836-11141-1-git-send-email-quic_krichai@quicinc.com>
References: <1688727836-11141-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cSFr7GHHAv6HzdR4JorKRNG0X0IYJ1OQ
X-Proofpoint-GUID: cSFr7GHHAv6HzdR4JorKRNG0X0IYJ1OQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 spamscore=0 mlxlogscore=793 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Add wakeup host op for MHI EPF.
If the D-state is in D3cold toggle wake signal, otherwise send PME.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 17 +++++++++++++++++
 include/linux/mhi_ep.h                       |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 631eb2f7..d84f869 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -237,6 +237,22 @@ static int pci_epf_mhi_write_to_host(struct mhi_ep_cntrl *mhi_cntrl,
 	return 0;
 }
 
+static int pci_epf_mhi_wakeup_host(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
+	struct pci_epf *epf = epf_mhi->epf;
+	enum pci_epc_wakeup_host_type type;
+	struct pci_epc *epc = epf->epc;
+	int ret;
+
+	type = PCI_WAKEUP_SEND_PME;
+	if (mhi_cntrl->dstate == PCI_D3cold)
+		type = PCI_WAKEUP_TOGGLE_WAKE;
+
+	return pci_epc_wakeup_host(epc, epf->func_no, epf->vfunc_no, type);
+
+}
+
 static int pci_epf_mhi_core_init(struct pci_epf *epf)
 {
 	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
@@ -293,6 +309,7 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
 	mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
 	mhi_cntrl->read_from_host = pci_epf_mhi_read_from_host;
 	mhi_cntrl->write_to_host = pci_epf_mhi_write_to_host;
+	mhi_cntrl->wakeup_host = pci_epf_mhi_wakeup_host;
 
 	/* Register the MHI EP controller */
 	ret = mhi_ep_register_controller(mhi_cntrl, info->config);
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index c3a0685..e353c429 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -137,6 +137,7 @@ struct mhi_ep_cntrl {
 			   void __iomem *virt, size_t size);
 	int (*read_from_host)(struct mhi_ep_cntrl *mhi_cntrl, u64 from, void *to, size_t size);
 	int (*write_to_host)(struct mhi_ep_cntrl *mhi_cntrl, void *from, u64 to, size_t size);
+	int (*wakeup_host)(struct mhi_ep_cntrl *mhi_cntrl);
 
 	enum mhi_state mhi_state;
 
-- 
2.7.4

