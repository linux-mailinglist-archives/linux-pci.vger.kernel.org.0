Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B593EF176
	for <lists+linux-pci@lfdr.de>; Tue, 17 Aug 2021 20:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhHQSK2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 14:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbhHQSK1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Aug 2021 14:10:27 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3873AC061764;
        Tue, 17 Aug 2021 11:09:54 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so6603190pjn.4;
        Tue, 17 Aug 2021 11:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=64aDvN9oKekcubnbTh6hlBJyjfJ9jTD8l/UAKBhqJ40=;
        b=MnyN+lMxTGlQ9iNgv6xxYF6zhMYrFB6WVoIm/psc7rn3k3SISi3cVRPLB0DLCLG93n
         lf6XTdg1yv73ndOUwaKQ4HoHM9FuYLM77sSiOQeJEN4uWoWnxbTQWq2m8FMgB1ckNgEj
         h/nvHSqCpPYUsjYE2bg5vAkOgCO3+4q5cd41uECA62hms2vEC8nVcs9Y0cDTUHxP2k8N
         YxgfmnHtpNs7GuN8pv3ef32nFZJO5K/D/lJPtovgHCffgHzIkd4aN0bGJbEqBR0fQBoC
         P843yd4fQiU/ynJWSPoY2Un+/ez90qojEUhI/xrDBBYgNIqhsGYgw4R7RSar4GxI/VkO
         feeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=64aDvN9oKekcubnbTh6hlBJyjfJ9jTD8l/UAKBhqJ40=;
        b=uewivHwO0jsYJMQyMsYmqE8JKhY6ybjaLix+yFK4/zSGHqhc7Z4rtGDkdC7r30MyEw
         rvEpPmx/pURmaEwmlrdq40batSk/OcGxU8BtWqGZrz9F5hjTTF9LZrAZl4vfPULeN8vZ
         4uPXhr9PiLDEZ0B/M2H7Igf+eSPy+0Afep3V0ukCEVASWqXSIaFQWjSQE3fDrW2HyfZu
         epuXilJEVez+6N7uEwWN7ycF/kkOigaUCFCdIrgPA3Z8V2Kya8q1gqcf5Ob8t2W13Dzx
         x+uJTGqy4I0e+7xKFfMSRbkh/vJwck1kqF3GsUZruztKDRVWlzV/+1X4MEsD4rjGJCrC
         DhYQ==
X-Gm-Message-State: AOAM532xYEPM/fddQCaRic6+LcCYusXVDU11jlsfy5u4FYg0kWs43cAM
        XsqxVapeocp9OSLmfP6tVlc=
X-Google-Smtp-Source: ABdhPJxFEwGZR1vhu5MYsiMEP3crfXxsmvu+96lLP6Abn6pD2bcftv7V9fNvkFtVZF7C6aTnXqk9ow==
X-Received: by 2002:a17:90a:c244:: with SMTP id d4mr4838319pjx.38.1629223793842;
        Tue, 17 Aug 2021 11:09:53 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.158])
        by smtp.googlemail.com with ESMTPSA id d18sm4011306pgk.24.2021.08.17.11.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:09:53 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v16 1/9] PCI: Cache PCIe FLR capability
Date:   Tue, 17 Aug 2021 23:39:29 +0530
Message-Id: <20210817180937.3123-2-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817180937.3123-1-ameynarkhede03@gmail.com>
References: <20210817180937.3123-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new member called devcap in struct pci_dev for caching the device
capabilities to avoid reading PCI_EXP_DEVCAP multiple times.

Refactor pcie_has_flr() to use cached device capabilities.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 drivers/pci/pci.c   | 6 ++----
 drivers/pci/probe.c | 5 +++--
 include/linux/pci.h | 1 +
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 452351025..1fafd05ca 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -31,6 +31,7 @@
 #include <linux/vmalloc.h>
 #include <asm/dma.h>
 #include <linux/aer.h>
+#include <linux/bitfield.h>
 #include "pci.h"
 
 DEFINE_MUTEX(pci_slot_mutex);
@@ -4620,13 +4621,10 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
  */
 bool pcie_has_flr(struct pci_dev *dev)
 {
-	u32 cap;
-
 	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
 		return false;
 
-	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
-	return cap & PCI_EXP_DEVCAP_FLR;
+	return FIELD_GET(PCI_EXP_DEVCAP_FLR, dev->devcap) == 1;
 }
 EXPORT_SYMBOL_GPL(pcie_has_flr);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3a62d09b8..df3f9db6e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -19,6 +19,7 @@
 #include <linux/hypervisor.h>
 #include <linux/irqdomain.h>
 #include <linux/pm_runtime.h>
+#include <linux/bitfield.h>
 #include "pci.h"
 
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
@@ -1497,8 +1498,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	pdev->pcie_cap = pos;
 	pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
 	pdev->pcie_flags_reg = reg16;
-	pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
-	pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
+	pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP, &pdev->devcap);
+	pdev->pcie_mpss = FIELD_GET(PCI_EXP_DEVCAP_PAYLOAD, pdev->devcap);
 
 	parent = pci_upstream_bridge(pdev);
 	if (!parent)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c20211e59..697b1f085 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -333,6 +333,7 @@ struct pci_dev {
 	struct rcec_ea	*rcec_ea;	/* RCEC cached endpoint association */
 	struct pci_dev  *rcec;          /* Associated RCEC device */
 #endif
+	u32		devcap;		/* PCIe device capabilities */
 	u8		pcie_cap;	/* PCIe capability offset */
 	u8		msi_cap;	/* MSI capability offset */
 	u8		msix_cap;	/* MSI-X capability offset */
-- 
2.32.0

