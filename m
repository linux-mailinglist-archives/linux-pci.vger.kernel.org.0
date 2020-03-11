Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 898EF18187C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 13:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbgCKMrC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 08:47:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53827 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729459AbgCKMrB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 08:47:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id 25so1932577wmk.3
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2020 05:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U47FGde+FbNcdQs+RPhyYEqijb3kd9q1HrNDc4ml5OM=;
        b=PaFI7UScmuJq/vQMffhQojPOeVfgLOAOjM4tY3da2DCq6MkkfzqrKf7V1Pxw17ncw8
         I7lQsl4LNyrad1s2jqB7jxtjderJz1RfVJLzyzLHT+oAi/Nou6U8jheMoW1RCz5MFSmt
         8TqQOYGDNPNoEyjr7Wiqwd81sNgrr8blWpNAwkKUf1YvpBlEq53rad+vRE26mSuLionw
         wAz0sy3xHgGF1Xt7nkvW0dLEL7P3CqIctcFCnPvoWBwkwSJ3aEqgNcQBJaSFzZUK4ZuH
         LE/gRrJ60DA+fHf+OG44ZIz5IHRMbefyq84xQfidyBcnHlOEgny1G6Qa9QaCs7OF3Ab7
         7uwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U47FGde+FbNcdQs+RPhyYEqijb3kd9q1HrNDc4ml5OM=;
        b=QYbxmQd2T2fBN0+D3Xj8HqtP53hh1fWGJO17bqY8RFRZ0RjeKcj+lHoKi6ks7JcGb2
         KIoGL1z+YXAlLryKwrkMBoHQ+rfLe3vFC6/1RZqdN0Y8Q3OzjgDHnwvbgpMBesJd3bRm
         G1FHrnEqh97E3AZZ8Bqj5U815ng4cGsIRxTaUglpYf3H7SzTN5Yw1jLLMpVgPa14YkCq
         nkOpfaTEPnYTzuM2YUOMsbCX0EKGWRyh1+n8BgrATdYs3iiNy275L4sZZH9albne4XZT
         xWr811s7kw5n+YDIsLXJ3kR9d68G+5zn32LkhRgYr5hQYQr+vO/p1XajVIrEm2Tc7+30
         m0Ow==
X-Gm-Message-State: ANhLgQ17va+zLr9Y42ETpmMSSiL7Y/pnYQh1iiSIvQljaIgsDYlsI2xh
        WjcTn+mpd5LjZMU/CN5ufIHAgg==
X-Google-Smtp-Source: ADFU+vssp6pgSA4SHhUAKAeskjqrgFN5K6L5kBvQztm1aXqSMSSOxW9M674hcGUdXj2nfa3aXBAr9Q==
X-Received: by 2002:a1c:5fc5:: with SMTP id t188mr1007198wmb.110.1583930819703;
        Wed, 11 Mar 2020 05:46:59 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id c2sm8380020wma.39.2020.03.11.05.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 05:46:59 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
        joro@8bytes.org, baolu.lu@linux.intel.com, sudeep.holla@arm.com,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     lorenzo.pieralisi@arm.com, corbet@lwn.net, mark.rutland@arm.com,
        liviu.dudau@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 04/11] ACPI/IORT: Check ATS capability in root complex node
Date:   Wed, 11 Mar 2020 13:44:59 +0100
Message-Id: <20200311124506.208376-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311124506.208376-1-jean-philippe@linaro.org>
References: <20200311124506.208376-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When initializing a PCI root bridge, copy its "ATS supported" attribute
into the root bridge.

Acked-by: Hanjun Guo <guohanjun@huawei.com>
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
2.25.1

