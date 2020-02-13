Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC5715C8B3
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 17:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgBMQwK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 11:52:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36296 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbgBMQwK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2020 11:52:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so7551830wma.1
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2020 08:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DmgjzmmWDE6AVkoEEWIs00PdyCL0hFYlq0AAqattmTE=;
        b=r3ZywhgW/FK3G9wDEpUnfgzuV7uJt6i9jV7UqceMvsTu0/msyTonSIQfFCbQGHxoBu
         oaGcDDLvQSQuINJrKcCRy8aSBFnEjT73wkWrRVJ768mL/vdToEH1LvTQLfy/mO84mtBk
         zoFwIe2er5GMHWl3FBKU2DowYpV+cUzzfmUXZKLLqulYh6dWiOqqB6a7hID358G9YmIw
         kKIHHewhvZfNlvZH7fNDH6gbr1CUxMP7k0SSRGtGGlB+SAbRuIafRahCYINoYFLPE3+3
         5LZK2hDZXIGXPHCWGD3xh+Ke0Py1z9cm3LLUTHPG3kh1pD5w5H26oRj5FbrdRLwZr+k3
         bmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DmgjzmmWDE6AVkoEEWIs00PdyCL0hFYlq0AAqattmTE=;
        b=KkN2v47LoIBCJOxr/30AsYlJkIO3fgX1KTciNwsLDdgcELH7cTNXPqtwWgDSp0Cjwa
         0iAjFxLQ1UQmu3rsag2+Th7HV7+vQJUlwKtBoq6yapmmCe9TLvACjZph+JE4GdWXRcED
         xgsD1pXYQxDkbI1OKDSsHCAePrwhmZi99WbQAtARA0M5VE6XPvEh/VWwKhpXdu4UgLaX
         NTe9xwiMz6j10i0jupJ8Ta3IYdWckNOEhZqFxJAcoE2sgsm7gejmx8mC13s4vNmmBaGt
         +GIJVjMIMGUre3sxhXzKjB+WF593thAkSfUQ0LwjvkBAL+PenWNPkkZ02QBPFSbrup0D
         ZQCA==
X-Gm-Message-State: APjAAAWElGkXzVN5243mQEHDzIZphLeLyTixTIgAASV/QYyCmVMpDIEY
        dZ+Sd8zQA4JfpT/EK0T4sy5A0g==
X-Google-Smtp-Source: APXvYqySri3oZxBP5/n/eQlkCkEkvXZHlVKb8rcBY3ipxnyr0phNLF0F/nWVh6oe85zgCgyj4T0dEw==
X-Received: by 2002:a1c:7915:: with SMTP id l21mr6417566wme.112.1581612728454;
        Thu, 13 Feb 2020 08:52:08 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y6sm3484807wrl.17.2020.02.13.08.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 08:52:08 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, joro@8bytes.org,
        baolu.lu@linux.intel.com, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     corbet@lwn.net, mark.rutland@arm.com, liviu.dudau@arm.com,
        sudeep.holla@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com
Subject: [PATCH 04/11] ACPI/IORT: Check ATS capability in root complex node
Date:   Thu, 13 Feb 2020 17:50:42 +0100
Message-Id: <20200213165049.508908-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213165049.508908-1-jean-philippe@linaro.org>
References: <20200213165049.508908-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When initializing a PCI root bridge, copy its "ATS supported" attribute
into the root bridge.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/arm64/iort.c | 27 +++++++++++++++++++++++++++
 drivers/acpi/pci_root.c   |  3 +++
 include/linux/acpi_iort.h |  8 ++++++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ed3d2d1a7ae9..d99d7f5b51e1 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1633,6 +1633,33 @@ static void __init iort_enable_acs(struct acpi_iort_node *iort_node)
 		}
 	}
 }
+
+static acpi_status iort_match_host_bridge_callback(struct acpi_iort_node *node,
+						   void *context)
+{
+	struct acpi_iort_root_complex *pci_rc;
+	struct pci_host_bridge *host_bridge = context;
+
+	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
+
+	return pci_domain_nr(host_bridge->bus) == pci_rc->pci_segment_number ?
+		AE_OK : AE_NOT_FOUND;
+}
+
+void iort_pci_host_bridge_setup(struct pci_host_bridge *host_bridge)
+{
+	struct acpi_iort_node *node;
+	struct acpi_iort_root_complex *pci_rc;
+
+	node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
+			      iort_match_host_bridge_callback, host_bridge);
+	if (!node)
+		return;
+
+	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
+	host_bridge->ats_supported = !!(pci_rc->ats_attribute &
+					ACPI_IORT_ATS_SUPPORTED);
+}
 #else
 static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
 #endif
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index d1e666ef3fcc..eb2fb8f17c0b 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -6,6 +6,7 @@
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
  */
 
+#include <linux/acpi_iort.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -917,6 +918,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
 		host_bridge->native_ltr = 0;
 
+	iort_pci_host_bridge_setup(host_bridge);
+
 	/*
 	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
 	 * exists and returns 0, we must preserve any PCI resource
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 8e7e2ec37f1b..7b06871cc3aa 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <linux/fwnode.h>
 #include <linux/irqdomain.h>
+#include <linux/pci.h>
 
 #define IORT_IRQ_MASK(irq)		(irq & 0xffffffffULL)
 #define IORT_IRQ_TRIGGER_MASK(irq)	((irq >> 32) & 0xffffffffULL)
@@ -55,4 +56,11 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 { return 0; }
 #endif
 
+#if defined(CONFIG_ACPI_IORT) && defined(CONFIG_PCI)
+void iort_pci_host_bridge_setup(struct pci_host_bridge *host_bridge);
+#else
+static inline
+void iort_pci_host_bridge_setup(struct pci_host_bridge *host_bridge) { }
+#endif
+
 #endif /* __ACPI_IORT_H__ */
-- 
2.25.0

