Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9EC6AE44C
	for <lists+linux-pci@lfdr.de>; Tue,  7 Mar 2023 16:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCGPR7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Mar 2023 10:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCGPRc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Mar 2023 10:17:32 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40FD498A2
        for <linux-pci@vger.kernel.org>; Tue,  7 Mar 2023 07:14:35 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id i3so14410393plg.6
        for <linux-pci@vger.kernel.org>; Tue, 07 Mar 2023 07:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678202075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CebAT6G7pMdHj4gkjeeBHR/+GUK4hl9hBpqAKTE774=;
        b=zyYTr4lb+xRvb6jYHLHpDUs5fW+RUV0GC00D8v+twpYwkjn5gauDWIpVnOqvXb1+t9
         YSqY8aLuzKFNUEpRbJltV8ohRDcvTMBfDAvY5Irw4aXnMSiaOpLd4wZ1wA5ZXv5y9xQv
         3l9xUKx2oVPoZSCrkCuYbh4uVM6gO0aQZbR4ral4uISQlZNAWXW04XzruEz2ZPnjAf37
         MAiwPb0PaFC+R5/VRYnp7Cs2K4OovLuV2FKcWg6ZrsE5lTEFgGsSTmoKIDVraxoGUsBD
         qMqDlEmBqQ6eK8Go/d3FvKvDKlJ/3rTekOhGUlysUiVYWZBDGh5mB/RGEOacK87GiPwd
         L53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678202075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CebAT6G7pMdHj4gkjeeBHR/+GUK4hl9hBpqAKTE774=;
        b=aQEMJ3AqM4uN6HNedkTbUs/kGVnb2Po90oewKwMJo42+KT+yAcHKBZZ4sQMTLeCApK
         sRGn7fljIagLGMqz5gWXcYgtSh4xJ5OXZCeq6rf092emQBu0O7lZXCOsSfh9+YmnwGTT
         hVkCwBvDJSEXbKRpheZRw5lE/2VmEOvfjCjC6rB3IBhqWi0KM0FdbC5CR6xWJrxsaj2y
         KDBJsdyIsv5JkZdgDZl4PN6WVcxcck82QF+gqa9VnML5cYrx6ipxlfFgK5zi3RJWkzcw
         EA4nu6aJW4oB3rP94L3Z+KJkt/0wfA6yhi0emiHdYgBY42b5ItQzyEtumPlZLrRPj4nK
         4YOQ==
X-Gm-Message-State: AO0yUKXg+HUAb+JqrQsgcR8NKBbg4FatI7auT+EYHPPfb/YUG59gTpZR
        iPlmDvcTbLWvnHhyBZSa9Ooj
X-Google-Smtp-Source: AK7set+p1vx95qAgPg51L803GQxGN8jwO3hK3IEMNMKfv1ZcqtJXtlGjwoiCcnamHQRPSOC8sG3vOQ==
X-Received: by 2002:a17:902:d583:b0:19e:8264:5623 with SMTP id k3-20020a170902d58300b0019e82645623mr15839218plh.64.1678202075318;
        Tue, 07 Mar 2023 07:14:35 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090340c800b0019c2cf12d15sm8549332pld.116.2023.03.07.07.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:14:34 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/7] PCI: endpoint: Add linkdown notifier support
Date:   Tue,  7 Mar 2023 20:44:12 +0530
Message-Id: <20230307151416.176595-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307151416.176595-1-manivannan.sadhasivam@linaro.org>
References: <20230307151416.176595-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to notify the EPF device about the linkdown event from the
EPC device.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 26 ++++++++++++++++++++++++++
 include/linux/pci-epc.h             |  1 +
 include/linux/pci-epf.h             |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 9440d9811eea..e3a6b5554c1c 100644
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

