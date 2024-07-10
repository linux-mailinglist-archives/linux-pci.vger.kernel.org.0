Return-Path: <linux-pci+bounces-10061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E52C292D059
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 13:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 466E4B2651B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 11:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7BD18FC8D;
	Wed, 10 Jul 2024 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nUeeJrZF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5C718FA34;
	Wed, 10 Jul 2024 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720609727; cv=none; b=YFntxnOAs8nH574n6UJPYYXXvAmG4i8JQBiRejll5cPTweipVgUDo2JeN46oGMAVksc8SCTLMnYYwTHvEVt+B5S8FUotauUup9H2zWEttvsPSqWgm63o6z9T4B2MYH3m5KE8paijxZXhjjd9Y4H7iRlOLVTjKZDnxV3L8xx0vzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720609727; c=relaxed/simple;
	bh=SvjP1T+EEQd7I8bwYjYD3cq6rvIqSMYXru+9AZEaQiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rAssmk4ZHh/fyUejJ0mIae22f4hjP9NuKnFvefOb8SsgXfUBWUyLQB/H92NSAIJXHAelQ3x/niG0Xhw90b7fvWOzamH7mQzGwH4YbRAnqri2b+BCBotnJIqk2pd382XnnE0hv9Gm8UGS24+nYzPF8N82DiT0vYZn6MydQdhwkUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nUeeJrZF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A9hHp9029428;
	Wed, 10 Jul 2024 11:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zciwMdZ6NZHjy0VGYyE8FFd257osghz8T+oYjLhMYec=; b=nUeeJrZFYkKlyPTB
	GIE3Do5vbdEimiJs3m96zLQmt2N3G6H1PwCxdJSZO0ETALeBAKvYY3twHtWYnEZw
	lDocXv9SKbM7H+PXYKfwPQHN/GTpUey58YUBaUpnhjljpE3sevDmkEUqIoEmZ4Do
	Osk+P7twIu0lQ95c11++8ccPTs8rqZpxhhuzLnV5xEwYfwKwmfZYEzpQqg0dc1NZ
	EmVZihRsdPilB4yNkXQQOcJrOI0SYgyHRjarpRVRm45lkvaScCLGdaDVeFtY/ser
	iv6tmzR4gxLFMmkz4kl6nu8C7GwLL0cla+AJZgQ+wtNVTJ1MSGcK/5QZ2kNqD6J1
	B0Fy5g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406xa691wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:08:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46AB8TZg004636
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:08:29 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 10 Jul 2024 04:08:24 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Wed, 10 Jul 2024 16:38:14 +0530
Subject: [PATCH v7 1/4] PCI: endpoint: Add D-state change notifier support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240710-dstate_notifier-v7-1-8d45d87b2b24@quicinc.com>
References: <20240710-dstate_notifier-v7-0-8d45d87b2b24@quicinc.com>
In-Reply-To: <20240710-dstate_notifier-v7-0-8d45d87b2b24@quicinc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I
	<kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet
	<corbet@lwn.net>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring
	<robh@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>,
        "Krishna chaitanya
 chundru" <quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720609699; l=3524;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=SvjP1T+EEQd7I8bwYjYD3cq6rvIqSMYXru+9AZEaQiU=;
 b=WMao6p06eazJVryGf6h1KPbZ9mqkl+5VGfhnRG9m8Mn7ADBuqpkxI/OL3u27fFNcMLvImhrEl
 h6usjDmFWSlAObz1RJlAQp1soSZf0zAQTICdXcCX7njca4PmsM+9MZ3
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZLwqFKSr_e5CpOv0rXHaFA78kS3T_DSp
X-Proofpoint-ORIG-GUID: ZLwqFKSr_e5CpOv0rXHaFA78kS3T_DSp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=810
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100076

Add support to notify the EPF device about the D-state change event
from the EPC device.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 Documentation/PCI/endpoint/pci-endpoint.rst |  3 +++
 drivers/pci/endpoint/pci-epc-core.c         | 24 ++++++++++++++++++++++++
 include/linux/pci-epc.h                     |  2 ++
 include/linux/pci-epf.h                     |  2 ++
 4 files changed, 31 insertions(+)

diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
index 21507e3cc238..3eb5648ca7ec 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -77,6 +77,9 @@ by the PCI controller driver.
 
    Cleanup the pci_epc_mem structure allocated during pci_epc_mem_init().
 
+* pci_epc_dstate_notify()
+
+   Notify all the function drivers that the EPC device has changed its D-state.
 
 EPC APIs for the PCI Endpoint Function Driver
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 84309dfe0c68..e2b9c458f2c4 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -828,6 +828,30 @@ void pci_epc_bus_master_enable_notify(struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(pci_epc_bus_master_enable_notify);
 
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
index 85bdf2adb760..e473d1780928 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -276,6 +276,8 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
 void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
 			   void __iomem *virt_addr, size_t size);
 
+void pci_epc_dstate_notify(struct pci_epc *epc, pci_power_t state);
+
 #else
 static inline void pci_epc_init_notify(struct pci_epc *epc)
 {
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 18a3aeb62ae4..d88063cdb067 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -75,6 +75,7 @@ struct pci_epf_ops {
  * @link_up: Callback for the EPC link up event
  * @link_down: Callback for the EPC link down event
  * @bus_master_enable: Callback for the EPC Bus Master Enable event
+ * @dstate_notify: Callback for the EPC D-state change event
  */
 struct pci_epc_event_ops {
 	int (*epc_init)(struct pci_epf *epf);
@@ -82,6 +83,7 @@ struct pci_epc_event_ops {
 	int (*link_up)(struct pci_epf *epf);
 	int (*link_down)(struct pci_epf *epf);
 	int (*bus_master_enable)(struct pci_epf *epf);
+	int (*dstate_notify)(struct pci_epf *epf, pci_power_t state);
 };
 
 /**

-- 
2.42.0


