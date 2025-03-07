Return-Path: <linux-pci+bounces-23169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7002A575E5
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 00:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4B23AC7C0
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 23:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341E71E1DE4;
	Fri,  7 Mar 2025 23:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIZDxZ4c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4EC19CC05
	for <linux-pci@vger.kernel.org>; Fri,  7 Mar 2025 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741389440; cv=none; b=LkvtVDOyNoIkJ47VWQvsdAynzs15ulpGGQoTBHLfRr1NSJLqG7nERRN7+iVLgUQ3D4426T57uqTLfO6499tvG86/+6VrrpZtaftjuktfgMv0aJDoIiFydRKVn4GooiFLAB7JFkQeh7uVCoRiX1JS3PXHBflePtaYfFzpmiql3nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741389440; c=relaxed/simple;
	bh=GNjJ/6cv9M7boOssKVPy0taspluHZ3Gd+brtlPPs1QM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RgiJ6yC4F/SWhUwA91sczYWHefo5rhDgmQjhuF/jYA1GDDCja5juN4F09uPsTWn3asQBCrN6CtImGhoyZhg8VeU+8ZRYCZrKp7rTIkp2iaAvIUvJlSiLEBnm35jkxWjK+bk5rn/PQYz+f3UdNMoEZqx6WE19TxsMsvOTCD549eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIZDxZ4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43627C4CED1;
	Fri,  7 Mar 2025 23:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741389439;
	bh=GNjJ/6cv9M7boOssKVPy0taspluHZ3Gd+brtlPPs1QM=;
	h=From:To:Cc:Subject:Date:From;
	b=UIZDxZ4cL+vuAvagZwnvNCm6ChF1Z1c+jpNPmQlJKJ53wnwpvvySjLw80hG7eq2af
	 RCSTCh74Ww8WkcpylvxJ26HGBkEFznJJloRsny6ywekahULqgWc889Zn0+KgFXlv6C
	 VL9e5zyDh9FWvqo2BfnyvObQzvWt/fxXpGUHpQPxacYrsWQwDhT0wDJfhttdkBzFuS
	 RltV0Z0bFlkGmpnsG0MCQrzyjl3A5lkK/+AevAeAjkhQCICNW2KobKyAWjOKt+nQqK
	 va7HTFMwHrASfVcROBudjHvn9p2bsASBw9kfaQaq/REYf1qNoCvRqxT5DYCn5ACQgC
	 P5p3rV+9MJd5Q==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2] PCI: Fix typos
Date: Fri,  7 Mar 2025 17:17:15 -0600
Message-Id: <20250307231715.438518-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos and whitespace errors.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---

