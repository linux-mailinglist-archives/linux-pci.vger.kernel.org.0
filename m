Return-Path: <linux-pci+bounces-37522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0E4BB64D2
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 11:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FB53B154C
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 09:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1337D28150F;
	Fri,  3 Oct 2025 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="dlkJZ4VR"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3793E280CCE;
	Fri,  3 Oct 2025 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482191; cv=none; b=BvmBVncjpV8x2jb53cK3KHTizIyn20vxPvZsT3YP8KJcQZMB+DFnos1U2B65YykiL934q402lfegd6lmm26PAxWj4qyJ8V+ta2281wzcKmb5UA61FsZ7Lwk0501MCi05+a8xKVPncbxz8Hd8zl42AzWzOSvFut09+4kO4+bvlvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482191; c=relaxed/simple;
	bh=0KZ0n4kojPv4sqYsZ4h8eRDRtef+RvVOId6dkEUd5k8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fyD1TaH+tbNazJaLEOYalHEuuzeDm1aTZORvkmH74XHonM/inYq7My7a43/DeDgffehXGw25SYM/d6fqRvfvylzX/ssb1/JH663l4VhkDHeurBYJNED9/JpkdbL7yahgfM/4PQuOM7LYqhoJR2H5pmcmQ7IpwcZNeyKQ5xcSVD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=dlkJZ4VR; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759482189; x=1791018189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+ArayRhSq303qFHt5ZQSDT/AviX9lru1vDA/q7ieGNs=;
  b=dlkJZ4VR2yXcx48pE3zPOnLao0i0/kXqzf7ABfXuQYVPz+W48iige2N8
   T67RSoxraWJzfTeOiE+cFB5gENBN5lftxPpzRy6PJG+skzpeDLP25YMEL
   p2nl8ti+beWfcbtoQA/gZgxUNtPYBtglUWgKm+BvAJqlxZvnYHnrtssKj
   2XL+CNozw42/lcK5hfFhk+8LwjAuUghds0RTE20kcdT+U3odcJpkD/15G
   l8ixlfnIQRt3fGaV+S/hzv8MKw22HMGMcM6bSwkmAWdO37U0UPNdMzj/k
   M3rfoIHrQpnh/d5mHwgVF2sfMWpd0l10al/dQmgCdmZNuAWqx86k9T7bW
   w==;
X-CSE-ConnectionGUID: IHjvvxWXTAuOdk89amRzMA==
X-CSE-MsgGUID: 8bsG8dUQS8mtBpN2Us9IoQ==
X-IronPort-AV: E=Sophos;i="6.18,312,1751241600"; 
   d="scan'208";a="4090440"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 09:03:07 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:46879]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.215:2525] with esmtp (Farcaster)
 id ae66a1df-44c0-4093-8c0b-5ecb61355fd0; Fri, 3 Oct 2025 09:03:07 +0000 (UTC)
X-Farcaster-Flow-ID: ae66a1df-44c0-4093-8c0b-5ecb61355fd0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 3 Oct 2025 09:03:06 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 3 Oct 2025
 09:03:04 +0000
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
Subject: [RFC PATCH 04/13] pci: pcsc: infer PCIe extended capabilities
Date: Fri, 3 Oct 2025 09:00:40 +0000
Message-ID: <026b1d3e3fcb2a554511de3f23d6a7640b5377b6.1759312886.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759312886.git.epetron@amazon.de>
References: <cover.1759312886.git.epetron@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Extend PCSC to support cacheability inference for PCIe extended
capabilities located in the 4KB extended configuration space.

Similar to the capabilities, PCIe extended capabilities require
traversal of the capability list to determine cacheability. The
implementation identifies cacheable registers for capabilities used
by the generic PCIe driver:

- Advanced Error Reporting (AER)
- Access Control Services (ACS)
- Alternative Routing-ID (ARI)
- SR-IOV
- Address Translation Services (ATS)
- Page Request Interface (PRI)
- Process Address Space ID (PASID)
- Downstream Port Containment (DPC)
- Precision Time Measurement (PTM)

