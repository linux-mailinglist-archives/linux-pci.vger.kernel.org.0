Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FD620ECE5
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 06:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgF3EuT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 00:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbgF3Etw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jun 2020 00:49:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323A1C03E97A
        for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2020 21:49:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e20so21184640ybc.23
        for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2020 21:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=p5jMb0OYXUjKEO09icbDu9vKB8mUnjKS7ldJrGg6Yyk=;
        b=Gm5cJgnNdA4j8KoD0JqCp92eh1dOmKyWbRuaafAkp7j4Tiyi/4VrofOQLz3gqmH/1f
         vlpldBL1WmCe+59Bk7L3+Bu45rxpdaClWinZYlTrS4AghzmPY4sSK8SDAvo4ZHE4nVF8
         dD1LOwsfjMTY6dYL4PT5+7wRAPaZZTfGFryosjGQCzjr3GjbXbC0q8rP7WwUrkKK+129
         6iRr7B/3o9dNgxc+2YqyrOnydhVzjrhZ3STLNNjon1ze+cF/JTDek3hPTlrAhpXvbTf/
         RbztkalEnybqiFRfvvrtExkKkmnoIKChXrimpwJ7RbEd0qnfPPsRFLzGD/3RV9k79OtQ
         wxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p5jMb0OYXUjKEO09icbDu9vKB8mUnjKS7ldJrGg6Yyk=;
        b=VhguQeYFdLwL6Ii7iItQNGYrMt6H7d8kpWYM6tc6dRnkp1oO+a7RzZvXpCEAgUDQSN
         +zF9geTLDQotSFGEPLP75hUZieYyzr7JnxaG7n4JWaLkw3AdtkSwrpjjasFYbgm4nA9J
         q5So/SSAQcqvo7zKquzVvC+f967lVndToMPWcZwUpcV8sHesLJqXuu/vwR8Z6E1AxZwt
         yrSSuKUw/0HmoIrF4j7mnlWBfRWzpuuxHsIDHdsLKrFVYtS5k6DCdn4zXEbwUKQtWcdB
         4S1NA0zzDw+Z55jkn7z61VqiEgE460KQLjJT6ihbJqIPssixDV4I1sfADcset2aSzDEg
         YYPw==
X-Gm-Message-State: AOAM533EkhPsOG5G3TbDxBr6Q8cU5lS+qG0o2bWqmHBBA/mnH6Jl7sz1
        vmI6RMc1rLrELCgemonlsXwoxYlB7+HH
X-Google-Smtp-Source: ABdhPJzQYV+XpQGsCmrvbSL0LKYgWoNAocwQcR3CYTfyKumjchyuds/0xjCWulL4XB9xL8VDCCUqLfTZnHHz
X-Received: by 2002:a25:dfd2:: with SMTP id w201mr25555433ybg.230.1593492591375;
 Mon, 29 Jun 2020 21:49:51 -0700 (PDT)
Date:   Mon, 29 Jun 2020 21:49:38 -0700
In-Reply-To: <20200630044943.3425049-1-rajatja@google.com>
Message-Id: <20200630044943.3425049-3-rajatja@google.com>
Mime-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 2/7] PCI: Set "untrusted" flag for truly external devices only
From:   Rajat Jain <rajatja@google.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oohall@gmail.com, Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The "ExternalFacing" devices (root ports) are still internal devices that
sit on the internal system fabric and thus trusted. Currently they were
being marked untrusted.

This patch uses the platform flag to identify the external facing devices
and then use it to mark any downstream devices as "untrusted". The
external-facing devices themselves are left as "trusted". This was
discussed here: https://lkml.org/lkml/2020/6/10/1049

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: cosmetic changes in commit log

 drivers/iommu/intel/iommu.c |  2 +-
 drivers/pci/of.c            |  2 +-
 drivers/pci/pci-acpi.c      | 13 +++++++------
 drivers/pci/probe.c         |  2 +-
 include/linux/pci.h         |  8 ++++++++
 5 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d759e7234e982..1ccb224f82496 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4743,7 +4743,7 @@ static inline bool has_untrusted_dev(void)
 	struct pci_dev *pdev = NULL;
 
 	for_each_pci_dev(pdev)
-		if (pdev->untrusted)
+		if (pdev->untrusted || pdev->external_facing)
 			return true;
 
 	return false;
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 27839cd2459f6..22727fc9558df 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -42,7 +42,7 @@ void pci_set_bus_of_node(struct pci_bus *bus)
 	} else {
 		node = of_node_get(bus->self->dev.of_node);
 		if (node && of_property_read_bool(node, "external-facing"))
-			bus->self->untrusted = true;
+			bus->self->external_facing = true;
 	}
 
 	bus->dev.of_node = node;
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 7224b1e5f2a83..492c07805caf8 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1213,22 +1213,23 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	ACPI_FREE(obj);
 }
 
-static void pci_acpi_set_untrusted(struct pci_dev *dev)
+static void pci_acpi_set_external_facing(struct pci_dev *dev)
 {
 	u8 val;
 
-	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
+	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT &&
+	    pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)
 		return;
 	if (device_property_read_u8(&dev->dev, "ExternalFacingPort", &val))
 		return;
 
 	/*
-	 * These root ports expose PCIe (including DMA) outside of the
-	 * system so make sure we treat them and everything behind as
+	 * These root/down ports expose PCIe (including DMA) outside of the
+	 * system so make sure we treat everything behind them as
 	 * untrusted.
 	 */
 	if (val)
-		dev->untrusted = 1;
+		dev->external_facing = 1;
 }
 
 static void pci_acpi_setup(struct device *dev)
@@ -1240,7 +1241,7 @@ static void pci_acpi_setup(struct device *dev)
 		return;
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
-	pci_acpi_set_untrusted(pci_dev);
+	pci_acpi_set_external_facing(pci_dev);
 	pci_acpi_add_edr_notifier(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6d87066a5ecc5..8c40c00413e74 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1552,7 +1552,7 @@ static void set_pcie_untrusted(struct pci_dev *dev)
 	 * untrusted as well.
 	 */
 	parent = pci_upstream_bridge(dev);
-	if (parent && parent->untrusted)
+	if (parent && (parent->untrusted || parent->external_facing))
 		dev->untrusted = true;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a26be5332bba6..fe1bc603fda40 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -432,6 +432,14 @@ struct pci_dev {
 	 * mappings to make sure they cannot access arbitrary memory.
 	 */
 	unsigned int	untrusted:1;
+	/*
+	 * Devices are marked as external-facing using info from platform
+	 * (ACPI / devicetree). An external-facing device is still an internal
+	 * trusted device, but it faces external untrusted devices. Thus any
+	 * devices enumerated downstream an external-facing device is marked
+	 * as untrusted.
+	 */
+	unsigned int	external_facing:1;
 	unsigned int	broken_intx_masking:1;	/* INTx masking can't be used */
 	unsigned int	io_window_1k:1;		/* Intel bridge 1K I/O windows */
 	unsigned int	irq_managed:1;
-- 
2.27.0.212.ge8ba1cc988-goog

