Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA97371A140
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jun 2023 16:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbjFAO6T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 10:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbjFAO6H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 10:58:07 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2714E69
        for <linux-pci@vger.kernel.org>; Thu,  1 Jun 2023 07:57:56 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b02d0942caso4140045ad.1
        for <linux-pci@vger.kernel.org>; Thu, 01 Jun 2023 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685631476; x=1688223476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYZvtGezswvgwNKpdFwjsrVB2tlNlkIcg9dibR8Jyd4=;
        b=j5mIwVNrkXB9e7PwH734RzlKBbt7G/OPSrTpfn+YG5/gW3gE8LQlxcexz/pWQkJDGW
         dd5UZgfyiqYh+j6mJ2q1oIfBlxZkbfA6S+rL1yrAyyye1r50ztVeDGyKcj5b7fg7yRUT
         ZBLlj2dF/dl8jtxHXJGUTfQyn5R/VrYw4UkdbHf+LEcgYNAfpIZkghccJJ4S4r7xPoTA
         5nCft0CkjHflVSQjhaob+lnN/89X9SLro9rKDuDVJE82voOwD51IFzzNN2U2b0HvxYlY
         ecGsLyrNSONOkDcyPLJC39qPptYwA4nEuAcBIUAAC1XiOeOhV5K373fGmrp23FEkxYnO
         f3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631476; x=1688223476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYZvtGezswvgwNKpdFwjsrVB2tlNlkIcg9dibR8Jyd4=;
        b=dOW5rQMl8GXoROwurak30GvwS8P9VDquUY9KDRFT6u8/L0Bo/vsNsOnMuFbHVU7I6v
         DkhfhjEYr0iGFtGZydA1Ls38SXc4vtnmFoFkPvRvVZuHltweTQ+m0JlIHBBUv17+ckT9
         oc1EkoOjCDg9nxrDM4a5PEGq9tlE7Ohmj81g/5aCfs5WRc4aEiOYy/U9hy6zeACEJxSq
         taptFkjDSJWoC6jYKsg4Iu1E4uWnVmx6KuAQbsBPEinmFgGcAt1NYU2xQp4B9VmULFRU
         d7VyDT6bknRaehjU4jmy8c86OIxLG7NvJtYLr3soleeyS3O0jyuLoyLlEQnmsP1ttMAY
         CFRQ==
X-Gm-Message-State: AC+VfDz+BLQOSz1/fxtyaYcFXHUDg7m5dLDhljInYsnfgTM3IEwHeAzP
        v/8GSl2zPu0q9SmpTJv8hfnn
X-Google-Smtp-Source: ACHHUZ58FyMJDryIcb5nwFxt0s7kS/5t3dBe6IT12VBCROlTmdztAu4R2HwmIgck1NU57nX9v2IETA==
X-Received: by 2002:a17:902:7049:b0:1b0:34c6:3be2 with SMTP id h9-20020a170902704900b001b034c63be2mr6474782plt.1.1685631476098;
        Thu, 01 Jun 2023 07:57:56 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b001b0603829a0sm3577826plg.199.2023.06.01.07.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:57:55 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 6/9] PCI: endpoint: Add BME notifier support
Date:   Thu,  1 Jun 2023 20:27:15 +0530
Message-Id: <20230601145718.12204-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
References: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to notify the EPF device about the Bus Master Enable (BME)
event received by the EPC device from the Root complex.

Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 26 ++++++++++++++++++++++++++
 include/linux/pci-epc.h             |  1 +
 include/linux/pci-epf.h             |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index e0570b52698d..6c54fa5684d2 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -758,6 +758,32 @@ void pci_epc_init_notify(struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(pci_epc_init_notify);
 
+/**
+ * pci_epc_bme_notify() - Notify the EPF device that the EPC device has received
+ *			  the BME event from the Root complex
+ * @epc: the EPC device that received the BME event
+ *
+ * Invoke to Notify the EPF device that the EPC device has received the Bus
+ * Master Enable (BME) event from the Root complex
+ */
+void pci_epc_bme_notify(struct pci_epc *epc)
+{
+	struct pci_epf *epf;
+
+	if (!epc || IS_ERR(epc))
+		return;
+
+	mutex_lock(&epc->list_lock);
+	list_for_each_entry(epf, &epc->pci_epf, list) {
+		mutex_lock(&epf->lock);
+		if (epf->event_ops && epf->event_ops->bme)
+			epf->event_ops->bme(epf);
+		mutex_unlock(&epf->lock);
+	}
+	mutex_unlock(&epc->list_lock);
+}
+EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
+
 /**
  * pci_epc_destroy() - destroy the EPC device
  * @epc: the EPC device that has to be destroyed
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 63a6cc5e5282..5cb694031072 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -205,6 +205,7 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 void pci_epc_linkup(struct pci_epc *epc);
 void pci_epc_linkdown(struct pci_epc *epc);
 void pci_epc_init_notify(struct pci_epc *epc);
+void pci_epc_bme_notify(struct pci_epc *epc);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 			enum pci_epc_interface_type type);
 int pci_epc_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index f8e5a63d0c83..f34b3b32a0e7 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -72,11 +72,13 @@ struct pci_epf_ops {
  * @core_init: Callback for the EPC initialization complete event
  * @link_up: Callback for the EPC link up event
  * @link_down: Callback for the EPC link down event
+ * @bme: Callback for the EPC BME (Bus Master Enable) event
  */
 struct pci_epc_event_ops {
 	int (*core_init)(struct pci_epf *epf);
 	int (*link_up)(struct pci_epf *epf);
 	int (*link_down)(struct pci_epf *epf);
+	int (*bme)(struct pci_epf *epf);
 };
 
 /**
-- 
2.25.1

