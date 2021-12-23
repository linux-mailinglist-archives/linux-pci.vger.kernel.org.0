Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2517247E924
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 22:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350366AbhLWVh7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Dec 2021 16:37:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33404 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350360AbhLWVh6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Dec 2021 16:37:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10D78B82224;
        Thu, 23 Dec 2021 21:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878C8C36AEA;
        Thu, 23 Dec 2021 21:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640295475;
        bh=VOA/kZNYfsGlJqtr+KqzP64QKPOBXsYVeTTgGSBCkMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kH45MWLMOiBgvhydPdhnkujy5bphbOHJtJLuQbiQh2OaTHTcRYpPEAcn+sWv6mgfm
         WUmgq317iPiIA6jUo+uyT/lvtioRD8b+KnzlvqdetNJvbQSd/Pedc8WfYZjTSfaiWT
         Bd7qLDaukjmXa9QOQZ0GjoSjcdl1GfOMZiawgCoOYmD1QGgVYjpfvNMXcNnU4E5jVG
         Hl4N65P8qpO8vjYObocyOW8+5PdA8lpHQVquiJS5FzK7UNQ08pRk6ICwpMCijxrIfw
         CUKGtU1gVjVb08pJkOeuwNUzMRAF7wK3MUpX3b54cSN7kr19KmNAUF1ZSTMSH75YqH
         oJbt1fgPUu6dw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Pratyush Anand <pratyush.anand@gmail.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] PCI: hisi: Avoid invalid address space conversions
Date:   Thu, 23 Dec 2021 15:37:48 -0600
Message-Id: <20211223213749.1314142-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223213749.1314142-1-helgaas@kernel.org>
References: <20211223213749.1314142-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The sparse checker complains about converting pointers between address
spaces.  The pci_config_window.priv pointer is a generic void *, but
hisi_pcie_map_bus() needs a void __iomem *.

This isn't a problem in other drivers because they store the __iomem
pointer in a driver struct.  Add a trivial struct hisi_pcie to avoid the
warning.

The sparse warning looks like this:

  $ make C=2 drivers/pci/controller/
  drivers/pci/controller/dwc/pcie-hisi.c:61:37: warning: incorrect type in initializer (different address spaces)
  drivers/pci/controller/dwc/pcie-hisi.c:61:37:    expected void [noderef] __iomem *reg_base
  drivers/pci/controller/dwc/pcie-hisi.c:61:37:    got void *priv

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/pci/controller/dwc/pcie-hisi.c | 32 ++++++++++++++++++--------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-hisi.c b/drivers/pci/controller/dwc/pcie-hisi.c
index 8fc5960faf28..8904b5b85ee5 100644
--- a/drivers/pci/controller/dwc/pcie-hisi.c
+++ b/drivers/pci/controller/dwc/pcie-hisi.c
@@ -18,6 +18,10 @@
 
 #if defined(CONFIG_PCI_HISI) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
 
+struct hisi_pcie {
+	void __iomem	*reg_base;
+};
+
 static int hisi_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 			     int size, u32 *val)
 {
@@ -58,10 +62,10 @@ static void __iomem *hisi_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
 				       int where)
 {
 	struct pci_config_window *cfg = bus->sysdata;
-	void __iomem *reg_base = cfg->priv;
+	struct hisi_pcie *pcie = cfg->priv;
 
 	if (bus->number == cfg->busr.start)
-		return reg_base + where;
+		return pcie->reg_base + where;
 	else
 		return pci_ecam_map_bus(bus, devfn, where);
 }
@@ -71,12 +75,16 @@ static void __iomem *hisi_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
 static int hisi_pcie_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
+	struct hisi_pcie *pcie;
 	struct acpi_device *adev = to_acpi_device(dev);
 	struct acpi_pci_root *root = acpi_driver_data(adev);
 	struct resource *res;
-	void __iomem *reg_base;
 	int ret;
 
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
 	/*
 	 * Retrieve RC base and size from a HISI0081 device with _UID
 	 * matching our segment.
@@ -91,11 +99,11 @@ static int hisi_pcie_init(struct pci_config_window *cfg)
 		return -ENOMEM;
 	}
 
-	reg_base = devm_pci_remap_cfgspace(dev, res->start, resource_size(res));
-	if (!reg_base)
+	pcie->reg_base = devm_pci_remap_cfgspace(dev, res->start, resource_size(res));
+	if (!pcie->reg_base)
 		return -ENOMEM;
 
-	cfg->priv = reg_base;
+	cfg->priv = pcie;
 	return 0;
 }
 
@@ -115,9 +123,13 @@ const struct pci_ecam_ops hisi_pcie_ops = {
 static int hisi_pcie_platform_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
+	struct hisi_pcie *pcie;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *res;
-	void __iomem *reg_base;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	if (!res) {
@@ -125,11 +137,11 @@ static int hisi_pcie_platform_init(struct pci_config_window *cfg)
 		return -EINVAL;
 	}
 
-	reg_base = devm_pci_remap_cfgspace(dev, res->start, resource_size(res));
-	if (!reg_base)
+	pcie->reg_base = devm_pci_remap_cfgspace(dev, res->start, resource_size(res));
+	if (!pcie->reg_base)
 		return -ENOMEM;
 
-	cfg->priv = reg_base;
+	cfg->priv = pcie;
 	return 0;
 }
 
-- 
2.25.1