The extended capability header (4 bytes) is always cached to enable
efficient capability list traversal.

All the extended capabilities apart from the DPC are static. Regarding
DPC, the DPC capabilities is read and based on its value the
cacheability of RP* registers is inferred.

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 drivers/pci/pcsc.c | 203 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 203 insertions(+)

diff --git a/drivers/pci/pcsc.c b/drivers/pci/pcsc.c
index 29945eac4190..343f8b03831a 100644
--- a/drivers/pci/pcsc.c
+++ b/drivers/pci/pcsc.c
@@ -180,6 +180,65 @@ static const u8 PCSC_SUPPORTED_CAPABILITIES[] = {
 	PCI_CAP_ID_MSIX, PCI_CAP_ID_EXP, PCI_CAP_ID_AF,	 PCI_CAP_ID_EA
 };
 
+#ifdef CONFIG_PCIE_PCSC
+static const u16 PCSCS_SUPPORTED_EXT_CAPABILITIES[] = {
+	PCI_EXT_CAP_ID_ERR,   PCI_EXT_CAP_ID_ACS, PCI_EXT_CAP_ID_ARI,
+	PCI_EXT_CAP_ID_SRIOV, PCI_EXT_CAP_ID_ATS, PCI_EXT_CAP_ID_PRI,
+	PCI_EXT_CAP_ID_PASID, PCI_EXT_CAP_ID_DPC, PCI_EXT_CAP_ID_PTM
+};
+
+/**
+ * pcsc_handle_dpc_cacheability - Set cacheability for DPC capability registers
+ * @dev: PCI device
+ * @cap_pos: Capability position in config space
+ *
+ * The DPC capability cacheability depends on whether RP extensions are supported:
+ * - PCI_EXP_DPC_CAP_RP_EXT bit indicates RP extension register presence
+ */
+static void pcsc_handle_dpc_cacheability(struct pci_dev *dev, int cap_pos)
+{
+	u32 val;
+	u16 dpc_cap;
+	bool has_rp_extensions;
+
+	if (WARN_ON(!dev || !dev->pcsc || !dev->pcsc->cfg_space))
+		return;
+
+	if (pcsc_hw_config_read(dev->bus, dev->devfn, cap_pos + PCI_EXP_DPC_CAP,
+				2, &val) != PCIBIOS_SUCCESSFUL) {
+		pci_warn(dev, "PCSC: Failed to read DPC capability at %#x\n",
+			 cap_pos + PCI_EXP_DPC_CAP);
+		return;
+	}
+
+	dpc_cap = val & 0xFFFF;
+	has_rp_extensions = !!(dpc_cap & PCI_EXP_DPC_CAP_RP_EXT);
+
+	/* Cache the DPC capability register */
+	pcsc_update_byte(dev, cap_pos + PCI_EXP_DPC_CAP, dpc_cap & 0xFF);
+	pcsc_update_byte(dev, cap_pos + PCI_EXP_DPC_CAP + 1,
+			 (dpc_cap >> 8) & 0xFF);
+
+	/* Always cacheable: main DPC registers */
+	bitmap_set(dev->pcsc->cachable_bitmask, cap_pos + PCI_EXP_DPC_CAP, 2);
+	bitmap_set(dev->pcsc->cachable_bitmask, cap_pos + PCI_EXP_DPC_CTL, 2);
+
+	/* Conditionally cacheable: RP extension registers  PCI_EXP_DPC_RP_PIO_MASK
+	 * PCI_EXP_DPC_RP_PIO_SEVERITY , PCI_EXP_DPC_RP_PIO_SYSERROR, PCI_EXP_DPC_RP_PIO_EXCEPTION
+	 */
+	if (has_rp_extensions) {
+		bitmap_set(dev->pcsc->cachable_bitmask,
+			   cap_pos + PCI_EXP_DPC_RP_PIO_MASK, 16);
+		bitmap_set(dev->pcsc->cachable_bitmask,
+			   cap_pos + PCI_EXP_DPC_RP_PIO_SEVERITY, 4);
+		bitmap_set(dev->pcsc->cachable_bitmask,
+			   cap_pos + PCI_EXP_DPC_RP_PIO_SYSERROR, 4);
+		bitmap_set(dev->pcsc->cachable_bitmask,
+			   cap_pos + PCI_EXP_DPC_RP_PIO_EXCEPTION, 4);
+	}
+}
+#endif
+
 /**
  * pcsc_handle_msi_cacheability - Set cacheability for MSI capability registers
  * @dev: PCI device
@@ -378,6 +437,146 @@ static void infer_capabilities_pointers(struct pci_dev *dev)
 	}
 }
 
+#ifdef CONFIG_PCIE_PCSC
+
+static void infer_extended_capability_cacheability(struct pci_dev *dev,
+						   int cap_pos, u16 cap_id)
+{
+	if (WARN_ON(!dev || !dev->pcsc || !dev->pcsc->cfg_space))
+		return;
+
+	switch (cap_id) {
+	case PCI_EXT_CAP_ID_ERR:
+		/* Advanced Error Reporting */
+		bitmap_set(dev->pcsc->cachable_bitmask,
+			   cap_pos + PCI_ERR_UNCOR_MASK,
+			   8); /* PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER */
+		bitmap_set(dev->pcsc->cachable_bitmask,
+			   cap_pos + PCI_ERR_COR_MASK,
+			   4); /* PCI_ERR_COR_MASK only */
+		bitmap_set(dev->pcsc->cachable_bitmask,
+			   cap_pos + PCI_ERR_ROOT_COMMAND,
+			   4); /* PCI_ERR_ROOT_COMMAND */
+		break;
+	case PCI_EXT_CAP_ID_ACS:
+		/* Access Control Services
+		 * We only cache PCI_ACS_CAP and PCI_ACS_CTRL (first 4 bytes).
+		 * The Egress Control Vector that follows (if present) is not
+		 * cached because:
+		 * - Determining its size would require reading PCI_ACS_CAP
+		 * - These registers are typically only written by the OS during
+		 *   setup and not read frequently during runtime
+		 * - Caching them would provide no performance benefit
+		 */
+		bitmap_set(dev->pcsc->cachable_bitmask, cap_pos + PCI_ACS_CAP,
+			   4); /* PCI_ACS_CAP, PCI_ACS_CTRL */
+		break;
+	case PCI_EXT_CAP_ID_ARI:
+		/* Alternative Routing-ID: */
+		bitmap_set(dev->pcsc->cachable_bitmask, cap_pos + PCI_ARI_CAP,
+			   4); /* PCI_ARI_CAP, PCI_ARI_CTRL */
+		break;
+	case PCI_EXT_CAP_ID_SRIOV:
+		/* SR-IOV */
+		bitmap_set(dev->pcsc->cachable_bitmask, cap_pos + PCI_SRIOV_CAP,
+			   6); /* PCI_SRIOV_CAP, PCI_SRIOV_CTRL */
+		/* PCI_SRIOV_INITIAL_VF, PCI_SRIOV_TOTAL_VF,
+		 * PCI_SRIOV_NUM_VF,PCI_SRIOV_FUNC_LINK
+		 */
+		bitmap_set(dev->pcsc->cachable_bitmask,
+			   cap_pos + PCI_SRIOV_INITIAL_VF, 7);
+		bitmap_set(dev->pcsc->cachable_bitmask,
+			   cap_pos + PCI_SRIOV_VF_OFFSET,
+			   4); /* PCI_SRIOV_VF_OFFSET, PCI_SRIOV_VF_STRIDE */
+		/* PCI_SRIOV_VF_DID, PCI_SRIOV_SUPPORTED_PAGE_SIZES,PCI_SRIOV_PAGE_SIZE */
+		bitmap_set(
+			dev->pcsc->cachable_bitmask, cap_pos + PCI_SRIOV_VF_DID,
+			10);
+		bitmap_set(dev->pcsc->cachable_bitmask, cap_pos + PCI_SRIOV_BAR,
+			   24); /* PCI_SRIOV_BAR0-5 */
+		bitmap_set(dev->pcsc->cachable_bitmask, cap_pos + PCI_SRIOV_VFM,
+			   4); /* PCI_SRIOV_VFMM */
+		break;
+	case PCI_EXT_CAP_ID_ATS:
+		/* Address Translation Service: */
+		bitmap_set(dev->pcsc->cachable_bitmask, cap_pos + PCI_ATS_CAP,
+			   4); /* PCI_ATS_CAP, PCI_ATS_CTRL*/
+		break;
+	case PCI_EXT_CAP_ID_PRI:
+		/* Page Request Interface */
+		bitmap_set(dev->pcsc->cachable_bitmask, cap_pos + PCI_PRI_CTRL,
+			   2); /* PCI_PRI_CTRL */
+		bitmap_set(dev->pcsc->cachable_bitmask,
+			   cap_pos + PCI_PRI_MAX_REQ,
+			   8); /* PCI_PRI_MAX_REQ, PCI_PRI_ALLOC_REQ */
+		break;
+	case PCI_EXT_CAP_ID_PASID:
+		/* Process Address Space ID */
+		bitmap_set(dev->pcsc->cachable_bitmask, cap_pos + PCI_PASID_CAP,
+			   4); /* PCI_PASID_CAP, PCI_PASID_CTRL */
+		break;
+	case PCI_EXT_CAP_ID_DPC:
+		/* Downstream Port Containment */
+		pcsc_handle_dpc_cacheability(dev, cap_pos);
+		break;
+	case PCI_EXT_CAP_ID_PTM:
+		/* Precision Time Measurement */
+		bitmap_set(dev->pcsc->cachable_bitmask, cap_pos + PCI_PTM_CAP,
+			   8); /* PCI_PTM_CAP, PCI_PTM_CTRL */
+		break;
+	default:
+		/* Unknown extended capability - only cache header */
+		break;
+	}
+}
+
+static void infer_extended_capabilities_pointers(struct pci_dev *dev)
+{
+	int pos = 0x100;
+	u32 header;
+	int cap_ver, cap_id;
+	int i;
+
+	while (pos) {
+		if (pos > 0xFFC || pos < 0x100)
+			break;
+
+		pos &= ~0x3;
+
+		if (pcsc_hw_config_read(dev->bus, dev->devfn, pos, 4,
+					&header) != PCIBIOS_SUCCESSFUL)
+			break;
+
+		if (!header)
+			break;
+
+		bitmap_set(dev->pcsc->cachable_bitmask, pos, 4);
+		for (i = 0; i < 4; i++)
+			pcsc_update_byte(dev, pos + i,
+					 (header >> (i * 8)) & 0xFF);
+
+		cap_id = PCI_EXT_CAP_ID(header);
+		cap_ver = PCI_EXT_CAP_VER(header);
+
+		pci_dbg(dev,
+			"Extended capability ID %#x (ver %d) found at %#x, next cap at %#x\n",
+			cap_id, cap_ver, pos, PCI_EXT_CAP_NEXT(header));
+
+		/* Check if this is a supported extended capability and infer cacheability */
+		for (i = 0; i < ARRAY_SIZE(PCSCS_SUPPORTED_EXT_CAPABILITIES);
+		     i++) {
+			if (cap_id == PCSCS_SUPPORTED_EXT_CAPABILITIES[i]) {
+				infer_extended_capability_cacheability(dev, pos,
+								       cap_id);
+				break;
+			}
+		}
+
+		pos = PCI_EXT_CAP_NEXT(header);
+	}
+}
+#endif
+
 static void infer_cacheability(struct pci_dev *dev)
 {
 	if (WARN_ON(!dev || !dev->pcsc || !dev->pcsc->cfg_space))
@@ -432,6 +631,10 @@ static void infer_cacheability(struct pci_dev *dev)
 		}
 
 		infer_capabilities_pointers(dev);
+#ifdef CONFIG_PCIE_PCSC
+		if (pci_is_pcie(dev))
+			infer_extended_capabilities_pointers(dev);
+#endif
 	}
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


