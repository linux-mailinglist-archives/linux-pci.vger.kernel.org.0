Return-Path: <linux-pci+bounces-6937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D80D8B89A2
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 14:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2494928264A
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 12:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39448824A3;
	Wed,  1 May 2024 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="a8FNhmBr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8009583CC2
	for <linux-pci@vger.kernel.org>; Wed,  1 May 2024 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565894; cv=none; b=BgGkUuZvBNuRPuQ6FjXA8L0nVQi6t1vwfgVBGHAUR8XOUih7IH+52JjnkGUhH6xiddn0YbeD20KODNQmtS5QSdbtdb8vkUe0loFfei9FL9jWAuYGWgvyjaFQG0kH807/tZiKql8FDOPn68dj4YVlSKlC4JI/THIOpilsWZpLYpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565894; c=relaxed/simple;
	bh=Kpg2Dak2Sn/bLhHCJoIkdyJgXdEy9G8+cj88d9DTE1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eeRaWcgowdXX46i102wDmbUc+KADwB0H85y3AAnw3cME8PeRZz4VJlriXqsYS6yhXiwpEFv+1GDa+pcHNlAZq+g9OP+Vk0fqY405BNwiSLaCAgvPj8aLOwClko8UuiD/Znrm9r481ZcKAztsj2Bid76a0y22NEzlhEsShlpiqoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=a8FNhmBr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e3ff14f249so5762635ad.1
        for <linux-pci@vger.kernel.org>; Wed, 01 May 2024 05:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714565892; x=1715170692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBFCNaiZG8SDhd9Avy2NjVgbIzDcy1byPrgimW8Jnrg=;
        b=a8FNhmBrj9rjKo0IZFUGsoe3E9xpfymjk3nZhZmeuqmlTL001CYguiU03v7oOsu6iS
         KWoBIM+swBSJHVWzHfo8BU5xiYby8aIhxyWzbPuUxUjJfzf71nsczxK45i4v7TzLywBc
         AXwXiuDJgc7XHM7UD0NGB89H8hpba+Cg5N26nRwerktBF4hSVix2LRvAsUS1iTPYrSNc
         D64pBdyzWtbgQBI/BQCA6OePXB2AO8qB7jkUHOyNJJPvWiXeKbpKyeJaL2toq1yQ3js2
         x7ARNMsLYQAQxz40S4hniyTvNRmKFACuFeSDD9eosfIRLqv+Eoi11cIMmcpByrDpu1QZ
         QgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714565892; x=1715170692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBFCNaiZG8SDhd9Avy2NjVgbIzDcy1byPrgimW8Jnrg=;
        b=ZofUyXnvBGD014RIhX/uYmzOVBhfC/c/5Nb1BdUOQFRPcW1xvUy1uY/02Z0nSjyrux
         wWcT8WpgS+rzNjzr8VBja3hkT3zF6YHlEF7YWjI+dZ0vI1DnMMN4KVcvnmklXWCfPT3n
         YVocOXpYoUiog/IUH78LYmfBhaXLnod4MFylXxaqVFmHkoSS6Og9aFKqW1Sf1vZSJo9a
         F4WR0BU7DQp65c+fu6M8oV3ccSmvv7EoqHuWB6Ql71QwpRtK4D74MdjUG9U0WWPKJzSi
         iIeHrRhL04CGT6m+rD8mV8haLetNcvCn1p1Nv7XsohA+PlYr/ve8oNbMZeLVyMjVgJmR
         +Xzg==
X-Forwarded-Encrypted: i=1; AJvYcCXbryQcXeU8tS3u49fpWTZzS8B1Hrg7iYu/0q/Yi2Uz87Y+jlsXMKXnS42vB6ZFxiyjVpbglKGqMh+rs1kXelrDJl1C9cxYzBFJ
X-Gm-Message-State: AOJu0YzuRdo2m1Icj6FjY8lKmj5LMOCi7YWoemaIzX9Nyy6QgItx3Hlh
	o1DtLy405Ng9U20SyHVwOynla3H3OqG6k5/zc24cSjbO8DO2m907szqr2MTP+ak=
