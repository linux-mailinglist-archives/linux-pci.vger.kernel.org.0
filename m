Return-Path: <linux-pci+bounces-10065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C699492D062
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 13:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2A4288FFC
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 11:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FFC18FC91;
	Wed, 10 Jul 2024 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SO8GQqYs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADA739FD9;
	Wed, 10 Jul 2024 11:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720610193; cv=none; b=YlwjSmEr0kKbN7UnYZVlrLsseLlBBG6DxSNwklLnyExl1KcxF8lVwn7RZ5+NYC6Uf+bSxMVreNZVXcATmHlKmaMvEOwwSYhHw6gGDwvpWyXlWWtlEh3f4wieaIfLZf0fjSy0X/Syjdekvs5QE+jXNSQc2UT6I63pPJwz6AHaDbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720610193; c=relaxed/simple;
	bh=nMuDL98JBcUiRI4vBE6ZFVmAcfaUd9g3f0c2REZ0zno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FlAUCu+/O4hvm19WPU8ph4pN0SAbwE/tyTY8cTy9/XMi8W/SAh9gCXUR+6SL7nj7VS2zvAQtGvo9/z590cNZWrss6Ed32kPg9CsD3KOGFbP5MYt7vMAUmNNPxTSFG2hLnM5b/d+BBXZEfI9cDPeoGhb9fKwoKF83K0bfV9rcVMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SO8GQqYs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AAfdC9021511;
	Wed, 10 Jul 2024 11:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	78yLytuRkDqz2e4iAL/1Ax4he7ZBigYYN7RdrDCB7l0=; b=SO8GQqYsJ/+3gN7H
	Jyt4gFY3tOaro68YOIAOXJHJM/BX9pkZhIuG7o/Ho+RPoZa5pVgF6tHk/+9dwHeF
	0EQ+4plRaKNlgDcalFeXrn5ZS8YNVPU9Spo6grP8PkDnjj9jC1oE8AZHbC9dDZ4v
	5wSQ0czRkbUhzp8Er+Jh286K+KoYnfQSBnW5/rJcDU6xrIxUH0VEzTGreHx/teOp
	kpOPLCVvqrlnV7FBYJCEfaKyXcd/2XWQtVKp+3SrMo9IMFfZhbpS0DAoy2IQ6zfV
	EcVYTGZtFC4quQsoUSl1eJwrE2+Z+OK/2LtyvyvGGa+oC6bNDdkkvxdFlkjNmn3i
	/2BKXw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wmmsa20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:16:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46ABGMHM004174
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:16:22 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 10 Jul 2024 04:16:16 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Wed, 10 Jul 2024 16:46:08 +0530
Subject: [PATCH v6 1/5] PCI: endpoint: Add wakeup host API to EPC core
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240710-wakeup_host-v6-1-ef00f31ea38d@quicinc.com>
References: <20240710-wakeup_host-v6-0-ef00f31ea38d@quicinc.com>
In-Reply-To: <20240710-wakeup_host-v6-0-ef00f31ea38d@quicinc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I
	<kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet
	<corbet@lwn.net>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>,
        "Krishna chaitanya
 chundru" <quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720610170; l=4245;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=nMuDL98JBcUiRI4vBE6ZFVmAcfaUd9g3f0c2REZ0zno=;
 b=QEkqWNaeU6wF46/pPR+HVMuQ/Md18ZzmWDFKu0DzUMpZvkRuG4pi0m7nDGYJ/od5GiBnoPV2M
 NTzl5JYp971CScR7r1g+vtAl6a8S3eg6xC/brijvqBNMpUxts84EOHx
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oM_zUArrmhOs4Q3t3aAxHGm2h9W2jcKI
X-Proofpoint-ORIG-GUID: oM_zUArrmhOs4Q3t3aAxHGm2h9W2jcKI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=976
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100077

Endpoint cannot send any data/MSI when the D-state is in
D3cold or D3hot. Endpoint needs to wake up the host to
bring the D-state to D0.

Endpoint can toggle wake signal when the D-state is in D3cold and vaux is
not supplied or can send inband PME.

To support this add wakeup_host() callback to the EPC core.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 Documentation/PCI/endpoint/pci-endpoint.rst |  6 ++++++
 drivers/pci/endpoint/pci-epc-core.c         | 30 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h                     |  5 +++++
 3 files changed, 41 insertions(+)

diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
index 3eb5648ca7ec..3744bc692b4b 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -53,6 +53,7 @@ by the PCI controller driver.
 	 * raise_irq: ops to raise a legacy, MSI or MSI-X interrupt
 	 * start: ops to start the PCI link
 	 * stop: ops to stop the PCI link
+	 * wakeup_host: ops to wakeup host
 
    The PCI controller driver can then create a new EPC device by invoking
    devm_pci_epc_create()/pci_epc_create().
@@ -120,6 +121,11 @@ by the PCI endpoint function driver.
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
index e2b9c458f2c4..7edc75de2ff3 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -162,6 +162,36 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_features);
 
+/**
+ * pci_epc_wakeup_host() - Wakeup the host
+ * @epc: the EPC device which has to wakeup the host
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
+ * @send_pme: true if wakeup is by sending PME
+ *
+ * Invoke to wakeup host
+ */
+bool pci_epc_wakeup_host(struct pci_epc *epc, u8 func_no, u8 vfunc_no, bool send_pme)
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
+	ret = epc->ops->wakeup_host(epc, func_no, vfunc_no, send_pme);
+	mutex_unlock(&epc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_wakeup_host);
+
 /**
  * pci_epc_stop() - stop the PCI link
  * @epc: the link of the EPC device that has to be stopped
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index e473d1780928..fffde507da47 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -52,6 +52,7 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
  * @get_features: ops to get the features supported by the EPC
+ * @wakeup_host: ops to wakeup the host
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -81,6 +82,8 @@ struct pci_epc_ops {
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
 						       u8 func_no, u8 vfunc_no);
+	bool	(*wakeup_host)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			       bool send_pme);
 	struct module *owner;
 };
 
@@ -258,6 +261,8 @@ int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no, u8 vfunc_no);
+bool pci_epc_wakeup_host(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			 bool send_pme);
 enum pci_barno
 pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features

-- 
2.42.0


