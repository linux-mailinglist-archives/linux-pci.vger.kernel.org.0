Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EC939149D
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 12:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhEZKQA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 06:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbhEZKP5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 06:15:57 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44608C061574;
        Wed, 26 May 2021 03:14:25 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g18so575440pfr.2;
        Wed, 26 May 2021 03:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vS7pC/Zrqej82Rga5YQdc9qfSyupzEHK9rNj2l815Fo=;
        b=vGghltiLpazoUIr7g5swBoJjkRgIreKttmaSbR/nFMMXM11JX15vSgAT9q+99kMu+v
         OJToVkt0rvvzWQNvGH4NpYSIolcmTmwSF2YLu+8daEWHHggWypM54IsTmJuAF6rivNQR
         pB9FS20vRBq/Q3aGnhMa8qaqLpizy9XJMMPMj3rISm/kEyrI4Vy8ACQa4ZIRYNhqpz2R
         WEIu4AQN7riGWwt6FMJ3c+xPjK7K0GjNNcIat+R8ouQN1j/exPkCT6HFg7/AmahAnN+e
         jIKONKLZd8KmkDB/4/CMJiaRxiEn+vfQggTKnxonuZbRYBQNpBaOIVhZHnQIyPPxXXIN
         veuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vS7pC/Zrqej82Rga5YQdc9qfSyupzEHK9rNj2l815Fo=;
        b=cTpvD/gUHUvfzLajZDbawd2xUwvKJix0Msl1J+ag5S6T3yLO1iqJtCwVzm/lsdEaHa
         X6ySIaDKVZwSXmFx9yrsF/JtNEGXiFeXTu1kqGvu1S1k5BYprME6VQ2e/8pE5cQ271qu
         QtGAd3+BxHymRhZUPvhNnO/LWr2lvTRnBE8Ry+f0vdpqT1EYnFL/br7ty4kxvqAvYMEM
         B5//+0S3ok/cOWbGARveOvkGmQ+2/0dey85HSx54rfsYzh1xFxihQA/Cfg3ztzWTzgvl
         /YP3E6PgcadiFeDnpiiibuDjqJEcUVppLah3Atd5NqTvhF5muTldIcq7neV1xEBNnp01
         jvwg==
X-Gm-Message-State: AOAM532qgD5ScuvnPxvh3fotQMp5AqQMVMMwLQbS5wTXpeRZuDDc4m6R
        j30kh75z+9ZCuOy3he2ZQXM=
X-Google-Smtp-Source: ABdhPJxGE3qj5KJ9jQUHo9lMGDpgPr4mor8NXPphOXYduiYwQezvdVHdeURu2okTdWFmL4xO22VY/w==
X-Received: by 2002:aa7:828c:0:b029:2d2:3231:7ef8 with SMTP id s12-20020aa7828c0000b02902d232317ef8mr34231181pfm.80.1622024064679;
        Wed, 26 May 2021 03:14:24 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.164])
        by smtp.googlemail.com with ESMTPSA id c191sm15662614pfc.94.2021.05.26.03.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 03:14:24 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v3 1/7] PCI: Add pcie_reset_flr to follow calling convention of other reset methods
Date:   Wed, 26 May 2021 15:43:57 +0530
Message-Id: <20210526101403.108721-2-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526101403.108721-1-ameynarkhede03@gmail.com>
References: <20210526101403.108721-1-ameynarkhede03@gmail.com>
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
index 8f79804c6..7cacb6d21 100644
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
index 86c799c97..35c8e9e7e 100644
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

