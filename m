Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6E675197B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 09:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbjGMHKt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 03:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbjGMHKk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 03:10:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096C51FC0;
        Thu, 13 Jul 2023 00:10:38 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D5QF2C011282;
        Thu, 13 Jul 2023 07:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=MiCrbQvU07WEeqPZ2HgxSUUeLEYFWznoyTZWxjfVLhQ=;
 b=DRru9uAaLpdd2q0yFGVrwYAv9DzhuiMxI6yhFdT40op4Yred8XOeRNN9aUIGLiSzh2Hx
 +kS6Jf9THtWPecjqTMUOL2E7MizvvSNvmn1JkWU2qseevPqQFIftNtiaTmVSo6SqLyJG
 Tf2xEjVlIeZePFupU7VLoWyOVz7H+BbS9ZBNpeWeSKfv/BwTTJPvMrcRRIgEeeTRLLxi
 s0mgYiND4dTadrWDV30w6TMgEcHDJVANgNNDgqcj+CN2S6+Dv4apZWQnAhP1761JoMFW
 rijtS/D4GJO/H/ouv36zdIKCtrF3S5Z/FFxtP6NDSZhlKIOPQhimdDUImRzfcj50rZdB /w== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsgarb9mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 07:10:30 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36D7ARW5030237;
        Thu, 13 Jul 2023 07:10:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rq0vkymj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 13 Jul 2023 07:10:27 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36D7AQw7030219;
        Thu, 13 Jul 2023 07:10:26 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36D7AQTY030208;
        Thu, 13 Jul 2023 07:10:26 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id CC3D647BB; Thu, 13 Jul 2023 12:40:25 +0530 (+0530)
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
Subject: [PATCH v4 5/9] PCI: endpoint: Add wakeup host API to EPC core
Date:   Thu, 13 Jul 2023 12:40:14 +0530
Message-Id: <1689232218-28265-6-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
References: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9VF1uqnsfauY6smXlnx6UX9gfVfYJK0a
X-Proofpoint-ORIG-GUID: 9VF1uqnsfauY6smXlnx6UX9gfVfYJK0a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=777 spamscore=0 priorityscore=1501 impostorscore=0
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

Endpoint cannot send any data/MSI when the D-state is in
D3cold or D3hot. Endpoint needs to wake up the host to
bring the D-state to D0.

Endpoint can toggle wake signal when the D-state is in D3cold and vaux is
not supplied or can send inband PME.

To support this add wakeup_host() callback to the EPC core.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 Documentation/PCI/endpoint/pci-endpoint.rst |  6 ++++++
 drivers/pci/endpoint/pci-epc-core.c         | 31 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h                     | 11 ++++++++++
 3 files changed, 48 insertions(+)

diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
index 3a54713..eb79b77 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -53,6 +53,7 @@ by the PCI controller driver.
 	 * raise_irq: ops to raise a legacy, MSI or MSI-X interrupt
 	 * start: ops to start the PCI link
 	 * stop: ops to stop the PCI link
+	 * wakeup_host: ops to wakeup host
 
    The PCI controller driver can then create a new EPC device by invoking
    devm_pci_epc_create()/pci_epc_create().
@@ -122,6 +123,11 @@ by the PCI endpoint function driver.
    The PCI endpoint function driver should use pci_epc_mem_free_addr() to
    free the memory space allocated using pci_epc_mem_alloc_addr().
 
+* pci_epc_wakeup_host()
+
+   The PCI endpoint function driver should use pci_epc_wakeup_host() to wakeup
+   host.
+
 Other EPC APIs
 ~~~~~~~~~~~~~~
 
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index ea76baf..b419eff 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -167,6 +167,37 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 EXPORT_SYMBOL_GPL(pci_epc_get_features);
 
 /**
+ * pci_epc_wakeup_host() - Wakeup the host
+ * @epc: the EPC device which has to wakeup the host
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
+ * @type: specify the type of wakeup: WAKEUP_FROM_D3COLD, WAKEUP_FROM_D3HOT
+ *
+ * Invoke to wakeup host
+ */
+bool pci_epc_wakeup_host(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			enum pci_epc_wakeup_host_type type)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
+		return false;
+
+	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+		return false;
+
+	if (!epc->ops->wakeup_host)
+		return true;
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->wakeup_host(epc, func_no, vfunc_no, type);
+	mutex_unlock(&epc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_wakeup_host);
+
+/**
  * pci_epc_stop() - stop the PCI link
  * @epc: the link of the EPC device that has to be stopped
  *
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 26a1108..d262179 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -26,6 +26,12 @@ enum pci_epc_irq_type {
 	PCI_EPC_IRQ_MSIX,
 };
 
+enum pci_epc_wakeup_host_type {
+	PCI_WAKEUP_UNKNOWN,
+	PCI_WAKEUP_SEND_PME,
+	PCI_WAKEUP_TOGGLE_WAKE,
+};
+
 static inline const char *
 pci_epc_interface_string(enum pci_epc_interface_type type)
 {
@@ -59,6 +65,7 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
  * @get_features: ops to get the features supported by the EPC
+ * @wakeup_host: ops to wakeup the host
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -88,6 +95,8 @@ struct pci_epc_ops {
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
 						       u8 func_no, u8 vfunc_no);
+	bool	(*wakeup_host)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				enum pci_epc_wakeup_host_type type);
 	struct module *owner;
 };
 
@@ -234,6 +243,8 @@ int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no, u8 vfunc_no);
+bool pci_epc_wakeup_host(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+					enum pci_epc_wakeup_host_type type);
 enum pci_barno
 pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
-- 
2.7.4

