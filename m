Return-Path: <linux-pci+bounces-4825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A7587BFEC
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 16:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF0A2842DB
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 15:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565B173532;
	Thu, 14 Mar 2024 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TwvgUoOM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC777351C
	for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429863; cv=none; b=rPWEdBI5ju4xANcWqJYJsdRPSzbUNXjebjHZ8NV9wCKUGdTRoCuxa6mO9IPAR9G3iwzGSKMkZGg9NirJFOt7kRdg2P+u4bBcXg3zkyy1HLu3QN7hL6Ie2Bz2AZ4vs2V+HKJB0WcTfb5D+BgleEA6H2eancvpv7nmByAC7kp881Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429863; c=relaxed/simple;
	bh=lGCqTGsH0mm9VdgV3rimMB23vCvTqdQtyUoVRgnqHFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gsosqQW4P3PtQ+aWbqEYf6pDZt5VKqKkK3FLO824GCJ3PmRIyGlGgd7f7/sQew/H25fNDLLeqxTenItEHBnIoAIFttYvhV95IXO0iuXBRsIRix4b6fwVjll5ANYGwRyR4JU8NTot+BUXq33zfVkQyxiBDMAdSA+OXjp/CkHNYVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TwvgUoOM; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59fdcf8ebbcso648686eaf.3
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 08:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710429860; x=1711034660; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hmo5GkrWgq85dG1VyL0i72o0ju0TcnLWL9PRQB4CpVU=;
        b=TwvgUoOM8oOAnHz6tpkyidljFowISqwbmuko43QW2SMLh20SMKzeFzLBvITBBx8MAV
         dfdKHELuBFSkMxXroUBULVHuXna/LFUA+OaMRQGxJ1IqZS7ruCi1xIR3TQ7QiTvm2UbT
         /pIyaUoIYqfP7efbEaNDeosBCZOvyTNxVEh7TKPeL9H2RMt8Q9ealIRGhn3Ohnpjc4cP
         USdohdd2f1rGEqeA23dMZcFQnHHq0tyuYn3I29Lp9BR0fagyskD4gOX3kQHQZoNFgP/R
         s+St7CnrvLyXZm+vJzrIzk/q7r3B8g3j4vbQcM6P1IBbV9noXuQUb/D2rr7BwGYaUoAZ
         FN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710429860; x=1711034660;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hmo5GkrWgq85dG1VyL0i72o0ju0TcnLWL9PRQB4CpVU=;
        b=JbL7Yi615f1wwo7HABr9IRg55RhAFlWKs/iJqK/je1Wh0oe00liSp10hReJqy2S5AJ
         9jmHJgfssuzlKKvS8DYf02p6zglZ9ucD+592JiPlAARrph9RO4eVHANmnwprELxSRAZw
         +qCnEnp7J6on/rScHza5DHDtYN+R0EsMiXHA8TuXyqI6M2clyc3mAB6UH7RE+uFRTgVZ
         NUP+rMCT/nxOuxtsKhXWOfwly0lPeR1EHQfXP67b+mI6vkVaT43aR74xzMcwPlYLP4Vo
         gVaP7YPM1082n2eYpHzSY4WNvpjCmG4sX3Hkq1w+FbcZhb2Fl20wCCRJKUEW6u+iL9LM
         bSag==
X-Gm-Message-State: AOJu0YzK2rCi8AXkXQiFqH+378/2fFOfzytd/91jTb8clmbA7T0vuTY+
	PGggBmhkJwVIRNmZHxOAR6bmf45xad9Qc6qIleg+2S3egg7z4WNpXlBs73Gucw==
X-Google-Smtp-Source: AGHT+IH735h0wRO4p3EDFKpXdMk7lf50Krmo5ygqFNlixEaKdjPh2gApyS1k774c2ix2b6oWQqeniQ==
X-Received: by 2002:a05:6358:248b:b0:17b:f3f9:117d with SMTP id m11-20020a056358248b00b0017bf3f9117dmr2735196rwc.16.1710429859818;
        Thu, 14 Mar 2024 08:24:19 -0700 (PDT)
Received: from [127.0.1.1] ([117.207.30.211])
        by smtp.gmail.com with ESMTPSA id m4-20020a63ed44000000b005e438ea2a5asm824021pgk.53.2024.03.14.08.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 08:24:19 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 14 Mar 2024 20:53:42 +0530
Subject: [PATCH 03/11] PCI: endpoint: Rename core_init() callback in
 'struct pci_epc_event_ops' to init()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-pci-epf-rework-v1-3-6134e6c1d491@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5286;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=lGCqTGsH0mm9VdgV3rimMB23vCvTqdQtyUoVRgnqHFc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl8xaO/kPngWfy5i/yfKtWNyWLtszgSAOX80+JM
 Zd7R8DLC/uJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfMWjgAKCRBVnxHm/pHO
 9Y9yB/9p0lkMoFe7sB5zCrNwSgPCUSxbb7RwZelaxXlhS5eru2NoWPc6nervrB3VSZYrItAebyU
 ENZddDyZY5pFAm3l4/aoJ8DhJd+fCrNgsqUV3JPXRZdsrinTxCbfbDlS0TIHH+255uiy0osRMxo
 VjNcNfiRxylOi1NVeVsr3Q0gDo90lI0WHkPhpzx8wsjo69OzykBfV+f8p/KN590C7z71yRAh6GO
 oONX3nSRm2ziR/9KETgAyunWypnI9tO6dNsl+H6VkfCWrbVJ4mrFr85ZEVRHjqr6UnIN1+qAPHV
 KLpSYYEuzF8JGp925cOz6vuAc1zwUghqPzrTaoKeAgr8dwR2
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

