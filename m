Return-Path: <linux-pci+bounces-12320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F8B961AD1
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 01:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881341C22D8D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 23:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89A41D54FC;
	Tue, 27 Aug 2024 23:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTJf1S65"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904251D54F9;
	Tue, 27 Aug 2024 23:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724802551; cv=none; b=P/7KXIHYE79aUQgUkx/dS6wVX17bbH6y5OSRJqCl+ovX3tuDy6iTAE72u1kYScN/mSyR9pB2bl2r0V2JRpLHqWsVjjGgGfPCHWKOgI+xS22ohC6qHO8QeFgIaz61I2zHatOBKcasZeJDMRD4YbBKIf6oWBAkiDCWH9eqokwh9Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724802551; c=relaxed/simple;
	bh=vVcim9QI3UmdrdEOzbyHrsdNihLYVffuaZS91Z5jGjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FcUgALtH8pOtUSgmhMp1ytZ1ak+NnMXMg+xq0geS8fT5WpP7+FkYn6r674I1sdLBx9DmmuIabRP04DP4Ufxytg9p4LLe2FIiJMoUZNS4rk7aiPMZzgeOpbtW4B0SoAkCopMLSOaN26wdRoNIziiMZELzBLNalfTadR4z/MU2NYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTJf1S65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDE3C4FEBD;
	Tue, 27 Aug 2024 23:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724802551;
	bh=vVcim9QI3UmdrdEOzbyHrsdNihLYVffuaZS91Z5jGjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MTJf1S65egLDU9i9iPCD26v2lQrELqb2agx5lKj7CwUDPMzN4hI18kyGwORukvFlc
	 5uj7DSoCKJdqCA6sn3/gJBjvY8+TCK6/T3cSqndJn9KszU5Mg8xDyuKRvF94xTkenh
	 g4LgW1cXTFTKiy0PqRybeDTFsX4EuwgMbVeT3hJZ/3SVhScw40Um8ayW/6hwfqxDKI
	 rpx7A1uBbZN2pFKjyQ6cICS+6Ukd+w+A6nankaoUzVfkyx0SavTdiQh+EvH0xV+h4x
	 oTVb2sJ6LY+wLv6o9vIWRhoaObp9xtDQfp3LAqcwUO78UZM0H+Up8ah/XLg8bvscVd
	 wFD0BYGQTT4mw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Duc Dang <ducdang@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 3/3] PCI: Rename CRS Completion Status to RRS
Date: Tue, 27 Aug 2024 18:48:48 -0500
Message-Id: <20240827234848.4429-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827234848.4429-1-helgaas@kernel.org>
References: <20240827234848.4429-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

PCIe r6.0 changed the abbreviation for "Configuration Request Retry Status"
Completion Status from "CRS" to "RRS" and uses the terminology of
"Configuration RRS Software Visibility" instead of "CRS Software
Visibility".

Align the Linux usage with the r6.0 spec language.  No functional change
intended.

It's confusing to make this change, but I think "RRS" *is* a better
abbreviation because it was easy to interpret "CRS" as "Completion Retry
Status", which really didn't make any sense.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/bcma/driver_pci_host.c             | 10 ++--
 drivers/pci/controller/dwc/pcie-tegra194.c | 18 +++---
 drivers/pci/controller/pci-aardvark.c      | 64 +++++++++++-----------
 drivers/pci/controller/pci-xgene.c         |  6 +-
 drivers/pci/controller/pcie-iproc.c        | 18 +++---
 drivers/pci/pci-bridge-emul.c              |  4 +-
 drivers/pci/pci.c                          |  4 +-
 drivers/pci/pci.h                          |  8 +--
 drivers/pci/probe.c                        | 28 +++++-----
 include/linux/bcma/bcma_driver_pci.h       |  2 +-
 include/linux/pci.h                        |  2 +-
 include/uapi/linux/pci_regs.h              |  6 +-
 12 files changed, 86 insertions(+), 84 deletions(-)

