Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35712BB976
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 23:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgKTWv6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 17:51:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:15001 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbgKTWv5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 17:51:57 -0500
IronPort-SDR: zdgG7ANR0ViG3dQXMr4vu+XapDxgR1o/+deN02h5zTRAA9wCKe80bLV82gbP9oLFnnTGfZceaA
 VyftQ/8lu1/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="168985737"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="168985737"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 14:51:57 -0800
IronPort-SDR: mV0Cu6xvUcP88u7sUFxqy/KRA/NGv8ikhRyiLo/RtntHQRLtxLubgJe1yX/AiQeDczj11yJlo3
 urCvfbqKGAkA==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="357852122"
Received: from sabakhle-mobl1.amr.corp.intel.com (HELO jderrick-mobl.amr.corp.intel.com) ([10.213.165.80])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 14:51:56 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Nirmal Patel <nirmal.patel@intel.com>,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 5/5] PCI: vmd: Add legacy guest passthrough mode
Date:   Fri, 20 Nov 2020 15:51:44 -0700
Message-Id: <20201120225144.15138-6-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201120225144.15138-1-jonathan.derrick@intel.com>
References: <20201120225144.15138-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some hypervisors allow passthrough of VMD to guests, but don't supply
the emulated vendor-specific capability. VMD users currently
passing-through VMD rely on a preconfiguration of the VMD Root Ports to
inform the guest of the physical addresses for offset mapping the bridge
windows.

This patch adds a non-visible module parameter to activate host or guest
passthrough mode. In host mode, this patch will write out the VMD MEMBAR
information into the root ports on module unload. Guest mode will use
the direct-assign hints, saving the host-supplied root port information
on VMD module load and restore on exit. It uses this information in the
offset calculation for bridge windows.

This is enabled by non-visible module parameter because it is
non-standard use case for certain users for a legacy behavior.

Link: https://lore.kernel.org/linux-pci/20200706091625.GA26377@e121166-lin.cambridge.arm.com/
Signed-off-by: Sushma Kalakota <sushmax.kalakota@intel.com>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 127 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 71aa002..711bbee 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -35,6 +35,19 @@
 #define MB2_SHADOW_OFFSET	0x2000
 #define MB2_SHADOW_SIZE		16
 
