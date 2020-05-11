Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5401CE3BB
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 21:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgEKTRV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 15:17:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:10033 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730974AbgEKTRU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 May 2020 15:17:20 -0400
IronPort-SDR: D3yYnAWL6oJ0V2RTIKH/7su77z+5OB81OPq2N7n+Pvy1WW0hi8AlXhDjDj9tzo1PAX8iH8/Yrh
 rjNKHoGEDKFg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 12:17:20 -0700
IronPort-SDR: J1dl4aw3xiNFGvwucvJnxSy7hn4p9TQdkAA/AN+skUvWZgoHHx+3AVCX5+Gaf7cNBFaI/pIN7I
 AeD6RKVGKtww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; 
   d="scan'208";a="463494237"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.74])
  by fmsmga006.fm.intel.com with ESMTP; 11 May 2020 12:17:20 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>, qemu-devel@nongnu.org
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        virtualization@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH for QEMU v2] hw/vfio: Add VMD Passthrough Quirk
Date:   Mon, 11 May 2020 15:01:27 -0400
Message-Id: <20200511190129.9313-2-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200511190129.9313-1-jonathan.derrick@intel.com>
References: <20200511190129.9313-1-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The VMD endpoint provides a real PCIe domain to the guest, including
bridges and endpoints. Because the VMD domain is enumerated by the guest
kernel, the guest kernel will assign Guest Physical Addresses to the
downstream endpoint BARs and bridge windows.

When the guest kernel performs MMIO to VMD sub-devices, IOMMU will
translate from the guest address space to the physical address space.
Because the bridges have been programmed with guest addresses, the
bridges will reject the transaction containing physical addresses.

VMD device 28C0 natively assists passthrough by providing the Host
Physical Address in shadow registers accessible to the guest for bridge
window assignment. The shadow registers are valid if bit 1 is set in VMD
VMLOCK config register 0x70. Future VMDs will also support this feature.
Existing VMDs have config register 0x70 reserved, and will return 0 on
reads.

In order to support existing VMDs, this quirk emulates the VMLOCK and
HPA shadow registers for all VMD device ids which don't natively assist
with passthrough. The Linux VMD driver is updated to allow existing VMD
devices to query VMLOCK for passthrough support.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 hw/vfio/pci-quirks.c | 103 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c        |   7 +++
 hw/vfio/pci.h        |   2 +
 hw/vfio/trace-events |   3 ++
 4 files changed, 115 insertions(+)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 2d348f8237..4060a6a95d 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1709,3 +1709,106 @@ free_exit:
 
     return ret;
 }