diff --git a/drivers/bcma/driver_pci_host.c b/drivers/bcma/driver_pci_host.c
index ed3be52ab63d..8540052d37c5 100644
--- a/drivers/bcma/driver_pci_host.c
+++ b/drivers/bcma/driver_pci_host.c
@@ -334,7 +334,7 @@ static u8 bcma_find_pci_capability(struct bcma_drv_pci *pc, unsigned int dev,
 }
 
 /* If the root port is capable of returning Config Request
- * Retry Status (CRS) Completion Status to software then
+ * Retry Status (RRS) Completion Status to software then
  * enable the feature.
  */
 static void bcma_core_pci_enable_crs(struct bcma_drv_pci *pc)
@@ -348,10 +348,10 @@ static void bcma_core_pci_enable_crs(struct bcma_drv_pci *pc)
 					   NULL);
 	root_cap = cap_ptr + PCI_EXP_RTCAP;
 	bcma_extpci_read_config(pc, 0, 0, root_cap, &val16, sizeof(u16));
-	if (val16 & BCMA_CORE_PCI_RC_CRS_VISIBILITY) {
-		/* Enable CRS software visibility */
+	if (val16 & BCMA_CORE_PCI_RC_RRS_VISIBILITY) {
+		/* Enable Configuration RRS Software Visibility */
 		root_ctrl = cap_ptr + PCI_EXP_RTCTL;
-		val16 = PCI_EXP_RTCTL_CRSSVE;
+		val16 = PCI_EXP_RTCTL_RRS_SVE;
 		bcma_extpci_read_config(pc, 0, 0, root_ctrl, &val16,
 					sizeof(u16));
 
@@ -360,7 +360,7 @@ static void bcma_core_pci_enable_crs(struct bcma_drv_pci *pc)
 		 * 100 ms wait time from the end of Reset. If the device is
 		 * not done with its internal initialization, it must at
 		 * least return a completion TLP, with a completion status
-		 * of "Configuration Request Retry Status (CRS)". The root
+		 * of "Configuration Request Retry Status (RRS)". The root
 		 * complex must complete the request to the host by returning
 		 * a read-data value of 0001h for the Vendor ID field and
 		 * all 1s for any additional bytes included in the request.
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 4bf7b433417a..886354342ef1 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -183,11 +183,11 @@
 #define GEN3_EQ_CONTROL_OFF_FB_MODE_MASK	GENMASK(3, 0)
 
 #define PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT	0x8D0
-#define AMBA_ERROR_RESPONSE_CRS_SHIFT		3
-#define AMBA_ERROR_RESPONSE_CRS_MASK		GENMASK(1, 0)
-#define AMBA_ERROR_RESPONSE_CRS_OKAY		0
-#define AMBA_ERROR_RESPONSE_CRS_OKAY_FFFFFFFF	1
-#define AMBA_ERROR_RESPONSE_CRS_OKAY_FFFF0001	2
+#define AMBA_ERROR_RESPONSE_RRS_SHIFT		3
+#define AMBA_ERROR_RESPONSE_RRS_MASK		GENMASK(1, 0)
+#define AMBA_ERROR_RESPONSE_RRS_OKAY		0
+#define AMBA_ERROR_RESPONSE_RRS_OKAY_FFFFFFFF	1
+#define AMBA_ERROR_RESPONSE_RRS_OKAY_FFFF0001	2
 
 #define MSIX_ADDR_MATCH_LOW_OFF			0x940
 #define MSIX_ADDR_MATCH_LOW_OFF_EN		BIT(0)
@@ -907,11 +907,11 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
 
-	/* Enable as 0xFFFF0001 response for CRS */
+	/* Enable as 0xFFFF0001 response for RRS */
 	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT);
-	val &= ~(AMBA_ERROR_RESPONSE_CRS_MASK << AMBA_ERROR_RESPONSE_CRS_SHIFT);
-	val |= (AMBA_ERROR_RESPONSE_CRS_OKAY_FFFF0001 <<
-		AMBA_ERROR_RESPONSE_CRS_SHIFT);
+	val &= ~(AMBA_ERROR_RESPONSE_RRS_MASK << AMBA_ERROR_RESPONSE_RRS_SHIFT);
+	val |= (AMBA_ERROR_RESPONSE_RRS_OKAY_FFFF0001 <<
+		AMBA_ERROR_RESPONSE_RRS_SHIFT);
 	dw_pcie_writel_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT, val);
 
 	/* Clear Slot Clock Configuration bit if SRNS configuration */
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index e66594558ce2..afccae3bfbc6 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -50,7 +50,7 @@
 #define   PIO_COMPLETION_STATUS_MASK		GENMASK(9, 7)
 #define   PIO_COMPLETION_STATUS_OK		0
 #define   PIO_COMPLETION_STATUS_UR		1
