Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B723EF178
	for <lists+linux-pci@lfdr.de>; Tue, 17 Aug 2021 20:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhHQSKb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 14:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbhHQSKa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Aug 2021 14:10:30 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B287FC061764;
        Tue, 17 Aug 2021 11:09:57 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id oa17so426490pjb.1;
        Tue, 17 Aug 2021 11:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BGW/zFi9zZsvEixt/KEYINoe8Ws6IQDPF8DBl+lDeng=;
        b=PnG0VI79b57enThI/g8hXYOlXM9lKRCFvcBz9+QjOCMqU6iILKMftoDB3BiOvcbGBA
         EEMA49Jg9ReSNU32d3IOtMSMaYZyLR5hKLWQmCz/xA12URrT++ABSTDI0efOUyWewayP
         mcPsvcBOKErePZybqY9Tw3mjxSEvBHegmGt6fZlLRcWbrKK6cFYEGzfzBYq4UmkUv4h0
         hQsA62hlYZYx0KTrLuZaaUmebKnkvBhik88sNXxEtU9bHVhJKeJ5Z0WcjE17zSVUxN09
         JxwqrYcufVdWk1UStbKOs27P4iVv8NWLfbaigHKgQ/W05xlSnROFy4/FpKjduQIERPJU
         Bp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BGW/zFi9zZsvEixt/KEYINoe8Ws6IQDPF8DBl+lDeng=;
        b=TmrcHr+UVwYQ/t3aALqyHYGFt4r09LQJb9j8kkP9MQ+fIiA1PJB2sd14Sv9tsEs8H4
         4D2ZbLJ2zT2CHvpfHrNaSi03mNw5Jz94VpJB8R5ywt13IVIjlCR6cdlQICP60GYplBrU
         6RetcGltziEl7SCmwkuUfpAFlSuVCkEkbtp7+OyDCguoqAbn/UUthRJf1Er+EjyGDpkn
         inyvVZtsNB48r/BDhaeOPkf0By8whKaOx/5CWzSQ90t+mcjeK6FH1P3pbEtODAJOP4HZ
         jE+ZUss1qYW+fr3qf1Fmd7IlivL9f3NKJU31kyipeP8D6n+21HjLkT8+Gu+Uqnn2FzCU
         djDQ==
X-Gm-Message-State: AOAM530+DuMJr7D5EsVTDFGdWgK5A9feUNp+oRPBGIslttmb+JMrdojo
        K9P62DcUFQ4P8ELRxZeRGwA=
X-Google-Smtp-Source: ABdhPJxkVinZVrmmXTlOw9C+KJ6+HYtwcBLowRFe8DXBmxPQ8QHEaOHbV+abKCKxDw4zerGRDZ/U5g==
X-Received: by 2002:a17:90a:c8c:: with SMTP id v12mr4846355pja.37.1629223797323;
        Tue, 17 Aug 2021 11:09:57 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.158])
        by smtp.googlemail.com with ESMTPSA id d18sm4011306pgk.24.2021.08.17.11.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:09:57 -0700 (PDT)
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
Date:   Tue, 17 Aug 2021 23:39:30 +0530
Message-Id: <20210817180937.3123-3-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817180937.3123-1-ameynarkhede03@gmail.com>
References: <20210817180937.3123-1-ameynarkhede03@gmail.com>
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

