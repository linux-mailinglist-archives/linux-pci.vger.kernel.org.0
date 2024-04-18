Return-Path: <linux-pci+bounces-6421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D6E8A9951
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 14:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C7C2820BF
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 12:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB4A15E5C9;
	Thu, 18 Apr 2024 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SLJmQQ9k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C63D15FA76
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441556; cv=none; b=bqBnw3sT2gVv8hNlEXO67NXaj7+S6u3OkRy3ZIdxxCanZn0nF0VgdtBxfcpUYmqg7Xk+LAFHsKmjnaUK/J+raK2cP6ighSujbFv+CsBujVg7Od/JO+HPVOa5RMHMsAP/9a4VH+n7RyTDavoPXiW74gIeO/r1wtlBt+0yV2fAupY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441556; c=relaxed/simple;
	bh=3XOdrzhpqbFIrl3fnv6xFM9Mmt9aEoCz8aAhMOMHLBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JcITE0P/321lkIlstkOMoF6FJJxSJl03qT/PTeh8qYk2p+dw+Rh2WoIhAPo3bY6mRKZ5qCaHjdTIvkuiHMbHT+lmzuDfbDFG4N0r1EgLd3oOXOxFZEiSg3ru6/b2VHFTcpGOYf2Q5y5aGt27KUKb7n5E9IThVarzNh1LFVje1Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SLJmQQ9k; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso755409b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 04:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713441554; x=1714046354; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUj747/lLV8YIqOMfvvj868IbKe2/5Xi8ukezoQn7Iw=;
        b=SLJmQQ9kaDWcmlQHoaizVnf2xlszIh7CKdXLayzC8GeB+SFjxQ99RA04dHeVknb3k6
         eLqRJcnE6EPYu9/1MB1nS4woi4cV/tj4RWJX6Io7fsBxyAEfGekqak+IZYwKC2Wp3E1v
         NvbzQK5e0GaUm2AGavMbuTmcixRdF2bNNQW2OJngVQx1OX4Av2bkpTRc9MZNQBAdGO6n
         KE9QzLmaEp6FxaM6m3wg0igjHEBFpZWtLYzlGCNxbG8OHgLN/yPoOnJuOlU3yOB586RL
         Xl04mOyYrOxq0RL0ffI2IYZ3Xud5Jxt/wJraSmvGU+te87VotXSiePFVLJniH0sYPz5s
         aYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441554; x=1714046354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUj747/lLV8YIqOMfvvj868IbKe2/5Xi8ukezoQn7Iw=;
        b=jdKT/5oMZ8q80Bph+XUh8oq2h3K7KJF20jau8GkO9N5LtRrF0QpY4DYMA0ebWUX1qZ
         FLEtCfyMdwlf4p6w99h2VYdy3H2iBQCx9UGHVbg3iYhyK1UlH3FjACLNerdQmTQkPqsk
         cE0lvzUWHxrTtvMvWQigAIZKpjsBP1+FuSfmKUFiOnKplPzTQiQgU6x81l/pVhZxFtlU
         k8gHhyWM59gG0lYO5Sc0Yd5G+ZkbnoMT+GwvEEG2Ngdh6rS6XGQ5HBSNoW4ybFVp3CHI
         wK38YR8VsgBmxeXqIu0xorBsPjTssbYFHh+rpIcXQ6JCRP4IS98H5KgZh8ZChFkwgC15
         yTyQ==
X-Gm-Message-State: AOJu0YzUpXSMv70Cx8s+9OKl0usQDCya+fv+phqFvDZmiTPws2VQoVt+
	bxMM+0kqEmU17BZhGp2sUhxSF2lSATNjoB9m7XuCVykFuzuCsoRB5DzTV7OXXw==
X-Google-Smtp-Source: AGHT+IGgvQvQ5O23HG1oNEL7Sbh7Gv0/uwPJhe1jVq2YB8VbbYLYIQmmC9S7BIpBDItUrIKvVWy6zQ==
X-Received: by 2002:a05:6a21:168c:b0:1a7:55f2:c92c with SMTP id np12-20020a056a21168c00b001a755f2c92cmr3431029pzb.45.1713441554378;
        Thu, 18 Apr 2024 04:59:14 -0700 (PDT)
Received: from [127.0.1.1] ([120.56.197.253])
        by smtp.gmail.com with ESMTPSA id ei16-20020a056a0080d000b006ed06c4074bsm1305512pfb.85.2024.04.18.04.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:59:13 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 18 Apr 2024 17:28:34 +0530
Subject: [PATCH v3 6/9] PCI: endpoint: Introduce 'epc_deinit' event and
 notify the EPF drivers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-pci-epf-rework-v3-6-222a5d1ed2e5@linaro.org>
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
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=8783;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=3XOdrzhpqbFIrl3fnv6xFM9Mmt9aEoCz8aAhMOMHLBU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmIQrzu4CeZ1RDHfHg2in1J8ho8R9UHICcsWAjE
 ZD+HPq6gu+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZiEK8wAKCRBVnxHm/pHO
 9TM5B/4hs5was5D96gfqeRHIYFLtN1VUCWzwQ81lffy/mKgILM5pvEtmWNuLxeHaLmUYWr2JYHK
 nLXGBAZZmuCwfKTtdhzpqd+93LjX0Sc3YCsC4RcyQ0fdFWDm+dcuadPSx+2hSPnUpnfTIycrplV
 O3xsouHjedbCtjMkGmuDPEUzsMc8todMijna33qVw22lePc8FCISP/clwlL9KJFyug4x9R24EL1
 nbQa7B+FdNM97N7Xoga8ka6dX9wcwPER5J7hu4wn0Og2bBAsZ4UkjB53wc/kjsGLGL1NCk4K0um
 jPhCNbX1wFZr74OsfujFTZRrygKAGnHld2ZuDJmXuSbCdT6x
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

