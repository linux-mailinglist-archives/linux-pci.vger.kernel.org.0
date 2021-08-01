Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9613DCC10
	for <lists+linux-pci@lfdr.de>; Sun,  1 Aug 2021 16:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbhHAO0K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Aug 2021 10:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbhHAO0G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Aug 2021 10:26:06 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA75C0613D3;
        Sun,  1 Aug 2021 07:25:57 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so21222157pjh.3;
        Sun, 01 Aug 2021 07:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TId0+h1i0453gBoMtZ8h2dF7+pQvpWYMri1/rxv1pP0=;
        b=JI7zjw3pxagniDhA3I2lmCh1d3pddu3H4AAeZPd94IiM8rEmEM6p1HHhj5RvH6xIAS
         NlYBK4i9cesMsl14ZgZeTeScXsWeSsvgNzr+lEHOuAIVGe53L4HirxSHKb7dG9H9P2W2
         i5ocP5u5g58FxSkz+d8bTYC72CPLgd1b7VMpDAwQLZ7SgF8Aok9bsMqn+Lg2cqQdZef4
         OwFeEUeMh1PengCXFeot554tR4uEFN/mP7Q/HRWun8yExt/4JPkx9aqqhPzhkwlQ8Poq
         iUaD6ysWP3f0nlECi+LDbYYwJ8iZZcZtFeUZeqRFhdi/HfFJiM+/zJ+gs7W1qlCoglGE
         rBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TId0+h1i0453gBoMtZ8h2dF7+pQvpWYMri1/rxv1pP0=;
        b=AttinE+Ula7vJiTeSHE21Bf5ljl2FFEOqs1/ByB6/Q5InFNxU+5v/ZKIGhoumnIsjf
         XrgOxoxgOhfym6TYH8vNmXG/P6V5N82pRKeR69/REtUXXEtLZYe0k0SnMnQrMaOgjIhb
         ePLGHCZqdoZrGulKN5RqNZaGsQqGH52woQ6VcnSeqz8fpdToOfpeKIw2fgUL0DwvLoah
         2fy0GHdn9texz5FkEP7G7S7TjtfYFtaGrzRzVPJ6XDa9KY6oJ1c9akDwXaiXvuPqufph
         69Vkh4q9Ue8/laaPo4b4PJvgOv3/5mUa5f5KAqx0ePxMERLWCbwqbvemlGy5trs/CVo8
         H6Lg==
X-Gm-Message-State: AOAM533ZmBO3WRELB5Vp1ksqSg12b6c/kWlGHJwYZRAVUsP9C/Vk7ove
        nD4lJpgZdUK9EIYUF4c6lig=
X-Google-Smtp-Source: ABdhPJzWUp4dP0cIaaxZqOcyxwH7SjWmw7ClMfuc+OciGeMjaev3sSR0rQbX2uT27FQAxFE9tmT4jQ==
X-Received: by 2002:a63:f557:: with SMTP id e23mr7918501pgk.344.1627827956929;
        Sun, 01 Aug 2021 07:25:56 -0700 (PDT)
Received: from localhost.localdomain ([139.5.31.186])
        by smtp.googlemail.com with ESMTPSA id g11sm7740897pju.13.2021.08.01.07.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 07:25:56 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v13 8/9] PCI: Add support for ACPI _RST reset method
Date:   Sun,  1 Aug 2021 19:55:17 +0530
Message-Id: <20210801142518.1224-9-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210801142518.1224-1-ameynarkhede03@gmail.com>
References: <20210801142518.1224-1-ameynarkhede03@gmail.com>
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
index c496cd164aca..36121b1fbcab 100644
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
