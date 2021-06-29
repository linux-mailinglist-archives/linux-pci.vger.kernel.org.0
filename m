Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556A43B7628
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jun 2021 18:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbhF2QGJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Jun 2021 12:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbhF2QFN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jun 2021 12:05:13 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E895AC0617AF;
        Tue, 29 Jun 2021 09:02:25 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g22so639818pgl.7;
        Tue, 29 Jun 2021 09:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6HqcttSPSxQWqSamFTVqADhPL4KJRBGfKQDkHy62/cQ=;
        b=Z937Z+/bc5q1eotJlAYSgx2YR5/5V/h1R9f5M2LhnYzqbcZJft7/dV7GTgfwzguuhi
         n1cRk4yXipkr9b40f/YR3P1Ws2lQHSLztPchMVrTdggFDa0usxwd3C5dLsdo4qgzVtUS
         8HASx9DxN1HlJftf39xaUZHzMjzBwVBwNt3kDYMNAcDKEGywdl5j8PjzObk+R2vCXx4W
         wsQirvY4SMhwgHhtL45oaEjVK56AQgJgjK/8s8nfipIl9qT0CUApRnVh3W9LAcMVKBtX
         z+O1unl8w4YierpUYSdkoAQ6NHRMEC9YgBOvkhlFYVgOQuKU5B/k/dbw2EVdDPjXVL1u
         tVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6HqcttSPSxQWqSamFTVqADhPL4KJRBGfKQDkHy62/cQ=;
        b=P88IQ9J9U6nyNVOblipXHH+GW6rWiVFqVm8K0QiU2fYkrMYjKKuqZ5CqjHNT+ZPMpy
         3C+yHxEQldQhELbMj5heZnpDVoZSGJ4aFioY6RBqErpLDVnVJTb+zVVQMEh3CxtNFZgg
         hrIoIObqBIJQu9xTYvVAJGgsoSa1W/D9TniDiqUZ3aNidTbHc7cb0LvJxJGy9pey7fG0
         DCH52GlnXjTJQzZ5aPFlMJww1ChR05gX2lnrCmrD8aCBV2aC931tEQoVVNzxQhr6+0bE
         SrMxqsh9xsibB5qeUKbAMA4EPYoy5V4qDmMZW5I5QOvCM+r+WZCTTqSNjFLvF+nyZo0E
         YRTQ==
X-Gm-Message-State: AOAM530NDj0H9m12En7vDaZsxVBJpPQVtWRtjN9M8EDFw1pK4zcUuxlN
        EJLi1oV7TqjHDGpJXN0S2S8=
X-Google-Smtp-Source: ABdhPJzauRG4TJLCMqNZY3Mrt6Tq8SobPcyXVoRk/zXrLfWuSVC/HE5PbIoYEtUU6fCuJrAqjI9TzA==
X-Received: by 2002:a05:6a00:2395:b029:304:7a51:6f1d with SMTP id f21-20020a056a002395b02903047a516f1dmr31349705pfc.53.1624982545558;
        Tue, 29 Jun 2021 09:02:25 -0700 (PDT)
Received: from localhost.localdomain ([103.200.106.119])
        by smtp.googlemail.com with ESMTPSA id m14sm19166240pgu.84.2021.06.29.09.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 09:02:25 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v8 7/8] PCI: Add support for ACPI _RST reset method
Date:   Tue, 29 Jun 2021 21:31:03 +0530
Message-Id: <20210629160104.2893-8-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629160104.2893-1-ameynarkhede03@gmail.com>
References: <20210629160104.2893-1-ameynarkhede03@gmail.com>
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
index db4e035cf..ec9fec952 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5116,6 +5116,7 @@ static void pci_dev_restore(struct pci_dev *dev)
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
index a295e621f..d091b2948 100644
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

