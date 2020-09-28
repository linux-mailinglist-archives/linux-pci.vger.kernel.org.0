Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F368127A516
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 03:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgI1BLq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 21:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgI1BLp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Sep 2020 21:11:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8860C0613CE;
        Sun, 27 Sep 2020 18:11:45 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x22so7813568pfo.12;
        Sun, 27 Sep 2020 18:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3FpCdq40qaHHJ+6I8hJ9zZ5vU56SPuY+MNGmHqX84vs=;
        b=jj/0c5aIarQn9ZmrVgy86bahreWeeiXRw5kzfH2ZKEnfi3Lshwk8xrpet72eOViYBr
         WayHnRGnuBqcdJ63tttF82PYBcMRTpY/WiF1HwsGF3BBPTCh0WStHykEjjIuUkoqLEWQ
         JgosQX6MdG/BAp8MEy6LP634wciP48Q2g+iNZGCrL7D3rIfxoU/0KNlcyXEs6UboB86c
         sRqyM7C/seN/9VuXBH/FSf2WaXI0sYvxsD0Z0zbicSpB/L4kTfwXYQSFxm5ps9LnIDdR
         T5m2o4YPK8GLFeFfCAuEPvfYguf9XHHo9DMFJv6xTDyGWDYDfIDeYN3Uawu4159PMIUT
         FxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3FpCdq40qaHHJ+6I8hJ9zZ5vU56SPuY+MNGmHqX84vs=;
        b=ObhScCoCYL20XchDoawphZkglZQtsV9WwZdrVWG+ZRPsUsK90IiJafciTgFYxurjQ0
         PO9stoM8+2lXtvtcmIgBJAEzfsvZxix5AZH79SxL7zUxJqbMb+064hU+KBJ7Vpx1fhRY
         oHSjgye7m6gujVwOaABMGISporM2oQV51hSoeSX+ax6N7NIsOxtBSsHtxzRGAysiVmcD
         hEcoPjhO4SskgAD0nWTNOBqnOKY91SJhfA/tTElpeoG63QH+IenwfKLWxmVxWWY+5K7w
         y1Gy1xPKk6ZbgflkFe9xkZr7OKtWBShHofPRlrg2PZ/IOejcBjvyAp1Db4jtoirVxsZJ
         7ZVA==
X-Gm-Message-State: AOAM531rt54DIbJ77kf0zKF1Yas9lYjEnc+zbxsGjIYA/j7dsDLCmMkU
        aK2Yo6aEErQ/VjIY7lYqFmk=
X-Google-Smtp-Source: ABdhPJz75H/TcvCRpimFPuwLVxjQ/C6tOKz9HZS2hNGfsTqbSjS035NxxIBF9U2pQdokGDk4za4L2Q==
X-Received: by 2002:a63:e444:: with SMTP id i4mr7151702pgk.304.1601255505382;
        Sun, 27 Sep 2020 18:11:45 -0700 (PDT)
Received: from skuppusw-mobl5.amr.corp.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id 137sm9368048pfb.183.2020.09.27.18.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 18:11:45 -0700 (PDT)
From:   Kuppuswamy Sathyanarayanan <sathyanarayanan.nkuppuswamy@gmail.com>
X-Google-Original-From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v9 2/5] ACPI/PCI: Ignore _OSC negotiation result if pcie_ports_native is set.
Date:   Sun, 27 Sep 2020 18:11:33 -0700
Message-Id: <6b39e90a03b8c2b999a0307ea307cc1d413382c6.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcie_ports_native is set only if user requests native handling
of PCIe capabilities via pcie_port_setup command line option.
User input takes precedence over _OSC based control negotiation
result. So consider the _OSC negotiated result only if
pcie_ports_native is unset.

Also, since struct pci_host_bridge ->native_* members caches the
ownership status of various PCIe capabilities, use them instead
of distributed checks for pcie_ports_native.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/acpi/pci_root.c           | 33 +++++++++++++++++++++----------
 drivers/pci/hotplug/pciehp_core.c |  2 +-
 drivers/pci/pci-acpi.c            |  3 ---
 drivers/pci/pcie/aer.c            |  2 +-
 drivers/pci/pcie/portdrv_core.c   |  9 +++------
 include/linux/acpi.h              |  2 ++
 6 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index f90e841c59f5..9749b7abdd7e 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -43,6 +43,10 @@ static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
 				| OSC_PCI_CLOCK_PM_SUPPORT \
 				| OSC_PCI_MSI_SUPPORT)
 
