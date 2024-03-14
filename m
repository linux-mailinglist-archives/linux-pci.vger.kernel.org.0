Return-Path: <linux-pci+bounces-4828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B4A87C000
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 16:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACE71C223CD
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 15:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45477443D;
	Thu, 14 Mar 2024 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+RXbK/E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360EB74439
	for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429876; cv=none; b=bT0gLRyBOu0d2CGajWN18MK3tQQjoBz9Xj9xRCO3KAygLZlMWUhcU1SclEjvXrIMAONjAFHVwv5PwnfS4cIcxDTsddcas178VPBYGHsAlpVoY9B4lcE02/9/3NDbFS8KqXKvsubgOVnig6slGMa/hpzWP/KoC5BcdTfJtgWxx44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429876; c=relaxed/simple;
	bh=jPWxbt2riSZi/maNAnphcN1RYR8qq0h5e3Zov+Lvc4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DrgzjLbgKZyiS5uR7AsxnwtbCyrqFJt3oF6ka/GO1gLon89PYn8hnLkhPMqb6S9o8G11SIKFvMHu3i3zU3Yri6hvC489lnhmmh7z5g/Xy0bJfo+tI6NTS9UW7V29cTNg1nKWMhcVDyF1E7FcPMr59iHf9yFsU7Q478bRqI7q9ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j+RXbK/E; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e622b46f45so918784b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 08:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710429874; x=1711034674; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IB98vAalShqJmV5WrujsdZwwSuhli1Awn07UHR7DaIg=;
        b=j+RXbK/EXLjEiIUrjnIYhLVDu5CKIXzlas81nYptC+Puqi6FU38pLUBkYa8Nja0i/U
         9sKcVKdH96DS6CsD8LUf2WPhY9ncf1gbn/xwC4aQP7ZVZla4QzVMFjVkFF6Uhv4LjKK+
         EeVYWl0X6q86cDR8s8xUSZxp0YKwLi3u2hZ4RA3ohGt4V6aDzng+VtbNqcZGscHCckZW
         H5Mm/ADRUdl/07+OZoWkW1JaRWYl4mo17A3SdCvkuZko/voQ5MzGXPndeRpS4e9STv0z
         IihdcSSCS2wb2bwSEPq1kPXD2w+ZlzGFMDR00oGTFmSIgBnYrDIpCjKWkb8Oc/0XX/i8
         xL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710429874; x=1711034674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IB98vAalShqJmV5WrujsdZwwSuhli1Awn07UHR7DaIg=;
        b=r35u3dqMr+PifLm9CHMT4VF2Cl8wd44+hZjxnrSsMyc5FcaRd8+VGskj5qfjlZbKMF
         T7i8FGT4L/lyhHbHEap8n0vRMOURDlNdpRUNefxnAhBuBIuf2xIfbxajlXKZYn765OZx
         d3jNGVQBUGqNhdYep5DwKXSuGZzdxAMlSQoKso5ObAOGKRAfImpXrO7u9qDgtK6RLBpT
         cRS5+50x3nWkR3hk7qz9SVD2v4CrWsh7Um+UbKqjkudvC++lObgagGq9fayREJ56rWLI
         ccJTSyKyE+f/SxMcf5mkoRl7CpqP7u9U89oUwK0/uUJMN2Quyu7yUiqiJQaBKeIhu+IY
         qjNQ==
X-Gm-Message-State: AOJu0YybsYDEMT+P+abonCs7r/U4OKLlrSTd2BAa0F3aNFBrWg9gyms+
	TC1yVQqK0FNK+1Xj+KE57InvGphAf2sXB/BjBcOrB3+DyUEHT8v8xkzqRf+h6A==
X-Google-Smtp-Source: AGHT+IFLvyvRjqJy6MhH7It5vtHW587K1JS6nFI9paLdFKRoNb2Tbu2X7sMT/Eiq1P2IPfI7veImaw==
X-Received: by 2002:a05:6a00:1489:b0:6e4:cf7c:6c28 with SMTP id v9-20020a056a00148900b006e4cf7c6c28mr544980pfu.22.1710429873143;
        Thu, 14 Mar 2024 08:24:33 -0700 (PDT)
Received: from [127.0.1.1] ([117.207.30.211])
        by smtp.gmail.com with ESMTPSA id m4-20020a63ed44000000b005e438ea2a5asm824021pgk.53.2024.03.14.08.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 08:24:32 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 14 Mar 2024 20:53:45 +0530
