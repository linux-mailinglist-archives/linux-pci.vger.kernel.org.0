Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA287200AF
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 13:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbjFBLtG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 07:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbjFBLtB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 07:49:01 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F7910CA
        for <linux-pci@vger.kernel.org>; Fri,  2 Jun 2023 04:48:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96fab30d1e1so427262266b.0
        for <linux-pci@vger.kernel.org>; Fri, 02 Jun 2023 04:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685706511; x=1688298511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zqb+azKNXB55HXMybpmBlfsJ54xPwbKSsj/GKkm5OMs=;
        b=CmDuMRPYvAeuG4xG1voNSkDADQ4mSy35RnYW8mibureiXJUAdvu5Cy5191oz2MB2Xp
         A+9L6ziZqxZpLbFEbwsHaej1rbDIc5r5HYpnzHHKr6u12Hw/xA4Li7k6SKBdpmJ9KqED
         ADJ3khYZIhGj5zBvTrS8F8v8yI0aaCmrMc6GT8J6qKfS0hZsWhsg172TaXBoUnjDsweA
         Ct3IgNC2SBXX2B3WJ4AlFBCisJfI1TNDORzN7qRmYX/zel88Kz6KRH7V80ETyy443chQ
         9YathxSaJn3eQn+nsQ2BPKRTZk0WT3A1pSmlYTiPvQerDsLUY0cbAlhB6FE7ANQfrnXZ
         lcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685706511; x=1688298511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zqb+azKNXB55HXMybpmBlfsJ54xPwbKSsj/GKkm5OMs=;
        b=Y0EMmlHdUHJxxXGpsaaQV/pLBzK1U7fU220XvKouIQsEEXPBVFGLdprSXDIxtN9dKg
         Ny/Fup7AmFbyg8xuseDdneklH++9NYo9IoQQxZY9ODrDFh6LkacHMq4kH8K9xDZzGAYK
         +qec6Dze+lluMWIqJpICA8SpKZL9h3PpYZ+WWSL1LMTf9BJyrJWHXb5bsYI0CQRx/GFv
         4D5jnSEAF36EQrjvk1DYlH+q5NJwZ1Bu3mT3QvHGEFPa7YK278nN+N+NQsKOFGSJCmUU
         dgEe6LEzCcVk91itPqcKB2V0jK5O/P0eepsln/XqfL194et+jawQuG8gFWZs7INZDxHc
         GYDw==
X-Gm-Message-State: AC+VfDyVIn06qZ71RGh8G7G7daN3SfuPSPQhaYk00FTV5nk0+rwbz6en
        H+fdGj4jEJ7ss6pYP5me877T
X-Google-Smtp-Source: ACHHUZ4dplUnJ2Tud7HGQSzoROiGmmBYfraoLDoPBVt48ClU40rqY8euFPInRMUXM/jWwRSenMceZw==
X-Received: by 2002:a17:906:9756:b0:966:1bf2:2af5 with SMTP id o22-20020a170906975600b009661bf22af5mr4455612ejy.22.1685706511417;
        Fri, 02 Jun 2023 04:48:31 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.79])
        by smtp.gmail.com with ESMTPSA id qu25-20020a170907111900b00974530bb44dsm658924ejb.183.2023.06.02.04.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 04:48:31 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dlemoal@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 4/9] PCI: endpoint: Add linkdown notifier support
Date:   Fri,  2 Jun 2023 17:17:51 +0530
Message-Id: <20230602114756.36586-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
References: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to notify the EPF device about the linkdown event from the
EPC device.

Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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

