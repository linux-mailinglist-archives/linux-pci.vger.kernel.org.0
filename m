Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87A07C41CB
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 22:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343984AbjJJUpA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 16:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbjJJUo5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 16:44:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B06DAC;
        Tue, 10 Oct 2023 13:44:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A395C433CA;
        Tue, 10 Oct 2023 20:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696970693;
        bh=Y+Uf6ZavQYiu+Y65PyZJCsAfyLBeSZUYDgP/xIZnEz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JJFFZBLXEtqanXcoXRedx8XQyWzZwWZvBN38J9SM3hzLTadcaeaQesL0gONlZaPLJ
         EjzAO/Q548Ap2wb2S7RJj5PIjJNHd+cjy8pv3OsxQhTNpLA+/YYezHKbreow3SD0/1
         cgFj4IOn0bbupscVCBqHNoXIXi205X9tlchAXUXN2iJkvHzjvnKOqxG5TUoxcMkvs9
         hpUHxuAvV7L3tySTbao+PtRmvtgzTakPA+38NLOXYpxXQd8EumvtjVwdWumSbT28vR
         ITuLaxkC6VJLkWAs3dyG0uckree5NxbyQ4aB4Blv5F05+kGYg+8AZfvPhjFrbYbM90
         rwlguxnHdncpg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 05/10] PCI/ATS: Use FIELD_GET()
Date:   Tue, 10 Oct 2023 15:44:31 -0500
Message-Id: <20231010204436.1000644-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010204436.1000644-1-helgaas@kernel.org>
References: <20231010204436.1000644-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use FIELD_GET() to remove dependences on the field position, i.e., the
shift value.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/ats.c             | 7 ++-----
 include/uapi/linux/pci_regs.h | 1 +
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index f9cc2e10b676..c570892b2090 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -9,6 +9,7 @@
  * Copyright (C) 2011 Advanced Micro Devices,
  */
 
+#include <linux/bitfield.h>
 #include <linux/export.h>
 #include <linux/pci-ats.h>
 #include <linux/pci.h>
@@ -480,8 +481,6 @@ int pci_pasid_features(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_pasid_features);
 
-#define PASID_NUMBER_SHIFT	8
-#define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
 /**
  * pci_max_pasids - Get maximum number of PASIDs supported by device
  * @pdev: PCI device structure
@@ -503,9 +502,7 @@ int pci_max_pasids(struct pci_dev *pdev)
 
 	pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
 
-	supported = (supported & PASID_NUMBER_MASK) >> PASID_NUMBER_SHIFT;
-
-	return (1 << supported);
+	return (1 << FIELD_GET(PCI_PASID_CAP_WIDTH, supported));
 }
 EXPORT_SYMBOL_GPL(pci_max_pasids);
 #endif /* CONFIG_PCI_PASID */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 6af1f8d53e97..833e5fb40ea5 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -932,6 +932,7 @@
 #define PCI_PASID_CAP		0x04    /* PASID feature register */
 #define  PCI_PASID_CAP_EXEC	0x0002	/* Exec permissions Supported */
 #define  PCI_PASID_CAP_PRIV	0x0004	/* Privilege Mode Supported */
+#define  PCI_PASID_CAP_WIDTH	0x1f00
 #define PCI_PASID_CTRL		0x06    /* PASID control register */
 #define  PCI_PASID_CTRL_ENABLE	0x0001	/* Enable bit */
 #define  PCI_PASID_CTRL_EXEC	0x0002	/* Exec permissions Enable */
-- 
2.34.1

