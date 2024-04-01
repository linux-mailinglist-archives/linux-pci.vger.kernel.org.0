Return-Path: <linux-pci+bounces-5486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABCB893D43
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 17:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E1E1F22E22
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 15:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A351D47A79;
	Mon,  1 Apr 2024 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kX7hjEoQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA6A4C60C
	for <linux-pci@vger.kernel.org>; Mon,  1 Apr 2024 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711986661; cv=none; b=ds1p6yJQfA6DLX5OnpWY0hZIaTu54nNsJ/SEsjtyJkCw6PwU9mCNnYi/khfS42D8IbliFcKtG1V9whhd2TwMBZ1DiiP+Ss2NCovN8dkOxHNRVydabAoPCudnASs3K9qhB7kLXRC8oEjeGjy/hRgttbpwYu4rF/GtKPRS8qrCpcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711986661; c=relaxed/simple;
	bh=T47iahFUoRy9WSY2Hwm0XSaPXE5SwHD86GbiyJRd2bQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L8Ro0AuHEL9+LwW7icH2gTpL7llPr2I2Jel6xto6oSEZeYV+mujQufkwsUZ2aeCeSxAeENZDRXjEva5d2zbz67dyyn10WhmlmbBlUTOsFiOs2riahHFS6Iip7sdjCI80V26vYKxru7C9AtPOUzIV9W4+w9+syi+/orZClvzBH4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kX7hjEoQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0025ef1efso27032235ad.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Apr 2024 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711986659; x=1712591459; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2wF173SVxh2xeHq87iflSPqXn8rpRDgO+18Xip4rLw=;
        b=kX7hjEoQs/Ac6RrGq3EcJsE4dzmMBqeA4FJ5wC3Ggm9eMJE+9lcpFwEI68OqSrBxIF
         82FGXonCIeudz0ej0noi/e2/QwaCSqIWWY4YoKKfMWXj5DQKkmpDc5tU/ZQjUjb+dzw9
         8b9GhWAbg6oxFGppfWTE/U8lhG1wLD0+jlMk+7INmTeY5yEtvgvF492JU9qYOMyY9jkb
         9TYeA+W9wfHSuW7XKgjSIhb8Vz6A5gl+oi8sOsKH3kePFw2G09t9TQgNvHjmufK0jHt9
         PrEzUgQFe8dkf+rBeQnwc7tsehMVknFIDiYovhQnuhcRZkpHSVWVzfXa6Qi9VKuny+n/
         aRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711986659; x=1712591459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2wF173SVxh2xeHq87iflSPqXn8rpRDgO+18Xip4rLw=;
        b=jgfADtWYt2a3E73ruQLNkvr8lpOEUS9FuUElveZof+kUFWo+xV6HQCDhBUMrYLIeGX
         FLg2+R7Y0eRW3Sq3G5GUHSCtKjjY/zXiothsLEIyz/JdND5Q8/WdZ4U/p0D+0hBX6GZC
         9wnxE9XVv0z9OzVd/1pBaQN56hm/2PjvJcLTSesnaU9bTf2iwE5DIOUg008aXc8s3Se7
         eu+ullaiOc27frvykR+lwRPMjj92lyAdK29TvjzQIWug6uZWsMNThdQeLcuTylERTPKX
         9BPKxto3TGGujIBXgFhwMPgJKCxY3tpnmK4GAH1SccHLVcPcKvTyc0D8f5P+/3nsO9zE
         BVAw==
X-Gm-Message-State: AOJu0Yw1888EAjrL+Et8k/Ks2Vb6s7yF4zqW+KPDFepO+CF3MPox31Oa
	33RjfLtA4hFqcpVl4BS7utJftE48GAJH9oFHKIJNLgDdOG1vf+3UHbNQw+ys0Q==
X-Google-Smtp-Source: AGHT+IGe3Xpxd8DyyMIWGzrdn4S8p18uJ2wpzDWFcXPzoRl2pIiCd0s3lDMPLPiVEVjLaR+cpssldg==
X-Received: by 2002:a17:902:e747:b0:1e0:b873:ce48 with SMTP id p7-20020a170902e74700b001e0b873ce48mr11264292plf.27.1711986658909;
        Mon, 01 Apr 2024 08:50:58 -0700 (PDT)
Received: from [127.0.1.1] ([103.28.246.102])
        by smtp.gmail.com with ESMTPSA id kh6-20020a170903064600b001e21957fecdsm8949076plb.246.2024.04.01.08.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 08:50:58 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 01 Apr 2024 21:20:28 +0530
