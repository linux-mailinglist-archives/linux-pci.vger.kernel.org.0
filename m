Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FAB3B7620
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jun 2021 18:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhF2QGG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Jun 2021 12:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbhF2QE5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jun 2021 12:04:57 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97A8C061768;
        Tue, 29 Jun 2021 09:01:59 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w15so14370862pgk.13;
        Tue, 29 Jun 2021 09:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OxqatQynLEzipLz1l2OP72u6gZlcohIcUEaR82vsx1E=;
        b=QGO6rXbiZoUfIVmfH7oby+L8TcY5w6abQ+VEO7NQjV0NXCg3nx5Ko2xnUW2IrWM4w3
         TyteyAtgguZGqpvMmaDAdjYwIVHz/FjODfYrZUBtMMPHZluyIAr12qBkqaEqYkpOY0bw
         mr1G21bow9lhfyrbGlXKHDVI6JNyvCtU0wdquDVX0g5BHyTVadpDgmHU2eswl1SmdLYd
         6B44n854j7CKDKVzvtJ1AjylbBLu2nVUAn75eTVKWdja/QSpAk3miUkt5XsvQISoEftW
         WMWSNit+O60OQpy8tKERtx53tEiDfoz2zLC5j685IfFVemws5VjMrNTqfyJXzg+M7u7f
         USYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OxqatQynLEzipLz1l2OP72u6gZlcohIcUEaR82vsx1E=;
        b=PzxPENPD2Tx3oxAOlbMXyYVh0ZdZbPYcbEkgUTHk9SV/jGdnYUdoQBLg0+XTtW9jUI
         UeJcHtqw4whyPg0e4MNkv6yZUk5tj0WY5ak3XJ6ru2CKPntN7NMY+qfUdx4WJnkjAxC5
         lrYXuUdQBgMFuVBZhMXJKEn5UQKk7XBLmPVLtD1qsgphMmAdXFkjJ71zFdf6CqwQHPjb
         Sm7jjngctgD8wKzNlajHCn5PPRTC0vzFXnfrtmVp6uKE4ZgTW32eJCW332lYIcQLX0Yp
         RZE9gGR2UkRCarNDFnf1t6L8KA4nbBRDJSQKczvZdmHaGYrjov7ysnPbBQWxn5roDfi2
         OPYA==
X-Gm-Message-State: AOAM533OC33+g52VcXBZeuU/J0LpmcEMKpSG9rugDZ2zji1oCqYKj+1H
        bkjWWhn5CRqkeDemOpRUokk=
X-Google-Smtp-Source: ABdhPJwE7439xPymV8l7YYmAhVMlNgpsjeaQuLfKff1zbgGOAwaln6qOEsyNAKpk3YQFpJ7qujVmCQ==
X-Received: by 2002:aa7:88c1:0:b029:30b:49b3:18e with SMTP id k1-20020aa788c10000b029030b49b3018emr15277181pff.43.1624982519330;
        Tue, 29 Jun 2021 09:01:59 -0700 (PDT)
Received: from localhost.localdomain ([103.200.106.119])
        by smtp.googlemail.com with ESMTPSA id m14sm19166240pgu.84.2021.06.29.09.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 09:01:59 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v8 1/8] PCI: Add pcie_reset_flr to follow calling convention of other reset methods
Date:   Tue, 29 Jun 2021 21:30:57 +0530
Message-Id: <20210629160104.2893-2-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629160104.2893-1-ameynarkhede03@gmail.com>
References: <20210629160104.2893-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add has_flr bitfield in struct pci_dev to indicate support for pcie flr
to avoid reading PCI_EXP_DEVCAP multiple times and get rid of
PCI_DEV_FLAGS_NO_FLR_RESET in quirk_no_flr().

Currently there is separate function pcie_has_flr() to probe if pcie flr is
supported by the device which does not match the calling convention
followed by reset methods which use second function argument to decide
whether to probe or not.  Add new function pcie_reset_flr() that follows
the calling convention of reset methods.

Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +-
 drivers/pci/pci.c                          | 62 +++++++++++-----------
 drivers/pci/pcie/aer.c                     | 12 ++---
 drivers/pci/probe.c                        |  6 ++-
 drivers/pci/quirks.c                       | 11 ++--
 include/linux/pci.h                        |  7 ++-
 6 files changed, 47 insertions(+), 55 deletions(-)

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
index 452351025..28f099a4f 100644
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
@@ -4659,16 +4639,35 @@ int pcie_flr(struct pci_dev *dev)
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
+	if (!dev->has_flr)
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
 	u8 cap;
 
-	pos = pci_find_capability(dev, PCI_CAP_ID_AF);
-	if (!pos)
+	if (!dev->has_flr)
 		return -ENOTTY;
 
-	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
+	pos = pci_find_capability(dev, PCI_CAP_ID_AF);
+	if (!pos)
 		return -ENOTTY;
 
 	pci_read_config_byte(dev, pos + PCI_AF_CAP, &cap);
@@ -5139,11 +5138,9 @@ int __pci_reset_function_locked(struct pci_dev *dev)
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
@@ -5174,8 +5171,9 @@ int pci_probe_reset_function(struct pci_dev *dev)
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
index 3a62d09b8..862d91615 100644
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
+	pdev->has_flr = reg32 & PCI_EXP_DEVCAP_FLR ? 1 : 0;
 
 	parent = pci_upstream_bridge(pdev);
 	if (!parent)
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d85914afe..1efdc4e5a 100644
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
 
@@ -5182,7 +5179,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
  */
 static void quirk_no_flr(struct pci_dev *dev)
 {
-	dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;
+	dev->has_flr = 0;
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c, quirk_no_flr);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c20211e59..74f42a2cd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -223,10 +223,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 8),
 	/* A non-root bridge where translation occurs, stop alias search here */
 	PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT = (__force pci_dev_flags_t) (1 << 9),
-	/* Do not use FLR even if device advertises PCI_AF_CAP */
-	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
 	/* Don't use Relaxed Ordering for TLPs directed at this device */
-	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
+	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 10),
 };
 
 enum pci_irq_reroute_variant {
@@ -381,6 +379,7 @@ struct pci_dev {
 						   bit manually */
 	unsigned int	d3hot_delay;	/* D3hot->D0 transition time in ms */
 	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
+	unsigned int	has_flr:1;
 
 #ifdef CONFIG_PCIEASPM
 	struct pcie_link_state	*link_state;	/* ASPM link state */
@@ -1225,7 +1224,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
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

