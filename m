Return-Path: <linux-pci+bounces-3898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEC2860584
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 23:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDEB5289B63
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 22:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D19313BAC0;
	Thu, 22 Feb 2024 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8fcGj40"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95F113793B;
	Thu, 22 Feb 2024 22:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640138; cv=none; b=J9F6L94Bvl9tLu61ZRBGAe57cYvHZX9ZQE9RWhPunMxlioZMSsbe016UzQqR0SO6lyvNFIXmMey+k/MtAx0K/w5xfeG8Xye6lgf3JhqVqg2x4g3/4g1SEjegr0OLW2YziisWY/bKm+fGm3/JZ06HEtP8bFkg423KYCF/xuOs4ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640138; c=relaxed/simple;
	bh=bARB3bwPnJD/Pqaol3M2Is4aqKt219+07FwF7t0zqkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HLwTJVMfEbDpCKX3PyMgTYKdUEtzssmCj48l++eq0nopl7vn2DTOHhwHYD9G7rDm7EzLqgSL/1PmWyKiVs2ENFPCGJXpLIhwj1KM5jJbaxE56vTRmJeTXG6LXwawdNtWFbWf+dBL7Wi6MZtitcSlpmP7vVBlkOG0ymcJBgRgb/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8fcGj40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26217C433B1;
	Thu, 22 Feb 2024 22:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708640138;
	bh=bARB3bwPnJD/Pqaol3M2Is4aqKt219+07FwF7t0zqkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l8fcGj40frsSckf5Xo0GsLs4xGBMv+oFspZxlghnHZh1eM6b3P9yqYcMPyV2+wCTN
	 0gGRxN78h0ZzR5Ev55k+KMIVH7A/BikbbbMQDwoN8kinCgdqjaFJeWLI224VB/eH4l
	 mfnAflIuRg/faX1BCQBr1JphCOToVPbWN7recDGBkGMEtaDPHM6jaDSJRHIRa6KSVa
	 tX8LxxAUgc5xX1IiuxazxF0dG2OWePOlinRbYDAKm6iw4V3vWTFncT9pRmOsSaBgLN
	 8TS83udzgl9caj08MlLeRDxez97KInXaAyKvcEg2FhJKELcj/xEo+52tR5pknKf3/z
	 NO4M7Wuscbz9g==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Matthew W Carlis <mattc@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 2/3] PCI/DPC: Remove CONFIG_PCIE_EDR
Date: Thu, 22 Feb 2024 16:15:20 -0600
Message-Id: <20240222221521.32159-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222221521.32159-1-helgaas@kernel.org>
References: <20240222221521.32159-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Previous Kconfig allowed the possibility of enabling CONFIG_PCIE_DPC
without CONFIG_PCIE_EDR.  The PCI Firmware Spec, r3.3, sec 4.5.1,
table 4-5, says an ACPI OS that requests control of DPC must also
advertise support for EDR.

Remove CONFIG_PCIE_EDR and enable the EDR code with CONFIG_PCIE_DPC so that
enabling DPC also enables EDR for ACPI systems.  Since EDR is an ACPI
feature, build edr.o only when CONFIG_ACPI is enabled.  Stubs cover the
case when DPC is enabled without ACPI.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_root.c   |  2 +-
 drivers/pci/pcie/Kconfig  | 14 ++++----------
 drivers/pci/pcie/Makefile |  5 ++++-
 drivers/pci/pcie/dpc.c    | 10 ----------
 include/linux/pci-acpi.h  |  4 ++--
 5 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index efc292b6214e..bcaf3d3a5e05 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -448,7 +448,7 @@ static u32 calculate_support(void)
 		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
 	if (pci_msi_enabled())
 		support |= OSC_PCI_MSI_SUPPORT;
-	if (IS_ENABLED(CONFIG_PCIE_EDR))
+	if (IS_ENABLED(CONFIG_PCIE_DPC))	/* DPC => EDR support */
 		support |= OSC_PCI_EDR_SUPPORT;
 
 	return support;
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 8999fcebde6a..21e98289fbe9 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -137,6 +137,10 @@ config PCIE_DPC
 	  have this capability or you do not want to use this feature,
 	  it is safe to answer N.
 
+	  On ACPI systems, this includes Error Disconnect Recover support,
+	  the hybrid model that uses both firmware and OS to implement DPC,
+	  as specified in the PCI Firmware Specification r3.3.
+
 config PCIE_PTM
 	bool "PCI Express Precision Time Measurement support"
 	help
@@ -145,13 +149,3 @@ config PCIE_PTM
 
 	  This is only useful if you have devices that support PTM, but it
 	  is safe to enable even if you don't.
-
-config PCIE_EDR
-	bool "PCI Express Error Disconnect Recover support"
-	depends on PCIE_DPC && ACPI
-	help
-	  This option adds Error Disconnect Recover support as specified
-	  in the Downstream Port Containment Related Enhancements ECN to
-	  the PCI Firmware Specification r3.2.  Enable this if you want to
-	  support hybrid DPC model which uses both firmware and OS to
-	  implement DPC.
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 8de4ed5f98f1..72657f780c33 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -12,4 +12,7 @@ obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
-obj-$(CONFIG_PCIE_EDR)		+= edr.o
+
+ifdef CONFIG_ACPI
+obj-$(CONFIG_PCIE_DPC)		+= edr.o
+endif
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 94111e438241..0aa79581250b 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -102,19 +102,9 @@ static bool dpc_completed(struct pci_dev *pdev)
  */
 bool pci_dpc_recovered(struct pci_dev *pdev)
 {
-	struct pci_host_bridge *host;
-
 	if (!pdev->dpc_cap)
 		return false;
 
-	/*
-	 * Synchronization between hotplug and DPC is not supported
-	 * if DPC is owned by firmware and EDR is not enabled.
-	 */
-	host = pci_find_host_bridge(pdev->bus);
-	if (!host->native_dpc && !IS_ENABLED(CONFIG_PCIE_EDR))
-		return false;
-
 	/*
 	 * Need a timeout in case DPC never completes due to failure of
 	 * dpc_wait_rp_inactive().  The spec doesn't mandate a time limit,
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 078225b514d4..92e196ba0249 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -122,13 +122,13 @@ extern const guid_t pci_acpi_dsm_guid;
 #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
 #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
 
-#ifdef CONFIG_PCIE_EDR
+#ifdef CONFIG_PCIE_DPC
 void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
 void pci_acpi_remove_edr_notifier(struct pci_dev *pdev);
 #else
 static inline void pci_acpi_add_edr_notifier(struct pci_dev *pdev) { }
 static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
-#endif /* CONFIG_PCIE_EDR */
+#endif /* CONFIG_PCIE_DPC */
 
 int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *));
 void pci_acpi_clear_companion_lookup_hook(void);
-- 
2.34.1