Changes since v1: (https://lore.kernel.org/r/20250303211119.200365-1-helgaas@kernel.org)
  - OVERIDE -> OVERRIDE (Krzysztof)
  - SPCIFIC -> SPECIFIC (Krzysztof)
  - translateable -> translatable (Krzysztof)
  - fom -> from (Krzysztof)
  - Return: kernel doc fixes (Ilpo)
  - an Performance -> a Performance
  - device-node -> device node
  - an link -> the link

 .../pci/controller/cadence/pcie-cadence-ep.c  |  8 +--
 drivers/pci/controller/dwc/pcie-qcom-ep.c     | 12 ++--
 drivers/pci/controller/dwc/pcie-qcom.c        | 12 ++--
 drivers/pci/controller/pci-mvebu.c            |  2 +-
 drivers/pci/controller/pci-thunder-ecam.c     |  2 +-
 drivers/pci/controller/pci-xgene-msi.c        |  2 +-
 drivers/pci/controller/pcie-altera.c          |  2 +-
 drivers/pci/controller/pcie-brcmstb.c         |  4 +-
 drivers/pci/controller/pcie-rcar-host.c       | 10 +--
 drivers/pci/endpoint/Kconfig                  |  2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |  2 +-
 drivers/pci/hotplug/Kconfig                   |  2 +-
 drivers/pci/hotplug/pciehp_hpc.c              |  2 +-
 drivers/pci/msi/api.c                         |  2 +-
 drivers/pci/of.c                              |  9 ++-
 drivers/pci/pci.c                             |  2 +-
 drivers/pci/pcie/aer.c                        | 68 +++++++++----------
 drivers/pci/setup-bus.c                       |  2 +-
 include/linux/pci-epf.h                       | 17 ++---
 19 files changed, 84 insertions(+), 78 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index e0cc4560dfde..a4f7ed04d38b 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -301,12 +301,12 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
 	val |= interrupts;
 	cdns_pcie_ep_fn_writew(pcie, fn, reg, val);
 
-	/* Set MSIX BAR and offset */
+	/* Set MSI-X BAR and offset */
 	reg = cap + PCI_MSIX_TABLE;
 	val = offset | bir;
 	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
 
-	/* Set PBA BAR and offset.  BAR must match MSIX BAR */
+	/* Set PBA BAR and offset.  BAR must match MSI-X BAR */
 	reg = cap + PCI_MSIX_PBA;
 	val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
 	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
@@ -573,8 +573,8 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 
 	/*
 	 * Next function field in ARI_CAP_AND_CTR register for last function
-	 * should be 0.
-	 * Clearing Next Function Number field for the last function used.
+	 * should be 0.  Clear Next Function Number field for the last
+	 * function used.
 	 */
 	last_fn = find_last_bit(&epc->function_num_map, BITS_PER_LONG);
 	reg     = CDNS_PCIE_CORE_PF_I_ARI_CAP_AND_CTRL(last_fn);
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index c08f64d7a825..90819d528e7b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -48,7 +48,7 @@
 #define PARF_DBI_BASE_ADDR_HI			0x354
 #define PARF_SLV_ADDR_SPACE_SIZE		0x358
 #define PARF_SLV_ADDR_SPACE_SIZE_HI		0x35c
-#define PARF_NO_SNOOP_OVERIDE			0x3d4
+#define PARF_NO_SNOOP_OVERRIDE			0x3d4
 #define PARF_ATU_BASE_ADDR			0x634
 #define PARF_ATU_BASE_ADDR_HI			0x638
 #define PARF_SRIS_MODE				0x644
@@ -89,9 +89,9 @@
 #define PARF_DEBUG_INT_CFG_BUS_MASTER_EN	BIT(2)
 #define PARF_DEBUG_INT_RADM_PM_TURNOFF		BIT(3)
 
-/* PARF_NO_SNOOP_OVERIDE register fields */
-#define WR_NO_SNOOP_OVERIDE_EN                 BIT(1)
-#define RD_NO_SNOOP_OVERIDE_EN                 BIT(3)
+/* PARF_NO_SNOOP_OVERRIDE register fields */
+#define WR_NO_SNOOP_OVERRIDE_EN			BIT(1)
+#define RD_NO_SNOOP_OVERRIDE_EN			BIT(3)
 
 /* PARF_DEVICE_TYPE register fields */
 #define PARF_DEVICE_TYPE_EP			0x0
@@ -529,8 +529,8 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	writel_relaxed(val, pcie_ep->parf + PARF_LTSSM);
 
 	if (pcie_ep->cfg && pcie_ep->cfg->override_no_snoop)
-		writel_relaxed(WR_NO_SNOOP_OVERIDE_EN | RD_NO_SNOOP_OVERIDE_EN,
-				pcie_ep->parf + PARF_NO_SNOOP_OVERIDE);
+		writel_relaxed(WR_NO_SNOOP_OVERRIDE_EN | RD_NO_SNOOP_OVERRIDE_EN,
+				pcie_ep->parf + PARF_NO_SNOOP_OVERRIDE);
 
 	return 0;
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e4d3366ead1f..dc98ae63362d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -61,7 +61,7 @@
 #define PARF_DBI_BASE_ADDR_V2_HI		0x354
 #define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
 #define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
-#define PARF_NO_SNOOP_OVERIDE			0x3d4
+#define PARF_NO_SNOOP_OVERRIDE			0x3d4
 #define PARF_ATU_BASE_ADDR			0x634
 #define PARF_ATU_BASE_ADDR_HI			0x638
 #define PARF_DEVICE_TYPE			0x1000
@@ -135,9 +135,9 @@
 #define PARF_INT_ALL_LINK_UP			BIT(13)
 #define PARF_INT_MSI_DEV_0_7			GENMASK(30, 23)
 
-/* PARF_NO_SNOOP_OVERIDE register fields */
-#define WR_NO_SNOOP_OVERIDE_EN			BIT(1)
-#define RD_NO_SNOOP_OVERIDE_EN			BIT(3)
+/* PARF_NO_SNOOP_OVERRIDE register fields */
+#define WR_NO_SNOOP_OVERRIDE_EN			BIT(1)
+#define RD_NO_SNOOP_OVERRIDE_EN			BIT(3)
 
 /* PARF_DEVICE_TYPE register fields */
 #define DEVICE_TYPE_RC				0x4
@@ -1007,8 +1007,8 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 	const struct qcom_pcie_cfg *pcie_cfg = pcie->cfg;
 
 	if (pcie_cfg->override_no_snoop)
-		writel(WR_NO_SNOOP_OVERIDE_EN | RD_NO_SNOOP_OVERIDE_EN,
-				pcie->parf + PARF_NO_SNOOP_OVERIDE);
+		writel(WR_NO_SNOOP_OVERRIDE_EN | RD_NO_SNOOP_OVERRIDE_EN,
+				pcie->parf + PARF_NO_SNOOP_OVERRIDE);
 
 	qcom_pcie_clear_aspm_l0s(pcie->pci);
 	qcom_pcie_clear_hpc(pcie->pci);
diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 665f35f9d826..b0e3bce10aa4 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1422,7 +1422,7 @@ static void mvebu_pcie_powerdown(struct mvebu_pcie_port *port)
 }
 
 /*
- * devm_of_pci_get_host_bridge_resources() only sets up translateable resources,
+ * devm_of_pci_get_host_bridge_resources() only sets up translatable resources,
  * so we need extra resource setup parsing our special DT properties encoding
  * the MEM and IO apertures.
  */
