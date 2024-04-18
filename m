Return-Path: <linux-pci+bounces-6418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E10EF8A9944
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 13:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111F71C21B6D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 11:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B2515FD12;
	Thu, 18 Apr 2024 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XjVRgxkR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EE115FCF0
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441544; cv=none; b=WpgWnofOct1usJZ/cQP+lSpCHCCffWJ8wiibZkbM0N9dfcOfPETPHaOvVZHctVrDGixpPolhVURppZMp5K4vaFCrQKYclryVvXyW4tiOnflkgjxWZl/QMS4MSZfLjOJ+KdFoMaoLoXpx8zcALWfjghHguUxv66F73cYlgkGn1S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441544; c=relaxed/simple;
	bh=Lk/AnxlCrRiAz0ji3mWdS5KjfmS1Qvw7tgApf8ZLE60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FTVbPTHMEa7/k+cL79pAfaqVSltT4Txeq6Uht8WGt3dsvSHlq7u2NFMZyJvLoYpX8XckztdPVF/5ful8I+lj49Ff3HHO8AacDaqSHPy/feyEuHGqI+J0FWANVpxl+FA0a3EhS4SlmnNn+tMM4Ud/n/0yhH1hUffhiknza1azRBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XjVRgxkR; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f043f9e6d7so796730b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 04:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713441542; x=1714046342; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5IHRTEpOjY2sC7qQ4E8BfwjFPjyqQrSwvZaUxoSWxY=;
        b=XjVRgxkR7F4dg5timbzTJxaFVQaKq1NBA11W4vl0ywbUNz3R9S+R8bvVJ0lKR8FASe
         oPV2yLCJFjHWIaZ7VceE+bI8PTOxutxuNt9FS+py64g5qmDuIrCPgeVVeCkXdihXW9FC
         W7zlr5AaA6vnKLH47h1wlzTDMd9GsXugYcjE5eKVL2FskHGI0n3VEOmUrIMwVEne32oK
         hW8gomiIvIpfbMsitrUv48wz+m/aGMTTxRXTCyqSHqG2kfA4SNBrwOzbCIdWvviCvqXB
         PP27nutC3HdPGvccOnFAHkbv+YR9/yINyj4eKvbG9bcrX1Dt1YJuyOmyK20dOpxgjK3f
         1A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441542; x=1714046342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5IHRTEpOjY2sC7qQ4E8BfwjFPjyqQrSwvZaUxoSWxY=;
        b=KuE8Nq2DVdUOzxTAECDAc+e8P20ZAMP7rEMmKi0aE5yV+pjQFrIln/OtxT6w+sLGmm
         tq6K13uxHmUrR0rY/5L2nvOoaMblUEsOyma7odt9lg/2+bypucCchSESDyzVRXgTvlYu
         T4ysdLtwxeuO4nZln++3qU4FhLfSHJ74lUaDTYZHKO5HWHoK0DBAsctar3tz8gD7A8jb
         sWsSKI5yAWSmgMJcCCmY7gp0wHPAFBDaSD0TS29svkyRblRIRBI3biBE2vC+E5tOa7zm
         OkjtX7X5DEuJbQnPa/Mja2e2xFWcU3m+mdxRrxRtTxA8zB9eZIFbmx5+P8uRPEmuOl+T
         jOJg==
X-Gm-Message-State: AOJu0Ywf1LUvadJZ//NvKuVUDutBnQ+GzFk2aAxzUq40LF+0chbs3jaq
	ZoZ+7A4Mn7FqXPvCXPr292r+Rdx/9Es471cNxAT7XVvMTv+fcPm96rgFW34xEQ==
X-Google-Smtp-Source: AGHT+IF6mIvmk0eNgTS3ZgsZJeimz6ohh7mh47bzE0qfP48g6iwB/2tEMzUWXamhs4A1OEQpnNuuVg==
X-Received: by 2002:a05:6a00:3cc2:b0:6ea:ad5e:f4b3 with SMTP id ln2-20020a056a003cc200b006eaad5ef4b3mr3416162pfb.23.1713441541586;
        Thu, 18 Apr 2024 04:59:01 -0700 (PDT)
Received: from [127.0.1.1] ([120.56.197.253])
        by smtp.gmail.com with ESMTPSA id ei16-20020a056a0080d000b006ed06c4074bsm1305512pfb.85.2024.04.18.04.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:59:01 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 18 Apr 2024 17:28:31 +0530
Subject: [PATCH v3 3/9] PCI: endpoint: Rename BME to Bus Master Enable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-pci-epf-rework-v3-3-222a5d1ed2e5@linaro.org>
References: <20240418-pci-epf-rework-v3-0-222a5d1ed2e5@linaro.org>
In-Reply-To: <20240418-pci-epf-rework-v3-0-222a5d1ed2e5@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, Niklas Cassel <cassel@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Damien Le Moal <dlemoal@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6209;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=Lk/AnxlCrRiAz0ji3mWdS5KjfmS1Qvw7tgApf8ZLE60=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmIQrys/WiHIEG/f/zBYXtE35MciDqjyaF8f3jD
 g5VbyDchN6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZiEK8gAKCRBVnxHm/pHO
 9SoFB/0XznAMJViAzNjG6YdUDOLoW7x5w89D72xa7bMYqD4CvgH5fFlM8JH4vq7GQH+rbU3Sn4H
 X3YztX7WQkTXL+NE5ptlvQjDG19jZTr0DN3jaQEfAdxE0MhZCZ+EcqDrAiew+mBNVV9w33DJy0F
 mUNSTtGxFpHNZYGwfbe/yww5RtVEAxmuIM9TYcX+EBVvOqTVUXTKksbPD8P4Y7d5nQ6JeEEMUY6
 /vpm7APD824UqdqPaka7AJkV1oxMvXFE80fSA76bmJJWhQO0Btd21JF5Sz8HVIFUNPLQ02Bk9B+
 v6aUoQXXkepCoNOgd52FJKkwvcFHKyA4lAdKw7vbpGmayGwr
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

