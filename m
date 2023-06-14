Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489117302A6
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jun 2023 17:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245676AbjFNPCI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jun 2023 11:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245711AbjFNPBu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jun 2023 11:01:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E861FFF;
        Wed, 14 Jun 2023 08:01:31 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E9PGLW021425;
        Wed, 14 Jun 2023 15:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=EAvtlgBPpOyXVzlhYjUJb94hSE+ID641KmueiBxv2Vc=;
 b=KZ7nuuNiMBW6ylNgosVMFCRPs8RLJc52tnnBhTzFKsBsrahDfUkYZxjU2wWTXiLf+Kqj
 D9QaUCv71/gw+nfZJ4qsguSrJNDerHx/OYvxqfgxT0am43k3xhksR9UXQ6Zfq9yjrltd
 o5v4SnPjS6Fo7EUcUjP4jGtW5Rne/ecNs0O07t6vNpgJzmlG5CYlC8ttj6bLa/kCecXS
 3ideWukyusyR+tRKwQvKmtOBbnbx6a9jzRzQF6T9ApiHFUUWXEAi11X0i92KahruTPz7
 Gg2aZZ1/r9o3jqwRUwAeqQ3+s4Y16yoTwCl+g+9Ru89MpBZd/KMnL/WyUVqAohXU06kj Qg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7auy0vd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 15:01:20 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35EF0uj4018430;
        Wed, 14 Jun 2023 15:01:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3r7271jay5-1;
        Wed, 14 Jun 2023 15:01:07 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35EF17Ib018597;
        Wed, 14 Jun 2023 15:01:07 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 35EF17QS018590;
        Wed, 14 Jun 2023 15:01:07 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id DDAD845A1; Wed, 14 Jun 2023 20:31:06 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org (open list:PCI ENDPOINT SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC v1 1/3] PCI: endpoint: Add wakeup host API to EPC core
Date:   Wed, 14 Jun 2023 20:30:47 +0530
Message-Id: <1686754850-29817-2-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1686754850-29817-1-git-send-email-quic_krichai@quicinc.com>
References: <1686754850-29817-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BF0FECC41ivyOQxrc5i0x8T3TjiisACg
X-Proofpoint-GUID: BF0FECC41ivyOQxrc5i0x8T3TjiisACg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_10,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 mlxlogscore=654 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306140131
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Endpoint cannot send any data/MSI when the device state is in
D3cold or D3hot. Endpoint needs to bring the device back to D0
to send any kind of data.

For this endpoint can send inband PME the device is in D3hot or
toggle wake when the device is D3 cold.

To support this adding wake up host to epc core.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 29 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 46c9a5c..d203947 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -167,6 +167,35 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 EXPORT_SYMBOL_GPL(pci_epc_get_features);
 
 /**
+ * pci_epc_wakeup_host() - interrupt the host system
+ * @epc: the EPC device which has to interrupt the host
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
+ *
+ * Invoke to wakeup host
+ */
+int pci_epc_wakeup_host(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
+		return -EINVAL;
+
+	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+		return -EINVAL;
+
+	if (!epc->ops->wakeup_host)
+		return 0;
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->wakeup_host(epc, func_no, vfunc_no);
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
index 301bb0e..a8496be 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -59,6 +59,7 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
  * @get_features: ops to get the features supported by the EPC
+ * @wakeup_host: ops to wakeup the host
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -88,6 +89,7 @@ struct pci_epc_ops {
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
 						       u8 func_no, u8 vfunc_no);
+	int	(*wakeup_host)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
 	struct module *owner;
 };
 
@@ -232,6 +234,7 @@ int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no, u8 vfunc_no);
+int pci_epc_wakeup_host(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
 enum pci_barno
 pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
-- 
2.7.4