-#define   PIO_COMPLETION_STATUS_CRS		2
+#define   PIO_COMPLETION_STATUS_RRS		2
 #define   PIO_COMPLETION_STATUS_CA		4
 #define   PIO_NON_POSTED_REQ			BIT(10)
 #define   PIO_ERR_STATUS			BIT(11)
@@ -262,7 +262,7 @@ enum {
 
 #define MSI_IRQ_NUM			32
 
-#define CFG_RD_CRS_VAL			0xffff0001
+#define CFG_RD_RRS_VAL			0xffff0001
 
 struct advk_pcie {
 	struct platform_device *pdev;
@@ -649,7 +649,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	advk_pcie_train_link(pcie);
 }
 
-static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u32 *val)
+static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_rrs, u32 *val)
 {
 	struct device *dev = &pcie->pdev->dev;
 	u32 reg;
@@ -669,7 +669,7 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
 	 * 2) value Unsupported Request(1) of COMPLETION_STATUS(bit9:7) only
 	 *    means a PIO write error, and for PIO read it is successful with
 	 *    a read value of 0xFFFFFFFF.
-	 * 3) value Completion Retry Status(CRS) of COMPLETION_STATUS(bit9:7)
+	 * 3) value Config Request Retry Status(RRS) of COMPLETION_STATUS(bit9:7)
 	 *    only means a PIO write error, and for PIO read it is successful
 	 *    with a read value of 0xFFFF0001.
 	 * 4) value Completer Abort (CA) of COMPLETION_STATUS(bit9:7) means
@@ -694,10 +694,10 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
 		strcomp_status = "UR";
 		ret = -EOPNOTSUPP;
 		break;
-	case PIO_COMPLETION_STATUS_CRS:
-		if (allow_crs && val) {
-			/* PCIe r4.0, sec 2.3.2, says:
-			 * If CRS Software Visibility is enabled:
+	case PIO_COMPLETION_STATUS_RRS:
+		if (allow_rrs && val) {
+			/* PCIe r6.0, sec 2.3.2, says:
+			 * If Configuration RRS Software Visibility is enabled:
 			 * For a Configuration Read Request that includes both
 			 * bytes of the Vendor ID field of a device Function's
 			 * Configuration Space Header, the Root Complex must
@@ -706,22 +706,22 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
 			 * all '1's for any additional bytes included in the
 			 * request.
 			 *
-			 * So CRS in this case is not an error status.
+			 * So RRS in this case is not an error status.
 			 */
-			*val = CFG_RD_CRS_VAL;
+			*val = CFG_RD_RRS_VAL;
 			strcomp_status = NULL;
 			ret = 0;
 			break;
 		}
-		/* PCIe r4.0, sec 2.3.2, says:
-		 * If CRS Software Visibility is not enabled, the Root Complex
+		/* PCIe r6.0, sec 2.3.2, says:
+		 * If RRS Software Visibility is not enabled, the Root Complex
 		 * must re-issue the Configuration Request as a new Request.
-		 * If CRS Software Visibility is enabled: For a Configuration
+		 * If RRS Software Visibility is enabled: For a Configuration
 		 * Write Request or for any other Configuration Read Request,
 		 * the Root Complex must re-issue the Configuration Request as
 		 * a new Request.
 		 * A Root Complex implementation may choose to limit the number
-		 * of Configuration Request/CRS Completion Status loops before
+		 * of Configuration Request/RRS Completion Status loops before
 		 * determining that something is wrong with the target of the
 		 * Request and taking appropriate action, e.g., complete the
 		 * Request to the host as a failed transaction.
@@ -729,7 +729,7 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
 		 * So return -EAGAIN and caller (pci-aardvark.c driver) will
 		 * re-issue request again up to the PIO_RETRY_CNT retries.
 		 */