diff --git a/drivers/pci/controller/pci-thunder-ecam.c b/drivers/pci/controller/pci-thunder-ecam.c
index b5bd10a62adb..08161065a89c 100644
--- a/drivers/pci/controller/pci-thunder-ecam.c
+++ b/drivers/pci/controller/pci-thunder-ecam.c
@@ -204,7 +204,7 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
 
 			v = readl(addr);
 			if (v & 0xff00)
-				pr_err("Bad MSIX cap header: %08x\n", v);
+				pr_err("Bad MSI-X cap header: %08x\n", v);
 			v |= 0xbc00; /* next capability is EA at 0xbc */
 			set_val(v, where, size, val);
 			return PCIBIOS_SUCCESSFUL;
diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index 88c0977bc41a..7bce327897c9 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -154,7 +154,7 @@ static void xgene_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
  * X-Gene v1 only has 16 MSI GIC IRQs for 2048 MSI vectors.  To maintain
  * the expected behaviour of .set_affinity for each MSI interrupt, the 16
  * MSI GIC IRQs are statically allocated to 8 X-Gene v1 cores (2 GIC IRQs
- * for each core).  The MSI vector is moved fom 1 MSI GIC IRQ to another
+ * for each core).  The MSI vector is moved from 1 MSI GIC IRQ to another
  * MSI GIC IRQ to steer its MSI interrupt to correct X-Gene v1 core.  As a
  * consequence, the total MSI vectors that X-Gene v1 supports will be
  * reduced to 256 (2048/8) vectors.
diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index eb55a7f8573a..e5b3d5dad4bc 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -149,7 +149,7 @@ static bool s10_altera_pcie_link_up(struct altera_pcie *pcie)
  * Altera PCIe port uses BAR0 of RC's configuration space as the translation
  * from PCI bus to native BUS.  Entire DDR region is mapped into PCIe space
  * using these registers, so it can be reached by DMA from EP devices.
- * This BAR0 will also access to MSI vector when receiving MSI/MSIX interrupt
+ * This BAR0 will also access to MSI vector when receiving MSI/MSI-X interrupt
  * from EP devices, eventually trigger interrupt to GIC.  The BAR0 of bridge
  * should be hidden during enumeration to avoid the sizing and resource
  * allocation by PCIe core.
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e733a27dc8df..65176826f750 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -40,7 +40,7 @@
 /* Broadcom STB PCIe Register Offsets */
 #define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1				0x0188
 #define  PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK	0xc
-#define  PCIE_RC_CFG_VENDOR_SPCIFIC_REG1_LITTLE_ENDIAN			0x0
+#define  PCIE_RC_CFG_VENDOR_SPECIFIC_REG1_LITTLE_ENDIAN			0x0
 
 #define PCIE_RC_CFG_PRIV1_ID_VAL3			0x043c
 #define  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK	0xffffff
@@ -1180,7 +1180,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 
 	/* PCIe->SCB endian mode for inbound window */
 	tmp = readl(base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1);