core_init() callback is used to notify the EPC initialization event to the
EPF drivers. The 'core' prefix was used indicate that the controller IP
core has completed initialization. But it serves no purpose as the EPF
driver will only care about the EPC initialization as a whole and there is
no real benefit to distinguish the IP core part.

So let's rename the core_init() callback in 'struct pci_epc_event_ops' to
just init() to make it more clear.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c  |  4 ++--
 drivers/pci/endpoint/functions/pci-epf-test.c |  4 ++--
 drivers/pci/endpoint/pci-epc-core.c           | 16 ++++++++--------
 include/linux/pci-epf.h                       |  4 ++--
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index e5d67aec7574..da894a9a447e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -700,7 +700,7 @@ static void pci_epf_mhi_dma_deinit(struct pci_epf_mhi *epf_mhi)
 	epf_mhi->dma_chan_rx = NULL;
 }
 
-static int pci_epf_mhi_core_init(struct pci_epf *epf)
+static int pci_epf_mhi_epc_init(struct pci_epf *epf)
 {
 	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
 	const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
@@ -881,7 +881,7 @@ static void pci_epf_mhi_unbind(struct pci_epf *epf)
 }
 
 static const struct pci_epc_event_ops pci_epf_mhi_epc_event_ops = {
-	.core_init = pci_epf_mhi_core_init,
+	.init = pci_epf_mhi_epc_init,
 };
 
 static const struct pci_epc_bus_event_ops pci_epf_mhi_bus_event_ops = {
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 751dab5799d5..1dae0fce8fc4 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -746,7 +746,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 	return 0;
 }
 
-static int pci_epf_test_core_init(struct pci_epf *epf)
+static int pci_epf_test_epc_init(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	struct pci_epf_header *header = epf->header;
@@ -814,7 +814,7 @@ static int pci_epf_test_link_up(struct pci_epf *epf)
 }
 
 static const struct pci_epc_event_ops pci_epf_test_epc_event_ops = {
-	.core_init = pci_epf_test_core_init,
+	.init = pci_epf_test_epc_init,
 };
 
 static const struct pci_epc_bus_event_ops pci_epf_test_bus_event_ops = {
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index f602f08a11a2..5a522b2842e2 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -732,9 +732,9 @@ void pci_epc_linkdown(struct pci_epc *epc)
 EXPORT_SYMBOL_GPL(pci_epc_linkdown);
 
 /**
- * pci_epc_init_notify() - Notify the EPF device that EPC device's core
- *			   initialization is completed.
- * @epc: the EPC device whose core initialization is completed
+ * pci_epc_init_notify() - Notify the EPF device that EPC device initialization
+ *                         is completed.
+ * @epc: the EPC device whose initialization is completed
  *
  * Invoke to Notify the EPF device that the EPC device's initialization
  * is completed.
@@ -749,8 +749,8 @@ void pci_epc_init_notify(struct pci_epc *epc)
 	mutex_lock(&epc->list_lock);
 	list_for_each_entry(epf, &epc->pci_epf, list) {
 		mutex_lock(&epf->lock);
-		if (epf->epc_event_ops && epf->epc_event_ops->core_init)
-			epf->epc_event_ops->core_init(epf);
+		if (epf->epc_event_ops && epf->epc_event_ops->init)
+			epf->epc_event_ops->init(epf);
 		mutex_unlock(&epf->lock);
 	}
 	epc->init_complete = true;
@@ -761,7 +761,7 @@ EXPORT_SYMBOL_GPL(pci_epc_init_notify);
 /**
  * pci_epc_notify_pending_init() - Notify the pending EPC device initialization
  *                                 complete to the EPF device
- * @epc: the EPC device whose core initialization is pending to be notified
+ * @epc: the EPC device whose initialization is pending to be notified
  * @epf: the EPF device to be notified
  *
  * Invoke to notify the pending EPC device initialization complete to the EPF
@@ -772,8 +772,8 @@ void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf)
 {
 	if (epc->init_complete) {
 		mutex_lock(&epf->lock);
-		if (epf->epc_event_ops && epf->epc_event_ops->core_init)
-			epf->epc_event_ops->core_init(epf);
+		if (epf->epc_event_ops && epf->epc_event_ops->init)
+			epf->epc_event_ops->init(epf);
 		mutex_unlock(&epf->lock);
 	}
 }
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 1271e1e00bbd..ff8304e72f8e 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -69,10 +69,10 @@ struct pci_epf_ops {
 
 /**
  * struct pci_epc_event_ops - Callbacks for capturing the EPC specific events
- * @core_init: Callback for the EPC initialization event
+ * @init: Callback for the EPC initialization event
  */
 struct pci_epc_event_ops {
-	int (*core_init)(struct pci_epf *epf);
+	int (*init)(struct pci_epf *epf);
 };
 
 /**

-- 
2.25.1


