Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9491658FA35
	for <lists+linux-pci@lfdr.de>; Thu, 11 Aug 2022 11:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiHKJnZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Aug 2022 05:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbiHKJnU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 05:43:20 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A15A81685
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 02:43:17 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso4806598pjq.4
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 02:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=k56CFyy5q/tLEdDa0AaNeHTf8E8dmcjqwpdigPl2beI=;
        b=nYhxQ7ANk4AWRoCB8jzIH9ZSlpstq2dnKXa/l6fhzvMZMZDTwkFHFBixe1fIqQ85vO
         iPECz1eMOMgDFVgb/2saEnVkaOwv4Qazm4qE0kaOpkbkfxeIRdUMQaLgfkn/gs9tLqyU
         DNIqKF0xH4Sz42q3L2h0/sd3NBT0BG8WalPZKvCC/1/PwJjKNgJOF+oHtYc9HI+rrvrT
         L/JU35VXhDy/vvvQS5uqs9INRQw791vA3sSKNoQB9zhZuGr07tDCYp/8HqZkjoSl2k+0
         0eAsUG3yy5c75sAlTrbCb1HwT2AkHvESOuG4o3V94NZ+zTvxhGv2aFFzDjz03yfX+zFM
         siUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=k56CFyy5q/tLEdDa0AaNeHTf8E8dmcjqwpdigPl2beI=;
        b=ijlyvVRr48xdXNoXMtyz+bQJAbUDLqkDKNwcY1dF2GS4dsWpPSwyA58fNz7S0a5uW0
         YS3wVzF7ZJau24EeEDkrFp7aspOJXV2N4g8sYbgDP00D1r0Kde/UCK6C6CtqNYqbLY0N
         yP6cZLhIXSJcgFMcYSfpJM07VrGR9JZ7fd0lFesreTtVGlEPFtHGXu6JCtOVTRRmvzi6
         jOLftoZyH56uiHUb3GogfrKqKCP0YiS4PXLfPLezgiHOuCPfp9qBAcXTU0NYg2amdBbj
         RaCRs+fN7Rt8PhxLY/P0Z0PGS0u540s3MY2tMv+v9lRPyNtb3V4antBNvVNXKqX4ABod
         6jBQ==
X-Gm-Message-State: ACgBeo0YZ+getIoKHY9D2CxrgJ+bEMtIjEunt1AIPkgKVCByuGWMQwyY
        deUWpnFNWhAqYJpBVZRdab6N
X-Google-Smtp-Source: AA6agR5tKVwsjMFBxrIELk3vEUMRLTH0iKIhFw/yTCr20+HlexLLyHVtt89b63geJ1+8Es3yXKKT2w==
X-Received: by 2002:a17:90a:d789:b0:1f5:1c76:24d6 with SMTP id z9-20020a17090ad78900b001f51c7624d6mr7942691pju.188.1660210996830;
        Thu, 11 Aug 2022 02:43:16 -0700 (PDT)
Received: from localhost.localdomain ([59.92.103.103])
        by smtp.gmail.com with ESMTPSA id s5-20020a625e05000000b0052e6d5ee183sm3553931pfb.129.2022.08.11.02.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 02:43:16 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     kw@linux.com, robh@kernel.org, vidyas@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] PCI: endpoint: Use callback mechanism for passing events from EPC to EPF
Date:   Thu, 11 Aug 2022 15:12:36 +0530
Message-Id: <20220811094237.77632-2-manivannan.sadhasivam@linaro.org>
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
 drivers/pci/endpoint/pci-epc-core.c           |  7 ++++++-
 include/linux/pci-epf.h                       | 11 ++++++++++-
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index d917a9d2be09..069943b57029 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -731,20 +731,17 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
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
@@ -915,6 +912,8 @@ static int pci_epf_test_probe(struct pci_epf *epf, const struct pci_epf_device_i
 
 	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
 
+	epf->event_ops = &pci_epf_test_event_ops;
+
 	epf_set_drvdata(epf, epf_test);
 	return 0;
 }
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 3bc9273d0a08..805f3d64f93b 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -707,10 +707,15 @@ EXPORT_SYMBOL_GPL(pci_epc_linkup);
  */
 void pci_epc_init_notify(struct pci_epc *epc)
 {
+	struct pci_epf *epf;
+
 	if (!epc || IS_ERR(epc))
 		return;
 
-	atomic_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
+	list_for_each_entry(epf, &epc->pci_epf, list) {
+		if (epf->event_ops->core_init)
+			epf->event_ops->core_init(epf);
+	}
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

