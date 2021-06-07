Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E6839E679
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 20:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFGSYs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 14:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFGSYr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 14:24:47 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F74C061766;
        Mon,  7 Jun 2021 11:22:43 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 69so9186175plc.5;
        Mon, 07 Jun 2021 11:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iNHrhq0IL96XZ0EI6v9hmr0ajyowuoqEGQEPG1rii/A=;
        b=L+XKyK9Xc/iP3xTzUjajXyy/0+DpVV+nzcEUa1HjSrX7McmLVt0we7X0ORMACcJgOu
         yeJCMAg+k19OdXBwPvh7c69u1/+evJzWDI8vfBioPgZrKBZhBE1AHH5gcySMN8BiOwJp
         GZla0MTWk3vIvF3Qj3esUtQMr+eIAa+Vq39XcP0AjZZMzb6evwVbL/PHPszcRMcpLhIP
         Abvr9n3ui7gNXbAneO/0XoAOrSneIZQ4CUeiraBWOIAhBRvBfCVps5Iu8GabKnAZ40r/
         BlDXtH20og75bN11CmEWwq/KU74wMeXxD9MBMoe+V40fQyQwsfTWb3JBvIsptfc0Q2Kx
         zowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iNHrhq0IL96XZ0EI6v9hmr0ajyowuoqEGQEPG1rii/A=;
        b=fy/QtNOPmDuRvm3EzUCNZ9i3KZSbF0AyJ2fNaM2v457BUk1jDF5qLtC/gfGQBtYQb+
         5VokcncbDDdfNyu8z45+nC2ynT3CEjeeHZqWmLxEwWPbkMfDmqN/UG08W1PkFJEH94LN
         NBplcetQ2Z0HkuZCeGh40QOsezsj1mHVeepxRMQsA8q1D9rc7s3tUBaxCnwWIHCVZ2Y0
         JrZbIHvIPN1IO6lMJCQH8Y1iAdIlhf26Vw1JscEEJeqlDKIntdQVaAYMtqBv7Onvj82L
         q/yaPTZcUv/05buPtEeG+FuCGDtpKACMwiZT7/onyW/nawz/RHVBd6S3xmwNyQ4i5xJD
         w9DQ==
X-Gm-Message-State: AOAM531Zjpm3FugxCJI9NxR3gm9B/ZZch7OPx9bevC87RMOTklK6HNFy
        sPNDL+MluXDDCfg9aHcd/sc=
X-Google-Smtp-Source: ABdhPJyTd0NkNIcVCMuvAgAaJVLy0DNbcZp4xeRSF9wybLHr5rTfUZdUo3r56WY3t6PsjWEfuu2HGw==
X-Received: by 2002:a17:90a:9511:: with SMTP id t17mr22014125pjo.108.1623090163365;
        Mon, 07 Jun 2021 11:22:43 -0700 (PDT)
Received: from localhost.localdomain ([103.200.106.115])
        by smtp.googlemail.com with ESMTPSA id k1sm8687656pfa.30.2021.06.07.11.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 11:22:43 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v6 6/8] PCI: Add support for ACPI _RST reset method
Date:   Mon,  7 Jun 2021 23:51:35 +0530
Message-Id: <20210607182137.5794-7-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210607182137.5794-1-ameynarkhede03@gmail.com>
References: <20210607182137.5794-1-ameynarkhede03@gmail.com>
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

