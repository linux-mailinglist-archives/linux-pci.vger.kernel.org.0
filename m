Return-Path: <linux-pci+bounces-6830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC20E8B6A49
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 08:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16BBA1C21712
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 06:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E94A2D627;
	Tue, 30 Apr 2024 06:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZ7nYDBM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B951286AC
	for <linux-pci@vger.kernel.org>; Tue, 30 Apr 2024 06:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714457649; cv=none; b=Sb7RmoqWaEL4KDxk3rzW/sukX50PMG6EGKpDU91PIPbFU2ehrGo3mbBKfRwb/pkuM6fQsVuPMKFBhCHm3hSGwqL/YEBjjMi2H/KswYI31TaksmXoGicp35rs7txMZJLgWlxrs2zwBHzp1v+KK2ub1tOf0f9EFtSQ04MmDpizs4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714457649; c=relaxed/simple;
	bh=kFKAuGzedoWSuUSaNL/I7razvug19SNAED1l9TYAI0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KsN37833cNOUloIjouuQjA5l5gzLqMKHg6YKFTzouYIUwlrKGsLrw+Y4s48gaz56wdpMOPLFdrgBqjDuVfkCFd/rmXoS+bnPdjldi7MnqFg3ABT1CHmamufzxvzGKuKr+S2NMGslsP+IzH/yY2Ux7NerUMAdrdGs3Z++7OtkzhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sZ7nYDBM; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed01c63657so5145172b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 29 Apr 2024 23:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714457647; x=1715062447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0TGpJGvvi+AshzdcWlNzIS1Ij/mm3bKppdj/wqTA4M8=;
        b=sZ7nYDBM5AKgkX52W/rLhEbGS+2KYkYfGbpaRamK/hiXho8+zd5Z4FBL5hOggZ/spe
         aCBQPQOZvqgYqGpgmBcEIvn3/wF0g5bApy1b3zmU2BA3HDpCytFhMaE7NTpXprKv81g1
         zKIzRqJg2TgadMSJXndaCiBs1p00f5Iemxv/aDWCKY4jY/zkahCCGCCxtORiFCUqq6zN
         gTomkVb3Xu+UZpusQMti/BK+G4h1vpFkeqispjchkBK6egFupitsxcbZn3H4uuxlMJ9j
         FiNAq8ccWWYINeldpq9/fjgnz94PQaQCukiOJfNYHKSdhhJel6avUhyVWkGQ7QAoh7hB
         5ahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714457647; x=1715062447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TGpJGvvi+AshzdcWlNzIS1Ij/mm3bKppdj/wqTA4M8=;
        b=B2KPp3+qsbjfsUOscNc2VBdwviELvimGWx1SAWQUkjN4Ev4kSHGm1ChPPVTuVkyCil
         qVlhJSQKLqS2NHJlWcxPEeTEgwa1x37Po8vH34OHhj4htnQ89JbCT+RVJ7pSSZoMBHZp
         RK1OhSmoJPmOCiHGPfqEer0Aqr/EuVLK4c89zumc9+3dO32o1ec3jvRNhg7G/8xEZRWS
         EFHw5vZRn65A861Zf4R46sR1EiaLsSxi2pydxkMKNphK0DgGBSWc7HtfbpR0nF/2j6IY
         oK59UJ2p1hY+dzYeRmP9rGmU0jAUGBb8TRNJwzwIo8oqDcB+/dSeDTiH8LUHNBWnxZBl
         woEw==
X-Gm-Message-State: AOJu0Yx4S3Xl3GHpdpQzC55Osdda1mAXAw+tcfeVbTJZ+63a6WxhNOc0
	5kmWr3oAkSUHaqTnMc7El+01IgITcFhbaGeCipy7O5JREPzsnCnCzXpy1RiZnQ==
X-Google-Smtp-Source: AGHT+IHGmNNGRkph+6Tqa8EOLlVW0JJYoMCZeRvIsYVJEi2dNNN2B/TQmfVtkb35uSgkd3rPlAY2Cg==
X-Received: by 2002:a05:6a20:de96:b0:1a9:b2a6:1d23 with SMTP id la22-20020a056a20de9600b001a9b2a61d23mr8018968pzb.20.1714457646700;
        Mon, 29 Apr 2024 23:14:06 -0700 (PDT)
Received: from [127.0.1.1] ([220.158.156.15])
        by smtp.gmail.com with ESMTPSA id bi2-20020a170902bf0200b001e27ad5199csm21393298plb.281.2024.04.29.23.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 23:14:06 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Tue, 30 Apr 2024 11:43:44 +0530
Subject: [PATCH v4 03/10] PCI: endpoint: Rename BME to Bus Master Enable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-pci-epf-rework-v4-3-22832d0d456f@linaro.org>
References: <20240430-pci-epf-rework-v4-0-22832d0d456f@linaro.org>
In-Reply-To: <20240430-pci-epf-rework-v4-0-22832d0d456f@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, Niklas Cassel <cassel@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Damien Le Moal <dlemoal@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6423;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=kFKAuGzedoWSuUSaNL/I7razvug19SNAED1l9TYAI0w=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmMIwbwy1PT2PyUkp33jlet/EymivMRBO8s+WAQ
 88R1SwTs/SJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZjCMGwAKCRBVnxHm/pHO
 9Wp0B/4gZGTDfen6gIL85g20lnuW07Bpgr3aIaTGnVVIloGUHnYSMhmRfFEWbmYJo9W5aXfr2z+
 +g5Sm5oTAdWhJHxMXJMlUsr52r9X0ieOhcUj1NYTGEm9Cu68lSnHQWC76mNPAbWt8wfP/4Z+HDP
 /G5GZAwnMWvBSAnyOxEjBskj4ZmVdr/7nlVT5baZ3eLkKu+SCWNsSa90LERb3+iqFGJolGJOXtl
 phm6Um/kbePwDi6HRqho7aii51QhcV2vClJOJTWjgHWZyX7t3dozYltLmUVosXL/+4+VqotjE9J
 18s2Lb176YxZd2LF/bep0aeFackq99IhxSdZyqfEPM6XCaaF
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

BME which stands for 'Bus Master Enable' is not defined in the PCIe base
spec even though it is commonly referred in many places (vendor docs). But
to align with the spec, let's rename it to its expansion 'Bus Master
Enable'.

Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c    |  4 ++--
 drivers/pci/endpoint/functions/pci-epf-mhi.c |  8 ++++----
 drivers/pci/endpoint/pci-epc-core.c          | 19 ++++++++++---------
 include/linux/pci-epc.h                      |  2 +-
 include/linux/pci-epf.h                      |  4 ++--
 5 files changed, 19 insertions(+), 18 deletions(-)

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
index e6bffa37a948..56b60330355d 100644
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
- * Invoke to Notify the EPF device that the EPC device has received the Bus
- * Master Enable (BME) event from the Root complex
+ * Notify the EPF device that the EPC device has generated the Bus Master Enable
+ * event due to host setting the Bus Master Enable bit in the Command register.
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


