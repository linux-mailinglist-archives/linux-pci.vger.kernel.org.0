Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FE660CF96
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 16:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiJYOvk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 10:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiJYOvg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 10:51:36 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E791A0478
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 07:51:34 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q71so11684256pgq.8
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 07:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPUYLN9W4BCvOlmHzhNojWMMlWjMPl6lRakt+Zvfz6k=;
        b=PC67dz8I4/JvtNy1bfJNkh5c+zWwXWKjXoxDj7L25zpv2LJLtomaKwVDKr80lSj7pQ
         b71cZXfskDT3U5cV0/wc+0pwslfshGx9MErUURt48Wg0m2dve0EOZE89oMagI2GhWSgc
         0FV7LZqhDtL3UMx2xImkRR44QXCYA6P7YmwnB3fH/sqLn4trX5e1rJacFN67jW0MJO6b
         /4kICPK23APQHIC3ItVUOXoS7uUYXQ4oKw//qFMe7xOxXOh1BMa/qh43Q26ol4ZUWp0j
         VpEdvXJCoMi5vYzvdeW8FI8SyIJ0NUADI/UlioFLJ1/tmg/72b5DEFbcfwL+WAS7e/zR
         9Xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPUYLN9W4BCvOlmHzhNojWMMlWjMPl6lRakt+Zvfz6k=;
        b=izRcQZ8RKwj/4IodhSCfr76cpiJRP08d+VqNJ81gis0qgjMHbtGPPbuxuyUjB6286b
         diXJSgBDyvH5qyz99Qmx88THQASsRBtNnsIeZlEhzeUeEanPr65M6wiJ0i6VrMXM4RX3
         3AJoTRgTME9Ank2u99V7a753OzL15csMNAocy/wDrhdUsFxsvMyDwkJdnXOtGniX8qQG
         QHklBl9vJgnEoLjRYyVxt2qhnSzkzR+AZIqle6DqSGNaG6TREMaMkJWjMuHOLIQ68eSQ
         Kr/4JOR5zCKfie/9OYfbMto8KQi+mD5u/Gdn5bEVTBz6z4BsNCfh0DpZgGpSyu9SibuE
         kClw==
X-Gm-Message-State: ACrzQf2cXVkLs/zKOi6iH1p+tX4iL+16YP76+XnWT7imyzeOUJCp+pFb
        bXpYdJY/JfuRKTzOhQN5xzTz
X-Google-Smtp-Source: AMsMyM4MQ1bTnHZNFWJMDTrGs9HFad71/FjWxCpcdE7VIyx3yib0IfG8APd0PlS1zLTsD16jH4V4Sg==
X-Received: by 2002:a63:8:0:b0:460:e669:a0c4 with SMTP id 8-20020a630008000000b00460e669a0c4mr33328164pga.475.1666709494244;
        Tue, 25 Oct 2022 07:51:34 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.236])
        by smtp.gmail.com with ESMTPSA id n14-20020a170903110e00b00180cf894b67sm1318765plh.130.2022.10.25.07.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:51:33 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 4/5] PCI: endpoint: Use callback mechanism for passing events from EPC to EPF
Date:   Tue, 25 Oct 2022 20:21:00 +0530
Message-Id: <20221025145101.116393-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025145101.116393-1-manivannan.sadhasivam@linaro.org>
References: <20221025145101.116393-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of using the notifiers for passing the events from EPC to EPF,
let's introduce a callback based mechanism where the EPF drivers can
populate relevant callbacks for EPC events they want to subscribe.

The use of notifiers in kernel is not recommended if there is a real link
between the sender and receiver, like in this case. Also, the existing
atomic notifier forces the notification functions to be in atomic context
while the caller may be in non-atomic context. For instance, the two
in-kernel users of the notifiers, pcie-qcom and pcie-tegra194, both are
calling the notifier functions in non-atomic context (from threaded IRQ
handlers). This creates a sleeping in atomic context issue with the
existing EPF_TEST driver that calls the EPC APIs that may sleep.

For all these reasons, let's get rid of the notifier chains and use the
simple callback mechanism for signalling the events from EPC to EPF
drivers. This preserves the context of the caller and avoids the latency
of going through a separate interface for triggering the notifications.

As a first step of the transition, the core_init() callback is introduced
in this commit, that'll replace the existing CORE_INIT notifier used for
signalling the init complete event from EPC.

During the occurrence of the event, EPC will go over the list of EPF
drivers attached to it and will call the core_init() callback if available.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++++++-------
 drivers/pci/endpoint/pci-epc-core.c           | 11 ++++++++++-
 include/linux/pci-epf.h                       | 11 ++++++++++-
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index a6f906a96669..868de17e1ad2 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -826,20 +826,17 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
 	return 0;
 }
 
+static const struct pci_epc_event_ops pci_epf_test_event_ops = {
+	.core_init = pci_epf_test_core_init,
+};
+
 static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
 				 void *data)
 {
 	struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
-	int ret;
 
 	switch (val) {
-	case CORE_INIT:
-		ret = pci_epf_test_core_init(epf);
-		if (ret)
-			return NOTIFY_BAD;
-		break;
-
 	case LINK_UP:
 		queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
 				   msecs_to_jiffies(1));
@@ -1010,6 +1007,8 @@ static int pci_epf_test_probe(struct pci_epf *epf, const struct pci_epf_device_i
 
 	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
 
+	epf->event_ops = &pci_epf_test_event_ops;
+
 	epf_set_drvdata(epf, epf_test);
 	return 0;
 }
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 6cce430d431b..8bb60528f530 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -707,10 +707,19 @@ EXPORT_SYMBOL_GPL(pci_epc_linkup);
  */
 void pci_epc_init_notify(struct pci_epc *epc)
 {
+	struct pci_epf *epf;
+
 	if (!epc || IS_ERR(epc))
 		return;
 
-	atomic_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
+	mutex_lock(&epc->list_lock);
+	list_for_each_entry(epf, &epc->pci_epf, list) {
+		mutex_lock(&epf->lock);
+		if (epf->event_ops && epf->event_ops->core_init)
+			epf->event_ops->core_init(epf);
+		mutex_unlock(&epf->lock);
+	}
+	mutex_unlock(&epc->list_lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_init_notify);
 
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 0c94cc1513bc..a06f3b4c8bee 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -18,7 +18,6 @@ struct pci_epf;
 enum pci_epc_interface_type;
 
 enum pci_notify_event {
-	CORE_INIT,
 	LINK_UP,
 };
 
@@ -72,6 +71,14 @@ struct pci_epf_ops {
 					struct config_group *group);
 };
 
+/**
+ * struct pci_epf_event_ops - Callbacks for capturing the EPC events
+ * @core_init: Callback for the EPC initialization complete event
+ */
+struct pci_epc_event_ops {
+	int (*core_init)(struct pci_epf *epf);
+};
+
 /**
  * struct pci_epf_driver - represents the PCI EPF driver
  * @probe: ops to perform when a new EPF device has been bound to the EPF driver
@@ -140,6 +147,7 @@ struct pci_epf_bar {
  * @is_vf: true - virtual function, false - physical function
  * @vfunction_num_map: bitmap to manage virtual function number
  * @pci_vepf: list of virtual endpoint functions associated with this function
+ * @event_ops: Callbacks for capturing the EPC events
  */
 struct pci_epf {
 	struct device		dev;
@@ -170,6 +178,7 @@ struct pci_epf {
 	unsigned int		is_vf;
 	unsigned long		vfunction_num_map;
 	struct list_head	pci_vepf;
+	const struct pci_epc_event_ops *event_ops;
 };
 
 /**
-- 
2.25.1

