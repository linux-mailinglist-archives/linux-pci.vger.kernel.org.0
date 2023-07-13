Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2AA75196E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 09:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjGMHKi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 03:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbjGMHKf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 03:10:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A571FC0;
        Thu, 13 Jul 2023 00:10:33 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D6qXWB025696;
        Thu, 13 Jul 2023 07:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=1DTdMrzLKr0yyzqfvIKYaB8YU3KPbZ9q75yXg4kY8ig=;
 b=DUy+N28f/GSuY48PKYxZlTD9R4rVxGufHK9j/6S4vxIQXl2UuPyknMnRgqwDXVl4odoV
 bhNVfV2mFzd6mmbUbLk9EYit1wwEASXH2KBVhWTbqffI44VsLeixmMsSjJVDkGy9qaNu
 BdJxZBS5aEa6Cx9waLsVlMEYFb1ME4C9vEUWwMY7h102/K/yekQukldb08t0/Fd2TI7u
 MG1fFC6NZMnmpbJvEqcYu6g6wwr4/CeSdxvqvd0vOSHGgKyHuUoSQKQZiS6KbU1WEBka
 OrW1kHPnhLlk2hl44tBUAxSDqGwSwGKMUoxS/KgLoQMcBPCSakPvN3RXehOhBBj0Eb0R EA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsgarb9mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 07:10:26 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36D7AMiS030166;
        Thu, 13 Jul 2023 07:10:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rq0vkymh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 13 Jul 2023 07:10:22 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36D7AM63030152;
        Thu, 13 Jul 2023 07:10:22 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36D7ALR7030145;
        Thu, 13 Jul 2023 07:10:22 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 31CE947B2; Thu, 13 Jul 2023 12:40:21 +0530 (+0530)
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
Subject: [PATCH v4 1/9] PCI: endpoint: Add D-state change notifier support
Date:   Thu, 13 Jul 2023 12:40:10 +0530
Message-Id: <1689232218-28265-2-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
References: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uWhroULhYFjrNeXGOOnCwZAj6_Sr0tse
X-Proofpoint-ORIG-GUID: uWhroULhYFjrNeXGOOnCwZAj6_Sr0tse
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=855 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
index 4f5622a..3a54713 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -78,6 +78,11 @@ by the PCI controller driver.
    Cleanup the pci_epc_mem structure allocated during pci_epc_mem_init().
 
 
+* pci_epc_dstate_notity()
+
+   In order to notify all the function devices that the EPC device has
+   changed its D-state.
+
 EPC APIs for the PCI Endpoint Function Driver
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 6c54fa5..ea76baf 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -785,6 +785,33 @@ void pci_epc_bme_notify(struct pci_epc *epc)
 EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
 
 /**
+ * pci_epc_dstate_notity() - Notify the EPF device that EPC device D-state
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

