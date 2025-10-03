Return-Path: <linux-pci+bounces-37521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAB6BB64A8
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 11:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7831AE057D
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 09:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F0027A90A;
	Fri,  3 Oct 2025 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="bOs8sylV"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627AE1F152D;
	Fri,  3 Oct 2025 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482167; cv=none; b=NKIH52OkDCa1wR63xrzI3vTOc4mX7ovvar6f8pNCHMDUryIOkxAJwjMVPpLj7DpNDD4gCnaGIQOEHBFQ1Doz9Gn/GCP5JpGhBrjjd+BxDSlZjv9pAXDYsmCH5C4CiOiDvZaNE2MI3zP2hW29L+VofRENabg0UCyGMszIQodVCKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482167; c=relaxed/simple;
	bh=Max++AZI+AOKCWikh2iqiErydfn28u9IoTGALpu4yF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfLsygKm5pZ/PwOuPAr5yv5LVdqY9Myd/8Uhs3hVCgptsCZklpidJ/FTF+8FkBq4IPL3qcxLrKe5N+YwEGOMq9tfej7W3iWAEa+HnHYGl18XWTfZHuhYDqWAKyFjm2O0P82zwwgZnNDH0n1ujVE+EgLJSZ2BH65/RJh8UL4pEHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=bOs8sylV; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759482165; x=1791018165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PU9V5eyawqU6rD2TMqdBmytt8K7XbHIr3fHrXPcNoJw=;
  b=bOs8sylV6E8K1hhjsfUR9p0BN3mj9W0qeO9y/RaWq4d5RDpF7qbDzgaq
   kz7R8PSAVVjfz7jbJwNUceEPZuWkiSCW2boT6Rt0ur0yCjPvqt8Y1YWT7
   gXum4wTliiUJY4NIICKFMHVi12HkbiZo0V0PQmCewiks/Th5fnaIn0adC
   lQJbRPPa3tVz4xdvIyP26ml0WaG/zMIgC3E0U2MbMZaMb+g80WO4B0CKb
   WlGEZY0yo7q4NaJ3mhwsOPNBTfavs0AxgBf7qeo7dIhCKk3PC8yJ6uzkS
   ZzD62oEezxsakzEdos8V306ADaCu/pUHYuVwRo0VUHaZEV5hPOzePHufd
   g==;
X-CSE-ConnectionGUID: UCwe02XYRFWunXRMcOXPQg==
X-CSE-MsgGUID: h98Tq2JmTK+Qf1ga/GJ0Ew==
X-IronPort-AV: E=Sophos;i="6.18,312,1751241600"; 
   d="scan'208";a="4010804"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 09:02:43 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:22597]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.3:2525] with esmtp (Farcaster)
 id a8ad3ff0-c92b-41f7-bba0-e44bb9829389; Fri, 3 Oct 2025 09:02:43 +0000 (UTC)
X-Farcaster-Flow-ID: a8ad3ff0-c92b-41f7-bba0-e44bb9829389
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 3 Oct 2025 09:02:42 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 3 Oct 2025
 09:02:39 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson
	<alex.williamson@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, "Vipin
 Sharma" <vipinsh@google.com>, Chris Li <chrisl@kernel.org>, Jason Miu
	<jasonmiu@google.com>, Pratyush Yadav <pratyush@kernel.org>, "Stanislav
 Spassov" <stanspas@amazon.de>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>
Subject: [RFC PATCH 03/13] pci: pcsc: infer cacheability of PCI capabilities
Date: Fri, 3 Oct 2025 09:00:39 +0000
Message-ID: <fb2f262e4733a56bf0ebd9ef5c9325880aea05cd.1759312886.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759312886.git.epetron@amazon.de>
References: <cover.1759312886.git.epetron@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Implement cacheability inference for PCI capabilities to
determine which configuration space registers can be safely cached.

The first 64 bytes of PCI configuration space follow a standardized
format, allowing straightforward cacheability determination. For
capability-specific registers, the implementation traverses the PCI
capability list to identify supported capabilities.

Cacheable registers are identified for the following capabilities:
- Power Management (PM)
- Message Signaled Interrupts (MSI)
- Message Signaled Interrupts Extensions (MSI-X)
- PCI Express
- PCI Advanced Features (AF)
- Enhanced Allocation (EA)
- Vital Product Data (VPD)
- Vendor Specific

The implementation pre-populates the cache with known values including
device/vendor IDs and header type to avoid unnecessary configuration
space reads during initialization.

We are currently not caching the Command/Status registers.

The cacheability of all capabilities apart from MSI, are straightforward
and can be deduced from the spec. Regarding MSI the MSI flags are read
and based on this, the cacheability is inferred.

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 drivers/pci/pcsc.c | 261 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 261 insertions(+)

