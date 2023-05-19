Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281A8709A33
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 16:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjESOmt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 10:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjESOml (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 10:42:41 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10BD1AC
        for <linux-pci@vger.kernel.org>; Fri, 19 May 2023 07:42:36 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64384c6797eso2616007b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 19 May 2023 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684507356; x=1687099356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7wJX7ZlC+ZSECooOl9HFjuRleTmjPyDTRWr5SltKsA=;
        b=nKzXVHe6vXhx7rUMNB1kNR7Ho7aHBVta+MBE76d7oASLkopJlB/QHtEjSdTkjOzd7g
         Pm+H2fED/Py77RrEnPZqELKDCkCAfxZoX0YhDPnIQea1C7nEPc/oMtEYj9V2vwdfNAxc
         NUFmEnKO4iNiA9eTKDiEZ1BPsB2dbeziEkQCQUf0vr1YSeGIY6HuetLk6/0ydBSCxWyd
         5kVY2pJgUVn6O27dfQGRIYA+hjoZLZ53ZXxctU89EUbV6KiluJwanvcePe4nYTSz9xGX
         9zo+/3nEAqy/VoXt9rJQb2fyQmz8lXzc0cczzgrIxEeDFrorHCXLfLk/KtRAuH/fr1Dy
         0obw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684507356; x=1687099356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7wJX7ZlC+ZSECooOl9HFjuRleTmjPyDTRWr5SltKsA=;
        b=Xo5mRVh5zzfRRKyhZISgfYu9QzkilEnmDHVNB8ky1OR3qDHQJoVKJUOIjzTgz1ktJj
         Smzc94yjO+9V7LZxrvlKaSEJvzHTLyx1puN7zuRyEvwn3ToC50NppDqv0GXg0e9Dqyw4
         BUvT2AddGeLuR3T/kp0a+BUAUvT1eBm05epsYZ3vvdNwGSSpA2MNyoYX5F53L12YXUWO
         ioq9MwYeIAncWHZEH4dGG5Zvkzr+C+PQJelpuT+DBsL42S9ut3zFoyRV4Oy71k29XmEu
         R7OZB76uwUCkbAeQQAcrJUStJV38mxgh2u1kF2SR01N0KacxaxQCWCsQJYOPq11qOn9P
         N4uA==
X-Gm-Message-State: AC+VfDx6W1asOvaV/1soytRpazIPcMYFaGhcsTgv9U9zmDw20f/UwDHo
        38KEkxKaAKpi8U8lrqtCCar4
X-Google-Smtp-Source: ACHHUZ5TxT4TvFIDMfSlQpUHO0Brp9U3jl8ZkeffGS7KJ76dlQByjO1BiaQik0B6akQ6THS1ci34Lw==
X-Received: by 2002:a05:6a00:2e98:b0:64d:3e99:83a5 with SMTP id fd24-20020a056a002e9800b0064d3e9983a5mr1311335pfb.26.1684507356403;
        Fri, 19 May 2023 07:42:36 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.13])
        by smtp.gmail.com with ESMTPSA id v11-20020aa7808b000000b005d22639b577sm3089611pff.165.2023.05.19.07.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:42:35 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 4/7] PCI: endpoint: Add BME notifier support
Date:   Fri, 19 May 2023 20:12:12 +0530
Message-Id: <20230519144215.25167-5-manivannan.sadhasivam@linaro.org>
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
index 1ecbe2b1d3bd..ca8f838fa51f 100644
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

