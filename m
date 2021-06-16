Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6C53A99BE
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 13:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhFPMBz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 08:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbhFPMBy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jun 2021 08:01:54 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B3EC0617A8
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 04:59:47 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h1so1007133plt.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 04:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fWWQKSCrhFCy8OkZJczZDgrXxFTkuwTV9AmNvxZeR+4=;
        b=VAjECfD79uJLuSVD6XDO2LgLBolmQtFVDZXfqmBa7yOVljl6MmNxRwzX96bcDpz08C
         tjAE4HktpC0UcnGKI2z7uPEG8lN9TeRvcEfmKx1McXbHtC94wx8RFvjOClbgQLEbI2Yr
         s6L1KGcm/4rfTUUA9SLowGmoTqcvAWYlkrlJfLIuSvfuYnMw5zjVhZqAjJnAeyzH8SWm
         nm3fU4cI4kEe4B5j6n2j8FYAL/obQQFL8Mdmwu0V+2OJBT8v5d0Wjq+gzyy+MPjGvRmz
         le642KxsUJPlHIbeAdEiLIOgW/D07FlBQ5LsL8hVn6U2MNkBhDl7/9XZZ7xT6mXboz9U
         rvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fWWQKSCrhFCy8OkZJczZDgrXxFTkuwTV9AmNvxZeR+4=;
        b=dYYxCMsN8uBOGxfoCXh3WZxjLR7PZkkwNCZJpWMyxji+9XKqi9zyqJkePpbaYKhi0e
         9dsw3u0bXOCCyomgSMB74TirdoOdONAa78mH18bZus1TimJ3dKFz3PjVHTxaFgXxLzMd
         i6rRC5Jb0MKMF9tJVP3ebLOiDuBKFaSJb7mI59w5Z20rci/apcQlP4DCnab9qS9D9sJ7
         FiPjSOVtgJO/j6lHAqUnRl5U/yNkqOeYiqta/S5bJD41VY4m90VMYoGHTB4/kNf6NXhi
         DIxcxNOSb0FChZOwP3oQyAOFtNXMIUPbeej+mgwHDXjic2OaVdTYvbmuddQ6VEmt6lev
         gZlA==
X-Gm-Message-State: AOAM532ZC+edr3OemtfWvCckIgwzJ7Hj9SQLVVt40wUhFMuFnzItE4ag
        ZgTB82Mp1lefim+vyGLtwazgna6gdqBb
X-Google-Smtp-Source: ABdhPJwD4AWfQFtsPn6lJ2OB3uLj8i8AQ92kFvV92A0hMuq4sttw1n3jfIzY4vZQ7bV/mj+aWw8iBw==
X-Received: by 2002:a17:90a:ab0c:: with SMTP id m12mr4628235pjq.179.1623844786437;
        Wed, 16 Jun 2021 04:59:46 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:280:c67a:95b5:d877:b175:798e])
        by smtp.gmail.com with ESMTPSA id m1sm2307646pjk.35.2021.06.16.04.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 04:59:46 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        smohanad@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/5] PCI: endpoint: Add linkdown notifier support
Date:   Wed, 16 Jun 2021 17:29:09 +0530
Message-Id: <20210616115913.138778-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616115913.138778-1-manivannan.sadhasivam@linaro.org>
References: <20210616115913.138778-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to notify the EPF device about the linkdown event from the
EPC device.

Usage:
======

EPC
---

```
static irqreturn_t pcie_ep_irq(int irq, void *data)
{
...
	case PCIE_EP_INT_LINK_DOWN:
		pci_epc_linkdown(epc);
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
	case LINK_DOWN:
		/* Handle link down event */
		break;
...
}
```

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 17 +++++++++++++++++
 include/linux/pci-epc.h             |  1 +
 include/linux/pci-epf.h             |  1 +
 3 files changed, 19 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index adec9bee72cf..f29d78c18438 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -641,6 +641,23 @@ void pci_epc_linkup(struct pci_epc *epc)
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
+	if (!epc || IS_ERR(epc))
+		return;
+
+	atomic_notifier_call_chain(&epc->notifier, LINK_DOWN, NULL);
+}
+EXPORT_SYMBOL_GPL(pci_epc_linkdown);
+
 /**
  * pci_epc_init_notify() - Notify the EPF device that EPC device's core
  *			   initialization is completed.
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index b82c9b100e97..23590efc13e7 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -202,6 +202,7 @@ void pci_epc_destroy(struct pci_epc *epc);
 int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 		    enum pci_epc_interface_type type);
 void pci_epc_linkup(struct pci_epc *epc);
+void pci_epc_linkdown(struct pci_epc *epc);
 void pci_epc_init_notify(struct pci_epc *epc);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 			enum pci_epc_interface_type type);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 6833e2160ef1..e9ad634b1575 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -20,6 +20,7 @@ enum pci_epc_interface_type;
 enum pci_notify_event {
 	CORE_INIT,
 	LINK_UP,
+	LINK_DOWN,
 };
 
 enum pci_barno {
-- 
2.25.1

