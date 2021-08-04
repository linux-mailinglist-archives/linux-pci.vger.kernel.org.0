Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D9B3E097F
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 22:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbhHDUme (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 16:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240935AbhHDUme (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 16:42:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7ADC0613D5;
        Wed,  4 Aug 2021 13:42:21 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so1683089pjn.4;
        Wed, 04 Aug 2021 13:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QGIaZKmJnYLgfJFGtm4M+hFdHDcRRrwJy+othd6lRXc=;
        b=n5WcfmLWPTJNRY5z9Lz2+R/11AYta1o7xf1cXQBNUAG40520BY1dpJ7R72KbWUwPnN
         osGbuG5UltsGhk5lCXxtrTva6qcOxbbTtv4AvQ6b4WnIp68XE2qxhuJP9bNIcB5px25b
         4TrL4HVc6vDrtHrR+KIorB9udjj7MeseI0QbGVoCbUEUaAQgnFcaiFYo/DWbiVnyF6uy
         ueEao9gOoooijLHYF8oHmPalBR5kVJwdnOpJvIL+bWN96fvKi575iFa4Z3zA1HhuST70
         4dCymv3B6U8SksiWDwpVodDeo2ILwGij4rqBZkcP82Yqp3WTVGtqeB7cMGB4EqbFvLNY
         wMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QGIaZKmJnYLgfJFGtm4M+hFdHDcRRrwJy+othd6lRXc=;
        b=eOLRS7lOKzbMLMKUv0Z5jfP/4oqMvh+F1rekVOy7fH7Y5S5HL/yQdPKLvfU+qN1wEh
         QUHzBsrwEJ1eGitCYd+4556FlbvcMVxPHg1/p/+g4Ywqjf+aiuJYksGDQFMU6iQjzSOF
         N069XQtB29r4heozsHECw8g/vs4LXbouO0oaw0DnPr92TuqDvY96hKkDO1UUNFNx+6p3
         e9TmX5qBmTACdgeKbXRrM58vqXNK/tTylDgqqoJ/zh711yul1PFp/RwqgBRNvVecZCB9
         VC6qfj+OxX3CkSJNpyPjmwuVaI4Gz+8z400NMgKJQlXvfeI0HCe+TWfILT1E66mcASYk
         GIvw==
X-Gm-Message-State: AOAM531CKWLQ60igfmunDMgSxiKWL/WwvjRRzM312wc4bNwOuzbo24gz
        aYexaq+IpTOa31YgQiXwI28=
X-Google-Smtp-Source: ABdhPJyiokwLsx+xvhJrpasK2S0pzLmLdFbGVDZhkNVmfV3VHVhn68gf3B6rUNQvnTBJdG4mgSWGKg==
X-Received: by 2002:a05:6a00:140f:b029:3ad:1fe4:70ff with SMTP id l15-20020a056a00140fb02903ad1fe470ffmr1470741pfu.71.1628109740605;
        Wed, 04 Aug 2021 13:42:20 -0700 (PDT)
Received: from localhost.localdomain ([139.5.31.161])
        by smtp.googlemail.com with ESMTPSA id w2sm7064922pjt.14.2021.08.04.13.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 13:42:20 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v14 2/9] PCI: Add pcie_reset_flr to follow calling convention of other reset methods
Date:   Thu,  5 Aug 2021 02:11:54 +0530
Message-Id: <20210804204201.1282-3-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210804204201.1282-1-ameynarkhede03@gmail.com>
References: <20210804204201.1282-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently there is separate function pcie_has_flr() to probe if PCIe FLR
is supported by the device which does not match the calling convention
followed by reset methods which use second function argument to decide
whether to probe or not. Add new function pcie_reset_flr() that follows
the calling convention of reset methods.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +--
 drivers/pci/pci.c                          | 40 +++++++++++++++-------
 drivers/pci/pcie/aer.c                     | 12 +++----
 drivers/pci/quirks.c                       |  9 ++---
 include/linux/pci.h                        |  2 +-
 5 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
index facc8e6bc580..15d6c8452807 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_main.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
@@ -306,9 +306,7 @@ static int nitrox_device_flr(struct pci_dev *pdev)
 		return -ENOMEM;
 	}
 
-	/* check flr support */
-	if (pcie_has_flr(pdev))
-		pcie_flr(pdev);
+	pcie_reset_flr(pdev, 0);
 
 	pci_restore_state(pdev);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1fafd05caa41..7d1d9671160b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4619,22 +4619,20 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
  * Returns true if the device advertises support for PCIe function level
  * resets.
  */