Subject: [PATCH v2 02/10] PCI: endpoint: Decouple EPC and PCIe bus specific
 events
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-pci-epf-rework-v2-2-970dbe90b99d@linaro.org>
References: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
In-Reply-To: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7165;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=T47iahFUoRy9WSY2Hwm0XSaPXE5SwHD86GbiyJRd2bQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmCtfTMf58IyY8zgD6wdaznuAb6v/sZ92IlHyqM
 VGTeNIHPpmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZgrX0wAKCRBVnxHm/pHO
 9WgSB/9AB+f1sHZEjI2tcB04bja5K8hMJe8OoURVSPqFOkxr9vaso+dmlETicECAXIlmwwNCPWI
 gZFTr8HVhes5gLiegjPF1apwKUiAbTQ1hOnvkRTsoSs268Z6FUTXjvVjCXu5uwfQymZbYGR60qp
 XT8gRx8Ci5ajHDyorlVEB/o5pAgi3sjgCVONXC0rCf6CRl6hzLBCT61V5c4gk7un4b7TVt6erI8
 MFjKMGbaQxLWBLtENmxgTUBHqEFP0EMhOQb/ckzhhB/dpfNUZhc0eB435pKlTF9ThgmT3KpxoNG
 26QDJY9iT9t4Y6EadhDpGGbcyCFD34HyUj3megv+0zutBbNO
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Currently, 'struct pci_epc_event_ops' has a bunch of events that are sent
from the EPC driver to EPF driver. But those events are a mix of EPC
specific events like core_init and PCIe bus specific events like LINK_UP,
LINK_DOWN, BME etc...

Let's decouple them to respective structs (pci_epc_event_ops,
pci_epc_bus_event_ops) to make the separation clear.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c  |  8 ++++++--
 drivers/pci/endpoint/functions/pci-epf-test.c |  8 ++++++--
 drivers/pci/endpoint/pci-epc-core.c           | 20 ++++++++++----------
 include/linux/pci-epf.h                       | 23 ++++++++++++++++-------
 4 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 2c54d80107cf..280863c0eeb9 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -896,8 +896,11 @@ static void pci_epf_mhi_unbind(struct pci_epf *epf)
 	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, epf_bar);
 }
 