+
+/*
+ * The VMD endpoint provides a real PCIe domain to the guest and the guest
+ * kernel performs enumeration of the VMD sub-device domain. Guest transactions
+ * to VMD sub-devices go through IOMMU translation from guest addresses to
+ * physical addresses. When MMIO goes to an endpoint after being translated to
+ * physical addresses, the bridge rejects the transaction because the window
+ * has been programmed with guest addresses.
+ *
+ * VMD can use the Host Physical Address in order to correctly program the
+ * bridge windows in its PCIe domain. VMD device 28C0 has HPA shadow registers
+ * located at offset 0x2000 in MEMBAR2 (BAR 4). The shadow registers are valid
+ * if bit 1 is set in the VMD VMLOCK config register 0x70. VMD devices without
+ * this native assistance can have these registers safely emulated as these
+ * registers are reserved.
+ */
+typedef struct VFIOVMDQuirk {
+    VFIOPCIDevice *vdev;
+    uint64_t membar_phys[2];
+} VFIOVMDQuirk;
+
+static uint64_t vfio_vmd_quirk_read(void *opaque, hwaddr addr, unsigned size)
+{
+    VFIOVMDQuirk *data = opaque;
+    uint64_t val = 0;
+
+    memcpy(&val, (void *)data->membar_phys + addr, size);
+    return val;
+}
+
+static const MemoryRegionOps vfio_vmd_quirk = {
+    .read = vfio_vmd_quirk_read,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+#define VMD_VMLOCK  0x70
+#define VMD_SHADOW  0x2000
+#define VMD_MEMBAR2 4
+
+static int vfio_vmd_emulate_shadow_registers(VFIOPCIDevice *vdev)
+{
+    VFIOQuirk *quirk;
+    VFIOVMDQuirk *data;
+    PCIDevice *pdev = &vdev->pdev;
+    int ret;
+
+    data = g_malloc0(sizeof(*data));
+    ret = pread(vdev->vbasedev.fd, data->membar_phys, 16,
+                vdev->config_offset + PCI_BASE_ADDRESS_2);
+    if (ret != 16) {
+        error_report("VMD %s cannot read MEMBARs (%d)",
+                     vdev->vbasedev.name, ret);
+        g_free(data);
+        return -EFAULT;
+    }
+
+    quirk = vfio_quirk_alloc(1);
+    quirk->data = data;
+    data->vdev = vdev;
+
+    /* Emulate Shadow Registers */
+    memory_region_init_io(quirk->mem, OBJECT(vdev), &vfio_vmd_quirk, data,
+                          "vfio-vmd-quirk", sizeof(data->membar_phys));
+    memory_region_add_subregion_overlap(vdev->bars[VMD_MEMBAR2].region.mem,
+                                        VMD_SHADOW, quirk->mem, 1);
+    memory_region_set_readonly(quirk->mem, true);
+    memory_region_set_enabled(quirk->mem, true);
+
+    QLIST_INSERT_HEAD(&vdev->bars[VMD_MEMBAR2].quirks, quirk, next);
+
+    trace_vfio_pci_vmd_quirk_shadow_regs(vdev->vbasedev.name,
+                                         data->membar_phys[0],
+                                         data->membar_phys[1]);
+
+    /* Advertise Shadow Register support */
+    pci_byte_test_and_set_mask(pdev->config + VMD_VMLOCK, 0x2);
+    pci_set_byte(pdev->wmask + VMD_VMLOCK, 0);
+    pci_set_byte(vdev->emulated_config_bits + VMD_VMLOCK, 0x2);
+
+    trace_vfio_pci_vmd_quirk_vmlock(vdev->vbasedev.name,
+                                    pci_get_byte(pdev->config + VMD_VMLOCK));
+
+    return 0;
+}
+
+int vfio_pci_vmd_init(VFIOPCIDevice *vdev)
+{
+    int ret = 0;
+
+    switch (vdev->device_id) {
+    case 0x28C0: /* Native passthrough support */
+        break;
+    /* Emulates Native passthrough support */
+    case 0x201D:
+    case 0x467F:
+    case 0x4C3D:
+    case 0x9A0B:
+        ret = vfio_vmd_emulate_shadow_registers(vdev);
+        break;
+    }
+
+    return ret;
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5e75a95129..85425a1a6f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3024,6 +3024,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         }
     }
 
+    if (vdev->vendor_id == PCI_VENDOR_ID_INTEL) {
+        ret = vfio_pci_vmd_init(vdev);
+        if (ret) {
+            error_report("Failed to setup VMD");
+        }
+    }
+
     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 0da7a20a7e..e8632d806b 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -217,6 +217,8 @@ int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
 int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp);
 int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Error **errp);
 
+int vfio_pci_vmd_init(VFIOPCIDevice *vdev);
+
 void vfio_display_reset(VFIOPCIDevice *vdev);
 int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
 void vfio_display_finalize(VFIOPCIDevice *vdev);
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index b1ef55a33f..ed64e477db 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -90,6 +90,9 @@ vfio_pci_nvidia_gpu_setup_quirk(const char *name, uint64_t tgt, uint64_t size) "
 vfio_pci_nvlink2_setup_quirk_ssatgt(const char *name, uint64_t tgt, uint64_t size) "%s tgt=0x%"PRIx64" size=0x%"PRIx64
 vfio_pci_nvlink2_setup_quirk_lnkspd(const char *name, uint32_t link_speed) "%s link_speed=0x%x"
 
+vfio_pci_vmd_quirk_shadow_regs(const char *name, uint64_t mb1, uint64_t mb2) "%s membar1_phys=0x%"PRIx64" membar2_phys=0x%"PRIx64
+vfio_pci_vmd_quirk_vmlock(const char *name, uint8_t vmlock) "%s vmlock=0x%x"
+
 # common.c
 vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
 vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
-- 
2.18.1