+enum legacy_da_mode {
+	VMD_DA_NONE,
+	VMD_DA_HOST,
+	VMD_DA_GUEST,
+};
+
+static int legacy_da_mode;
+static char legacy_da_mode_str[sizeof("guest")];
+module_param_string(legacy_da_mode, legacy_da_mode_str,
+		    sizeof(legacy_da_mode_str), 0);
+MODULE_PARM_DESC(legacy_da_mode,
+	"use legacy host-provided addressing hints in Root Ports to assist guest passthrough (off, host, guest)");
+
 enum vmd_features {
 	/*
 	 * Device may contain registers which hint the physical location of the
@@ -97,6 +110,12 @@ struct vmd_irq_list {
 	unsigned int		count;
 };
 
+struct root_port_addr {
+	int port;
+	u64 membase;
+	u64 pref_membase;
+};
+
 struct vmd_dev {
 	struct pci_dev		*dev;
 
@@ -112,6 +131,7 @@ struct vmd_dev {
 	struct pci_bus		*bus;
 	u8			busn_start;
 	u8			first_vec;
+	struct root_port_addr	rp_addr;
 };
 
 static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
@@ -483,6 +503,97 @@ static int vmd_find_free_domain(void)
 	return domain + 1;
 }
 
+#define VMD_RP_BASE(vmd, port) ((vmd)->cfgbar + (port) * 8 * 4096)
+static void vmd_save_root_port_info(struct vmd_dev *vmd)
+{
+	resource_size_t physical = 0;
+	char __iomem *addr;
+	int port;
+
+	if (upper_32_bits(pci_resource_start(vmd->dev, VMD_MEMBAR1)))
+		return;
+
+	for (port = 0; port < 4; port++) {
+		u32 membase;
+
+		addr = VMD_RP_BASE(vmd, port) + PCI_MEMORY_BASE;
+		membase = readl(addr);
+
+		/* Break on first found root port */
+		if ((membase != 0xffffffff) && (membase != 0) &&
+		    (membase != 0x0000fff0))
+			break;
+	}
+
+	if (port >= 4)
+		return;
+
+	vmd->rp_addr.port = port;
+
+	/* Only save the first root port index in host mode */
+	if (legacy_da_mode == VMD_DA_HOST)
+		return;
+
+	addr = VMD_RP_BASE(vmd, port) + PCI_MEMORY_BASE;
+	physical = ((u64)readw(addr) & 0xfff0) << 16;
+	vmd->rp_addr.membase = physical;
+
+	addr = VMD_RP_BASE(vmd, port) + PCI_PREF_BASE_UPPER32;
+	physical = ((u64)readl(addr)) << 32;
+	vmd->rp_addr.pref_membase = physical;
+
+	addr = VMD_RP_BASE(vmd, port) + PCI_PREF_MEMORY_BASE;
+	physical |= ((u64)readw(addr) & 0xfff0) << 16;
+	vmd->rp_addr.pref_membase |= physical;
+
+	writel(0, VMD_RP_BASE(vmd, port) + PCI_MEMORY_BASE);
+	writel(0, VMD_RP_BASE(vmd, port) + PCI_PREF_BASE_UPPER32);
+	writel(0, VMD_RP_BASE(vmd, port) + PCI_PREF_MEMORY_BASE);
+	writel(0, VMD_RP_BASE(vmd, port) + PCI_PREF_MEMORY_LIMIT);
+}
+
+static void vmd_restore_root_port_info(struct vmd_dev *vmd)
+{
+	resource_size_t	phyaddr;
+	char __iomem *addr;
+	u32 val;
+	int port;
+
+	port = vmd->rp_addr.port;
+	if (legacy_da_mode == VMD_DA_HOST) {
+		/* Write the MEMBAR information to prepare the guest */
+		phyaddr = pci_resource_start(vmd->dev, VMD_MEMBAR1);
+		if (upper_32_bits(phyaddr))
+			return;
+
+		addr = VMD_RP_BASE(vmd, port) + PCI_MEMORY_BASE;
+		val = (phyaddr >> 16) & 0xfff0;
+		writew(val, addr);
+
+		phyaddr = pci_resource_start(vmd->dev, VMD_MEMBAR2);
+		addr = VMD_RP_BASE(vmd, port) + PCI_PREF_BASE_UPPER32;
+		val = phyaddr >> 32;
+		writel(val, addr);
+
+		addr = VMD_RP_BASE(vmd, port) + PCI_PREF_MEMORY_BASE;
+		val = (phyaddr >> 16) & 0xfff0;
+		writew(val, addr);
+	} else if (legacy_da_mode == VMD_DA_GUEST) {
+		/* Restore information provided by Host */
+		addr = VMD_RP_BASE(vmd, port) + PCI_MEMORY_BASE;
+		val = (vmd->rp_addr.membase >> 16) & 0xfff0;
+		writew(val, addr);
+
+		addr = VMD_RP_BASE(vmd, port) + PCI_PREF_BASE_UPPER32;
+		val = vmd->rp_addr.pref_membase >> 32;
+		writel(val, addr);
+
+		addr = VMD_RP_BASE(vmd, port) + PCI_PREF_MEMORY_BASE;
+		val = (vmd->rp_addr.pref_membase >> 16) & 0xfff0;
+		writew(val, addr);
+	}
+}
+
 static void vmd_phys_to_offset(struct vmd_dev *vmd, u64 phys1, u64 phys2,
 				 resource_size_t *offset1,
 				 resource_size_t *offset2)
@@ -500,7 +611,19 @@ static int vmd_get_phys_offsets(struct vmd_dev *vmd, unsigned long features,
 	struct pci_dev *dev = vmd->dev;
 	u64 phys1, phys2;
 
-	if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
+	if (!strncmp(legacy_da_mode_str, "host", 4))
+		legacy_da_mode = VMD_DA_HOST;
+	else if (!strncmp(legacy_da_mode_str, "guest", 5))
+		legacy_da_mode = VMD_DA_GUEST;
+
+	if (legacy_da_mode != VMD_DA_NONE) {
+		vmd_save_root_port_info(vmd);
+		if (legacy_da_mode == VMD_DA_GUEST) {
+			vmd_phys_to_offset(vmd, vmd->rp_addr.membase,
+					   vmd->rp_addr.pref_membase,
+					   offset1, offset2);
+		}
+	} else if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
 		u32 vmlock;
 		int ret;
 
@@ -732,6 +855,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	if (!vmd->bus) {
 		pci_free_resource_list(&resources);
 		vmd_remove_irq_domain(vmd);
+		vmd_restore_root_port_info(vmd);
 		return -ENODEV;
 	}
 
@@ -821,6 +945,7 @@ static void vmd_remove(struct pci_dev *dev)
 	vmd_cleanup_srcu(vmd);
 	vmd_detach_resources(vmd);
 	vmd_remove_irq_domain(vmd);
+	vmd_restore_root_port_info(vmd);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
1.8.3.1

