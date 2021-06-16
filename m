Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF603A99CB
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 14:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhFPMCS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 08:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbhFPMCP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jun 2021 08:02:15 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE95C061574
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 05:00:08 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p13so2077649pfw.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 05:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q6FFMNi0w8wBxpKeYDdXPwwxjU3cn3Myi2hz/ywMz+w=;
        b=II+5q8Jrp2elpES9k9l3CmxQr74TfDa0QaoFGUqPiHmS/vS6groglYsZx79zA1oICB
         f54xfCHO8ppvcApZttYBuBZCqFHeXAFlH+n1btsBQaOL7CJxmMeGKwv6WcpJukKFGSdh
         gkewXhTsG1UHLEmWTN6FDFGz+nkUYca20wbk/eLp6r4k5QqXtcNk+tE+QiyrG140SALh
         FdOibp0iFLmHgDrU9xl82BHE0JxpIAYkyLwW0HRa3JD56WgbbMwu7LIt+49ZldVGgexj
         AQZWuJoIWmPg0VVHO9H6ar+vB6Tf86T4tSuOHBTW7roSb49gGjsBGO2VSSlxeAAyJ4RA
         a6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q6FFMNi0w8wBxpKeYDdXPwwxjU3cn3Myi2hz/ywMz+w=;
        b=N9WVte2B2za3dxhbgdJ09DewL1O6sju6jDBEGjtrS8pfxZ9Eq7Unc2zZehr0c4s7sr
         G1bo9i2DZ/pyqwq6xQuXCKUwDgBOOwltNFS2dXhqg6okgl6bcpBMZd5DNcaTkcJ38Arm
         H1XJB9HD6vq0QPspj0roHd3AXO5WxBaOW6TP0Pox01scQGRpxFXNdYgQhKLBFCXOZ2Rd
         aLFPQNeKBnnL8zqUoYytGKr0d0XPW3azToZX2QXhfdjbX0NdQAknGvjU6FMxU2blUT6R
         pLHHVD1Y3sXz81ufHx2YnbydLtkMBmSGYt9SmjPOolGh9wW3TEVB0mehYDW3iseyoZig
         SBpg==
X-Gm-Message-State: AOAM530sQimCIjCbDeqt+gq6syyqeUzKhT+ssc0NMyCU9zPP7tW9TeLf
        Vk8Alw1CxVCrWNbUJHXYV0xv
X-Google-Smtp-Source: ABdhPJzAPi3gg7I9jX6acmwD9DgNgs4AYlLzF3vGqebnQQEwnEwZAa+HraDsmO4n15w+2jf0RianDQ==
X-Received: by 2002:a05:6a00:d65:b029:2ec:2bfa:d0d1 with SMTP id n37-20020a056a000d65b02902ec2bfad0d1mr9278866pfv.14.1623844808273;
        Wed, 16 Jun 2021 05:00:08 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:280:c67a:95b5:d877:b175:798e])
        by smtp.gmail.com with ESMTPSA id m1sm2307646pjk.35.2021.06.16.05.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 05:00:07 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        smohanad@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5/5] PCI: endpoint: Add custom notifier support
Date:   Wed, 16 Jun 2021 17:29:13 +0530
Message-Id: <20210616115913.138778-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616115913.138778-1-manivannan.sadhasivam@linaro.org>
References: <20210616115913.138778-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for notifying the EPF device about the custom notifications
received by the EPC device from the Root complex. These notifications
are EPC/vendor specific and are shared with the specific EPF devices.

For instance, the Qcom EPC device generates events such as MHI_A7,
MHI_Q6, DEBUG, MMIO_WRITE, CFG_WRITE etc... These events can be passed
to the EPF device using this notifier.

EPC
---

```
static irqreturn_t pcie_ep_irq(int irq, void *data)
{
...
	case PCIE_EP_INT_MHI_A7:
		pci_epc_custom_notify(epc, PCIE_EP_INT_MHI_A7);
		break;
	case PCIE_EP_INT_MHI_Q6:
		pci_epc_custom_notify(epc, PCIE_EP_INT_MHI_Q6);
		break;
	case PCIE_EP_INT_MMIO_WRITE:
		pci_epc_custom_notify(epc, PCIE_EP_INT_MMIO_WRITE);
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
	case CUSTOM:
		cus_event = data;
		if (cus_event == PCIE_EP_INT_MHI_A7)
			/* Handle MHI A7 event */
		else if (cus_event == PCIE_EP_INT_MHI_Q6)
			/* Handle MHI Q6 event */
		else if (cus_event == PCIE_EP_INT_MMIO_WRITE)
			/* Handle MMIO WRITE event */
		break;
...
}
```

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 19 +++++++++++++++++++
 include/linux/pci-epc.h             |  1 +
 include/linux/pci-epf.h             |  1 +
 3 files changed, 21 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index b4a7bb3caa97..b963a4aa0af4 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -728,6 +728,25 @@ void pci_epc_d_state_notify(struct pci_epc *epc, void *data)
 }
 EXPORT_SYMBOL_GPL(pci_epc_d_state_notify);
 
+/**
+ * pci_epc_custom_notify() - Notify the EPF device that the EPC device has
+ *			     received the custom events from the Root complex
+ * @epc: EPC device that received the custom event
+ * @data: Data for the CUSTOM notifier
+ *
+ * Invoke to notify the EPF device that the EPC device has received the Custom
+ * event from the Root complex. The custom event is EPC/vendor specific and is
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
index 94c66fae8a88..943d31a83f6e 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -207,6 +207,7 @@ void pci_epc_init_notify(struct pci_epc *epc);
 void pci_epc_bme_notify(struct pci_epc *epc);
 void pci_epc_pme_notify(struct pci_epc *epc, void *data);
 void pci_epc_d_state_notify(struct pci_epc *epc, void *data);
+void pci_epc_custom_notify(struct pci_epc *epc, void *data);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 			enum pci_epc_interface_type type);
 int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index ca020c080431..2fa3b90399b9 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -24,6 +24,7 @@ enum pci_notify_event {
 	BME,
 	PME,
 	D_STATE,
+	CUSTOM,
 };
 
 enum pci_barno {
-- 
2.25.1