Subject: [PATCH 06/11] PCI: endpoint: Introduce EPC 'deinit' event and
 notify the EPF drivers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-pci-epf-rework-v1-6-6134e6c1d491@linaro.org>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
In-Reply-To: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=7829;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=jPWxbt2riSZi/maNAnphcN1RYR8qq0h5e3Zov+Lvc4c=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl8xaP/ckGOJIy8V7WIDvqEwd3+feRz3R2gye47
 WRDQmlp476JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfMWjwAKCRBVnxHm/pHO
 9UKGB/9nju5m6oFvoV1OrjsN0LzD+q0w87oLvJPxvWMupLaxgAofU7VBZLLp1Hf5bFwQa+rUPss
 weEl454L4h+sFLOc+BR3WRYVY5dJ8g55CQoPzpLY4wsTb69U11jO7dscLhssC/D3EDy9o3o61w9
 3icSgiuy/ZiGwVsovTud36jvLnKe/moXnJvsvUokMP63553MNlDTkmSe5xdX4Yq7LbxwzFwJ606
 8YnnwoAU/heHoo9o4RAyyTtTb0sm0eGiun8wYS+dHlnnWGS6dYgFIEbUX7qaND8jj+QByHquz82
 USNDs12u9yaTA0fyqVXqRjOHSnBmmdSTCyEinPHVZ5qD8jIv
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

As like the EPC 'init' event, that is used to signal the EPF drivers about
the EPC initialization, let's introduce 'deinit' event that is used to
signal EPC deinitialization.

The EPC deinitialization applies only when any sort of fundamental reset
is supported by the endpoint controller as per the PCIe spec.

Reference: PCIe Base spec v5.0, sections 4.2.4.9.1 and 6.6.1.

Currently, some EPC drivers like pcie-qcom-ep and pcie-tegra194 support
PERST# as the fundamental reset. So the 'deinit' event will be notified to
the EPF drivers when PERST# assert happens in the above mentioned EPC
drivers.

The EPF drivers, on receiving the event through the deinit() callback
should reset the EPF state machine and also cleanup any configuration that
got affected by the fundamental reset like BAR, DMA etc...

This change also warrants skipping the cleanups in unbind() if already done
in deinit().

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  1 +
 drivers/pci/controller/dwc/pcie-tegra194.c    |  1 +
 drivers/pci/endpoint/functions/pci-epf-mhi.c  | 19 +++++++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-test.c | 17 +++++++++++++++--
 drivers/pci/endpoint/pci-epc-core.c           | 25 +++++++++++++++++++++++++
 include/linux/pci-epc.h                       |  1 +
 include/linux/pci-epf.h                       |  2 ++
 7 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 50b1635e3cbb..e4b742355d57 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -501,6 +501,7 @@ static void qcom_pcie_perst_assert(struct dw_pcie *pci)
 {
 	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
 
+	pci_epc_deinit_notify(pci->ep.epc);
 	dw_pcie_ep_cleanup(&pci->ep);
 	qcom_pcie_disable_resources(pcie_ep);
 	pcie_ep->link_status = QCOM_PCIE_EP_LINK_DISABLED;
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index e02deb31a72d..3e6e08b321fb 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1715,6 +1715,7 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 	if (ret)
 		dev_err(pcie->dev, "Failed to go Detect state: %d\n", ret);
 
+	pci_epc_deinit_notify(pcie->pci.ep.epc);
 	dw_pcie_ep_cleanup(&pcie->pci.ep);
 
 	reset_control_assert(pcie->core_rst);
diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 4e4300efd9d7..83de96119718 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -748,6 +748,24 @@ static int pci_epf_mhi_epc_init(struct pci_epf *epf)
 	return 0;
 }
 
