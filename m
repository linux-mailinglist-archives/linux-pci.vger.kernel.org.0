Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3863EF181
	for <lists+linux-pci@lfdr.de>; Tue, 17 Aug 2021 20:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhHQSKu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 14:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbhHQSKs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Aug 2021 14:10:48 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB38CC0613CF;
        Tue, 17 Aug 2021 11:10:14 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e19so25762079pla.10;
        Tue, 17 Aug 2021 11:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rgryk5duYMg0I6U6vS/GxLsDfUJoC6HD3ngWCb4FyxQ=;
        b=kVn/QL0q9eYDDOqQNpNmsuOhY+vI1zEDlmtrCCsI0SeXaPIKawnkPcClQ9QceTjBw6
         pj0VCQLcNfMfYanKrwQwl8283Jq/IFFx743r6iRTw2CP2h9vt9ZK24BojZfbJTh/lbNc
         7DQ59dX/2jQC0xins+dx0o6XQbyJOHChBZcp4ubnlkj5IdHzapcZFXj8MPLTQppTdBQ+
         chdZK6oTjgS0EO8W6vPzKO3kO4Aj7lojok2MGOTJocZMVPiNQGEwrjrYKIjA96PYxHWw
         MHiQ+a3V3U5TRcOYDJbNtlAStmJUQwqfFIwxGUORVt5vIHUp1W0/ISPkQiC3OImWr6hB
         QnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rgryk5duYMg0I6U6vS/GxLsDfUJoC6HD3ngWCb4FyxQ=;
        b=YyIlMrto2DtYnRzzuO6jQGdLpLaJydOwAptA++/VD0ZK1YYbXws2g2fXAU7aVsxKlc
         aMLYVevs6xPpknz976QGWWHiEb/pPCMnPiS6tYCujm6XwLN11lAAheCup756v1212LJe
         RlwEiIEdI8YMTgb+CUX/xHavAt3QU1lmbNw4Ka44gNmtFcMYJPSZ4ASNXtyPV139VUSf
         SpWY+ImHKlq45i+NIiU0AZwfg0R8H2ae7yDUpEJdiv78SSfzMF0g8vYaNWOmBhGccFRx
         MVkBCO+45otrQndj2yJBUcJEZpayOvBRRjTXbKh3dLEOnYlZqad7NEA8H0rPa3dI0XwR
         R6aQ==
X-Gm-Message-State: AOAM531ASHeoSIwO7fMHAF6EJ7wJkWN2Sjpf6Fd4861ZVYYPRB5zE19r
        6HRmSopKduz8AQPE2bhS/I0=
X-Google-Smtp-Source: ABdhPJzYUWuJ9fH2R6F15cqGi8+AyUutS7NRx4db7k7+V36ad8h4ye2FmtXkdmJEmUTT4N77DUQ9Vg==
X-Received: by 2002:a17:902:b190:b029:12d:487:dddc with SMTP id s16-20020a170902b190b029012d0487dddcmr3845247plr.24.1629223814469;
        Tue, 17 Aug 2021 11:10:14 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.158])
        by smtp.googlemail.com with ESMTPSA id d18sm4011306pgk.24.2021.08.17.11.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:10:14 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v16 7/9] PCI: Setup ACPI fwnode early and at the same time with OF
Date:   Tue, 17 Aug 2021 23:39:35 +0530
Message-Id: <20210817180937.3123-8-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817180937.3123-1-ameynarkhede03@gmail.com>
References: <20210817180937.3123-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Shanker Donthineni <sdonthineni@nvidia.com>

The pci_dev objects are created through two mechanisms 1) during PCI
bus scan and 2) from I/O Virtualization. The fwnode in pci_dev object
is being set at different places depends on the type of firmware used,
device creation mechanism, and acpi_pci_bridge_d3().

The software features which have a dependency on ACPI fwnode properties
and need to be handled before device_add() will not work. One use case,
the software has to check the existence of _RST method to support ACPI
based reset method.

This patch does the two changes in order to provide fwnode consistently.
 - Set ACPI and OF fwnodes from pci_setup_device().
 - Cleanup acpi_pci_bridge_d3() since FWNODE is available long before
   it's being called.