X-Google-Smtp-Source: AGHT+IFCz+8u/X89VsHYsAyI7LAYB37fwi80edU6U2OxBpGy7t88sQSAo0aUQcHa3ElV/kemBD1B7A==
X-Received: by 2002:a17:902:c40e:b0:1eb:527e:a89e with SMTP id k14-20020a170902c40e00b001eb527ea89emr8243829plk.26.1714565891753;
        Wed, 01 May 2024 05:18:11 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.106])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001ec8888b22esm1336900plb.65.2024.05.01.05.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:18:11 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v5 01/17] arm64: PCI: Migrate ACPI related functions to pci-acpi.c
Date: Wed,  1 May 2024 17:47:26 +0530
Message-Id: <20240501121742.1215792-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions defined in arm64 for ACPI support are required
for RISC-V also. To avoid duplication, move these functions
to common location.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm64/kernel/pci.c | 191 ----------------------------------------
 drivers/pci/pci-acpi.c  | 182 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+), 191 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index f872c57e9909..fd9a7bed83ce 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -6,28 +6,7 @@
  * Copyright (C) 2014 ARM Ltd.
  */
 
-#include <linux/acpi.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
 #include <linux/pci.h>
-#include <linux/pci-acpi.h>
-#include <linux/pci-ecam.h>
-#include <linux/slab.h>
-
-#ifdef CONFIG_ACPI
-/*
- * Try to assign the IRQ number when probing a new device
- */
-int pcibios_alloc_irq(struct pci_dev *dev)
-{
-	if (!acpi_disabled)
-		acpi_pci_irq_enable(dev);
-
-	return 0;
-}
-#endif
 
 /*
  * raw_pci_read/write - Platform-specific PCI config space access.
@@ -61,173 +40,3 @@ int pcibus_to_node(struct pci_bus *bus)
 EXPORT_SYMBOL(pcibus_to_node);
 
 #endif
-
-#ifdef CONFIG_ACPI
-
-struct acpi_pci_generic_root_info {
-	struct acpi_pci_root_info	common;
-	struct pci_config_window	*cfg;	/* config space mapping */
-};
-
-int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
-{
-	struct pci_config_window *cfg = bus->sysdata;
-	struct acpi_device *adev = to_acpi_device(cfg->parent);
-	struct acpi_pci_root *root = acpi_driver_data(adev);
-
-	return root->segment;
-}
-
-int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
-{
-	struct pci_config_window *cfg;
-	struct acpi_device *adev;
-	struct device *bus_dev;
-
-	if (acpi_disabled)
-		return 0;
-
-	cfg = bridge->bus->sysdata;
-
-	/*
-	 * On Hyper-V there is no corresponding ACPI device for a root bridge,
-	 * therefore ->parent is set as NULL by the driver. And set 'adev' as
-	 * NULL in this case because there is no proper ACPI device.
-	 */
-	if (!cfg->parent)
-		adev = NULL;
-	else
-		adev = to_acpi_device(cfg->parent);
-
-	bus_dev = &bridge->bus->dev;
-
-	ACPI_COMPANION_SET(&bridge->dev, adev);
-	set_dev_node(bus_dev, acpi_get_node(acpi_device_handle(adev)));
-
-	return 0;
-}
-
-static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
-{
-	struct resource_entry *entry, *tmp;
-	int status;
-
-	status = acpi_pci_probe_root_resources(ci);
-	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
-		if (!(entry->res->flags & IORESOURCE_WINDOW))
-			resource_list_destroy_entry(entry);
-	}
-	return status;
-}
-
-/*
- * Lookup the bus range for the domain in MCFG, and set up config space
- * mapping.
- */
-static struct pci_config_window *
-pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
-{
-	struct device *dev = &root->device->dev;
-	struct resource *bus_res = &root->secondary;
-	u16 seg = root->segment;
-	const struct pci_ecam_ops *ecam_ops;
-	struct resource cfgres;
-	struct acpi_device *adev;
-	struct pci_config_window *cfg;
-	int ret;
-
-	ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
-	if (ret) {
-		dev_err(dev, "%04x:%pR ECAM region not found\n", seg, bus_res);
-		return NULL;
-	}
-
-	adev = acpi_resource_consumer(&cfgres);
-	if (adev)
-		dev_info(dev, "ECAM area %pR reserved by %s\n", &cfgres,
-			 dev_name(&adev->dev));
-	else
-		dev_warn(dev, FW_BUG "ECAM area %pR not reserved in ACPI namespace\n",
-			 &cfgres);
-
-	cfg = pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
-	if (IS_ERR(cfg)) {
-		dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, bus_res,
-			PTR_ERR(cfg));
-		return NULL;
-	}
-
-	return cfg;
-}
-
-/* release_info: free resources allocated by init_info */
-static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
-{
-	struct acpi_pci_generic_root_info *ri;
-
-	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
-	pci_ecam_free(ri->cfg);
-	kfree(ci->ops);
-	kfree(ri);
-}
-
-/* Interface called from ACPI code to setup PCI host controller */
-struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
-{
-	struct acpi_pci_generic_root_info *ri;
-	struct pci_bus *bus, *child;
-	struct acpi_pci_root_ops *root_ops;
-	struct pci_host_bridge *host;
-
-	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
-	if (!ri)
-		return NULL;
-
-	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
-	if (!root_ops) {
-		kfree(ri);
-		return NULL;
-	}
-
-	ri->cfg = pci_acpi_setup_ecam_mapping(root);
-	if (!ri->cfg) {
-		kfree(ri);
-		kfree(root_ops);
-		return NULL;
-	}
-
-	root_ops->release_info = pci_acpi_generic_release_info;
-	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
-	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
-	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
-	if (!bus)
-		return NULL;
-
-	/* If we must preserve the resource configuration, claim now */
-	host = pci_find_host_bridge(bus);
-	if (host->preserve_config)
-		pci_bus_claim_resources(bus);
-
-	/*
-	 * Assign whatever was left unassigned. If we didn't claim above,
-	 * this will reassign everything.
-	 */
-	pci_assign_unassigned_root_bus_resources(bus);
-
-	list_for_each_entry(child, &bus->children, node)
-		pcie_bus_configure_settings(child);
-
-	return bus;
-}
-
-void pcibios_add_bus(struct pci_bus *bus)
-{
-	acpi_pci_add_bus(bus);
-}
-
-void pcibios_remove_bus(struct pci_bus *bus)
-{
-	acpi_pci_remove_bus(bus);
-}
-
-#endif
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 004575091596..e8d84fa435da 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -15,6 +15,7 @@
 #include <linux/pci_hotplug.h>
 #include <linux/module.h>
 #include <linux/pci-acpi.h>
