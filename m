Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA143A8073
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 15:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhFONka (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 09:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhFONjY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jun 2021 09:39:24 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639D1C0617AF
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 06:37:15 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g4so11827486pjk.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 06:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BAFuvMVTI8ErK40EaLynbxPtz/61ySZ5UuelaAMUdxI=;
        b=GbD/lo+6pXWXlwjbLn9pyTbB5AaspJgIq34FPWtuwYm4nhGIUB23LWbGE9QHb9NlGf
         wx0GhWvRMvk/gcSuYCPxVjn1HPeoNHZuLpfAYaW/nEJ2XDEBnCHhoO/zZ50f0X0k6vew
         l5yCic7H/oKEN/lU0dMohimZD4S460ff5PLOij5Qwlxw3xmKjF/TdM0WZPTi9psBATgp
         HJWC3DoANi1MNDfCTR4i9bRZe9GJD2aJJJDvUQH7uQfVy3SEPDNBWYLIa3xdGPGVExMh
         ARc4miF1vKbqhR8U6k01C9aA2apa5PE5ozGmEpEhTgEonqWBLkitrviYzozungtYybVn
         16MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BAFuvMVTI8ErK40EaLynbxPtz/61ySZ5UuelaAMUdxI=;
        b=Tzq6LTvjuH7TD22WqM5x/7/EBcNBS234Df6q32fe6bj6QbYPK41ulvM1MCJIH6NLbF
         kbT56k/Km4mXDE549xITLK1+4U2Vc5AAqdEd48+w6ibgKxPDqBVkMrqVlGMNugNJ0qjb
         FjayAI5cS7sE/TSjlcUgV6zlG3GP1KL+CWBRPvTh6WPEok6QgryOx9vKNQZwXUmpp8+8
         vVW9dVzlHfNGZD2DOZcuJP5dlPKbbkvxayOg4RTzCA9dfkEJ+rxx2f7NtuEmA7jcaa2z
         55FYp6tNd0aGPOFC1JYQkr7+h001WmrMmPjOH5+UiDYYZvKwSjmFw/XnloFqojSUuIav
         JLrQ==
X-Gm-Message-State: AOAM531nawOSvZBuhF4PjIKV5O3ztrLZBnHHotoVpEG0jHV4PaF5sU56
        dGaoGhDnjIq6Vp2uabVb1vB1
X-Google-Smtp-Source: ABdhPJwoqwjSryoH/57hb8eBeT2IuD5kPN8qctWYRDy6V7ViKbT7qRe3IedaTW6gB8+tiDGuu3DQxw==
X-Received: by 2002:a17:90a:1fc9:: with SMTP id z9mr2673055pjz.234.1623764234735;
        Tue, 15 Jun 2021 06:37:14 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:85:d63b:22d3:eb6:40c6:5ead])
        by smtp.gmail.com with ESMTPSA id c207sm15522136pfb.86.2021.06.15.06.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 06:37:14 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        smohanad@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] PCI: endpoint: Add custom notifier support
Date:   Tue, 15 Jun 2021 19:07:04 +0530
Message-Id: <20210615133704.88169-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for passing the custom notifications between the endpoint
controller and the function driver. This helps in passing the
notifications that are more specific to the controller and corresponding
function driver. The opaque `data` arugument in pci_epc_custom_notify()
function can be used to carry the event specific data that helps in
differentiating the events.

For instance, the Qcom EPC device generates specific events such as
MHI_A7, BME, DSTATE_CHANGE, PM_TURNOFF etc... These events needs to be
passed to the function driver for proper handling. Hence, this custom
notifier can be used to pass these events.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 19 +++++++++++++++++++
 include/linux/pci-epc.h             |  1 +
 include/linux/pci-epf.h             |  1 +
 3 files changed, 21 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index adec9bee72cf..86b6934c6297 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -658,6 +658,25 @@ void pci_epc_init_notify(struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(pci_epc_init_notify);
 
+/**
+ * pci_epc_custom_notify() - Notify the EPF device about the custom events
+ *			     in the EPC device
+ * @epc: EPC device that generates the custom notification
+ * @data: Data for the custom notifier
+ *
+ * Invoke to notify the EPF device about the custom events in the EPC device.
+ * This notifier can be used to pass the EPC specific custom events that are
+ * shared with the EPF device.
+ */
+void pci_epc_custom_notify(struct pci_epc *epc, void *data)
+{
+	if (!epc || IS_ERR(epc))
+		return;
+
+	atomic_notifier_call_chain(&epc->notifier, CUSTOM, data);
+}
+EXPORT_SYMBOL_GPL(pci_epc_custom_notify);
+
 /**
  * pci_epc_destroy() - destroy the EPC device
  * @epc: the EPC device that has to be destroyed
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index b82c9b100e97..13140fdbcdf6 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -203,6 +203,7 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 		    enum pci_epc_interface_type type);
 void pci_epc_linkup(struct pci_epc *epc);
 void pci_epc_init_notify(struct pci_epc *epc);
+void pci_epc_custom_notify(struct pci_epc *epc, void *data);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 			enum pci_epc_interface_type type);
 int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 6833e2160ef1..8d740c5cf0e3 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -20,6 +20,7 @@ enum pci_epc_interface_type;
 enum pci_notify_event {
 	CORE_INIT,
 	LINK_UP,
+	CUSTOM,
 };
 
 enum pci_barno {
-- 
2.25.1

