Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B333C238F
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jul 2021 14:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhGIMl5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jul 2021 08:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbhGIMl4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jul 2021 08:41:56 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31194C0613DD;
        Fri,  9 Jul 2021 05:39:13 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id u14so9802831pga.11;
        Fri, 09 Jul 2021 05:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cUyFfTZzWLY1nC0kNlDEdNgOhsBcCI3jl7nSUjoy+o0=;
        b=QZhedZYEIRQSSE5JTlonKGI53skEEqlVQos8G0jvcdsnsE34E9ImJJafd/CxoCjb33
         88iwvQSSlzjRtbcrobyrWCU8R9DSyNh0nNjJMceGWvXNUVPWTZhDnc9Cxi1oCFcTTyjn
         oUbqHoZ1NiwZddTjGdypEOWr6IpW+sX0g75XtPhSzF/oRKURtq8ENR6l2uaaejnUbEzo
         2984T/fDzdtX3sLvU3mum7psRgP94pn3KZCC691fhVmZp0FHJ0sQ43zCMKZMvzk2MZ0X
         9B9ptutLGQc9oavbDuLZRznhwxo/Y90QRxNNQaKz20Xw4DMjkyG8nb/YFyHH5cJFMdSK
         9cBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cUyFfTZzWLY1nC0kNlDEdNgOhsBcCI3jl7nSUjoy+o0=;
        b=bJVh+a8Aiw/tSz1h+ZwjSm4QrhcQpfbnhpyUvkrSkhAGyWb/AdH4h9v+oPYU+Xhv2n
         SDL6w3Mf+X2EZOsJ1yDhKe84Ql8qQy2qYZSMYT4O431TOl9sC7wkXfzlFasHpr4onkRj
         MF44tR2FbNKW5O49P8lBOAxkG++ZaYQa3jOeEpoXmX7vsM+1TiURqCzCupWk1BQfb/40
         aHHz5eIaWyxI04K8rG3P+ffrWgsuV59w60gytetKBHAndkSiXywM6KzmZQLMs51qNua/
         cGLV3S828rBPOCoeDVOjgKK59ilU4Ym4c6urT1/P+IaUrPWtijIuUYATOkrfJYuOeXFY
         p/Yg==
X-Gm-Message-State: AOAM532t3uSlGMmA9PmkB5M9bj/g08qIKsit44ITuIG+JmeghqpT6eyS
        uN24s0kMSFgpwE8ikKiZyr8=
X-Google-Smtp-Source: ABdhPJzjSF2eo8qpZTy80mtXDS1g48VSmwvXx8b4nhoNMpx9sv6ewwMJRK1l4c97XbjAbh7ZXJRMAA==
X-Received: by 2002:a63:1c1f:: with SMTP id c31mr37542917pgc.380.1625834352811;
        Fri, 09 Jul 2021 05:39:12 -0700 (PDT)
Received: from localhost.localdomain ([152.57.176.46])
        by smtp.googlemail.com with ESMTPSA id j6sm5592402pji.23.2021.07.09.05.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 05:39:12 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v10 7/8] PCI: Add support for ACPI _RST reset method
Date:   Fri,  9 Jul 2021 18:08:12 +0530
Message-Id: <20210709123813.8700-8-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210709123813.8700-1-ameynarkhede03@gmail.com>
References: <20210709123813.8700-1-ameynarkhede03@gmail.com>
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

