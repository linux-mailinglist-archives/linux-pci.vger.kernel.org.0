Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F36F217B34
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 00:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgGGWqN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 18:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729444AbgGGWqM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jul 2020 18:46:12 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B2CC08C5DC
        for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2020 15:46:12 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id t36so13846086qtc.16
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2020 15:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+Rqxcc67bWamHPT9UuHLq9P/O36CYZQMOcdNpnmmIao=;
        b=pXZcXhxz7mxW6RS7gJAv+NztP6PWIdXUddf5RV8kHRHOgSQsBTRWQ1kS6KDZwaXyYH
         yoGbwYV+lo5tqx0FRClBaQgvoKziBo4h6Z7fY1r8opn1GwexWSqz0HsRK5lgFzCx7Hto
         oJF9FQRenEaECQh4qFBYY48A456Srf7zC3wEtpl4CRGFVns2fUaYYgnA3QLbCwBlEBGe
         r2o2LBmx6Z1RS0/swh8B4gpLLRumQtdkajRNwjGtDHeKjMr7XzLJ7xp7rZtaSPPwl75U
         lK06Fba7oS0Ta8x3kR5Y+4Elrw6RS0PJg+Obk1PPaGMj5vur2Pd782/vmR1grIYi8RhN
         VFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+Rqxcc67bWamHPT9UuHLq9P/O36CYZQMOcdNpnmmIao=;
        b=JgBoHpLjNnbqmwATeBhe5H/m3Dhdi7sGTzWA0i+exDYQg66Ij36yIBvlZutvmA2tUA
         y1qwWvFfnHgGgLZmhRCmjxqUC4+gJMyTFXbdLeqtFihciKi0uNVBeSRNqwpTmcOBxF9L
         2Lr0st6PPbQalgWOl3pfp3kGxa34urCkpDGSYksryz76kDLEBCLUA+c4/sWAYLrph5wF
         ST+Us213PTEdjZVZjhka01nUD6ZrXGOGAj2/MWqkPNCJR5gEIVkdUAMqDRs51YDLa6Vw
         hlnjqxWSprSlBOx0qGG0WLafDvzp3o4Ze2E8H4uT0kme5TCgD7d4iTpudUJh1Iud5ppx
         cQFQ==
X-Gm-Message-State: AOAM531H4yRmDECTbQ+HFGl1Z6Bh0lNUWvEmvnjEukRTA4UDchKAack3
        eFJv3oXPTcg53OZAxL78rmbN6N/GpOxm
X-Google-Smtp-Source: ABdhPJxnH+92NoVCcK7NZHV4Ls6bngx8p8nimLUooSLS2gVZpS5/6IxaAi2WM9zBZzRgEB7nYKaxRQqv7qfK
X-Received: by 2002:a05:6214:18f2:: with SMTP id ep18mr41966212qvb.96.1594161971125;
 Tue, 07 Jul 2020 15:46:11 -0700 (PDT)
Date:   Tue,  7 Jul 2020 15:46:03 -0700
In-Reply-To: <20200707224604.3737893-1-rajatja@google.com>
Message-Id: <20200707224604.3737893-3-rajatja@google.com>
Mime-Version: 1.0
References: <20200707224604.3737893-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v4 3/4] PCI: Treat "external-facing" devices as internal
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

The "ExternalFacingPort" devices (root ports) are internal devices that
sit on the internal system fabric. Ref:
https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports

Currently they were treated (marked as untrusted) at par with other
external devices downstream those external facing rootports.

Use the platform flag to identify the external facing devices and then
treat them at par with internal devices (don't mark them untrusted).
Any devices downstream continue to be marked as "untrusted". This was
discussed here:
https://lore.kernel.org/linux-pci/20200610230906.GA1528594@bjorn-Precision-5520/

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v4: No change
v3: * fix commit log and minor code comment
    * Don't check for "ExternalFacingPort" on PCI_EXP_TYPE_DOWNSTREAM
    * Check only for pdev->external_facing in iommu.c
v2: cosmetic changes in commit log

 drivers/iommu/intel/iommu.c |  6 +++---
 drivers/pci/of.c            |  2 +-
 drivers/pci/pci-acpi.c      | 10 +++++-----
 drivers/pci/probe.c         |  2 +-
 include/linux/pci.h         |  8 ++++++++
 5 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d759e7234e982..4f0f6ee2d4aaa 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4738,12 +4738,12 @@ const struct attribute_group *intel_iommu_groups[] = {
 	NULL,
 };
 
-static inline bool has_untrusted_dev(void)
+static inline bool has_external_pci(void)
 {
 	struct pci_dev *pdev = NULL;
 
 	for_each_pci_dev(pdev)
-		if (pdev->untrusted)
+		if (pdev->external_facing)
 			return true;
 
 	return false;
@@ -4751,7 +4751,7 @@ static inline bool has_untrusted_dev(void)
 
 static int __init platform_optin_force_iommu(void)
 {
-	if (!dmar_platform_optin() || no_platform_optin || !has_untrusted_dev())
+	if (!dmar_platform_optin() || no_platform_optin || !has_external_pci())
 		return 0;
 
 	if (no_iommu || dmar_disabled)
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
index 7224b1e5f2a83..43a5158b2b662 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1213,7 +1213,7 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	ACPI_FREE(obj);
 }
 
-static void pci_acpi_set_untrusted(struct pci_dev *dev)
+static void pci_acpi_set_external_facing(struct pci_dev *dev)
 {
 	u8 val;
 
@@ -1223,12 +1223,12 @@ static void pci_acpi_set_untrusted(struct pci_dev *dev)
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
@@ -1240,7 +1240,7 @@ static void pci_acpi_setup(struct device *dev)
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
index 0ca39042507ce..281be857d2430 100644
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
+	 * device enumerated downstream an external-facing device, is marked
+	 * as untrusted.
+	 */
+	unsigned int	external_facing:1;
 	unsigned int	broken_intx_masking:1;	/* INTx masking can't be used */
 	unsigned int	io_window_1k:1;		/* Intel bridge 1K I/O windows */
 	unsigned int	irq_managed:1;
-- 
2.27.0.212.ge8ba1cc988-goog

