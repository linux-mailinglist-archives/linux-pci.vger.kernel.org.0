Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5864A3A99C5
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 14:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhFPMCG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 08:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbhFPMCF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jun 2021 08:02:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB22C0617A6
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 04:59:58 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k22-20020a17090aef16b0290163512accedso3543918pjz.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 04:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=npWguGF+sv+TNIJk7vE0aKrt2xI11hFGoDM/Lo6gWeI=;
        b=ts5HvtOb7Wrv0uits8CEe7ZZvcqKznlaG53XWIDeJR6mx67o9nm07NJMq6mpKkNVsz
         w5Hy51TD80CTlRo4fznDWh98W6g+pYqeSrd0g6nEQ/v3jm6duyK8G1IP4TL4lxfGIMz0
         COOeUrHnts0K+d56B28v9c3z3cVUx/b3fMGZ1fZyjpKkpp24+4/WeAT8mPwSgwpqx2Aa
         ozu7XXKBzm+hjrhXDFrD7m280NQJz2TbSNzgE3WQ0PvEX5gzbEysnjNAuZpBMF8yoIji
         HScaeMw6lLujqkAurwkA0uQUII5c9TPPzCwtBgtks9zr6RIOVuAHd/gN5jlRZIijJDjW
         NDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=npWguGF+sv+TNIJk7vE0aKrt2xI11hFGoDM/Lo6gWeI=;
        b=JwCev7cEzOMaT6CHuiRDAJEvHFVYZ1fEBaXBzywOfca3EkS8GMLBySxOwv0GRaytWR
         bloyyhKlVcVNAYWVhzVEMXgnclMLOXMZ1rh43wqjRAZrBHX5x9FFYNnidKXDt/1aPUOg
         SjKt4pq4nv75oy5NJgZlQysVBd3pwvGzxcLM+2Yr52GRFdWpwss0iFQMKO+XHw0Go+fx
         2iLHofwk0GcO7hisBrCKBhgavf9gKFgAjZCa1jik2/E4JjQV28NrFkuLyfXsMkk51ogD
         v41wzb293VJX/55mar9Ocr4FaNqlvjUEVgXiYPHyEI6EZLm/AYRREx42V0VXtr6EaFRr
         fusg==
X-Gm-Message-State: AOAM533PUX+LDYGGb99SYPW5aevylWnkK4rn/Hq6o9htkZ62wpBzuojf
        QD8RShiwN/eGoqP9kFKG0Ko9
X-Google-Smtp-Source: ABdhPJxL1ftDa9WZT0O9uDcCCoIo532JhmRmV0jNwTjlDC4M9pKhygqcovw0cQ79+JfGzlhxLXNO1g==
X-Received: by 2002:a17:90a:e2c6:: with SMTP id fr6mr10415047pjb.198.1623844798144;
        Wed, 16 Jun 2021 04:59:58 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:280:c67a:95b5:d877:b175:798e])
        by smtp.gmail.com with ESMTPSA id m1sm2307646pjk.35.2021.06.16.04.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 04:59:57 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        smohanad@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/5] PCI: endpoint: Add PME notifier support
Date:   Wed, 16 Jun 2021 17:29:11 +0530
Message-Id: <20210616115913.138778-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616115913.138778-1-manivannan.sadhasivam@linaro.org>
References: <20210616115913.138778-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to notify the EPF device about the Power Management Event
(PME) received by the EPC device from the Root complex.

Usage:
======

EPC
---

```
static irqreturn_t pcie_ep_irq(int irq, void *data)
{
...
	case PCIE_EP_INT_PM_TURNOFF:
		pci_epc_pme_notify(epc, PCIE_EP_PM_TURNOFF);
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
	case PME:
		pm_state = data;
		if (pm_state == PCIE_EP_PM_TURNOFF)
			/* Handle PM Turnoff event */
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
index 7e42a83a4877..63fe90dbbba2 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -692,6 +692,24 @@ void pci_epc_bme_notify(struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
 
+/**
+ * pci_epc_pme_notify() - Notify the EPF device that the EPC device has received
+ *			  the PME from the Root complex
+ * @epc: the EPC device that received the PME
+ * @data: Data for the PME notifier
+ *
+ * Invoke to Notify the EPF device that the EPC device has received the Power
+ * Management Event (PME) from the Root complex
+ */
+void pci_epc_pme_notify(struct pci_epc *epc, void *data)
+{
+	if (!epc || IS_ERR(epc))
+		return;
+
+	atomic_notifier_call_chain(&epc->notifier, PME, data);
+}
+EXPORT_SYMBOL_GPL(pci_epc_pme_notify);
+
 /**
  * pci_epc_destroy() - destroy the EPC device
  * @epc: the EPC device that has to be destroyed
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 6c2cff33f670..37dbcade1780 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -205,6 +205,7 @@ void pci_epc_linkup(struct pci_epc *epc);
 void pci_epc_linkdown(struct pci_epc *epc);
 void pci_epc_init_notify(struct pci_epc *epc);
 void pci_epc_bme_notify(struct pci_epc *epc);
+void pci_epc_pme_notify(struct pci_epc *epc, void *data);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 			enum pci_epc_interface_type type);
 int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 063a59a58e3c..c162a73eb836 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -22,6 +22,7 @@ enum pci_notify_event {
 	LINK_UP,
 	LINK_DOWN,
 	BME,
+	PME,
 };
 
 enum pci_barno {
-- 
2.25.1

