Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1D376C3C0
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 05:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjHBDvn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 23:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjHBDvf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 23:51:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3A81BCC;
        Tue,  1 Aug 2023 20:51:34 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3722uoKr023085;
        Wed, 2 Aug 2023 03:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=hqWH1wZFX6/dz6P/dE70oqlC29OOIiNba9LUbBVVjm8=;
 b=X74NWK7GU57Tk7apQySpkI+rKr1kZKu53sGNY7Zc5IuiPkf4gr+vl09LEkqFIsrd/1aQ
 iEAFMkwhwQ3TwsSGEQdwF7Dva+roOJEfVbGCZuYblDgrmECFyg0ZucoTCFGGMrcwKH/V
 0AiOtftiWjyNcfPVVSWVvYwV2foRMQxbsIQ+YjEhK9i7Fg4kQ8hIoRBviIzElXB1D52H
 VXa/ATlYFQKiqVdEiPKdXvmmHu0600WhL2z8Gs+QmjO6WNZuANGIdI717JGqgVGO28Zh
 QbKDA4ovzdGJVwjXMb6nu1LtATiiX9+VnMIeVxdEw2Ce5foQeBTpNm3KMe10h3QmFcso VQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s72gqsjtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 03:51:28 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3723pOZN022480;
        Wed, 2 Aug 2023 03:51:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3s4uukryxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 02 Aug 2023 03:51:25 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3723pO86022456;
        Wed, 2 Aug 2023 03:51:24 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3723pNwU022448;
        Wed, 02 Aug 2023 03:51:24 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 14D944B5C; Wed,  2 Aug 2023 09:21:23 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH v5 1/4] PCI: endpoint: Add D-state change notifier support
Date:   Wed,  2 Aug 2023 09:21:18 +0530
Message-Id: <1690948281-2143-2-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690948281-2143-1-git-send-email-quic_krichai@quicinc.com>
References: <1690948281-2143-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pg-fQM61kHo-69Fe7pE89lzx2cOesOEs
X-Proofpoint-ORIG-GUID: pg-fQM61kHo-69Fe7pE89lzx2cOesOEs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_01,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=857 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020033
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to notify the EPF device about the D-state change event
from the EPC device.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 Documentation/PCI/endpoint/pci-endpoint.rst |  4 ++++
 drivers/pci/endpoint/pci-epc-core.c         | 27 +++++++++++++++++++++++++++
 include/linux/pci-epc.h                     |  1 +
 include/linux/pci-epf.h                     |  1 +
 4 files changed, 33 insertions(+)

diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
index 4f5622a..66f3191 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -78,6 +78,10 @@ by the PCI controller driver.
    Cleanup the pci_epc_mem structure allocated during pci_epc_mem_init().
 
 
+* pci_epc_dstate_notity()
+
+   Notify all the function drivers that the EPC device has changed its D-state.
+
 EPC APIs for the PCI Endpoint Function Driver
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 6c54fa5..4cf9c82 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -785,6 +785,33 @@ void pci_epc_bme_notify(struct pci_epc *epc)
 EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
 
 /**
+ * pci_epc_dstate_notity() - Notify the EPF driver that EPC device D-state
+ *			has changed
+ * @epc: the EPC device which has change in D-state
+ * @state: the changed D-state
+ *
+ * Invoke to Notify the EPF device that the EPC device has D-state has
+ * changed.
+ */
+void pci_epc_dstate_notity(struct pci_epc *epc, pci_power_t state)
+{
+	struct pci_epf *epf;
+
+	if (!epc || IS_ERR(epc))
+		return;
+
+	mutex_lock(&epc->list_lock);
+	list_for_each_entry(epf, &epc->pci_epf, list) {
+		mutex_lock(&epf->lock);
+		if (epf->event_ops && epf->event_ops->dstate_notify)
+			epf->event_ops->dstate_notify(epf, state);
+		mutex_unlock(&epf->lock);
+	}
+	mutex_unlock(&epc->list_lock);
+}
+EXPORT_SYMBOL_GPL(pci_epc_dstate_notity);
+
+/**
  * pci_epc_destroy() - destroy the EPC device
  * @epc: the EPC device that has to be destroyed
  *
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 5cb6940..26a1108 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -251,4 +251,5 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
 				     phys_addr_t *phys_addr, size_t size);
 void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
 			   void __iomem *virt_addr, size_t size);
+void pci_epc_dstate_change(struct pci_epc *epc, pci_power_t state);
 #endif /* __LINUX_PCI_EPC_H */
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 3f44b6a..529075b 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -79,6 +79,7 @@ struct pci_epc_event_ops {
 	int (*link_up)(struct pci_epf *epf);
 	int (*link_down)(struct pci_epf *epf);
 	int (*bme)(struct pci_epf *epf);
+	int (*dstate_notify)(struct pci_epf *epf, pci_power_t state);
 };
 
 /**
-- 
2.7.4

