Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA5D3E097E
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 22:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240925AbhHDUmd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 16:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240930AbhHDUm3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 16:42:29 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB9DC06179A;
        Wed,  4 Aug 2021 13:42:16 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id k2so4341401plk.13;
        Wed, 04 Aug 2021 13:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3TdIfUE1vHBHBg5ARypMvKXE/Ywe1XabexhsHIfEbiE=;
        b=qnIHbcZbxU9hsd66ZjGhQbRblMvuXg7Tobt72IhCmWIEi0t8ayCGOZ+3ocyhuzmW2z
         Y3rZ0977bJwpv5EayFGmdDehXGR7hpJg6iXcxyCuxzoutpQeKrnl93RlaMMtLyGMI31T
         2VkJ2e/hRDRa9qIlpqIMq6WGFGUcNDPdqd0IZP8e5As8Ssqlkfvq/yyDS8/Ywqp8ZfZK
         shCbrotSEL9qhBDRSR220bSoEU0fB3pmIvDXV69mVC2IK3RBWikdjLQx+RLK3X5wB9bf
         a0m4vbO3pzvtt6DPJ+Wi0/HPobJ1C6ciJE/FPznvpS6ENilAweh5TExF0g3BmqRNlULL
         Gv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3TdIfUE1vHBHBg5ARypMvKXE/Ywe1XabexhsHIfEbiE=;
        b=pI+dgEcK6gqqX/miPWeB6Pt01PgLWUk3CB/3BVW/O1zqcAbvb/ZAOQWsVRYjv446TY
         KyMSULzC8aRrFtnRFUfrRY3Tm2U0vekI/G/CP9SjYi4y8JMwjpnYf/dVlljEfm/i4gCP
         bVzxFsFPU9pFI3AFG5ngr02CbmsGIymOxMKOwoPMhMD1t2P0/DrHncPfw0kWqurUkRa4
         AJz1M8IlTUx5GH5G8Q9zVjv1+hjAgUa4A9OSfulK5eYucI314JMqv/QBtxGX+KmCa2AL
         PDvDFNGhvQNd0UDVv0EvIk8Ty4lQX6luM3rLjoaI2RqFCZvJ6iihQU3pKZg/aODvcRso
         sBmg==
X-Gm-Message-State: AOAM5330+B67jStbV/ERYZFI8TOX+fjmFCst3cTW5QVNe3WOsOKHihqM
        gZMV/Sp5hETS7sZtXF/7MZk=
X-Google-Smtp-Source: ABdhPJxDLUHqvByk5yDy6JEh/lNnBjPgAxr6fg6fwPSiURu4CU4wdKpHOmtIfudT2wVEJAFsigK1fg==
X-Received: by 2002:a65:44c3:: with SMTP id g3mr890762pgs.233.1628109735669;
        Wed, 04 Aug 2021 13:42:15 -0700 (PDT)
Received: from localhost.localdomain ([139.5.31.161])
        by smtp.googlemail.com with ESMTPSA id w2sm7064922pjt.14.2021.08.04.13.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 13:42:15 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v14 1/9] PCI: Cache PCIe FLR capability
Date:   Thu,  5 Aug 2021 02:11:53 +0530
Message-Id: <20210804204201.1282-2-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210804204201.1282-1-ameynarkhede03@gmail.com>
References: <20210804204201.1282-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new member called devcap in struct pci_dev for caching the device
capabilities to avoid reading PCI_EXP_DEVCAP multiple times.

Refactor pcie_has_flr() to use cached device capabilities.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/pci/pci.c   | 6 ++----
 drivers/pci/probe.c | 5 +++--
 include/linux/pci.h | 1 +
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 452351025a09..1fafd05caa41 100644
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
index 3a62d09b8869..df3f9db6e151 100644
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
index c20211e59a57..697b1f085c7b 100644
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