+#include <linux/pci-ecam.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
 #include <linux/rwsem.h>
@@ -1519,3 +1520,184 @@ static int __init acpi_pci_init(void)
 	return 0;
 }
 arch_initcall(acpi_pci_init);
+
+#if defined(CONFIG_ARM64)
+
+/*
+ * Try to assign the IRQ number when probing a new device
+ */
+int pcibios_alloc_irq(struct pci_dev *dev)
+{
+	if (!acpi_disabled)
+		acpi_pci_irq_enable(dev);
+
+	return 0;
+}
+
+struct acpi_pci_generic_root_info {
+	struct acpi_pci_root_info	common;
+	struct pci_config_window	*cfg;	/* config space mapping */
+};
+
+int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	struct acpi_device *adev = to_acpi_device(cfg->parent);
+	struct acpi_pci_root *root = acpi_driver_data(adev);
+
+	return root->segment;
+}
+
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	struct pci_config_window *cfg;
+	struct acpi_device *adev;
+	struct device *bus_dev;
+
+	if (acpi_disabled)
+		return 0;
+
+	cfg = bridge->bus->sysdata;
+
+	/*
+	 * On Hyper-V there is no corresponding ACPI device for a root bridge,
+	 * therefore ->parent is set as NULL by the driver. And set 'adev' as
+	 * NULL in this case because there is no proper ACPI device.
+	 */
+	if (!cfg->parent)
+		adev = NULL;
+	else
+		adev = to_acpi_device(cfg->parent);
+
+	bus_dev = &bridge->bus->dev;
+
+	ACPI_COMPANION_SET(&bridge->dev, adev);
+	set_dev_node(bus_dev, acpi_get_node(acpi_device_handle(adev)));
+
+	return 0;
+}
+
+static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
+{
+	struct resource_entry *entry, *tmp;
+	int status;
+
+	status = acpi_pci_probe_root_resources(ci);
+	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
+		if (!(entry->res->flags & IORESOURCE_WINDOW))
+			resource_list_destroy_entry(entry);
+	}
+	return status;
+}
+
+/*
+ * Lookup the bus range for the domain in MCFG, and set up config space
+ * mapping.
+ */
+static struct pci_config_window *
+pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
+{
+	struct device *dev = &root->device->dev;
+	struct resource *bus_res = &root->secondary;
+	u16 seg = root->segment;
+	const struct pci_ecam_ops *ecam_ops;
+	struct resource cfgres;
+	struct acpi_device *adev;
+	struct pci_config_window *cfg;
+	int ret;
+
+	ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
+	if (ret) {
+		dev_err(dev, "%04x:%pR ECAM region not found\n", seg, bus_res);
+		return NULL;
+	}
+
+	adev = acpi_resource_consumer(&cfgres);
+	if (adev)
+		dev_info(dev, "ECAM area %pR reserved by %s\n", &cfgres,
+			 dev_name(&adev->dev));
+	else
+		dev_warn(dev, FW_BUG "ECAM area %pR not reserved in ACPI namespace\n",
+			 &cfgres);
+
+	cfg = pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
+	if (IS_ERR(cfg)) {
+		dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, bus_res,
+			PTR_ERR(cfg));
+		return NULL;
+	}
+
+	return cfg;
+}
+
+/* release_info: free resources allocated by init_info */
+static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
+{
+	struct acpi_pci_generic_root_info *ri;
+
+	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
+	pci_ecam_free(ri->cfg);
+	kfree(ci->ops);
+	kfree(ri);
+}
+
+/* Interface called from ACPI code to setup PCI host controller */
+struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
+{
+	struct acpi_pci_generic_root_info *ri;
+	struct pci_bus *bus, *child;
+	struct acpi_pci_root_ops *root_ops;
+	struct pci_host_bridge *host;
+
+	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
+	if (!ri)
+		return NULL;
+
+	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
+	if (!root_ops) {
+		kfree(ri);
+		return NULL;
+	}
+
+	ri->cfg = pci_acpi_setup_ecam_mapping(root);
+	if (!ri->cfg) {
+		kfree(ri);
+		kfree(root_ops);
+		return NULL;
+	}
+
+	root_ops->release_info = pci_acpi_generic_release_info;
+	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
+	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
+	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
+	if (!bus)
+		return NULL;
+
+	/* If we must preserve the resource configuration, claim now */
+	host = pci_find_host_bridge(bus);
+	if (host->preserve_config)
+		pci_bus_claim_resources(bus);
+
+	/*
+	 * Assign whatever was left unassigned. If we didn't claim above,
+	 * this will reassign everything.
+	 */
+	pci_assign_unassigned_root_bus_resources(bus);
+
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
+
+	return bus;
+}
+
+void pcibios_add_bus(struct pci_bus *bus)
+{
+	acpi_pci_add_bus(bus);
+}
+
+void pcibios_remove_bus(struct pci_bus *bus)
+{
+	acpi_pci_remove_bus(bus);
+}
+
+#endif
-- 
2.40.1