BME which stands for 'Bus Master Enable' is not defined in the PCIe base
spec even though it is commonly referred in many places (vendor docs). But
to align with the spec, let's rename it to its expansion 'Bus Master
Enable'.

Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c    |  4 ++--
 drivers/pci/endpoint/functions/pci-epf-mhi.c |  8 ++++----
 drivers/pci/endpoint/pci-epc-core.c          | 17 +++++++++--------
 include/linux/pci-epc.h                      |  2 +-
 include/linux/pci-epf.h                      |  4 ++--
 5 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 50b1635e3cbb..f6e925d434f6 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -636,10 +636,10 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_DOWN;
 		pci_epc_linkdown(pci->ep.epc);
 	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
-		dev_dbg(dev, "Received BME event. Link is enabled!\n");
+		dev_dbg(dev, "Received Bus Master Enable event. Link is enabled!\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
 		qcom_pcie_ep_icc_update(pcie_ep);
-		pci_epc_bme_notify(pci->ep.epc);
+		pci_epc_bus_master_enable_notify(pci->ep.epc);
 	} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
 		dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
 		val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 95c3206f609f..b662905e2532 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -819,7 +819,7 @@ static int pci_epf_mhi_link_down(struct pci_epf *epf)
 	return 0;
 }
 
-static int pci_epf_mhi_bme(struct pci_epf *epf)
+static int pci_epf_mhi_bus_master_enable(struct pci_epf *epf)
 {
 	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
 	const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
@@ -882,8 +882,8 @@ static void pci_epf_mhi_unbind(struct pci_epf *epf)
 
 	/*
 	 * Forcefully power down the MHI EP stack. Only way to bring the MHI EP
-	 * stack back to working state after successive bind is by getting BME
-	 * from host.
+	 * stack back to working state after successive bind is by getting Bus
+	 * Master Enable event from host.
 	 */
 	if (mhi_cntrl->mhi_dev) {
 		mhi_ep_power_down(mhi_cntrl);
@@ -900,7 +900,7 @@ static const struct pci_epc_event_ops pci_epf_mhi_event_ops = {
 	.epc_init = pci_epf_mhi_epc_init,
 	.link_up = pci_epf_mhi_link_up,
 	.link_down = pci_epf_mhi_link_down,
-	.bme = pci_epf_mhi_bme,
+	.bus_master_enable = pci_epf_mhi_bus_master_enable,
 };
 
 static int pci_epf_mhi_probe(struct pci_epf *epf,
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index e6bffa37a948..917dc56dfbbe 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -775,14 +775,15 @@ void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf)
 EXPORT_SYMBOL_GPL(pci_epc_notify_pending_init);
 
 /**
- * pci_epc_bme_notify() - Notify the EPF device that the EPC device has received
- *			  the BME event from the Root complex
- * @epc: the EPC device that received the BME event
+ * pci_epc_bus_master_enable_notify() - Notify the EPF device that the EPC
+ *					device has received the Bus Master
+ *					Enable event from the Root complex
+ * @epc: the EPC device that received the Bus Master Enable event
  *
  * Invoke to Notify the EPF device that the EPC device has received the Bus
- * Master Enable (BME) event from the Root complex
+ * Master Enable event from the Root complex
  */
-void pci_epc_bme_notify(struct pci_epc *epc)
+void pci_epc_bus_master_enable_notify(struct pci_epc *epc)
 {
 	struct pci_epf *epf;
 
@@ -792,13 +793,13 @@ void pci_epc_bme_notify(struct pci_epc *epc)
 	mutex_lock(&epc->list_lock);
 	list_for_each_entry(epf, &epc->pci_epf, list) {
 		mutex_lock(&epf->lock);
-		if (epf->event_ops && epf->event_ops->bme)
-			epf->event_ops->bme(epf);
+		if (epf->event_ops && epf->event_ops->bus_master_enable)
+			epf->event_ops->bus_master_enable(epf);
 		mutex_unlock(&epf->lock);
 	}
 	mutex_unlock(&epc->list_lock);
 }
-EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
+EXPORT_SYMBOL_GPL(pci_epc_bus_master_enable_notify);
 
 /**
  * pci_epc_destroy() - destroy the EPC device
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index acc5f96161fe..11115cd0fe5b 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -226,7 +226,7 @@ void pci_epc_linkup(struct pci_epc *epc);
 void pci_epc_linkdown(struct pci_epc *epc);
 void pci_epc_init_notify(struct pci_epc *epc);
 void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf);
-void pci_epc_bme_notify(struct pci_epc *epc);
+void pci_epc_bus_master_enable_notify(struct pci_epc *epc);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 			enum pci_epc_interface_type type);
 int pci_epc_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index afe3bfd88742..dc759eb7157c 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -73,13 +73,13 @@ struct pci_epf_ops {
  * @epc_init: Callback for the EPC initialization complete event
  * @link_up: Callback for the EPC link up event
  * @link_down: Callback for the EPC link down event
- * @bme: Callback for the EPC BME (Bus Master Enable) event
+ * @bus_master_enable: Callback for the EPC Bus Master Enable event
  */
 struct pci_epc_event_ops {
 	int (*epc_init)(struct pci_epf *epf);
 	int (*link_up)(struct pci_epf *epf);
 	int (*link_down)(struct pci_epf *epf);
-	int (*bme)(struct pci_epf *epf);
+	int (*bus_master_enable)(struct pci_epf *epf);
 };
 
 /**

-- 
2.25.1