-		strcomp_status = "CRS";
+		strcomp_status = "RRS";
 		ret = -EAGAIN;
 		break;
 	case PIO_COMPLETION_STATUS_CA:
@@ -920,8 +920,8 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 
 	case PCI_EXP_RTCTL: {
 		u16 rootctl = le16_to_cpu(bridge->pcie_conf.rootctl);
-		/* Only emulation of PMEIE and CRSSVE bits is provided */
-		rootctl &= PCI_EXP_RTCTL_PMEIE | PCI_EXP_RTCTL_CRSSVE;
+		/* Only emulation of PMEIE and RRS_SVE bits is provided */
+		rootctl &= PCI_EXP_RTCTL_PMEIE | PCI_EXP_RTCTL_RRS_SVE;
 		bridge->pcie_conf.rootctl = cpu_to_le16(rootctl);
 		break;
 	}
@@ -1075,7 +1075,7 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 	bridge->pcie_conf.slotsta = cpu_to_le16(PCI_EXP_SLTSTA_PDS);
 
 	/* Indicates supports for Completion Retry Status */
-	bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_CRSVIS);
+	bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_RRS_SV);
 
 	bridge->subsystem_vendor_id = advk_readl(pcie, PCIE_CORE_SSDEV_ID_REG) & 0xffff;
 	bridge->subsystem_id = advk_readl(pcie, PCIE_CORE_SSDEV_ID_REG) >> 16;
@@ -1141,7 +1141,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 {
 	struct advk_pcie *pcie = bus->sysdata;
 	int retry_count;
-	bool allow_crs;
+	bool allow_rrs;
 	u32 reg;
 	int ret;
 
@@ -1153,16 +1153,16 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 						 size, val);
 
 	/*
-	 * Completion Retry Status is possible to return only when reading
-	 * both bytes from PCI_VENDOR_ID at once and CRSSVE flag on Root
-	 * Port is enabled.
+	 * Configuration Request Retry Status (RRS) is possible to return
+	 * only when reading both bytes from PCI_VENDOR_ID at once and
+	 * RRS_SVE flag on Root Port is enabled.
 	 */
-	allow_crs = (where == PCI_VENDOR_ID) && (size >= 2) &&
+	allow_rrs = (where == PCI_VENDOR_ID) && (size >= 2) &&
 		    (le16_to_cpu(pcie->bridge.pcie_conf.rootctl) &
-		     PCI_EXP_RTCTL_CRSSVE);
+		     PCI_EXP_RTCTL_RRS_SVE);
 
 	if (advk_pcie_pio_is_running(pcie))
-		goto try_crs;
+		goto try_rrs;
 
 	/* Program the control register */
 	reg = advk_readl(pcie, PIO_CTRL);
@@ -1189,12 +1189,12 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 
 		ret = advk_pcie_wait_pio(pcie);
 		if (ret < 0)
-			goto try_crs;
+			goto try_rrs;
 
 		retry_count += ret;
 
 		/* Check PIO status and get the read result */
-		ret = advk_pcie_check_pio_status(pcie, allow_crs, val);
+		ret = advk_pcie_check_pio_status(pcie, allow_rrs, val);
 	} while (ret == -EAGAIN && retry_count < PIO_RETRY_CNT);
 
 	if (ret < 0)
@@ -1207,13 +1207,13 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 
 	return PCIBIOS_SUCCESSFUL;
 
-try_crs:
+try_rrs:
 	/*
-	 * If it is possible, return Completion Retry Status so that caller
-	 * tries to issue the request again instead of failing.
+	 * If it is possible, return Configuration Request Retry Status so
+	 * that caller tries to issue the request again instead of failing.
 	 */
