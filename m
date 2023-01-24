Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F67C6791A9
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 08:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjAXHM7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 02:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjAXHM4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 02:12:56 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FF11BC2
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 23:12:42 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id k18so13876977pll.5
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 23:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtspVR08c2Hzxz4d1S9naljhmqqgR/iHq8R5vgVdVO8=;
        b=jLkKilHTzY/C2gsXwduuwbnZbxommKG4NDPVIPHJS2s8XV3xmC21LPWVZya5CgL+XE
         BB7Tt0eTbwzy0TWpJGBKvITSxZn7LozlbKEjzK7hX3hZkE9iiNrHTmU2TDkEo1z9CcxM
         ZL2llotCUra8/97oBsOoJNlLRGLBFVP6LRsIJxp7eFyapgP+WKTRz1h92P506qq8mPcj
         SaGFIFz/NiYdU5bramL0TmwIJGD1J+kLE/RglKXkZbZkIrhvn7Aft839Y5ZV57ZqE2d8
         m23KSjfN29rKbUUj/oacO1QuuCzwyIXMc6BcAKl3dGygF2uSAsg2XOByhzQNawYUirxM
         I0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtspVR08c2Hzxz4d1S9naljhmqqgR/iHq8R5vgVdVO8=;
        b=xwtSipVGgVF/ntKo7nWtZOrJBWZTEnVl9yw/Bh+cRW1YxgAMd02pZVP0gnzhRZEpw+
         JoLpYOryqSHHryqzWZxWYuUnkv1DRqshgW7zCPKG80m13qiSABa7wagJOA3JMWEmXBrt
         6d5Y6h4uylqfs2PBAbzVboZEKjgD5buMQriKD8yoEkDR50QJT32io/tvTyJvtAIpAGTd
         uNV3AjzteEDpZWym2le52JuemIlA76TIEIj07qLK/8huPTvhlM1FQcp8y31TYHWR6IpY
         LnWuLbO+LVo9i0Fm3pw3Weo3rdUsGYQtd+LwZmpV44y3bqQaPdLGbdELLZox/E34mIRX
         2DdA==
X-Gm-Message-State: AFqh2krRk+bYQi1oDGcOCUuu9zSFI+VsR4yYvuEfkXg0h7x2rhkM3nLk
        upHTDRD3AcMyLYkYxDJFhbpA
X-Google-Smtp-Source: AMrXdXvncgc8u3d7s7w1FyIptX9Hz6CmVryP1yMVLcJqb3q6xQ5aketll8gQxvgDGcmiwhoTiMQs6A==
X-Received: by 2002:a17:90a:c298:b0:229:b5e:2e03 with SMTP id f24-20020a17090ac29800b002290b5e2e03mr28940773pjt.32.1674544362064;
        Mon, 23 Jan 2023 23:12:42 -0800 (PST)
Received: from localhost.localdomain ([117.193.209.165])
        by smtp.gmail.com with ESMTPSA id 7-20020a17090a174700b00219220edf0dsm736041pjm.48.2023.01.23.23.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 23:12:41 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 4/5] PCI: endpoint: Use callback mechanism for passing events from EPC to EPF
Date:   Tue, 24 Jan 2023 12:41:57 +0530
Message-Id: <20230124071158.5503-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230124071158.5503-1-manivannan.sadhasivam@linaro.org>
References: <20230124071158.5503-1-manivannan.sadhasivam@linaro.org>
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

