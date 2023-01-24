Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EC06791AD
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 08:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjAXHNO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 02:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjAXHNG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 02:13:06 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1512D4C
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 23:12:47 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso13213959pjf.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 23:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NE2wDny5PvDRrubr6JRTjSZsx71LXB56a2j7Ta+DwYo=;
        b=oC+dWgQH/gctvZu2MG2Q87ikWE5cGSRh3pjabyPTFWcOWNtke3S08mO6T7Re/wQC3M
         AlmVTy7tI8HpppCq+teW51YusVPsiGL8WgkOrRU5fE8X+rAEECEsntEjcxiqpOnjowq4
         H4wESEem/k/QvtLYUwQ3b+7GZ6EhZyL2c8MfpdLKbzqe9Oy+4XjQdTOokzJ+14XEDYlc
         pF6Q1EJCXCHDHFz+/1SWUtQ7b9izzG5tNe/9tv+/inUbAqMVfa8Hxui2i4+dwVYGjmHm
         tyrDap8AYGzV5FvURU3cMnGmLR+vyrF6bc2scyoKLAYjlCRSB/lP/kzxu0awpQ0Bf/Pu
         8X5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NE2wDny5PvDRrubr6JRTjSZsx71LXB56a2j7Ta+DwYo=;
        b=TJbOiJUm1PM/zLnA5Zo25rwp32c0PauPqkP3Jix303dfvkd6BFIfQFPdwFtjM2RT0t
         +5io+oOZAW8rRARdlFjzxnN0raM+oqNRIZfbigLNDW9aupXwexJtMKEY6QxTvmpL0nen
         sf+MmgawGPh/wqQMXl5erYAkQ6rAs9yiGgmLYSWQ1jv6iuV7KjTxzx+y+53e6NKgWf0Z
         wqogWD3F9+bY9OqOlTPyNFLOJ6+G+GpqQne0hVLpoCeoaOq0gfh/crIdLdnhE6rAGpko
         8bBcqcQaox/J6z6sKbkykFvfmEEMrOu1WSgyqsgv7STSa0tdPCXtXtD3333h19npNyGa
         hgEA==
X-Gm-Message-State: AFqh2krRCbbW48J3WzEma8LDy8zQY7hdvECCbWOy4Oa6SBtK6ssCTcMn
        Sl71MN7GE19yfbc2IMl6XeNk
X-Google-Smtp-Source: AMrXdXsp4bGKJYTu78UUTYKOif+X8CONjW0SePClol0eE1CaQXHmLW78TJROfdl4YBFl91NlgkebCA==
X-Received: by 2002:a17:90a:b107:b0:219:dc24:7595 with SMTP id z7-20020a17090ab10700b00219dc247595mr28596417pjq.19.1674544367425;
        Mon, 23 Jan 2023 23:12:47 -0800 (PST)
Received: from localhost.localdomain ([117.193.209.165])
        by smtp.gmail.com with ESMTPSA id 7-20020a17090a174700b00219220edf0dsm736041pjm.48.2023.01.23.23.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 23:12:46 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 5/5] PCI: endpoint: Use link_up() callback in place of LINK_UP notifier
Date:   Tue, 24 Jan 2023 12:41:58 +0530
Message-Id: <20230124071158.5503-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230124071158.5503-1-manivannan.sadhasivam@linaro.org>
References: <20230124071158.5503-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As a part of the transition towards callback mechanism for signalling the
events from EPC to EPF, let's use the link_up() callback in the place of
the LINK_UP notifier. This also removes the notifier support completely
from the PCI endpoint framework.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Kishon Vijay Abraham I <kishon@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 33 ++++++-------------
 drivers/pci/endpoint/pci-epc-core.c           | 12 +++++--
 include/linux/pci-epc.h                       |  8 -----
 include/linux/pci-epf.h                       |  8 ++---
 4 files changed, 22 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 2fe161747e51..0f9d2ec822ac 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -826,30 +826,21 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
 	return 0;
 }
 
-static const struct pci_epc_event_ops pci_epf_test_event_ops = {
-	.core_init = pci_epf_test_core_init,
-};
-
-static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
-				 void *data)
+static int pci_epf_test_link_up(struct pci_epf *epf)
 {
-	struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 
-	switch (val) {
-	case LINK_UP:
-		queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
-				   msecs_to_jiffies(1));
-		break;
-
-	default:
-		dev_err(&epf->dev, "Invalid EPF test notifier event\n");
-		return NOTIFY_BAD;
-	}
+	queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
+			   msecs_to_jiffies(1));
 