-	if (allow_crs) {
-		*val = CFG_RD_CRS_VAL;
+	if (allow_rrs) {
+		*val = CFG_RD_RRS_VAL;
 		return PCIBIOS_SUCCESSFUL;
 	}
 
diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index 8e457fa450a2..1e2ebbfa36d1 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -171,17 +171,17 @@ static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 
 	/*
 	 * The v1 controller has a bug in its Configuration Request Retry
-	 * Status (CRS) logic: when CRS Software Visibility is enabled and
+	 * Status (RRS) logic: when RRS Software Visibility is enabled and
 	 * we read the Vendor and Device ID of a non-existent device, the
 	 * controller fabricates return data of 0xFFFF0001 ("device exists
 	 * but is not ready") instead of 0xFFFFFFFF (PCI_ERROR_RESPONSE)
 	 * ("device does not exist").  This causes the PCI core to retry
 	 * the read until it times out.  Avoid this by not claiming to
-	 * support CRS SV.
+	 * support RRS SV.
 	 */
 	if (pci_is_root_bus(bus) && (port->version == XGENE_PCIE_IP_VER_1) &&
 	    ((where & ~0x3) == XGENE_V1_PCI_EXP_CAP + PCI_EXP_RTCTL))
-		*val &= ~(PCI_EXP_RTCAP_CRSVIS << 16);
+		*val &= ~(PCI_EXP_RTCAP_RRS_SV << 16);
 
 	if (size <= 2)
 		*val = (*val >> (8 * (where & 3))) & ((1 << (size * 8)) - 1);
diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 97f739a2c9f8..22134e95574b 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -54,7 +54,7 @@
 
 #define CFG_RD_SUCCESS			0
 #define CFG_RD_UR			1
-#define CFG_RD_CRS			2
+#define CFG_RD_RRS			2
 #define CFG_RD_CA			3
 #define CFG_RETRY_STATUS		0xffff0001
 #define CFG_RETRY_STATUS_TIMEOUT_US	500000 /* 500 milliseconds */
@@ -485,31 +485,31 @@ static unsigned int iproc_pcie_cfg_retry(struct iproc_pcie *pcie,
 	u32 status;
 
 	/*
-	 * As per PCIe spec r3.1, sec 2.3.2, CRS Software Visibility only
+	 * As per PCIe r6.0, sec 2.3.2, Config RRS Software Visibility only
 	 * affects config reads of the Vendor ID.  For config writes or any
 	 * other config reads, the Root may automatically reissue the
 	 * configuration request again as a new request.
 	 *
 	 * For config reads, this hardware returns CFG_RETRY_STATUS data
-	 * when it receives a CRS completion, regardless of the address of
-	 * the read or the CRS Software Visibility Enable bit.  As a
+	 * when it receives a RRS completion, regardless of the address of
+	 * the read or the RRS Software Visibility Enable bit.  As a
 	 * partial workaround for this, we retry in software any read that
 	 * returns CFG_RETRY_STATUS.
 	 *
 	 * Note that a non-Vendor ID config register may have a value of
 	 * CFG_RETRY_STATUS.  If we read that, we can't distinguish it from
-	 * a CRS completion, so we will incorrectly retry the read and
+	 * a RRS completion, so we will incorrectly retry the read and
 	 * eventually return the wrong data (0xffffffff).
 	 */
 	data = readl(cfg_data_p);
 	while (data == CFG_RETRY_STATUS && timeout--) {
 		/*
-		 * CRS state is set in CFG_RD status register
+		 * RRS state is set in CFG_RD status register
 		 * This will handle the case where CFG_RETRY_STATUS is
 		 * valid config data.
 		 */
 		status = iproc_pcie_read_reg(pcie, IPROC_PCIE_CFG_RD_STATUS);
-		if (status != CFG_RD_CRS)
+		if (status != CFG_RD_RRS)
 			return data;
 
 		udelay(1);
@@ -556,8 +556,8 @@ static void iproc_pcie_fix_cap(struct iproc_pcie *pcie, int where, u32 *val)
 		break;
 
 	case IPROC_PCI_EXP_CAP + PCI_EXP_RTCTL:
-		/* Don't advertise CRS SV support */
-		*val &= ~(PCI_EXP_RTCAP_CRSVIS << 16);
+		/* Don't advertise RRS SV support */
+		*val &= ~(PCI_EXP_RTCAP_RRS_SV << 16);
 		break;
 
 	default:
diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 9334b2dd4764..6658c1edd464 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -257,8 +257,8 @@ struct pci_bridge_reg_behavior pcie_cap_regs_behavior[PCI_CAP_PCIE_SIZEOF / 4] =
 		 */
 		.rw = (PCI_EXP_RTCTL_SECEE | PCI_EXP_RTCTL_SENFEE |
 		       PCI_EXP_RTCTL_SEFEE | PCI_EXP_RTCTL_PMEIE |
-		       PCI_EXP_RTCTL_CRSSVE),
-		.ro = PCI_EXP_RTCAP_CRSVIS << 16,
+		       PCI_EXP_RTCTL_RRS_SVE),
+		.ro = PCI_EXP_RTCAP_RRS_SV << 16,
 	},
 
 	[PCI_EXP_RTSTA / 4] = {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fc2ecb7fe081..55d6124acb2d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1320,9 +1320,9 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 			return -ENOTTY;
 		}
 
-		if (root && root->config_crs_sv) {
+		if (root && root->config_rrs_sv) {
 			pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
-			if (!pci_bus_crs_vendor_id(id))
+			if (!pci_bus_rrs_vendor_id(id))
 				break;
 		} else {
 			pci_read_config_dword(dev, PCI_COMMAND, &id);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fa1997bc2667..061cc1b48fd8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -139,7 +139,7 @@ bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
 int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
 
-static inline bool pci_bus_crs_vendor_id(u32 l)
+static inline bool pci_bus_rrs_vendor_id(u32 l)
 {
 	return (l & 0xffff) == PCI_VENDOR_ID_PCI_SIG;
 }
@@ -295,10 +295,10 @@ void pci_put_host_bridge_device(struct device *dev);
 
 int pci_configure_extended_tags(struct pci_dev *dev, void *ign);
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
-				int crs_timeout);
+				int rrs_timeout);
 bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
-					int crs_timeout);
-int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *pl, int crs_timeout);
+					int rrs_timeout);
+int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *pl, int rrs_timeout);
 
 int pci_setup_device(struct pci_dev *dev);
 int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b1615da9eb6b..e79d9bea32bf 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1203,16 +1203,16 @@ struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev,
 }
 EXPORT_SYMBOL(pci_add_new_bus);
 
