Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A695539EE69
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 07:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhFHFwl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 01:52:41 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:41917 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhFHFwi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 01:52:38 -0400
Received: by mail-ot1-f46.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so19218812oth.8;
        Mon, 07 Jun 2021 22:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fW5wfb8x41zglgHyAcUMAuIIBSAY+Ni+6lOFyDzIdFA=;
        b=U9LTh4XCT1IWjmtmFLeSM4suqXmmEe/ALoHU9zT9il0Do+8j6r5Ib/HNg0giZJ0/ui
         SQE4iZwsTAie99pWRhL5UIpd9fSFv1txr0Ud3MY5PjAz1GIaX1lFH3By1fvna95KwB0j
         Co4x/+qxvVHzUTeKyw96P7SIw8BW/ZhqXhYyJxFRIHZ+UEcNQUlW53JTrBFdMXV1rvBD
         VRA6k2a++WGIZBjf9nmhvsMWfmkbdcLoa/Q4kQ7OzxIXl3Wwe5iSGvdDpWX99/7iZ7BH
         vfYVmy7UGjlVfJTQkL1E0Xh80edU4k/QWymk8EvtpaSloFec24npe4T09AV6mHpk3Ku1
         9qMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fW5wfb8x41zglgHyAcUMAuIIBSAY+Ni+6lOFyDzIdFA=;
        b=Ol5Y9gRF1rzyQ0IztjwUOsEtq1KtG7kjrDuZWo/gHT0KaTKTYKwntmkYvZMGnSqfsY
         TDBpAu6AZ5wq5bY9xUeZIVpsV9ZeRnKQO/YcXHdGxITCmjOnmYh0rGVj+40rvYINovIE
         XPZm3BbeCHZlrkpHDw+O/WvJHUcbQC6YaIof4oiHFZxmJdbaIw+s1LuiSjFVHPrxZxaj
         8IocP5fc278N9PTqZbBAlpNPMiAqrwn1iSgQoNeafLpyc1QHTZBPbE1lpGtea6JiXqJk
         Ljy83l/UU0a5gs4ijwBtGEJLgL3LRJBABervvd0/uLEUvr8vcfIhpdfC6IHt9gt5cq2Z
         vjKA==
X-Gm-Message-State: AOAM532Ha92FwqeBNzBwrmKYgJMm0SvuAneUiHuvkFw61QAou+V9kD4N
        m1rotJuYc6kjo+DdOLNn0B0=
X-Google-Smtp-Source: ABdhPJx1T3kEivj7whKbneIcR7gSz9veM4lk0UFN3Op+vMaKz7HEOFm8ZhjuL9jD8j5KPSkfCKoUnw==
X-Received: by 2002:a05:6830:34a7:: with SMTP id c39mr16451469otu.357.1623131370062;
        Mon, 07 Jun 2021 22:49:30 -0700 (PDT)
Received: from localhost.localdomain (static-198-54-128-46.cust.tzulo.com. [198.54.128.46])
        by smtp.googlemail.com with ESMTPSA id o2sm2489730oom.26.2021.06.07.22.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 22:49:29 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v7 5/8] PCI: Setup ACPI_COMPANION early
Date:   Tue,  8 Jun 2021 11:18:54 +0530
Message-Id: <20210608054857.18963-6-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608054857.18963-1-ameynarkhede03@gmail.com>
References: <20210608054857.18963-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Shanker Donthineni <sdonthineni@nvidia.com>

Currently, the ACPI_COMPANION is not available until device_add().
The software features which have dependency on ACPI fwnode properties
and needs to be handled before device_add() will not work. One use
case, software has to check the existence of _RST method to support
ACPI based reset mechanism.

This patch adds a new function pci_set_acpi_fwnode() for setting the
ACPI_COMPANION, same code which is available in acpi_pci_bridge_d3().

Call pci_set_acpi_fwnode() from pci_scan_device() to fix the issue.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 drivers/pci/pci-acpi.c | 12 ++++++++----
 drivers/pci/pci.h      |  2 ++
 drivers/pci/probe.c    |  2 ++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 36bc23e21..eaddbf701 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -934,6 +934,13 @@ static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 
 static struct acpi_device *acpi_pci_find_companion(struct device *dev);
 
+void pci_set_acpi_fwnode(struct pci_dev *dev)
+{
+	if (!ACPI_COMPANION(&dev->dev) && !pci_dev_is_added(dev))
+		ACPI_COMPANION_SET(&dev->dev,
+				   acpi_pci_find_companion(&dev->dev));
+}
+
 static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 {
 	const struct fwnode_handle *fwnode;
@@ -945,11 +952,8 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 		return false;
 
 	/* Assume D3 support if the bridge is power-manageable by ACPI. */
+	pci_set_acpi_fwnode(dev);
 	adev = ACPI_COMPANION(&dev->dev);
-	if (!adev && !pci_dev_is_added(dev)) {
-		adev = acpi_pci_find_companion(&dev->dev);
-		ACPI_COMPANION_SET(&dev->dev, adev);
-	}
 
 	if (adev && acpi_device_power_manageable(adev))
 		return true;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 13ec6bd6f..d22da6d3c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -703,7 +703,9 @@ static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL
 #ifdef CONFIG_ACPI
 int pci_acpi_program_hp_params(struct pci_dev *dev);
 extern const struct attribute_group pci_dev_acpi_attr_group;
+void pci_set_acpi_fwnode(struct pci_dev *dev);
 #else
+static inline void pci_set_acpi_fwnode(struct pci_dev *dev) {}
 static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
 {
 	return -ENODEV;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 90fd4f61f..dfefa5ed0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2359,6 +2359,8 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 		return NULL;
 	}
 
+	pci_set_acpi_fwnode(dev);
+
 	return dev;
 }
 
-- 
2.31.1

