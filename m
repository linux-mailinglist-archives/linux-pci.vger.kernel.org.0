Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DBB5F6889
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 15:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiJFNuh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 09:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiJFNuV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 09:50:21 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531377F247
        for <linux-pci@vger.kernel.org>; Thu,  6 Oct 2022 06:50:04 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y8so2062896pfp.13
        for <linux-pci@vger.kernel.org>; Thu, 06 Oct 2022 06:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Y0MJ+CUZZvqiC06rOGoANeiEeLDH+rfWRVr8HGOI0zE=;
        b=m+gzwteEDOkMfL/WFoicBOTuBgNGNC5upbaRmlPnAq2+eHEimZ0IGhaNNfATO+I1td
         Fn3w+pSkPbAUQQa+rkRijGa3SOLJqJYtHJTyXKs4hyB72V3W7V/U2Ju2JTuaz3TPRuy8
         B/lfYiInVeMGS/AEKNlIqfgp3kvP4FqNs6b4T5RIYUSZEwPbWY23T9iBKt9q1M12iay+
         nfyyiG3eZdJgU1qkdUtEveHSxNp3sEcXFQi/6ptvJGqyVM2PmZpcQ9QSw6PPFtIX/AUV
         wtSMKYDrziZaMG9NJ2K/LQ0SJ7TTIdKtukh7jaIuLOjvubG3sGCpuwKnzJP74uvJKdKO
         aobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Y0MJ+CUZZvqiC06rOGoANeiEeLDH+rfWRVr8HGOI0zE=;
        b=F09b/uNETVlFRoXpXJJhPzmWxpExI1bhuNXg3zNmEZqmF0ZClWVXyloefl/ACzsxvv
         8hlC5Shog4bSfVaipgsvcbWnGURXLa8qaAeFnlMp2OYc+CmWydqxIn3LNuGB62aJ0Z+M
         SgylgE24FBhxh899MHI4lIojft70CQvRdy8//ilV69UeNRmHWubUeoSvwYhUbu0Dtn1I
         7pvN6KvTjbyMIvPsSEaxdL1fbOIpQNOhtPQYznTNRVO4HpfLIwZ7aqnmZjwLMe7TZwqk
         GuxK5oGj2tjelRZNEbXfSl6H6cZvYKIDraDEBLrRFjsVxoplYpc0B4rweABFcwfx69u/
         wA1w==
X-Gm-Message-State: ACrzQf2VA+RAoH5u+IuDcxgFjJVOajbpM15g5xU0qA8kXmt0eH4fynuC
        rwmS0mSa2Sfa4CgyLxiVP23P
X-Google-Smtp-Source: AMsMyM7gSbJZ96bcqtZTdVs4/z84De0pFcLRe4b2AbJgXTAHQk0JwrMBVcmscWQYl5xaVRo5E2YdJQ==
X-Received: by 2002:a63:b545:0:b0:43c:2ad9:b00 with SMTP id u5-20020a63b545000000b0043c2ad90b00mr1456pgo.535.1665064203337;
        Thu, 06 Oct 2022 06:50:03 -0700 (PDT)
Received: from localhost.localdomain ([220.158.158.220])
        by smtp.gmail.com with ESMTPSA id k25-20020a635a59000000b00434760ee36asm1874053pgm.16.2022.10.06.06.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:50:02 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 5/5] PCI: endpoint: Use link_up() callback in place of LINK_UP notifier
Date:   Thu,  6 Oct 2022 19:19:27 +0530
Message-Id: <20221006134927.41437-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006134927.41437-1-manivannan.sadhasivam@linaro.org>
References: <20221006134927.41437-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/pci/endpoint/pci-epc-core.c           | 12 +++++--
 include/linux/pci-epc.h                       |  8 -----
 include/linux/pci-epf.h                       |  8 ++---
 4 files changed, 22 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 868de17e1ad2..f75045f2dee3 100644
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
index ba54f17ae06f..5dac1496cf16 100644
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
+		if (epf->event_ops->link_up)
+			epf->event_ops->link_up(epf);
+		mutex_unlock(&epf->lock);
+	}
+	mutex_unlock(&epc->list_lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_linkup);
 
@@ -784,7 +793,6 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
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