+#define OSC_OWNER(ctrl, bit, flag) \
+	if (!(ctrl & bit)) \
+		flag = 0;
+
 static const struct acpi_device_id root_device_ids[] = {
 	{"PNP0A03", 0},
 	{"", 0},
@@ -889,6 +893,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	struct pci_bus *bus;
 	struct pci_host_bridge *host_bridge;
 	union acpi_object *obj;
+	u32 ctrl;
 
 	info->root = root;
 	info->bridge = device;
@@ -914,18 +919,26 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 		goto out_release_info;
 
 	host_bridge = to_pci_host_bridge(bus->bridge);
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
-		host_bridge->native_pcie_hotplug = 0;
+
+	  if (pcie_ports_native) {
+		  decode_osc_control(root, "OS forcibly taking over",
+				     OSC_PCI_EXPRESS_CONTROL_MASKS);
+	  } else {
+		  ctrl = root->osc_control_set;
+		  OSC_OWNER(ctrl, OSC_PCI_EXPRESS_NATIVE_HP_CONTROL,
+			    host_bridge->native_pcie_hotplug);
+		  OSC_OWNER(ctrl, OSC_PCI_EXPRESS_AER_CONTROL,
+			    host_bridge->native_aer);
+		  OSC_OWNER(ctrl, OSC_PCI_EXPRESS_PME_CONTROL,
+			    host_bridge->native_pme);
+		  OSC_OWNER(ctrl, OSC_PCI_EXPRESS_LTR_CONTROL,
+			    host_bridge->native_ltr);
+		  OSC_OWNER(ctrl, OSC_PCI_EXPRESS_DPC_CONTROL,
+			    host_bridge->native_dpc);
+	  }
+
 	if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
 		host_bridge->native_shpc_hotplug = 0;
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_AER_CONTROL))
-		host_bridge->native_aer = 0;
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_PME_CONTROL))
-		host_bridge->native_pme = 0;
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
-		host_bridge->native_ltr = 0;
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
-		host_bridge->native_dpc = 0;
 
 	/*
 	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ad3393930ecb..d1831e6bf60a 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -256,7 +256,7 @@ static bool pme_is_native(struct pcie_device *dev)
 	const struct pci_host_bridge *host;
 
 	host = pci_find_host_bridge(dev->port->bus);
-	return pcie_ports_native || host->native_pme;
+	return host->native_pme;
 }
 
 static void pciehp_disable_interrupt(struct pcie_device *dev)
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index d5869a03f748..2e53d8bf1fe5 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -800,9 +800,6 @@ bool pciehp_is_native(struct pci_dev *bridge)
 	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
 		return false;
 
-	if (pcie_ports_native)
-		return true;
-
 	host = pci_find_host_bridge(bridge->bus);
 	return host->native_pcie_hotplug;
 }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 65dff5f3457a..79bb441139c2 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -219,7 +219,7 @@ int pcie_aer_is_native(struct pci_dev *dev)
 	if (!dev->aer_cap)
 		return 0;
 
-	return pcie_ports_native || host->native_aer;
+	return host->native_aer;
 }
 
 int pci_enable_pcie_error_reporting(struct pci_dev *dev)
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 50a9522ab07d..ccd5e0ce5605 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -208,8 +208,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 	int services = 0;
 
-	if (dev->is_hotplug_bridge &&
-	    (pcie_ports_native || host->native_pcie_hotplug)) {
+	if (dev->is_hotplug_bridge && host->native_pcie_hotplug) {
 		services |= PCIE_PORT_SERVICE_HP;
 
 		/*
@@ -221,8 +220,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	}
 
 #ifdef CONFIG_PCIEAER
-	if (dev->aer_cap && pci_aer_available() &&
-	    (pcie_ports_native || host->native_aer)) {
+	if (dev->aer_cap && pci_aer_available() && host->native_aer) {
 		services |= PCIE_PORT_SERVICE_AER;
 
 		/*
@@ -238,8 +236,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	 * Event Collectors can also generate PMEs, but we don't handle
 	 * those yet.
 	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
-	    (pcie_ports_native || host->native_pme)) {
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT && host->native_pme) {
 		services |= PCIE_PORT_SERVICE_PME;
 
 		/*
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 1e4cdc6c7ae2..a1b2b16f34ce 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -569,6 +569,8 @@ extern bool osc_pc_lpi_support_confirmed;
 #define OSC_PCI_EXPRESS_LTR_CONTROL		0x00000020
 #define OSC_PCI_EXPRESS_DPC_CONTROL		0x00000080
 #define OSC_PCI_CONTROL_MASKS			0x000000bf
+/* Masks specific to PCIe Capabilities */
+#define OSC_PCI_EXPRESS_CONTROL_MASKS		0x000000bd
 
 #define ACPI_GSB_ACCESS_ATTRIB_QUICK		0x00000002
 #define ACPI_GSB_ACCESS_ATTRIB_SEND_RCV         0x00000004
-- 
2.17.1

