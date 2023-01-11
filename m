Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F65665A90
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 12:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjAKLo1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 06:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbjAKLmk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 06:42:40 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2AA1AA0F
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 03:41:32 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso16828558pjo.3
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 03:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtspVR08c2Hzxz4d1S9naljhmqqgR/iHq8R5vgVdVO8=;
        b=BmCUr8xANyYLZih9JbA/unTaGgYJvNd65uoCjO9Jag5rfVgVoLxKCos6Lh3ASfL/Ph
         q2T6gg2lPhM+JfUoSA8H+mQ1BIhJMLUT/fLFs4FHKaJyNTBDK5uPC0iOPNy61/JyLxiL
         K7Lq821g/WollalKKe/N1m0kdTUmLxla3LbhGh2LMwAcF9X7ZOR0d7yr2DVbD9llE2MV
         20Aqe/t8N0I/pBHhDc4OihxLJQoVfZGnr9TCb8/VSyMNzdxMFmOkmCCuTfossncA94tX
         DNMMOY5rEL+3htAuHLe0U9V1xcJtt0U1FW6rAvKXZciyr679EnXsyQHVK5je8td7anoS
         f8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtspVR08c2Hzxz4d1S9naljhmqqgR/iHq8R5vgVdVO8=;
        b=e+aGuOQW1iBBxXtP1MB3uPXqhosLjDQHBdZTDSdU5w0VJNYzjZbwOhZQfT+kmkPJ9v
         JTGF5KPQtt4f8DKu/fPUItbL6ZMPxpM82x8Cw3HIA2/lALBlET2JtKVyF59RwcTPiG77
         5rffS071jKHJcYzqQowUMGyKjhL1i2Hr6oGkq2HLGKoTmUpupZOmJhDXfYqKCcgSoBfb
         ePH4XlA275+qJwTdMVbXA1u3mPz1B5kl3VuStoObb4BUAqbYQLqQ6L28LSe3tJB2L25V
         hzaWINzJdQWZP49FjngCfoOzCLAGKvrstmS+WslBVVVFolIsWqDiUTR3nWS09VpXN/2K
         rySA==
X-Gm-Message-State: AFqh2kpzq2TREUsqyO1BEI0pRtGw5WmWvJssTE131yQVrwVi0QvHyCU4
        bbZ4g7XXi7G3B6/8KRJ5yR0A
X-Google-Smtp-Source: AMrXdXu04Sw8mjlc1djrE3RsjrQnWk+k+Fg+8nTg9e3RRniYkbqdsYQa3ZtuDf/mkV3Fi6kgwSysKw==
X-Received: by 2002:a17:902:6b89:b0:18f:6cb:1730 with SMTP id p9-20020a1709026b8900b0018f06cb1730mr70863669plk.26.1673437291848;
        Wed, 11 Jan 2023 03:41:31 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.1])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e5ce00b0018958a913a2sm9942688plf.223.2023.01.11.03.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 03:41:30 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND v4 4/5] PCI: endpoint: Use callback mechanism for passing events from EPC to EPF
Date:   Wed, 11 Jan 2023 17:10:58 +0530
Message-Id: <20230111114059.6553-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230111114059.6553-1-manivannan.sadhasivam@linaro.org>
References: <20230111114059.6553-1-manivannan.sadhasivam@linaro.org>
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
Acked-by: Kishon Vijay Abraham I <kishon@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++++++-------
 drivers/pci/endpoint/pci-epc-core.c           | 11 ++++++++++-
 include/linux/pci-epf.h                       | 11 ++++++++++-
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 55283d2379a6..2fe161747e51 100644
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
@@ -1010,6 +1007,8 @@ static int pci_epf_test_probe(struct pci_epf *epf)
 
 	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
 
+	epf->event_ops = &pci_epf_test_event_ops;
+
 	epf_set_drvdata(epf, epf_test);
 	return 0;
 }
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 2c023db8f51c..7cb9587c6548 100644
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
index 009a07147c61..fa629c191f00 100644
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
@@ -139,6 +146,7 @@ struct pci_epf_bar {
  * @is_vf: true - virtual function, false - physical function
  * @vfunction_num_map: bitmap to manage virtual function number
  * @pci_vepf: list of virtual endpoint functions associated with this function
+ * @event_ops: Callbacks for capturing the EPC events
  */
 struct pci_epf {
 	struct device		dev;
@@ -168,6 +176,7 @@ struct pci_epf {
 	unsigned int		is_vf;
 	unsigned long		vfunction_num_map;
 	struct list_head	pci_vepf;
+	const struct pci_epc_event_ops *event_ops;
 };
 
 /**
-- 
2.25.1

