Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080DA3A99C8
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 14:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhFPMCN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 08:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhFPMCK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jun 2021 08:02:10 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5218FC06175F
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 05:00:04 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id m2so1763917pgk.7
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 05:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nDCCmeJMQtzprUTNJPaEV26/JKcM/RuAlK0UO9dpDaw=;
        b=tOy1eq+e9UVCY4+voZO1PD4Gj2PIOqemKd5Jn+6KhiipXzL4rWtvbxIKXZnWrUzdiw
         rSbYJ8PbOIr+sKIW+lc90+kDqYg8Wcx6ImFvndEGsi9rdQyt+SAZ/48YNNhHAkfIUJgu
         qAZvavVINzXM3fECM+lrxL+TbEjVZpgYYCFwIr5ga672Dc8GYD2K340jBrLG/ugVbj8r
         8OOay1WaQrvANz2W5ZeNmVCr6qfgSwu+xrNlbR76uMWKpU+LRv5jfdbpxXpCTR7dEzdG
         5SKdfOnLxKqG58u9jHSFJv0BTnqO/CL5ow1j6Q97it4RLUYpdq8PirG6N2qLgJWfT6w4
         JQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nDCCmeJMQtzprUTNJPaEV26/JKcM/RuAlK0UO9dpDaw=;
        b=M4S7WhYiy6/osKGh68EAvyM47+A+ykjx8IA+phfALnna2oQ95bv82oDqtAlNOz5I55
         cEZod0wZc1g+7bxXRp234mfAdj1wF87dMLwxG0uGUyTluDuAPeMSYnIql1mdkgniKf/q
         1ASYNWZ64HX/ek9ycVlpgky18+qm03rPkpfojuR/cQWns5YsPMeyLpw+udNhTvZ9ZvGl
         hww7qhwwJjBlkipMHTa1Vwx0BsIrooHUzPMKC9N2Yy7BHYXjPMqAAA+I7e8RFMTribUT
         NZVi6uq0wRQBOYgDCipghOJU8/xISqI8fvR7HLOoB8RGqSnpszY0rv2PaPd75bWTjsqr
         CFSA==
X-Gm-Message-State: AOAM530cJLAzrtP1OrC9CWP1R2fW5alehIidN4hg+eUy8c5PGp0Ke1lJ
        +1W5utkFNCuLu5G0HjWmZ4d8
X-Google-Smtp-Source: ABdhPJxUjnwiBWsgK9hYwfgTV8C2Akip43japtBhBjCZ5Y3x87xjs3Sh/oWZQY/6m6djq5bgWLVa8Q==
X-Received: by 2002:a63:d57:: with SMTP id 23mr4704623pgn.392.1623844803681;
        Wed, 16 Jun 2021 05:00:03 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:280:c67a:95b5:d877:b175:798e])
        by smtp.gmail.com with ESMTPSA id m1sm2307646pjk.35.2021.06.16.04.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 05:00:03 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        smohanad@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/5] PCI: endpoint: Add D_STATE notifier support
Date:   Wed, 16 Jun 2021 17:29:12 +0530
Message-Id: <20210616115913.138778-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616115913.138778-1-manivannan.sadhasivam@linaro.org>
References: <20210616115913.138778-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to notify the EPF device about the Device State (D_STATE)
event received by the EPC device from the Root complex.

Usage:
======

EPC
---

```
static irqreturn_t pcie_ep_irq(int irq, void *data)
{
...
	case PCIE_EP_INT_D_STATE:
		dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) & 0x3;
		pci_epc_d_state_notify(epc, dstate);
		break;
...
}
```

EPF
---

```
static int pci_epf_notifier(struct notifier_block *nb, unsigned long val,
			    void *data)
{
...
	case D_STATE:
		dstate = data;
		if (dstate == PCIE_EP_D0)
			/* Handle D0 event */
		else if (dstate == PCIE_EP_D3)
			/* Handle D3 event */
		break;
...
}
```

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 18 ++++++++++++++++++
 include/linux/pci-epc.h             |  1 +
 include/linux/pci-epf.h             |  1 +
 3 files changed, 20 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 63fe90dbbba2..b4a7bb3caa97 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -710,6 +710,24 @@ void pci_epc_pme_notify(struct pci_epc *epc, void *data)
 }
 EXPORT_SYMBOL_GPL(pci_epc_pme_notify);
 
+/**
+ * pci_epc_d_state_notify() - Notify the EPF device that the EPC device has
+ *			      received the Device State event from Root complex
+ * @epc: the EPC device that received the Device State event
+ * @data: Data for the D_STATE notifier
+ *
+ * Invoke to notify the EPF device that the EPC device has received the Device
+ * State (D_STATE) event from the Root complex
+ */
+void pci_epc_d_state_notify(struct pci_epc *epc, void *data)
+{
+	if (!epc || IS_ERR(epc))
+		return;
+
+	atomic_notifier_call_chain(&epc->notifier, D_STATE, data);
+}
+EXPORT_SYMBOL_GPL(pci_epc_d_state_notify);
+
 /**
  * pci_epc_destroy() - destroy the EPC device
  * @epc: the EPC device that has to be destroyed
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 37dbcade1780..94c66fae8a88 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -206,6 +206,7 @@ void pci_epc_linkdown(struct pci_epc *epc);
 void pci_epc_init_notify(struct pci_epc *epc);
 void pci_epc_bme_notify(struct pci_epc *epc);
 void pci_epc_pme_notify(struct pci_epc *epc, void *data);
+void pci_epc_d_state_notify(struct pci_epc *epc, void *data);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 			enum pci_epc_interface_type type);
 int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index c162a73eb836..ca020c080431 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -23,6 +23,7 @@ enum pci_notify_event {
 	LINK_DOWN,
 	BME,
 	PME,
+	D_STATE,
 };
 
 enum pci_barno {
-- 
2.25.1

