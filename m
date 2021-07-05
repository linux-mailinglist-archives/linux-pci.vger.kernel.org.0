Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533713BBE1F
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 16:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhGEOYm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 10:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhGEOYl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 10:24:41 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E808EC061574;
        Mon,  5 Jul 2021 07:22:04 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v7so18462211pgl.2;
        Mon, 05 Jul 2021 07:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ezyl9znPDS4XJngAoOB66He3Jj88vDsFLgZj2nxw3FI=;
        b=ULQRGFs8Y4Rr98VDotpfAshNcOqA5IfduWnz9Y+6PP1Wbi5/8uPuFRiWFDc+rqLfZZ
         kEJxoKGePTf0RY1/AAWXy/bRt/2I0XXJ+tRCqwS9NQrqid0XZ3evdSzSPi97cv4qDa5x
         j/qnksP1Ok/lTeB5H2kUnoR9tsHf2RUv0tv9xMhUfnQ97VgdeDefbctPE8yMrOCgr4Wx
         Tju1aMe7HMhTluxqI3kB11qOEE44b77vWuEB75Pz5rWwGq+iNXEqgp/RYR6whE+PLnau
         +3ktCDRzTT7y8/V+YATaXr+uzQfstqKWQ9gQFAcNUHbNG9pClciOCsQvvqSUZANVsxH9
         trpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ezyl9znPDS4XJngAoOB66He3Jj88vDsFLgZj2nxw3FI=;
        b=WRD2/lpOkozoqBeyOHjCmGIFQg1tT95NJva0bmKvkzGRFmlgNwdx3naKZcxsnaBIL2
         df8D1/qQoIM8VNE18Rsm2F8IiLkvVfWiB5he2SIeurpvIw1Ri/H7wxna3QCEFUV6LonJ
         FU3DOZ92Zalzzo+g8t7jw6FVnolUVW6PsYm1saS9/GnKvGG3ag7z5y6va8TkURXzzYxD
         gc3Jbx8ysNWBdPeqREC8nAVYA1k8udbOE/VzHwrG6Xj7wlo8rSgRmoOq0Nru2p+68dOb
         id0elPvJrmMtmSFdI1i2foV/HmV5wucilnxLYPQOBEQPB4r4oLT7qDKELiw4r/gTvmfM
         i4cQ==
X-Gm-Message-State: AOAM533a+stWRayCcBPFhdwGiIFoydhhgHTh1miQkZJ+9xVV1jNE1EAo
        6ruO3vk9rK9E5ODq1Dv15Ho=
X-Google-Smtp-Source: ABdhPJyvNyVDg6lJAgDG0H7wH1dxaYiKhWr3cuzSbo+r+sI2/8oIg0mbONiyCTsiVcQT53af1Zighw==
X-Received: by 2002:aa7:9905:0:b029:301:ec7c:f73c with SMTP id z5-20020aa799050000b0290301ec7cf73cmr15294846pff.68.1625494924319;
        Mon, 05 Jul 2021 07:22:04 -0700 (PDT)
Received: from localhost.localdomain ([2409:4042:2696:1624:5e13:abf4:6ecf:a1f1])
        by smtp.googlemail.com with ESMTPSA id 92sm22615307pjv.29.2021.07.05.07.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 07:22:04 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v9 1/8] PCI: Add pcie_reset_flr to follow calling convention of other reset methods
Date:   Mon,  5 Jul 2021 19:51:31 +0530
Message-Id: <20210705142138.2651-2-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210705142138.2651-1-ameynarkhede03@gmail.com>
References: <20210705142138.2651-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add has_pcie_flr bitfield in struct pci_dev to indicate support for PCIe
FLR to avoid reading PCI_EXP_DEVCAP multiple times.

Currently there is separate function pcie_has_flr() to probe if PCIe FLR
is supported by the device which does not match the calling convention
followed by reset methods which use second function argument to decide
whether to probe or not. Add new function pcie_reset_flr() that follows
the calling convention of reset methods.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +-
 drivers/pci/pci.c                          | 59 +++++++++++-----------
 drivers/pci/pcie/aer.c                     | 12 ++---
 drivers/pci/probe.c                        |  6 ++-
 drivers/pci/quirks.c                       |  9 ++--
 include/linux/pci.h                        |  3 +-
 6 files changed, 45 insertions(+), 48 deletions(-)

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
index 452351025..fefa6d7b3 100644
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
@@ -4659,6 +4639,28 @@ int pcie_flr(struct pci_dev *dev)
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
+	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
+		return -ENOTTY;
+
+	if (!dev->has_pcie_flr)
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
@@ -5139,11 +5141,9 @@ int __pci_reset_function_locked(struct pci_dev *dev)
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
@@ -5174,8 +5174,9 @@ int pci_probe_reset_function(struct pci_dev *dev)
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
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3a62d09b8..a95252113 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1487,6 +1487,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
 {
 	int pos;
 	u16 reg16;
+	u32 reg32;
 	int type;
 	struct pci_dev *parent;
 
@@ -1497,8 +1498,9 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	pdev->pcie_cap = pos;
 	pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
 	pdev->pcie_flags_reg = reg16;
-	pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
-	pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
+	pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP, &reg32);
+	pdev->pcie_mpss = reg32 & PCI_EXP_DEVCAP_PAYLOAD;
+	pdev->has_pcie_flr = reg32 & PCI_EXP_DEVCAP_FLR ? 1 : 0;
 
 	parent = pci_upstream_bridge(pdev);
 	if (!parent)
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
index c20211e59..d432428fd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -337,6 +337,7 @@ struct pci_dev {
 	u8		msi_cap;	/* MSI capability offset */
 	u8		msix_cap;	/* MSI-X capability offset */
 	u8		pcie_mpss:3;	/* PCIe Max Payload Size Supported */
+	u8		has_pcie_flr:1; /* PCIe FLR supported */
 	u8		rom_base_reg;	/* Config register controlling ROM */
 	u8		pin;		/* Interrupt pin this device uses */
 	u16		pcie_flags_reg;	/* Cached PCIe Capabilities Register */
@@ -1225,7 +1226,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
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

