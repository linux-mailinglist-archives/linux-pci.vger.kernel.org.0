Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15033709A30
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 16:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjESOmq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 10:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjESOmh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 10:42:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277DB1B5
        for <linux-pci@vger.kernel.org>; Fri, 19 May 2023 07:42:33 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d2a613ec4so1102103b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 19 May 2023 07:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684507352; x=1687099352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0Nj6xvTZCRiBBoVUykKLMC0GwPG51XjYBpupCLgLXc=;
        b=K0kt2N60Z5EDo3wlxaZ+oVBbfd+uUCkPvW1R1/lUWTEfqNhl4hXOQl+eW5E17/oMzS
         PCFqiVb9r7Wc8jfJPdYYoCrOrRd7N9A7gL8M8pCMZiEDZoEpViZrxMnnarTT8rdRG9C0
         OmqfRHLljypcQupS9qtAXGgsgSbvLrscESECEJW/Gp6ulvgJHgx8ET5l24XhuBMpV7eI
         W98QthDpRI7f4JQLIsbiEXclk3yXVSZo/klSfGgPXIs2ZLZU/vn2kJyQIHXxnX7WbaX5
         /9Uoqq3aavtqMySbigMN9X1fffeMCDoE3uIgzXL6TPNf46cmtyBMJFD0QKCLO6qiwH8c
         nlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684507352; x=1687099352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0Nj6xvTZCRiBBoVUykKLMC0GwPG51XjYBpupCLgLXc=;
        b=cLjcIy2OpdlqW/o8lINp4rYAa2gpl9v4HAlDyv3ANTpig+kbXFpr2yKixlY+Qo0ya6
         E/sG0clSry29SiJRoP82doSOZ5QfRIcq9COWRRAeawRRA6aOaMdsGg78DPLholVXbUd6
         qunK22MnR0VEi9EADUSMJjMsLdSm6D+QQOpm0zipnhkD53cWm8tL21ODZlwhtd0QEp0B
         Dhn4JEbGZ/afNGEuGvgta8Rqsso9PXnouJRswieyAv9hkIVTO33VHeNaqg0x4vQOQ3vi
         ef0UuTkH/DSmqMgCR9XZyfPyR3S3k2/vsDx4uiqE03qTMQSm0AsOTxiMIp2SxG1iWeJc
         Mvtg==
X-Gm-Message-State: AC+VfDwIvVxDc94thQMbAl7bTMR0qnKBzE7gypykpYpERqqZ9S2aqOAh
        j6NbhJ+8vBAFmSzo5OZUdkea
X-Google-Smtp-Source: ACHHUZ4sGOB3ClfNG/LbPnjH5sqnf/3PSsTpHnqi2ZgAMIWLobureM6us2sRu14OIoj/mkT/6Ldqvw==
X-Received: by 2002:a05:6a00:13a2:b0:64d:2487:5b20 with SMTP id t34-20020a056a0013a200b0064d24875b20mr3440157pfg.9.1684507352390;
        Fri, 19 May 2023 07:42:32 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.13])
        by smtp.gmail.com with ESMTPSA id v11-20020aa7808b000000b005d22639b577sm3089611pff.165.2023.05.19.07.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:42:32 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 3/7] PCI: endpoint: Add linkdown notifier support
Date:   Fri, 19 May 2023 20:12:11 +0530
Message-Id: <20230519144215.25167-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519144215.25167-1-manivannan.sadhasivam@linaro.org>
References: <20230519144215.25167-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 46c9a5c3ca14..1ecbe2b1d3bd 100644
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