-static const struct pci_epc_event_ops pci_epf_mhi_event_ops = {
+static const struct pci_epc_event_ops pci_epf_mhi_epc_event_ops = {
 	.core_init = pci_epf_mhi_core_init,
+};
+
+static const struct pci_epc_bus_event_ops pci_epf_mhi_bus_event_ops = {
 	.link_up = pci_epf_mhi_link_up,
 	.link_down = pci_epf_mhi_link_down,
 	.bme = pci_epf_mhi_bme,
@@ -919,7 +922,8 @@ static int pci_epf_mhi_probe(struct pci_epf *epf,
 	epf_mhi->info = info;
 	epf_mhi->epf = epf;
 
-	epf->event_ops = &pci_epf_mhi_event_ops;
+	epf->epc_event_ops = &pci_epf_mhi_epc_event_ops;
+	epf->bus_event_ops = &pci_epf_mhi_bus_event_ops;
 
 	mutex_init(&epf_mhi->lock);
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 977fb79c1567..973db0b1bde2 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -798,8 +798,11 @@ static int pci_epf_test_link_up(struct pci_epf *epf)
 	return 0;
 }
 
-static const struct pci_epc_event_ops pci_epf_test_event_ops = {
+static const struct pci_epc_event_ops pci_epf_test_epc_event_ops = {
 	.core_init = pci_epf_test_core_init,
+};
+
+static const struct pci_epc_bus_event_ops pci_epf_test_bus_event_ops = {
 	.link_up = pci_epf_test_link_up,
 };
 
@@ -916,7 +919,8 @@ static int pci_epf_test_probe(struct pci_epf *epf,
 
 	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
 
-	epf->event_ops = &pci_epf_test_event_ops;
+	epf->epc_event_ops = &pci_epf_test_epc_event_ops;
+	epf->bus_event_ops = &pci_epf_test_bus_event_ops;
 
 	epf_set_drvdata(epf, epf_test);
 	return 0;
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 47d27ec7439d..f202ae07ffa9 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -692,8 +692,8 @@ void pci_epc_linkup(struct pci_epc *epc)
 	mutex_lock(&epc->list_lock);
 	list_for_each_entry(epf, &epc->pci_epf, list) {
 		mutex_lock(&epf->lock);
-		if (epf->event_ops && epf->event_ops->link_up)
-			epf->event_ops->link_up(epf);
+		if (epf->bus_event_ops && epf->bus_event_ops->link_up)
+			epf->bus_event_ops->link_up(epf);
 		mutex_unlock(&epf->lock);
 	}
 	mutex_unlock(&epc->list_lock);
@@ -718,8 +718,8 @@ void pci_epc_linkdown(struct pci_epc *epc)
 	mutex_lock(&epc->list_lock);
 	list_for_each_entry(epf, &epc->pci_epf, list) {
 		mutex_lock(&epf->lock);
-		if (epf->event_ops && epf->event_ops->link_down)
-			epf->event_ops->link_down(epf);
+		if (epf->bus_event_ops && epf->bus_event_ops->link_down)
+			epf->bus_event_ops->link_down(epf);
 		mutex_unlock(&epf->lock);
 	}
 	mutex_unlock(&epc->list_lock);
@@ -744,8 +744,8 @@ void pci_epc_init_notify(struct pci_epc *epc)
 	mutex_lock(&epc->list_lock);
 	list_for_each_entry(epf, &epc->pci_epf, list) {
 		mutex_lock(&epf->lock);
-		if (epf->event_ops && epf->event_ops->core_init)
-			epf->event_ops->core_init(epf);
+		if (epf->epc_event_ops && epf->epc_event_ops->core_init)
+			epf->epc_event_ops->core_init(epf);
 		mutex_unlock(&epf->lock);
 	}
 	epc->init_complete = true;
@@ -767,8 +767,8 @@ void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf)
 {
 	if (epc->init_complete) {
 		mutex_lock(&epf->lock);
-		if (epf->event_ops && epf->event_ops->core_init)
-			epf->event_ops->core_init(epf);
+		if (epf->epc_event_ops && epf->epc_event_ops->core_init)
+			epf->epc_event_ops->core_init(epf);
 		mutex_unlock(&epf->lock);
 	}
 }
@@ -792,8 +792,8 @@ void pci_epc_bme_notify(struct pci_epc *epc)
 	mutex_lock(&epc->list_lock);
 	list_for_each_entry(epf, &epc->pci_epf, list) {
 		mutex_lock(&epf->lock);
-		if (epf->event_ops && epf->event_ops->bme)
-			epf->event_ops->bme(epf);
+		if (epf->bus_event_ops && epf->bus_event_ops->bme)
+			epf->bus_event_ops->bme(epf);
 		mutex_unlock(&epf->lock);
 	}
 	mutex_unlock(&epc->list_lock);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index adee6a1b35db..77399fecaeb5 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -69,14 +69,21 @@ struct pci_epf_ops {
 };
 
 /**
- * struct pci_epc_event_ops - Callbacks for capturing the EPC events
- * @core_init: Callback for the EPC initialization complete event
- * @link_up: Callback for the EPC link up event
- * @link_down: Callback for the EPC link down event
- * @bme: Callback for the EPC BME (Bus Master Enable) event
+ * struct pci_epc_event_ops - Callbacks for capturing the EPC specific events
+ * @core_init: Callback for the EPC initialization event
  */
 struct pci_epc_event_ops {
 	int (*core_init)(struct pci_epf *epf);
+};
+
+/**
+ * struct pci_epc_bus_event_ops - Callbacks for capturing the PCIe bus specific
+ *                               events
+ * @link_up: Callback for the PCIe bus link up event
+ * @link_down: Callback for the PCIe bus link down event
+ * @bme: Callback for the PCIe bus BME (Bus Master Enable) event
+ */
+struct pci_epc_bus_event_ops {
 	int (*link_up)(struct pci_epf *epf);
 	int (*link_down)(struct pci_epf *epf);
 	int (*bme)(struct pci_epf *epf);
@@ -150,7 +157,8 @@ struct pci_epf_bar {
  * @is_vf: true - virtual function, false - physical function
  * @vfunction_num_map: bitmap to manage virtual function number
  * @pci_vepf: list of virtual endpoint functions associated with this function
- * @event_ops: Callbacks for capturing the EPC events
+ * @epc_event_ops: Callbacks for capturing the EPC events
+ * @bus_event_ops: Callbacks for capturing the PCIe bus events
  */
 struct pci_epf {
 	struct device		dev;
@@ -180,7 +188,8 @@ struct pci_epf {
 	unsigned int		is_vf;
 	unsigned long		vfunction_num_map;
 	struct list_head	pci_vepf;
-	const struct pci_epc_event_ops *event_ops;
+	const struct pci_epc_event_ops *epc_event_ops;
+	const struct pci_epc_bus_event_ops *bus_event_ops;
 };
 
 /**

-- 
2.25.1


