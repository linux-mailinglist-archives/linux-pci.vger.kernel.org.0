Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E167982C1
	for <lists+linux-pci@lfdr.de>; Fri,  8 Sep 2023 08:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242274AbjIHGyQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 02:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241965AbjIHGyP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 02:54:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8BE19B4;
        Thu,  7 Sep 2023 23:54:11 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3885tpS1010247;
        Fri, 8 Sep 2023 06:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=2922vILVa8UJXhvum/nKfQlEzI1uMBYh7Kut3LGMBrs=;
 b=awLv6CKbemw3yR1i7+m4DBwr1zRKAxC5M/v57phNhAoH5OO3n9X8SzisGM2kV3/igl2h
 Uj19ViKEd2F5FKWQcwH9ybtn3XWUhueaOSIVdmICzt3AZJlYRqrUBaDKMRbRUIkhK/PS
 bk2z3PnO6pnozwnmI4wysOHX2pRoiWaUMghxycEv9TWKEpel5ETWNfEOInIzzEjcIn21
 qiW9wnWOCARjZYArzFZD1wTlDR33NoQpg6atouEoeymqMprL0mEwlmKeix8CyIh9KROh
 TUBut4kB70c3eWGKldUA4YljUfAWCSH4aFVD1QjjLpqVqpgMfaAb2JLcaKtCHakqas+8 7w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3syk9ns8cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 06:54:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3886s00N025755
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 06:54:00 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 7 Sep 2023 23:53:56 -0700
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date:   Fri, 8 Sep 2023 12:23:35 +0530
Subject: [PATCH v6 1/4] PCI: endpoint: Add D-state change notifier support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230908-dstate_change-v6-1-b414a6edd765@quicinc.com>
References: <20230908-dstate_change-v6-0-b414a6edd765@quicinc.com>
In-Reply-To: <20230908-dstate_change-v6-0-b414a6edd765@quicinc.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694156032; l=3437;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=jbgDRmZQrRxWP8VxR+Ppt4oqP/vV7+WYZt1SMSTQ3/o=;
 b=/Qn7oG4alWE3ShI9UBDarOrMB4EsvgRBxFakJpi/nhn9gGwVHkUFHsH6mmruHgPv6m4EtBhFY
 KX7Y6T/OtrSAPP+nFxAv4liF6exDTmqLLRv0OsCGyNjbnFZuSBTqmDU
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zMAcOPpOuFOxXjxwDOEJYehbWSsl6WyF
X-Proofpoint-GUID: zMAcOPpOuFOxXjxwDOEJYehbWSsl6WyF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=797 mlxscore=0 priorityscore=1501 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/pci/endpoint/pci-epc-core.c         | 24 ++++++++++++++++++++++++
 include/linux/pci-epc.h                     |  1 +
 include/linux/pci-epf.h                     |  2 ++
 4 files changed, 31 insertions(+)

diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
index 4f5622a65555..a1d610f612b4 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -78,6 +78,10 @@ by the PCI controller driver.
    Cleanup the pci_epc_mem structure allocated during pci_epc_mem_init().
 
 
+* pci_epc_dstate_notify()
+
+   Notify all the function drivers that the EPC device has changed its D-state.
+
 EPC APIs for the PCI Endpoint Function Driver
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 5a4a8b0be626..4d589a5c96f0 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -783,6 +783,30 @@ void pci_epc_bme_notify(struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
 
+/**
+ * pci_epc_dstate_notify() - Notify the EPF driver that EPC device D-state
+ *			has changed
+ * @epc: the EPC device which has change in D-state
+ * @state: the changed D-state
+ *
+ * Invoke to Notify the EPF device that the EPC device D-state has
+ * changed.
+ */
+void pci_epc_dstate_notify(struct pci_epc *epc, pci_power_t state)
+{
+	struct pci_epf *epf;
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
+EXPORT_SYMBOL_GPL(pci_epc_dstate_notify);
+
 /**
  * pci_epc_destroy() - destroy the EPC device
  * @epc: the EPC device that has to be destroyed
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 5cb694031072..225a5a88627f 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -251,4 +251,5 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
 				     phys_addr_t *phys_addr, size_t size);
 void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
 			   void __iomem *virt_addr, size_t size);
+void pci_epc_dstate_notify(struct pci_epc *epc, pci_power_t state);
 #endif /* __LINUX_PCI_EPC_H */
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 3f44b6aec477..b2178bb0e976 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -73,12 +73,14 @@ struct pci_epf_ops {
  * @link_up: Callback for the EPC link up event
  * @link_down: Callback for the EPC link down event
  * @bme: Callback for the EPC BME (Bus Master Enable) event
+ * @dstate_notify: Callback for the EPC D-state change event
  */
 struct pci_epc_event_ops {
 	int (*core_init)(struct pci_epf *epf);
 	int (*link_up)(struct pci_epf *epf);
 	int (*link_down)(struct pci_epf *epf);
 	int (*bme)(struct pci_epf *epf);
+	int (*dstate_notify)(struct pci_epf *epf, pci_power_t state);
 };
 
 /**

-- 
2.42.0

