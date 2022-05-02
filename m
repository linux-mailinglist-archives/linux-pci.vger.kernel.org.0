Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D36516AAE
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 08:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383435AbiEBGKM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 02:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383439AbiEBGKK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 02:10:10 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078B74F462
        for <linux-pci@vger.kernel.org>; Sun,  1 May 2022 23:06:40 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id j8so11703155pll.11
        for <linux-pci@vger.kernel.org>; Sun, 01 May 2022 23:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=emy+se/hKalbH2tp0a4mK8E86GGOMmeQZbEu2D153u4=;
        b=gmG8NgYNfGEjNCcuFO9JZOXXmkueQfPGdn69XdTXChZw7LgJKOCytt1QGrtVshbjlG
         7nxhD/YJXODxEck25e3j6+lr+C2PTvWL7owGdIiYQn8O7q9yszO1r4l0JZ4wuNDBDQgB
         7eQLbQgnu0HChXYnJUFjlN8iUPsDI0UJmIeaCSGk4z6mYNvI9xlS3TmjhM3faJcqlyrl
         S+GUvCXuJHi+SoVopgAwLQXR6SlVhDKZgAQkiaUVMu3jd0yibz/98Q4Qit/yuDSDNaGW
         mBxRECnt6Ftia7BPyHiJ+/JLl2bU2TcK2UIS3gYAy9vLLOuIZOrP6CVtBz11He7HCW02
         DiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=emy+se/hKalbH2tp0a4mK8E86GGOMmeQZbEu2D153u4=;
        b=XTfUkv1ZyhesyAqWEd7BBCc4ZFmqRE8VKvLmCiVUlf489PNeVddgApUr7DUKaOs249
         lMaGx00VsmmBBMlIpFoof1EvIKuAb8/RWDAfDV5f6ATALmV5n4B0lY/2lcQjgKqrqk+u
         h+DFO/HW9sFCr1Ks0uW+uXwJDnbx76SCia2DpeKkJlGyGDrASjcNmsWhhk2iE8blwCi7
         sJXAwn3GyTONOfVk57qxU9dTOUWxIFOi4Gp+wIrne1vqFjuiAROTCLuwgU3OvbipL1v0
         bQkPlRowlY2K31NjfcEzZB4UEncnnMR4/zU8r/kRllr48UJQOhNXxhp0xLCEGzzVGkt7
         36xw==
X-Gm-Message-State: AOAM532ciCOVNEQEhC8l/2TwbZuobJRjGmEF3hHhQUnU/fHqfdCeNABw
        /dvjj/isYkd4M1R2rp5Yg0m3
X-Google-Smtp-Source: ABdhPJxZpaVR+CBbIhn1WxJ9NylF/NJ9w8C24Qx49e19NaDRtUQ07QLsCjO6Q96FB4VDSjdCkTysqg==
X-Received: by 2002:a17:903:234d:b0:15d:4055:d7aa with SMTP id c13-20020a170903234d00b0015d4055d7aamr10196956plh.167.1651471600035;
        Sun, 01 May 2022 23:06:40 -0700 (PDT)
Received: from localhost.localdomain ([27.111.75.99])
        by smtp.gmail.com with ESMTPSA id h3-20020a62b403000000b0050dc7628181sm3933826pfn.91.2022.05.01.23.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 23:06:39 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, kw@linux.com,
        bhelgaas@google.com, robh@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5/8] PCI: endpoint: Add BME notifier support
Date:   Mon,  2 May 2022 11:36:08 +0530
Message-Id: <20220502060611.58987-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502060611.58987-1-manivannan.sadhasivam@linaro.org>
References: <20220502060611.58987-1-manivannan.sadhasivam@linaro.org>
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

Add support to notify the EPF device about the Bus Master Enable (BME)
event received by the EPC device from the Root complex.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 17 +++++++++++++++++
 include/linux/pci-epc.h             |  1 +
 include/linux/pci-epf.h             |  1 +
 3 files changed, 19 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 8401c2750c9e..6120d99bff73 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -731,6 +731,23 @@ void pci_epc_init_notify(struct pci_epc *epc)
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
+	if (!epc || IS_ERR(epc))
+		return;
+
+	atomic_notifier_call_chain(&epc->notifier, BME, NULL);
+}
+EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
+
 /**
  * pci_epc_destroy() - destroy the EPC device
  * @epc: the EPC device that has to be destroyed
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index d346ab9ae061..8454610df4c3 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -217,6 +217,7 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 void pci_epc_linkup(struct pci_epc *epc);
 void pci_epc_linkdown(struct pci_epc *epc);
 void pci_epc_init_notify(struct pci_epc *epc);
+void pci_epc_bme_notify(struct pci_epc *epc);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 			enum pci_epc_interface_type type);
 int pci_epc_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index b1fcd88d0b1f..e03c57129ed5 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -21,6 +21,7 @@ enum pci_notify_event {
 	CORE_INIT,
 	LINK_UP,
 	LINK_DOWN,
+	BME,
 };
 
 enum pci_barno {
-- 
2.25.1

