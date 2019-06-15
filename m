Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB47246D34
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2019 02:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfFOAaH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 20:30:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:46452 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfFOAaH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 20:30:07 -0400
Received: from ufdda393ec48b57.ant.amazon.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5F0TfFR010961;
        Fri, 14 Jun 2019 19:29:46 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sinan Kaya <okaya@kernel.org>, Ali Saidi <alisaidi@amazon.com>,
        Zeev Zilberman <zeev@amazon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/4] pci: acpi: Read _DSM #5 from ACPI on root bridges
Date:   Sat, 15 Jun 2019 10:23:57 +1000
Message-Id: <20190615002359.29577-2-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190615002359.29577-1-benh@kernel.crashing.org>
References: <20190615002359.29577-1-benh@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reads _DSM #5 value on root bridges, and when 0, sets a "preserve_config"
flag in the host bridge structure indicating that the FW has requested that
the existing configuration be preserved.

The upcoming spec change to define _DSM #5 for host bridges states that
this should be the default behaviour, however doing so would be very
intrusive and break existing setups. So we leave the default to be
the existing behaviour.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/acpi/pci_root.c  | 23 +++++++++++++++++++++++
 include/linux/pci-acpi.h |  7 ++++---
 include/linux/pci.h      |  2 ++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 39f5d172e84f..217b3916f0f1 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -881,6 +881,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	int node = acpi_get_node(device->handle);
 	struct pci_bus *bus;
 	struct pci_host_bridge *host_bridge;
+	union acpi_object *obj;
 
 	info->root = root;
 	info->bridge = device;
@@ -917,6 +918,28 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
 		host_bridge->native_ltr = 0;
 
+	/*
+	 * Invoke the PCI device specific method (_DSM) #5 'Ignore PCI Boot
+	 * Configuration', on the host bridge. This tells us whether the
+	 * firmware wants us to preserve or reassign the configuration of
+	 * the PCI resource tree for this root bridge.
+	 *
+	 * For now, we only care about the function being present and returning
+	 * 0, which we use to set a flag indicating that we'll preserve the
+	 * FW configuration.
+	 *
+	 * This diverges from the spec which states that 0 is also the default
+	 * in absence of _DSM #5. We do that today to work around the fact that
+	 * our arm64 code doesn't implement the right defaults otherwise. This
+	 * will be superseeded by a more thorough handling of _DSM #5 once the
+	 * resource survey code has been consolidated further.
+	 */
+	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
+	                        IGNORE_PCI_BOOT_CONFIG_DSM, NULL);
+	if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 0)
+		host_bridge->preserve_config = 1;
+	ACPI_FREE(obj);
+
 	pci_scan_child_bus(bus);
 	pci_set_host_bridge_release(host_bridge, acpi_pci_root_release_info,
 				    info);
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 8082b612f561..62b7fdcc661c 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -107,9 +107,10 @@ static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
 #endif
 
 extern const guid_t pci_acpi_dsm_guid;
-#define DEVICE_LABEL_DSM	0x07
-#define RESET_DELAY_DSM		0x08
-#define FUNCTION_DELAY_DSM	0x09
+#define IGNORE_PCI_BOOT_CONFIG_DSM	0x05
+#define DEVICE_LABEL_DSM		0x07
+#define RESET_DELAY_DSM			0x08
+#define FUNCTION_DELAY_DSM		0x09
 
 #else	/* CONFIG_ACPI */
 static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index dd436da7eccc..c50389b8df3c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -506,6 +506,8 @@ struct pci_host_bridge {
 	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
 	unsigned int	native_pme:1;		/* OS may use PCIe PME */
 	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
+        unsigned int    preserve_config:1;	/* Preserve FW resources setup */
+
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
 			const struct resource *res,
-- 
2.17.1

