Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C4339E685
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 20:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhFGSZl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 14:25:41 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:39511 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhFGSZk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 14:25:40 -0400
Received: by mail-pf1-f177.google.com with SMTP id k15so13732434pfp.6;
        Mon, 07 Jun 2021 11:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fW5wfb8x41zglgHyAcUMAuIIBSAY+Ni+6lOFyDzIdFA=;
        b=o3G5oOU6//tIJmKmhES2tEXoxirzr608aHOc8pwpPnv8aQk+CdhyQcuc7joomfsHRT
         +PD6CMJS3QYCqh9nU1seiNikpZP/zHYeTf1au17XNqyzo3KxwNzttzJvnJGQmURZbEyc
         6B8b4Z6K9SvsplGvLt6/DXoLmOgCA1xjkW1iYR/JaC1cKDa84xPGRs3Ddwy5AXllWd6B
         HzH3PYxry0KPMnpAN/BkX6/iank5e1G7OqqTg+yhkHaadhOUQpWcI4X2HafI6uGZTV06
         Wzwzfl4PgvtZKP1LwQ449Nx9aLi74HRq0sDkIHKn0SQZj/i/Oe867Mdaa7YLLaL9Qjpv
         C7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fW5wfb8x41zglgHyAcUMAuIIBSAY+Ni+6lOFyDzIdFA=;
        b=sLYEYxEKAx4OT+2NE0FgDNjq53sVVBvMMk96HS8WhrAawHaR5Ms2EeVvPmBOOGgJDt
         daQdSmeV4pKyiUhLCug8R7XtVv4F9s9z9/A00OTxtXf7yKmnHGulK/f/ntTcJ84/jaTx
         r/jWHxQuDRDyEpGrSFprLIeOTq4+hRbeRkfcdN2aCLqSXCdof0K2h9q4FvyYiNuNYNJN
         WrdfU9vL/B0ng/SeTIfEl382eAKNIdv3iB+UFEsdgGlnNkZX94SQfyQParA0bO4XECTD
         KFystQFVXYTsZKy7jCitWhs/GwrrkBpbajHahgefYhN/QxuMq5PcGHpdHqy0hE2Ae7Oz
         +2kw==
X-Gm-Message-State: AOAM533zEEp2mh4UpXfH3nfJ0efMt6er+2mjDBSBPqHoPuLLqvM9k0c/
        2wbNMmZJ8nxeBUxqKN2D6Kw=
X-Google-Smtp-Source: ABdhPJxO6nuThz+aF2UXb1doXP7+lOWOJraO2hEpY3HD/g0jVsAVCm2yzSE/X1QuvzF+ieQN3iN1fQ==
X-Received: by 2002:a62:30c2:0:b029:289:116c:ec81 with SMTP id w185-20020a6230c20000b0290289116cec81mr18598706pfw.42.1623090159879;
        Mon, 07 Jun 2021 11:22:39 -0700 (PDT)
Received: from localhost.localdomain ([103.200.106.115])
        by smtp.googlemail.com with ESMTPSA id k1sm8687656pfa.30.2021.06.07.11.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 11:22:39 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v6 5/8] PCI: Setup ACPI_COMPANION early
Date:   Mon,  7 Jun 2021 23:51:34 +0530
Message-Id: <20210607182137.5794-6-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210607182137.5794-1-ameynarkhede03@gmail.com>
References: <20210607182137.5794-1-ameynarkhede03@gmail.com>
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

