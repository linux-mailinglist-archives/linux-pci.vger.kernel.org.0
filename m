Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A873E1985
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 18:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbhHEQbM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 12:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbhHEQbE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Aug 2021 12:31:04 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7651BC0613D5;
        Thu,  5 Aug 2021 09:30:06 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso10784344pjf.4;
        Thu, 05 Aug 2021 09:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=08u6MMg6gSt2pbogpVHi/DqBdJc7D2fOEtZsmltAf/k=;
        b=X2DTxfApm2buDlasGCGYHQGn/OlAvFmI7WhvIo9GxOV95R0WcdDGrBEN91GVdTIMLV
         OgQqFfoHhkEl6Q3FRg35UwDEtFncQnYdWfAxGeatzTNGHMNiz4N2aJi4o80y9EDQq0UB
         KTbNUZ70bEFH/JlzJRyYOX9M4iKWX1ZrdxyDxCoGlXBA4rT0Xi4X0hDHB/s0ndnsS7iH
         78pItcR2SVQO4a6eE9ZHZ3aRCcQVTKFEeAx1/kZYt9JIrTEXKcvdwYuTAO3xlV04HwrO
         4XV3EYFL31SG+zIzx8MkFsgoF0MZXxNoLxLt1HD2gJcWIhgra6e7Jt2ncotvPr2mxO1j
         oHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=08u6MMg6gSt2pbogpVHi/DqBdJc7D2fOEtZsmltAf/k=;
        b=Mw1KO7YB1b1wA8tIRl2K7NMfggkeY8YwcZWjGtlQFzfhWV/RfTO5w1IypScjFul6ax
         OTRDbtt4L2Otao3a18yLqBXNoNvz+/13YNh66IjFVVB37oNFpYdKQ49n79NPBnoVWa9b
         O6Tz0IsIkiAbbtlIe4GQaeNuKNk6iR2TZoust0K9wg9+Cle79xHwlPAkD36ZRDifYdQJ
         GC01m4AiFaZYjZvfYdlZ+F9aCfPtg0JE4kiZaYD9GGHi+tw4GSs9RyUu75DgVHoFaQc6
         7HpJfADvL3Hv0TW8DSb+Kw6bIECiAdpz7cIgxuq0RHyC7qR1BhG9I+IU8QacmZoXcrZn
         MHrQ==
X-Gm-Message-State: AOAM532Rwpkx1q8pGQAOx1j3eLig8ONPReXok+w8lLhIfld1QFH3NqvT
        UK7FgPrcVQW8GzVgUIT+93A=
X-Google-Smtp-Source: ABdhPJyLwWGUO1yltP93WuU8vZIkJaP9UrQZkoMM03r6IeMCZbz2qkSu2EBotptasMmnJQddC3HV9A==
X-Received: by 2002:a65:52c2:: with SMTP id z2mr6680pgp.225.1628181006093;
        Thu, 05 Aug 2021 09:30:06 -0700 (PDT)
Received: from localhost.localdomain ([139.5.31.161])
        by smtp.googlemail.com with ESMTPSA id nr6sm62551pjb.39.2021.08.05.09.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 09:30:05 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v15 8/9] PCI: Add support for ACPI _RST reset method
Date:   Thu,  5 Aug 2021 21:59:16 +0530
Message-Id: <20210805162917.3989-9-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805162917.3989-1-ameynarkhede03@gmail.com>
References: <20210805162917.3989-1-ameynarkhede03@gmail.com>
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
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci-acpi.c | 23 +++++++++++++++++++++++
 drivers/pci/pci.c      |  1 +
 drivers/pci/pci.h      |  6 ++++++
 include/linux/pci.h    |  2 +-
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index dae021322b3f..31f76746741f 100644
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
+		return -ENOTTY;
+	}
+
+	return 0;
+}
+
 static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 {
 	const struct fwnode_handle *fwnode;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 53d73770881f..5f76d04fa864 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5126,6 +5126,7 @@ static void pci_dev_restore(struct pci_dev *dev)
 static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ },
 	{ pci_dev_specific_reset, .name = "device_specific" },
+	{ pci_dev_acpi_reset, .name = "acpi" },
 	{ pcie_reset_flr, .name = "flr" },
 	{ pci_af_flr, .name = "af_flr" },
 	{ pci_pm_reset, .name = "pm" },
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 8ef379b6cfad..b13dae3323da 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -704,7 +704,13 @@ static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL
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
index 94d74fd594c1..d3b06bfd8b99 100644
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

