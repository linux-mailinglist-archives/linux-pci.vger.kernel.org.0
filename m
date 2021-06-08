Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880FC39EE65
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 07:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhFHFw1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 01:52:27 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:33596 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhFHFw0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 01:52:26 -0400
Received: by mail-ot1-f52.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so5498721otl.0;
        Mon, 07 Jun 2021 22:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iNHrhq0IL96XZ0EI6v9hmr0ajyowuoqEGQEPG1rii/A=;
        b=rqBfJaic00+39Yc0R6kZ1OlmY1TA0B4f0e9Dvt0ly86lrXnPm/NE5j1Rd3h62rxAxq
         lNexTtLRBT0xJP02vMee/q/SIJOTSpoVt5PMFuzA3a+sx9qCDd53Qnz6jwlrU5o9dRmG
         BtjLyun9tkzwuXrT65RUwPz4CIznmB6wmDtBbT3gQtWAIZ2oie9v1l5UaPixrqLuH6G7
         aI3W8olpV26BGkjnVaPn+7KdGtIdov1RowD5rcNhIYEwjOXJDPLeaEvKEvUGPfMzVHsA
         mPQSnCQhJwyJkG8O0gzFemZYz3CfSGksLiSE1POQUzpLLOdGpm4EwmEKEtGyBl7/+i5p
         lVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iNHrhq0IL96XZ0EI6v9hmr0ajyowuoqEGQEPG1rii/A=;
        b=PNyaXPOjydrnJVjl5/KqQZFvp5L+bcvI/c5EifHhgz0hgwHZDvvTwvIFUIHDidspJ8
         7m+AcIqBng/UupBG3n2or+m5iMDH/gsyz4HeY1Lhj4kluwaF46L5NC2qIvHMOAcAF+Ja
         QiqwdQ3ycEDyIwSK+r9Nke6VB2mmfvIcp+FfvQQEfQpV6paXEvQ/L0FoD9OsFQvTVqcB
         3Gij/Z3UIBPgd+vJkOfTpPCY62LGsttdftFm6jcRy2052fgliP44XBBdAnRhph3kZnes
         cl7TZqv/isn+M63xfiWfk3FmK3cvWuIRIYvn+R3u15iwCfy8oMPkD8N35Pl8GKSNDa/S
         MLCw==
X-Gm-Message-State: AOAM530ZwF1w0OhpChT0piWZo+x/CErhu9T/CQeG3CpK/x20W/orw3K+
        D4EsBvGHKgLhtx7AyECgs4Y=
X-Google-Smtp-Source: ABdhPJzQHszRj8AzKWGqpNBUsat1h0CftaSmlwCcvqRx1YAORY1OtJi+POTtQUuYYy+UBxEHhG6CBg==
X-Received: by 2002:a9d:5ccc:: with SMTP id r12mr16328130oti.172.1623131374343;
        Mon, 07 Jun 2021 22:49:34 -0700 (PDT)
Received: from localhost.localdomain (static-198-54-128-46.cust.tzulo.com. [198.54.128.46])
        by smtp.googlemail.com with ESMTPSA id o2sm2489730oom.26.2021.06.07.22.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 22:49:34 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v7 6/8] PCI: Add support for ACPI _RST reset method
Date:   Tue,  8 Jun 2021 11:18:55 +0530
Message-Id: <20210608054857.18963-7-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608054857.18963-1-ameynarkhede03@gmail.com>
References: <20210608054857.18963-1-ameynarkhede03@gmail.com>
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
index eaddbf701..40dd24cd3 100644
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
index 2302aa421..2e7efd7e7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5121,6 +5121,7 @@ static void pci_dev_restore(struct pci_dev *dev)
  */
 const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ &pci_dev_specific_reset, .name = "device_specific" },
+	{ &pci_dev_acpi_reset, .name = "acpi" },
 	{ &pcie_reset_flr, .name = "flr" },
 	{ &pci_af_flr, .name = "af_flr" },
 	{ &pci_pm_reset, .name = "pm" },
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d22da6d3c..e9cfb7cd6 100644
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
index 6e9bc4f9c..a7f063da2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -49,7 +49,7 @@
 			       PCI_STATUS_SIG_TARGET_ABORT | \
 			       PCI_STATUS_PARITY)
 
-#define PCI_RESET_METHODS_NUM 5
+#define PCI_RESET_METHODS_NUM 6
 
 /*
  * The PCI interface treats multi-function devices as independent
-- 
2.31.1

