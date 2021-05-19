Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F15389A30
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 01:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhESX5W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 19:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhESX5V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 19:57:21 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EDDC061574;
        Wed, 19 May 2021 16:56:00 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t193so10597490pgb.4;
        Wed, 19 May 2021 16:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JID/D/KXtWMVZbJD63Qy/P1niv6pTy4RV0ayNkwMylI=;
        b=KIgRdEc9tBygnG0si+aZz6QPnCZLqGoi8r/tiKBxljEqXvl8h3I9TG19Midl7WkSsB
         GRHNI++c7Bp2cfFPwHF+eZn3mLy+3+oLAqQDnfOgtBTtmRC06PVP1VQGrncSG2J5Fzzo
         /kpLrO0Prgb021SKwGWygj0tt/2+IxqwKzFKAWghG2L3pVv9brDOCMkkeGosheGsepkT
         EeecSwvansL7np+p8Rjw5NOCmteSAIgNnGT7eQGHEOgcL4s8urgoIJgDBeAUilLpCH9N
         bm22ljDnSzpEe9liRgCoPKV0VmhpmP+L9fcM39KGeqO8Qshgtg3BRz4JicIEjA7aLrfW
         yQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JID/D/KXtWMVZbJD63Qy/P1niv6pTy4RV0ayNkwMylI=;
        b=Y26fUsEOO36BN6kO5Wzlt4HBcL1E+gyKHI5vF2izm2BLOGJlYsCIS9vyqb//v52+gp
         OpI/0dQw495J1brIdM4uJArx8J3SzAxkWOTqqFhy945lVM8uWl6CPW6DsO2NdcXGXzG8
         vMejZHMZqbkL3hbVT9fILvxSg6ANR0rMPPj9dPbL5Ow7+UWluAS/a+DlOB9lavHEJSJh
         5cv9eHob/WR4jdhddjPeWmF54Hawov8iZ85Jvp7wFEWdg2tKpkIrfhWJUKOthNVv4MlI
         O1zUTqT1+n8hA49Hu8z8UwemeKysQ2vBcHgbKpueyrl6b35UG9FjXq1SSkvInz30I8sE
         uueA==
X-Gm-Message-State: AOAM530kqiWFtfQE5gO0g3lnQzPwVmRLwvEK+0f22lQ3pNCjokg5l6rr
        Dx9UssQ/xkmJNoCT1OP3Ly8=
X-Google-Smtp-Source: ABdhPJwHNVfl28T31yW0FsTl7GDa+cG/GiO/x0XEtnesypMpVIAw0M0UfS62XDUKa+bwCzQSqpGdWg==
X-Received: by 2002:a65:640c:: with SMTP id a12mr1667768pgv.229.1621468559857;
        Wed, 19 May 2021 16:55:59 -0700 (PDT)
Received: from localhost.localdomain ([94.140.8.39])
        by smtp.googlemail.com with ESMTPSA id z12sm397670pfk.45.2021.05.19.16.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 16:55:59 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, sdonthineni@nvidia.com
Subject: [PATCH RESEND v2 6/7] PCI: Add support for a function level reset based on _RST method
Date:   Thu, 20 May 2021 05:24:25 +0530
Message-Id: <20210519235426.99728-7-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519235426.99728-1-ameynarkhede03@gmail.com>
References: <20210519235426.99728-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Shanker Donthineni <sdonthineni () nvidia ! com>

The _RST is a standard method specified in the ACPI specification. It
provides a function level reset when it is described in the acpi_device
context associated with PCI-device.

Implement a new reset function pci_dev_acpi_reset() for probing RST
method and execute if it is defined in the firmware. The ACPI binding
information is available only after calling device_add(), so move
pci_init_reset_methods() to end of the pci_device_add().

The default priority of the acpi reset is set to below device-specific
and above hardware resets.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 drivers/pci/pci.c   | 30 ++++++++++++++++++++++++++++++
 drivers/pci/probe.c |  2 +-
 include/linux/pci.h |  2 +-
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 664cf2d35..d39dba590 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5076,6 +5076,35 @@ static void pci_dev_restore(struct pci_dev *dev)
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
@@ -5083,6 +5112,7 @@ static void pci_dev_restore(struct pci_dev *dev)
  */
 const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ .reset_fn = &pci_dev_specific_reset, .name = "device_specific" },
+	{ .reset_fn = &pci_dev_acpi_reset, .name = "acpi" },
 	{ .reset_fn = &pcie_reset_flr, .name = "flr" },
 	{ .reset_fn = &pci_af_flr, .name = "af_flr" },
 	{ .reset_fn = &pci_pm_reset, .name = "pm" },
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4764e031a..d4becd6ff 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2403,7 +2403,6 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
 
 	pcie_report_downtraining(dev);
-	pci_init_reset_methods(dev);
 }
 
 /*
@@ -2494,6 +2493,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	dev->match_driver = false;
 	ret = device_add(&dev->dev);
 	WARN_ON(ret < 0);
+	pci_init_reset_methods(dev);
 }
 
 struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9f8347799..b4a5d2146 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -49,7 +49,7 @@
 			       PCI_STATUS_SIG_TARGET_ABORT | \
 			       PCI_STATUS_PARITY)
 
-#define PCI_RESET_FN_METHODS 5
+#define PCI_RESET_FN_METHODS 6
 
 /*
  * The PCI interface treats multi-function devices as independent
-- 
2.31.1

