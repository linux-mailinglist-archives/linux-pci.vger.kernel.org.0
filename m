Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13576AE451
	for <lists+linux-pci@lfdr.de>; Tue,  7 Mar 2023 16:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjCGPSC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Mar 2023 10:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjCGPRe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Mar 2023 10:17:34 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56787B985
        for <linux-pci@vger.kernel.org>; Tue,  7 Mar 2023 07:14:39 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so16852745pjb.1
        for <linux-pci@vger.kernel.org>; Tue, 07 Mar 2023 07:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678202079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJgDTGPG3O7w69/b8j6+Tmk/A5SbbomMgk7rRHGZCSE=;
        b=LAjfp0U2z+jXxcfIR/Nj2wDXduY4sI+Oe5o+54zzEHJnLV6jScQA4bJT+nabmxRY1Y
         y8ZR1AJ+jwk2s8DwluK3cFXzZQ52lHJYomrKTE9wvZ6bL36kZOOjNE4qbZxZOpwcu69z
         iVBLx/D2NWYr9nCQvTB564eKWLhThhiVzI3PGEqmtIfhB3OUvscR5hVu+CO3muQfYfSs
         GsZ88UvRJN9sqo/qcgktAVk0Sca/9PNzqzljVxwLWsSc51L8xn7Kg/3sDys9gHjjxvCg
         2qb8JThxlJuELD5JLVdBKTCevDIyLas174ifB+/Pln7z+BnXVfarYFSPDFdLwLAtNxZm
         o8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678202079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJgDTGPG3O7w69/b8j6+Tmk/A5SbbomMgk7rRHGZCSE=;
        b=vAkho4/jPyygOxSnPVov1fFXZg70LAYW2hV6FvVyB8Wa/W3/FLRkIWGMNRgtJR/mrD
         YHA4IycL0cK22rYcvV75HVV6igeDwz8WFa3vcZr8oqKGtBG9AnYzl4R0/OBXIsnMCnJb
         rZgnAu7FfFTKSLtrtlvOEPqoG5RA1sGr0SXjz8vvxyFOvw8yS2NvXtMFt0tlSSM86HG7
         ya5Tfge0Iid0iZ1spQQ6L+NUEtP8+NakliFkqURnZZut6p5zbqoo/jilMLbEXHfqogYA
         QuGeY7nHflketDzyfTajl5OW3A7b2OEtOki2koJItf+UDlIUerf4cDW2VmB8aa57WuvU
         ql1g==
X-Gm-Message-State: AO0yUKW/f0K4iSJlGVewRXtmCfIBoEOIsPx6vbN6FV1vcgd5zGEcAq7Q
        Nrv63vU9Gb2rIQRMQW3ed/IX
X-Google-Smtp-Source: AK7set8BTFWMgdktfp+AI0oS4VgdGclVXPntu04JDDKvtaMSynhmUVIgJeNmGWU/OkuljeqxCANHtw==
X-Received: by 2002:a17:902:760d:b0:19c:e6c8:db16 with SMTP id k13-20020a170902760d00b0019ce6c8db16mr12760511pll.27.1678202079374;
        Tue, 07 Mar 2023 07:14:39 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090340c800b0019c2cf12d15sm8549332pld.116.2023.03.07.07.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:14:38 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 4/7] PCI: endpoint: Add BME notifier support
Date:   Tue,  7 Mar 2023 20:44:13 +0530
Message-Id: <20230307151416.176595-5-manivannan.sadhasivam@linaro.org>
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

Add support to notify the EPF device about the Bus Master Enable (BME)
event received by the EPC device from the Root complex.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 26 ++++++++++++++++++++++++++
 include/linux/pci-epc.h             |  1 +
 include/linux/pci-epf.h             |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index e3a6b5554c1c..11bd873a7997 100644
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