-static void pci_enable_crs(struct pci_dev *pdev)
+static void pci_enable_rrs_sv(struct pci_dev *pdev)
 {
 	u16 root_cap = 0;
 
-	/* Enable CRS Software Visibility if supported */
+	/* Enable Configuration RRS Software Visibility if supported */
 	pcie_capability_read_word(pdev, PCI_EXP_RTCAP, &root_cap);
-	if (root_cap & PCI_EXP_RTCAP_CRSVIS) {
+	if (root_cap & PCI_EXP_RTCAP_RRS_SV) {
 		pcie_capability_set_word(pdev, PCI_EXP_RTCTL,
-					 PCI_EXP_RTCTL_CRSSVE);
-		pdev->config_crs_sv = 1;
+					 PCI_EXP_RTCTL_RRS_SVE);
+		pdev->config_rrs_sv = 1;
 	}
 }
 
@@ -1328,7 +1328,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
 			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
 
-	pci_enable_crs(dev);
+	pci_enable_rrs_sv(dev);
 
 	if ((secondary || subordinate) && !pcibios_assign_all_busses() &&
 	    !is_cardbus && !broken) {
@@ -2345,23 +2345,23 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_alloc_dev);
 
-static bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l,
+static bool pci_bus_wait_rrs(struct pci_bus *bus, int devfn, u32 *l,
 			     int timeout)
 {
 	int delay = 1;
 
-	if (!pci_bus_crs_vendor_id(*l))
-		return true;	/* not a CRS completion */
+	if (!pci_bus_rrs_vendor_id(*l))
+		return true;	/* not a Configuration RRS completion */
 
 	if (!timeout)
-		return false;	/* CRS, but caller doesn't want to wait */
+		return false;	/* RRS, but caller doesn't want to wait */
 
 	/*
 	 * We got the reserved Vendor ID that indicates a completion with
-	 * Configuration Request Retry Status (CRS).  Retry until we get a
+	 * Configuration Request Retry Status (RRS).  Retry until we get a
 	 * valid Vendor ID or we time out.
 	 */
-	while (pci_bus_crs_vendor_id(*l)) {
+	while (pci_bus_rrs_vendor_id(*l)) {
 		if (delay > timeout) {
 			pr_warn("pci %04x:%02x:%02x.%d: not ready after %dms; giving up\n",
 				pci_domain_nr(bus), bus->number,
@@ -2400,8 +2400,8 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 	    *l == 0x0000ffff || *l == 0xffff0000)
 		return false;
 
-	if (pci_bus_crs_vendor_id(*l))
-		return pci_bus_wait_crs(bus, devfn, l, timeout);
+	if (pci_bus_rrs_vendor_id(*l))
+		return pci_bus_wait_rrs(bus, devfn, l, timeout);
 
 	return true;
 }
diff --git a/include/linux/bcma/bcma_driver_pci.h b/include/linux/bcma/bcma_driver_pci.h
index 68da8dba5162..dba41b65ae0d 100644
--- a/include/linux/bcma/bcma_driver_pci.h
+++ b/include/linux/bcma/bcma_driver_pci.h
@@ -203,7 +203,7 @@ struct pci_dev;
 #define BCMA_CORE_PCI_MDIO_RXCTRL0		0x840
 
 /* PCIE Root Capability Register bits (Host mode only) */
-#define BCMA_CORE_PCI_RC_CRS_VISIBILITY		0x0001
+#define BCMA_CORE_PCI_RC_RRS_VISIBILITY		0x0001
 
 struct bcma_drv_pci;
 struct bcma_bus;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 121d8d94d6d0..27d8ce977674 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -371,7 +371,7 @@ struct pci_dev {
 					   can be generated */
 	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
 	unsigned int	pinned:1;	/* Whether this dev is pinned */
-	unsigned int	config_crs_sv:1; /* Config CRS software visibility */
+	unsigned int	config_rrs_sv:1; /* Config RRS software visibility */
 	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
 	unsigned int	d1_support:1;	/* Low power state D1 is supported */
 	unsigned int	d2_support:1;	/* Low power state D2 is supported */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 94c00996e633..f94591f9f5e9 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -634,9 +634,11 @@
 #define  PCI_EXP_RTCTL_SENFEE	0x0002	/* System Error on Non-Fatal Error */
 #define  PCI_EXP_RTCTL_SEFEE	0x0004	/* System Error on Fatal Error */
 #define  PCI_EXP_RTCTL_PMEIE	0x0008	/* PME Interrupt Enable */
-#define  PCI_EXP_RTCTL_CRSSVE	0x0010	/* CRS Software Visibility Enable */
+#define  PCI_EXP_RTCTL_RRS_SVE	0x0010	/* Config RRS Software Visibility Enable */
+#define  PCI_EXP_RTCTL_CRSSVE PCI_EXP_RTCTL_RRS_SVE /* compatibility */
 #define PCI_EXP_RTCAP		0x1e	/* Root Capabilities */
-#define  PCI_EXP_RTCAP_CRSVIS	0x0001	/* CRS Software Visibility capability */
+#define  PCI_EXP_RTCAP_RRS_SV	0x0001	/* Config RRS Software Visibility */
+#define  PCI_EXP_RTCAP_CRSVIS PCI_EXP_RTCAP_RRS_SV /* compatibility */
 #define PCI_EXP_RTSTA		0x20	/* Root Status */
 #define  PCI_EXP_RTSTA_PME_RQ_ID 0x0000ffff /* PME Requester ID */
 #define  PCI_EXP_RTSTA_PME	0x00010000 /* PME status */
-- 
2.34.1


