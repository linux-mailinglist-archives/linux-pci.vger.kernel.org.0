Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311827439FD
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 12:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjF3KxB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 06:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjF3Kw5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 06:52:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E40358A;
        Fri, 30 Jun 2023 03:52:56 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UAMUMk021002;
        Fri, 30 Jun 2023 10:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=qSBCqNr7HThrO5qc+qjL+xE0BVneevTd9s/gLlHxryg=;
 b=euhuaAwbByL1i4WX75FucNX1MhNhLRQmcg1CIjKuKkefKGmyNJTH3JBX6UcXqXy68qQu
 52xY1LUvmr8xtLOETNyL+l6DsOkVXqI12cp5PA63/rM+CsK6ZDna5HKcbFGY0EoH5n0I
 2a3Dp5hPF2Ks3OagLdXHr8JpATU7Fj0sJqvMthw4n0uK/hTTOrJGPXv+Ke8uiA8u4yOg
 ygt3rMLsFxbZ0hqGrLqhP8fX04WMFZV0xdX9fWB6PnWWbMAMyc8Z/1YM0GkFVRluqQ39
 vSSZENh6upHd1/74KljiLxAxOckyxTQPEJUYyQjUJr/eJwXyQaGGpqH93m15uVZgJdCt iQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rhgpgsfsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 10:52:48 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35UAqD3C004632;
        Fri, 30 Jun 2023 10:52:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rdsjkpf1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Jun 2023 10:52:13 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UAqD8I004615;
        Fri, 30 Jun 2023 10:52:13 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 35UAqCKw004608;
        Fri, 30 Jun 2023 10:52:13 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 6572F4AC1; Fri, 30 Jun 2023 16:22:12 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH v2 1/8] PCI: endpoint: Add dstate change notifier support
Date:   Fri, 30 Jun 2023 16:22:04 +0530
Message-Id: <1688122331-25478-2-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688122331-25478-1-git-send-email-quic_krichai@quicinc.com>
References: <1688122331-25478-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m1pEml9JmOHLsp6VdZM8Vr4ehwpZcudg
X-Proofpoint-ORIG-GUID: m1pEml9JmOHLsp6VdZM8Vr4ehwpZcudg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=830 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306300092
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to notify the EPF device about the D-state change event
from the EPC device.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 Documentation/PCI/endpoint/pci-endpoint.rst |  5 +++++
 drivers/pci/endpoint/pci-epc-core.c         | 27 +++++++++++++++++++++++++++
 include/linux/pci-epc.h                     |  1 +
 include/linux/pci-epf.h                     |  1 +
 4 files changed, 34 insertions(+)

diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
index 4f5622a..0538cdc 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -78,6 +78,11 @@ by the PCI controller driver.
    Cleanup the pci_epc_mem structure allocated during pci_epc_mem_init().
 
 
+* pci_epc_dstate_change()
+
+   In order to notify all the function devices that the EPC device has
+   changed its D-state.
+
 EPC APIs for the PCI Endpoint Function Driver
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 6c54fa5..cad360f 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -785,6 +785,33 @@ void pci_epc_bme_notify(struct pci_epc *epc)
 EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
 
 /**
+ * pci_epc_dstate_change() - Notify the EPF device that EPC device D-state
+ *			has changed
+ * @epc: the EPC device which has change in D-state
+ * @state: the changed D-state
+ *
+ * Invoke to Notify the EPF device that the EPC device has D-state has
+ * changed.
+ */
+void pci_epc_dstate_change(struct pci_epc *epc, pci_power_t state)
+{
+	struct pci_epf *epf;
+
+	if (!epc || IS_ERR(epc))
+		return;
+
+	mutex_lock(&epc->list_lock);
+	list_for_each_entry(epf, &epc->pci_epf, list) {
+		mutex_lock(&epf->lock);
+		if (epf->event_ops && epf->event_ops->dstate_change)
+			epf->event_ops->dstate_change(epf, state);
+		mutex_unlock(&epf->lock);
+	}
+	mutex_unlock(&epc->list_lock);
+}
+EXPORT_SYMBOL_GPL(pci_epc_dstate_change);
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
index 4b52807..1d3c2a2 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -79,6 +79,7 @@ struct pci_epc_event_ops {
 	int (*link_up)(struct pci_epf *epf);
 	int (*link_down)(struct pci_epf *epf);
 	int (*bme)(struct pci_epf *epf);
+	int (*dstate_change)(struct pci_epf *epf, pci_power_t state);
 };
 
 /**
-- 
2.7.4

