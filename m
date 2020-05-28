Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FEB1E547D
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 05:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgE1DTF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 23:19:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:13839 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbgE1DTE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 May 2020 23:19:04 -0400
IronPort-SDR: A1QtLyKkkzWrO0tqzkKMN8AfO7jXZj3HJJxrVquAybidAfQskorVaePFBdd3ytIoTJUgf6snvz
 GHTGsutp96HQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 20:19:04 -0700
IronPort-SDR: mVqD7UuuK0pzlLigxY/k0WKh8Iixj1jQRE7w5ekg2DqCtwPlLJTcwGT/+v6XwhEmzgOB38Ohik
 cx/1CayNELNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; 
   d="scan'208";a="310775944"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.74])
  by FMSMGA003.fm.intel.com with ESMTP; 27 May 2020 20:19:03 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>, qemu-devel@nongnu.org
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        virtualization@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v3 FOR QEMU v3] hw/vfio: Add VMD Passthrough Quirk
Date:   Wed, 27 May 2020 23:02:38 -0400
Message-Id: <20200528030240.16024-2-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200528030240.16024-1-jonathan.derrick@intel.com>
References: <20200528030240.16024-1-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The VMD endpoint provides a real PCIe domain to the guest, including
bridges and endpoints. Because the VMD domain is enumerated by the guest
kernel, the guest kernel will assign Guest Physical Addresses to the
downstream endpoint BARs and bridge windows.

When the guest kernel performs MMIO to VMD sub-devices, MMU will
translate from the guest address space to the physical address space.
Because the bridges have been programmed with guest addresses, the
bridges will reject the transaction containing physical addresses.

VMD device 28C0 natively assists passthrough by providing the Host
Physical Address in shadow registers accessible to the guest for bridge
window assignment. The shadow registers are valid if bit 1 is set in VMD
VMLOCK config register 0x70.

In order to support existing VMDs, this quirk provides the shadow
registers in a vendor-specific PCI capability to the vfio-passthrough
device for all VMD device ids which don't natively assist with
passthrough. The Linux VMD driver is updated to check for this new
vendor-specific capability.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 hw/vfio/pci-quirks.c | 84 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 72 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 3bd05fed12..6b8c1edfd5 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1567,18 +1567,6 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
     return 0;
 }
 
-int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
-{
-    int ret;
-
-    ret = vfio_add_nv_gpudirect_cap(vdev, errp);
-    if (ret) {
-        return ret;
-    }
-
-    return 0;
-}
-
 static void vfio_pci_nvlink2_get_tgt(Object *obj, Visitor *v,
                                      const char *name,
                                      void *opaque, Error **errp)
@@ -1709,3 +1697,75 @@ free_exit:
 
     return ret;
 }
+
+/*
+ * The VMD endpoint provides a real PCIe domain to the guest and the guest
+ * kernel performs enumeration of the VMD sub-device domain. Guest transactions
+ * to VMD sub-devices go through MMU translation from guest addresses to
+ * physical addresses. When MMIO goes to an endpoint after being translated to
+ * physical addresses, the bridge rejects the transaction because the window
+ * has been programmed with guest addresses.
+ *
+ * VMD can use the Host Physical Address in order to correctly program the
+ * bridge windows in its PCIe domain. VMD device 28C0 has HPA shadow registers
+ * located at offset 0x2000 in MEMBAR2 (BAR 4). This quirk provides the HPA
+ * shadow registers in a vendor-specific capability register for devices
+ * without native support. The position of 0xE8-0xFF is in the reserved range
+ * of the VMD device capability space following the Power Management
+ * Capability.
+ */
+#define VMD_SHADOW_CAP_VER 1
+#define VMD_SHADOW_CAP_LEN 24
+static int vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
+{
+    uint8_t membar_phys[16];
+    int ret, pos = 0xE8;
+
+    if (!(vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, 0x201D) ||
+          vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, 0x467F) ||
+          vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, 0x4C3D) ||
+          vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, 0x9A0B))) {
+        return 0;
+    }
+
+    ret = pread(vdev->vbasedev.fd, membar_phys, 16,
+                vdev->config_offset + PCI_BASE_ADDRESS_2);
+    if (ret != 16) {
+        error_report("VMD %s cannot read MEMBARs (%d)",
+                     vdev->vbasedev.name, ret);
+        return -EFAULT;
+    }
+
+    ret = pci_add_capability(&vdev->pdev, PCI_CAP_ID_VNDR, pos,
+                             VMD_SHADOW_CAP_LEN, errp);
+    if (ret < 0) {
+        error_prepend(errp, "Failed to add VMD MEMBAR Shadow cap: ");
+        return ret;
+    }
+
+    memset(vdev->emulated_config_bits + pos, 0xFF, VMD_SHADOW_CAP_LEN);
+    pos += PCI_CAP_FLAGS;
+    pci_set_byte(vdev->pdev.config + pos++, VMD_SHADOW_CAP_LEN);
+    pci_set_byte(vdev->pdev.config + pos++, VMD_SHADOW_CAP_VER);
+    pci_set_long(vdev->pdev.config + pos, 0x53484457); /* SHDW */
+    memcpy(vdev->pdev.config + pos + 4, membar_phys, 16);
+
+    return 0;
+}
+
+int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
+{
+    int ret;
+
+    ret = vfio_add_nv_gpudirect_cap(vdev, errp);
+    if (ret) {
+        return ret;
+    }
+
+    ret = vfio_add_vmd_shadow_cap(vdev, errp);
+    if (ret) {
+        return ret;
+    }
+
+    return 0;
+}
-- 
2.18.1

