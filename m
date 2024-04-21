Return-Path: <linux-pci+bounces-6501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD29C8AC0DB
	for <lists+linux-pci@lfdr.de>; Sun, 21 Apr 2024 21:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0163B20D8F
	for <lists+linux-pci@lfdr.de>; Sun, 21 Apr 2024 19:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE313405FF;
	Sun, 21 Apr 2024 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYww6CYR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBAB3FE5B;
	Sun, 21 Apr 2024 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713726569; cv=none; b=TYeTjjjakLPg5AIyNNHyhWfgngwYVqeQF9+kBkZjYKVFsIU8rvy271OoldxWXobheYDmN382JdNux39C4aBRfibSEyfpoEp+TDEtRqWKZiNS0ysg1kwiXDqQKLUe4zNLir7rJMkXpFJX5kGEGcrJlOH5HLaIyZBO/heM/Szm3fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713726569; c=relaxed/simple;
	bh=DGGRnOnMETe5yLZBJXUtvMjEtQFRFyfHXXUU3JsalXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MPOofRZ/k5Zywu2SQ7Ibd0Snmvxm29a+X3m3JsqvzNhkc+ZhzkVYjdKHJP+hNzyuuMRebCF9Z/qMn9lwGeUxjN6xLglCGhD1sqlT148Ly7QFgT4r63IQZc3s3ydFuRt5e0ocXyO+ByxCf1N375hT8B9jLXCgjq4Mh5N+dBdK5uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYww6CYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E469FC2BD11;
	Sun, 21 Apr 2024 19:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713726569;
	bh=DGGRnOnMETe5yLZBJXUtvMjEtQFRFyfHXXUU3JsalXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cYww6CYReqt2SCnm+5LCXLNaA5uLrkY05rRfufILRa0RUDjWgLgWCFRu27DiLILdU
	 LvksBZpuUrNGSjXm9utvcOZ1Rh2cOBpsffkIQinFxoyrFwPqU/YsF42C55gEQHJy+p
	 99bDYudh00o61/py6z8uFX+5CySklCbHNA4v0A12PRdDxWyFs7yuGXPS1v3LQG481q
	 MAccxDUiAeYb7mAiCYzklRPtU5Nq66kotm4EvbgUJaRH6D/UTyaR63mk/LkypVXX2e
	 MoXhv0pQqMjmlsagiwef4meSxHn15hSJKnfCiSlxaZSymXA1zVQ+seMVSAIJsvR4bY
	 Qn0BqtXwTJFMQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krishna Thota <kthota@nvidia.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Vidya Sagar <sagar.tv@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v7-incomplete 1/3] PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to pci_register_host_bridge()
Date: Sun, 21 Apr 2024 14:09:12 -0500
Message-Id: <20240421190914.374399-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240421190914.374399-1-helgaas@kernel.org>
References: <20240418174043.3750240-1-vidyas@nvidia.com>
 <20240421190914.374399-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Move the PRESERVE_BOOT_CONFIG _DSM evaluation from acpi_pci_root_create()
to pci_register_host_bridge().

This will help unify the ACPI _DSM path and the DT-based
"linux,pci-probe-only" paths.

This should be safe because it happens earlier than it used to:

    acpi_pci_root_create
      pci_create_root_bus
        pci_register_host_bridge
  +       bridge->preserve_config = pci_preserve_config(bridge)
            pci_acpi_preserve_config
  +           acpi_evaluate_dsm_typed(DSM_PCI_PRESERVE_BOOT_CONFIG)
  -   acpi_evaluate_dsm_typed(DSM_PCI_PRESERVE_BOOT_CONFIG)

No functional change intended.
---
 drivers/acpi/pci_root.c | 12 ------------
 drivers/pci/pci-acpi.c  | 22 ++++++++++++++++++++++
 drivers/pci/pci.h       |  5 +++++
 drivers/pci/probe.c     | 11 +++++++++++
 4 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 58b89b8d950e..ddc2b3e89111 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -1008,7 +1008,6 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	int node = acpi_get_node(device->handle);
 	struct pci_bus *bus;
 	struct pci_host_bridge *host_bridge;
-	union acpi_object *obj;
 
 	info->root = root;
 	info->bridge = device;
@@ -1050,17 +1049,6 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	if (!(root->osc_ext_control_set & OSC_CXL_ERROR_REPORTING_CONTROL))
 		host_bridge->native_cxl_error = 0;
 
-	/*
-	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
-	 * exists and returns 0, we must preserve any PCI resource
-	 * assignments made by firmware for this host bridge.
-	 */
-	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
-				      DSM_PCI_PRESERVE_BOOT_CONFIG, NULL, ACPI_TYPE_INTEGER);
-	if (obj && obj->integer.value == 0)
-		host_bridge->preserve_config = 1;
-	ACPI_FREE(obj);
-
 	acpi_dev_power_up_children_with_adr(device);
 
 	pci_scan_child_bus(bus);
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 004575091596..9cc447da9475 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -119,6 +119,28 @@ phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
 	return (phys_addr_t)mcfg_addr;
 }
 
+bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
+{
+	if (ACPI_HANDLE(&host_bridge->dev)) {
+		union acpi_object *obj;
+
+		/*
+		 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
+		 * exists and returns 0, we must preserve any PCI resource
+		 * assignments made by firmware for this host bridge.
+		 */
+		obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev),
+					      &pci_acpi_dsm_guid,
+					      1, DSM_PCI_PRESERVE_BOOT_CONFIG,
+					      NULL, ACPI_TYPE_INTEGER);
+		if (obj && obj->integer.value == 0)
+			return true;
+		ACPI_FREE(obj);
+	}
+
+	return false;
+}
+
 /* _HPX PCI Setting Record (Type 0); same as _HPP */
 struct hpx_type0 {
 	u32 revision;		/* Not present in _HPP */
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 17fed1846847..180d3907b543 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -734,6 +734,7 @@ static inline void pci_restore_aer_state(struct pci_dev *dev) { }
 #endif
 
 #ifdef CONFIG_ACPI
+bool pci_acpi_preserve_config(struct pci_host_bridge *bridge);
 int pci_acpi_program_hp_params(struct pci_dev *dev);
 extern const struct attribute_group pci_dev_acpi_attr_group;
 void pci_set_acpi_fwnode(struct pci_dev *dev);
@@ -747,6 +748,10 @@ int acpi_pci_wakeup(struct pci_dev *dev, bool enable);
 bool acpi_pci_need_resume(struct pci_dev *dev);
 pci_power_t acpi_pci_choose_state(struct pci_dev *pdev);
 #else
+static inline bool pci_acpi_preserve_config(struct pci_host_bridge *bridge)
+{
+	return false;
+}
 static inline int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
 {
 	return -ENOTTY;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1325fbae2f28..ee086d029450 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -889,6 +889,14 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
 	dev_set_msi_domain(&bus->dev, d);
 }
 
+static bool pci_preserve_config(struct pci_host_bridge *host_bridge)
+{
+	if (pci_acpi_preserve_config(host_bridge))
+		return true;
+
+	return false;
+}
+
 static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 {
 	struct device *parent = bridge->dev.parent;
@@ -983,6 +991,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
 		dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
 
+	/* Check if the boot configuration by FW needs to be preserved */
+	bridge->preserve_config = pci_preserve_config(bridge);
+
 	/* Coalesce contiguous windows */
 	resource_list_for_each_entry_safe(window, n, &resources) {
 		if (list_is_last(&window->node, &resources))
-- 
2.34.1