diff --git a/drivers/pci/pcsc.c b/drivers/pci/pcsc.c
index 7531217925e8..29945eac4190 100644
--- a/drivers/pci/pcsc.c
+++ b/drivers/pci/pcsc.c
@@ -175,6 +175,266 @@ static int pcsc_update_byte(struct pci_dev *dev, int where, u8 val)
 	return 0;
 }
 
+static const u8 PCSC_SUPPORTED_CAPABILITIES[] = {
+	PCI_CAP_ID_PM,	 PCI_CAP_ID_VPD, PCI_CAP_ID_MSI, PCI_CAP_ID_VNDR,
+	PCI_CAP_ID_MSIX, PCI_CAP_ID_EXP, PCI_CAP_ID_AF,	 PCI_CAP_ID_EA
+};
+
+/**
+ * pcsc_handle_msi_cacheability - Set cacheability for MSI capability registers
+ * @dev: PCI device
+ * @cap_pos: Capability position in config space
+ *
+ * The MSI capability has four different shapes (12-24 bytes) depending on:
+ * - 64-bit addressing capability (PCI_MSI_FLAGS_64BIT)
+ * - Per-vector masking capability (PCI_MSI_FLAGS_MASKBIT)
+ *
+ * Cacheable registers:
+ * - PCI_MSI_FLAGS: Control register
+ * - PCI_MSI_ADDRESS_LO: Lower 32 bits of message address
+ * - PCI_MSI_ADDRESS_HI: Upper 32 bits (if 64-bit capable)
+ * - PCI_MSI_DATA_32/64: Message data register
+ * - PCI_MSI_MASK_32/64: Mask bits register (if masking capable)
+ *
+ * Non-cacheable registers:
+ * - PCI_MSI_PENDING_32/64: Pending bits (modified by device)
+ */
+static void pcsc_handle_msi_cacheability(struct pci_dev *dev, int cap_pos)
+{
+	u32 val;
+	u16 msi_flags;
+	bool is_64bit_capable;
+	bool is_mask_capable;
+	int data_offset;
+	int mask_offset;
+
+	if (WARN_ON(!dev || !dev->pcsc || !dev->pcsc->cfg_space))
+		return;
+
+	/* Read MSI flags to determine capability shape */
+	if (pcsc_hw_config_read(dev->bus, dev->devfn, cap_pos + PCI_MSI_FLAGS,
+				2, &val) != PCIBIOS_SUCCESSFUL) {
+		pci_warn(dev, "PCSC: Failed to read MSI flags at %#x\n",
+			 cap_pos + PCI_MSI_FLAGS);
+		return;
+	}
+
+	msi_flags = val & 0xFFFF;
+	pcsc_update_byte(dev, cap_pos + PCI_MSI_FLAGS, msi_flags & 0xFF);
+	pcsc_update_byte(dev, cap_pos + PCI_MSI_FLAGS + 1, (msi_flags >> 8) & 0xFF);
+
+	/* Mark MSI flags as cacheable */
+	bitmap_set(dev->pcsc->cachable_bitmask, cap_pos + PCI_MSI_FLAGS, 2);
+	is_64bit_capable = !!(msi_flags & PCI_MSI_FLAGS_64BIT);
+	is_mask_capable = !!(msi_flags & PCI_MSI_FLAGS_MASKBIT);
+
+	bitmap_set(dev->pcsc->cachable_bitmask, cap_pos + PCI_MSI_ADDRESS_LO,
+		   4);
+
+	if (is_64bit_capable) {
+		/* PCI_MSI_ADDRESS_HI is cacheable for 64-bit capable devices */
+		bitmap_set(dev->pcsc->cachable_bitmask,
+			   cap_pos + PCI_MSI_ADDRESS_HI, 4);
+
+		data_offset = PCI_MSI_DATA_64;
+		mask_offset = PCI_MSI_MASK_64;
+	} else {
+		/* Message Data register is at different offset for 32-bit */
+		data_offset = PCI_MSI_DATA_32;
+		mask_offset = PCI_MSI_MASK_32;
+	}
+
+	/*
+	 * Message Data register is always cacheable
+	 * Note: PCI spec defines Extended Message Data Capable (bit 9, 0x0200)
+	 * which allows 4-byte message data instead of 2-byte. However, Linux
+	 * doesn't currently define or use this capability, so we conservatively
+	 * mark only 2 bytes as cacheable for compatibility.
+	 */
+	bitmap_set(dev->pcsc->cachable_bitmask, cap_pos + data_offset, 2);
+
+	if (is_mask_capable) {
+		/* Mask bits register is cacheable if masking is supported */
+		bitmap_set(dev->pcsc->cachable_bitmask, cap_pos + mask_offset,
+			   4);
+	}
+}
+
+static void infer_capability_cacheability(struct pci_dev *dev, int cap_pos,
+					  u8 cap_id)
+{
+	if (WARN_ON(!dev || !dev->pcsc || !dev->pcsc->cfg_space))
+		return;
+
+	switch (cap_id) {
+	case PCI_CAP_ID_PM:
+		/* Power Management Capability */
+		bitmap_set(dev->pcsc->cachable_bitmask, cap_pos + PCI_PM_PMC,
+			   2); /* PCI_PM_PMC */
+		break;
+	case PCI_CAP_ID_MSI:
+		/* Message Signaled Interrupts */
+		pcsc_handle_msi_cacheability(dev, cap_pos);
+		break;
+	case PCI_CAP_ID_VNDR:
+		/* Vendor Specific */
+		bitmap_set(dev->pcsc->cachable_bitmask, cap_pos + PCI_CAP_FLAGS,
+			   1);
+		/* Only the flag can be cached as the body is opaque */
+		break;
+	case PCI_CAP_ID_MSIX:
+		/* MSI-X - the entire capability is cacheable */
+		bitmap_set(dev->pcsc->cachable_bitmask,
+			   cap_pos + PCI_MSIX_FLAGS, 10);
+		break;
+	case PCI_CAP_ID_EXP:
+		/* PCI Express capability - All except Status registers */
+		bitmap_set(
+			dev->pcsc->cachable_bitmask, cap_pos + PCI_EXP_FLAGS,
+			8); /* PCI_EXP_FLAGS, PCI_EXP_DEVCAP, PCI_EXP_DEVCTL */
+		bitmap_set(dev->pcsc->cachable_bitmask,
+			   cap_pos + PCI_EXP_LNKCAP,
+			   6); /* PCI_EXP_LNKCAP, PCI_EXP_LNKCTL */
+		bitmap_set(dev->pcsc->cachable_bitmask,
+			   cap_pos + PCI_EXP_SLTCAP,
+			   6); /* PCI_EXP_SLTCAP, PCI_EXP_SLTCTL */
+		bitmap_set(dev->pcsc->cachable_bitmask, cap_pos + PCI_EXP_RTCTL,
+			   4); /* PCI_EXP_RTCTL, PCI_EXP_RTCAP */
+		bitmap_set(dev->pcsc->cachable_bitmask,
+			   cap_pos + PCI_EXP_DEVCAP2,
+			   6); /* PCI_EXP_DEVCAP2, PCI_EXP_DEVCTL2 */
+		bitmap_set(dev->pcsc->cachable_bitmask,
+			   cap_pos + PCI_EXP_LNKCAP2,
+			   6); /* PCI_EXP_LNKCAP2, PCI_EXP_LNKCTL2 */
+		bitmap_set(dev->pcsc->cachable_bitmask,
+			   cap_pos + PCI_EXP_SLTCAP2,
+			   6); /* PCI_EXP_SLTCAP2, PCI_EXP_SLTCTL2 */
+		break;
+	case PCI_CAP_ID_AF:
+		/* PCI Advanced Features */
+		bitmap_set(dev->pcsc->cachable_bitmask, cap_pos + PCI_AF_LENGTH,
+			   2); /* PCI_AF_LENGTH, PCI_AF_CAP */
+		break;
+	case PCI_CAP_ID_EA:
+		/* Enhanced Allocation Theoretically the entire capability could
+		 * be cached, but it is not trivial to deduce its size.
+		 */
+		bitmap_set(dev->pcsc->cachable_bitmask,
+			   cap_pos + PCI_EA_NUM_ENT, 2);
+		break;
+	case PCI_CAP_ID_VPD:
+		/* Vital Product Data */
+		bitmap_set(dev->pcsc->cachable_bitmask, cap_pos + PCI_VPD_ADDR,
+			   2); /* PCI_VPD_ADDR */
+		break;
+	default:
+		/* Unsupported capability - We shouldn't reach this point */
+		pr_warn("Something is off when iterating through the supported capabilities.");
+		break;
+	}
+}
+
+static void infer_capabilities_pointers(struct pci_dev *dev)
+{
+	u8 pos, cap_id, next_cap;
+	u32 val;
+	int i;
+
+	if (pcsc_hw_config_read(dev->bus, dev->devfn, PCI_CAPABILITY_LIST, 1,
+				&val) != PCIBIOS_SUCCESSFUL)
+		return;
+
+	pos = (val & 0xFF) & ~0x3;
+
+	while (pos) {
+		if (pos < 0x40 || pos > 0xFE)
+			break;
+
+		pos &= ~0x3;
+		if (pcsc_hw_config_read(dev->bus, dev->devfn, pos, 2, &val) !=
+		    PCIBIOS_SUCCESSFUL)
+			break;
+
+		cap_id = val & 0xFF; /* PCI_CAP_LIST_ID */
+		next_cap = (val >> 8) & 0xFF; /* PCI_CAP_LIST_NEXT */
+
+		bitmap_set(dev->pcsc->cachable_bitmask, pos, 2);
+		pcsc_update_byte(dev, pos, cap_id); /* PCI_CAP_LIST_ID */
+		pcsc_update_byte(dev, pos + 1,
+				 next_cap); /* PCI_CAP_LIST_NEXT */
+
+		pci_dbg(dev, "Capability ID %#x found at %#x\n", cap_id, pos);
+
+		/* Check if this is a supported capability and infer cacheability */
+		for (i = 0; i < ARRAY_SIZE(PCSC_SUPPORTED_CAPABILITIES); i++) {
+			if (cap_id == PCSC_SUPPORTED_CAPABILITIES[i]) {
+				infer_capability_cacheability(dev, pos, cap_id);
+				break;
+			}
+		}
+
+		/* Move to next capability */
+		pos = next_cap;
+	}
+}
+
+static void infer_cacheability(struct pci_dev *dev)
+{
+	if (WARN_ON(!dev || !dev->pcsc || !dev->pcsc->cfg_space))
+		return;
+
+	bitmap_zero(dev->pcsc->cachable_bitmask, PCSC_CFG_SPC_SIZE);
+
+	/* Type 0 Configuration Space Header */
+	if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
+		/*
+		 * Mark cacheable registers in the PCI configuration space header.
+		 * We cache read-only and rarely changing registers:
+		 * - PCI_VENDOR_ID, PCI_DEVICE_ID (0x00-0x03)
+		 * - PCI_CLASS_REVISION through PCI_CAPABILITY_LIST (0x08-0x34)
+		 *   Includes: CLASS_REVISION, CACHE_LINE_SIZE, LATENCY_TIMER,
+		 *   HEADER_TYPE, BIST, BASE_ADDRESS_0-5, CARDBUS_CIS,
+		 *   SUBSYSTEM_VENDOR_ID, SUBSYSTEM_ID, ROM_ADDRESS, CAPABILITY_LIST
+		 * - PCI_INTERRUPT_LINE through PCI_MAX_LAT (0x3c-0x3f)
+		 *   Includes: INTERRUPT_LINE, INTERRUPT_PIN, MIN_GNT, MAX_LAT
+		 */
+		bitmap_set(dev->pcsc->cachable_bitmask, PCI_VENDOR_ID, 4);
+		bitmap_set(dev->pcsc->cachable_bitmask, PCI_CLASS_REVISION, 45);
+		bitmap_set(dev->pcsc->cachable_bitmask, PCI_INTERRUPT_LINE, 4);
+
+		/* Pre populate the cache with the values that we already know */
+		pcsc_update_byte(dev, PCI_HEADER_TYPE,
+				 dev->hdr_type |
+					 (dev->multifunction ? 0x80 : 0));
+
+		/*
+		 * SR-IOV VFs must return 0xFFFF (PCI_ANY_ID) for vendor/device ID
+		 * registers per PCIe spec.
+		 */
+		if (dev->is_virtfn) {
+			pcsc_update_byte(dev, PCI_VENDOR_ID, 0xFF);
+			pcsc_update_byte(dev, PCI_VENDOR_ID + 1, 0xFF);
+			pcsc_update_byte(dev, PCI_DEVICE_ID, 0xFF);
+			pcsc_update_byte(dev, PCI_DEVICE_ID + 1, 0xFF);
+		} else {
+			if (dev->vendor != PCI_ANY_ID) {
+				pcsc_update_byte(dev, PCI_VENDOR_ID,
+						 dev->vendor & 0xFF);
+				pcsc_update_byte(dev, PCI_VENDOR_ID + 1,
+						 (dev->vendor >> 8) & 0xFF);
+			}
+			if (dev->device != PCI_ANY_ID) {
+				pcsc_update_byte(dev, PCI_DEVICE_ID,
+						 dev->device & 0xFF);
+				pcsc_update_byte(dev, PCI_DEVICE_ID + 1,
+						 (dev->device >> 8) & 0xFF);
+			}
+		}
+
+		infer_capabilities_pointers(dev);
+	}
+}
+
 int pcsc_add_device(struct pci_dev *dev)
 {
 	struct pcsc_node *node;
@@ -199,6 +459,7 @@ int pcsc_add_device(struct pci_dev *dev)
 		if (!dev->pcsc->cfg_space)
 			goto err_free_node;
 
+		infer_cacheability(dev);
 	} else {
 		dev->pcsc->cfg_space = NULL;
 	}
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


