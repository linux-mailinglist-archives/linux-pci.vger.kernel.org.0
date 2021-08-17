Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECE73EF183
	for <lists+linux-pci@lfdr.de>; Tue, 17 Aug 2021 20:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhHQSKw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 14:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbhHQSKv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Aug 2021 14:10:51 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30770C061764;
        Tue, 17 Aug 2021 11:10:18 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o10so52587plg.0;
        Tue, 17 Aug 2021 11:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zUbjTLJIKy7pOxZ+AFV2nBFsLgx//TOXTrcZYrkUN6g=;
        b=vJA6fSx3CSJ0Pumbhfx4N+cqZX+DpxPk0zNrNgB7MxFg/7XnfCQmowZxYeUz4o/BkL
         X8NFH3L2gwbZ+xzBxlwMj818GDPKeK5gyDW3FIkzz4y0beRTFSdPs2Lxiy4IKt1l6UCf
         AwV4s+uzvrUnXtvzHvFBJApSWLAeO4JKL/6ZU0FolfBH/a9uC4MP9b+VDUlvgtz6AAM1
         c10J/iwE+8g+wr3/Ds9fvXp9LVLJ9E5931wwttfFA6CWjYLWpGh6uAIFAx/ufppKbHbR
         9CzEDXbw6xKcHIG+ErUyQDmdvAhqPuwEs2fPo2RV9f/lBwqzp8ZN3mzQhL6IrGrn2G28
         QzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zUbjTLJIKy7pOxZ+AFV2nBFsLgx//TOXTrcZYrkUN6g=;
        b=gQXwhMlNzFDxjy1nkn+Ts6AQuY5mWVAONfJh8KuBNg394bnEu34aemeDya1cJzUxsA
         cUf5464hFA0PNwcd0jZwaxJR86nUGPk17rtEbmWkXE9onL77zGrwvGn+dz5e6D2buChD
         CdjLBM9qkkuSxftFf9wLdQ9thHYOblQ+wrPvwplgTOJu/JMcCJNgH8Q1U9wC646Eaamw
         +sD60nSIiExb9wk5j3fWEOa96QN9my7DVwM0Z4gF8TFyFD6/mDTQhdTHXUEKJkVn5rsM
         KfZESr18OYOKVbS7AQFVDz+hbT13M58GCwtJshykNeadFaKG3nTGX2z2smirrYikkMSe
         ZaZw==
X-Gm-Message-State: AOAM533PgOJz+lIkN773A1Gy0aIQBRnXiHQyqmvULY04WZkTwFpNWUdF
        NLkdxbWyWmO7cLPvfvQdGwQ=
X-Google-Smtp-Source: ABdhPJwYtFRrKw20Xbrt+QZh+1lNd5dKVPQwyhyHaKY97oiVdJD1GJ/F8Y0a4IBqXWmQHbEDz/xaMA==
X-Received: by 2002:aa7:8891:0:b0:3e1:6eb1:b4b4 with SMTP id z17-20020aa78891000000b003e16eb1b4b4mr4836646pfe.9.1629223817731;
        Tue, 17 Aug 2021 11:10:17 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.158])
        by smtp.googlemail.com with ESMTPSA id d18sm4011306pgk.24.2021.08.17.11.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:10:17 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v16 8/9] PCI: Add support for ACPI _RST reset method
Date:   Tue, 17 Aug 2021 23:39:36 +0530
Message-Id: <20210817180937.3123-9-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817180937.3123-1-ameynarkhede03@gmail.com>
References: <20210817180937.3123-1-ameynarkhede03@gmail.com>
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
index e9a403191..e7b2f7d5c 100644
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
 static bool acpi_pci_power_manageable(struct pci_dev *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 53d737708..5f76d04fa 100644
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
index 8ef379b6c..b13dae332 100644
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
index 94d74fd59..d3b06bfd8 100644
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

