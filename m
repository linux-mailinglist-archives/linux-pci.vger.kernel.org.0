Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1433EF14A
	for <lists+linux-pci@lfdr.de>; Tue, 17 Aug 2021 20:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhHQSFv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 14:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhHQSFu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Aug 2021 14:05:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25381C061764;
        Tue, 17 Aug 2021 11:05:17 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j12-20020a17090aeb0c00b00179530520b3so6699118pjz.0;
        Tue, 17 Aug 2021 11:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BGW/zFi9zZsvEixt/KEYINoe8Ws6IQDPF8DBl+lDeng=;
        b=ikiLsZFHhIaE9+/6C4SdZiW6NlghVsgO6+9PIpFHLAux1V1qppueSVgSfQzKz5yDAn
         zE9A+I+o5av3kAy7gyOrWDZebkE++oh0wQEkWC3MhTYLPnzl9aVY+4V3F4dVckgHKKpB
         r22VrAuLGfAu369abmmOTboLfUeUCqdVnllAiFm3NQ3NrtoZ145QZNVVybQFW6X8hiOM
         qaNKLnhxSYShlbXrqdpEzSVdJmoqVWj1M2SVv8iOUUCpDtZeitS+kGaGXnymO+z5Yc2/
         1ffi6W/aqD7Zw231oz7jVsTFFaBEEUuvXnYROTprneeAB1I/Ozjnn3GzBfmA0cvLKKv4
         BvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BGW/zFi9zZsvEixt/KEYINoe8Ws6IQDPF8DBl+lDeng=;
        b=OtCXtOGBhsfXsc9SnaUZvqIQzNYbm85njmRDoil6Da+5upLJBg9MiiKQM7ACQTDdS9
         WDCKebiajnCK5F6GykFMG45TbiLH1wgvsxB6nOgAXfi63C4eJHLPM2aXZg9A/MVqQVR7
         vBItPaThFhBdsPGKzgUgYwGWGd5rxJxfeR7HW/MhMmm5RXzi+QEot+WSzzQNtO4kFKQH
         wcjU5jceZCdBgF1gcoJFRQ0NWs1GBRXxi4oNsWKXWmyomHfENzlIamOncis8of0u/3Cx
         Nt8/iQSI8b9mdHJv8kQCpQn7U0RCCv8z4Ns6/++iQ+y4/sQoz0wHZYDOajSJvCPw9UyW
         hFIg==
X-Gm-Message-State: AOAM533juOOO0qHXpnZxzeDdiFytI60LoE/xy1cdvx7AOW/YRtghkXag
        yqn8GEPf8eCVvfU055f+WVk=
X-Google-Smtp-Source: ABdhPJyuTXiwyEDyFVeHlW9lmFeUAUpCk5WhSg9K3P7zx2p+U9mAUCyYNHkMXSTzcJlMZsnBODd1tA==
X-Received: by 2002:aa7:8802:0:b0:3e2:bb03:4560 with SMTP id c2-20020aa78802000000b003e2bb034560mr1331272pfo.62.1629223516722;
        Tue, 17 Aug 2021 11:05:16 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.158])
        by smtp.googlemail.com with ESMTPSA id 65sm4065632pgi.12.2021.08.17.11.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:05:16 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v16 2/9] PCI: Add pcie_reset_flr to follow calling convention of other reset methods
Date:   Tue, 17 Aug 2021 23:34:53 +0530
Message-Id: <20210817180500.1253-3-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817180500.1253-1-ameynarkhede03@gmail.com>
References: <20210817180500.1253-1-ameynarkhede03@gmail.com>
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
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +--
 drivers/pci/pci.c                          | 40 +++++++++++++++-------
 drivers/pci/pcie/aer.c                     | 12 +++----
 drivers/pci/quirks.c                       |  9 ++---
 include/linux/pci.h                        |  2 +-
 5 files changed, 38 insertions(+), 29 deletions(-)

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
index 1fafd05ca..7d1d96711 100644
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
index d85914afe..b48e7ef8b 100644
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
index 697b1f085..aa85e7d31 100644
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