-	return NOTIFY_OK;
+	return 0;
 }
 
+static const struct pci_epc_event_ops pci_epf_test_event_ops = {
+	.core_init = pci_epf_test_core_init,
+	.link_up = pci_epf_test_link_up,
+};
+
 static int pci_epf_test_alloc_space(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
@@ -976,12 +967,8 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	if (ret)
 		epf_test->dma_supported = false;
 
-	if (linkup_notifier || core_init_notifier) {
-		epf->nb.notifier_call = pci_epf_test_notifier;
-		pci_epc_register_notifier(epc, &epf->nb);
-	} else {
+	if (!linkup_notifier && !core_init_notifier)
 		queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
-	}
 
 	return 0;
 }
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 7cb9587c6548..c9c3c6b58a9f 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -690,10 +690,19 @@ EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
  */
 void pci_epc_linkup(struct pci_epc *epc)
 {
+	struct pci_epf *epf;
+
 	if (!epc || IS_ERR(epc))
 		return;
 
-	atomic_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
+	mutex_lock(&epc->list_lock);
+	list_for_each_entry(epf, &epc->pci_epf, list) {
+		mutex_lock(&epf->lock);
+		if (epf->event_ops && epf->event_ops->link_up)
+			epf->event_ops->link_up(epf);
+		mutex_unlock(&epf->lock);
+	}
+	mutex_unlock(&epc->list_lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_linkup);
 
@@ -788,7 +797,6 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 	mutex_init(&epc->lock);
 	mutex_init(&epc->list_lock);
 	INIT_LIST_HEAD(&epc->pci_epf);
-	ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
 
 	device_initialize(&epc->dev);
 	epc->dev.class = pci_epc_class;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index fe729dfe509b..301bb0e53707 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -135,7 +135,6 @@ struct pci_epc_mem {
  * @group: configfs group representing the PCI EPC device
  * @lock: mutex to protect pci_epc ops
  * @function_num_map: bitmap to manage physical function number
- * @notifier: used to notify EPF of any EPC events (like linkup)
  */
 struct pci_epc {
 	struct device			dev;
@@ -151,7 +150,6 @@ struct pci_epc {
 	/* mutex to protect against concurrent access of EP controller */
 	struct mutex			lock;
 	unsigned long			function_num_map;
-	struct atomic_notifier_head	notifier;
 };
 
 /**
@@ -194,12 +192,6 @@ static inline void *epc_get_drvdata(struct pci_epc *epc)
 	return dev_get_drvdata(&epc->dev);
 }
 
-static inline int
-pci_epc_register_notifier(struct pci_epc *epc, struct notifier_block *nb)
-{
-	return atomic_notifier_chain_register(&epc->notifier, nb);
-}
-
 struct pci_epc *
 __devm_pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 		      struct module *owner);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index fa629c191f00..a215dc8ce693 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -17,10 +17,6 @@
 struct pci_epf;
 enum pci_epc_interface_type;
 
-enum pci_notify_event {
-	LINK_UP,
-};
-
 enum pci_barno {
 	NO_BAR = -1,
 	BAR_0,
@@ -74,9 +70,11 @@ struct pci_epf_ops {
 /**
  * struct pci_epf_event_ops - Callbacks for capturing the EPC events
  * @core_init: Callback for the EPC initialization complete event
+ * @link_up: Callback for the EPC link up event
  */
 struct pci_epc_event_ops {
 	int (*core_init)(struct pci_epf *epf);
+	int (*link_up)(struct pci_epf *epf);
 };
 
 /**
@@ -134,7 +132,6 @@ struct pci_epf_bar {
  * @epf_pf: the physical EPF device to which this virtual EPF device is bound
  * @driver: the EPF driver to which this EPF device is bound
  * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
- * @nb: notifier block to notify EPF of any EPC events (like linkup)
  * @lock: mutex to protect pci_epf_ops
  * @sec_epc: the secondary EPC device to which this EPF device is bound
  * @sec_epc_list: to add pci_epf as list of PCI endpoint functions to secondary
@@ -162,7 +159,6 @@ struct pci_epf {
 	struct pci_epf		*epf_pf;
 	struct pci_epf_driver	*driver;
 	struct list_head	list;
-	struct notifier_block   nb;
 	/* mutex to protect against concurrent access of pci_epf_ops */
 	struct mutex		lock;
 
-- 
2.25.1

