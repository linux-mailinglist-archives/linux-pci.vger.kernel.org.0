Return-Path: <linux-pci+bounces-43946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83830CEEE1E
	for <lists+linux-pci@lfdr.de>; Fri, 02 Jan 2026 16:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90022300E01B
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 15:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB762741DF;
	Fri,  2 Jan 2026 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzlXxTCh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C5422157E;
	Fri,  2 Jan 2026 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767368105; cv=none; b=Kfl7TUUvAuckeZ1YkRQYxA/kcyeJBp7zB1zo6rBHXjv+pRVaPWXpcGXkPclTw/lWqjoHCJUTpZgyS/KeP4EwAEtifHX+AAqbt54MSkqyh33oFbrTc0VbVYAfufAVCIpu3+UvUv8WwsyTxXsnaJpMcg40VU7SvisUpB4rqxnqdmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767368105; c=relaxed/simple;
	bh=63RTubzZMgn/lpxM537Y/oEc4WWZ4p237I10VUTM4vQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SJhPDBDgi00Yypm5mbCVQu93AvQp6KzkQPwpaKxBGxstfvKs92RB24tDEpAv7nY8tvoNc7mic9mTKu4X9Ll5V5d3IJsFil2P2BzMHqOkZ8mN2Pa3SoA3DaGhFigZ2n0p3hknlO4fuINZ5ZMgI1p6A0KLdCplKeDiL6FmJWvA6r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzlXxTCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A305EC19425;
	Fri,  2 Jan 2026 15:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767368104;
	bh=63RTubzZMgn/lpxM537Y/oEc4WWZ4p237I10VUTM4vQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PzlXxTChAECNQMuPekaaqgONjTIGADM5Fv7sGh+h/QI3RW0o9wcFD1HAoWasYZYbD
	 WE/UkFE5pJA5Phr+aj/xyI9S0jxXs8FOeClTsNoC6k+tgIdlP4FPg+YYyLpuC88AGx
	 hYH2aHd48gD1qPDxPEUYa8HTBTRVAX+8aGFdxaU6FO2j+ebZ7OdabHP7nAr8rJ6gFj
	 PzdTMrQCnnye7P881FNQBTcVmpNMRsGduHXdKtFif79JxmVxlBkVptUcGOEunhghk1
	 ICd3/UV1i2+XxbUkhH9rFwtPCyg4faymChUU1LTqrLji+efd7IJWL1C2yAAZ0Z0q8d
	 NkWMGc3THBIxA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9608CEED628;
	Fri,  2 Jan 2026 15:35:04 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Fri, 02 Jan 2026 21:04:49 +0530
Subject: [PATCH v3 3/4] PCI: Disable ACS SV capability for the broken IDT
 switches
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260102-pci_acs-v3-3-72280b94d288@oss.qualcomm.com>
References: <20260102-pci_acs-v3-0-72280b94d288@oss.qualcomm.com>
In-Reply-To: <20260102-pci_acs-v3-0-72280b94d288@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, Naresh Kamboju <naresh.kamboju@linaro.org>, 
 Pavankumar Kondeti <quic_pkondeti@quicinc.com>, 
 Xingang Wang <wangxingang5@huawei.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7330;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=hSq+H8p+b3vKTeIGRylJu/YSgirGGdFRZY95lQVM7wA=;
 b=owGbwMvMwMUYOl/w2b+J574ynlZLYsgMf7osxH6euZDI7wjG72v4er++yf03tbnvnmO7sJ77n
 3wLwwdenYzGLAyMXAyyYoos6UudtRo9Tt9YEqE+HWYQKxPIFAYuTgGYyK3H7P/0jSwP2X58vSFv
 4r+O4oNckhL15/hZjOa/Y9d3sc80aLF+xPtlZub7JbFckyR1f+ptli5Pm+9qfPaT3LT5xZGZO6s
 5VJM0aq9HbL109TizUdy7X54Xmp/GxycUeH/qjZ5lYj+JLbdMMPfkHKUHxnKtc7LOz2mUs9N5Wr
 21clqLqRi/iGGTzqPozj9JZyd27GiQClmvkFmhtOt+d/OMfwcZz7/Zymkv4RjA56k6ec77/EB1v
 ugHwbxcinE1d3ksLRTc2fgq/i1xlZ4hXPjttc0igZqZXpb5x/K9Naa1bNoWXHnvrvmZ4mP8C+52
 hcidCi2Pi+3KiLU+uOT/NdcPTl1FdmevBrtbdT705N8GAA==
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Some IDT switches behave erratically when ACS Source Validation is enabled.
For example, they incorrectly flag an ACS Source Validation error on
completions for config read requests even though PCIe r4.0, sec 6.12.1.1,
says that completions are never affected by ACS Source Validation.

Even though IDT suggests working around this issue by issuing a config
write before the first config read, so that the device caches the bus and
device number. But it would still be fragile since the device could loose
the IDs after the reset and any further access may trigger ACS SV
violation.

Hence, to properly fix the issue, the respective capability needs to be
disabled. Since the ACS Capabilities are RO values, and are cached in the
'pci_dev::acs_capabilities' field, remove the cached broken capabilities by
calling pci_disable_broken_acs_cap() from pci_acs_init(). This will allow
pci_enable_acs() helper to disable the relevant ACS ctrls.

