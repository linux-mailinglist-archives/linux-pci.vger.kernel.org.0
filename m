Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A713914A4
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 12:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbhEZKQT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 06:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbhEZKQL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 06:16:11 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77485C061574;
        Wed, 26 May 2021 03:14:39 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 6so543210pgk.5;
        Wed, 26 May 2021 03:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+kjX7vYmWzq1R7BiwbLx/rhOeELktigh7hpXVvkPMNY=;
        b=Kc62qixb7dfoIVA0r72e1gyF4+gAgQF2SHyd1a9L6gWrzisLbu/LIRmjV7G9d5oIYl
         r1GoFUECGM5dSEMe3pegNQ6oVUIUKw38TA0mWOnfw61WGoaPPVrh3/T4MBNeqfih0tmG
         BqUYr+7CwGoRGrJv5IGSBgvFp8ZyuD8Il/1b2TTARqxtQReAjavl8MH2KxSlXV44Q7D/
         1nvGhXzAF8tCgwPWaq3ngNVICUIvOa2TymWUXJhlGdFL8zo39j3YE1FEEjM0WQgnmkvl
         smIspmbjgi1tUML8maQh+KjwgbLTr15hWKY6+1TSSh4YxrD/x5bZJuUI6lfpBuU1dk6Q
         B9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+kjX7vYmWzq1R7BiwbLx/rhOeELktigh7hpXVvkPMNY=;
        b=SR2FumBe3GnfRsg/i5eHgZsk0JlNCchE4iyxyOlTU6WITV47YAxjKcI74Z2O1zu0ac
         AmWcLbnT2Q6UJG2/tN7NO30ft+DIewBRQSV23cvOOJ21mc27Icmcn9qtOG+Vpimewq91
         IcCvnrDdP6Be/awD/qEG0SLnq43xp+xMaz3m2LRBmgFqKKIJD1UovMMO3fHfICC02+vM
         H62aeUt5vEYVsEYD5HzkIg0GV4tsujs6z8pUASQKdL8fyiDgqoXEvpugEnkVTsz59ExC
         Uoljhd3I3vm5mQ6P7U9ubERZey3LUHKj6eeiS8bLVlgFuYn+vpcS5a/A1YMccyUp9nBD
         XSzA==
X-Gm-Message-State: AOAM531CZl7GGTtTNlC2huSDt2JNIlMNxX+ki17Glxx8HlQEiKRXJP2f
        3WGI+1KVN9NdRJNthRxI17k=
X-Google-Smtp-Source: ABdhPJxlFWUhQojQqlHx+vSpFlxlKtAO1T+xcBFll70bQ2ATBzvxJiLSMF3BK9Z4Yx2kYk9q1SccYQ==
X-Received: by 2002:a63:d709:: with SMTP id d9mr24393260pgg.337.1622024079086;
        Wed, 26 May 2021 03:14:39 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.164])
        by smtp.googlemail.com with ESMTPSA id c191sm15662614pfc.94.2021.05.26.03.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 03:14:38 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v3 5/7] PCI: Add support for a function level reset based on _RST method
Date:   Wed, 26 May 2021 15:44:01 +0530
Message-Id: <20210526101403.108721-6-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526101403.108721-1-ameynarkhede03@gmail.com>
References: <20210526101403.108721-1-ameynarkhede03@gmail.com>
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
information is available only after calling device_add(), so move
pci_init_reset_methods() to end of the pci_device_add().

The default priority of the acpi reset is set to below device-specific
and above hardware resets.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Reviewed-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/pci/pci.c   | 30 ++++++++++++++++++++++++++++++
 drivers/pci/probe.c |  2 +-
 include/linux/pci.h |  2 +-
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fad209c5f..1d859b100 100644
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
 	{ &pci_dev_specific_reset, .name = "device_specific" },
+	{ &pci_dev_acpi_reset, .name = "acpi" },
 	{ &pcie_reset_flr, .name = "flr" },
 	{ &pci_af_flr, .name = "af_flr" },
 	{ &pci_pm_reset, .name = "pm" },
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
index e9603d638..9bec3c616 100644
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