-	u32p_replace_bits(&tmp, PCIE_RC_CFG_VENDOR_SPCIFIC_REG1_LITTLE_ENDIAN,
+	u32p_replace_bits(&tmp, PCIE_RC_CFG_VENDOR_SPECIFIC_REG1_LITTLE_ENDIAN,
 		PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK);
 	writel(tmp, base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1);
 
diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 7c92eada04af..c32b803a47c7 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -178,8 +178,8 @@ static int rcar_pcie_config_access(struct rcar_pcie_host *host,
 	 * space, it's generally only accessible when in endpoint mode.
 	 * When in root complex mode, the controller is unable to target
 	 * itself with either type 0 or type 1 accesses, and indeed, any
-	 * controller initiated target transfer to its own config space
-	 * result in a completer abort.
+	 * controller-initiated target transfer to its own config space
+	 * results in a completer abort.
 	 *
 	 * Each channel effectively only supports a single device, but as
 	 * the same channel <-> device access works for any PCI_SLOT()
@@ -775,7 +775,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
 	if (err)
 		return err;
 
-	/* Two irqs are for MSI, but they are also used for non-MSI irqs */
+	/* Two IRQs are for MSI, but they are also used for non-MSI IRQs */
 	err = devm_request_irq(dev, msi->irq1, rcar_pcie_msi_irq,
 			       IRQF_SHARED | IRQF_NO_THREAD,
 			       rcar_msi_bottom_chip.name, host);
@@ -792,7 +792,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
 		goto err;
 	}
 
-	/* disable all MSIs */
+	/* Disable all MSIs */
 	rcar_pci_write_reg(pcie, 0, PCIEMSIIER);
 
 	/*
@@ -892,6 +892,7 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
 			dev_err(pcie->dev, "Failed to map inbound regions!\n");
 			return -EINVAL;
 		}
+
 		/*
 		 * If the size of the range is larger than the alignment of
 		 * the start address, we have to use multiple entries to
@@ -903,6 +904,7 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
 
 			size = min(size, alignment);
 		}
+
 		/* Hardware supports max 4GiB inbound region */
 		size = min(size, 1ULL << 32);
 
diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
index 17bbdc9bbde0..1c5d82eb57d4 100644
--- a/drivers/pci/endpoint/Kconfig
+++ b/drivers/pci/endpoint/Kconfig
@@ -26,7 +26,7 @@ config PCI_ENDPOINT_CONFIGFS
 	help
 	   This will enable the configfs entry that can be used to
 	   configure the endpoint function and used to bind the
-	   function with a endpoint controller.
+	   function with an endpoint controller.
 
 source "drivers/pci/endpoint/functions/Kconfig"
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index b94e205ae10b..ee1416c43f03 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -632,7 +632,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	case IRQ_TYPE_MSIX:
 		count = pci_epc_get_msix(epc, epf->func_no, epf->vfunc_no);
 		if (reg->irq_number > count || count <= 0) {
-			dev_err(dev, "Invalid MSIX IRQ number %d / %d\n",
+			dev_err(dev, "Invalid MSI-X IRQ number %d / %d\n",
 				reg->irq_number, count);
 			return;
 		}
diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 123c4c7c2ab5..3207860b52e4 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -97,7 +97,7 @@ config HOTPLUG_PCI_CPCI_ZT5550
 	tristate "Ziatech ZT5550 CompactPCI Hotplug driver"
 	depends on HOTPLUG_PCI_CPCI && X86
 	help
-	  Say Y here if you have an Performance Technologies (formerly Intel,
+	  Say Y here if you have a Performance Technologies (formerly Intel,
 	  formerly just Ziatech) Ziatech ZT5550 CompactPCI system card.
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bb5a8d9f03ad..e17bebe2ceb3 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -430,7 +430,7 @@ void pciehp_get_latch_status(struct controller *ctrl, u8 *status)
  * removed immediately after the check so the caller may need to take
  * this into account.
  *
- * It the hotplug controller itself is not available anymore returns
+ * If the hotplug controller itself is not available anymore returns
  * %-ENODEV.
  */
 int pciehp_card_present(struct controller *ctrl)
diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index b956ce591f96..17ec6332cb1d 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -162,7 +162,7 @@ struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
 EXPORT_SYMBOL_GPL(pci_msix_alloc_irq_at);
 
 /**
- * pci_msix_free_irq - Free an interrupt on a PCI/MSIX interrupt domain
+ * pci_msix_free_irq - Free an interrupt on a PCI/MSI-X interrupt domain
  *
  * @dev:	The PCI device to operate on
  * @map:	A struct msi_map describing the interrupt to free
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 7a806f5c0d20..0e4f9119f5f2 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -455,9 +455,9 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
  * @out_irq:    structure of_phandle_args filled by this function
  *
  * This function resolves the PCI interrupt for a given PCI device. If a
- * device-node exists for a given pci_dev, it will use normal OF tree
+ * device node exists for a given pci_dev, it will use normal OF tree
  * walking. If not, it will implement standard swizzling and walk up the
- * PCI tree until an device-node is found, at which point it will finish
+ * PCI tree until a device node is found, at which point it will finish
  * resolving using the OF tree walking.
  */
 static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
@@ -517,13 +517,16 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
 		}
 
 		/*
-		 * Ok, we have found a parent with a device-node, hand over to
+		 * Ok, we have found a parent with a device node, hand over to
 		 * the OF parsing code.
+		 *
 		 * We build a unit address from the linux device to be used for
 		 * resolution. Note that we use the linux bus number which may
 		 * not match your firmware bus numbering.
+		 *
 		 * Fortunately, in most cases, interrupt-map-mask doesn't
 		 * include the bus number as part of the matching.
+		 *
 		 * You should still be careful about that though if you intend
 		 * to rely on this function (you ship a firmware that doesn't
 		 * create device nodes for all PCI devices).
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..2fcd1e583966 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4766,7 +4766,7 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
 
 	/*
 	 * PCIe r4.0 sec 6.6.1, a component must enter LTSSM Detect within 20ms,
-	 * after which we should expect an link active if the reset was
+	 * after which we should expect the link to be active if the reset was
 	 * successful. If so, software must wait a minimum 100ms before sending
 	 * configuration requests to devices downstream this port.
 	 *
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 508474e17183..de0e1ca3396b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -2,7 +2,7 @@
 /*
  * Implement the AER root port service driver. The driver registers an IRQ
  * handler. When a root port triggers an AER interrupt, the IRQ handler
- * collects root port status and schedules work.
+ * collects Root Port status and schedules work.
  *
  * Copyright (C) 2006 Intel Corp.
  *	Tom Long Nguyen (tom.l.nguyen@intel.com)
@@ -56,9 +56,9 @@ struct aer_stats {
 	/*
 	 * Fields for all AER capable devices. They indicate the errors
 	 * "as seen by this device". Note that this may mean that if an
-	 * end point is causing problems, the AER counters may increment
-	 * at its link partner (e.g. root port) because the errors will be
-	 * "seen" by the link partner and not the problematic end point
+	 * Endpoint is causing problems, the AER counters may increment
+	 * at its link partner (e.g. Root Port) because the errors will be
+	 * "seen" by the link partner and not the problematic Endpoint
 	 * itself (which may report all counters as 0 as it never saw any
 	 * problems).
 	 */
@@ -76,10 +76,10 @@ struct aer_stats {
 	u64 dev_total_nonfatal_errs;
 
 	/*
-	 * Fields for Root ports & root complex event collectors only, these
+	 * Fields for Root Ports & Root Complex Event Collectors only; these
 	 * indicate the total number of ERR_COR, ERR_FATAL, and ERR_NONFATAL
-	 * messages received by the root port / event collector, INCLUDING the
-	 * ones that are generated internally (by the rootport itself)
+	 * messages received by the Root Port / Event Collector, INCLUDING the
+	 * ones that are generated internally (by the Root Port itself)
 	 */
 	u64 rootport_total_cor_errs;
 	u64 rootport_total_fatal_errs;
@@ -138,7 +138,7 @@ static const char * const ecrc_policy_str[] = {
  * enable_ecrc_checking - enable PCIe ECRC checking for a device
  * @dev: the PCI device
  *
- * Returns 0 on success, or negative on failure.
+ * Return: 0 on success, or negative on failure.
  */
 static int enable_ecrc_checking(struct pci_dev *dev)
 {
@@ -159,10 +159,10 @@ static int enable_ecrc_checking(struct pci_dev *dev)
 }
 
 /**
- * disable_ecrc_checking - disables PCIe ECRC checking for a device
+ * disable_ecrc_checking - disable PCIe ECRC checking for a device
  * @dev: the PCI device
  *
- * Returns 0 on success, or negative on failure.
+ * Return: 0 on success, or negative on failure.
  */
 static int disable_ecrc_checking(struct pci_dev *dev)
 {
@@ -283,10 +283,10 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
  * pci_aer_raw_clear_status - Clear AER error registers.
  * @dev: the PCI device
  *
- * Clearing AER error status registers unconditionally, regardless of
+ * Clear AER error status registers unconditionally, regardless of
  * whether they're owned by firmware or the OS.
  *
- * Returns 0 on success, or negative on failure.
+ * Return: 0 on success, or negative on failure.
  */
 int pci_aer_raw_clear_status(struct pci_dev *dev)
 {
@@ -378,8 +378,8 @@ void pci_aer_init(struct pci_dev *dev)
 	/*
 	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
 	 * PCI_ERR_COR_MASK, and PCI_ERR_CAP.  Root and Root Complex Event
-	 * Collectors also implement PCI_ERR_ROOT_COMMAND (PCIe r5.0, sec
-	 * 7.8.4).
+	 * Collectors also implement PCI_ERR_ROOT_COMMAND (PCIe r6.0, sec
+	 * 7.8.4.9).
 	 */
 	n = pcie_cap_has_rtctl(dev) ? 5 : 4;
 	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, sizeof(u32) * n);
@@ -825,8 +825,8 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 	u16 reg16;
 
 	/*
-	 * When bus id is equal to 0, it might be a bad id
-	 * reported by root port.
+	 * When bus ID is equal to 0, it might be a bad ID
+	 * reported by Root Port.
 	 */
 	if ((PCI_BUS_NUM(e_info->id) != 0) &&
 	    !(dev->bus->bus_flags & PCI_BUS_FLAGS_NO_AERSID)) {
@@ -834,15 +834,15 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 		if (e_info->id == pci_dev_id(dev))
 			return true;
 
-		/* Continue id comparing if there is no multiple error */
+		/* Continue ID comparing if there is no multiple error */
 		if (!e_info->multi_error_valid)
 			return false;
 	}
 
 	/*
 	 * When either
-	 *      1) bus id is equal to 0. Some ports might lose the bus
-	 *              id of error source id;
+	 *      1) bus ID is equal to 0. Some ports might lose the bus
+	 *              ID of error source id;
 	 *      2) bus flag PCI_BUS_FLAGS_NO_AERSID is set
 	 *      3) There are multiple errors and prior ID comparing fails;
 	 * We check AER status registers to find possible reporter.
@@ -894,9 +894,9 @@ static int find_device_iter(struct pci_dev *dev, void *data)
 /**
  * find_source_device - search through device hierarchy for source device
  * @parent: pointer to Root Port pci_dev data structure
- * @e_info: including detailed error information such like id
+ * @e_info: including detailed error information such as ID
  *
- * Return true if found.
+ * Return: true if found.
  *
  * Invoked by DPC when error is detected at the Root Port.
  * Caller of this function must set id, severity, and multi_error_valid of
@@ -938,9 +938,9 @@ static bool find_source_device(struct pci_dev *parent,
 
 /**
  * pci_aer_unmask_internal_errors - unmask internal errors
- * @dev: pointer to the pcie_dev data structure
+ * @dev: pointer to the pci_dev data structure
  *
- * Unmasks internal errors in the Uncorrectable and Correctable Error
+ * Unmask internal errors in the Uncorrectable and Correctable Error
  * Mask registers.
  *
  * Note: AER must be enabled and supported by the device which must be
@@ -1003,7 +1003,7 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
 		return 0;
 
-	/* protect dev->driver */
+	/* Protect dev->driver */
 	device_lock(&dev->dev);
 
 	err_handler = dev->driver ? dev->driver->err_handler : NULL;
@@ -1195,10 +1195,10 @@ EXPORT_SYMBOL_GPL(aer_recover_queue);
 
 /**
  * aer_get_device_error_info - read error status from dev and store it to info
- * @dev: pointer to the device expected to have a error record
+ * @dev: pointer to the device expected to have an error record
  * @info: pointer to structure to store the error record
  *
- * Return 1 on success, 0 on error.
+ * Return: 1 on success, 0 on error.
  *
  * Note that @info is reused among all error devices. Clear fields properly.
  */
@@ -1256,7 +1256,7 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
 {
 	int i;
 
-	/* Report all before handle them, not to lost records by reset etc. */
+	/* Report all before handling them, to not lose records by reset etc. */
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
 		if (aer_get_device_error_info(e_info->dev[i], e_info))
 			aer_print_error(e_info->dev[i], e_info);
@@ -1268,8 +1268,8 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
 }
 
 /**
- * aer_isr_one_error - consume an error detected by root port
- * @rpc: pointer to the root port which holds an error
+ * aer_isr_one_error - consume an error detected by Root Port
+ * @rpc: pointer to the Root Port which holds an error
  * @e_src: pointer to an error source
  */
 static void aer_isr_one_error(struct aer_rpc *rpc,
@@ -1319,11 +1319,11 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 }
 
 /**
- * aer_isr - consume errors detected by root port
+ * aer_isr - consume errors detected by Root Port
  * @irq: IRQ assigned to Root Port
  * @context: pointer to Root Port data structure
  *
- * Invoked, as DPC, when root port records new detected error
+ * Invoked, as DPC, when Root Port records new detected error
  */
 static irqreturn_t aer_isr(int irq, void *context)
 {
@@ -1383,7 +1383,7 @@ static void aer_disable_irq(struct pci_dev *pdev)
 	int aer = pdev->aer_cap;
 	u32 reg32;
 
-	/* Disable Root's interrupt in response to error messages */
+	/* Disable Root Port's interrupt in response to error messages */
 	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
 	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
 	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
@@ -1583,9 +1583,9 @@ static struct pcie_port_service_driver aerdriver = {
 };
 
 /**
- * pcie_aer_init - register AER root service driver
+ * pcie_aer_init - register AER service driver
  *
- * Invoked when AER root service driver is loaded.
+ * Invoked when AER service driver is loaded.
  */
 int __init pcie_aer_init(void)
 {
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 5e00cecf1f1a..5b847f7b1f68 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1880,7 +1880,7 @@ static void remove_dev_resources(struct pci_dev *dev, struct resource *io,
 			 * Make sure prefetchable memory is reduced from
 			 * the correct resource. Specifically we put 32-bit
 			 * prefetchable memory in non-prefetchable window
-			 * if there is an 64-bit prefetchable window.
+			 * if there is a 64-bit prefetchable window.
 			 *
 			 * See comments in __pci_bus_size_bridges() for
 			 * more information.
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index ee6156bcbbd0..879d19cebd4f 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -38,7 +38,7 @@ enum pci_barno {
  * @baseclass_code: broadly classifies the type of function the device performs
  * @cache_line_size: specifies the system cacheline size in units of DWORDs
  * @subsys_vendor_id: vendor of the add-in card or subsystem
- * @subsys_id: id specific to vendor
+ * @subsys_id: ID specific to vendor
  * @interrupt_pin: interrupt pin the device (or device function) uses
  */
 struct pci_epf_header {
@@ -59,7 +59,7 @@ struct pci_epf_header {
  * @bind: ops to perform when a EPC device has been bound to EPF device
  * @unbind: ops to perform when a binding has been lost between a EPC device
  *	    and EPF device
- * @add_cfs: ops to initialize function specific configfs attributes
+ * @add_cfs: ops to initialize function-specific configfs attributes
  */
 struct pci_epf_ops {
 	int	(*bind)(struct pci_epf *epf);
@@ -138,7 +138,7 @@ struct pci_epf_bar {
  * @epc: the EPC device to which this EPF device is bound
  * @epf_pf: the physical EPF device to which this virtual EPF device is bound
  * @driver: the EPF driver to which this EPF device is bound
- * @id: Pointer to the EPF device ID
+ * @id: pointer to the EPF device ID
  * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
  * @lock: mutex to protect pci_epf_ops
  * @sec_epc: the secondary EPC device to which this EPF device is bound
@@ -151,7 +151,7 @@ struct pci_epf_bar {
  * @is_vf: true - virtual function, false - physical function
  * @vfunction_num_map: bitmap to manage virtual function number
  * @pci_vepf: list of virtual endpoint functions associated with this function
- * @event_ops: Callbacks for capturing the EPC events
+ * @event_ops: callbacks for capturing the EPC events
  */
 struct pci_epf {
 	struct device		dev;
@@ -185,11 +185,12 @@ struct pci_epf {
 };
 
 /**
- * struct pci_epf_msix_tbl - represents the MSIX table entry structure
- * @msg_addr: Writes to this address will trigger MSIX interrupt in host
- * @msg_data: Data that should be written to @msg_addr to trigger MSIX interrupt
+ * struct pci_epf_msix_tbl - represents the MSI-X table entry structure
+ * @msg_addr: Writes to this address will trigger MSI-X interrupt in host
+ * @msg_data: Data that should be written to @msg_addr to trigger MSI-X
+ *   interrupt
  * @vector_ctrl: Identifies if the function is prohibited from sending a message
- * using this MSIX table entry
+ *   using this MSI-X table entry
  */
 struct pci_epf_msix_tbl {
 	u64 msg_addr;
-- 
2.34.1


