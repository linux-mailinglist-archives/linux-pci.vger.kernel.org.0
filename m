Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FDC58FA37
	for <lists+linux-pci@lfdr.de>; Thu, 11 Aug 2022 11:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbiHKJne (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Aug 2022 05:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbiHKJnW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 05:43:22 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEE281698
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 02:43:21 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso4828745pjo.1
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 02:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=F5DxS0pA74UlPDuN8Qz9kJijHmaiEeefe4AsfGooW68=;
        b=y6GyMKBIUT8zJ/MMaMSjghBm021AhVAoU4oIwUR8zeRVR16Y+67FdgS9F5AxSl5KjJ
         LagRoE3XVxyah4z6sM3kBeerZCK8xCv/2czkDRdyMMjW5dEsb0f4vbpBfWha7G/g/MSg
         763r2rplXBcg6ptEQZ3gVwSnUFBsZ7222foOBaWiOzJHWn5I7YY4qD+a3tnm7Fkfsm7j
         9uhxptoPWzPGYvHD5BLcSOxq7C8W2otI/RA6BNTgQIl1XiAbb2QKzrqAlpPPHHPuzCVW
         sNxVbtfO79HOUGTKbB2WJQsj2jGqNF+rnHJG+23kLvFNjwPtiLOHid0udtIX5XuQOaZn
         HfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=F5DxS0pA74UlPDuN8Qz9kJijHmaiEeefe4AsfGooW68=;
        b=q3HDtJ77/J0LnUPRcu2awxB90Q6DfOZj9va3lu5uUDH4HqF7uomdaJUNnR80QoDb/+
         xdRMYeDi0sV40LWQoc4m5uBatIam0LxKu4i6uEY40BZHoxaHkaiHl6aIFFWbJL+g5iNf
         USzeCQMm9TdPeKUjPqhabd4Y3UxT49ia0dh7p0qx4jrMnQc2QQnNN/tNj/a5dHT2Mi7c
         BrsxWWU2E5ndhMdwN+cCcLdGi13sOfSdeMd/MmYaA5gjPdQ9/F5YE4xG5tTYlsgBoFh7
         PlbbWf2bbX3GNC5iaVUOhC71YfioNwwWXX8k/+YlWGqAu0lHHpgTHwUj/P/p2pVO0n8U
         zgww==
X-Gm-Message-State: ACgBeo3cDweLbZaM0qyFhfH+iD8HYtKvXibE/mP4w2XwTIWuu47rPCc/
        BJ7kSOfen+Tir7+3v+qiNcDLM298j6Uj
X-Google-Smtp-Source: AA6agR5SACUm3dq6gpunYuni2ojL/+7AkWvoClch8BRRaro5aySTuRg6TuaMHSymrRsYFQp3cHt/Kw==
X-Received: by 2002:a17:90a:db0d:b0:1f3:a48e:46b3 with SMTP id g13-20020a17090adb0d00b001f3a48e46b3mr8184317pjv.72.1660211000763;
        Thu, 11 Aug 2022 02:43:20 -0700 (PDT)
Received: from localhost.localdomain ([59.92.103.103])
        by smtp.gmail.com with ESMTPSA id s5-20020a625e05000000b0052e6d5ee183sm3553931pfb.129.2022.08.11.02.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 02:43:20 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     kw@linux.com, robh@kernel.org, vidyas@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/2] PCI: endpoint: Use link_up() callback in place of LINK_UP notifier
Date:   Thu, 11 Aug 2022 15:12:37 +0530
Message-Id: <20220811094237.77632-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811094237.77632-1-manivannan.sadhasivam@linaro.org>
References: <20220811094237.77632-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 33 ++++++-------------
 drivers/pci/endpoint/pci-epc-core.c           |  8 +++--
 include/linux/pci-epc.h                       |  8 -----
 include/linux/pci-epf.h                       |  8 ++---
 4 files changed, 18 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 069943b57029..37454538c000 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -731,30 +731,21 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
 	return 0;
 }
 
-static const struct pci_epc_event_ops pci_epf_test_event_ops = {
-	.core_init = pci_epf_test_core_init,
-};
-
-static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
-				 void *data)
+int pci_epf_test_link_up(struct pci_epf *epf)
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
@@ -881,12 +872,8 @@ static int pci_epf_test_bind(struct pci_epf *epf)
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
index 805f3d64f93b..a51ba9f158c3 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -690,10 +690,15 @@ EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
  */
 void pci_epc_linkup(struct pci_epc *epc)
 {
+	struct pci_epf *epf;
+
 	if (!epc || IS_ERR(epc))
 		return;
 
-	atomic_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
+	list_for_each_entry(epf, &epc->pci_epf, list) {
+		if (epf->event_ops->link_up)
+			epf->event_ops->link_up(epf);
+	}
 }
 EXPORT_SYMBOL_GPL(pci_epc_linkup);
 
@@ -779,7 +784,6 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 
 	mutex_init(&epc->lock);
 	INIT_LIST_HEAD(&epc->pci_epf);
-	ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
 
 	device_initialize(&epc->dev);
 	epc->dev.class = pci_epc_class;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index a48778e1a4ee..05604fe0ede0 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -134,7 +134,6 @@ struct pci_epc_mem {
  * @group: configfs group representing the PCI EPC device
  * @lock: mutex to protect pci_epc ops
  * @function_num_map: bitmap to manage physical function number
- * @notifier: used to notify EPF of any EPC events (like linkup)
  */
 struct pci_epc {
 	struct device			dev;
@@ -149,7 +148,6 @@ struct pci_epc {
 	/* mutex to protect against concurrent access of EP controller */
 	struct mutex			lock;
 	unsigned long			function_num_map;
-	struct atomic_notifier_head	notifier;
 };
 
 /**
@@ -192,12 +190,6 @@ static inline void *epc_get_drvdata(struct pci_epc *epc)
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
index a06f3b4c8bee..bc613f0df7e3 100644
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
@@ -135,7 +133,6 @@ struct pci_epf_bar {
  * @driver: the EPF driver to which this EPF device is bound
  * @id: Pointer to the EPF device ID
  * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
- * @nb: notifier block to notify EPF of any EPC events (like linkup)
  * @lock: mutex to protect pci_epf_ops
  * @sec_epc: the secondary EPC device to which this EPF device is bound
  * @sec_epc_list: to add pci_epf as list of PCI endpoint functions to secondary
@@ -164,7 +161,6 @@ struct pci_epf {
 	struct pci_epf_driver	*driver;
 	const struct pci_epf_device_id *id;
 	struct list_head	list;
-	struct notifier_block   nb;
 	/* mutex to protect against concurrent access of pci_epf_ops */
 	struct mutex		lock;
 
-- 
2.25.1