With this, the previous workaround can now be safely removed.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pci.c    |  1 +
 drivers/pci/pci.h    |  3 ++-
 drivers/pci/probe.c  | 12 -----------
 drivers/pci/quirks.c | 61 ++++++++++++----------------------------------------
 4 files changed, 17 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d89b04451aea..e16229e7ff6f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3652,6 +3652,7 @@ void pci_acs_init(struct pci_dev *dev)
 		return;
 
 	pci_read_config_word(dev, pos + PCI_ACS_CAP, &dev->acs_capabilities);
+	pci_disable_broken_acs_cap(dev);
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4592ede0ebcc..5fe5d6e84c95 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -432,7 +432,6 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
 				int rrs_timeout);
 bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
 					int rrs_timeout);
-int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *pl, int rrs_timeout);
 
 int pci_setup_device(struct pci_dev *dev);
 void __pci_size_stdbars(struct pci_dev *dev, int count,
@@ -944,6 +943,7 @@ void pci_enable_acs(struct pci_dev *dev);
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
 int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
+void pci_disable_broken_acs_cap(struct pci_dev *pdev);
 int pcie_failed_link_retrain(struct pci_dev *dev);
 #else
 static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
@@ -959,6 +959,7 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
 {
 	return -ENOTTY;
 }
+static inline void pci_disable_broken_acs_cap(struct pci_dev *dev) { }
 static inline int pcie_failed_link_retrain(struct pci_dev *dev)
 {
 	return -ENOTTY;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 41183aed8f5d..c7304ac5afc2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2547,18 +2547,6 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 				int timeout)
 {
-#ifdef CONFIG_PCI_QUIRKS
-	struct pci_dev *bridge = bus->self;
-
-	/*
-	 * Certain IDT switches have an issue where they improperly trigger
-	 * ACS Source Validation errors on completions for config reads.
-	 */
-	if (bridge && bridge->vendor == PCI_VENDOR_ID_IDT &&
-	    bridge->device == 0x80b5)
-		return pci_idt_bus_quirk(bus, devfn, l, timeout);
-#endif
-
 	return pci_bus_generic_read_dev_vendor_id(bus, devfn, l, timeout);
 }
 EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b9c252aa6fe0..1571a2ef331e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5778,58 +5778,25 @@ DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 			       PCI_BASE_CLASS_DISPLAY, 16, quirk_nvidia_hda);
 
 /*
- * Some IDT switches incorrectly flag an ACS Source Validation error on
- * completions for config read requests even though PCIe r4.0, sec
- * 6.12.1.1, says that completions are never affected by ACS Source
- * Validation.  Here's the text of IDT 89H32H8G3-YC, erratum #36:
+ * Some IDT switches behave erratically when ACS Source Validation is enabled.
+ * For example, they incorrectly flag an ACS Source Validation error on
+ * completions for config read requests even though PCIe r4.0, sec 6.12.1.1,
+ * says that completions are never affected by ACS Source Validation.
  *
- *   Item #36 - Downstream port applies ACS Source Validation to Completions
- *   Section 6.12.1.1 of the PCI Express Base Specification 3.1 states that
- *   completions are never affected by ACS Source Validation.  However,
- *   completions received by a downstream port of the PCIe switch from a
- *   device that has not yet captured a PCIe bus number are incorrectly
- *   dropped by ACS Source Validation by the switch downstream port.
+ * Even though IDT suggests working around this issue by issuing a config write
+ * before the first config read, so that the switch caches the bus and device
+ * number, it would still be fragile since the device could loose the IDs after
+ * the reset.
  *
- * The workaround suggested by IDT is to issue a config write to the
- * downstream device before issuing the first config read.  This allows the
- * downstream device to capture its bus and device numbers (see PCIe r4.0,
- * sec 2.2.9), thus avoiding the ACS error on the completion.
- *
- * However, we don't know when the device is ready to accept the config
- * write, so we do config reads until we receive a non-Config Request Retry
- * Status, then do the config write.
- *
- * To avoid hitting the erratum when doing the config reads, we disable ACS
- * SV around this process.
+ * Hence, a reliable fix would be to assume that these switches don't support
+ * ACS SV.
  */
-int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *l, int timeout)
+void pci_disable_broken_acs_cap(struct pci_dev *pdev)
 {
-	int pos;
-	u16 ctrl = 0;
-	bool found;
-	struct pci_dev *bridge = bus->self;
-
-	pos = bridge->acs_cap;
-
-	/* Disable ACS SV before initial config reads */
-	if (pos) {
-		pci_read_config_word(bridge, pos + PCI_ACS_CTRL, &ctrl);
-		if (ctrl & PCI_ACS_SV)
-			pci_write_config_word(bridge, pos + PCI_ACS_CTRL,
-					      ctrl & ~PCI_ACS_SV);
+	if (pdev->vendor == PCI_VENDOR_ID_IDT && pdev->device == 0x80b5) {
+		pci_info(pdev, "Disabling broken ACS SV\n");
+		pdev->acs_capabilities &= ~PCI_ACS_SV;
 	}
-
-	found = pci_bus_generic_read_dev_vendor_id(bus, devfn, l, timeout);
-
-	/* Write Vendor ID (read-only) so the endpoint latches its bus/dev */
-	if (found)
-		pci_bus_write_config_word(bus, devfn, PCI_VENDOR_ID, 0);
-
-	/* Re-enable ACS_SV if it was previously enabled */
-	if (ctrl & PCI_ACS_SV)
-		pci_write_config_word(bridge, pos + PCI_ACS_CTRL, ctrl);
-
-	return found;
 }
 
 /*

-- 
2.48.1



