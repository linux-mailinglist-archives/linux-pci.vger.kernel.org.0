Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C83935A70D
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 21:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbhDITZT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 15:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbhDITZQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Apr 2021 15:25:16 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B836BC061762;
        Fri,  9 Apr 2021 12:25:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y204so2066839wmg.2;
        Fri, 09 Apr 2021 12:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E2K31zv9B7ffj6B6TFciOEn0r2d2kzsg0XNwIGTDF7c=;
        b=g0EEz3xTi5QPMyDjesWwEp3TP9gWo5Hbypko7TJobFBquHgKKGHZGdpcmSK06DrrIX
         8+SjvS43Q9/4Ts/xc68WD7u+V89sPt07lNFq3/gt3ECO+z7cSl+30ZaHnm6unTWmdi9Q
         xvcf3b1ZoaLk8fTguPAK4s5LTCOd+5j76gI+n1WJfOnEr4B/p2ribSm/GPRJWz2JFiWY
         JkVJMlWBtFxfvnOXmlFghXjKkoTwxzkrJlmKOj0Zk5gu8pJlsldItPhfPP6nOYnPGNiP
         Dj+tubRL4CAyKGb+29wwjY1CNP/ThurFLy8OMrb4SAlXahPK+EfdoIatMEydU7/KYA4M
         tAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2K31zv9B7ffj6B6TFciOEn0r2d2kzsg0XNwIGTDF7c=;
        b=HF0vlIsHDqS0bEEFaZmNsZRqJjd/hJ0Mw3Q0R3yabMlQOU6wbGsbF0QM4l8u5Bz5j4
         zQoS8hs5FE3VUpvKWXWXpAdvMht20xQhx4q0R8ykys/doBo1d8uRcCXiNwHjK+OToPQu
         yyY36u0rHCeYlSrdN/maHTOWWBdVlrp4WuXotPPA5CP9nebT7Rox5M78k/HBUDK+tSEd
         VYUVpJLrP/kB0/1xiVzpqwtxLjHjudeP0Tbf4M0EpYYXlAEMjnawv5TF6WL2cudd9Q1N
         vD0Gf4HV9LFIZ02Cr4XagqagXSeZAF/UW6ZRl9OBi0gLQ12WcZpiXom22PTuD4N92pnU
         p5Tw==
X-Gm-Message-State: AOAM5308kQ0KNfF+kTY6eUIt6hhFB54Jblez/tjb4lk7eL62bWkLwmdI
        2MfnWWVF3XCiSUCz/1TaMj8=
X-Google-Smtp-Source: ABdhPJzRF/i7r98esR05I9uBqMtitDyp/0MNnxS965vEwJTyz4WpibmlooA8oBIa4uzRZc09UA+8yA==
X-Received: by 2002:a1c:1d14:: with SMTP id d20mr6895841wmd.49.1617996301390;
        Fri, 09 Apr 2021 12:25:01 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.176])
        by smtp.googlemail.com with ESMTPSA id j6sm6618573wru.18.2021.04.09.12.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 12:25:01 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v2 2/5] PCI: Add pcie_reset_flr to follow calling convention of other reset methods
Date:   Sat, 10 Apr 2021 00:53:21 +0530
Message-Id: <20210409192324.30080-3-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210409192324.30080-1-ameynarkhede03@gmail.com>
References: <20210409192324.30080-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently there is separate function pcie_has_flr to probe
if pcie flr is supported by the device which does not match
the calling convention followed by reset methods which use second
function argument to decide whether to probe or not.
Add new function pcie_reset_flr that follows the calling
convention of reset methods.

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +-
 drivers/pci/pci.c                          | 62 ++++++++++++----------
 drivers/pci/pcie/aer.c                     | 12 ++---
 drivers/pci/quirks.c                       |  9 ++--
 include/linux/pci.h                        |  2 +-
 5 files changed, 43 insertions(+), 46 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
index facc8e6bc..15d6c8452 100644
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
index a8f8dd588..b998d6ad3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4573,32 +4573,12 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_wait_for_pending_transaction);
 
-/**
- * pcie_has_flr - check if a device supports function level resets
- * @dev: device to check
- *
- * Returns true if the device advertises support for PCIe function level
- * resets.
- */
-bool pcie_has_flr(struct pci_dev *dev)
-{
-	u32 cap;
-
-	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
-		return false;
-
-	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
-	return cap & PCI_EXP_DEVCAP_FLR;
-}
-EXPORT_SYMBOL_GPL(pcie_has_flr);
-
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
@@ -4621,6 +4601,31 @@ int pcie_flr(struct pci_dev *dev)
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
+	u32 cap;
+
+	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
+		return -ENOTTY;
+
+	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
+	if (!(cap & PCI_EXP_DEVCAP_FLR))
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
@@ -5100,11 +5105,9 @@ int __pci_reset_function_locked(struct pci_dev *dev)
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
@@ -5135,8 +5138,9 @@ int pci_probe_reset_function(struct pci_dev *dev)
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
index ba2238834..f4e891bd5 100644
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
index 653660e3b..5318833f3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3831,7 +3831,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
 	u32 cfg;
 
 	if (dev->class != PCI_CLASS_STORAGE_EXPRESS ||
-	    !pcie_has_flr(dev) || !pci_resource_start(dev, 0))
+	    pcie_reset_flr(dev, 1) || !pci_resource_start(dev, 0))
 		return -ENOTTY;
 
 	if (probe)
@@ -3900,13 +3900,10 @@ static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
  */
 static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
 {
-	if (!pcie_has_flr(dev))
-		return -ENOTTY;
+	int ret = pcie_reset_flr(dev, probe);
 
 	if (probe)
-		return 0;
-
-	pcie_flr(dev);
+		return ret;
 
 	msleep(250);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 979d54335..8d20e51ab 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1217,7 +1217,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pci_bus_speed *speed,
 			     enum pcie_link_width *width);
 void pcie_print_link_status(struct pci_dev *dev);
-bool pcie_has_flr(struct pci_dev *dev);
+int pcie_reset_flr(struct pci_dev *dev, int probe);
 int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
-- 
2.31.1