-bool pcie_has_flr(struct pci_dev *dev)
+static bool pcie_has_flr(struct pci_dev *dev)
 {
 	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
 		return false;
 
 	return FIELD_GET(PCI_EXP_DEVCAP_FLR, dev->devcap) == 1;
 }
-EXPORT_SYMBOL_GPL(pcie_has_flr);
 
 /**
  * pcie_flr - initiate a PCIe function level reset
  * @dev: device to reset
  *
- * Initiate a function level reset on @dev.  The caller should ensure the
- * device supports FLR before calling this function, e.g. by using the
- * pcie_has_flr() helper.
+ * Initiate a function level reset unconditionally on @dev without
+ * checking any flags and DEVCAP
  */
 int pcie_flr(struct pci_dev *dev)
 {
@@ -4657,6 +4655,25 @@ int pcie_flr(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
 
+/**
+ * pcie_reset_flr - initiate a PCIe function level reset
+ * @dev: device to reset
+ * @probe: If set, only check if the device can be reset this way.
+ *
+ * Initiate a function level reset on @dev.
+ */
+int pcie_reset_flr(struct pci_dev *dev, int probe)
+{
+	if (!pcie_has_flr(dev))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	return pcie_flr(dev);
+}
+EXPORT_SYMBOL_GPL(pcie_reset_flr);
+
 static int pci_af_flr(struct pci_dev *dev, int probe)
 {
 	int pos;
@@ -5137,11 +5154,9 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 	rc = pci_dev_specific_reset(dev, 0);
 	if (rc != -ENOTTY)
 		return rc;
-	if (pcie_has_flr(dev)) {
-		rc = pcie_flr(dev);
-		if (rc != -ENOTTY)
-			return rc;
-	}
+	rc = pcie_reset_flr(dev, 0);
+	if (rc != -ENOTTY)
+		return rc;
 	rc = pci_af_flr(dev, 0);
 	if (rc != -ENOTTY)
 		return rc;
@@ -5172,8 +5187,9 @@ int pci_probe_reset_function(struct pci_dev *dev)
 	rc = pci_dev_specific_reset(dev, 1);
 	if (rc != -ENOTTY)
 		return rc;
-	if (pcie_has_flr(dev))
-		return 0;
+	rc = pcie_reset_flr(dev, 1);
+	if (rc != -ENOTTY)
+		return rc;
 	rc = pci_af_flr(dev, 1);
 	if (rc != -ENOTTY)
 		return rc;
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ec943cee5ecc..98077595a73e 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1405,13 +1405,11 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	}
 
 	if (type == PCI_EXP_TYPE_RC_EC || type == PCI_EXP_TYPE_RC_END) {
-		if (pcie_has_flr(dev)) {
-			rc = pcie_flr(dev);
-			pci_info(dev, "has been reset (%d)\n", rc);
-		} else {
-			pci_info(dev, "not reset (no FLR support)\n");
-			rc = -ENOTTY;
-		}
+		rc = pcie_reset_flr(dev, 0);
+		if (!rc)
+			pci_info(dev, "has been reset\n");
+		else
+			pci_info(dev, "not reset (no FLR support: %d)\n", rc);
 	} else {
 		rc = pci_bus_error_reset(dev);
 		pci_info(dev, "%s Port link has been reset (%d)\n",
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d85914afe65a..b48e7ef8b641 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3819,7 +3819,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
 	u32 cfg;
 
 	if (dev->class != PCI_CLASS_STORAGE_EXPRESS ||
-	    !pcie_has_flr(dev) || !pci_resource_start(dev, 0))
+	    pcie_reset_flr(dev, 1) || !pci_resource_start(dev, 0))
 		return -ENOTTY;
 
 	if (probe)
@@ -3888,13 +3888,10 @@ static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
  */
 static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
 {
-	if (!pcie_has_flr(dev))
-		return -ENOTTY;
-
 	if (probe)
-		return 0;
+		return pcie_reset_flr(dev, 1);
 
-	pcie_flr(dev);
+	pcie_reset_flr(dev, 0);
 
 	msleep(250);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 697b1f085c7b..aa85e7d3147e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1226,7 +1226,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pci_bus_speed *speed,
 			     enum pcie_link_width *width);
 void pcie_print_link_status(struct pci_dev *dev);
-bool pcie_has_flr(struct pci_dev *dev);
+int pcie_reset_flr(struct pci_dev *dev, int probe);
 int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
-- 
2.32.0

