Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018A8394DE4
	for <lists+linux-pci@lfdr.de>; Sat, 29 May 2021 21:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhE2T1c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 May 2021 15:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhE2T12 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 May 2021 15:27:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D6CC061761;
        Sat, 29 May 2021 12:25:51 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f3-20020a17090a4a83b02901619627235bso2260791pjh.1;
        Sat, 29 May 2021 12:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VonPpqeifCpx/rhRuWJbeDZ8TUbllujK6CrQIjhpWII=;
        b=Vge6YOWL7wF4rp7Ah5iEVuABfZWkEX9Vj1czcDauD6rbyXB2B9A9lAqmezQH+cN9IU
         IPLVQ4hpQ8T4msKdagDdbTLi9QWpkLzar0jAbCbvY+uDG30mquf1ppRpY+tXh34O7nhU
         BZtVvbNnyFGUh7ITOrH5+oAl6Of4AqUQInNZSlcJsnU9YJMi/2JcFuFacuvon1bZoyRL
         yvaaoo4i7grrKmVVVsIY7PEerahOK6XKAcWypEXpiAv8AacxXsXRstWLapyAp3uyDB2F
         mEINSVdZ3348KXB7g25doXnkoeuGKZStmDidMF7Cuq0YiuYS5yO0Gi6hai0k5zxm0qMm
         PDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VonPpqeifCpx/rhRuWJbeDZ8TUbllujK6CrQIjhpWII=;
        b=OjdJOoOOmTifq5gO1ejngHADQrePVkQupS3bGPSmXV1BzuywCGtkl59Wfieim7uh0B
         dDd9AipcsM870BuS0DXzn3yGv35TUATzDXb6VbpEYf4EE3pKjD7ILrAee61CjZSxzg/F
         VUfaaBbvOq8A5Epql7vFeMvTp+Ag8/Ehgq3oD/94md3crXvaDhjvSKzqOqnay1698kUI
         DYZXNt5X8LFArbZNXx6It+WYwTZaWyghhrGJ7WM+PS82GwmrTHIeXsRNPaMtg6o3Iaml
         tDr0Npf8NP8FTAfY5DjGmU38tdZO52qEPVE9+sEA1ECe/hPxo8AHewoXpZRfLQtV/gF/
         Tckg==
X-Gm-Message-State: AOAM5337NeIF6tkuCMxZEKF5rz/jOBz/rkSRhAejJdE3td02tgw76m1U
        uBB9KPreC2z4DIv+8VZ54/SZiRu56gwgUw==
X-Google-Smtp-Source: ABdhPJzWOCtEW8eDeZOfb181fTEjC1J7EUg2hUWokvbKaB2iBxYJ5fe8vjbjmE/fyyob/OKocSaYew==
X-Received: by 2002:a17:90a:ea10:: with SMTP id w16mr10533853pjy.46.1622316351067;
        Sat, 29 May 2021 12:25:51 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.172])
        by smtp.googlemail.com with ESMTPSA id ge5sm7286754pjb.45.2021.05.29.12.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 12:25:50 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v5 5/7] PCI: Add support for a function level reset based on _RST method
Date:   Sun, 30 May 2021 00:55:25 +0530
Message-Id: <20210529192527.2708-6-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529192527.2708-1-ameynarkhede03@gmail.com>
References: <20210529192527.2708-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Shanker Donthineni <sdonthineni@nvidia.com>

The _RST is a standard method specified in the ACPI specification. It
provides a function level reset when it is described in the acpi_device
context associated with PCI-device.

Implement a new reset function pci_dev_acpi_reset() for probing RST
method and execute if it is defined in the firmware. The ACPI binding
information is available only after calling device_add(). To consider
_RST method, move pci_init_reset_methods() to end of pci_device_add()
and craete two sysfs entries reset & reset_methond from
pci_create_sysfs_dev_files()

The default priority of the acpi reset is set to below device-specific
and above hardware resets.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Reviewed-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/pci/pci-sysfs.c | 23 ++++++++++++++++++++---
 drivers/pci/pci.c       | 30 ++++++++++++++++++++++++++++++
 drivers/pci/probe.c     |  2 +-
 include/linux/pci.h     |  2 +-
 4 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 04b3d6565..b332d7923 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1482,12 +1482,30 @@ static const struct attribute_group pci_dev_reset_attr_group = {
 	.is_visible = pci_dev_reset_attr_is_visible,
 };
 
+const struct attribute_group *pci_dev_reset_groups[] = {
+	&pci_dev_reset_attr_group,
+	&pci_dev_reset_method_attr_group,
+	NULL,
+};
+
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
+	int retval;
+
 	if (!sysfs_initialized)
 		return -EACCES;
 
-	return pci_create_resource_files(pdev);
+	retval = pci_create_resource_files(pdev);
+	if (retval)
+		return retval;
+
+	retval = device_add_groups(&pdev->dev, pci_dev_reset_groups);
+	if (retval) {
+		pci_remove_resource_files(pdev);
+		return retval;
+	}
+
+	return 0;
 }
 
 /**
@@ -1501,6 +1519,7 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 	if (!sysfs_initialized)
 		return;
 
+	device_remove_groups(&pdev->dev, pci_dev_reset_groups);
 	pci_remove_resource_files(pdev);
 }
 
@@ -1594,8 +1613,6 @@ const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_group,
 	&pci_dev_config_attr_group,
 	&pci_dev_rom_attr_group,
-	&pci_dev_reset_attr_group,
-	&pci_dev_reset_method_attr_group,
 	&pci_dev_vpd_attr_group,
 #ifdef CONFIG_DMI
 	&pci_dev_smbios_attr_group,
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bbed852d9..4a7019d0b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5115,6 +5115,35 @@ static void pci_dev_restore(struct pci_dev *dev)
 		err_handler->reset_done(dev);
 }
 
+/**
+ * pci_dev_acpi_reset - do a function level reset using _RST method
+ * @dev: device to reset
+ * @probe: check if _RST method is included in the acpi_device context.
+ */
+static int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
+{
+#ifdef CONFIG_ACPI
+	acpi_handle handle = ACPI_HANDLE(&dev->dev);
+
+	/* Return -ENOTTY if _RST method is not included in the dev context */
+	if (!handle || !acpi_has_method(handle, "_RST"))
+		return -ENOTTY;
+
+	/* Return 0 for probe phase indicating that we can reset this device */
+	if (probe)
+		return 0;
+
+	/* Invoke _RST() method to perform a function level reset */
+	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
+		pci_warn(dev, "Failed to reset the device\n");
+		return -EINVAL;
+	}
+	return 0;
+#else
+	return -ENOTTY;
+#endif
+}
+
 /*
  * The ordering for functions in pci_reset_fn_methods
  * is required for reset_methods byte array defined
@@ -5122,6 +5151,7 @@ static void pci_dev_restore(struct pci_dev *dev)
  */
 const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ &pci_dev_specific_reset, .name = "device_specific" },
+	{ &pci_dev_acpi_reset, .name = "acpi" },
 	{ &pcie_reset_flr, .name = "flr" },
 	{ &pci_af_flr, .name = "af_flr" },
 	{ &pci_pm_reset, .name = "pm" },
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 90fd4f61f..eeab791a0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2404,7 +2404,6 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
 
 	pcie_report_downtraining(dev);
-	pci_init_reset_methods(dev);
 }
 
 /*
@@ -2495,6 +2494,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	dev->match_driver = false;
 	ret = device_add(&dev->dev);
 	WARN_ON(ret < 0);
+	pci_init_reset_methods(dev);
 }
 
 struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
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

