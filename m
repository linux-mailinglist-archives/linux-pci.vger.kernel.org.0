Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E92971A136
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jun 2023 16:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbjFAO6R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 10:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbjFAO6G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 10:58:06 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937501AE
        for <linux-pci@vger.kernel.org>; Thu,  1 Jun 2023 07:57:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b01bd7093aso4741455ad.1
        for <linux-pci@vger.kernel.org>; Thu, 01 Jun 2023 07:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685631473; x=1688223473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhNik2H+uO+Q16HqIS1xj7FIQ3fy5k7mBkKyNDoBImY=;
        b=dgsHYUUfC1+pccoNZp6xxO+N3y6D2Bf7E/JuL9C9g4AtbhQDLX3jVytV5jbO7Ldhd5
         deA0waQzk2L1V/e1Hzmo8NRo5mvvzc/2XdLX0CS962t0EhmGS9Wc5C0cs2qQCg6655PV
         x/vO2ka2fyRMqPmy3hWbrK+k8+gT6uOyZAH5uDJaxq2hhJyeYp2UySnbe2/qi03jZGlI
         +Nd4RwFJXf3kqMTbvUPdxcmXB/mTqsQV/CuiLDcYg7ktqXtNVHcJVd7s+8O4rWDnDwR6
         OQ8bRL1j+5xyYwqikzwfQhBwDY+GF8M6WJg7ttUVMt9OU23nbBl9Uh6w8kmyiRiBcrls
         YB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631473; x=1688223473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhNik2H+uO+Q16HqIS1xj7FIQ3fy5k7mBkKyNDoBImY=;
        b=j74yi871FTai84eBfV/H5Gz4QykbmMOePMMtDCFhIDu5th5BBZLFq8opQJPwVaD8yS
         pHyaXT+M20yXdxghObcCOlrMzgPDcqqfvpSqR1SVHxMReKU/TadVT6yEZLpgavx+iZA/
         ISH+NKVlVDNlYC6wHnBzu8SsHOLuKrWSXrQIKHPGV1tIABJSEqRz1eu5h4Q9a1ame0mI
         r9je9V+0SXPImxuwfFa0w8i4WUonupFgjgViAZP7nBE8hQdvGBJ+nnhNBDdvx2pwGIz3
         B75WzMCJ6qrDbmCBFmv4ca0YagNCZ2nS5bc7i//EiuIzDEs3COLq2BWH3nm2Vxg6TG1T
         KYYw==
X-Gm-Message-State: AC+VfDy0SnvCdNpcKT5cZ3EMIZ1wLC6iyUk/Tk1xEkf/3ugNDAjJBxD7
        5RzySbappl1671bNWO5UiJe/
X-Google-Smtp-Source: ACHHUZ7UV+dcrB4tEVVxWfAIJ+mU72SNsaiLlYMV3bnaZr7BkfZwGGyqaYN+rRRkaUB2aD9wDLMp2A==
X-Received: by 2002:a17:902:c410:b0:1af:e999:a070 with SMTP id k16-20020a170902c41000b001afe999a070mr9189094plk.14.1685631473230;
        Thu, 01 Jun 2023 07:57:53 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b001b0603829a0sm3577826plg.199.2023.06.01.07.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:57:52 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 5/9] PCI: endpoint: Add linkdown notifier support
Date:   Thu,  1 Jun 2023 20:27:14 +0530
Message-Id: <20230601145718.12204-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
References: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to notify the EPF device about the linkdown event from the
EPC device.

Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 26 ++++++++++++++++++++++++++
 include/linux/pci-epc.h             |  1 +
 include/linux/pci-epf.h             |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 0cf602c83d4a..e0570b52698d 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -706,6 +706,32 @@ void pci_epc_linkup(struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(pci_epc_linkup);
 
+/**
+ * pci_epc_linkdown() - Notify the EPF device that EPC device has dropped the
+ *			connection with the Root Complex.
+ * @epc: the EPC device which has dropped the link with the host
+ *
+ * Invoke to Notify the EPF device that the EPC device has dropped the
+ * connection with the Root Complex.
+ */
+void pci_epc_linkdown(struct pci_epc *epc)
+{
+	struct pci_epf *epf;
+
+	if (!epc || IS_ERR(epc))
+		return;
+
+	mutex_lock(&epc->list_lock);
+	list_for_each_entry(epf, &epc->pci_epf, list) {
+		mutex_lock(&epf->lock);
+		if (epf->event_ops && epf->event_ops->link_down)
+			epf->event_ops->link_down(epf);
+		mutex_unlock(&epf->lock);
+	}
+	mutex_unlock(&epc->list_lock);
+}
+EXPORT_SYMBOL_GPL(pci_epc_linkdown);
+
 /**
  * pci_epc_init_notify() - Notify the EPF device that EPC device's core
  *			   initialization is completed.
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 301bb0e53707..63a6cc5e5282 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -203,6 +203,7 @@ void pci_epc_destroy(struct pci_epc *epc);
 int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 		    enum pci_epc_interface_type type);
 void pci_epc_linkup(struct pci_epc *epc);
+void pci_epc_linkdown(struct pci_epc *epc);
 void pci_epc_init_notify(struct pci_epc *epc);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 			enum pci_epc_interface_type type);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index bc613f0df7e3..f8e5a63d0c83 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -71,10 +71,12 @@ struct pci_epf_ops {
  * struct pci_epf_event_ops - Callbacks for capturing the EPC events
  * @core_init: Callback for the EPC initialization complete event
  * @link_up: Callback for the EPC link up event
+ * @link_down: Callback for the EPC link down event
  */
 struct pci_epc_event_ops {
 	int (*core_init)(struct pci_epf *epf);
 	int (*link_up)(struct pci_epf *epf);
+	int (*link_down)(struct pci_epf *epf);
 };
 
 /**
-- 
2.25.1

