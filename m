Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1ED639EE5F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 07:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFHFwN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 01:52:13 -0400
Received: from mail-oo1-f41.google.com ([209.85.161.41]:36667 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhFHFwN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 01:52:13 -0400
Received: by mail-oo1-f41.google.com with SMTP id d27-20020a4a3c1b0000b029024983ef66dbso1946920ooa.3;
        Mon, 07 Jun 2021 22:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VqQOpJKxzJ4iXeJuu/O3h8CrpjPwv08YHWrIZDj9y8w=;
        b=vXVq3kg7iBmzNdHm7rcNCEas+iWTWddHDyMnijA/06RRczurlwgFAi5/ZuAiyoZcU6
         3cV1diAVuRA+gJ3s3bezM4KqmLQ5/VOLb0hhCyhB7LTwtCuy1x8wcZhsWHcaQ+M3E5hb
         1r0+c3pKCyDSLD41d+s00lgdX06Z8r4xGbK4vy2z9vnQsNhAL4ZWzWLGRqBaZR9kiZJy
         Abann3zHhcdjlt62FF7cV9bYWwaRAeWIVIx7NgVjJWsSRCrzwFzNCkARJ54TJ0Pr6nKY
         E1pPqXa8fcwP6xNfsNXMbS3eG5eREh/mWCUJ+q8yPeuqFFaXZVAQXQ+NNsHjV9JwY4po
         bAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VqQOpJKxzJ4iXeJuu/O3h8CrpjPwv08YHWrIZDj9y8w=;
        b=PnSA12djoigjx3YDgSvhu7ybKCzjb+xAAO1hKtAzEmGxaf/QDGM8Xuj0U6W2FdRJxb
         Lt0BXfwS+JtMrWMIKZzqAASKXVoYzOl2RRNmqgYgNLJ8NGi6EAp/6LIeCWD8jPkqAJxu
         1VCpmX16pwDx9IwxL+ToDC9XN54t631ymVi48VznDldmVLZwSYzcRC3QV3he6IxF9i8J
         UR5HongsHn/Hy29aYv32SywfBn9I9iFh0O5OPjMWbD6sovRStx4BS/aWLZ60phjwPC20
         6E0sjtpTE1yuku5m43LwjkaUb2MSvX64GiI0Ij8qX6Mi5HP/wRowzQN1Ip15f3Vx19B5
         TBZQ==
X-Gm-Message-State: AOAM532We1c/mrSt86zp1zbz4KbXj3+ybJL0n17G4gr60/D8lq1LYJj/
        QB395dTeUMvusCoA0PN/9zw=
X-Google-Smtp-Source: ABdhPJynFv1qs14lrk/aTa9NBIlmEi8hC98QVfwIqlVMhpLXBNmvPihMw+2RRZ1K16M6Ia3HbgqF6g==
X-Received: by 2002:a4a:625a:: with SMTP id y26mr15956686oog.38.1623131351895;
        Mon, 07 Jun 2021 22:49:11 -0700 (PDT)
Received: from localhost.localdomain (static-198-54-128-46.cust.tzulo.com. [198.54.128.46])
        by smtp.googlemail.com with ESMTPSA id o2sm2489730oom.26.2021.06.07.22.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 22:49:11 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v7 1/8] PCI: Add pcie_reset_flr to follow calling convention of other reset methods
Date:   Tue,  8 Jun 2021 11:18:50 +0530
Message-Id: <20210608054857.18963-2-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608054857.18963-1-ameynarkhede03@gmail.com>
References: <20210608054857.18963-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently there is separate function pcie_has_flr() to probe if pcie flr is
supported by the device which does not match the calling convention
followed by reset methods which use second function argument to decide
whether to probe or not.  Add new function pcie_reset_flr() that follows
the calling convention of reset methods.

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
index 452351025..3bf36924c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4611,32 +4611,12 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
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
@@ -4659,6 +4639,31 @@ int pcie_flr(struct pci_dev *dev)
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
@@ -5139,11 +5144,9 @@ int __pci_reset_function_locked(struct pci_dev *dev)
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
@@ -5174,8 +5177,9 @@ int pci_probe_reset_function(struct pci_dev *dev)
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
index ec943cee5..98077595a 100644
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
index d85914afe..f977ba79a 100644
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
+	int ret = pcie_reset_flr(dev, probe);
 
 	if (probe)
-		return 0;
-
-	pcie_flr(dev);
+		return ret;
 
 	msleep(250);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c20211e59..20b90c205 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1225,7 +1225,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
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