As like the 'epc_init' event, that is used to signal the EPF drivers about
the EPC initialization, let's introduce 'epc_deinit' event that is used to
signal EPC deinitialization.

The EPC deinitialization applies only when any sort of fundamental reset
is supported by the endpoint controller as per the PCIe spec.

Reference: PCIe Base spec v5.0, sections 4.2.4.9.1 and 6.6.1.

Currently, some EPC drivers like pcie-qcom-ep and pcie-tegra194 support
PERST# as the fundamental reset. So the 'deinit' event will be notified to
the EPF drivers when PERST# assert happens in the above mentioned EPC
drivers.

The EPF drivers, on receiving the event through the epc_deinit() callback
should reset the EPF state machine and also cleanup any configuration that
got affected by the fundamental reset like BAR, DMA etc...

This change also warrants skipping the cleanups in unbind() if already done
in epc_deinit().

Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c |  1 -
 drivers/pci/controller/dwc/pcie-qcom-ep.c       |  1 +
 drivers/pci/controller/dwc/pcie-tegra194.c      |  1 +
 drivers/pci/endpoint/functions/pci-epf-mhi.c    | 19 +++++++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-test.c   | 17 +++++++++++++++--
 drivers/pci/endpoint/pci-epc-core.c             | 25 +++++++++++++++++++++++++
 include/linux/pci-epc.h                         |  1 +
 include/linux/pci-epf.h                         |  2 ++
 8 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 47391d7d3a73..2063cf2049e5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -632,7 +632,6 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
 	dw_pcie_edma_remove(pci);
-	ep->epc->init_complete = false;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_cleanup);
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index f6e925d434f6..458145d1f796 100644
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
index 93f5433c5c55..4b28f8beedfe 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1715,6 +1715,7 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 	if (ret)
 		dev_err(pcie->dev, "Failed to go Detect state: %d\n", ret);
 
+	pci_epc_deinit_notify(pcie->pci.ep.epc);
 	dw_pcie_ep_cleanup(&pcie->pci.ep);
 
 	reset_control_assert(pcie->core_rst);
diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 205c02953f25..5832989e55e8 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -764,6 +764,24 @@ static int pci_epf_mhi_epc_init(struct pci_epf *epf)
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
@@ -898,6 +916,7 @@ static void pci_epf_mhi_unbind(struct pci_epf *epf)
 
 static const struct pci_epc_event_ops pci_epf_mhi_event_ops = {
 	.epc_init = pci_epf_mhi_epc_init,
+	.epc_deinit = pci_epf_mhi_epc_deinit,
 	.link_up = pci_epf_mhi_link_up,
 	.link_down = pci_epf_mhi_link_down,
 	.bus_master_enable = pci_epf_mhi_bus_master_enable,
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ab714108dfdb..c8d0c51ae329 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -790,6 +790,15 @@ static int pci_epf_test_epc_init(struct pci_epf *epf)
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
@@ -802,6 +811,7 @@ static int pci_epf_test_link_up(struct pci_epf *epf)
 
 static const struct pci_epc_event_ops pci_epf_test_event_ops = {
 	.epc_init = pci_epf_test_epc_init,
+	.epc_deinit = pci_epf_test_epc_deinit,
 	.link_up = pci_epf_test_link_up,
 };
 
@@ -907,10 +917,13 @@ static int pci_epf_test_bind(struct pci_epf *epf)
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
index 917dc56dfbbe..e4bad4ef8e22 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -774,6 +774,31 @@ void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf)
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
+		if (epf->event_ops && epf->event_ops->epc_deinit)
+			epf->event_ops->epc_deinit(epf);
+		mutex_unlock(&epf->lock);
+	}
+	epc->init_complete = false;
+	mutex_unlock(&epc->list_lock);
+}
+EXPORT_SYMBOL_GPL(pci_epc_deinit_notify);
+
 /**
  * pci_epc_bus_master_enable_notify() - Notify the EPF device that the EPC
  *					device has received the Bus Master
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 11115cd0fe5b..c39eed3ee73e 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -226,6 +226,7 @@ void pci_epc_linkup(struct pci_epc *epc);
 void pci_epc_linkdown(struct pci_epc *epc);
 void pci_epc_init_notify(struct pci_epc *epc);
 void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf);
+void pci_epc_deinit_notify(struct pci_epc *epc);
 void pci_epc_bus_master_enable_notify(struct pci_epc *epc);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 			enum pci_epc_interface_type type);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index dc759eb7157c..0639d4dc8986 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -71,12 +71,14 @@ struct pci_epf_ops {
 /**
  * struct pci_epc_event_ops - Callbacks for capturing the EPC events
  * @epc_init: Callback for the EPC initialization complete event
+ * @epc_deinit: Callback for the EPC deinitialization event
  * @link_up: Callback for the EPC link up event
  * @link_down: Callback for the EPC link down event
  * @bus_master_enable: Callback for the EPC Bus Master Enable event
  */
 struct pci_epc_event_ops {
 	int (*epc_init)(struct pci_epf *epf);
+	void (*epc_deinit)(struct pci_epf *epf);
 	int (*link_up)(struct pci_epf *epf);
 	int (*link_down)(struct pci_epf *epf);
 	int (*bus_master_enable)(struct pci_epf *epf);

-- 
2.25.1


