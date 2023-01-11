Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0577A665A92
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 12:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjAKLo2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 06:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjAKLnB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 06:43:01 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7272412A94
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 03:41:37 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 17so16545808pll.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 03:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMFBNcMsSwUAtzp9lzITidEj8Y0BrN9scArVi0VzClw=;
        b=Cj847BbbdZTsyxKXL070RY+vEBtesJT7pHaPuk/PL6G1J+O6r9G54Ulcmj0WjsR4Gi
         SfkFuyDlZMtwyiamIKzhFjVDDzEwjFfOTgvQf67Ud1kHXHopN4uMEFUEJDUk+L9u5E6s
         KaY0QaNTaUWXL1o4J14bsvHz8QB4qaUZnfRBjcc3mgB5fOZ2pw4tk4tdD4T+IVN0iqqj
         Ese9sy+LW0DNjRHI2jDnEwGq4+sGyStTCi7DGTFmU85CR7bDqKK+izsnO+cMONv2V8rq
         RQoWGEcJK6y0MUd8EdouvXL3+ekNyMKnX/8rHtbvIhXwDJQICzz5u8Dc9vlH+WhG45Y9
         1rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMFBNcMsSwUAtzp9lzITidEj8Y0BrN9scArVi0VzClw=;
        b=xe62GnqLw80UTRgut7eL3FocrdeZFYyLjQO0xLddtBQJfgmtB50mscCrOY/3lQWSZ4
         KCnvqCsomJh2sdSoEIZqqTSQk99ex05Pm7QZZjYxYdt2kNE+HaL6OVPWOLUOkDtQZTcq
         Vtv27NQZGnNxKkIre0MvhtyXGiTDeIorWxXojjwKJntA6flDSF/nyAi8VKGV19hTytT9
         WotgESphvPcC5+asnsIT3nUXQMmn7OHz+lGAjcMQ8N83EiZG21ckNS5sy7miw/G/Ekt7
         knq8JQDzHTYZOBPQ5rSONPwKW1rm0zvVM8ZqZw8pM3wrXoo079EmjBJh9E6VXjPDKK5o
         5Dmw==
X-Gm-Message-State: AFqh2kqcTIh7U1CEYzA/xeN2Dhr2+7smc2noQOItrbeesrkVKDtlfQ8b
        k6WE691mlozYSHkEUsoff7da
X-Google-Smtp-Source: AMrXdXv0HEF4sIUbR+Cx9/GCA84i4KpTkopt+vRmMmGIMc6wJOmab24jm3J/febCcoh/GoImKQZ1Fw==
X-Received: by 2002:a17:903:2685:b0:192:ca49:4c59 with SMTP id jf5-20020a170903268500b00192ca494c59mr31763833plb.16.1673437296915;
        Wed, 11 Jan 2023 03:41:36 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.1])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e5ce00b0018958a913a2sm9942688plf.223.2023.01.11.03.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 03:41:35 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND v4 5/5] PCI: endpoint: Use link_up() callback in place of LINK_UP notifier
Date:   Wed, 11 Jan 2023 17:10:59 +0530
Message-Id: <20230111114059.6553-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230111114059.6553-1-manivannan.sadhasivam@linaro.org>
References: <20230111114059.6553-1-manivannan.sadhasivam@linaro.org>
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
index 2fe161747e51..39fb3774aecf 100644
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