After this patch, ACPI/OF firmware properties are visible at the same
time during the early stage of pci_dev setup. And also call sites should
be able to use firmware agnostic functions device_property_xxx() for the
early PCI quirks in the future.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci-acpi.c | 49 ++++++++++++++++--------------------------
 drivers/pci/probe.c    |  7 +++---
 2 files changed, 23 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index eaddbf701..e9a403191 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -941,55 +941,44 @@ void pci_set_acpi_fwnode(struct pci_dev *dev)
 				   acpi_pci_find_companion(&dev->dev));
 }
 
+static bool acpi_pci_power_manageable(struct pci_dev *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
+	return adev ? acpi_device_power_manageable(adev) : false;
+}
+
 static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 {
-	const struct fwnode_handle *fwnode;
+	const union acpi_object *obj;
 	struct acpi_device *adev;
-	struct pci_dev *root;
-	u8 val;
+	struct pci_dev *rpdev;
 
 	if (!dev->is_hotplug_bridge)
 		return false;
 
 	/* Assume D3 support if the bridge is power-manageable by ACPI. */
-	pci_set_acpi_fwnode(dev);
-	adev = ACPI_COMPANION(&dev->dev);
-
-	if (adev && acpi_device_power_manageable(adev))
+	if (acpi_pci_power_manageable(dev))
 		return true;
 
 	/*
-	 * Look for a special _DSD property for the root port and if it
-	 * is set we know the hierarchy behind it supports D3 just fine.
+	 * The ACPI firmware will provide the device-specific properties through
+	 * _DSD configuration object. Look for the 'HotPlugSupportInD3' property
+	 * for the root port and if it is set we know the hierarchy behind it
+	 * supports D3 just fine.
 	 */
-	root = pcie_find_root_port(dev);
-	if (!root)
+	rpdev = pcie_find_root_port(dev);
+	if (!rpdev)
 		return false;
 
-	adev = ACPI_COMPANION(&root->dev);
-	if (root == dev) {
-		/*
-		 * It is possible that the ACPI companion is not yet bound
-		 * for the root port so look it up manually here.
-		 */
-		if (!adev && !pci_dev_is_added(root))
-			adev = acpi_pci_find_companion(&root->dev);
-	}
-
+	adev = ACPI_COMPANION(&rpdev->dev);
 	if (!adev)
 		return false;
 
-	fwnode = acpi_fwnode_handle(adev);
-	if (fwnode_property_read_u8(fwnode, "HotPlugSupportInD3", &val))
+	if (acpi_dev_get_property(adev, "HotPlugSupportInD3",
+				   ACPI_TYPE_INTEGER, &obj) < 0)
 		return false;
 
-	return val == 1;
-}
-
-static bool acpi_pci_power_manageable(struct pci_dev *dev)
-{
-	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
-	return adev ? acpi_device_power_manageable(adev) : false;
+	return obj->integer.value == 1;
 }
 
 static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 379e85037..15a6975d3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1789,6 +1789,9 @@ int pci_setup_device(struct pci_dev *dev)
 	dev->error_state = pci_channel_io_normal;
 	set_pcie_port_type(dev);
 
+	pci_set_of_node(dev);
+	pci_set_acpi_fwnode(dev);
+
 	pci_dev_assign_slot(dev);
 
 	/*
@@ -1924,6 +1927,7 @@ int pci_setup_device(struct pci_dev *dev)
 	default:				    /* unknown header */
 		pci_err(dev, "unknown header type %02x, ignoring device\n",
 			dev->hdr_type);
+		pci_release_of_node(dev);
 		return -EIO;
 
 	bad:
@@ -2351,10 +2355,7 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	dev->vendor = l & 0xffff;
 	dev->device = (l >> 16) & 0xffff;
 
-	pci_set_of_node(dev);
-
 	if (pci_setup_device(dev)) {
-		pci_release_of_node(dev);
 		pci_bus_put(dev->bus);
 		kfree(dev);
 		return NULL;
-- 
2.32.0

