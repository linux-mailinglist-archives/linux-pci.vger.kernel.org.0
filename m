Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F793BBE2B
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 16:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhGEOZO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 10:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhGEOZN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 10:25:13 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E282FC061760;
        Mon,  5 Jul 2021 07:22:36 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id h4so18429517pgp.5;
        Mon, 05 Jul 2021 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cUyFfTZzWLY1nC0kNlDEdNgOhsBcCI3jl7nSUjoy+o0=;
        b=oxqRWx3hnchLIDwXqQSlZqMYE0Ze5PHmuqc5ExIoQDqZyG8j5GEJzu462t8oQYtA1F
         sO23iz5yRYe3P0fFxjWns3HJTumyPJ73UY3eaSPWMd519rBcdCam/SQ83I72l9hPUKFE
         ewAgiDh2+HBASAVbwv9+NBryrlxwG7kGb2FD8EwwJuGoXBN+s+29ZVj/CL/Ay/R9p9Ei
         1HCbT1D0RZzWbtRkpHj/9QCKLl98wN7cIi3eZ4v46RZhQyGs9gooyjnCUhRRXaSJbitB
         PFnRJCoPB7Dl1FuY50X4HX3EWio54R6UJVcWNzjQLIf7afg+NRL6FvZLSzj7mGovqgrS
         7yZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cUyFfTZzWLY1nC0kNlDEdNgOhsBcCI3jl7nSUjoy+o0=;
        b=AZkoGnfGuqS3C327t7T7MVne0PZ41b2v6urO1ebKQwjTECKBbGEj4stB8BsX6tnXxI
         AZrsi/p0DTUaVhie5HeTh0/28XmqR5dhf4fgY7KRk/jN5wJblJPlHG438MgYgyYv/qyJ
         rXr0/b8Ulx0tuTH9IE/PwpVPGMgW2nF4MZyAg/qIjXXJ2hptGy/QttV9xxAyQwAJH9xm
         lWUitWPgGRqw8FvEjVd0ZF5nDG13uN2YV6VfQug1hsvcT9o0+6bz8F/Ii3VbJWu5twtR
         R4D4So8ADFLihcCwAYFsYhmIdqARkbL4CCE7NQyF636lsFsxiM1uoime9Hod5XjK5Zt9
         /8iQ==
X-Gm-Message-State: AOAM532mz2zY6o519YADLoZnyH62bYMc2BbqgtfLjj/yX9diX6qyAkt9
        o0KMLaUn+GCJuas3YUYRZv8=
X-Google-Smtp-Source: ABdhPJyLMc113K9irs1cGiipwliBGIG4AQ0ypBvY1CXqLMk+USAAYNpktPDvkki6FbelJLgJLpxnXA==
X-Received: by 2002:a63:5912:: with SMTP id n18mr16135678pgb.108.1625494956558;
        Mon, 05 Jul 2021 07:22:36 -0700 (PDT)
Received: from localhost.localdomain ([2409:4042:2696:1624:5e13:abf4:6ecf:a1f1])
        by smtp.googlemail.com with ESMTPSA id 92sm22615307pjv.29.2021.07.05.07.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 07:22:36 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v9 7/8] PCI: Add support for ACPI _RST reset method
Date:   Mon,  5 Jul 2021 19:51:37 +0530
Message-Id: <20210705142138.2651-8-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210705142138.2651-1-ameynarkhede03@gmail.com>
References: <20210705142138.2651-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Shanker Donthineni <sdonthineni@nvidia.com>

The _RST is a standard method specified in the ACPI specification. It
provides a function level reset when it is described in the acpi_device
context associated with PCI-device. Implement a new reset function
pci_dev_acpi_reset() for probing RST method and execute if it is defined
in the firmware.

The default priority of the ACPI reset is set to below device-specific
and above hardware resets.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/pci/pci-acpi.c | 23 +++++++++++++++++++++++
 drivers/pci/pci.c      |  1 +
 drivers/pci/pci.h      |  6 ++++++
 include/linux/pci.h    |  2 +-
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index dae021322..b6de71d15 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -941,6 +941,29 @@ void pci_set_acpi_fwnode(struct pci_dev *dev)
 				   acpi_pci_find_companion(&dev->dev));
 }
 
+/**
+ * pci_dev_acpi_reset - do a function level reset using _RST method
+ * @dev: device to reset
+ * @probe: check if _RST method is included in the acpi_device context.
+ */
+int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
+{
+	acpi_handle handle = ACPI_HANDLE(&dev->dev);
+
+	if (!handle || !acpi_has_method(handle, "_RST"))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
+		pci_warn(dev, "ACPI _RST failed\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 {
 	const struct fwnode_handle *fwnode;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d5c16492c..1e64dbd3e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5115,6 +5115,7 @@ static void pci_dev_restore(struct pci_dev *dev)
 const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ },
 	{ &pci_dev_specific_reset, .name = "device_specific" },
+	{ &pci_dev_acpi_reset, .name = "acpi" },
 	{ &pcie_reset_flr, .name = "flr" },
 	{ &pci_af_flr, .name = "af_flr" },
 	{ &pci_pm_reset, .name = "pm" },
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 990b73e90..2c12017ed 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -705,7 +705,13 @@ static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL
 int pci_acpi_program_hp_params(struct pci_dev *dev);
 extern const struct attribute_group pci_dev_acpi_attr_group;
 void pci_set_acpi_fwnode(struct pci_dev *dev);
+int pci_dev_acpi_reset(struct pci_dev *dev, int probe);
 #else
+static inline int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
+{
+	return -ENOTTY;
+}
+
 static inline void pci_set_acpi_fwnode(struct pci_dev *dev) {}
 static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f34563831..c3b0d771c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -50,7 +50,7 @@
 			       PCI_STATUS_PARITY)
 
 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
-#define PCI_NUM_RESET_METHODS 6
+#define PCI_NUM_RESET_METHODS 7
 
 /*
  * The PCI interface treats multi-function devices as independent
-- 
2.32.0