+static void pci_epf_mhi_epc_deinit(struct pci_epf *epf)
+{
+	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
+	const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
+	struct pci_epf_bar *epf_bar = &epf->bar[info->bar_num];
+	struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
+	struct pci_epc *epc = epf->epc;
+
+	if (mhi_cntrl->mhi_dev) {
+		mhi_ep_power_down(mhi_cntrl);
+		if (info->flags & MHI_EPF_USE_DMA)
+			pci_epf_mhi_dma_deinit(epf_mhi);
+		mhi_ep_unregister_controller(mhi_cntrl);
+	}
+
+	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, epf_bar);
+}
+
 static int pci_epf_mhi_link_up(struct pci_epf *epf)
 {
 	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
@@ -882,6 +900,7 @@ static void pci_epf_mhi_unbind(struct pci_epf *epf)
 
 static const struct pci_epc_event_ops pci_epf_mhi_epc_event_ops = {
 	.init = pci_epf_mhi_epc_init,
+	.deinit = pci_epf_mhi_epc_deinit,
 };
 
 static const struct pci_epc_bus_event_ops pci_epf_mhi_bus_event_ops = {
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 8f1e0cb08814..84cd47ebac22 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -804,6 +804,15 @@ static int pci_epf_test_epc_init(struct pci_epf *epf)
 	return 0;
 }
 
+static void pci_epf_test_epc_deinit(struct pci_epf *epf)
+{
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+
+	cancel_delayed_work(&epf_test->cmd_handler);
+	pci_epf_test_clean_dma_chan(epf_test);
+	pci_epf_test_clear_bar(epf);
+}
+
 static int pci_epf_test_link_up(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
@@ -816,6 +825,7 @@ static int pci_epf_test_link_up(struct pci_epf *epf)
 
 static const struct pci_epc_event_ops pci_epf_test_epc_event_ops = {
 	.init = pci_epf_test_epc_init,
+	.deinit = pci_epf_test_epc_deinit,
 };
 
 static const struct pci_epc_bus_event_ops pci_epf_test_bus_event_ops = {
@@ -954,10 +964,13 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 static void pci_epf_test_unbind(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+	struct pci_epc *epc = epf->epc;
 
 	cancel_delayed_work(&epf_test->cmd_handler);
-	pci_epf_test_clean_dma_chan(epf_test);
-	pci_epf_test_clear_bar(epf);
+	if (epc->init_complete) {
+		pci_epf_test_clean_dma_chan(epf_test);
+		pci_epf_test_clear_bar(epf);
+	}
 	pci_epf_test_free_space(epf);
 }
 
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 5a522b2842e2..26378a9a56a7 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -779,6 +779,31 @@ void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf)
 }
 EXPORT_SYMBOL_GPL(pci_epc_notify_pending_init);
 
+/**
+ * pci_epc_deinit_notify() - Notify the EPF device about EPC deinitialization
+ * @epc: the EPC device whose deinitialization is completed
+ *
+ * Invoke to notify the EPF device that the EPC deinitialization is completed.
+ */
+void pci_epc_deinit_notify(struct pci_epc *epc)
+{
+	struct pci_epf *epf;
+
+	if (IS_ERR_OR_NULL(epc))
+		return;
+
+	mutex_lock(&epc->list_lock);
+	list_for_each_entry(epf, &epc->pci_epf, list) {
+		mutex_lock(&epf->lock);
+		if (epf->epc_event_ops && epf->epc_event_ops->deinit)
+			epf->epc_event_ops->deinit(epf);
+		mutex_unlock(&epf->lock);
+	}
+	epc->init_complete = false;
+	mutex_unlock(&epc->list_lock);
+}
+EXPORT_SYMBOL_GPL(pci_epc_deinit_notify);
+
 /**
  * pci_epc_bme_notify() - Notify the EPF device that the EPC device has received
  *			  the BME event from the Root complex
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index adee6dbe4e45..976b2212e872 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -199,6 +199,7 @@ void pci_epc_linkup(struct pci_epc *epc);
 void pci_epc_linkdown(struct pci_epc *epc);
 void pci_epc_init_notify(struct pci_epc *epc);
 void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf);
+void pci_epc_deinit_notify(struct pci_epc *epc);
 void pci_epc_bme_notify(struct pci_epc *epc);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 			enum pci_epc_interface_type type);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index ff8304e72f8e..52f69eaf505d 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -70,9 +70,11 @@ struct pci_epf_ops {
 /**
  * struct pci_epc_event_ops - Callbacks for capturing the EPC specific events
  * @init: Callback for the EPC initialization event
+ * @deinit: Callback for the EPC deinitialization event
  */
 struct pci_epc_event_ops {
 	int (*init)(struct pci_epf *epf);
+	void (*deinit)(struct pci_epf *epf);
 };
 
 /**

-- 
2.25.1


